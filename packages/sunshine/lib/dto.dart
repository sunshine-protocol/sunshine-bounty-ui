// ignore_for_file: avoid_as

import 'dart:convert';

class BountyInformation {
  BountyInformation({
    this.id,
    this.repoOwner,
    this.repoName,
    this.issueNumber,
    this.depositer,
    BigInt total,
  })  : _total = total,
        _isOpen = true;

  factory BountyInformation.fromString(String data) {
    final d = json.decode(data);
    return BountyInformation.fromJSON(d);
  }
  factory BountyInformation.fromJSON(dynamic data) {
    return BountyInformation(
      id: BigInt.parse(data['id'].toString()),
      repoOwner: data['repo_owner'] as String,
      repoName: data['repo_name'] as String,
      issueNumber: BigInt.parse(data['issue_number'].toString()),
      depositer: data['depositer'] as String,
      total: BigInt.parse(data['total'].toString()),
    );
  }
  final BigInt id;
  final String repoOwner;
  final String repoName;
  final BigInt issueNumber;
  final String depositer;
  BigInt _total;
  bool _isOpen = true;
  BigInt get total => _total;
  bool get isOpen => _isOpen;

  static List<BountyInformation> buildList(String str) {
    if (str == null || str.isEmpty) {
      return [];
    }
    final data = json.decode(str) as List<dynamic>;
    return data.map((e) => BountyInformation.fromJSON(e)).toList();
  }

  BigInt contibute(BigInt amount) {
    return _total += amount;
  }

  void approve(BountySubmissionInformation submission) {
    submission.approve();
    _isOpen = false;
  }

  @override
  String toString() {
    return 'BountyInformation { id: $id, depositer: $depositer }';
  }
}

class BountySubmissionInformation {
  BountySubmissionInformation({
    this.id,
    this.repoOwner,
    this.repoName,
    this.issueNumber,
    this.bountyId,
    this.submitter,
    this.amount,
    bool awaitingReview,
  })  : _awaitingReview = awaitingReview,
        _approved = !awaitingReview;

  factory BountySubmissionInformation.fromString(String data) {
    final d = jsonDecode(data);
    return BountySubmissionInformation.fromJSON(d);
  }

  factory BountySubmissionInformation.fromJSON(dynamic data) {
    return BountySubmissionInformation(
      id: BigInt.parse(data['id'].toString()),
      repoOwner: data['repo_owner'] as String,
      repoName: data['repo_name'] as String,
      issueNumber: BigInt.parse(data['issue_number'].toString()),
      bountyId: BigInt.parse(data['bounty_id'].toString()),
      submitter: data['submitter'] as String,
      amount: BigInt.parse(data['amount'].toString()),
      awaitingReview: data['awaiting_review'] as bool,
    );
  }
  final BigInt id;
  final String repoOwner;
  final String repoName;
  final BigInt issueNumber;
  final BigInt bountyId;
  final String submitter;
  final BigInt amount;
  bool _awaitingReview = true;
  bool _approved = false;

  bool get awaitingReview => _awaitingReview;
  bool get approved => _approved;

  static List<BountySubmissionInformation> buildList(String json) {
    if (json == null || json.isEmpty) {
      return [];
    }
    final data = jsonDecode(json) as List<dynamic> ?? [];
    return data.map((e) => BountySubmissionInformation.fromJSON(e)).toList();
  }

  void approve() {
    _awaitingReview = false;
    _approved = true;
  }
}

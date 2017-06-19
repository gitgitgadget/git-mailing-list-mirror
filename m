Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA96320D0C
	for <e@80x24.org>; Mon, 19 Jun 2017 12:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbdFSMTa (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 08:19:30 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:44821 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbdFSMT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 08:19:29 -0400
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jun 2017 08:19:29 EDT
IronPort-PHdr: =?us-ascii?q?9a23=3A9htrkRaE4BEu8os762K0LAb/LSx+4OfEezUN459i?=
 =?us-ascii?q?sYplN5qZoMW4bnLW6fgltlLVR4KTs6sC0LuJ9fC9EjBQqb+681k6OKRWUBEEjc?=
 =?us-ascii?q?hE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRo?=
 =?us-ascii?q?LerpBIHSk9631+ev8JHPfglEnjSwbLdwIRmsrgjctsYajIRhJ60s1hbHv3xEdv?=
 =?us-ascii?q?hMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW874s3rrgTD?=
 =?us-ascii?q?QhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VDq+46t3ThLjlS?=
 =?us-ascii?q?EKPCM7/m7KkMx9lKJVrgy8qRxjzYDaY4CVO+ZxcKzSZt4aWXFOU9xNWyBdHo+x?=
 =?us-ascii?q?bY0CBPcBM+ZCqIn9okMDoBygCgayHuPvzSVEiWXs0q0+z+QhFgfG0xImH98Vrn?=
 =?us-ascii?q?TbttT1NLwIXuCx1qbE1ynMb/RT2Trk7oXDbxMvoemUUL5tc8fd11MjGx3Kg1mK?=
 =?us-ascii?q?tIDpJTCY2+QVv2SG7edsS/ijh3Aopg1rozWix90ghpTKi48a0lzE+zt2zYUpKd?=
 =?us-ascii?q?C9TUN2YdqpH4ZNuyyfKod5WMEvTmR2tyknyLAGt5u2cDYXx5g6xRPSbeGMfZKS?=
 =?us-ascii?q?7RL5TumRJC91hHdieL2imRm/6VOgyujgVsms11ZKszZFnsHMtn8T0xzT7dCKRP?=
 =?us-ascii?q?ly8EmnwDqB2AHc5/9GL0wtiabXNYQtzaI3lpoJqUTPBDH2l1/3jK+NbEok/vKn?=
 =?us-ascii?q?5/77bbXho5+QL450igfgPaQygsGzHOY1PhYUU2SF9umwzqDv8Vf6TbhKlvE2l7?=
 =?us-ascii?q?PWsJHeJcQVvK65BApV35495BmhFTem184UkmMdI1JBZBKHiI7pNE/IIP3jE/ew?=
 =?us-ascii?q?mVWskCxxyPDCJLLtGInCLn/GkLv5Z7Zy91ZcyBYvzdBY/59UBbABIO7oV0/vu9?=
 =?us-ascii?q?zXEAU5Pxa3w+n5EtV90J0RWWaVDq+eKqPSvgzA2uV6d+aNeKcLtzvnbfso/fjj?=
 =?us-ascii?q?iTk+g1BLLoez2p5CPH21BPMgKkydfX3qj9EpD24LpQM6Rarhj1jUAm0bXGq7Q6?=
 =?us-ascii?q?9pvmJzM4mhF4qWHo0=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EzCgB3vkdZ/1UBGKxcHgYMGQYMhSODZ?=
 =?us-ascii?q?JtxghCWGoZAgnQVAQEBAQEBAQEBAQECgRCCMyKCbQQNVwEiAiYCBDAVEgS4R4F?=
 =?us-ascii?q?sOowTgQuHYwuHP2KCRoJhBYlZlQWBX4kOjF6OIZUJNYEtdIVqHYFmiUqBDQEBA?=
 =?us-ascii?q?Q?=
X-IPAS-Result: =?us-ascii?q?A2EzCgB3vkdZ/1UBGKxcHgYMGQYMhSODZJtxghCWGoZAgnQ?=
 =?us-ascii?q?VAQEBAQEBAQEBAQECgRCCMyKCbQQNVwEiAiYCBDAVEgS4R4FsOowTgQuHYwuHP?=
 =?us-ascii?q?2KCRoJhBYlZlQWBX4kOjF6OIZUJNYEtdIVqHYFmiUqBDQEBAQ?=
X-IronPort-AV: E=Sophos;i="5.39,361,1493672400"; 
   d="scan'208";a="42431466"
Received: from hel-exch-02.corp.vaisala.com ([172.24.1.85])
  by hel-mailgw-01.vaisala.com with ESMTP/TLS/AES256-SHA; 19 Jun 2017 15:09:29 +0300
Received: from HEL-EXCH-02.corp.vaisala.com (172.24.1.85) by
 HEL-EXCH-02.corp.vaisala.com (172.24.1.85) with Microsoft SMTP Server (TLS)
 id 15.0.1210.3; Mon, 19 Jun 2017 15:09:28 +0300
Received: from HEL-EXCH-02.corp.vaisala.com ([fe80::59d1:1a7:ed7f:2d17]) by
 HEL-EXCH-02.corp.vaisala.com ([fe80::59d1:1a7:ed7f:2d17%14]) with mapi id
 15.00.1210.000; Mon, 19 Jun 2017 15:09:28 +0300
From:   <eero.aaltonen@vaisala.com>
To:     <git@vger.kernel.org>
Subject: Behavior of 'git fetch' for commit hashes
Thread-Topic: Behavior of 'git fetch' for commit hashes
Thread-Index: AQHS6PTmljaresomX0G+oE4gpNMbnQ==
Date:   Mon, 19 Jun 2017 12:09:28 +0000
Message-ID: <14e804c6-0798-8bbd-b182-66c3cd2b870c@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.24.66.184]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B622368629B602499BD3AC8ED26E3D06@exch.vaisala.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8sDQoNCkkgYW0gc2VlaW5nIGdyZWF0bHkgZGlmZmVyZW50IGJlaGF2aW9yIGZvciAnZ2l0
IGZldGNoJyBjb21tYW5kcyBvbg0KdmVyc2lvbiAyLjcuNCBhbmQgMi4xMy4xIHdoZW4gdGhlIGFy
Z3VtZW50IHRvIGZldGNoIGlzIGEgY29tbWl0IGhhc2guDQoNCkkgYW0gd29ya2luZyBvbiBhIGN1
c3RvbSBDb250aW51b3VzIEludGVncmF0aW9uIChDSSkgc3lzdGVtLiBUaGUNCnByb2plY3RzIGhh
dmUgZGVwZW5kZW5jaWVzIHRoYXQgYXJlIHNpbXBseSBmZXRjaGVkIGFzIHJlcG9zaXRvcmllcyB0
byBhDQpwcm9qZWN0IHN1YmRpcmVjdG9yeS4NCg0KSW4gb3JkZXIgdG8gcHJldmVudCBhIHJhY2Ug
Y29uZGl0aW9uIGluIHVwZGF0aW5nIGJyYW5jaGVzLCBJIHdhbnQgdG8NCmNoZWNrb3V0IHRoZSBh
Y3R1YWwgY29tbWl0IHRoYXQgd2FzIGJ1aWx0IGluIGEgcHJldmlvdXMgam9iLg0KDQpFbnZpcm9u
bWVudA0KPT09PT09PT09PT0NClByb2JsZW0gb2NjdXJzIHdpdGggR2l0IGNsaWVudHMNCi0gMi43
LjQNCi0gMi4xMy4xDQoNCmFuZCBHaXQgc2VydmVyDQotIEF0bGFzc2lhbiBCaXRidWNrZXQgdjQu
MTQuMw0KLSBnaXQgdmVyc2lvbiAyLjEyLjANCg0KDQpUaGUgcHJvYmxlbSBjYW4gYmUgcmVwcm9k
dWNlZCBhcyBmb2xsb3dzLCB3aXRoDQotIDxhdXRob3JpdGF0aXZlVXJsPiA9IFVSTCB0byBwcmlt
YXJ5IHJlcG9zaXRvcnkNCi0gPGZvcmtVcmw+ID0gVVJMIHRvIGZvcmsgb2YgdGhlIHByaW1hcnkN
Ci0gPHNoYTE+IGNvbW1pdCBoYXNoIGluIGEgcmVjZW50IGJyYW5jaA0KDQoxLiBnaXQgY2xvbmUg
PGF1dGhvcml0YXRpdmVVcmw+DQoyLiBjZCByZXN1bHRpbmdfZGlyZWN0b3J5DQozLiBnaXQgZmV0
Y2ggPGZvcmtVcmw+IDxzaGExPg0KDQpGb3IgdmVyc2lvbiAyLjcuNA0KPT09PT09PT09PT09PT09
PT0NCkdpdCBleGl0cyB3aXRoIGV4aXQgY29kZSAxLg0KDQpIb3dldmVyLCBpZiBJIGZpcnN0IGRv
ICdnaXQgZmV0Y2ggPGJyYW5jaD4nLCB0aGVuICdnaXQgZmV0Y2ggPHNoYTE+IHdpbGwNCmFsc28g
d29yaw0KDQogKiBicmFuY2ggICA8c2hhMT4gLT4gRkVUQ0hfSEVBRA0KDQpGb3IgdmVyc2lvbiAy
LjEzLjMNCj09PT09PT09PT09PT09PT09PQ0KR2l0IGV4aXRzIHdpdGggZXhpdCBjb2RlIDEyOCBh
bmQgbWVzc2FnZQ0KZmF0YWw6IENvdWxkbid0IGZpbmQgcmVtb3RlIHJlZg0KDQpIb3dldmVyLCB0
aGUgd29ya2Fyb3VuZCBmb3IgZGVzY2JpYmVkIGFib3QgZm9yIGdpdCB2ZXJzaW9uIDIuNy40IG5v
DQpsb25nZXIgd29ya3MuIFRoZSByZXN1bHQgaXMgYWx3YXlzDQpmYXRhbDogQ291bGRuJ3QgZmlu
ZCByZW1vdGUgcmVmDQoNCkRlc2lyZWQgcmVzdWx0DQo9PT09PT09PT09PT09PQ0KQ29tbWl0IGlz
IGluIC5naXQvRkVUQ0hfSEVBRCBhbmQgY2FuIGJlIGNoZWNrZWQgb3V0Lg0KDQoNCkkgd2FudCB0
byBjaGVja291dCBhIHNwZWNpZmljIGNvbW1pdCB3aXRob3V0IGNyZWF0aW5nIGFueSBleHRyYSBu
YW1lZA0KcmVtb3RlcyBpbiB0aGUgbG9jYWwgZ2l0IGNsb25lLg0KDQpGaW5hbGx5LA0KV2hhdCBp
cyB0aGUgZXhwZWN0ZWQgYmVoYXZpb3IgZm9yICdnaXQgZmV0Y2gnIGluIHRoaXMgY2FzZT8NCklz
IHRoZXJlIHNvbWUgb3RoZXIgd2F5IEkgY2FuIGFjaGlldmUgbXkgZ29hbHM/DQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KRWVybyBBYWx0b25lbg==

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DFA81F516
	for <e@80x24.org>; Thu, 28 Jun 2018 12:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753647AbeF1Mwt (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 08:52:49 -0400
Received: from mail-cys01nam02on0139.outbound.protection.outlook.com ([104.47.37.139]:45124
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752581AbeF1Mws (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 08:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7XrZu6lojmasxPaPfo45UGGyDBN7hTnMnd61hu7cWc=;
 b=X5f/P99kclC4KdoBLLe9+tVzmPm1wWiKxa7S0PoIZrUB8eN6Faps6is+avKLVIGaLva7CtWnOwJIHVJXpOUwajvEx29wQ0tU3suv8L2CNug1wmevcpuFIrlW3UYT5PFYeTHsV5ujADkOZja0hcxBpv8YdhYuW4jadU6JNj+EI6U=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1027.namprd21.prod.outlook.com (52.132.20.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.2; Thu, 28 Jun 2018 12:52:45 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0930.005; Thu, 28 Jun 2018
 12:52:45 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "gwelch925@gmail.com" <gwelch925@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] commit-graph: fix documentation inconsistencies
Thread-Topic: [PATCH] commit-graph: fix documentation inconsistencies
Thread-Index: AQHUDt7o2Vel3yWiYUqoBXGYObc/OQ==
Date:   Thu, 28 Jun 2018 12:52:45 +0000
Message-ID: <20180628125235.77256-1-dstolee@microsoft.com>
References: <c48629f1-7b41-d516-84f5-c07ef7881e03@gmail.com>
In-Reply-To: <c48629f1-7b41-d516-84f5-c07ef7881e03@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:903:dd::21) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1027;7:30OMZfi6rsw3BtEgqR8UHNUCYFmSZvjtY8kLfcEjfDhb8ncR7RqsfiUC+LHmkswjQnROTkeXxQUWN+Z6tHdUqTZKA/KaSHZM+0d/zOqR+2mYiPNEOSspm/GaXQ7iYe9ORpJKvBbwuVlH20RWArmWfsNgU0H+kSDeDNw8MeiYTGaYN5Fuao8fLhUSjDi7pC1m/Epz281nI5ZKGG0iwD/FwbU0AaKpjZrwt7I7E6wPtxU/8aOiCoA0MlhaVfjwvA+3
x-ms-office365-filtering-correlation-id: eae88af4-8741-4307-b4db-08d5dcf60b04
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1027;
x-ms-traffictypediagnostic: BL0PR2101MB1027:
x-microsoft-antispam-prvs: <BL0PR2101MB1027065E8B01291DA9126F6EA14F0@BL0PR2101MB1027.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231270)(2018427008)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1027;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1027;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(376002)(396003)(366004)(189003)(199004)(1076002)(86362001)(6512007)(11346002)(486006)(7736002)(305945005)(2616005)(446003)(6916009)(25786009)(6346003)(97736004)(76176011)(68736007)(102836004)(52116002)(5660300001)(1857600001)(53936002)(46003)(4326008)(39060400002)(2906002)(186003)(10090500001)(107886003)(22452003)(6506007)(54906003)(316002)(8936002)(476003)(2900100001)(256004)(14444005)(106356001)(105586002)(36756003)(99286004)(386003)(10290500003)(2501003)(478600001)(5250100002)(6116002)(86612001)(6486002)(14454004)(575784001)(81156014)(8676002)(6436002)(1730700003)(81166006)(5640700003)(2351001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1027;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: NpOSSZSalwXQtdpHaoWldSQCzMANS2QE/WlxwWfQEy4iAULtnUrNTkdnSRZY4A9GdUcsXIuQHlt0wfuGu/gu3C/Src+IixbrqtRrN97S0UYn9WyRRcCFkH59VRwZYm6r0/koV4flSjrTDv04lSmgFJkejfUYcYpgaT1tBJUzuyZzZDDBIljo9vs4Xddkr3l4jVottYElylRbtFyzDX7+nCawBgQ1lBAq+ceGEcQBHlnFhfQ9QWknia+a/D6hnkkgkCth+MsbnNfYOoLZcQXktr5kn/TtxPEwPehoHLFrLG5CE5EHTCT6Jef5gSEORYqT90tOcxxGDUF77soacjZUCTo6yZOhh6Z+TnWBr3tTUQ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae88af4-8741-4307-b4db-08d5dcf60b04
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 12:52:45.4311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1027
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph feature shipped in Git 2.18 has some inconsistencies in
the constants used by the implementation and specified by the format
document.

The commit data chunk uses the key "CDAT" in the file format, but was
previously documented to say "CGET".

The commit data chunk stores commit parents using two 32-bit fields that
typically store the integer position of the parent in the list of commit
ids within the commit-graph file. When a parent does not exist, we had
documented the value 0xffffffff, but implemented the value 0x70000000.
This swap is easy to correct in the documentation, but unfortunately
reduces the number of commits that we can store in the commit-graph.
Update that estimate, too.

Reported-by: Grant Welch <gwelch925@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph-format.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentatio=
n/technical/commit-graph-format.txt
index ad6af8105c..91c2fbd86a 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -18,9 +18,9 @@ metadata, including:
   the graph file.
=20
 These positional references are stored as unsigned 32-bit integers
-corresponding to the array position withing the list of commit OIDs. We
-use the most-significant bit for special purposes, so we can store at most
-(1 << 31) - 1 (around 2 billion) commits.
+corresponding to the array position withing the list of commit OIDs. Due
+to some special constants we use to track parents, we can store at most
+(1 << 30) + (1 << 29) + (1 << 28) - 1 (around 1.8 billion) commits.
=20
 =3D=3D Commit graph files have the following format:
=20
@@ -70,10 +70,10 @@ CHUNK DATA:
   OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
       The OIDs for all commits in the graph, sorted in ascending order.
=20
-  Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
+  Commit Data (ID: {'C', 'D', 'A', 'T' }) (N * (H + 16) bytes)
     * The first H bytes are for the OID of the root tree.
     * The next 8 bytes are for the positions of the first two parents
-      of the ith commit. Stores value 0xffffffff if no parent in that
+      of the ith commit. Stores value 0x7000000 if no parent in that
       position. If there are more than two parents, the second value
       has its most-significant bit on and the other bits store an array
       position into the Large Edge List chunk.

base-commit: ed843436dd4924c10669820cc73daf50f0b4dabd
--=20
2.18.0.24.g1b579a2ee9


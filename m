Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95D1E1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 14:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753509AbeDYOjO (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 10:39:14 -0400
Received: from mail-bn3nam01on0132.outbound.protection.outlook.com ([104.47.33.132]:40160
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754552AbeDYOiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 10:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZVyRM/DiOASdSw/lLqDhrBNOuHlsZAw5zhIknyThLXU=;
 b=R0NEmuehz9OCGbV2Sasw4OjHX3Td3iL6ocRjIv7dDMznrpyk2m0nVndbdNQxWiG/OwSjYBUfkQjOu8FHMWdvHojgqf4Wj9CRQTE4R4hZbaQnTks6YXNloSDtWCqzC4GwUxa5HpGgoQe7l9C+lQvJDXDJ+dBF+EZGmoiQit27nII=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.735.5; Wed, 25 Apr 2018 14:38:03 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0735.006; Wed, 25 Apr 2018
 14:38:03 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 10/10] commit-graph.txt: update design document
Thread-Topic: [PATCH v4 10/10] commit-graph.txt: update design document
Thread-Index: AQHT3KMD6DIso0aSi0emIYxpB54Frw==
Date:   Wed, 25 Apr 2018 14:38:03 +0000
Message-ID: <20180425143735.240183-11-dstolee@microsoft.com>
References: <20180417170001.138464-1-dstolee@microsoft.com>
 <20180425143735.240183-1-dstolee@microsoft.com>
In-Reply-To: <20180425143735.240183-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR12CA0040.namprd12.prod.outlook.com
 (2603:10b6:405:70::26) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1106;7:EVkNO9M/Jee6yaYnExwMzJRdX8HjBXqr67GkzTo1rmlh5qOKJRdnbdevKsBZN6R+TsOEU4W2skXI2OEuV+HzPZJXrt1UBQdsp26+Xyjxn74xzkDQhupgYgCimdNHh9ngo6MCbwa6RQHBpLfElzpoCB5NYUCifav09m5SzKhApFSE6Q501KiV8mP9SQPo9HYculreyzvEol5UfL/fwjuZLXEOJ3LG5e5LGIO+o7LxQfOh00CHLJxfPVE0F+YORAUD;20:Ue+44tMGSmra8V/VMrtqMrCUt+LeaVKUoJchF5P8HCk5EY+USNo0Mt4aQRETR8Tya7Uron2yPD6MS3/curJxj0wcLVOL4Bhik1Le9ntBz4K1RYh8iJ5Q5FT2STvoR9ATBEBrkUqCWDycWNCaTvWnbxQZN6MbMepU8/6FREBm42g=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1106;
x-ms-traffictypediagnostic: BL0PR2101MB1106:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1106BBE726B596721A7902CCA18F0@BL0PR2101MB1106.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35073007944872);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1106;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1106;
x-forefront-prvs: 06530126A4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(106356001)(86612001)(25786009)(105586002)(39060400002)(22452003)(15650500001)(486006)(316002)(6512007)(186003)(8676002)(1730700003)(81166006)(305945005)(6486002)(97736004)(8936002)(5250100002)(14454004)(76176011)(81156014)(386003)(6506007)(7736002)(99286004)(59450400001)(6116002)(86362001)(36756003)(102836004)(478600001)(1076002)(3280700002)(8656006)(3660700001)(52116002)(10290500003)(5660300001)(46003)(2900100001)(107886003)(5640700003)(4326008)(6436002)(6916009)(2501003)(2351001)(68736007)(10090500001)(11346002)(54906003)(2906002)(575784001)(446003)(53936002)(476003)(2616005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1106;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /yBE6dkCrVT3NAism2KGgRlVXR+PlN0tKFzCk3ifNQj7HBv3WoPyyNhOCZ559aVc/bDWRdtzEbcm2r8tN51zM7/nckwlomUNvpDpypJEEUYzSX2DNie8Q7aMSqpQlq4MfcMWUtRgIQSJ9gaHprW9RQ9nK2riRImyjf1WH+33bR0KCbEdMpoXfIJ/aITVQh2v
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2febbf25-631e-48e9-a329-08d5aaba2644
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2febbf25-631e-48e9-a329-08d5aaba2644
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2018 14:38:03.1038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1106
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We now calculate generation numbers in the commit-graph file and use
them in paint_down_to_common().

Expand the section on generation numbers to discuss how the three
special generation numbers GENERATION_NUMBER_INFINITY, _ZERO, and
_MAX interact with other generation numbers.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 30 +++++++++++++++++++-----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/techn=
ical/commit-graph.txt
index 0550c6d0dc..d9f2713efa 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -77,6 +77,29 @@ in the commit graph. We can treat these commits as havin=
g "infinite"
 generation number and walk until reaching commits with known generation
 number.
=20
+We use the macro GENERATION_NUMBER_INFINITY =3D 0xFFFFFFFF to mark commits=
 not
+in the commit-graph file. If a commit-graph file was written by a version
+of Git that did not compute generation numbers, then those commits will
+have generation number represented by the macro GENERATION_NUMBER_ZERO =3D=
 0.
+
+Since the commit-graph file is closed under reachability, we can guarantee
+the following weaker condition on all commits:
+
+    If A and B are commits with generation numbers N amd M, respectively,
+    and N < M, then A cannot reach B.
+
+Note how the strict inequality differs from the inequality when we have
+fully-computed generation numbers. Using strict inequality may result in
+walking a few extra commits, but the simplicity in dealing with commits
+with generation number *_INFINITY or *_ZERO is valuable.
+
+We use the macro GENERATION_NUMBER_MAX =3D 0x3FFFFFFF to for commits whose
+generation numbers are computed to be at least this value. We limit at
+this value since it is the largest value that can be stored in the
+commit-graph file using the 30 bits available to generation numbers. This
+presents another case where a commit can have generation number equal to
+that of a parent.
+
 Design Details
 --------------
=20
@@ -98,17 +121,12 @@ Future Work
 - The 'commit-graph' subcommand does not have a "verify" mode that is
   necessary for integration with fsck.
=20
-- The file format includes room for precomputed generation numbers. These
-  are not currently computed, so all generation numbers will be marked as
-  0 (or "uncomputed"). A later patch will include this calculation.
-
 - After computing and storing generation numbers, we must make graph
   walks aware of generation numbers to gain the performance benefits they
   enable. This will mostly be accomplished by swapping a commit-date-order=
ed
   priority queue with one ordered by generation number. The following
-  operations are important candidates:
+  operation is an important candidate:
=20
-    - paint_down_to_common()
     - 'log --topo-order'
=20
 - Currently, parse_commit_gently() requires filling in the root tree
--=20
2.17.0.39.g685157f7fb


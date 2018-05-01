Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5317215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755810AbeEAMru (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:47:50 -0400
Received: from mail-by2nam01on0125.outbound.protection.outlook.com ([104.47.34.125]:51343
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755676AbeEAMr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Z3KQMCaj5oROkpL2O3LIa+ktLwAhHnORqE5oanGxJPY=;
 b=BgXVJgP1GxBXSNAaamdoobEPwNMqPACaRM/cuWR9nOzOkc9BHdKY/LqSEsj/AhlB7nP51LTzgEU92mLboZ10d4FGssTZCCKQfZ+YD7wd6pqDNLbaenW3FgTiKypyAz4EgpKrf8umv69z3EPyuX92TeUeMXcgq3pAX6obUHKH1Qc=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1042.namprd21.prod.outlook.com (52.132.24.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Tue, 1 May 2018 12:47:25 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%2]) with mapi id 15.20.0755.007; Tue, 1 May 2018
 12:47:25 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 11/11] commit-graph.txt: update design document
Thread-Topic: [PATCH v5 11/11] commit-graph.txt: update design document
Thread-Index: AQHT4UqNUDiQG2BATEC/b5PDAhuR4Q==
Date:   Tue, 1 May 2018 12:47:25 +0000
Message-ID: <20180501124652.155781-12-dstolee@microsoft.com>
References: <20180425143735.240183-1-dstolee@microsoft.com>
 <20180501124652.155781-1-dstolee@microsoft.com>
In-Reply-To: <20180501124652.155781-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN4PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:403:2::15) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1042;7:4YkagN4nlMteKuVd2o9i56EBt96HsC1nIi3WCNKBhmyJ9n1gV6blvURqK8R4fG23ke6Fsg8K0SThNySD4FR1dZLvEt2WD748mO5VTBHV1YhixL70ZkjI3vxHwilD0mDjd+d6HbwWb8AnfcDpVSDlBGx3W0pherqneGlWQYJWl+ekAl6TKGgCdyxSBHrNIpM1iXOVyyosq7RhxkfHC+SluU7EpH/fHnhcKxVpLjn2+PaGZ881T7Lewe0sqFJnHb4d;20:wUJzauRsv6r6WkKKop977NNGDs9LLDhhzTotA+QVeQ/4YeLgm5BEdHOLHJ4cR71QqwlyDzWR90G2e8sCkuzDmXkb1YePS7YOR7rxFL2nIz9CjQNBiIrMI4THFrLKxumLuo/6VQw7p/4obBaVc4b6nUosaRKDcDuVTi7O8Q5Co+g=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1042;
x-ms-traffictypediagnostic: BL0PR2101MB1042:
x-microsoft-antispam-prvs: <BL0PR2101MB10428BBCF6C711BE3AF939AFA1810@BL0PR2101MB1042.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35073007944872);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1042;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1042;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(346002)(366004)(39860400002)(199004)(189003)(22452003)(86362001)(15650500001)(316002)(39060400002)(36756003)(5660300001)(8936002)(81156014)(6486002)(97736004)(575784001)(68736007)(6116002)(10090500001)(11346002)(81166006)(5250100002)(2501003)(186003)(446003)(6512007)(1076002)(3660700001)(4326008)(10290500003)(3280700002)(46003)(6346003)(386003)(6506007)(478600001)(102836004)(105586002)(53936002)(25786009)(2616005)(2906002)(2900100001)(107886003)(486006)(305945005)(2351001)(54906003)(5640700003)(7736002)(86612001)(106356001)(1730700003)(14454004)(8676002)(6436002)(8656006)(476003)(99286004)(6916009)(52116002)(76176011)(59450400001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1042;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: C+yGC9V7DdpObnyjhoJPXvDWj/8bWHwJhkW2zfx6KWIeaOL1oQn/qQuYLdkTxJCh9kcgyN+uPMP/nU1WgvPKGOy7ccVVDRyfCku+Jy+n39mlbbPSf1JzasznZ75hQRVy1WT2n5CrpoQ5GgSqLFqVuK9brocfbBuOKv/6vJMqUFpyY6j1DOQ5oociPj6YZ/Yw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ecce9d55-32bd-4f18-558c-08d5af61b06a
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecce9d55-32bd-4f18-558c-08d5af61b06a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 12:47:25.2052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1042
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
 Documentation/technical/commit-graph.txt | 29 ++++++++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/techn=
ical/commit-graph.txt
index 0550c6d0dc..e1a883eb46 100644
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
@@ -98,18 +121,14 @@ Future Work
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
   operations are important candidates:
=20
-    - paint_down_to_common()
     - 'log --topo-order'
+    - 'tag --merged'
=20
 - Currently, parse_commit_gently() requires filling in the root tree
   object for a commit. This passes through lookup_tree() and consequently
--=20
2.17.0.39.g685157f7fb


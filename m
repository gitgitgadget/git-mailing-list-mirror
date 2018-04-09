Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8C341F404
	for <e@80x24.org>; Mon,  9 Apr 2018 16:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeDIQmN (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 12:42:13 -0400
Received: from mail-sn1nam02on0137.outbound.protection.outlook.com ([104.47.36.137]:18369
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753370AbeDIQmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 12:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AblnIMMEV98MGmQ6cQ1y0WGkgnxP/JBdI8X1DPB9kNI=;
 b=JKWSRQ2HGfb31fKMFCcnhS2DsSSDUc51q0KA/BDw1Y8R1R+5KFo8AcaMoKvFHPLvojMGi3Fv49gMW6BXJBxhUXXrzBwwFbQHm2FesAScfdZF0WZnx0SOhQ5A6xP0AP1XtcsHmFievvpWCmmewH5+2gIcUhvcLTrK/hfB420JxsU=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 16:42:07 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 16:42:07 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 07/10] commit-graph.txt: update future work
Thread-Topic: [PATCH v2 07/10] commit-graph.txt: update future work
Thread-Index: AQHT0CGy6L/ovWlGrUeJ58Tmx61knA==
Date:   Mon, 9 Apr 2018 16:42:07 +0000
Message-ID: <20180409164131.37312-8-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180409164131.37312-1-dstolee@microsoft.com>
In-Reply-To: <20180409164131.37312-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:903:99::15) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:hbV1ojL3YYcKbJNlJXdPx6Aw09gzjjiHYXNh9tyJ6D0nbIKGatldHtfH9J8tNKydIP6gqKl1cE4tkoGLMZU7Sa3mrrP2jm9wF0goViY/0DbkQgK15AOvVHxgEmH7eJ9rRDKMmxhW2WIpePkw3ftatt8KxB/OUTuwGAERO3u82foq4vTv1kC+DjjbMKejJ7i7OpHr0mjvMS3yvOVLtu0gyG4IuPtcJ2dys21DYa/9tp3AGLzfhB0Qc7tdaXaIryrW;20:Yq0YeNDTUSsTwGuyowKcvkYEbwSK8Q4DWO0irLLX/nKCoNQK1kG+K19B29edMfe5hGV6A7P0DK1RtWIFWGrOde0zuMJ/S6LhGjyl8z4MKTftIUGFn9iB2n3Meai1urIBwcSLwBI8F50qAqcoEhCQVLuX4zTZLdstXMuZ/8dQyB0=
X-MS-Office365-Filtering-Correlation-Id: 047b6470-6c3f-48b5-48d7-08d59e38d4c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09621472DAE1A6D8F4653B24A1BF0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35073007944872);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(107886003)(59450400001)(105586002)(76176011)(14454004)(2906002)(316002)(68736007)(97736004)(8676002)(46003)(86612001)(3280700002)(39060400002)(386003)(6506007)(1730700003)(5640700003)(6116002)(3660700001)(102836004)(8936002)(25786009)(36756003)(54906003)(22452003)(4326008)(10090500001)(81156014)(81166006)(186003)(486006)(5660300001)(6916009)(15650500001)(5250100002)(2501003)(99286004)(1076002)(6512007)(2900100001)(53936002)(6436002)(305945005)(7736002)(106356001)(575784001)(86362001)(2351001)(478600001)(476003)(52116002)(446003)(6486002)(11346002)(2616005)(10290500003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5HkRGYzHy/Ezv7u/B1Jq6XvqqMOosqMj1J5uYmvxEqU/pGW8LUu9oOxGL6SSPg0449VKVptyVICQ+LTSO4D2L8wj3NBt3OMUnNu6j0XDZJoNauXjVQMwUodRkvr2/K8XbS7xDnRxv+27G7/U4oDOjIMHQ9DupEddYZZDLWhjqQe6Til1edTA92j0+4C3/Qu8hxVBurGFoPcnjf+LLQFvIW3hWEtfz7KTmKkWNjTwsIs81lC+o7YZ0K85/sZfPUF4zN5Fte/X7O5YDL/dy933BGn6f2NgNMMclLUzs9vFAEBtD79rI+nVWfknLpocLWVXO1NcK5K7qtLXw4/jpjlgjj8TZJmM1zlIIukRoNNEUM7Y1XQxisPmNyBW3FK8LfLyVUYIeQCg1DQIcmTCEM7es0pngsUjG3ZArmxGk05jLb4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047b6470-6c3f-48b5-48d7-08d59e38d4c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 16:42:07.1811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We now calculate generation numbers in the commit-graph file and use
them in paint_down_to_common().

Expand the section on generation numbers to discuss how the two
"special" generation numbers GENERATION_NUMBER_INFINITY and *_ZERO
interact with other generation numbers.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 50 +++++++++++++++++++++---
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/techn=
ical/commit-graph.txt
index 0550c6d0dc..a8df0ae9db 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -77,6 +77,49 @@ in the commit graph. We can treat these commits as havin=
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
+Here is a diagram to visualize the shape of the full commit graph, and
+how different generation numbers relate:
+
+    +-----------------------------------------+
+    | GENERATION_NUMBER_INFINITY =3D 0xFFFFFFFF |
+    +-----------------------------------------+
+	    |            |      ^
+	    |            |      |
+	    |            +------+
+	    |         [gen(A) =3D gen(B)]
+	    V
+    +-------------------------------------+
+    | 0 < commit->generation < 0x40000000 |
+    +-------------------------------------+
+	    |            |      ^
+	    |            |      |
+	    |            +------+
+	    |        [gen(A) > gen(B)]
+	    V
+    +-------------------------------------+
+    | GENERATION_NUMBER_ZERO =3D 0          |
+    +-------------------------------------+
+			 |      ^
+			 |      |
+			 +------+
+		     [gen(A) =3D gen(B)]
+
 Design Details
 --------------
=20
@@ -98,17 +141,12 @@ Future Work
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
2.17.0


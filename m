Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C2B91F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbeGMQqL (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 12:46:11 -0400
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:8800
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729275AbeGMQqL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 12:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSJtLrLNy+uyRdU9izyIWeCqdiv85lYvvflNqpcvlu4=;
 b=Ee8sHnHnhG8wFg3BcqQ0SOy9YO03Q+BIDisKGxr0U4mDoh+ygulgZm7uRS1Ei008fvNizjUnNOsbCRbbiOsY9h75mas5i6Gc6u9fcJ0NpzCnCRfbyTmr3WcUitie/QjeCqcvSat12UaZuiDwn1JU8lFqJLB3Oa+hc84SEzFrIRo=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0993.namprd21.prod.outlook.com (52.132.23.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.11; Fri, 13 Jul 2018 16:30:46 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0973.011; Fri, 13 Jul 2018
 16:30:46 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] coccinelle: update commit.cocci
Thread-Topic: [PATCH] coccinelle: update commit.cocci
Thread-Index: AQHUGsbZZZPpw+nRnEyfcpI36StsOw==
Date:   Fri, 13 Jul 2018 16:30:46 +0000
Message-ID: <20180713163033.110497-1-dstolee@microsoft.com>
References: <20180711093822.2123-1-szeder.dev@gmail.com>
In-Reply-To: <20180711093822.2123-1-szeder.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR17CA0091.namprd17.prod.outlook.com
 (2603:10b6:300:c2::29) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;6:P0zPFZshyp81/zMVHPoNxf8yijgdbX3znwZFUqFkGPxHqx9c8aJTwLhKeXQl9p66HT91yRtGposUXFzuXAImnXBzIWMbwK+POMK+NucLwywJvKAqBwOEAER1cxMMzLXtEbnh9kaIrpoRa9IZ7GHHCTb2NpYmHEbUR25H0IbNcFq4trTZ8+URKAGHsathbDcMgFxjNTbDu863TGV5PlArl140U6gQbYEDDtf1Op1dtYlVUXgO0fKFl9ybXGzZCprltHiDpXjy8uZyFx6i1kNGW7CR+5fWtYy3rxn83Avaxipgal/MqV9PCMK0ajvwxc+6lJngzIK5ik+X8QHeISgkKMWj6ABav8Se2RX/Oe7Cvgm4Xdzo3x0qWL9IJfl7OpbkUJL9LxOpH8wf3eNNiE4jJ8N4HpgerslRS5W8Ef0oIBuM6XWPhEVyfDAv5+PCgOmkvS5xXfUrPeVrVZpN2IT1KQ==;5:BxxMBOQdvir9JUHpUVYDpLzM4p6FGlXqoc70eL1ZKM66XwL4lTTlwUMj3GYnZQ/voWgGVjv0neyyZJwlFcut/dj7C1D2i/8RFJcy57qSe09GPIRrWzzhmMi/vVYU7LWt9V5gDGh/B2dlp5rWaVA0occv86fW9MjOgOpFybopQ4U=;7:DrQ8sZK1NBbhB/A2NPucqmegNzptG1YPyQy1lGrOcj+QOYHiF+SUMhK+UP+V8ZsrVt5xXsBxfSMNQ0INMYwhKi4mHFYZMMCvfd4ma2ojjYbiO5nkScXJkhpUmi4vQJezHL6mwNKxTBx7QjQX+f3rulfQiilvsY1ZF9WiihEKLq+pM5Wqf303QU/0Ptlgkv6z343nWzlR5nb8b9k8dGyrcz8Y4XaVSfxac7j9pbcm+yUxgVtHViclUqGSYek286CI
x-ms-office365-filtering-correlation-id: e56412ba-a148-4d75-b1d5-08d5e8ddfc16
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09939C96F679C2264CB17D9AA1580@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 07326CFBC4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(366004)(39860400002)(376002)(199004)(189003)(2906002)(10090500001)(2351001)(5250100002)(86362001)(14444005)(486006)(2501003)(2900100001)(15650500001)(256004)(5640700003)(36756003)(105586002)(478600001)(14454004)(6486002)(1076002)(5660300001)(86612001)(6436002)(10290500003)(68736007)(6116002)(106356001)(46003)(52116002)(4326008)(25786009)(81156014)(1730700003)(81166006)(8676002)(8936002)(1857600001)(186003)(6916009)(386003)(102836004)(6506007)(76176011)(54906003)(22452003)(99286004)(476003)(11346002)(6512007)(97736004)(446003)(316002)(2616005)(53936002)(305945005)(107886003)(39060400002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ubm2Yk1Vfmqt3ccCp/vjLRVe+YQEdFs+u+bL/CVXYbUTB++JTKldkPBrD62On9d+HyfnbLyRY64vz4SEYtU55P1WKhXkrZwI9YRgj5PF5sSYbmcGDT8J4///Z6nplWwg+i1LdRnnL35zSShD/rfazstSGgBkfTb3DXhl/vJcipqyJ054PbUNrBdsoOPi4Z9eAMrzOpxO/xQMcZAhkglQpyZGr5eme6i7QQr5i0CmN7FbM668bvrnEMxYaQWVkE4fIIg2Se/c3vb8b1qCnrjHEA3eI/eHWmR1eE7fwcdvKk0Q9br/cDdNPEtFnNuXfOHv2Q1x3uAv+ZioGV6cBvSybLOTonHPaXpC6+BiT5jKn/E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56412ba-a148-4d75-b1d5-08d5e8ddfc16
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2018 16:30:46.1157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A recent patch series renamed the get_commit_tree_from_graph method but
forgot to update the coccinelle script that excempted it from rules
regarding accesses to 'maybe_tree'. This fixes that oversight to bring
the coccinelle scripts back to a good state.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 contrib/coccinelle/commit.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.co=
cci
index a7e9215ffc..aec3345adb 100644
--- a/contrib/coccinelle/commit.cocci
+++ b/contrib/coccinelle/commit.cocci
@@ -12,7 +12,7 @@ expression c;
=20
 // These excluded functions must access c->maybe_tree direcly.
 @@
-identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph|load_tree_for_=
commit)$";
+identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph_one|load_tree_=
for_commit)$";
 expression c;
 @@
   f(...) {...

base-commit: d4f65b8d141e041eb5e558cd9e763873e29863b9
--=20
2.18.0.118.gd4f65b8d14


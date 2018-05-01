Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469A8215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755310AbeEAMrJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:47:09 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:50394
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755259AbeEAMrH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yc9Qy3dusleW69oHQ2N4w3XiH4cTU6c9Qgobl12EYcA=;
 b=OaFPAPYMnVij3nCy1QvKQBIP6fqMnoRVroLhCJI8AnYOiajyx7NrpQErChP8RwKwzyPTG4dlxlPZIKqYiIMzKkN91ETMhehdxhTjtX8G8B4kR1Z1qa90fe2ztpV6+17vS6YviTN131Ppe2Ui/IeRG/PUBbl3VQKNx4UivWt6gEU=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0977.namprd21.prod.outlook.com (52.132.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Tue, 1 May 2018 12:47:05 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%2]) with mapi id 15.20.0755.007; Tue, 1 May 2018
 12:47:05 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 01/11] ref-filter: fix outdated comment on in_commit_list
Thread-Topic: [PATCH v5 01/11] ref-filter: fix outdated comment on
 in_commit_list
Thread-Index: AQHT4UqCKrlkayVmpUO8/hrgFE/V6A==
Date:   Tue, 1 May 2018 12:47:05 +0000
Message-ID: <20180501124652.155781-2-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0977;7:1eB5DuvH/1WQzVb+imikIwjOKelhzPwoFCL8v7cIhBitrTliMbU6d+W6erUQR5FBfnYfNKy/9dWZuHaYc28q1Wm7whHAUgK33hS7DEuGXwn3eWddFz/UT7A2X08jS0DQVSql7ULFu9RAVEEUJPjJElkVix/sugvXn+T/qu5R7vTVzApYw+LKyBCY5J3gkvIrztqo9CT/3oeZOo2tZIK6kZSo12AN4NpnDGztTdiq5+0KuO7+FNJCtnkkWITFFvdt;20:HfTTxPGDCpEz862Uc6C/w0F2cVYySzX6TxqkbOyVH88RS0gaF7Y6MeSnzrpS9lfifCFZXzHu3XGY9CphQcVD92fB0GzcZzuvyWpMV1r2s7C465DdoIk8TT2f+DTKAo5pxAj6LPio30Vsi5iik6GK/3vXBz8GZFvL17SLOT9C15E=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0977;
x-ms-traffictypediagnostic: BL0PR2101MB0977:
x-microsoft-antispam-prvs: <BL0PR2101MB0977E3A8F79A854E786E8554A1810@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB0977;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0977;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(39380400002)(346002)(396003)(189003)(199004)(102836004)(53936002)(6506007)(386003)(59450400001)(99286004)(2900100001)(54906003)(5640700003)(3280700002)(3660700001)(2906002)(6512007)(6486002)(25786009)(39060400002)(4326008)(107886003)(86612001)(6436002)(6346003)(8656006)(36756003)(52116002)(76176011)(105586002)(106356001)(5660300001)(6916009)(5250100002)(2501003)(97736004)(7736002)(68736007)(8676002)(81166006)(81156014)(10290500003)(8936002)(478600001)(86362001)(486006)(10090500001)(6116002)(476003)(2351001)(1730700003)(186003)(1076002)(305945005)(446003)(22452003)(46003)(2616005)(316002)(11346002)(14454004)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0977;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: 9hPa0T0DJwBnbB+0zeKJtGCygu9f/QF5O3Ggb8GMv+iEs6sQ517Cwwe0EGl4Ppx0xhn2twLqCQPwvSVXp7tEL1iQY6duUOFfa1X9414pWd1cocN7x0TaZO4LnpLtGskhFHCbTPaQE71w4a6rKNh0Ij5wbjuyNJ8FyysKKxkXdo2OOxz5FporNASyK92xAquS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8817a08d-9c9e-45bc-9ec8-08d5af61a4cf
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8817a08d-9c9e-45bc-9ec8-08d5af61a4cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 12:47:05.7520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The in_commit_list() method does not check the parents of
the candidate for containment in the list. Fix the comment
that incorrectly states that it does.

Reported-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index cffd8bf3ce..aff24d93be 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1582,7 +1582,7 @@ static int in_commit_list(const struct commit_list *w=
ant, struct commit *c)
 }
=20
 /*
- * Test whether the candidate or one of its parents is contained in the li=
st.
+ * Test whether the candidate is contained in the list.
  * Do not recurse to find out, though, but return -1 if inconclusive.
  */
 static enum contains_result contains_test(struct commit *candidate,
--=20
2.17.0.39.g685157f7fb


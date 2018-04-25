Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DEFB1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 14:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754560AbeDYOiB (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 10:38:01 -0400
Received: from mail-co1nam03on0113.outbound.protection.outlook.com ([104.47.40.113]:51008
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754203AbeDYOh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 10:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yc9Qy3dusleW69oHQ2N4w3XiH4cTU6c9Qgobl12EYcA=;
 b=HP5+mBxKBdNhWSC6C962mUcKHrZ9g1hlLrw5TVZ1Os5cwYFNM55pOXx5sZUv+gNUQOTG2F+3qNWkV8guL/9YFh+aZTPYPl4WVvwSPENwmZgYtwfTsjQgeniW8JIh+bSz4eLLXafo9AjveJbfsYTcT/Bg6ZcV9c36JvmmVHX5HrA=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.735.4; Wed, 25 Apr 2018 14:37:54 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0735.006; Wed, 25 Apr 2018
 14:37:54 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 01/10] ref-filter: fix outdated comment on in_commit_list
Thread-Topic: [PATCH v4 01/10] ref-filter: fix outdated comment on
 in_commit_list
Thread-Index: AQHT3KL+E98EKoTvB06/hbJrxQhtMg==
Date:   Wed, 25 Apr 2018 14:37:54 +0000
Message-ID: <20180425143735.240183-2-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:sWlZb2HFV0Ze+y+9FZqhgxL0OeyrcV1+AOACiz+bRTh2hyLqNr1aXCb9sATnbl5kVm1WBsvVW6SGgsG5VqXDTbB6oZRWUR2N47pomPb9Ag/XXkSYYyfuLhCbg98kxSKo1xcXGx3NAQE8RNt4cDcBx79BePEe8Adgq+3tPmS5JxPjvTjDFn+tVA9N6cPN0DNffO54NOXbqSntXDko6Qg/r04xuI/P3RpgcBY7fKDRp8XvjE8leADyOQyqFRwbbyut;20:FCQTqf1xVY567dIhl4AkTmPT339ld7dvZ+UgHpP8wa9G1beEC0y7WErkKoQr1xEEDdEGwF8AiJs+/bAvZC1OOfhAeWYh2uqGSr6v1WdKarDoqCEMZhHTuSM5UqZ/PiVlopA+S0NXa2vCC/p++I75WuEAR/4mmidiPH7hxJsTsTM=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10445B73996927403C2C0E62A18F0@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 06530126A4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(366004)(376002)(39860400002)(189003)(199004)(476003)(486006)(76176011)(2616005)(106356001)(446003)(11346002)(186003)(305945005)(99286004)(7736002)(6506007)(10290500003)(52116002)(2351001)(46003)(386003)(59450400001)(97736004)(5640700003)(25786009)(3280700002)(102836004)(478600001)(2906002)(105586002)(6512007)(14454004)(10090500001)(54906003)(39060400002)(4326008)(68736007)(107886003)(1076002)(6916009)(6116002)(6486002)(3660700001)(53936002)(8676002)(81156014)(1730700003)(81166006)(8936002)(2900100001)(316002)(8656006)(6436002)(22452003)(5660300001)(5250100002)(86612001)(86362001)(2501003)(36756003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uaHo4x+DulpEGZyOb8MVLTYjhLjuHQ4Bl81ylxFr2p279s/N7JiTk3XrYk0QlKmmpaqZW8jCXolryNFvsWhukPuvscnaBM26hiapdST0T6bN+tN7OpOItHUOhvEHRIYDYkmiq9xkxpLb1sq+HmPZhx6S5TN4M9imojtCOI9qGAQmezs0RtadcSobPHDCvbKZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ca53cbae-a654-4ca5-4997-08d5aaba211a
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca53cbae-a654-4ca5-4997-08d5aaba211a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2018 14:37:54.4657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
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


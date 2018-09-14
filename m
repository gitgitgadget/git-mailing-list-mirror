Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9FB51F42B
	for <e@80x24.org>; Fri, 14 Sep 2018 14:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeINTw3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 15:52:29 -0400
Received: from mail-by2nam03on0100.outbound.protection.outlook.com ([104.47.42.100]:51842
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbeINTw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 15:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oMUiEsoeRAqnibtQl9NoOLq75L4gEmrE05f67FU7T8=;
 b=NqJn2dvxS8RLci4nZulEYtuxqOhjhLJjVwycdn0ARWzPYPUXFvDwovEEohJDlSxzNs14sXNRcljXzuyTVI0/JkO1v26zX6gHrxyET6Pix+5TY1ZS2AaShAOzSAH9/BA/8QHRjS2/qch0bvwv1oz/HM0LOnEZzEZCKdsuBvw652w=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB0972.namprd21.prod.outlook.com (52.132.146.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Fri, 14 Sep 2018 14:37:26 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.008; Fri, 14 Sep 2018
 14:37:26 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "t.gummerer@gmail.com" <t.gummerer@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1 1/4] correct typo/spelling error in t/README
Thread-Topic: [PATCH v1 1/4] correct typo/spelling error in t/README
Thread-Index: AQHUTDh0pwtCm1BX+0STPyIdHf9ddA==
Date:   Fri, 14 Sep 2018 14:37:26 +0000
Message-ID: <20180914143708.63024-2-benpeart@microsoft.com>
References: <20180914143708.63024-1-benpeart@microsoft.com>
In-Reply-To: <20180914143708.63024-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: CY4PR12CA0037.namprd12.prod.outlook.com
 (2603:10b6:903:129::23) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0972;6:YPuKuj952CTeYQQ5PpRkQ8pLf71VlYtiM4zgX4Fx1uxJgPa+7tDoY3CYgMzFGbOK2nVuvOU2zn73EdpRZA0kVuK3XVqqi7E1YBeXAtW/pebpdm0y57wxtj5DElz6mpGpeDGaM+Y0o430JD1aYaLZUy9lfiapU7S7Tp5wRcOuTOsnMlIRJIRvp+CITlLG0MDFMi1NR5aFM6G9jS2rYW+u92q0/uXgnhFiNCkAcZY+7uwuPE6SRCSvB+cOVOKZS8N4h1S/O9djP1VcQqCjsigY32prAlGC6VUpm8UA553vF3P4O+HR3LpuaMxtgtleo+aW9tLtQYVZ8zTBA0q7Rm4jcYp5artsvAq0gIg5sTtNhT6d/Fe0STsMsJcq3qYiCTF5cLw0w9TsLZN0lqNbJa4goEfQHA/F65YZLBRI9CWCl59Sd6IgYKa1KL707+16xVCDsgpTU5CTqV9NiwfSKANS0A==;5:dWuLxNljUEEq/E5vlaFf3nXKdyA9tROeY1Hwwr/zBG0AIAoSd1BNqyDgVnLn5QCIzj5mD6hWaUHEEh6tfcvhxdd8RrGQJu7tobfOtqPT5s35ZLaoeI+nvMX6E6TMYipAwZKuaEkC37J3tSynaot7bWOw4WOMFXZ2SAZBWu+MgV4=;7:Mscq4AEd73RkxufUz+ZEysSEPt6XQCbOokQfNRHihQi0g/hse+kOmZwni/x8Eip+BpxyICr18/k+/Ks+xEjhBh8mhByM7cBOd7KSXFMfG50Y2NMcoeq8uMcEYRZ6hx+uBttlfKwPHYQICQcdPb3NUbHgTJkBclhE63/eSx/LAw0qhZ3cs48nqKthP+kKvqYxgNgMTaJK165xNQTDc9j7G8VPSWIpa+cTXHI5xcFgGfT/BE24agR/Khtnuq8smHbC
x-ms-office365-filtering-correlation-id: 98dfcfce-0d8e-4690-b3a3-08d61a4f96f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0972;
x-ms-traffictypediagnostic: MW2PR2101MB0972:
x-microsoft-antispam-prvs: <MW2PR2101MB0972523FF61FD198B7DBB5BEF4190@MW2PR2101MB0972.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB0972;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0972;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(486006)(6346003)(3846002)(386003)(22452003)(6506007)(6436002)(26005)(186003)(53936002)(2900100001)(2616005)(446003)(11346002)(5640700003)(5250100002)(6116002)(476003)(14454004)(76176011)(316002)(25786009)(54906003)(6486002)(10090500001)(36756003)(2501003)(99286004)(1076002)(6512007)(102836004)(97736004)(14444005)(52116002)(68736007)(66066001)(2351001)(106356001)(39060400002)(256004)(50226002)(8936002)(10290500003)(81166006)(81156014)(1730700003)(8676002)(107886003)(5660300001)(72206003)(478600001)(305945005)(6916009)(7736002)(2906002)(86612001)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0972;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: bBe/pSNix03KR0OZy73OrOugUu566tvGqYxHrihAsi9jgMCi9T5MSQ2vuqfCQQRcZ/qh+Ldw849awoKqFAPVWES4U9N4eiBJzPLqHQms6q9fNNAvivbMe1k474C0eL5USQ5FZCiJhq2xPBZ5CXa1Uzv+jjBQWl81eiIj8vt3ml356cuPu3tDbuxYjzIBPoar0qI6a0zNmLLXig+67GUiGc6VbJMHk8OJBGS7LQ6HDDdGDC+g2iCdQpR3Z5WkiPWubEx0WM81UmU0awsp39p8H+MVVF3G77zwRJu1R1tO/sJGjuH6MMLGBBD8aRuOYZrY7ah95cCNeI/nui/IZ/3kePOu1Oh4ncpP1RiVRmLBFrg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98dfcfce-0d8e-4690-b3a3-08d61a4f96f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 14:37:26.1095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0972
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct a spelling error in the documentation for GIT_TEST_OE_DELTA_SIZE

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 t/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 9028b47d92..56a417439c 100644
--- a/t/README
+++ b/t/README
@@ -315,7 +315,7 @@ packs on demand. This normally only happens when the ob=
ject size is
 over 2GB. This variable forces the code path on any object larger than
 <n> bytes.
=20
-GIT_TEST_OE_DELTA_SIZE=3D<n> exercises the uncomon pack-objects code
+GIT_TEST_OE_DELTA_SIZE=3D<n> exercises the uncommon pack-objects code
 path where deltas larger than this limit require extra memory
 allocation for bookkeeping.
=20
--=20
2.18.0.windows.1


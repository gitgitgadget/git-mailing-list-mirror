Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EBCC1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 20:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeIOBaD (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 21:30:03 -0400
Received: from mail-sn1nam02on0110.outbound.protection.outlook.com ([104.47.36.110]:25600
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728045AbeIOBaD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 21:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oMUiEsoeRAqnibtQl9NoOLq75L4gEmrE05f67FU7T8=;
 b=d99est2tjP0rZnj2uCWEq6cAlzsEcfwAD1VpX6lxOQoBVNY6sDPBIzi7qnNGYswkSqjk/4hwsczOzCHeQmqNlKou8WwFITPvhYcJQ4F7yY1zniCwgkRNJ84PJZeQv9kODD2oMyukNG9rXCgjOZiDurCsho+bnIdUoHCQloSiqhA=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1083.namprd21.prod.outlook.com (52.132.149.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Fri, 14 Sep 2018 20:13:59 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.008; Fri, 14 Sep 2018
 20:13:59 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "peartben@gmail.com" <peartben@gmail.com>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "t.gummerer@gmail.com" <t.gummerer@gmail.com>
Subject: [PATCH v2 1/5] correct typo/spelling error in t/README
Thread-Topic: [PATCH v2 1/5] correct typo/spelling error in t/README
Thread-Index: AQHUTGd4J12X6HH+hUyYAJ2h0injsw==
Date:   Fri, 14 Sep 2018 20:13:59 +0000
Message-ID: <20180914201340.37400-2-benpeart@microsoft.com>
References: <80988727-085f-cdd9-e5bb-a90a55e97024@gmail.com>
 <20180914201340.37400-1-benpeart@microsoft.com>
In-Reply-To: <20180914201340.37400-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: CY1PR07CA0019.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::29) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;6:GeFuT3gZKS1ak63OOqsi8ItsMdDz1AGojofK76Lk5fu9Vmx6CZOTaHwLGZ8K03lRefW/oo37g1yW8vfk7yEquCR9+kaB69mvxNtizGm0mEIITVARjkJiRyEN+cADziA5tKV90U7v2QTxaFzdkZ90Op5A/dzTBDi4w4sWngkADeAdDb7Prh3Ylp1dw5j0v91gz6HUssV35oEoH6uF5tcvoIunPfOeaKEgC1e/3Byx+HgfF/m0RqAOGewQj0anCOczrpfjdabPpe5FG7PDa4ppiELEabDgsS/0s+PkV/9FKGcMFNIs1m6RcMSASeE1+mLU+x/+ZGIN2tS5B5HQryMaSkdnMkqOTPFjNaeDIod0pvcw6u+XcaLmnsi6JoO2294wHD+YgJEE35eo15A/gNdoLe70NFteJLAwALRWqM/pVSPECLR8Td2rMtzHfpeUDK4XzjacdRIOaEZvZmplvp79CA==;5:ToZNPjNBJBUgPPxLRZCSI93cbgecZvNEtHcCUAfbtBrQmaV4gjlpiF13GRceF2EtNAjZwLBmzUN9DPqs1Es7mxFs/DA5wopcSfKvTSC5VC7qNqT/6JVsVkSf9uV1+kvGCjKtWHuEwR/lscpIVCTOuzP/YTOhvceGVzaw8xFV7Jg=;7:zAsf2dPJyWqHuXilDUSHgQarNfQcdX7FlmqpMJHWsBv1ak4mnxJI6LADfM4/mHlfKxftgasSvjbPhdFNFQTqYVmDeRqy6czEjSXcTYqgTHyHFJcSDNYtDaASYnBOuO0onmxMZ2IX6pyyWKcdCVN+5qYGdJ1zvEg6BH2g19Egbk97rn/gXNt3QamRmUzA8pwUCuvXiApjqR1Kx3UibeCN0VLcUQbTVv8u6uRv9WmaAHUBmCRtUHvvNtS5g9Sw5wIB
x-ms-office365-filtering-correlation-id: 2bb95a74-f52b-4158-a376-08d61a7e9aec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1083734D7BB338C3A8C82EE4F4190@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(54906003)(478600001)(36756003)(2351001)(81166006)(81156014)(386003)(1730700003)(6506007)(8676002)(4326008)(316002)(8936002)(97736004)(22452003)(102836004)(1076002)(6116002)(3846002)(106356001)(1361003)(72206003)(25786009)(50226002)(105586002)(305945005)(14454004)(7736002)(1411001)(99286004)(86612001)(2906002)(76176011)(52116002)(10290500003)(5660300001)(6916009)(39060400002)(5250100002)(6512007)(486006)(186003)(6436002)(11346002)(476003)(2616005)(6486002)(446003)(26005)(5640700003)(2900100001)(10090500001)(2501003)(66066001)(53936002)(68736007)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wtDOWfR5S37Vi+MismQ6XFphENgCjjmrPOQR8e8AHJxwoIn5wqRgTRfHa8VdsJ+mSURczOxDslT3jdFE2X8qOpA7rNrQxpWxGpvS/RAINYS0u5NdgHrrxAKdurheczktW540mxcuGKo+LLjtodBheONCCvESghd5ZM096oap23SvXjKu8ETycJGnz37UzDcDcCO1+aD6OWI/ZepyAlEtdSA1CW8J78TCh/cbmAru1fTw4+4sTz4QvAr1j5imoiAg0wwQfuC9JUxvFsfBLFXIAib/bHx5S4gNXz5drM7B8g8op/ufP81u77n8GeTRzu1L6sRm30hk3H9YA8SuXsFHaSzP7blv6spozNgwdevdV7k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb95a74-f52b-4158-a376-08d61a7e9aec
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 20:13:59.5342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
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


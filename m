Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33DEF1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbeDCQwS (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:52:18 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:45952
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752661AbeDCQwP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=P3G+XR5SI6g5C4+XIFdo9UIceV+JhTRpYQRV8x3MXbY=;
 b=E+20PU1U8PNUhue3lovREycxoZg9gJoOMUFhYL/NV76HQC5v1ogrr+NTUZjh2q0kYG5lcJotXdCQ7U56SbuZEzEWSlomWVHskWvpdtTSSmY38eoocnGqp47sjUsemFtGjl61B2YXlR1sNL+K/rzzL2a5y0RxjAmFcxnQBMd5xdk=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 BL0PR2101MB1011.namprd21.prod.outlook.com (2603:10b6:207:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.675.1; Tue, 3 Apr 2018
 16:52:10 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com,
        peff@peff.net, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 6/6] commit-graph.txt: update future work
Date:   Tue,  3 Apr 2018 12:51:43 -0400
Message-Id: <20180403165143.80661-7-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180403165143.80661-1-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: BL0PR1501CA0018.namprd15.prod.outlook.com
 (2603:10b6:207:17::31) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c39dc48d-8196-4d8f-558b-08d599833e2b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1011;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;3:3xgDvpu/GXAohQrPUJbcoy2+KL00NCY6wgC1SanIssy+kULMynIMnd0b3hAy+D6Yy1xyeD7jS4dDUGlpP2TBGunNwcIS3IcXOkEl+Wh2+JOkL12DHF9T8GNHKvTqookHdQ/lXsd4AKl53uwatgN4xcTeydahSVAoWbLpnSu4VBdaazAiUEoRuvwYv/8Mm6ETH055SOdkZce/cvqXCEj5bfXv8GwqaYXAI7VCZNb+AUd60esaPkHQxz+/p3Q8wY53;25:bgy3PsSH8fSw+Ld5855OlA4fR+d0nzGUsYAfDFdTI+dRkST03rTIwvH7IQ/WiURHziuooVtDmb1yieN8hXaXPLiWRPJ6G31K1tI2bPkQQG5xl3+gpEql+bzjSHwz75TAjrjPsRUDbPF7t55CC63gFQynyj0qBLAt4V1f+K4YlWSYZ6tUkpqPK6ishiWgK304NIdpkZgKfvhx3MrsnxV2JBnmqzO0k0/FS3VZyYh2M4dqruI+lzlARTd79x4FxX154KXDiobU9G1ilcLo5p6HaMtZGq6XuuG7qk64+VxLIMChp73gnt0OKzr6lXNIS5IueLCY3Vlz85cXMQBsEDb4GA==;31:WCI0A7aEcz+U+Gmb8rSUMnuWvODcdEb9T8XFmzA9sLpbNJe1HrMq7aqrDoJgmWzIKi1ufviArCe4wTrTMO+s/8emylkN32YMAtHGKY6kes9sgfxSiHL0excEgtYhviFzia0po8Mb7EGSzv3q1uHb1RurMOdXRJxq8Hw2kjpIwhK1w2LkXUAk5TsOpcpum7sYi7nVxPmdxu/BGOgz3mYmf0J6xzPvqGUXKVAi7sKq1cQ=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1011:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;20:yNJSwqYyzex3Gcw0UFUn9FPeU560DGqkFJE9tiIfwApFRmvX71K+DfnaS0iId2E58SVX+WEgUG4eX78daxWw8SrO4UUrlTR8F3NhuW1DKLpBacfELlxO55p6957A/EuH7Y5sthLGMAEdMCjgTZJrwAK6tocpuSUU5JTKPdXoynYXs++W+oHXxVrE2kanOoNJPwsiI2WIBYkAWueqCf67RO3ak5ymtm8V0T4A/W+9acoUHNkzTsdsDWd30iKHhJtRJt5tb81ZqJw5p+WKmYGWgBMBFYYxcMnXX5XyjDPj0JDRraU5fQsCCG30D7s/j3+F6R7QhdqQfWr0CXKmJEqX6RtBpDqr98XqbtpLxKT/yLiG1hV6P+QaPpRXumVH3azqiO1FBDUMaHfEAysSIgc1PKDjh6fWfYqI6ClnLJUg9Fe/cuKuxhQcjiEBevLV9opgXKMrsRDcmbVp2S7xRf95LslXJ+5wxdYSq+pscnv9MxV6vHBz1FogZ1zw4dJZNGJf;4:ygkRAX7/47uzgPb+Y6q/9KlYT5vMNr+HuWzcMoJweTRyEpMMikhvactJG8tjtGU/QVs8vbdq9tzw+pevP8bZ40zcqxWPXIuyRhNaPN0S8yphiMNurskCj2hUgwQQxM/mqoPE1hmzkomYdRl//7BbyFTimT1lUFBlna9ZyZFgTjTCMtS//uU2TdhK7tIToJhyQrTjV2U0GVEZlU3VM6FpMHdD1A3LRacWENyTA17ebHBM2QiCzwMJ/Iq3pneKigU2DwbwJD8Oow+U8mDuC23UaGev/FAeFmzxO3zIcjitFCAjox1aLvseJQmM+q6+8syI6gwQoORc3z/bmWw6LqcV8/8h1V9yMdbLIip4qtxTHCk=
X-Microsoft-Antispam-PRVS: <BL0PR2101MB101187A468726F31815A4F3CA1A50@BL0PR2101MB1011.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1011;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1011;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39860400002)(39380400002)(366004)(199004)(189003)(6666003)(6916009)(105586002)(53936002)(7696005)(15650500001)(52116002)(68736007)(51416003)(76176011)(4326008)(52396003)(1076002)(107886003)(86362001)(575784001)(386003)(106356001)(59450400001)(39060400002)(6116002)(22452003)(478600001)(86612001)(2906002)(16586007)(316002)(50466002)(2616005)(5660300001)(25786009)(97736004)(81156014)(486005)(486005)(50226002)(186003)(476003)(16526019)(305945005)(81166006)(48376002)(11346002)(8676002)(7736002)(47776003)(46003)(6486002)(446003)(2351001)(2361001)(10290500003)(10090500001)(36756003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1011;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1011;23:zgLWLJv5MHMFd9L4aT9a0P2Chr8z/WhMDEalsRD?=
 =?us-ascii?Q?/bqITAABKa8f0Dqj8T+5mF8ehMoQqKtMo6GdxFzZh8PtZfFZDanGCS04H6RL?=
 =?us-ascii?Q?p9EhsthTguz2IRipc5aIgRbgEJx3RM1QtO9/nqxjBXZP1O5KvefT9ItQpsjz?=
 =?us-ascii?Q?Y7azH3KW7Z9s8aLXLWXhmB/hWC3WffY9vHQ0x5p8IdxLhm1uDHYZ6PquCeJA?=
 =?us-ascii?Q?DDJh65wRIwe0Kdfnj8JEVjIlVfIvkIRqXjIo1n/NuavBicmCzZWxt3LjKp6Y?=
 =?us-ascii?Q?J68iIubp8MKxO286VriSXq+gaFYGKZiPXFSGicCGaNpXWzQnWtg540j0VTH0?=
 =?us-ascii?Q?jSdxTfYXjStutx914DI3CCU8+h0P5YB+nQzFGgNlN9wddkWaMBSncyG2gi42?=
 =?us-ascii?Q?lrUB+HP/x+PFPYxfOSpdwEyI0AHaoc1u5nmZGyc2CNlVXJVoEOVUUI3wrNJd?=
 =?us-ascii?Q?G9YaxNUm1cRpmUzHvF/FEZ3WeqJOLkOBk5WuLTia4M+g22mSLbwOdsrjbWDj?=
 =?us-ascii?Q?CkvxJhU2H3vtdE6FYV1JIcZhfJeMzSbYXH6HKMyL4VgDpm5+hOPlwp751c/Z?=
 =?us-ascii?Q?59ls+UqQr+Q3GY1R6WpRtoi7SHlaFV5QivSAWvSRNLSgh3IXXC8hyjPl7LFe?=
 =?us-ascii?Q?XnXI70SX5tKdmrIr4R+wsEcEmzRQ9PLGECIWFHpkfCAX3E/Gt5uFEO0JXChW?=
 =?us-ascii?Q?5ZYNuKC27eGM1dYWDk/6CPCT8oM8wnfDfJl9AXoRHoZ21zMvTykxRMqqdlBa?=
 =?us-ascii?Q?yv8C1mdL5n931hM++w/YBdoGLuBzSw4vxzYiFpGL0AZ0DuKj8poXV3m2CKsS?=
 =?us-ascii?Q?N0aIouhNOHhD5wHATKALLr81pg3c7M1J63d8IVigODQlpcOJZl79IbL6f3wY?=
 =?us-ascii?Q?qtvDYvFQZ+cNvals/iljMXJrvsqGxSoOvRvatN2eTHG5JZAI42Fco/9Wq8kx?=
 =?us-ascii?Q?KRNTPXxqZUHt4uFOt+QKVvTaD5DFfEC3OLAzDnabSdFS6kdVuoSccLkHGhFr?=
 =?us-ascii?Q?QirBB+eEucAuGo509qE8Wl4NZ/IsVDuaBQgRRQ3zLu0YPnskrkM4gSNi0Qys?=
 =?us-ascii?Q?nCATQvZ2rqiH0uE+XYyE0S6qwHKJ2Pkp8rBa/+XkwbmoJy0tlkpkxekzWTwG?=
 =?us-ascii?Q?RnncrarLS6kfqT+sLmcGbOzuOeb6Xek6bEx60Z7ueHzz99cq4tIj4VpZuJzI?=
 =?us-ascii?Q?Gk/eI4tu9cvIqEdh2SOW8K1pGi99toeSoZzAfffk3xJlPM6Y07AU6w+cJZyj?=
 =?us-ascii?Q?REub8jPxqkQG6zWtFXCZHmVS9USQLXJ49QDoP+fiMCDMIslJreRjk4jNI+Kp?=
 =?us-ascii?Q?dMVLUWTJ61n1l9rvot0fjSwoEFSkGN4poi7ZZfbpsbWYV610ruecy5jyWpT7?=
 =?us-ascii?Q?YDBBCGNf6r6UubsXsZJCA0GQP+erxuxkgt9s7ow8sStVpH7JaNiPetq8gpLe?=
 =?us-ascii?Q?alrrwJBHB2Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: RE+B5xNx0YuUzVrkePoDIUU2ZQg0J3I9wiGbiSlm422H3PPrjmccXwU/LowJwiqPnATOMaoXasSDvF8DoNeuerV8Mqoajt33hCLq60FBHfVcRfnK8MU6P/zAQjpdobM6T9h6m9kvgIER0FJULhgwkydA/+u3boUgEPf9Pn98Wi22Fm5RwmRwSONJ9kVP7xCo
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;6:EjDWO8T0l5apXM4DXCSH1Poydk/OE0ecqaLEZ0eCCvvRTjIrvgKZUH6VNOPk+TMWWSbSW6P63G8DbRwtZnb358D/FRS8QPHsuSj3Sv3lQJOkJI9xMSUQQUMelen1QVJ2FYONbrVX5zPzymhapk22mITCdSwwdTOKSnULeM6XkQk32dikPxj7TnvIB7N4qFEmP8kcR0sHvxg/5XbW+1832vvJoAwFVunr7Wr99eyHyu9TDQImzNTU5HGyZw8MBdzs5h9V1Znr5IjfNCICQsuvX0d4XJVKzHhUDbBX4dezbpjfZNO39cXCWv+6dKPXrE35vaQ2nIYD4u0TxyOh+K0AoUWV5Inwlf7I5Et6Bk4d3aBV91ifc+CU2pOaftkLenNMOJRqQiFzW51Hxhzefx4N6x1s50+G8REPeJDRZy+NyQfEkELrgmNJjdtbFH7AOOEWXR9J3o1QF5cor+Mh/lZQSQ==;5:MQSfNqyy1FYsF1pdTrf5JwAle/NKn9PVXepRRLObnPDM5nkXAMjNpFRCsYhueupxFsS1dvddn77CPvyiFZAxg5/+ZF9dxiG/JW7+XFPvWxarYC2kHLWXdVvurVDE02bjHk2mHgjm6QznXmIDe6yy132iRjnZU60LglcPgxeX0iE=;24:UO/5R35YwAdiAump/GWnULMvF9WwaeSLQf7NMxL7KHnv5MdUTJNmp9waOaSz39hgGmlvmJ70sUtjy84xBbnCxeLqK7rakgv0E/mvqFkjKag=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;7:Y8qRtlv5slsWAkus4n8Cf7SDRPsiiVCacCekWZs21JkfKGDUi5zFqrpSL/eCrb8PQgfZMTzWYepCOKquAEw1V+kdRpGnkhWktbHfjQbMEkGgoSX0Ou4TftV+X69B1YzRpY4e6uWLVYvUJSNrE9OUj0nEC1+pmLFP9IWp/i0LTBHpG1hPRVjhMSpNB+CBe1XzW3uRdjFnW5ENkr2EFQXTi2TZfhjO1njvXngcgxoAsnPeF/5w2agxBfo9OHYvA7wK;20:C+WdInMCEq0bzF7FksX2+y8Zl8urv8MZgPWgZN9QbgJwThL4cpWjiDkGhvQsthIjDcCa7uurHq8h0dWX681vXM8Jyrrj3GINAsvhoNC54cG6Q/ztNhzO1vxKLu3myWEdupkt010lUJLTym6HMjLP9ACLf3SuqvPeEupT7v5/iWg=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 16:52:10.3242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c39dc48d-8196-4d8f-558b-08d599833e2b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We now calculate generation numbers in the commit-graph file and use
them in paint_down_to_common().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index 0550c6d0dc..be68bee43d 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -98,17 +98,12 @@ Future Work
 - The 'commit-graph' subcommand does not have a "verify" mode that is
   necessary for integration with fsck.
 
-- The file format includes room for precomputed generation numbers. These
-  are not currently computed, so all generation numbers will be marked as
-  0 (or "uncomputed"). A later patch will include this calculation.
-
 - After computing and storing generation numbers, we must make graph
   walks aware of generation numbers to gain the performance benefits they
   enable. This will mostly be accomplished by swapping a commit-date-ordered
   priority queue with one ordered by generation number. The following
-  operations are important candidates:
+  operation is an important candidate:
 
-    - paint_down_to_common()
     - 'log --topo-order'
 
 - Currently, parse_commit_gently() requires filling in the root tree
-- 
2.17.0.rc0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C95F1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 03:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933685AbeFMD5Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 23:57:24 -0400
Received: from mail-pu1apc01on0046.outbound.protection.outlook.com ([104.47.126.46]:38352
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933584AbeFMD5W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 23:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortunewhite.onmicrosoft.com; s=selector1-fortunewhite-org;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UotwHs+adJNtjA5YTEo1SZOr/AtmMh4qPxc9QpIRRJs=;
 b=QGtuWwxa6gFp1VO/qY9QUdn4JyyvUUY9ce5F1ipGCbhWSHzLlkydaIAloLD7Eg45Ify8GVTI4jwsO1LlLZH/kI+uOiToeHD2GBy2D2WyUKh9BGKWE/JKU0VxqDz2kw5Z8pF3xdXfViBSD2IuOhgzGMUGcvS9z23zdVV9KDVcbw4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mengsungwu@fortunewhite.org; 
Received: from localhost.localdomain (114.42.142.74) by
 PS1PR02MB1404.apcprd02.prod.outlook.com (2a01:111:e400:790b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.17; Wed, 13 Jun
 2018 03:57:17 +0000
From:   Meng-Sung Wu <mengsungwu@fortunewhite.org>
To:     git@vger.kernel.org
Cc:     Meng-Sung Wu <mengsungwu@fortunewhite.org>
Subject: [PATCH] doc: update the order of the syntax `git merge --continue`
Date:   Wed, 13 Jun 2018 11:57:02 +0800
Message-Id: <20180613035702.15957-1-mengsungwu@fortunewhite.org>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [114.42.142.74]
X-ClientProxiedBy: HK0P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::18) To PS1PR02MB1404.apcprd02.prod.outlook.com
 (2a01:111:e400:790b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69423495-2afa-4ae5-a333-08d5d0e1c1a4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:PS1PR02MB1404;
X-Microsoft-Exchange-Diagnostics: 1;PS1PR02MB1404;3:9nyUam42+9CvxVDEYlW+Deh98zk5H2kp/Yf0qvnc/UOmSMxgUMewO5o1OD1jgXW48kE+qh+fK/gURBJo2NzVA5R1S8LtThiCr0fN2HFXzjO4MATh4nB+dSre0MN0uU828zNMRCrjLSCp+ddEI8yYzucdIE8sKS6AYH6J22FMm073tMWKn17aXp6P352vXpm58S62dqVWwrDbmBfidtxS71/RkL2zwDFYj8teeakaHmg4xpNqsAoouG9CV4dF2xEG;25:4xEwLwykJXGc+YnQiNsfZBIuYdB6Od9W3Abmo3zd77lxCrP2Hn3JIUll5w8bM2bpTnQtjKmIW3FDCxwtcERvWwQP02UpOT2NG5c3CoctimGP9cWAau8LGgiO6kjOkzcYf/uccLPuUa4UVlRsSauyaJK7kYfn0QyJ/rp1LkNPN2eClRDWGV2ig7FTV5i4c+zxmrhEC1xZ4QW/dVtHUgDnW6D6OlzzVuKUUZRZ2TA7ZzbEGzVAZfwr4SwXu5nV2ebIpYs3R77udYVxzh6oJYQReGhegYERpaY7ie5mvzOmc1bYjocpAKu4Cek7GG0xuiM2gYNG0kSTY0fm4HCz0O79uA==;31:CHyMNoYj3H2vw6WumGnglrdABw/HhWxYfbiaHsMZUBVW/6dt/OKGXDf+gSCXZhLniff02hqJqCDqwkFmo0rbB9COwvIolleEDU5SJf/Gq6qOo+ArPfR/qkAMg5ZmPzIKxEXQdnhEk9DE24vnXy15P0n7aupwr3WEnzKw+MWVg9Mbo5djxWgD/1l7kxGwrPvgkp6+rJQJAi/SY5LhyMf1flKRhsjVudG1MecMhp55eHE=
X-MS-TrafficTypeDiagnostic: PS1PR02MB1404:
X-Microsoft-Antispam-PRVS: <PS1PR02MB14040C1134964AD0E6C03D6DB47E0@PS1PR02MB1404.apcprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:PS1PR02MB1404;BCL:0;PCL:0;RULEID:;SRVR:PS1PR02MB1404;
X-Microsoft-Exchange-Diagnostics: 1;PS1PR02MB1404;4:QtvhV9OM5xL2nuhOrquSnDBidN0FkNOtwMIBWtQUKj9IIFhX7Ah8BjY0/J8wf2Vg6hAuUjTBbdf29tuA5CPkmRnr06Js613O7AJCif24VE5Xa4DNlp3LeUH1Fzw0wtq20Vx9I3XJvYEJO0wT/Hl63EM5ZrFRneyVNJN+6agBEjiXa8BPw4navYttJHldmLNWdV6eZtoWjUshRTkHeMGRAIZW4zsPe9RxpnzioblrSh3pS7sVwWv9TjPWm/6VVq7vxbm+KqE7VaqKs2eMM781MA==
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(39380400002)(39830400003)(376002)(366004)(346002)(199004)(189003)(36756003)(6666003)(6916009)(107886003)(4326008)(105586002)(956004)(2616005)(476003)(16526019)(486006)(51416003)(52116002)(97736004)(106356001)(5660300001)(1857600001)(59450400001)(186003)(6506007)(386003)(26005)(2351001)(2361001)(316002)(16586007)(478600001)(3846002)(68736007)(1076002)(50466002)(6116002)(8676002)(81156014)(6512007)(48376002)(2906002)(7736002)(15650500001)(47776003)(66066001)(6486002)(86362001)(81166006)(305945005)(53936002)(25786009)(8936002)(50226002)(11716003)(46800400004)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:PS1PR02MB1404;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
Received-SPF: None (protection.outlook.com: fortunewhite.org does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;PS1PR02MB1404;23:8m0KHmAN5pdonxctg9OuTFFfGEp6/TZZt9ADftJzq?=
 =?us-ascii?Q?WB5+5FulBj6JBmrPeY09BwTNHCG5m0zwofAjNmuLhikQuHArHU13duQjVRXA?=
 =?us-ascii?Q?cRJHCprZIBp2Lo0vFeAXgQ0083PHYZ50uUzXL3+7CCRf7RFLkc2q20atxFU/?=
 =?us-ascii?Q?NY/ZRzropUd/zXpID3r4ydn/qsECgnjNaoD5q5oIrS3JOCDNvJPQovzNPxiU?=
 =?us-ascii?Q?swFnZHKA5JbdpSpkTlMKsQxLqKyZkOOe+deWsrMGaypDAPGcHXrGvo1mdVR0?=
 =?us-ascii?Q?cHA9jXUYRhlWqxtrtIFnmgzU6SilEh8jkHC5js0pGg9zbD47SGtr6PJctcn2?=
 =?us-ascii?Q?Pvul3rFcWBW92iTb4R/x7a2O2VFcA5d4fLYdZjM8J9eJViutn6YUxR8sddJ6?=
 =?us-ascii?Q?ARJETmasfLNPtbOnD4kJhd0rp23O+NeMFNZGwDlSFqlrtXCSYEOzu2PPQin0?=
 =?us-ascii?Q?SUlK0UfE43s7aWoieMOnbtktcgvV6v0oKtvnSoE9jpU3bAiyrJ/f4fQsdlCA?=
 =?us-ascii?Q?HIqtavXYcD355y3uXvyonPgU+FhjdtNJACKXw4O8xal2+0bXh8J17WBR8e6A?=
 =?us-ascii?Q?Mul0+oTXmU+pxnYFCN9NyUZwD4wZbf0Wa4ZSg6PYRW3RG/PmJbyJo0cjegCH?=
 =?us-ascii?Q?U8vv2AuWeQx/fFReB2GymDZhU/aGsknvfP7gagrpwhKyN7D48pDchuQgbUkH?=
 =?us-ascii?Q?AP8Th2qoNht3taeq9W4Z4hb/BwXddC7gb0Ob6t4HuWXseSGbRAsc7LiRDPnQ?=
 =?us-ascii?Q?2bcPbZJb7DXk2kCKeAGLKObKECrWy37JoiFCKMltKNeBkgaPJ0inUachCG41?=
 =?us-ascii?Q?lgyNwpyyxZ57s4QkupkSnzFFvzBZ2Nebhu7QpCOx0uGhWdEXL3vSv6ai3odo?=
 =?us-ascii?Q?vZ7Xykmcqd1B3PZYpX6qnz2/dhfcWcYCuk6h3oIYPPOrIhbEyyoX9cpauOst?=
 =?us-ascii?Q?QCeO5SrBPDmVQ7qJ4o8FKMi9HZ5Ses/m+RjLfVJxY1juP92pjw0v6eQlCizo?=
 =?us-ascii?Q?0YFgywK8ENWlSYF2ni3myIEeV5XWXWTDhkyT6EavBVo1X3PwDo15NsJpyy8s?=
 =?us-ascii?Q?FQisUjJKiAvzDR4A1C/L6ZaeU88wTM7TWtQCZVZI5k+iCy9Vksbgzwsz/s9O?=
 =?us-ascii?Q?cQC17yFB+bV9oVXcEzROl41enQkFGIyfYv/TvA30yTKZMAGM6J7gsS68TkYR?=
 =?us-ascii?Q?Zu1iMC7n4OO9Wmy/gFsTI0CmZVuX1/HdCfBi9HP+Cvez4Af82mjCFcg1GT1g?=
 =?us-ascii?Q?pCPYvUXWSBFieXysiiQaPy9Wyrmg65A1yj2X3zW8+G34nkLWalKzmJ6kG16R?=
 =?us-ascii?Q?7OOzr5CeftvucpUAmSoF5ojF+UOssTw/hPrbYoqcLZ1gHBqWBn3Qwwu0ERdP?=
 =?us-ascii?Q?TvW/w=3D=3D?=
X-Microsoft-Antispam-Message-Info: M6ZykH+xtd1PdML7XD3m6rfR3mW/ptL4730qL9NSHYxn/0C9rR6MklcImf0fJqQ6ZiBHLSNWjcLK+tEwIS8L9+EotmImOzsTBNFBd2CYfbO58571ldnL6peeOZeskkxEVJlIQDqsCpBdnjEgNfpoQ9bT+YLdd7oL0j69Q7/Curpv2kEuzBByglsZYjGHp9K2
X-Microsoft-Exchange-Diagnostics: 1;PS1PR02MB1404;6:DqEBKJmUkGZ5p/shYC1IMR/gotaPfmkF9g6P6Vn3rKT2dMM/hLyYm+tNN8dxbRwkK2sURKZjM51O9ED9mg6Ve6ArziNs3mYuOJ4cj3z9Uhhw58h2y+Ngu+zvkUXZcKKzV6DqCf8eZIP5umzCyUM++GmtUdmF4ahjPReNc8yKeli9R2txoyG2MwsJJkkn9PQXZXhyNCjYw8EXFbxcBLSLBU7oJT2pZysuGW5cSRZ7bs7/sxNBorg6vMD3yH1dILSzwZZGv3CuTGBXOgkGuKEKmEiPDPZJ7vWXWodZ5q22REgtzFEN623lHcm+TRf7vNU9VXayqj7/25yITf/RPJWxC/6tK2hh3jJy/rVrPYbTPjoZ61YKaxXIQa2jeqy27qqiIRJ9BoQFiGy3+e4QBpYIbhy4KM78l85QK+51U9duYPWtT6Lrv3Xwu5Oso9ZGeCrZm1LD0wEM0zV0mUfrJp0U7Q==;5:UXNaGkpYghW82E68q+QLx4wMqJfQrtAkQWsvcQTvZAITmSIe63cXo51EkKjBTE59ZJfw2wZuwV6AjhSPzhUqzviK6TVe0q/62XYNXYC9nRP+UBiDC7rKOfZko7qGmM0F6eDH4his2H3I7KD+3Oy+7tcCHDYwWntAvaeFYoW5lXs=;24:j4wLAnEbaIZbVs/YJUgEocQwV3v2AzFyo1uqwII/SJ63QN18oxV+KJBG17lIt7e8bhbj01uWGkDGijbTrSJFkbL8hf+1EFCx92hEL6hF8Ys=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;PS1PR02MB1404;7:8Pv19lRgCIPgcGiFSrxV9CBrAVBnm6prVkBqbHNy8CTMauz0QSZwdnB1NR0AkzaV0tNZWYaJaktcVhJNu5QtpvR84DAdZDBZ90URJF4WQXZlQ3WWWdMIRm3X5FynZFOpa8POOtV5Op3M2KUkU+1Cc2LUYFFtkst7FF4boKVmhKjg6fHiGV5xgNs+HZ3+noFn76/MzP4D6IW9oeJU6w5N16IZO0mwGBiCIXvoilI9c8g8g9Z9stg2k5nl17aOxNRr
X-OriginatorOrg: fortunewhite.org
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 03:57:17.3680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69423495-2afa-4ae5-a333-08d5d0e1c1a4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0f8f60d5-9654-45b1-a1d8-998175cd542e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR02MB1404
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The syntax "git merge <message> HEAD <commit>" has been removed. The
order of the syntax should also be updated.
---
 Documentation/git-merge.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index d5dfd8430..6a5c00e2c 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -57,7 +57,7 @@ reconstruct the original (pre-merge) changes. Therefore:
 discouraged: while possible, it may leave you in a state that is hard to
 back out of in the case of a conflict.
 
-The fourth syntax ("`git merge --continue`") can only be run after the
+The third syntax ("`git merge --continue`") can only be run after the
 merge has resulted in conflicts.
 
 OPTIONS
-- 
2.15.1 (Apple Git-101)


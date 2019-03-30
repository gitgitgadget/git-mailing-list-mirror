Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F94720248
	for <e@80x24.org>; Sat, 30 Mar 2019 00:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfC3AeU (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 20:34:20 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36394 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730322AbfC3AeT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Mar 2019 20:34:19 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2U0XVDu015420;
        Fri, 29 Mar 2019 17:34:02 -0700
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rht7wrark-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 29 Mar 2019 17:34:02 -0700
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 29 Mar 2019 20:33:57 -0400
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 29 Mar 2019 20:33:57 -0400
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 6E9A8220CB31;
        Fri, 29 Mar 2019 17:33:56 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 12/15] t6043: fix copied test description to match its purpose
Date:   Fri, 29 Mar 2019 17:33:33 -0700
Message-ID: <20190330003336.21940-13-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.211.g078f4bef79.dirty
In-Reply-To: <20190330003336.21940-1-newren@gmail.com>
References: <20190306002744.14418-1-newren@gmail.com>
 <20190330003336.21940-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=439 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903300002
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 62c564707b..fe205be607 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3910,7 +3910,7 @@ test_expect_success '12a-check: Moving one directory hierarchy into another' '
 #         To which, I can do no more than shrug my shoulders and say that
 #         even simple rules give weird results when given weird inputs.
 
-test_expect_success '12b-setup: Moving one directory hierarchy into another' '
+test_expect_success '12b-setup: Moving two directory hierarchies into each other' '
 	test_create_repo 12b &&
 	(
 		cd 12b &&
@@ -3940,7 +3940,7 @@ test_expect_success '12b-setup: Moving one directory hierarchy into another' '
 	)
 '
 
-test_expect_success '12b-check: Moving one directory hierarchy into another' '
+test_expect_success '12b-check: Moving two directory hierarchies into each other' '
 	(
 		cd 12b &&
 
-- 
2.21.0.211.g078f4bef79.dirty


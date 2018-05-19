Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C91281F51C
	for <e@80x24.org>; Sat, 19 May 2018 02:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeESCHG (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 22:07:06 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:59098 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752205AbeESCHF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 May 2018 22:07:05 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4J263gX024696;
        Fri, 18 May 2018 19:07:03 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2j23ryhmu0-1;
        Fri, 18 May 2018 19:07:03 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id F0D2B229B0E9;
        Fri, 18 May 2018 19:07:02 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id E793B2CDE79;
        Fri, 18 May 2018 19:07:02 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/5] merge-recursive: fix miscellaneous grammar error in comment
Date:   Fri, 18 May 2018 19:06:56 -0700
Message-Id: <20180519020700.2241-2-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.847.g20b8963732
In-Reply-To: <20180519020700.2241-1-newren@gmail.com>
References: <20180519020700.2241-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1805190021
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 35df695fa4..c430fd72bc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -531,7 +531,7 @@ static void record_df_conflict_files(struct merge_options *o,
 				     struct string_list *entries)
 {
 	/* If there is a D/F conflict and the file for such a conflict
-	 * currently exist in the working tree, we want to allow it to be
+	 * currently exists in the working tree, we want to allow it to be
 	 * removed to make room for the corresponding directory if needed.
 	 * The files underneath the directories of such D/F conflicts will
 	 * be processed before the corresponding file involved in the D/F
-- 
2.17.0.847.g20b8963732


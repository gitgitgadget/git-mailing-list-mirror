Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFAC41F403
	for <e@80x24.org>; Sun, 10 Jun 2018 04:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbeFJEQ0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 00:16:26 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:54354 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753672AbeFJEQY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jun 2018 00:16:24 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5A4DmRJ011512;
        Sat, 9 Jun 2018 21:16:18 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jgcrk97hy-1;
        Sat, 09 Jun 2018 21:16:18 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 60CFD21F2AF6;
        Sat,  9 Jun 2018 21:16:18 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 5C62F2CDE86;
        Sat,  9 Jun 2018 21:16:18 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 1/6] merge-recursive: fix miscellaneous grammar error in comment
Date:   Sat,  9 Jun 2018 21:16:11 -0700
Message-Id: <20180610041616.4448-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.6.gffeb3ef585
In-Reply-To: <20180610041616.4448-1-newren@gmail.com>
References: <20180522004327.13085-1-newren@gmail.com>
 <20180610041616.4448-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-10_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806100048
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ac27abbd4c..921f8e2d2d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -539,7 +539,7 @@ static void record_df_conflict_files(struct merge_options *o,
 				     struct string_list *entries)
 {
 	/* If there is a D/F conflict and the file for such a conflict
-	 * currently exist in the working tree, we want to allow it to be
+	 * currently exists in the working tree, we want to allow it to be
 	 * removed to make room for the corresponding directory if needed.
 	 * The files underneath the directories of such D/F conflicts will
 	 * be processed before the corresponding file involved in the D/F
-- 
2.18.0.rc1.6.gffeb3ef585


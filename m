Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAE871F404
	for <e@80x24.org>; Thu,  5 Apr 2018 17:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeDERUi (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 13:20:38 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36384 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751255AbeDERUg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Apr 2018 13:20:36 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w35HDNIS005377;
        Thu, 5 Apr 2018 10:20:35 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2h277s732a-1;
        Thu, 05 Apr 2018 10:20:34 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id CCEF5229B0E3;
        Thu,  5 Apr 2018 10:20:34 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id C3F8D2CDEB4;
        Thu,  5 Apr 2018 10:20:34 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/2] Documentation: Normalize spelling of 'normalised'
Date:   Thu,  5 Apr 2018 10:20:27 -0700
Message-Id: <20180405172027.31515-2-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.7.g0b50f94d69
In-Reply-To: <20180405172027.31515-1-newren@gmail.com>
References: <20180405172027.31515-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804050178
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This could be a localization issue, but we had about four dozen
"normalize"s (or variants, e.g. normalized, renormalize, etc.), and only
one "normalised" (no other variants), so normalize normalised into
normalized.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-mktree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index c3616e7711..27fe2b32e1 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Reads standard input in non-recursive `ls-tree` output format, and creates
-a tree object.  The order of the tree entries is normalised by mktree so
+a tree object.  The order of the tree entries is normalized by mktree so
 pre-sorting the input is not required.  The object name of the tree object
 built is written to the standard output.
 
-- 
2.17.0.7.g0b50f94d69


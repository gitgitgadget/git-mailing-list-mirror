Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 842021F453
	for <e@80x24.org>; Tue, 23 Oct 2018 03:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeJWMPN (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 08:15:13 -0400
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:52145 "EHLO
        fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbeJWMPL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 08:15:11 -0400
Received: from fed1rmimpo305.cox.net ([68.230.241.173])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181023035342.XNVK4136.fed1rmfepo103.cox.net@fed1rmimpo305.cox.net>
          for <git@vger.kernel.org>; Mon, 22 Oct 2018 23:53:42 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo305.cox.net with cox
        id qrth1y00a59yGBo01rti3L; Mon, 22 Oct 2018 23:53:42 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090206.5BCE9B46.0010,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=TOXxtGta c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=smKx5t2vBNcA:10 a=kviXuzpPAAAA:8 a=YFMf9IyjuHz-WlxvhJ8A:9
 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id A3BA929A0208
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 20:53:41 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/5] t7509: cleanup description and filename
Date:   Mon, 22 Oct 2018 20:53:38 -0700
Message-Id: <20181023035341.15398-3-ischis2@cox.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <xmqqwos19nr5.fsf@gitster-ct.c.googlers.com>
References: <xmqqwos19nr5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename test and update the test description to explicitly state that
included tests all relate to commit authorship. The t7509-commit.sh
file was not rnemamed when other scripts were updated in compliance
with the test naming convention.

[1] f50c9f76c ("Rename some test scripts and describe the naming convention", 2005-05-15)

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 t/{t7509-commit.sh => t7509-commit-authorship.sh} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename t/{t7509-commit.sh => t7509-commit-authorship.sh} (98%)

diff --git a/t/t7509-commit.sh b/t/t7509-commit-authorship.sh
similarity index 98%
rename from t/t7509-commit.sh
rename to t/t7509-commit-authorship.sh
index ddef7ea6b0..500ab2fe72 100755
--- a/t/t7509-commit.sh
+++ b/t/t7509-commit-authorship.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2009 Erick Mattos
 #
 
-test_description='git commit --reset-author'
+test_description='commit tests of various authorhip options. '
 
 . ./test-lib.sh
 
-- 
2.19.0


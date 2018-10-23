Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CE361F453
	for <e@80x24.org>; Tue, 23 Oct 2018 03:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeJWMPM (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 08:15:12 -0400
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:38449 "EHLO
        fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJWMPL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 08:15:11 -0400
Received: from fed1rmimpo109.cox.net ([68.230.241.158])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181023035342.XNVN4136.fed1rmfepo103.cox.net@fed1rmimpo109.cox.net>
          for <git@vger.kernel.org>; Mon, 22 Oct 2018 23:53:42 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo109.cox.net with cox
        id qrti1y00159yGBo01rtiUb; Mon, 22 Oct 2018 23:53:42 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090211.5BCE9B46.001F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=HfWgsRM8 c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=smKx5t2vBNcA:10 a=WDhBSedXqNQA:10 a=kviXuzpPAAAA:8 a=5hH1eStbwqkaGghjTmgA:9
 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id D010429A020A
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 20:53:41 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/5] t7500: rename commit tests script to comply with naming convention
Date:   Mon, 22 Oct 2018 20:53:40 -0700
Message-Id: <20181023035341.15398-5-ischis2@cox.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <xmqqwos19nr5.fsf@gitster-ct.c.googlers.com>
References: <xmqqwos19nr5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the test naming convention was documented[1] the commit script
was not renamed.

Update the test description to note that the tests fall into for
general categories: template, sign-off, -F and squash tests.

Chose to not add "File" to the new script name as that did not seem to
convey the current test contents for that switch.

[1] f50c9f76c ("Rename some test scripts and describe the naming convention", 2005-05-15)

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 t/{t7500-commit.sh => t7500-commit-template-squash-signoff.sh} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename t/{t7500-commit.sh => t7500-commit-template-squash-signoff.sh} (99%)

diff --git a/t/t7500-commit.sh b/t/t7500-commit-template-squash-signoff.sh
similarity index 99%
rename from t/t7500-commit.sh
rename to t/t7500-commit-template-squash-signoff.sh
index 31ab608b67..46a5cd4b73 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -5,7 +5,7 @@
 
 test_description='git commit
 
-Tests for selected commit options.'
+Tests for template, signoff, squash and -F functions.'
 
 . ./test-lib.sh
 
-- 
2.19.0


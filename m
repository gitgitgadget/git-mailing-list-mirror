X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: andyparkins@gmail.com
Subject: (unknown)
Date: Wed, 25 Oct 2006 15:49:35 +0100
Message-ID: <E1Gck4V-0003If-00@dvr.360vision.com>
NNTP-Posting-Date: Wed, 25 Oct 2006 14:49:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-OriginalArrivalTime: 25 Oct 2006 14:52:35.0411 (UTC) FILETIME=[351C3230:01C6F845]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30060>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gck4b-0006Xt-AM for gcvg-git@gmane.org; Wed, 25 Oct
 2006 16:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932251AbWJYOth (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 10:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWJYOth
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 10:49:37 -0400
Received: from mail.360visiontechnology.com ([194.70.53.226]:47895 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S932251AbWJYOth
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 10:49:37 -0400
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Wed, 25 Oct 2006 15:52:35 +0100
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1Gck4V-0003If-00 for <git@vger.kernel.org>; Wed, 25 Oct
 2006 15:49:35 +0100
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org

From cf13955d13b8b6a86dd1f6340565e16500b3cf38 Mon Sep 17 00:00:00 2001
From: Andy Parkins <andyparkins@gmail.com>
Date: Wed, 25 Oct 2006 15:49:34 +0100
Subject: [PATCH] Minor grammar fixes for git-diff-index.txt
To: git@vger.kernel.org
X-TUID: c63a7eaedc72a5ce
X-UID: 129
X-Length: 2247
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610251549.34193.andyparkins@gmail.com>

"what you are going to commit is" doesn't need the "is" and does need a comma.

"can trivially see" is an unecessary split infinitive and "easily" is a more
appropriate adverb.

"case where you" should be "case were you" as it's the past tense form of the
verb "to be", rather than a location (I think :-) ).
Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 Documentation/git-diff-index.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-diff-index.txt 
b/Documentation/git-diff-index.txt
index 9cd43f1..ad1e903 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -54,7 +54,7 @@ If '--cached' is specified, it allows yo
 
 For example, let's say that you have worked on your working directory, 
updated
 some files in the index and are ready to commit. You want to see exactly
-*what* you are going to commit is without having to write a new tree
+*what* you are going to commit, without having to write a new tree
 object and compare it that way, and to do that, you just do
 
 	git-diff-index --cached HEAD
@@ -68,11 +68,11 @@ matches my working directory. But doing 
   -100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        commit.c
   +100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        
git-commit.c
 
-You can trivially see that the above is a rename.
+You can see easily that the above is a rename.
 
 In fact, "git-diff-index --cached" *should* always be entirely equivalent to
 actually doing a "git-write-tree" and comparing that. Except this one is much
-nicer for the case where you just want to check where you are.
+nicer for the case were you just want to check where you are.
 
 So doing a "git-diff-index --cached" is basically very useful when you are
 asking yourself "what have I already marked for being committed, and 
-- 
1.4.2.3

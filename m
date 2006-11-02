X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Minor grammar fixes for git-diff-index.txt
Date: Thu, 2 Nov 2006 12:12:44 +0100
Message-ID: <200611021112.45057.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 11:12:58 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: eae09e7c5d2310ec
X-UID: 146
X-Length: 1686
Content-Disposition: inline
X-OriginalArrivalTime: 02 Nov 2006 11:13:51.0530 (UTC) FILETIME=[F9F8E0A0:01C6FE6F]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30727>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaV9-0004Fv-Bt for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752847AbWKBLMs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbWKBLMs
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:12:48 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:19814 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S1752847AbWKBLMs
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:12:48 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 2 Nov 2006 11:13:51 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GfaV4-0003xU-00 for <git@vger.kernel.org>; Thu, 02 Nov
 2006 11:12:46 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

"what you are going to commit is" doesn't need the "is" and does need a comma.

"can trivially see" is an unecessary split infinitive and "easily" is a more
appropriate adverb.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 Documentation/git-diff-index.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 9cd43f1..2df581c 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -54,7 +54,7 @@ If '--cached' is specified, it allows yo
 
 For example, let's say that you have worked on your working directory, updated
 some files in the index and are ready to commit. You want to see exactly
-*what* you are going to commit is without having to write a new tree
+*what* you are going to commit, without having to write a new tree
 object and compare it that way, and to do that, you just do
 
 	git-diff-index --cached HEAD
@@ -68,7 +68,7 @@ matches my working directory. But doing
   -100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        commit.c
   +100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        git-commit.c
 
-You can trivially see that the above is a rename.
+You can see easily that the above is a rename.
 
 In fact, "git-diff-index --cached" *should* always be entirely equivalent to
 actually doing a "git-write-tree" and comparing that. Except this one is much
-- 
1.4.3.2

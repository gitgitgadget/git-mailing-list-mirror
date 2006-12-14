X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Cleanup git-diff documentation
Date: Thu, 14 Dec 2006 07:32:56 -0500
Message-ID: <9A80051B-1F6B-4FFD-B33F-84121D3A422F@silverinsanity.com>
References: <7vr6v2aofs.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612140957590.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 12:33:11 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612140957590.3635@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34331>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guplq-00057k-PQ for gcvg-git@gmane.org; Thu, 14 Dec
 2006 13:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932693AbWLNMdD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 07:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWLNMdD
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 07:33:03 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:50148 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932693AbWLNMdB (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 07:33:01 -0500
Received: from [IPv6???1] (localhost [127.0.0.1]) (using TLSv1 with cipher
 AES128-SHA (128/128 bits)) (No client certificate requested) by
 silverinsanity.com (Postfix) with ESMTP id E06ED1FFCECA; Thu, 14 Dec 2006
 12:32:59 +0000 (UTC)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

There were a couple inconsistencies in the formatting of the command
descriptions and a more descriptive initial description is better.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

I agree with Johannes about the original being clearer.  Plus two of
the command examples were missing brackets around -- and one had a
* at the beginning the others didn't.  This patch is against Junio's
changes made on master (1d770), even though his patch didn't apply
cleanly.

Documentation/git-diff.txt |   11 +++++++----
1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 534f824..2ba9145 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -12,7 +12,10 @@ SYNOPSIS
DESCRIPTION
-----------
-This command shows changes between four combinations of states.
+Show changes between two trees, a tree and the working tree, a
+tree and the index file, or the index file and the working tree.
+The combination of what is compared with what is determined by
+the number of trees given to the command.
'git-diff' [--options] [--] [<path>...]::
@@ -25,11 +28,11 @@ This command shows changes between four  
combinations of states.
'git-diff' [--options] --cached [<commit>] [--] [<path>...]::
	This form is to view the changes you staged for the next
-	commit relative to the named <tree-ish>.  Typically you
+	commit relative to the named <commit>.  Typically you
	would want comparison with the latest commit, so if you
	do not give <commit>, it defaults to HEAD.
-'git-diff' [--options] <commit> -- [<path>...]::
+'git-diff' [--options] <commit> [--] [<path>...]::
	This form is to view the changes you have in your
	working tree relative to the named <commit>.  You can
@@ -37,7 +40,7 @@ This command shows changes between four  
combinations of states.
	branch name to compare with the tip of a different
	branch.
-* 'git-diff' [--options] <commit> <commit> -- [<path>...]
+'git-diff' [--options] <commit> <commit> [--] [<path>...]
	This form is to view the changes between two <commit>,
	for example, tips of two branches.
--

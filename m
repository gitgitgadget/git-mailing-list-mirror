X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] shortlog: use pager
Date: Tue, 28 Nov 2006 00:29:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611280027320.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 27 Nov 2006 23:29:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32459>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gopui-0007Ez-UH for gcvg-git@gmane.org; Tue, 28 Nov
 2006 00:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758570AbWK0X3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 18:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758606AbWK0X3Z
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 18:29:25 -0500
Received: from mail.gmx.de ([213.165.64.20]:20135 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758570AbWK0X3Y (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 18:29:24 -0500
Received: (qmail invoked by alias); 27 Nov 2006 23:29:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp018) with SMTP; 28 Nov 2006 00:29:22 +0100
To: git@vger.kernel.org, torvalds@osdl.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


On request of the kingpenguin, shortlog now uses the pager if output
goes to a tty.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 9bcb17c..63a4747 100644
--- a/git.c
+++ b/git.c
@@ -265,7 +265,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "runstatus", cmd_runstatus, RUN_SETUP },
-		{ "shortlog", cmd_shortlog, RUN_SETUP },
+		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "stripspace", cmd_stripspace },
-- 
1.4.4.1.ga3a78-dirty

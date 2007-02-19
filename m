From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git grep: use pager
Date: Mon, 19 Feb 2007 15:56:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702191555400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Feb 19 15:56:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ9wU-0008Ht-DD
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 15:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbXBSO4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 09:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbXBSO4H
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 09:56:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:40431 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932325AbXBSO4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 09:56:05 -0500
Received: (qmail invoked by alias); 19 Feb 2007 14:56:04 -0000
X-Provags-ID: V01U2FsdGVkX19hkQ8qM/dhAZBb9Q6zUkzL+7OPZnPYGl5iPqnsx/
	qiLg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40129>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index a8fdae3..395a054 100644
--- a/git.c
+++ b/git.c
@@ -259,7 +259,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "fsck", cmd_fsck, RUN_SETUP },
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
-		{ "grep", cmd_grep, RUN_SETUP },
+		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
 		{ "help", cmd_help },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
-- 
1.5.0.1.2138.g7274

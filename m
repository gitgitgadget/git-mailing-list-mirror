From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] annotate: use pager
Date: Wed, 24 Jan 2007 15:04:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241504030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jan 24 15:04:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9ik6-0001ZG-V1
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 15:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbXAXOEk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 09:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbXAXOEk
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 09:04:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:33213 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751401AbXAXOEj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 09:04:39 -0500
Received: (qmail invoked by alias); 24 Jan 2007 14:04:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 24 Jan 2007 15:04:38 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37638>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 1ea2c5b..0a9476c 100644
--- a/git.c
+++ b/git.c
@@ -219,7 +219,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		int option;
 	} commands[] = {
 		{ "add", cmd_add, RUN_SETUP | NOT_BARE },
-		{ "annotate", cmd_annotate, },
+		{ "annotate", cmd_annotate, USE_PAGER },
 		{ "apply", cmd_apply },
 		{ "archive", cmd_archive },
 		{ "blame", cmd_blame, RUN_SETUP | USE_PAGER },
-- 
1.5.0.rc2.g8b13f-dirty

From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH 2/3] Update git(7) man-page for the C wrapper.
Date: Wed, 16 Nov 2005 00:31:25 +0100 (CET)
Message-ID: <20051115233125.251595BFA0@nox.op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 16 00:32:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcAH3-0003qm-7a
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 00:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbVKOXb1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 18:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbVKOXb1
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 18:31:27 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:62904 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932572AbVKOXb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 18:31:26 -0500
Received: from vrrx50sn1.teliamobile.net (192.71.148.196) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 4378EBDA0007609A for git@vger.kernel.org; Wed, 16 Nov 2005 00:31:25 +0100
Received: from nox.op5.se (host-n13-90.homerun.telia.com [212.181.228.90])
	by vrrx50sn1.teliamobile.net (8.11.6/8.11.6) with ESMTP id jAFNVPf24369
	for <git@vger.kernel.org>; Wed, 16 Nov 2005 00:31:25 +0100
Received: by nox.op5.se (Postfix, from userid 500)
	id 251595BFA0; Wed, 16 Nov 2005 00:31:25 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11964>


The program 'git' now has --exec-path which needs explaining.

Renamed old "DESCRIPTION" to "CORE GIT COMMANDS" to make room for
"OPTIONS" while following follow some sort of convention.

Also updated AUTHORS section to pat my own back a bit.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Documentation/git.txt |   33 +++++++++++++++++++++++++++------
 1 files changed, 27 insertions(+), 6 deletions(-)

applies-to: 5b537267ba1593d4eb92f9bc09d32c14fb7e2faf
e743bc1a48f15533ae9cd2f450106be96516d037
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7045f3f..91e9f9f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -8,13 +8,31 @@ git - the stupid content tracker
 
 SYNOPSIS
 --------
-'git-<command>' <args>
+'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND [ARGS]
 
 DESCRIPTION
 -----------
+'git' is both a program and a directory content tracker system.
+The program 'git' is just a wrapper to reach the core git programs
+(or a potty if you like, as it's not exactly porcelain but still
+brings your stuff to the plumbing).
+
+OPTIONS
+-------
+--version::
+	prints the git suite version that the 'git' program came from.
+
+--help::
+	prints the synopsis and a list of available commands.
+
+--exec-path::
+	path to wherever your core git programs are installed.
+	This can also be controlled by setting the GIT_EXEC_PATH
+	environment variable. If no path is given 'git' will print
+	the current setting and then exit.
 
-This is reference information for the core git commands.
-
+CORE GIT COMMANDS
+-----------------
 Before reading this cover to cover, you may want to take a look
 at the link:tutorial.html[tutorial] document.
 
@@ -533,9 +551,12 @@ Discussion[[Discussion]]
 ------------------------
 include::../README[]
 
-Author
-------
-Written by Linus Torvalds <torvalds@osdl.org> and the git-list <git@vger.kernel.org>.
+Authors
+-------
+	git's founding father is Linus Torvalds <torvalds@osdl.org>.
+	The current git nurse is Junio C. Hamano <junkio@cox.net>.
+	The git potty was written by Andres Ericsson <ae@op5.se>.
+	General upbringing is handled by the git-list <git@vger.kernel.org>.
 
 Documentation
 --------------
---
0.99.9.GIT

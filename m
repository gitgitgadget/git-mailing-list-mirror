From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: rename "hooks.txt" to "githooks.txt" and
 make it a man page
Date: Wed, 30 Apr 2008 23:11:53 +0200
Message-ID: <20080430231153.113a75cd.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 23:07:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrJWg-0006pf-Ja
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 23:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853AbYD3VGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 17:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756100AbYD3VGx
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 17:06:53 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:45455 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754394AbYD3VGw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 17:06:52 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 16B161AB2A9;
	Wed, 30 Apr 2008 23:06:51 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id B5E6C1AB2E1;
	Wed, 30 Apr 2008 23:06:49 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80872>

Also now "gitcli(5)" becomes "gitcli(7)".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/Makefile                    |    5 ++---
 Documentation/gitcli.txt                  |    2 +-
 Documentation/{hooks.txt => githooks.txt} |   20 ++++++++++++++++++--
 3 files changed, 21 insertions(+), 6 deletions(-)
 rename Documentation/{hooks.txt => githooks.txt} (98%)

	Here is a patch made with "git format-patch -M ..."

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 43781fb..4144d1e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -2,8 +2,8 @@ MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt)) \
 	gitk.txt
-MAN5_TXT=gitattributes.txt gitignore.txt gitcli.txt gitmodules.txt
-MAN7_TXT=git.txt
+MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt
+MAN7_TXT=git.txt gitcli.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
@@ -18,7 +18,6 @@ ARTICLES += cvs-migration
 ARTICLES += diffcore
 ARTICLES += howto-index
 ARTICLES += repository-layout
-ARTICLES += hooks
 ARTICLES += everyday
 ARTICLES += git-tools
 ARTICLES += glossary
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 7ee5ce3..835cb05 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -1,4 +1,4 @@
-gitcli(5)
+gitcli(7)
 =========
 
 NAME
diff --git a/Documentation/hooks.txt b/Documentation/githooks.txt
similarity index 98%
rename from Documentation/hooks.txt
rename to Documentation/githooks.txt
index 44fbe58..62ee065 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/githooks.txt
@@ -1,5 +1,17 @@
-Hooks used by git
-=================
+githooks(5)
+===========
+
+NAME
+----
+githooks - Hooks used by git
+
+SYNOPSIS
+--------
+$GIT_DIR/hooks/*
+
+
+DESCRIPTION
+-----------
 
 Hooks are little scripts you can place in `$GIT_DIR/hooks`
 directory to trigger action at certain points.  When
@@ -283,3 +295,7 @@ pre-auto-gc
 This hook is invoked by `git-gc --auto`. It takes no parameter, and
 exiting with non-zero status from this script causes the `git-gc --auto`
 to abort.
+
+GIT
+---
+Part of the linkgit:git[7] suite
-- 
1.5.5.1.100.gc23d

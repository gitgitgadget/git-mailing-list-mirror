From: "Asgeir S. Nilsen" <asgeir@twingine.no>
Subject: [PATCH] contrib: Replaced /bin/sh with /bin/bash to make scripts with Bash syntax work on Solaris.
Date: Fri,  6 Aug 2010 14:56:05 +0200
Message-ID: <1281099365-11978-1-git-send-email-asgeir@twingine.no>
Cc: "Asgeir S. Nilsen" <asgeir@twingine.no>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 06 15:29:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhMzD-0005f0-6a
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 15:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761319Ab0HFN3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 09:29:16 -0400
Received: from asav3.lyse.net ([81.167.37.131]:40147 "EHLO asav3.lyse.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756334Ab0HFN3O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 09:29:14 -0400
X-Greylist: delayed 1976 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Aug 2010 09:29:14 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by asav3.lyse.net (Postfix) with ESMTP id E06038403A;
	Fri,  6 Aug 2010 14:56:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at lyse.net
Received: from debian.twingine.no (231.81-166-234.customer.lyse.net [81.166.234.231])
	by asav3.lyse.net (Postfix) with ESMTP id AB9868407F;
	Fri,  6 Aug 2010 14:56:16 +0200 (CEST)
X-Mailer: git-send-email 1.7.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152778>

Signed-off-by: Asgeir S. Nilsen <asgeir@twingine.no>
---
 contrib/ciabot/ciabot.sh           |    2 +-
 contrib/examples/git-checkout.sh   |    2 +-
 contrib/examples/git-clean.sh      |    2 +-
 contrib/examples/git-clone.sh      |    2 +-
 contrib/examples/git-commit.sh     |    2 +-
 contrib/examples/git-fetch.sh      |    2 +-
 contrib/examples/git-gc.sh         |    2 +-
 contrib/examples/git-ls-remote.sh  |    2 +-
 contrib/examples/git-merge.sh      |    2 +-
 contrib/examples/git-notes.sh      |    2 +-
 contrib/examples/git-reset.sh      |    2 +-
 contrib/examples/git-resolve.sh    |    2 +-
 contrib/examples/git-revert.sh     |    2 +-
 contrib/examples/git-tag.sh        |    2 +-
 contrib/examples/git-verify-tag.sh |    2 +-
 contrib/fast-import/git-import.sh  |    2 +-
 contrib/git-resurrect.sh           |    2 +-
 contrib/hooks/post-receive-email   |    2 +-
 contrib/hooks/pre-auto-gc-battery  |    2 +-
 contrib/remotes2config.sh          |    2 +-
 contrib/rerere-train.sh            |    2 +-
 contrib/workdir/git-new-workdir    |    2 +-
 22 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/contrib/ciabot/ciabot.sh b/contrib/ciabot/ciabot.sh
index eb87bba..d3f5ded 100755
--- a/contrib/ciabot/ciabot.sh
+++ b/contrib/ciabot/ciabot.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Distributed under the terms of the GNU General Public License v2
 # Copyright (c) 2006 Fernando J. Pereda <ferdy@gentoo.org>
 # Copyright (c) 2008 Natanael Copa <natanael.copa@gmail.com>
diff --git a/contrib/examples/git-checkout.sh b/contrib/examples/git-checkout.sh
index 1a7689a..5130736 100755
--- a/contrib/examples/git-checkout.sh
+++ b/contrib/examples/git-checkout.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 OPTIONS_KEEPDASHDASH=t
 OPTIONS_SPEC="\
diff --git a/contrib/examples/git-clean.sh b/contrib/examples/git-clean.sh
index 01c95e9..e75bfc2 100755
--- a/contrib/examples/git-clean.sh
+++ b/contrib/examples/git-clean.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # Copyright (c) 2005-2006 Pavel Roskin
 #
diff --git a/contrib/examples/git-clone.sh b/contrib/examples/git-clone.sh
index 547228e..2287f14 100755
--- a/contrib/examples/git-clone.sh
+++ b/contrib/examples/git-clone.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # Copyright (c) 2005, Linus Torvalds
 # Copyright (c) 2005, Junio C Hamano
diff --git a/contrib/examples/git-commit.sh b/contrib/examples/git-commit.sh
index 5c72f65..ccc0497 100755
--- a/contrib/examples/git-commit.sh
+++ b/contrib/examples/git-commit.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2006 Junio C Hamano
diff --git a/contrib/examples/git-fetch.sh b/contrib/examples/git-fetch.sh
index a314273..285f155 100755
--- a/contrib/examples/git-fetch.sh
+++ b/contrib/examples/git-fetch.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 
 USAGE='<fetch-options> <repository> <refspec>...'
diff --git a/contrib/examples/git-gc.sh b/contrib/examples/git-gc.sh
index 1597e9f..8c32571 100755
--- a/contrib/examples/git-gc.sh
+++ b/contrib/examples/git-gc.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # Copyright (c) 2006, Shawn O. Pearce
 #
diff --git a/contrib/examples/git-ls-remote.sh b/contrib/examples/git-ls-remote.sh
index fec70bb..c6fea33 100755
--- a/contrib/examples/git-ls-remote.sh
+++ b/contrib/examples/git-ls-remote.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 
 usage () {
diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index 8f617fc..1b8c611 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # Copyright (c) 2005 Junio C Hamano
 #
diff --git a/contrib/examples/git-notes.sh b/contrib/examples/git-notes.sh
index e642e47..b4932e3 100755
--- a/contrib/examples/git-notes.sh
+++ b/contrib/examples/git-notes.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 USAGE="(edit [-F <file> | -m <msg>] | show) [commit]"
 . git-sh-setup
diff --git a/contrib/examples/git-reset.sh b/contrib/examples/git-reset.sh
index bafeb52..fc4b0f1 100755
--- a/contrib/examples/git-reset.sh
+++ b/contrib/examples/git-reset.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
 #
diff --git a/contrib/examples/git-resolve.sh b/contrib/examples/git-resolve.sh
index 8f98142..7606065 100755
--- a/contrib/examples/git-resolve.sh
+++ b/contrib/examples/git-resolve.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # Copyright (c) 2005 Linus Torvalds
 #
diff --git a/contrib/examples/git-revert.sh b/contrib/examples/git-revert.sh
index 49f0032..dcd085a 100755
--- a/contrib/examples/git-revert.sh
+++ b/contrib/examples/git-revert.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2005 Junio C Hamano
diff --git a/contrib/examples/git-tag.sh b/contrib/examples/git-tag.sh
index 2c15bc9..194bd52 100755
--- a/contrib/examples/git-tag.sh
+++ b/contrib/examples/git-tag.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Copyright (c) 2005 Linus Torvalds
 
 USAGE='[-n [<num>]] -l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg>] <tagname> [<head>]'
diff --git a/contrib/examples/git-verify-tag.sh b/contrib/examples/git-verify-tag.sh
index 0902a5c..fbe94fd 100755
--- a/contrib/examples/git-verify-tag.sh
+++ b/contrib/examples/git-verify-tag.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 USAGE='<tag>'
 SUBDIRECTORY_OK='Yes'
diff --git a/contrib/fast-import/git-import.sh b/contrib/fast-import/git-import.sh
index 0ca7718..0723c69 100755
--- a/contrib/fast-import/git-import.sh
+++ b/contrib/fast-import/git-import.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # Performs an initial import of a directory. This is the equivalent
 # of doing 'git init; git add .; git commit'. It's a lot slower,
diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
index a4ed4c3..599d807 100755
--- a/contrib/git-resurrect.sh
+++ b/contrib/git-resurrect.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 USAGE="[-a] [-r] [-m] [-t] [-n] [-b <newname>] <name>"
 LONG_USAGE="git-resurrect attempts to find traces of a branch tip
diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 30ae63d..dc58d64 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # Copyright (c) 2007 Andy Parkins
 #
diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto-gc-battery
index 1f914c9..bbf0aa9 100644
--- a/contrib/hooks/pre-auto-gc-battery
+++ b/contrib/hooks/pre-auto-gc-battery
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # An example hook script to verify if you are on battery, in case you
 # are running Linux or OS X. Called by git-gc --auto with no arguments.
diff --git a/contrib/remotes2config.sh b/contrib/remotes2config.sh
index 1cda19f..ed4aaf9 100755
--- a/contrib/remotes2config.sh
+++ b/contrib/remotes2config.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 # Use this tool to rewrite your .git/remotes/ files into the config.
 
diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
index 2cfe1b9..654aec4 100755
--- a/contrib/rerere-train.sh
+++ b/contrib/rerere-train.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Copyright (c) 2008, Nanako Shiraishi
 # Prime rerere database from existing merge commits
 
diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 993cacf..a84c7ad 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 usage () {
 	echo "usage:" $@
-- 
1.7.2.1

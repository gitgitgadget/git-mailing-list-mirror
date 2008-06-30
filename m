From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 5/7] Documentation: prepare to be consistent about "git-"
 versus "git "
Date: Mon, 30 Jun 2008 17:17:07 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0806301716150.7190@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 00:18:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDRhS-0007BI-At
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763512AbYF3WRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763187AbYF3WRU
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:17:20 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:47776 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762544AbYF3WRS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:17:18 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m5UMH8io024592;
	Mon, 30 Jun 2008 17:17:08 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m5UMH7sb008122;
	Mon, 30 Jun 2008 17:17:07 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86948>

With the dashed forms of git commands not in $(bindir), we have
to change many instances of "git-command" to "git command". Also,
for consistency it is at times appropriate to make the opposite
change. In some cases, the change is not so simple as changing one
character.

This patch gets rid of some of those cases by rewrapping lines.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/git-mailinfo.txt         |    4 ++--
 Documentation/git-tag.txt              |    4 ++--
 Documentation/gitrepository-layout.txt |    8 ++++----
 Documentation/gittutorial.txt          |    4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 183dc1d..6a73b73 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -29,8 +29,8 @@ OPTIONS
 	among which (1) remove 'Re:' or 're:', (2) leading
 	whitespaces, (3) '[' up to ']', typically '[PATCH]', and
 	then prepends "[PATCH] ".  This flag forbids this
-	munging, and is most useful when used to read back 'git
-	format-patch -k' output.
+	munging, and is most useful when used to read back
+	'git format-patch -k' output.
 
 -u::
 	The commit log message, author name and author email are
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 8f40f4b..0c41711 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -122,8 +122,8 @@ others have already seen the old one. So just use "git tag -f"
 again, as if you hadn't already published the old one.
 
 However, Git does *not* (and it should not) change tags behind
-users back. So if somebody already got the old tag, doing a "git
-pull" on your tree shouldn't just make them overwrite the old
+users back. So if somebody already got the old tag, doing a
+"git pull" on your tree shouldn't just make them overwrite the old
 one.
 
 If somebody got a release tag from you, you cannot just change
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index b75508a..2afc5a3 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -167,14 +167,14 @@ info/grafts::
 info/exclude::
 	This file, by convention among Porcelains, stores the
 	exclude pattern list. `.gitignore` is the per-directory
-	ignore file.  `git status`, `git add`, `git rm` and `git
-	clean` look at it but the core git commands do not look
+	ignore file.  `git status`, `git add`, `git rm` and
+	`git clean` look at it but the core git commands do not look
 	at it.  See also: linkgit:gitignore[5].
 
 remotes::
 	Stores shorthands to be used to give URL and default
-	refnames to interact with remote repository to `git
-	fetch`, `git pull` and `git push` commands.
+	refnames to interact with remote repository to
+	`git fetch`, `git pull` and `git push` commands.
 
 logs::
 	Records of changes made to refs are stored in this
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index b833167..144bacd 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -19,8 +19,8 @@ If you are instead primarily interested in using git to fetch a project,
 for example, to test the latest version, you may prefer to start with
 the first two chapters of link:user-manual.html[The Git User's Manual].
 
-First, note that you can get documentation for a command such as "git
-log --graph" with:
+First, note that you can get documentation for a command such as
+"git log --graph" with:
 
 ------------------------------------------------
 $ man git-log
-- 
1.5.5.GIT

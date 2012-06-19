From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Documentation: spelling fixes
Date: Tue, 19 Jun 2012 19:56:09 +0200
Message-ID: <20120619175608.GK1299@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 19 19:55:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh2dr-0001nZ-ST
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 19:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab2FSRy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 13:54:58 -0400
Received: from cantor2.suse.de ([195.135.220.15]:44267 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430Ab2FSRy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 13:54:58 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id B1BAAA3E1C;
	Tue, 19 Jun 2012 19:54:56 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200215>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/diff-config.txt     |    2 +-
 Documentation/git-column.txt      |    2 +-
 Documentation/git-commit-tree.txt |    2 +-
 Documentation/git.txt             |    2 +-
 Documentation/gitweb.conf.txt     |    2 +-
 Documentation/user-manual.txt     |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 6aa1be0..67a90a8 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -54,7 +54,7 @@ and accumulating child directory counts in the parent directories:
 
 diff.statGraphWidth::
 	Limit the width of the graph part in --stat output. If set, applies
-	to all commands generating --stat outuput except format-patch.
+	to all commands generating --stat output except format-patch.
 
 diff.external::
 	If this config variable is set, diff generation is not
diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
index 9be16ee..5d6f1cc 100644
--- a/Documentation/git-column.txt
+++ b/Documentation/git-column.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git column' [--command=<name>] [--[raw-]mode=<mode>] [--width=<width>]
-	     [--indent=<string>] [--nl=<string>] [--pading=<n>]
+	     [--indent=<string>] [--nl=<string>] [--padding=<n>]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index eb8ee99..6d5a04c 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -45,7 +45,7 @@ OPTIONS
 	Each '-p' indicates the id of a parent commit object.
 
 -m <message>::
-	A paragraph in the commig log message. This can be given more than
+	A paragraph in the commit log message. This can be given more than
 	once and each <message> becomes its own paragraph.
 
 -F <file>::
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 59ce6ac..9589734 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -734,7 +734,7 @@ other
 
 'GIT_EDITOR'::
 	This environment variable overrides `$EDITOR` and `$VISUAL`.
-	It is used by several git comands when, on interactive mode,
+	It is used by several git commands when, on interactive mode,
 	an editor is to be launched. See also linkgit:git-var[1]
 	and the `core.editor` option in linkgit:git-config[1].
 
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index b9dd567..4947455 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -244,7 +244,7 @@ $highlight_bin::
 	By default set to 'highlight'; set it to full path to highlight
 	executable if it is not installed on your web server's PATH.
 	Note that 'highlight' feature must be set for gitweb to actually
-	use syntax hightlighting.
+	use syntax highlighting.
 +
 *NOTE*: if you want to add support for new file type (supported by
 "highlight" but not used by gitweb), you need to modify `%highlight_ext`
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1b94207..02ed566 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1600,7 +1600,7 @@ dangling tree b24c2473f1fd3d91352a624795be026d64c8841f
 You will see informational messages on dangling objects. They are objects
 that still exist in the repository but are no longer referenced by any of
 your branches, and can (and will) be removed after a while with "gc".
-You can run `git fsck --no-dangling` to supress these messages, and still
+You can run `git fsck --no-dangling` to suppress these messages, and still
 view real errors.
 
 [[recovering-lost-changes]]
-- 
1.7.8.2

From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 10/15] manpages: italicize command names
Date: Thu, 3 Jul 2008 00:37:18 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807030036120.16085@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jon Loeliger <jdl@jdl.com>, Dan McGee <dpmcgee@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Olivier Marin <dkr+ml.git@free.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 09:02:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEIpk-0003HF-DT
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 09:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621AbYGCG7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091AbYGCG6G
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:58:06 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:45387 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842AbYGCFhv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 01:37:51 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m635bICk023348;
	Thu, 3 Jul 2008 00:37:19 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m635bI7L019173;
	Thu, 3 Jul 2008 00:37:18 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87232>

This includes nongit commands like RCS 'merge'.  This patch only
italicizes names of commands if they had no formatting before.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
	The escaping under "log.date" in config.txt works for me
	with asciidoc 8.2.6 and ASCIIDOC8=YesPlease.  Will it work
	on asciidoc 7?

 Documentation/config.txt          |    4 ++--
 Documentation/git-apply.txt       |    6 +++---
 Documentation/git-merge-file.txt  |    2 +-
 Documentation/git-merge-index.txt |    2 +-
 Documentation/git-rerere.txt      |    4 ++--
 Documentation/gitdiffcore.txt     |    4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5a98a5b..84a0e77 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -568,7 +568,7 @@ diff.external::
 
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
-	detection; equivalent to the git-diff option '-l'.
+	detection; equivalent to the 'git-diff' option '-l'.
 
 diff.renames::
 	Tells git to detect renames.  If set to any boolean value, it
@@ -849,7 +849,7 @@ instaweb.port::
 
 log.date::
 	Set default date-time mode for the log command. Setting log.date
-	value is similar to using git-log's --date option. The value is one of the
+	value is similar to using 'git-log'\'s --date option. The value is one of the
 	following alternatives: {relative,local,default,iso,rfc,short}.
 	See linkgit:git-log[1].
 
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index fbe1130..b2f909d 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads supplied diff output and applies it on a git index file
+Reads supplied 'diff' output and applies it on a git index file
 and a work tree.
 
 OPTIONS
@@ -165,9 +165,9 @@ behavior:
 * `error-all` is similar to `error` but shows all errors.
 
 --inaccurate-eof::
-	Under certain circumstances, some versions of diff do not correctly
+	Under certain circumstances, some versions of 'diff' do not correctly
 	detect a missing new-line at the end of the file. As a result, patches
-	created by such diff programs do not record incomplete lines
+	created by such 'diff' programs do not record incomplete lines
 	correctly. This option adds support for applying such patches by
 	working around this bug.
 
diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index 2a033dd..b5eb630 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -93,7 +93,7 @@ Written by Johannes Schindelin <johannes.schindelin@gmx.de>
 Documentation
 --------------
 Documentation by Johannes Schindelin and the git-list <git@vger.kernel.org>,
-with parts copied from the original documentation of RCS merge.
+with parts copied from the original documentation of RCS 'merge'.
 
 GIT
 ---
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 4368084..4f04bbb 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -41,7 +41,7 @@ processes them in turn only stopping if merge returns a non-zero exit
 code.
 
 Typically this is run with a script calling git's imitation of
-the merge command from the RCS package.
+the 'merge' command from the RCS package.
 
 A sample script called `git-merge-one-file` is included in the
 distribution.
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index ae2b2b5..30ec68d 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -7,7 +7,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
 
 SYNOPSIS
 --------
-'git rerere' [clear|diff|status|gc]
+'git rerere' ['clear'|'diff'|'status'|'gc']
 
 DESCRIPTION
 -----------
@@ -49,7 +49,7 @@ conflicts.  Additional arguments are passed directly to the system
 
 'status'::
 
-Like diff, but this only prints the filenames that will be tracked
+Like 'diff', but this only prints the filenames that will be tracked
 for resolutions.
 
 'gc'::
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 1171b5c..949332b 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -7,7 +7,7 @@ gitdiffcore - Tweaking diff output (June 2005)
 
 SYNOPSIS
 --------
-git diff *
+'git diff' *
 
 DESCRIPTION
 -----------
@@ -16,7 +16,7 @@ The diff commands `git-diff-index`, `git-diff-files`, and `git-diff-tree`
 can be told to manipulate differences they find in
 unconventional ways before showing `diff` output.  The manipulation
 is collectively called "diffcore transformation".  This short note
-describes what they are and how to use them to produce diff output
+describes what they are and how to use them to produce 'diff' output
 that is easier to understand than the conventional kind.
 
 
-- 
1.5.5.GIT

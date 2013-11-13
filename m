From: "Jason St. John" <jstjohn@purdue.edu>
Subject: [PATCH 2/2] Fix minor grammatical and other formatting issues in the "git log" man page
Date: Wed, 13 Nov 2013 01:21:49 -0500
Message-ID: <1384323709-2690-2-git-send-email-jstjohn@purdue.edu>
References: <1384323709-2690-1-git-send-email-jstjohn@purdue.edu>
Cc: "Jason St. John" <jstjohn@purdue.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 13 07:22:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgTq3-0003Oj-Fy
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 07:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758329Ab3KMGWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 01:22:01 -0500
Received: from mailhub129.itcs.purdue.edu ([128.210.5.129]:51741 "EHLO
	mailhub129.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758223Ab3KMGV7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Nov 2013 01:21:59 -0500
Received: from megahurtz.itap.purdue.edu (pal-nat184-041-152.itap.purdue.edu [10.184.41.152])
	(authenticated bits=0)
	by mailhub129.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id rAD6Lpd5006447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 13 Nov 2013 01:21:58 -0500
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1384323709-2690-1-git-send-email-jstjohn@purdue.edu>
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237777>

Documentation/git-log.txt:
-- replace single quotes around options/commands with backticks
-- use single quotes around references to sections
-- replaced some double quotes with proper AsciiDoc quotes (e.g.
     ``foo'')
-- use backticks around files and file paths
-- use title case when referring to section headings
-- use backticks around option arguments/defaults

Signed-off-by: Jason St. John <jstjohn@purdue.edu>
---
When working on this commit, I noticed a difference in how options and
option descriptions are separated (e.g. with a blank line or not). At least
with Vim's syntax highlighting, if there is a blank line between the option
and its description, the text block is all colored the same; however, if
there isn't a blank line, then the text block is not specially colored.

Is there an existing convention for how this should be done?


 Documentation/git-log.txt | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index a5de513..1f7bc67 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -15,9 +15,9 @@ DESCRIPTION
 -----------
 Shows the commit logs.
 
-The command takes options applicable to the 'git rev-list'
+The command takes options applicable to the `git rev-list`
 command to control what is shown and how, and options applicable to
-the 'git diff-*' commands to control how the changes
+the `git diff-*` commands to control how the changes
 each commit introduces are shown.
 
 
@@ -42,21 +42,20 @@ OPTIONS
 
 --use-mailmap::
 	Use mailmap file to map author and committer names and email
-	to canonical real names and email addresses. See
+	addresses to canonical real names and email addresses. See
 	linkgit:git-shortlog[1].
 
 --full-diff::
-	Without this flag, "git log -p <path>..." shows commits that
+	Without this flag, `git log -p <path>...` shows commits that
 	touch the specified paths, and diffs about the same specified
 	paths.  With this, the full diff is shown for commits that touch
 	the specified paths; this means that "<path>..." limits only
 	commits, and doesn't limit diff for those commits.
 +
 Note that this affects all diff-based output types, e.g. those
-produced by --stat etc.
+produced by `--stat`, etc.
 
 --log-size::
-
 	Include a line ``log size <number>'' in the output for each commit,
 	where <number> is the length of that commit's message in bytes.
 	Intended to speed up tools that read log messages from `git log`
@@ -64,7 +63,6 @@ produced by --stat etc.
 
 -L <start>,<end>:<file>::
 -L :<regex>:<file>::
-
 	Trace the evolution of the line range given by "<start>,<end>"
 	(or the funcname regex <regex>) within the <file>.  You may
 	not give any pathspec limiters.  This is currently limited to
@@ -80,16 +78,16 @@ include::line-range-format.txt[]
 	whole history leading to the current commit).  `origin..HEAD`
 	specifies all the commits reachable from the current commit
 	(i.e. `HEAD`), but not from `origin`. For a complete list of
-	ways to spell <revision range>, see the "Specifying Ranges"
+	ways to spell <revision range>, see the 'Specifying Ranges'
 	section of linkgit:gitrevisions[7].
 
 [\--] <path>...::
 	Show only commits that are enough to explain how the files
-	that match the specified paths came to be.  See "History
-	Simplification" below for details and other simplification
+	that match the specified paths came to be.  See 'History
+	Simplification' below for details and other simplification
 	modes.
 +
-Paths may need to be prefixed with "\-- " to separate them from
+Paths may need to be prefixed with ``\-- '' to separate them from
 options or the revision range, when confusion arises.
 
 include::rev-list-options.txt[]
@@ -113,12 +111,12 @@ EXAMPLES
 `git log v2.6.12.. include/scsi drivers/scsi`::
 
 	Show all commits since version 'v2.6.12' that changed any file
-	in the include/scsi or drivers/scsi subdirectories
+	in the `include/scsi` or `drivers/scsi` subdirectories
 
 `git log --since="2 weeks ago" -- gitk`::
 
 	Show the changes during the last two weeks to the file 'gitk'.
-	The "--" is necessary to avoid confusion with the *branch* named
+	The ``--'' is necessary to avoid confusion with the *branch* named
 	'gitk'
 
 `git log --name-status release..test`::
@@ -129,7 +127,7 @@ EXAMPLES
 
 `git log --follow builtin/rev-list.c`::
 
-	Shows the commits that changed builtin/rev-list.c, including
+	Shows the commits that changed `builtin/rev-list.c`, including
 	those commits that occurred before the file was given its
 	present name.
 
@@ -147,17 +145,18 @@ EXAMPLES
 `git log -p -m --first-parent`::
 
 	Shows the history including change diffs, but only from the
-	"main branch" perspective, skipping commits that come from merged
+	``main branch'' perspective, skipping commits that come from merged
 	branches, and showing full diffs of changes introduced by the merges.
 	This makes sense only when following a strict policy of merging all
 	topic branches when staying on a single integration branch.
 
 `git log -L '/int main/',/^}/:main.c`::
 
-	Shows how the function `main()` in the file 'main.c' evolved
+	Shows how the function `main()` in the file `main.c` evolved
 	over time.
 
 `git log -3`::
+
 	Limits the number of commits to show to 3.
 
 DISCUSSION
@@ -172,12 +171,12 @@ See linkgit:git-config[1] for core variables and linkgit:git-diff[1]
 for settings related to diff generation.
 
 format.pretty::
-	Default for the `--format` option.  (See "PRETTY FORMATS" above.)
-	Defaults to "medium".
+	Default for the `--format` option.  (See 'Pretty Formats' above.)
+	Defaults to `medium`.
 
 i18n.logOutputEncoding::
-	Encoding to use when displaying logs.  (See "Discussion", above.)
-	Defaults to the value of `i18n.commitEncoding` if set, UTF-8
+	Encoding to use when displaying logs.  (See 'Discussion' above.)
+	Defaults to the value of `i18n.commitEncoding` if set, and UTF-8
 	otherwise.
 
 log.date::
@@ -186,7 +185,7 @@ log.date::
 	dates like `Sat May 8 19:35:34 2010 -0500`.
 
 log.showroot::
-	If `false`, 'git log' and related commands will not treat the
+	If `false`, `git log` and related commands will not treat the
 	initial commit as a big creation event.  Any root commits in
 	`git log -p` output would be shown without a diff attached.
 	The default is `true`.
@@ -197,7 +196,7 @@ mailmap.*::
 notes.displayRef::
 	Which refs, in addition to the default set by `core.notesRef`
 	or 'GIT_NOTES_REF', to read notes from when showing commit
-	messages with the 'log' family of commands.  See
+	messages with the `log` family of commands.  See
 	linkgit:git-notes[1].
 +
 May be an unabbreviated ref name or a glob and may be specified
-- 
1.8.4.2

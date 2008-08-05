From: Mike Ralphson <mike@abacus.co.uk>
Subject: [PATCH] Documentation: typos / spelling fixes
Date: Tue,  5 Aug 2008 17:12:05 +0100
Message-ID: <1217952726-4149-1-git-send-email-mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 18:37:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQPWi-0001jW-Gj
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 18:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758000AbYHEQfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 12:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757422AbYHEQfp
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 12:35:45 -0400
Received: from [82.109.193.99] ([82.109.193.99]:18579 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756979AbYHEQfo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 12:35:44 -0400
X-Greylist: delayed 1845 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Aug 2008 12:35:43 EDT
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id 771A61BBB19; Tue,  5 Aug 2008 17:12:06 +0100 (BST)
X-Mailer: git-send-email 1.5.5.1.1.g75d5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91447>


Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---
 Documentation/RelNotes-1.6.0.txt   |    2 +-
 Documentation/config.txt           |    2 +-
 Documentation/git-cat-file.txt     |    2 +-
 Documentation/git-for-each-ref.txt |    2 +-
 Documentation/git-mergetool.txt    |    2 +-
 Documentation/git-svn.txt          |    4 ++--
 Documentation/merge-config.txt     |    4 ++--
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/RelNotes-1.6.0.txt b/Documentation/RelNotes-1.6.0.txt
index 2542cf5..614a3be 100644
--- a/Documentation/RelNotes-1.6.0.txt
+++ b/Documentation/RelNotes-1.6.0.txt
@@ -187,7 +187,7 @@ Updates since v1.5.6
   command internally uses rev-parse to interpret its arguments.
 
 * git-rev-list learned --children option to show child commits it
-  encountered during the traversal, instead of shoing parent commits.
+  encountered during the traversal, instead of showing parent commits.
 
 * git-send-mail can talk not just over SSL but over TLS now.
 
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 61c3760..b8ec01c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -693,7 +693,7 @@ gitcvs.usecrlfattr
 	files to determine the '-k' modes to use. If `crlf` is set,
 	the '-k' mode will be left blank, so cvs clients will
 	treat it as text. If `crlf` is explicitly unset, the file
-	will be set with '-kb' mode, which supresses any newline munging
+	will be set with '-kb' mode, which suppresses any newline munging
 	the client might otherwise do. If `crlf` is not specified,
 	then 'gitcvs.allbinary' is used. See linkgit:gitattributes[5].
 
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index d35e8a0..668f697 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -81,7 +81,7 @@ object specified on stdin:
 ------------
 
 If '--batch-check' is specified, output of the following form is printed for
-each object specified fon stdin:
+each object specified on stdin:
 
 ------------
 <sha1> SP <type> SP <size> LF
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 609f949..eae6c0e 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -49,7 +49,7 @@ OPTIONS
 
 <pattern>...::
 	If one or more patterns are given, only refs are shown that
-	match againt at least one pattern, either using fnmatch(3) or
+	match against at least one pattern, either using fnmatch(3) or
 	literally, in the latter case matching completely or from the
 	beginning up to a slash.
 
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 31570b1..e0b2703 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -40,7 +40,7 @@ tool is available in PATH.
 +
 Instead of running one of the known merge tool programs
 'git-mergetool' can be customized to run an alternative program
-by specifying the command line to invoke in a configration
+by specifying the command line to invoke in a configuration
 variable `mergetool.<tool>.cmd`.
 +
 When 'git-mergetool' is invoked with this tool (either through the
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f230125..773ae96 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -13,7 +13,7 @@ DESCRIPTION
 -----------
 'git-svn' is a simple conduit for changesets between Subversion and git.
 It provides a bidirectional flow of changes between a Subversion and a git
-respository.
+repository.
 
 'git-svn' can track a single Subversion branch simply by using a
 URL to the branch, follow branches laid out in the Subversion recommended
@@ -209,7 +209,7 @@ Any other arguments are passed directly to 'git-log'
 	Recursively finds the svn:ignore property on directories and
 	creates matching .gitignore files. The resulting files are staged to
 	be committed, but are not committed. Use -r/--revision to refer to a
-	specfic revision.
+	specific revision.
 
 'show-ignore'::
 	Recursively finds and lists the svn:ignore property on
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 48ce747..00277e0 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -1,5 +1,5 @@
 merge.stat::
-	Whether to print the diffstat berween ORIG_HEAD and merge result
+	Whether to print the diffstat between ORIG_HEAD and merge result
 	at the end of the merge.  True by default.
 
 merge.log::
@@ -16,7 +16,7 @@ merge.tool::
 	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
 	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff", and
 	"opendiff".  Any other value is treated is custom merge tool
-	and there must be a corresponing mergetool.<tool>.cmd option.
+	and there must be a corresponding mergetool.<tool>.cmd option.
 
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
-- 
1.6.0.rc0.dirty

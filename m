From: "Jason St. John" <jstjohn@purdue.edu>
Subject: [PATCH] RelNotes/2.0.0.txt: Fix several grammar issues, notably a lack of hyphens, double quotes, or articles
Date: Fri, 16 May 2014 23:30:34 -0400
Message-ID: <1400297434-30254-1-git-send-email-jstjohn@purdue.edu>
Cc: "Jason St. John" <jstjohn@purdue.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 05:30:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlVKk-0001ME-MW
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 05:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171AbaEQDao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 23:30:44 -0400
Received: from mailhub246.itcs.purdue.edu ([128.210.5.246]:57107 "EHLO
	mailhub246.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755035AbaEQDan (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2014 23:30:43 -0400
Received: from m4800.wl.stjohn.lcl (41.117.244.66.bay.smithvilledigital.net [66.244.117.41])
	(authenticated bits=0)
	by mailhub246.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id s4H3UbX3002191
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 16 May 2014 23:30:41 -0400
X-Mailer: git-send-email 1.9.2
X-PMX-Version: 6.0.2.2308539
X-PerlMx-URL-Scanned: Yes
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249437>

Signed-off-by: Jason St. John <jstjohn@purdue.edu>
---
 Documentation/RelNotes/2.0.0.txt | 75 ++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/Documentation/RelNotes/2.0.0.txt b/Documentation/RelNotes/2.0.0.txt
index 6e628d4..e6bf9d6 100644
--- a/Documentation/RelNotes/2.0.0.txt
+++ b/Documentation/RelNotes/2.0.0.txt
@@ -44,7 +44,7 @@ with "git diff-files --diff-filter=d").
 The default prefix for "git svn" has changed in Git 2.0.  For a long
 time, "git svn" created its remote-tracking branches directly under
 refs/remotes, but it now places them under refs/remotes/origin/ unless
-it is told otherwise with its --prefix option.
+it is told otherwise with its "--prefix" option.
 
 
 Updates since v1.9 series
@@ -53,7 +53,7 @@ Updates since v1.9 series
 UI, Workflows & Features
 
  * The "multi-mail" post-receive hook (in contrib/) has been updated
-   to a more recent version from the upstream.
+   to a more recent version from upstream.
 
  * "git gc --aggressive" learned "--depth" option and
    "gc.aggressiveDepth" configuration variable to allow use of a less
@@ -63,12 +63,13 @@ UI, Workflows & Features
    single strand-of-pearls is broken in its output.
 
  * The "rev-parse --parseopt" mechanism used by scripted Porcelains to
-   parse command line options and to give help text learned to take
+   parse command-line options and to give help text learned to take
    the argv-help (the placeholder string for an option parameter,
    e.g. "key-id" in "--gpg-sign=<key-id>").
 
  * The pattern to find where the function begins in C/C++ used in
-   "diff" and "grep -p" has been updated to help C++ source better.
+   "diff" and "grep -p" has been updated to improve viewing C++
+   sources.
 
  * "git rebase" learned to interpret a lone "-" as "@{-1}", the
    branch that we were previously on.
@@ -79,7 +80,7 @@ UI, Workflows & Features
    "--sort=version:refname".
 
  * Discard the accumulated "heuristics" to guess from which branch the
-   result wants to be pulled from and make sure what the end user
+   result wants to be pulled from and make sure that what the end user
    specified is not second-guessed by "git request-pull", to avoid
    mistakes.  When you pushed out your 'master' branch to your public
    repository as 'for-linus', use the new "master:for-linus" syntax to
@@ -88,7 +89,7 @@ UI, Workflows & Features
  * "git grep" learned to behave in a way similar to native grep when
    "-h" (no header) and "-c" (count) options are given.
 
- * "git push" via transport-helper interface (e.g. remote-hg) has
+ * "git push" via transport-helper interfaces (e.g. remote-hg) has
    been updated to allow forced ref updates in a way similar to the
    natively supported transports.
 
@@ -114,28 +115,28 @@ UI, Workflows & Features
  * The progress indicators from various time-consuming commands have
    been marked for i18n/l10n.
 
- * "git notes -C <blob>" diagnoses an attempt to use an object that
-   is not a blob as an error.
+ * "git notes -C <blob>" diagnoses as an error an attempt to use an
+   object that is not a blob.
 
  * "git config" learned to read from the standard input when "-" is
    given as the value to its "--file" parameter (attempting an
-   operation to update the configuration in the standard input of
-   course is rejected).
+   operation to update the configuration in the standard input is
+   rejected, of course).
 
  * Trailing whitespaces in .gitignore files, unless they are quoted
    for fnmatch(3), e.g. "path\ ", are warned and ignored.  Strictly
-   speaking, this is a backward incompatible change, but very unlikely
+   speaking, this is a backward-incompatible change, but very unlikely
    to bite any sane user and adjusting should be obvious and easy.
 
- * Many commands that create commits, e.g. "pull", "rebase",
-   learned to take the --gpg-sign option on the command line.
+ * Many commands that create commits, e.g. "pull" and "rebase",
+   learned to take the "--gpg-sign" option on the command line.
 
  * "git commit" can be told to always GPG sign the resulting commit
-   by setting "commit.gpgsign" configuration variable to true (the
-   command line option --no-gpg-sign should override it).
+   by setting the "commit.gpgsign" configuration variable to "true"
+   (the command-line option "--no-gpg-sign" should override it).
 
  * "git pull" can be told to only accept fast-forward by setting the
-   new "pull.ff" configuration.
+   new "pull.ff" configuration variable.
 
  * "git reset" learned the "-N" option, which does not reset the index
    fully for paths the index knows about but the tree-ish the command
@@ -152,7 +153,7 @@ Performance, Internal Implementation, etc.
 
  * Uses of curl's "multi" interface and "easy" interface do not mix
    well when we attempt to reuse outgoing connections.  Teach the RPC
-   over http code, used in the smart HTTP transport, not to use the
+   over HTTP code, used in the smart HTTP transport, not to use the
    "easy" interface.
 
  * The bitmap-index feature from JGit has been ported, which should
@@ -190,20 +191,20 @@ notes for details).
 
  * The remote-helper interface to fast-import/fast-export via the
    transport-helper has been tightened to avoid leaving the import
-   marks file from a failed/crashed run, as such a file that is out of
-   sync with the reality confuses a later invocation of itself.
+   marks file from a failed/crashed run, as such a file that is out-of-
+   sync with reality confuses a later invocation of itself.
 
- * "git rebase" used a POSIX shell construct FreeBSD /bin/sh does not
+ * "git rebase" used a POSIX shell construct FreeBSD's /bin/sh does not
    work well with.
    (merge 8cd6596 km/avoid-non-function-return-in-rebase later to maint).
 
  * zsh prompt (in contrib/) leaked unnecessary error messages.
 
- * bash completion (in contrib/) did not complete the refs and remotes
+ * Bash completion (in contrib/) did not complete the refs and remotes
    correctly given "git pu<TAB>" when "pu" is aliased to "push".
 
- * Some more Unicode codepoints defined in Unicode 6.3 as having zero
-   width have been taught to our display column counting logic.
+ * Some more Unicode code points, defined in Unicode 6.3 as having zero
+   width, have been taught to our display column counting logic.
    (merge d813ab9 tb/unicode-6.3-zero-width later to maint).
 
  * Some tests used shell constructs that did not work well on FreeBSD
@@ -217,7 +218,7 @@ notes for details).
  * "git diff --no-index -Mq a b" fell into an infinite loop.
    (merge ad1c3fb jc/fix-diff-no-index-diff-opt-parse later to maint).
 
- * "git fetch --prune", when the right-hand-side of multiple fetch
+ * "git fetch --prune", when the right-hand side of multiple fetch
    refspecs overlap (e.g. storing "refs/heads/*" to
    "refs/remotes/origin/*", while storing "refs/frotz/*" to
    "refs/remotes/origin/fr/*"), aggressively thought that lack of
@@ -272,7 +273,7 @@ notes for details).
    (merge 3c3e6f5 rr/doc-merge-strategies later to maint).
 
  * Serving objects from a shallow repository needs to write a
-   new file to hold the temporary shallow boundaries but it was not
+   new file to hold the temporary shallow boundaries, but it was not
    cleaned when we exit due to die() or a signal.
    (merge 7839632 jk/shallow-update-fix later to maint).
 
@@ -295,19 +296,19 @@ notes for details).
    ".git" tells us where it is.
    (merge fcfec8b da/difftool-git-files later to maint).
 
- * "git push" did not pay attention to branch.*.pushremote if it is
-   defined earlier than remote.pushdefault; the order of these two
+ * "git push" did not pay attention to "branch.*.pushremote" if it is
+   defined earlier than "remote.pushdefault"; the order of these two
    variables in the configuration file should not matter, but it did
    by mistake.
    (merge 98b406f jk/remote-pushremote-config-reading later to maint).
 
- * Codepaths that parse timestamps in commit objects have been
+ * Code paths that parse timestamps in commit objects have been
    tightened.
    (merge f80d1f9 jk/commit-dates-parsing-fix later to maint).
 
  * "git diff --external-diff" incorrectly fed the submodule directory
-   in the working tree to the external diff driver when it knew it is
-   the same as one of the versions being compared.
+   in the working tree to the external diff driver when it knew that it
+   is the same as one of the versions being compared.
    (merge aba4727 tr/diff-submodule-no-reuse-worktree later to maint).
 
  * "git reset" needs to refresh the index when working in a working
@@ -318,7 +319,7 @@ notes for details).
 
  * "git check-attr" when working on a repository with a working tree
    did not work well when the working tree was specified via the
-   --work-tree (and obviously with --git-dir) option.
+   "--work-tree" (and obviously with "--git-dir") option.
    (merge cdbf623 jc/check-attr-honor-working-tree later to maint).
 
  * "merge-recursive" was broken in 1.7.7 era and stopped working in
@@ -326,12 +327,12 @@ notes for details).
    involved.  This has been corrected.
    (merge 6e2068a bk/refresh-missing-ok-in-merge-recursive later to maint.)
 
- * "git rev-parse" was loose in rejecting command line arguments
+ * "git rev-parse" was loose in rejecting command-line arguments
    that do not make sense, e.g. "--default" without the required
    value for that option.
    (merge a43219f ds/rev-parse-required-args later to maint.)
 
- * include.path variable (or any variable that expects a path that
+ * "include.path" variable (or any variable that expects a path that
    can use ~username expansion) in the configuration file is not a
    boolean, but the code failed to check it.
    (merge 67beb60 jk/config-path-include-fix later to maint.)
@@ -343,20 +344,20 @@ notes for details).
    (merge later 655ee9e mw/symlinks to maint.)
 
  * "git diff --quiet -- pathspec1 pathspec2" sometimes did not return
-   correct status value.
+   the correct status value.
    (merge f34b205 nd/diff-quiet-stat-dirty later to maint.)
 
  * Attempting to deepen a shallow repository by fetching over smart
-   HTTP transport failed in the protocol exchange, when no-done
+   HTTP transport failed in the protocol exchange, when the no-done
    extension was used.  The fetching side waited for the list of
-   shallow boundary commits after the sending end stopped talking to
+   shallow boundary commits after the sending side stopped talking to
    it.
    (merge 0232852 nd/http-fetch-shallow-fix later to maint.)
 
  * Allow "git cmd path/", when the 'path' is where a submodule is
    bound to the top-level working tree, to match 'path', despite the
    extra and unnecessary trailing slash (such a slash is often
-   given by command line completion).
+   given by command-line completion).
    (merge 2e70c01 nd/submodule-pathspec-ending-with-slash later to maint.)
 
  * Documentation and in-code comments had many instances of mistaken
-- 
1.9.2

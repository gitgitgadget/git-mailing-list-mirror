From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] Release notes grammatical fixes.
Date: Tue,  5 Aug 2014 12:50:45 -0400
Message-ID: <1407257445-18363-1-git-send-email-marcnarc@xiplink.com>
References: <xmqqy4v3q43r.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 19:00:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEi5j-0005B3-PD
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 19:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859AbaHEQ76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 12:59:58 -0400
Received: from domain.not.configured ([192.252.130.194]:10177 "EHLO
	cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755349AbaHEQ75 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 12:59:57 -0400
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Aug 2014 12:59:56 EDT
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id 20D9E60318;
	Tue,  5 Aug 2014 12:50:42 -0400 (EDT)
X-Mailer: git-send-email 2.1.0.rc1
In-Reply-To: <xmqqy4v3q43r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254812>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

(Note that I did not reflow lines to keep them a specific length.)

 Documentation/RelNotes/2.1.0.txt | 108 +++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 55 deletions(-)

diff --git a/Documentation/RelNotes/2.1.0.txt b/Documentation/RelNotes/2.1.0.txt
index 5cfb0ab..4fd153e 100644
--- a/Documentation/RelNotes/2.1.0.txt
+++ b/Documentation/RelNotes/2.1.0.txt
@@ -12,7 +12,7 @@ Backward compatibility notes
      $ git config core.pager "less -S"
 
    to restore the traditional behaviour.  It is expected that people
-   find output from the most subcommands easier to read with the new
+   find output from most subcommands easier to read with the new
    default, except for "blame" which tends to produce really long
    lines.  To override the new default only for "git blame", you can
    do this:
@@ -31,7 +31,7 @@ UI, Workflows & Features
    default value "FRSX" when we spawn "less" as the pager.  "S" (chop
    long lines instead of wrapping) has been removed from this default
    set of options, because it is more or less a personal taste thing,
-   as opposed to others that have good justifications (i.e. "R" is
+   as opposed to the others that have good justifications (i.e. "R" is
    very much justified because many kinds of output we produce are
    colored and "FX" is justified because output we produce is often
    shorter than a page).
@@ -39,47 +39,47 @@ UI, Workflows & Features
  * The logic and data used to compute the display width needed for
    UTF-8 strings have been updated to match Unicode 7.0 better.
 
- * HTTP-based transports learned to propagate the error messages from
-   the webserver better to the client coming over the HTTP transport.
+ * HTTP-based transports learned to better propagate the error messages from
+   the webserver to the client coming over the HTTP transport.
 
  * The completion script for bash (in contrib/) has been updated to
-   handle aliases that define complex sequence of commands better.
+   better handle aliases that define a complex sequence of commands.
 
- * The "core.preloadindex" configuration variable is by default
-   enabled, allowing modern platforms to take advantage of the
-   multiple cores they have.
+ * The "core.preloadindex" configuration variable is enabled by default,
+   allowing modern platforms to take advantage of their
+   multiple cores.
 
  * "git clone" applies the "if cloning from a local disk, physically
-   copy repository using hardlinks, unless otherwise told not to with
-   --no-local" optimization when url.*.insteadOf mechanism rewrites a
-   "git clone $URL" that refers to a repository over the network to a
+   copy the repository using hardlinks, unless otherwise told not to with
+   --no-local" optimization when the url.*.insteadOf mechanism rewrites a
+   remote-repository "git clone $URL" into a
    clone from a local disk.
 
- * "git commit --date=<date>" option learned to read from more
+ * "git commit --date=<date>" option learned more
    timestamp formats, including "--date=now".
 
  * The `core.commentChar` configuration variable is used to specify a
-   custom comment character other than the default "#" to be used in
-   the commit log editor.  This can be set to `auto` to attempt to
-   choose a different character that does not conflict with what
-   already starts a line in the message being edited for cases like
+   custom comment character (other than the default "#") for
+   the commit message editor.  This can be set to `auto` to attempt to
+   choose a different character that does not conflict with any that
+   already starts a line in the message being edited, for cases like
    "git commit --amend".
 
- * "git format-patch" learned --signature-file=<file> to take the mail
-   signature from.
+ * "git format-patch" learned --signature-file=<file> to add the contents
+   of a file as a signature to the mail message it produces.
 
- * "git grep" learned grep.fullname configuration variable to force
-   "--full-name" to be default.  This may cause regressions on
-   scripted users that do not expect this new behaviour.
+ * "git grep" learned the grep.fullname configuration variable to force
+   "--full-name" to be the default.  This may cause regressions for
+   scripted users who do not expect this new behaviour.
 
  * "git imap-send" learned to ask the credential helper for auth
    material.
 
- * "git log" and friends now understand the value "auto" set to the
+ * "git log" and friends now understand the value "auto" for the
    "log.decorate" configuration variable to enable the "--decorate"
    option automatically when the output is sent to tty.
 
- * "git merge" without argument, even when there is an upstream
+ * "git merge" without an argument, even when there is an upstream
    defined for the current branch, refused to run until
    merge.defaultToUpstream is set to true.  Flip the default of that
    configuration variable to true.
@@ -87,22 +87,20 @@ UI, Workflows & Features
  * "git mergetool" learned to drive the vimdiff3 backend.
 
  * mergetool.prompt used to default to 'true', always asking "do you
-   really want to run the tool on this path?".  Among the two
-   purposes this prompt serves, ignore the use case to confirm that
-   the user wants to view particular path with the named tool, and
-   redefine the meaning of the prompt only to confirm the choice of
-   the tool made by the autodetection (for those who configured the
-   tool explicitly, the prompt shown for the latter purpose is
-   simply annoying).
-
-   Strictly speaking, this is a backward incompatible change and the
+   really want to run the tool on this path?".  The default has been
+   changed to 'false'.  However, the prompt will still appear if
+   mergetool used its autodetection system to guess which tool to use.
+   Users who explicitly specify or configure a tool will no longer see
+   the prompt by default.
+
+   Strictly speaking, this is a backward incompatible change and
    users need to explicitly set the variable to 'true' if they want
-   to resurrect the now-ignored use case.
+   to resurrect the old behaviour.
 
  * "git replace" learned the "--edit" subcommand to create a
    replacement by editing an existing object.
 
- * "git replace" learned a "--graft" option to rewrite parents of a
+ * "git replace" learned a "--graft" option to rewrite the parents of a
    commit.
 
  * "git send-email" learned "--to-cover" and "--cc-cover" options, to
@@ -117,10 +115,10 @@ UI, Workflows & Features
    being edited as a comment in the editor.
 
  * "git tag" learned to pay attention to "tag.sort" configuration, to
-   be used as the default sort order when no --sort=<value> the option
+   be used as the default sort order when no --sort=<value> option
    is given.
 
- * "git verify-commit" command to check GPG signature in signed
+ * A new "git verify-commit" command, to check GPG signatures in signed
    commits, in a way similar to "git verify-tag" is used to check
    signed tags, was added.
 
@@ -129,8 +127,8 @@ Performance, Internal Implementation, etc.
 
  * Build procedure for 'subtree' (in contrib/) has been cleaned up.
 
- * The support for the profile-feedback build, which has been left
-   bit-rotten for quite a while, has been updated.
+ * Support for the profile-feedback build, which has
+   bit-rotted for quite a while, has been updated.
 
  * An experimental format to use two files (the base file and
    incremental changes relative to it) to represent the index has been
@@ -158,7 +156,7 @@ Performance, Internal Implementation, etc.
    structure that is used to keep track of the work to be done.
 
  * "git diff" that compares 3-or-more trees (e.g. parents and the
-   result of a merge) have been optimized.
+   result of a merge) has been optimized.
 
  * The API to update/delete references are being converted to handle
    updates to multiple references in a transactional way.  As an
@@ -194,8 +192,8 @@ notes for details).
    to a tty.
    (merge 38de156 mn/sideband-no-ansi later to maint).
 
- * Mishandling of patterns in .gitignore that has trailing SPs quoted
-   with backslashes (e.g. ones that end with "\ ") have been
+ * Mishandling of patterns in .gitignore that have trailing SPs quoted
+   with backslashes (e.g. ones that end with "\ ") has been
    corrected.
    (merge 97c1364be6b pb/trim-trailing-spaces later to maint).
 
@@ -232,7 +230,7 @@ notes for details).
    and to allow the caller find the length of the object.
    (merge 218aa3a jk/commit-buffer-length later to maint).
 
- * The "mailmap.file" configuration option did not support the tilde
+ * The "mailmap.file" configuration option did not support tilde
    expansion (i.e. ~user/path and ~/path).
    (merge 9352fd5 ow/config-mailmap-pathname later to maint).
 
@@ -244,7 +242,7 @@ notes for details).
  * The unix-domain socket used by the sample credential cache daemon
    tried to unlink an existing stale one at a wrong path, if the path
    to the socket was given as an overlong path that does not fit in
-   sun_path member of the sockaddr_un structure.
+   the sun_path member of the sockaddr_un structure.
    (merge 2869b3e rs/fix-unlink-unix-socket later to maint).
 
  * An ancient rewrite passed a wrong pointer to a curl library
@@ -252,12 +250,12 @@ notes for details).
    (merge 479eaa8 ah/fix-http-push later to maint).
 
  * "--ignore-space-change" option of "git apply" ignored the spaces
-   at the beginning of line too aggressively, which is inconsistent
-   with the option of the same name "diff" and "git diff" have.
+   at the beginning of lines too aggressively, which is inconsistent
+   with the option of the same name that "diff" and "git diff" have.
    (merge 14d3bb4 jc/apply-ignore-whitespace later to maint).
 
- * "git blame" miscounted number of columns needed to show localized
-   timestamps, resulting in jaggy left-side-edge of the source code
+ * "git blame" miscounted the number of columns needed to show localized
+   timestamps, resulting in a jaggy left-side-edge for the source code
    lines in its output.
    (merge dd75553 jx/blame-align-relative-time later to maint).
 
@@ -271,17 +269,17 @@ notes for details).
    because it incorrectly used strstr().
    (merge 60a5f5f jc/fix-clone-single-starting-at-a-tag later to maint).
 
- * "git commit --allow-empty-messag -C $commit" did not work when the
+ * "git commit --allow-empty-message -C $commit" did not work when the
    commit did not have any log message.
    (merge 076cbd6 jk/commit-C-pick-empty later to maint).
 
  * "git diff --find-copies-harder" sometimes pretended as if the mode
-   bits have changed for paths that are marked with assume-unchanged
+   bits have changed for paths that are marked with the assume-unchanged
    bit.
    (merge 5304810 jk/diff-files-assume-unchanged later to maint).
 
  * "filter-branch" left an empty single-parent commit that results when
-   all parents of a merge commit gets mapped to the same commit, even
+   all parents of a merge commit get mapped to the same commit, even
    under "--prune-empty".
    (merge 79bc4ef cb/filter-branch-prune-empty-degenerate-merges later to maint).
 
@@ -314,10 +312,10 @@ notes for details).
    mergetag that was and was not correctly validated.
    (merge 42c55ce mg/fix-log-mergetag-color later to maint).
 
- * "log --show-signature" did not pay attention to "--graph" option.
+ * "log --show-signature" did not pay attention to the "--graph" option.
    (merge cf3983d zk/log-graph-showsig later to maint).
 
- * "git mailinfo" used to read beyond the end of header string while
+ * "git mailinfo" used to read beyond the ends of header strings while
    parsing an incoming e-mail message to extract the patch.
    (merge b1a013d rs/mailinfo-header-cmp later to maint).
 
@@ -337,7 +335,7 @@ notes for details).
    (merge fb79947 rs/pack-objects-no-unnecessary-realloc later to maint).
 
  * Recent updates to "git repack" started to duplicate objects that
-   are in packfiles marked with .keep flag into the new packfile by
+   are in packfiles marked with the .keep flag into the new packfile by
    mistake.
    (merge d078d85 jk/repack-pack-keep-objects later to maint).
 
@@ -375,14 +373,14 @@ notes for details).
  * "git status", even though it is a read-only operation, tries to
    update the index with refreshed lstat(2) info to optimize future
    accesses to the working tree opportunistically, but this could
-   race with a "read-write" operation that modify the index while it
+   race with a "read-write" operation that modifies the index while it
    is running.  Detect such a race and avoid overwriting the index.
    (merge 426ddee ym/fix-opportunistic-index-update-race later to maint).
 
  * "git status" (and "git commit") behaved as if changes in a modified
    submodule are not there if submodule.*.ignore configuration is set,
    which was misleading.  The configuration is only to unclutter diff
-   output during the course of development, and should not to hide
+   output during the course of development, and not to hide
    changes in the "status" output to cause the users forget to commit
    them.
    (merge c215d3d jl/status-added-submodule-is-never-ignored later to maint).
-- 
2.1.0.rc1

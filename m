From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] RelNotes/1.8.0: various typo and style fixes
Date: Tue,  2 Oct 2012 16:35:55 +0200
Message-ID: <0a88dc3dd202903b2fbb2d32079767e45a72bb9e.1349188433.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 16:37:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ3Zy-0007mD-3o
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 16:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113Ab2JBOf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 10:35:58 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57421 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751525Ab2JBOf5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2012 10:35:57 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3AAC5208BB;
	Tue,  2 Oct 2012 10:35:57 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 02 Oct 2012 10:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id; s=
	smtpout; bh=8mn61UVJ7EnsOhpPagcpL5J9Oz0=; b=hxqnPvd2uk1LLMPTTOvy
	nJ7TWZdgkOWPlk9JOEiQKO2ezOnvcKx/9wQUO8xAhwsRtTuxgbimlYR2r5pVNLjH
	iOyMNevdAg2naCgbDdfBHlvj2KfiJetADGAJXt4k+Pbkjeeb/0FBkm6q3kVHnFwE
	kjzL3SHtHnEL+LI5R4AB2Sk=
X-Sasl-enc: A4/WfNyISu3jZA1ZuxFy9gBcy8CtAqk2+zavA2AHKYaT 1349188556
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id AE05B482525;
	Tue,  2 Oct 2012 10:35:56 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc0.229.g049d4c0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206798>


Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Just trying to make it clearer, and threw in an article or two.
Also, tried to make the use of tenses a bit more uniform.

As always, best looked at with --color-words or such.

 Documentation/RelNotes/1.8.0.txt | 48 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/RelNotes/1.8.0.txt b/Documentation/RelNotes/1.8.0.txt
index cc460a4..a17f893 100644
--- a/Documentation/RelNotes/1.8.0.txt
+++ b/Documentation/RelNotes/1.8.0.txt
@@ -4,11 +4,11 @@ Git v1.8.0 Release Notes
 Backward compatibility notes
 ----------------------------
 
-In the next major release, we will change the behaviour of the "git
+In the next major release, we will change the behavior of the "git
 push" command.  When "git push [$there]" does not say what to push, we
-have used the traditional "matching" semantics (all your branches were
+have used the traditional "matching" semantics so far (all your branches were
 sent to the remote as long as there already are branches of the same
-name over there).  We will use the "simple" semantics, that pushes the
+name over there).  We will now use the "simple" semantics, that pushes the
 current branch to the branch with the same name only when the current
 branch is set to integrate with that remote branch.  There is a user
 preference configuration variable "push.default" to change this, and
@@ -33,9 +33,9 @@ UI, Workflows & Features
  * A credential helper to allow access to the Gnome keyring has been
    added.
 
- * When "git am" sanitizes the Subject: line, we strip the prefix from
+ * When "git am" sanitizes the "Subject:" line, we strip the prefix from
    "Re: subject" and also from a less common "re: subject", but left
-   even less common "RE: subject" intact.
+   the even less common "RE: subject" intact. We strip that now, too.
 
  * It was tempting to say "git branch --set-upstream origin/master",
    but that tells Git to arrange the local branch "origin/master" to
@@ -57,15 +57,15 @@ UI, Workflows & Features
    repository path, etc.
 
  * "git difftool --dir-diff" learned to use symbolic links to prepare
-   temporary copy of the working tree when available.
+   a temporary copy of the working tree when available.
 
  * "git grep" learned to use a non-standard pattern type by default if
    a configuration variable tells it to.
 
- * "git merge-base" learned "--is-ancestor A B" option to tell if A is
+ * "git merge-base" learned the "--is-ancestor A B" option to tell if A is
    an ancestor of B.  The result is indicated by its exit status code.
 
- * "git mergetool" allows users to override the actual command used
+ * "git mergetool" now allows users to override the actual command used
    with the mergetool.$name.cmd configuration variable even for built-in
    mergetool backends.
 
@@ -73,14 +73,14 @@ UI, Workflows & Features
    effect even on binary files.
 
  * "git rebase -i" learned the "--edit-todo" option to open an editor
-   to edit the insn sheet.
+   to edit the instruction sheet.
 
 
 Foreign Interface
 
  * "git svn" has been updated to work with SVN 1.7.
 
- * "git p4" learned "--conflicts" option to specify what to do when
+ * "git p4" learned the "--conflicts" option to specify what to do when
    encountering a conflict during "p4 submit".
 
 
@@ -88,12 +88,12 @@ Performance, Internal Implementation, etc. (please report possible regressions)
 
  * Git ships with a fall-back regexp implementation for platforms with
    buggy regexp library, but it was easy for people to keep using their
-   platform regexp.  A new test has been added to check this.
+   platform regexp by mistake.  A new test has been added to check this.
 
  * The "check-docs" build target has been updated and greatly
    simplified.
 
- * The test suite is run under MALLOC_CHECK_ when running with glibc
+ * The test suite is run under MALLOC_CHECK_ when running with a glibc
    that supports the feature.
 
  * The documentation in the TeXinfo format was using indented output
@@ -101,7 +101,7 @@ Performance, Internal Implementation, etc. (please report possible regressions)
    monospace.
 
  * Compatibility wrapper around some mkdir(2) implementations that
-   reject parameter with trailing slash has been introduced.
+   reject parameters with trailing slash has been introduced.
 
  * Compatibility wrapper for systems that lack usable setitimer() has
    been added.
@@ -113,7 +113,7 @@ Performance, Internal Implementation, etc. (please report possible regressions)
    when the user says "git checkout -b -t foo bar" (e.g. "-t" is not a
    good name for a branch).
 
- * Many internal uses of "git merge-base" equivalent were only to see
+ * Many internal uses of a "git merge-base" equivalent were only to see
    if one commit fast-forwards to the other, which did not need the
    full set of merge bases to be computed. They have been updated to
    use less expensive checks.
@@ -164,7 +164,7 @@ to them for details).
 
  * Output from "git branch -v" contains "(no branch)" that could be
    localized, but the code to align it along with the names of
-   branches were counting in bytes, not in display columns.
+   branches was counting in bytes, not in display columns.
 
  * "git cherry-pick A C B" used to replay changes in A and then B and
    then C if these three commits had committer timestamps in that
@@ -189,11 +189,11 @@ to them for details).
  * Earlier we made the diffstat summary line that shows the number of
    lines added/deleted localizable, but it was found irritating having
    to see them in various languages on a list whose discussion language
-   is English.
+   is English, and this change has been reverted.
 
  * "git fetch --all", when passed "--no-tags", did not honor the
    "--no-tags" option while fetching from individual remotes (the same
-   issue existed with "--tags", but combination "--all --tags" makes
+   issue existed with "--tags", but the combination "--all --tags" makes
    much less sense than "--all --no-tags").
 
  * "git fetch" over http had an old workaround for an unlikely server
@@ -202,13 +202,13 @@ to them for details).
    (merge 6ac964a sp/maint-http-info-refs-no-retry later to maint).
 
  * "git fetch" over http advertised that it supports "deflate", which
-   is much less common, and did not advertise more common "gzip" on
+   is much less common, and did not advertise the more common "gzip" on
    its Accept-Encoding header.
    (merge aa90b96 sp/maint-http-enable-gzip later to maint).
 
  * After "gitk" showed the contents of a tag, neither "Reread
-   references" nor "Reload" did not update what is shown as the
-   contents of it, when the user overwrote the tag with "git tag -f".
+   references" nor "Reload" updated what is shown as the
+   contents of it when the user overwrote the tag with "git tag -f".
 
  * "git log --all-match --grep=A --grep=B" ought to show commits that
    mention both A and B, but when these three options are used with
@@ -224,21 +224,21 @@ to them for details).
    (merge 74eb32d jk/receive-pack-unpack-error-to-pusher later to maint).
 
  * When you misspell the command name you give to the "exec" action in
-   the "git rebase -i" insn sheet, you are told that 'rebase' is not a
+   the "git rebase -i" instruction sheet you were told that 'rebase' is not a
    git subcommand from "git rebase --continue".
 
  * The subcommand in "git remote" to remove a defined remote was
    "rm" and the command did not take a fully-spelled "remove".
 
- * The interactive prompt "git send-email" gives was error prone. It
+ * The interactive prompt that "git send-email" gives was error prone. It
    asked "What e-mail address do you want to use?" with the address it
    guessed (correctly) the user would want to use in its prompt,
    tempting the user to say "y". But the response was taken as "No,
    please use 'y' as the e-mail address instead", which is most
    certainly not what the user meant.
 
- * "git show --format='%ci'" did not give timestamp correctly for
-   commits created without human readable name on "committer" line.
+ * "git show --format='%ci'" did not give the timestamp correctly for
+   commits created without human readable name on the "committer" line.
 
  * "git show --quiet" ought to be a synonym for "git show -s", but
    wasn't.
-- 
1.8.0.rc0.229.g049d4c0

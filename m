From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] RelNotes/1.7.7: minor fixes
Date: Wed,  7 Sep 2011 13:54:11 +0200
Message-ID: <61f2b23c1717455d9b2088b1b8f3350756d757e0.1315396440.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 18:42:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1LCo-0007iO-4G
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 18:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429Ab1IGQmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 12:42:19 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:55044 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752314Ab1IGQmP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2011 12:42:15 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EC517296A7;
	Wed,  7 Sep 2011 07:54:13 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 07 Sep 2011 07:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id; s=
	smtpout; bh=V5wFWxByUOf9sEjXljvrtmf+dyU=; b=gttZJGcCI93LfWTKDKwX
	SfFMvQqH4rwV4n5ByyXvFL92LUNDyQ8jei6Nap5caMT5oB1LqJjt1649v1Qy42l4
	+yjrm9XguSLj8FxsnyO3CQzp7OIclusrJyfpFgc39khEz06MKMaSxAYxY16Lo02b
	AgSNYomDoW95b5c/izlu1qk=
X-Sasl-enc: 1AjmPkGg/ysCxY/gLio9uV53l251iNseVjgKfx8Rqbo/ 1315396453
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4E2456E08BE;
	Wed,  7 Sep 2011 07:54:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.438.gcfb82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180866>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/RelNotes/1.7.7.txt |   52 +++++++++++++++++++-------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/RelNotes/1.7.7.txt b/Documentation/RelNotes/1.7.7.txt
index d819956..6e83082 100644
--- a/Documentation/RelNotes/1.7.7.txt
+++ b/Documentation/RelNotes/1.7.7.txt
@@ -8,7 +8,7 @@ Updates since v1.7.6
 
  * Interix, Cygwin and Minix ports got updated.
 
- * Various updates git-p4 (in contrib/), fast-import, and git-svn.
+ * Various updates to git-p4 (in contrib/), fast-import, and git-svn.
 
  * Gitweb learned to read from /etc/gitweb-common.conf when it exists,
    before reading from gitweb_config.perl or from /etc/gitweb.conf
@@ -20,7 +20,7 @@ Updates since v1.7.6
    platforms with 64-bit long, which has been corrected.
 
  * Git now recognizes loose objects written by other implementations that
-   uses non-standard window size for zlib deflation (e.g. Agit running on
+   use a non-standard window size for zlib deflation (e.g. Agit running on
    Android with 4kb window). We used to reject anything that was not
    deflated with 32kb window.
 
@@ -28,59 +28,59 @@ Updates since v1.7.6
    been improved, especially when a command that is not built-in was
    involved.
 
- * "git am" learned to pass "--exclude=<path>" option through to underlying
+ * "git am" learned to pass the "--exclude=<path>" option through to underlying
    "git apply".
 
- * You can now feed many empty lines before feeding a mbox file to
+ * You can now feed many empty lines before feeding an mbox file to
    "git am".
 
  * "git archive" can be told to pass the output to gzip compression and
    produce "archive.tar.gz".
 
- * "git bisect" can be used in a bare repository (provided if the test
+ * "git bisect" can be used in a bare repository (provided that the test
    you perform per each iteration does not need a working tree, of
    course).
 
  * The length of abbreviated object names in "git branch -v" output
-   now honors core.abbrev configuration variable.
+   now honors the core.abbrev configuration variable.
 
  * "git check-attr" can take relative paths from the command line.
 
- * "git check-attr" learned "--all" option to list the attributes for a
+ * "git check-attr" learned an "--all" option to list the attributes for a
    given path.
 
  * "git checkout" (both the code to update the files upon checking out a
-   different branch, the code to checkout specific set of files) learned
+   different branch and the code to checkout a specific set of files) learned
    to stream the data from object store when possible, without having to
-   read the entire contents of a file in memory first. An earlier round
+   read the entire contents of a file into memory first. An earlier round
    of this code that is not in any released version had a large leak but
    now it has been plugged.
 
- * "git clone" can now take "--config key=value" option to set the
+ * "git clone" can now take a "--config key=value" option to set the
    repository configuration options that affect the initial checkout.
 
  * "git commit <paths>..." now lets you feed relative pathspecs that
-   refer outside your current subdirectory.
+   refer to outside your current subdirectory.
 
- * "git diff --stat" learned --stat-count option to limit the output of
-   diffstat report.
+ * "git diff --stat" learned a --stat-count option to limit the output of
+   a diffstat report.
 
- * "git diff" learned "--histogram" option, to use a different diff
+ * "git diff" learned a "--histogram" option to use a different diff
    generation machinery stolen from jgit, which might give better
    performance.
 
- * "git diff" had a wierd worst case behaviour that can be triggered
+ * "git diff" had a weird worst case behaviour that can be triggered
    when comparing files with potentially many places that could match.
 
  * "git fetch", "git push" and friends no longer show connection
-   errors for addresses that couldn't be connected when at least one
+   errors for addresses that couldn't be connected to when at least one
    address succeeds (this is arguably a regression but a deliberate
    one).
 
- * "git grep" learned --break and --heading options, to let users mimic
-   output format of "ack".
+ * "git grep" learned "--break" and "--heading" options, to let users mimic
+   the output format of "ack".
 
- * "git grep" learned "-W" option that shows wider context using the same
+ * "git grep" learned a "-W" option that shows wider context using the same
    logic used by "git diff" to determine the hunk header.
 
  * Invoking the low-level "git http-fetch" without "-a" option (which
@@ -91,25 +91,25 @@ Updates since v1.7.6
    highlight grafted and replaced commits.
 
  * "git rebase master topci" no longer spews usage hints after giving
-   "fatal: no such branch: topci" error message.
+   the "fatal: no such branch: topci" error message.
 
  * The recursive merge strategy implementation got a fairly large
-   fixes for many corner cases that may rarely happen in real world
+   fix for many corner cases that may rarely happen in real world
    projects (it has been verified that none of the 16000+ merges in
    the Linux kernel history back to v2.6.12 is affected with the
    corner case bugs this update fixes).
 
- * "git stash" learned --include-untracked option.
+ * "git stash" learned an "--include-untracked option".
 
  * "git submodule update" used to stop at the first error updating a
    submodule; it now goes on to update other submodules that can be
    updated, and reports the ones with errors at the end.
 
- * "git push" can be told with --recurse-submodules=check option to
+ * "git push" can be told with the "--recurse-submodules=check" option to
    refuse pushing of the supermodule, if any of its submodules'
    commits hasn't been pushed out to their remotes.
 
- * "git upload-pack" and "git receive-pack" learned to pretend only a
+ * "git upload-pack" and "git receive-pack" learned to pretend that only a
    subset of the refs exist in a repository. This may help a site to
    put many tiny repositories into one repository (this would not be
    useful for larger repositories as repacking would be problematic).
@@ -118,7 +118,7 @@ Updates since v1.7.6
    that is more efficient in reading objects in packfiles.
 
  * test scripts for gitweb tried to run even when CGI-related perl modules
-   are not installed; it now exits early when they are unavailable.
+   are not installed; they now exit early when the latter are unavailable.
 
 Also contains various documentation updates and minor miscellaneous
 changes.
@@ -127,7 +127,7 @@ changes.
 Fixes since v1.7.6
 ------------------
 
-Unless otherwise noted, all the fixes in 1.7.6.X maintenance track are
+Unless otherwise noted, all fixes in the 1.7.6.X maintenance track are
 included in this release.
 
  * The error reporting logic of "git am" when the command is fed a file
-- 
1.7.7.rc0.438.gcfb82

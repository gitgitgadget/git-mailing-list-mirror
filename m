From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] release notes: typo fixes
Date: Thu, 13 Feb 2014 11:35:08 +0100
Message-ID: <a19c8a36a99d643ceb3d5b41480db98ca1cf099a.1392287654.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 13 11:34:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDtd9-0003wL-92
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 11:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbaBMKeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 05:34:50 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58965 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753203AbaBMKet (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Feb 2014 05:34:49 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 81E5A20F8B
	for <git@vger.kernel.org>; Thu, 13 Feb 2014 05:34:48 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 13 Feb 2014 05:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id; s=
	smtpout; bh=PDWP9DS1mVEkXCWjXLSC+KY++LA=; b=c4+GIg+9OC6OOcJfIjcc
	Bzn5m3lCEjnjIXfBKaiNTrH48hxLgtuYhGFEWoWK5AwIv9tTAdnictVjzdG12Ag4
	zVFTFOAF0AXFhgzc5uoazUYCxxufNhjMzYTlRDZ2zGl0iQklc2GRTzMSeWcjaoPt
	o2K0pBWMfGVabHOSB4yPJpk=
X-Sasl-enc: DppR7btR+Aq12xBpmp975E7i77NaXna3YiOAPh0QXbSY 1392287687
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id F0C54C00005;
	Thu, 13 Feb 2014 05:34:47 -0500 (EST)
X-Mailer: git-send-email 1.9.0.rc3.263.g4010a96
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242058>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Just a few things I spotted while trying to keep myself informed :)

 Documentation/RelNotes/1.9.txt | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/RelNotes/1.9.txt b/Documentation/RelNotes/1.9.txt
index 43c7b68..a0cabcd 100644
--- a/Documentation/RelNotes/1.9.txt
+++ b/Documentation/RelNotes/1.9.txt
@@ -7,19 +7,19 @@ Backward compatibility notes
 "git submodule foreach $cmd $args" used to treat "$cmd $args" the same
 way "ssh" did, concatenating them into a single string and letting the
 shell unquote. Careless users who forget to sufficiently quote $args
-gets their argument split at $IFS whitespaces by the shell, and got
+get their argument split at $IFS whitespaces by the shell, and got
 unexpected results due to this. Starting from this release, the
 command line is passed directly to the shell, if it has an argument.
 
 Read-only support for experimental loose-object format, in which users
-could optionally choose to write in their loose objects for a short
-while between v1.4.3 to v1.5.3 era, has been dropped.
+could optionally choose to write their loose objects for a short
+while between v1.4.3 and v1.5.3 era, has been dropped.
 
-The meanings of "--tags" option to "git fetch" has changed; the
-command fetches tags _in addition to_ what are fetched by the same
+The meanings of the "--tags" option to "git fetch" has changed; the
+command fetches tags _in addition to_ what is fetched by the same
 command line without the option.
 
-The way "git push $there $what" interprets $what part given on the
+The way "git push $there $what" interprets the $what part given on the
 command line, when it does not have a colon that explicitly tells us
 what ref at the $there repository is to be updated, has been enhanced.
 
@@ -96,7 +96,7 @@ UI, Workflows & Features
    primarily because the codepaths involved were not carefully vetted
    and we did not bother supporting such usage. This release attempts
    to allow object transfer out of a shallowly-cloned repository in a
-   more controlled way (i.e. the receiver become a shallow repository
+   more controlled way (i.e. the receiver becomes a shallow repository
    with a truncated history).
 
  * Just like we give a reasonable default for "less" via the LESS
@@ -107,12 +107,12 @@ UI, Workflows & Features
    hierarchies, whose variables are predominantly three-level, were
    not completed by hitting a <TAB> in bash and zsh completions.
 
- * Fetching 'frotz' branch with "git fetch", while 'frotz/nitfol'
+ * Fetching a 'frotz' branch with "git fetch", while a 'frotz/nitfol'
    remote-tracking branch from an earlier fetch was still there, would
    error out, primarily because the command was not told that it is
    allowed to lose any information on our side.  "git fetch --prune"
-   now can be used to remove 'frotz/nitfol' to make room to fetch and
-   store 'frotz' remote-tracking branch.
+   now can be used to remove 'frotz/nitfol' to make room for fetching and
+   storing the 'frotz' remote-tracking branch.
 
  * "diff.orderfile=<file>" configuration variable can be used to
    pretend as if the "-O<file>" option were given from the command
@@ -218,7 +218,7 @@ track are contained in this release (see the maintenance releases' notes
 for details).
 
  * The pathspec matching code, while comparing two trees (e.g. "git
-   diff A B -- path1 path2") was too agrresive and failed to match
+   diff A B -- path1 path2") was too aggressive and failed to match
    some paths when multiple pathspecs were involved.
    (merge e4ddb05 as/tree-walk-fix-aggressive-short-cut later to maint).
 
@@ -227,11 +227,11 @@ for details).
    (merge b861e23 sb/repack-in-c later to maint).
 
  * An earlier update in v1.8.4.x to "git rev-list --objects" with
-   negative ref had performance regression.
+   negative ref had a performance regression.
    (merge 200abe7 jk/mark-edges-uninteresting later to maint).
 
  * A recent update to "git send-email" broke platforms where
-   /etc/ssl/certs/ directory exists, but it cannot used as SSL_ca_path
+   /etc/ssl/certs/ directory exists but cannot be used as SSL_ca_path
    (e.g. Fedora rawhide).
    (merge 01645b7 rk/send-email-ssl-cert later to maint).
 
@@ -275,8 +275,8 @@ for details).
    names.
    (merge 82246b7 nd/daemon-informative-errors-typofix later to maint).
 
- * There is no reason to have a hardcoded upper limit of the number of
-   parents for an octopus merge, created via the graft mechanism, but
+ * There is no reason to have a hardcoded upper limit for the number of
+   parents of an octopus merge, created via the graft mechanism, but
    there was.
    (merge e228c17 js/lift-parent-count-limit later to maint).
 
@@ -306,8 +306,8 @@ for details).
  * When we figure out how many file descriptors to allocate for
    keeping packfiles open, a system with non-working getrlimit() could
    cause us to die(), but because we make this call only to get a
-   rough estimate of how many is available and we do not even attempt
-   to use up all file descriptors available ourselves, it is nicer to
+   rough estimate of how many are available and we do not even attempt
+   to use up all available file descriptors ourselves, it is nicer to
    fall back to a reasonable low value rather than dying.
    (merge 491a8de jh/rlimit-nofile-fallback later to maint).
 
@@ -349,7 +349,7 @@ for details).
    Diagnose it as an error.
    (merge 5594bca nd/transport-positive-depth-only later to maint).
 
- * Remote repository URL expressed in scp-style host:path notation are
+ * Remote repository URLs expressed in scp-style host:path notation are
    parsed more carefully (e.g. "foo/bar:baz" is local, "[::1]:/~user" asks
    to connect to user's home directory on host at address ::1.
    (merge a2036d7 tb/clone-ssh-with-colon-for-port later to maint).
-- 
1.9.0.rc3.263.g4010a96

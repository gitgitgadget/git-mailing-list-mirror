From: jari.aalto@cante.net
Subject: [PATCH] git-branch.txt: order options alphabetically
Date: Wed,  1 Dec 2010 22:26:41 +0200
Organization: Private
Message-ID: <1291235201-21651-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 21:26:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNtGL-00078p-VR
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756808Ab0LAU0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 15:26:45 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:45441 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756695Ab0LAU0o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 15:26:44 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 4A8F0C7BC7
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:26:43 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0450B46914; Wed, 01 Dec 2010 22:26:43 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 304541C6385
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:26:42 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNtGD-0005dd-HL; Wed, 01 Dec 2010 22:26:41 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162603>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-branch.txt |  108 +++++++++++++++++++++---------------=
------
 1 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 9106d38..b4a56f9 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -63,6 +63,23 @@ way to clean up all obsolete remote-tracking branches.
=20
 OPTIONS
 -------
+
+-a::
+	List both remote-tracking branches and local branches.
+
+--abbrev=3D<length>::
+	Alter the sha1's minimum display length in the output listing.
+	The default value is 7.  See also `--no-abbrev'.
+
+--color[=3D<when>]::
+	Color branches to highlight current, local, and
+	remote-tracking branches.
+	The value must be always (the default), never, or auto.  See
+	also `--no-color'.
+
+--contains <commit>::
+	Only list branches which contain the specified commit.
+
 -d::
 	Delete a branch. The branch must be fully merged in its
 	upstream branch, or in `HEAD` if no upstream was set with
@@ -71,6 +88,11 @@ OPTIONS
 -D::
 	Delete a branch irrespective of its merged status.
=20
+-f::
+--force::
+	Reset <branchname> to <startpoint> if <branchname> exists
+	already. Without `-f` 'git branch' refuses to change an existing branch=
.
+
 -l::
 	Create the branch's reflog.  This activates recording of
 	all changes made to the branch ref, enabling use of date
@@ -78,45 +100,39 @@ OPTIONS
 	Note that in non-bare repositories, reflogs are usually
 	enabled by default by the `core.logallrefupdates` config option.
=20
--f::
---force::
-	Reset <branchname> to <startpoint> if <branchname> exists
-	already. Without `-f` 'git branch' refuses to change an existing branch=
.
-
 -m::
 	Move/rename a branch and the corresponding reflog.
=20
+--merged [<commit>]::
+	Only list branches whose tips are reachable from the
+	specified commit (HEAD if not specified).  See also `--no-merged'.
+
 -M::
 	Move/rename a branch even if the new branch name already exists.
=20
---color[=3D<when>]::
-	Color branches to highlight current, local, and
-	remote-tracking branches.
-	The value must be always (the default), never, or auto.
+--no-abbrev::
+	Display the full sha1s in the output listing rather than abbreviating t=
hem.
=20
 --no-color::
 	Turn off branch colors, even when the configuration file gives the
-	default to color output.
-	Same as `--color=3Dnever`.
+	default to color output.  Same as `--color=3Dnever`.
=20
--r::
-	List or delete (if used with -d) the remote-tracking branches.
-
--a::
-	List both remote-tracking branches and local branches.
+--no-merged [<commit>]::
+	Only list branches whose tips are not reachable from the
+	specified commit (HEAD if not specified).
=20
--v::
---verbose::
-	Show sha1 and commit subject line for each head, along with
-	relationship to upstream branch (if any). If given twice, print
-	the name of the upstream branch, as well.
+--no-track::
+	Do not set up "upstream" configuration, even if the
+	branch.autosetupmerge configuration variable is true.
=20
---abbrev=3D<length>::
-	Alter the sha1's minimum display length in the output listing.
-	The default value is 7.
+-r::
+	List or delete (if used with -d) the remote-tracking branches.
=20
---no-abbrev::
-	Display the full sha1s in the output listing rather than abbreviating t=
hem.
+--set-upstream::
+	If specified branch does not exist yet or if '--force' has been
+	given, acts exactly like '--track'. Otherwise sets up configuration
+	like '--track' would when creating the branch, except that where
+	branch points to is not changed.
=20
 -t::
 --track::
@@ -133,26 +149,11 @@ want `git checkout` and `git branch` to always beha=
ve as if '--no-track'
 were given. Set it to `always` if you want this behavior when the
 start-point is either a local or remote-tracking branch.
=20
---no-track::
-	Do not set up "upstream" configuration, even if the
-	branch.autosetupmerge configuration variable is true.
-
---set-upstream::
-	If specified branch does not exist yet or if '--force' has been
-	given, acts exactly like '--track'. Otherwise sets up configuration
-	like '--track' would when creating the branch, except that where
-	branch points to is not changed.
-
---contains <commit>::
-	Only list branches which contain the specified commit.
-
---merged [<commit>]::
-	Only list branches whose tips are reachable from the
-	specified commit (HEAD if not specified).
-
---no-merged [<commit>]::
-	Only list branches whose tips are not reachable from the
-	specified commit (HEAD if not specified).
+-v::
+--verbose::
+	Show sha1 and commit subject line for each head, along with
+	relationship to upstream branch (if any). If given twice, print
+	the name of the upstream branch, as well.
=20
 <branchname>::
 	The name of the branch to create or delete.
@@ -160,18 +161,17 @@ start-point is either a local or remote-tracking br=
anch.
 	linkgit:git-check-ref-format[1].  Some of these checks
 	may restrict the characters allowed in a branch name.
=20
-<start-point>::
-	The new branch head will point to this commit.  It may be
-	given as a branch name, a commit-id, or a tag.  If this
-	option is omitted, the current HEAD will be used instead.
-
-<oldbranch>::
-	The name of an existing branch to rename.
-
 <newbranch>::
 	The new name for an existing branch. The same restrictions as for
 	<branchname> apply.
=20
+<oldbranch>::
+	The name of an existing branch to rename.
+
+<start-point>::
+	The new branch head will point to this commit.  It may be
+	given as a branch name, a commit-id, or a tag.  If this
+	option is omitted, the current HEAD will be used instead.
=20
 Examples
 --------
--=20
1.7.2.3

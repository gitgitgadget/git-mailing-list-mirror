From: jari.aalto@cante.net
Subject: [PATCH] git-checkout.txt: order options alphabetically
Date: Wed,  1 Dec 2010 20:05:33 +0200
Organization: Private
Message-ID: <1291226733-17562-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 19:05:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNr3q-00080v-VL
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 19:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755808Ab0LASFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 13:05:37 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:41383 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600Ab0LASFg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 13:05:36 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 3492C8C4DD
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 20:05:35 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0248B1EFB6; Wed, 01 Dec 2010 20:05:35 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 1AA382BD48
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 20:05:33 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNr3d-0004Zg-B7; Wed, 01 Dec 2010 20:05:33 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162561>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-checkout.txt |  121 ++++++++++++++++++++--------------=
------
 1 files changed, 60 insertions(+), 61 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.=
txt
index 880763d..5e7c870 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -64,23 +64,6 @@ file can be discarded to re-create the original confli=
cted merge result.
=20
 OPTIONS
 -------
--q::
---quiet::
-	Quiet, suppress feedback messages.
-
--f::
---force::
-	When switching branches, proceed even if the index or the
-	working tree differs from HEAD.  This is used to throw away
-	local changes.
-+
-When checking out paths from the index, do not fail upon unmerged
-entries; instead, unmerged entries are ignored.
-
---ours::
---theirs::
-	When checking out paths from the index, check out stage #2
-	('ours') or #3 ('theirs') for unmerged paths.
=20
 -b::
 	Create a new branch named <new_branch> and start it at
@@ -92,28 +75,53 @@ entries; instead, unmerged entries are ignored.
 	equivalent to running "git branch" with "-f"; see
 	linkgit:git-branch[1] for details.
=20
--t::
---track::
-	When creating a new branch, set up "upstream" configuration. See
-	"--track" in linkgit:git-branch[1] for details.
+--conflict=3D<style>::
+	The same as --merge option above, but changes the way the
+	conflicting hunks are presented, overriding the
+	merge.conflictstyle configuration variable.  Possible values are
+	"merge" (default) and "diff3" (in addition to what is shown by
+	"merge" style, shows the original contents).
+
+-f::
+--force::
+	When switching branches, proceed even if the index or the
+	working tree differs from HEAD.  This is used to throw away
+	local changes.
 +
-If no '-b' option is given, the name of the new branch will be
-derived from the remote-tracking branch.  If "remotes/" or "refs/remotes=
/"
-is prefixed it is stripped away, and then the part up to the
-next slash (which would be the nickname of the remote) is removed.
-This would tell us to use "hack" as the local branch when branching
-off of "origin/hack" (or "remotes/origin/hack", or even
-"refs/remotes/origin/hack").  If the given name has no slash, or the abo=
ve
-guessing results in an empty name, the guessing is aborted.  You can
-explicitly give a name with '-b' in such a case.
+When checking out paths from the index, do not fail upon unmerged
+entries; instead, unmerged entries are ignored.
+
+-l::
+	Create the new branch's reflog; see linkgit:git-branch[1] for
+	details.
+
+-m::
+--merge::
+	When switching branches,
+	if you have local modifications to one or more files that
+	are different between the current branch and the branch to
+	which you are switching, the command refuses to switch
+	branches in order to preserve your modifications in context.
+	However, with this option, a three-way merge between the current
+	branch, your working tree contents, and the new branch
+	is done, and you will be on the new branch.
++
+When a merge conflict happens, the index entries for conflicting
+paths are left unmerged, and you need to resolve the conflicts
+and mark the resolved paths with `git add` (or `git rm` if the merge
+should result in deletion of the path).
++
+When checking out paths from the index, this option lets you recreate
+the conflicted merge in the specified paths.
=20
 --no-track::
 	Do not set up "upstream" configuration, even if the
 	branch.autosetupmerge configuration variable is true.
=20
--l::
-	Create the new branch's reflog; see linkgit:git-branch[1] for
-	details.
+--ours::
+--theirs::
+	When checking out paths from the index, check out stage #2
+	('ours') or #3 ('theirs') for unmerged paths.
=20
 --orphan::
 	Create a new 'orphan' branch, named <new_branch>, started from
@@ -140,32 +148,6 @@ branch by running "git rm -rf ." from the top level =
of the working tree.
 Afterwards you will be ready to prepare your new files, repopulating the
 working tree, by copying them from elsewhere, extracting a tarball, etc.
=20
--m::
---merge::
-	When switching branches,
-	if you have local modifications to one or more files that
-	are different between the current branch and the branch to
-	which you are switching, the command refuses to switch
-	branches in order to preserve your modifications in context.
-	However, with this option, a three-way merge between the current
-	branch, your working tree contents, and the new branch
-	is done, and you will be on the new branch.
-+
-When a merge conflict happens, the index entries for conflicting
-paths are left unmerged, and you need to resolve the conflicts
-and mark the resolved paths with `git add` (or `git rm` if the merge
-should result in deletion of the path).
-+
-When checking out paths from the index, this option lets you recreate
-the conflicted merge in the specified paths.
-
---conflict=3D<style>::
-	The same as --merge option above, but changes the way the
-	conflicting hunks are presented, overriding the
-	merge.conflictstyle configuration variable.  Possible values are
-	"merge" (default) and "diff3" (in addition to what is shown by
-	"merge" style, shows the original contents).
-
 -p::
 --patch::
 	Interactively select hunks in the difference between the
@@ -176,6 +158,25 @@ the conflicted merge in the specified paths.
 This means that you can use `git checkout -p` to selectively discard
 edits from your current working tree.
=20
+-q::
+--quiet::
+	Quiet, suppress feedback messages.
+
+-t::
+--track::
+	When creating a new branch, set up "upstream" configuration. See
+	"--track" in linkgit:git-branch[1] for details.
++
+If no '-b' option is given, the name of the new branch will be
+derived from the remote-tracking branch.  If "remotes/" or "refs/remotes=
/"
+is prefixed it is stripped away, and then the part up to the
+next slash (which would be the nickname of the remote) is removed.
+This would tell us to use "hack" as the local branch when branching
+off of "origin/hack" (or "remotes/origin/hack", or even
+"refs/remotes/origin/hack").  If the given name has no slash, or the abo=
ve
+guessing results in an empty name, the guessing is aborted.  You can
+explicitly give a name with '-b' in such a case.
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
@@ -202,8 +203,6 @@ leave out at most one of `A` and `B`, in which case i=
t defaults to `HEAD`.
 	Tree to checkout from (when paths are given). If not specified,
 	the index will be used.
=20
-
-
 Detached HEAD
 -------------
=20
--=20
1.7.2.3

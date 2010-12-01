From: jari.aalto@cante.net
Subject: [PATCH] git-push.txt: order options alphabetically
Date: Wed,  1 Dec 2010 22:12:25 +0200
Organization: Private
Message-ID: <1291234345-21070-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 21:12:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNt2r-0000Kk-1l
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756880Ab0LAUMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 15:12:30 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:42968 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756862Ab0LAUM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 15:12:29 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id CFBF0C7E0D
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:12:27 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A01755CBBF7; Wed, 01 Dec 2010 22:12:27 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id AC920158A69
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:12:26 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNt2P-0005UG-H0; Wed, 01 Dec 2010 22:12:25 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162598>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-push.txt |  142 ++++++++++++++++++++++----------------=
------
 1 files changed, 72 insertions(+), 70 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index e11660a..0cc5b88 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -26,51 +26,22 @@ documentation for linkgit:git-receive-pack[1].
=20
 OPTIONS[[OPTIONS]]
 ------------------
-<repository>::
-	The "remote" repository that is destination of a push
-	operation.  This parameter can be either a URL
-	(see the section <<URLS,GIT URLS>> below) or the name
-	of a remote (see the section <<REMOTES,REMOTES>> below).
-
-<refspec>...::
-	The format of a <refspec> parameter is an optional plus
-	`{plus}`, followed by the source ref <src>, followed
-	by a colon `:`, followed by the destination ref <dst>.
-	It is used to specify with what <src> object the <dst> ref
-	in the remote repository is to be updated.
-+
-The <src> is often the name of the branch you would want to push, but
-it can be any arbitrary "SHA-1 expression", such as `master~4` or
-`HEAD` (see linkgit:gitrevisions[7]).
-+
-The <dst> tells which ref on the remote side is updated with this
-push. Arbitrary expressions cannot be used here, an actual ref must
-be named. If `:`<dst> is omitted, the same ref as <src> will be
-updated.
-+
-The object referenced by <src> is used to update the <dst> reference
-on the remote side, but by default this is only allowed if the
-update can fast-forward <dst>.  By having the optional leading `{plus}`,
-you can tell git to update the <dst> ref even when the update is not a
-fast-forward.  This does *not* attempt to merge <src> into <dst>.  See
-EXAMPLES below for details.
-+
-`tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
-+
-Pushing an empty <src> allows you to delete the <dst> ref from
-the remote repository.
-+
-The special refspec `:` (or `{plus}:` to allow non-fast-forward updates)
-directs git to push "matching" branches: for every branch that exists on
-the local side, the remote side is updated if a branch of the same name
-already exists on the remote side.  This is the default operation mode
-if no explicit refspec is found (that is neither on the command line
-nor in any Push line of the corresponding remotes file---see below).
=20
 --all::
 	Instead of naming each ref to push, specifies that all
 	refs under `refs/heads/` be pushed.
=20
+--delete::
+	All listed refs are deleted from the remote repository. This is
+	the same as prefixing all refs with a colon.
+
+-f::
+--force::
+	Usually, the command refuses to update a remote ref that is
+	not an ancestor of the local ref used to overwrite it.
+	This flag disables the check.  This can cause the
+	remote repository to lose commits; use it with care.
+
 --mirror::
 	Instead of naming each ref to push, specifies that all
 	refs under `refs/` (which includes but is not
@@ -91,14 +62,17 @@ nor in any Push line of the corresponding remotes fil=
e---see below).
 	will be tab-separated and sent to stdout instead of stderr.  The full
 	symbolic names of the refs will be given.
=20
---delete::
-	All listed refs are deleted from the remote repository. This is
-	the same as prefixing all refs with a colon.
+--progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless -q
+	is specified. This flag forces progress status even if the
+	standard error stream is not directed to a terminal.
=20
---tags::
-	All refs under `refs/tags` are pushed, in
-	addition to refspecs explicitly listed on the command
-	line.
+-q::
+--quiet::
+	Suppress all output, including the listing of updated refs,
+	unless an error occurs. Progress is not reported to the standard
+	error stream.
=20
 --receive-pack=3D<git-receive-pack>::
 --exec=3D<git-receive-pack>::
@@ -107,13 +81,6 @@ nor in any Push line of the corresponding remotes fil=
e---see below).
 	repository over ssh, and you do not have the program in
 	a directory on the default $PATH.
=20
--f::
---force::
-	Usually, the command refuses to update a remote ref that is
-	not an ancestor of the local ref used to overwrite it.
-	This flag disables the check.  This can cause the
-	remote repository to lose commits; use it with care.
-
 --repo=3D<repository>::
 	This option is only relevant if no <repository> argument is
 	passed in the invocation. In this case, 'git push' derives the
@@ -132,12 +99,10 @@ is that #1 always pushes to "public" whereas #2 push=
es to "public"
 only if the current branch does not track a remote branch. This is
 useful if you write an alias or script around 'git push'.
=20
--u::
---set-upstream::
-	For every branch that is up to date or successfully pushed, add
-	upstream (tracking) reference, used by argument-less
-	linkgit:git-pull[1] and other commands. For more information,
-	see 'branch.<name>.merge' in linkgit:git-config[1].
+--tags::
+	All refs under `refs/tags` are pushed, in
+	addition to refspecs explicitly listed on the command
+	line.
=20
 --thin::
 --no-thin::
@@ -146,21 +111,58 @@ useful if you write an alias or script around 'git =
push'.
 	receiver share many of the same objects in common. The default is
 	\--thin.
=20
--q::
---quiet::
-	Suppress all output, including the listing of updated refs,
-	unless an error occurs. Progress is not reported to the standard
-	error stream.
+-u::
+--set-upstream::
+	For every branch that is up to date or successfully pushed, add
+	upstream (tracking) reference, used by argument-less
+	linkgit:git-pull[1] and other commands. For more information,
+	see 'branch.<name>.merge' in linkgit:git-config[1].
=20
 -v::
 --verbose::
 	Run verbosely.
=20
---progress::
-	Progress status is reported on the standard error stream
-	by default when it is attached to a terminal, unless -q
-	is specified. This flag forces progress status even if the
-	standard error stream is not directed to a terminal.
+<refspec>...::
+	The format of a <refspec> parameter is an optional plus
+	`{plus}`, followed by the source ref <src>, followed
+	by a colon `:`, followed by the destination ref <dst>.
+	It is used to specify with what <src> object the <dst> ref
+	in the remote repository is to be updated.
++
+The <src> is often the name of the branch you would want to push, but
+it can be any arbitrary "SHA-1 expression", such as `master~4` or
+`HEAD` (see linkgit:gitrevisions[7]).
++
+The <dst> tells which ref on the remote side is updated with this
+push. Arbitrary expressions cannot be used here, an actual ref must
+be named. If `:`<dst> is omitted, the same ref as <src> will be
+updated.
++
+The object referenced by <src> is used to update the <dst> reference
+on the remote side, but by default this is only allowed if the
+update can fast-forward <dst>.  By having the optional leading `{plus}`,
+you can tell git to update the <dst> ref even when the update is not a
+fast-forward.  This does *not* attempt to merge <src> into <dst>.  See
+EXAMPLES below for details.
++
+`tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
++
+Pushing an empty <src> allows you to delete the <dst> ref from
+the remote repository.
++
+The special refspec `:` (or `{plus}:` to allow non-fast-forward updates)
+directs git to push "matching" branches: for every branch that exists on
+the local side, the remote side is updated if a branch of the same name
+already exists on the remote side.  This is the default operation mode
+if no explicit refspec is found (that is neither on the command line
+nor in any Push line of the corresponding remotes file---see below).
+
+<repository>::
+	The "remote" repository that is destination of a push
+	operation.  This parameter can be either a URL
+	(see the section <<URLS,GIT URLS>> below) or the name
+	of a remote (see the section <<REMOTES,REMOTES>> below).
+
=20
 include::urls-remotes.txt[]
=20
--=20
1.7.2.3

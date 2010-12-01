From: jari.aalto@cante.net
Subject: [PATCH] git-cherry-pick.txt: order options alphabetically
Date: Wed,  1 Dec 2010 22:02:55 +0200
Organization: Private
Message-ID: <1291233775-20619-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 21:03:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNstM-0003q1-LL
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834Ab0LAUC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 15:02:59 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:36594 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353Ab0LAUC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 15:02:58 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 9F031EF14B
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:02:57 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A011598D1F1; Wed, 01 Dec 2010 22:02:57 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 892A6402E
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:02:56 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNstD-0005Mz-Jb; Wed, 01 Dec 2010 22:02:55 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162594>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-cherry-pick.txt |   57 +++++++++++++++++++------------=
------
 1 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry=
-pick.txt
index 3c96fa8..6abde39 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -18,36 +18,16 @@ working tree to be clean (no modifications from the H=
EAD commit).
=20
 OPTIONS
 -------
-<commit>...::
-	Commits to cherry-pick.
-	For a more complete list of ways to spell commits, see
-	linkgit:gitrevisions[7].
-	Sets of commits can be passed but no traversal is done by
-	default, as if the '--no-walk' option was specified, see
-	linkgit:git-rev-list[1].
=20
 -e::
 --edit::
 	With this option, 'git cherry-pick' will let you edit the commit
 	message prior to committing.
=20
--x::
-	When recording the commit, append to the original commit
-	message a note that indicates which commit this change
-	was cherry-picked from.  Append the note only for cherry
-	picks without conflicts.  Do not use this option if
-	you are cherry-picking from your private branch because
-	the information is useless to the recipient.  If on the
-	other hand you are cherry-picking between two publicly
-	visible branches (e.g. backporting a fix to a
-	maintenance branch for an older release from a
-	development branch), adding this information can be
-	useful.
-
--r::
-	It used to be that the command defaulted to do `-x`
-	described above, and `-r` was to disable it.  Now the
-	default is not to do `-x` so this option is a no-op.
+--ff::
+	If the current HEAD is the same as the parent of the
+	cherry-pick'ed commit, then a fast forward to this commit will
+	be performed.
=20
 -m parent-number::
 --mainline parent-number::
@@ -70,14 +50,35 @@ OPTIONS
 This is useful when cherry-picking more than one commits'
 effect to your index in a row.
=20
+-r::
+	It used to be that the command defaulted to do `-x`
+	described above, and `-r` was to disable it.  Now the
+	default is not to do `-x` so this option is a no-op.
+
 -s::
 --signoff::
 	Add Signed-off-by line at the end of the commit message.
=20
---ff::
-	If the current HEAD is the same as the parent of the
-	cherry-pick'ed commit, then a fast forward to this commit will
-	be performed.
+-x::
+	When recording the commit, append to the original commit
+	message a note that indicates which commit this change
+	was cherry-picked from.  Append the note only for cherry
+	picks without conflicts.  Do not use this option if
+	you are cherry-picking from your private branch because
+	the information is useless to the recipient.  If on the
+	other hand you are cherry-picking between two publicly
+	visible branches (e.g. backporting a fix to a
+	maintenance branch for an older release from a
+	development branch), adding this information can be
+	useful.
+
+<commit>...::
+	Commits to cherry-pick.
+	For a more complete list of ways to spell commits, see
+	linkgit:gitrevisions[7].
+	Sets of commits can be passed but no traversal is done by
+	default, as if the '--no-walk' option was specified, see
+	linkgit:git-rev-list[1].
=20
 EXAMPLES
 --------
--=20
1.7.2.3

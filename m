From: jari.aalto@cante.net
Subject: [PATCH] git-reset.txt: (git reset): order options alphabetically
Date: Wed,  1 Dec 2010 20:09:30 +0200
Organization: Private
Message-ID: <1291226970-17779-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 19:09:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNr7a-0001Tn-GX
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 19:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755658Ab0LASJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 13:09:33 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:43981 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab0LASJc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 13:09:32 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id BC14AC8377
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 20:09:31 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0286C9E624; Wed, 01 Dec 2010 20:09:31 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id AE51641BE6
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 20:09:30 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNr7S-0004dB-5r; Wed, 01 Dec 2010 20:09:30 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162562>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-reset.txt |   43 ++++++++++++++++++++++---------------=
------
 1 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index fd72976..e89956f 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -49,21 +49,21 @@ linkgit:git-add[1]).
 	must be one of the following:
 +
 --
---soft::
-	Does not touch the index file nor the working tree at all (but
-	resets the head to <commit>, just like all modes do). This leaves
-	all your changed files "Changes to be committed", as 'git status'
-	would put it.
-
---mixed::
-	Resets the index but not the working tree (i.e., the changed files
-	are preserved but not marked for commit) and reports what has not
-	been updated. This is the default action.
-
 --hard::
 	Resets the index and working tree. Any changes to tracked files in the
 	working tree since <commit> are discarded.
=20
+--keep::
+	Resets the index, updates files in the working tree that are
+	different between <commit> and HEAD, but keeps those
+	which are different between HEAD and the working tree (i.e.
+	which have local changes).
+	If a file that is different between <commit> and HEAD has local changes=
,
+	reset is aborted.
++
+In other words, --keep does a 2-way merge between <commit> and HEAD foll=
owed by
+'git reset --mixed <commit>'.
+
 --merge::
 	Resets the index and updates the files in the working tree that are
 	different between <commit> and HEAD, but keeps those which are
@@ -75,16 +75,17 @@ linkgit:git-add[1]).
 In other words, --merge does something like a 'git read-tree -u -m <comm=
it>',
 but carries forward unmerged index entries.
=20
---keep::
-	Resets the index, updates files in the working tree that are
-	different between <commit> and HEAD, but keeps those
-	which are different between HEAD and the working tree (i.e.
-	which have local changes).
-	If a file that is different between <commit> and HEAD has local changes=
,
-	reset is aborted.
-+
-In other words, --keep does a 2-way merge between <commit> and HEAD foll=
owed by
-'git reset --mixed <commit>'.
+--mixed::
+	Resets the index but not the working tree (i.e., the changed files
+	are preserved but not marked for commit) and reports what has not
+	been updated. This is the default action.
+
+--soft::
+	Does not touch the index file nor the working tree at all (but
+	resets the head to <commit>, just like all modes do). This leaves
+	all your changed files "Changes to be committed", as 'git status'
+	would put it.
+
 --
=20
 If you want to undo a commit other than the latest on a branch,
--=20
1.7.2.3

From: jari.aalto@cante.net
Subject: [PATCH] Documentation/gitk.txt: order options alphabetically
Date: Wed,  1 Dec 2010 19:33:15 +0200
Organization: Private
Message-ID: <1291224795-16445-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 18:33:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNqYY-00058P-D5
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 18:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab0LARdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 12:33:20 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:43273 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab0LARdT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 12:33:19 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 3A6B6EC11D
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 19:33:18 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A028A32FB63; Wed, 01 Dec 2010 19:33:18 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 2662B2BD45
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 19:33:16 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNqYN-0004Hf-NZ; Wed, 01 Dec 2010 19:33:15 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162553>

From: Jari Aalto <jari.aalto@cante.net>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/gitk.txt |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index e21bac4..28c5784 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -26,23 +26,17 @@ the 'git rev-list' command (see linkgit:git-rev-list[=
1]).
 This manual page describes only the most
 frequently used options.
=20
--n <number>::
---max-count=3D<number>::
-
-	Limits the number of commits to show.
-
---since=3D<date>::
-
-	Show commits more recent than a specific date.
-
---until=3D<date>::
-
-	Show commits older than a specific date.
-
 --all::
=20
 	Show all branches.
=20
+--argscmd=3D<command>::
+	Command to be run each time gitk has to determine the list of
+	<revs> to show.  The command is expected to print on its standard
+	output a list of additional revs to be shown, one per line.
+	Use this instead of explicitly specifying <revs> if the set of
+	commits to show may vary between refreshes.
+
 --merge::
=20
 	After an attempt to merge stops with conflicts, show the commits on
@@ -50,18 +44,24 @@ frequently used options.
 	that modify the conflicted files and do not exist on all the heads
 	being merged.
=20
---argscmd=3D<command>::
-	Command to be run each time gitk has to determine the list of
-	<revs> to show.  The command is expected to print on its standard
-	output a list of additional revs to be shown, one per line.
-	Use this instead of explicitly specifying <revs> if the set of
-	commits to show may vary between refreshes.
+-n <number>::
+--max-count=3D<number>::
+
+	Limits the number of commits to show.
=20
 --select-commit=3D<ref>::
=20
 	Automatically select the specified commit after loading the graph.
 	Default behavior is equivalent to specifying '--select-commit=3DHEAD'.
=20
+--since=3D<date>::
+
+	Show commits more recent than a specific date.
+
+--until=3D<date>::
+
+	Show commits older than a specific date.
+
 <revs>::
=20
 	Limit the revisions to show. This can be either a single revision
--=20
1.7.2.3

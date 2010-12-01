From: jari.aalto@cante.net
Subject: [PATCH] git-reflog.txt: order options alphabetically
Date: Wed,  1 Dec 2010 22:53:17 +0200
Organization: Private
Message-ID: <1291236797-22530-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 21:53:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNtg6-0003We-2H
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201Ab0LAUxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 15:53:20 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:48711 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856Ab0LAUxU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 15:53:20 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 2C9B78BFB6
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:53:19 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A031E829E3E; Wed, 01 Dec 2010 22:53:19 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 1BCC1E51A6
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:53:17 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNtfx-0005ro-75; Wed, 01 Dec 2010 22:53:17 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162611>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-reflog.txt |   38 +++++++++++++++++++-----------------=
--
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index e50bd9b..d45e3fe 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -50,18 +50,8 @@ and specify the _exact_ entry (e.g. "`git reflog delet=
e master@\{2\}`").
 OPTIONS
 -------
=20
---stale-fix::
-	This revamps the logic -- the definition of "broken commit"
-	becomes: a commit that is not reachable from any of the refs and
-	there is a missing object among the commit, tree, or blob
-	objects reachable from it that is not reachable from any of the
-	refs.
-+
-This computation involves traversing all the reachable objects, i.e. it
-has the same cost as 'git prune'.  Fortunately, once this is run, we
-should not have to ever worry about missing objects, because the current
-prune and pack-objects know about reflogs and protect objects referred b=
y
-them.
+--all::
+	Instead of listing <refs> explicitly, prune all refs.
=20
 --expire=3D<time>::
 	Entries older than this time are pruned.  Without the
@@ -75,18 +65,28 @@ them.
 	`gc.reflogExpireUnreachable`, which in turn defaults to
 	30 days.
=20
---all::
-	Instead of listing <refs> explicitly, prune all refs.
-
---updateref::
-	Update the ref with the sha1 of the top reflog entry (i.e.
-	<ref>@\{0\}) after expiring or deleting.
-
 --rewrite::
 	While expiring or deleting, adjust each reflog entry to ensure
 	that the `old` sha1 field points to the `new` sha1 field of the
 	previous entry.
=20
+--stale-fix::
+	This revamps the logic -- the definition of "broken commit"
+	becomes: a commit that is not reachable from any of the refs and
+	there is a missing object among the commit, tree, or blob
+	objects reachable from it that is not reachable from any of the
+	refs.
++
+This computation involves traversing all the reachable objects, i.e. it
+has the same cost as 'git prune'.  Fortunately, once this is run, we
+should not have to ever worry about missing objects, because the current
+prune and pack-objects know about reflogs and protect objects referred b=
y
+them.
+
+--updateref::
+	Update the ref with the sha1 of the top reflog entry (i.e.
+	<ref>@\{0\}) after expiring or deleting.
+
 --verbose::
 	Print extra information on screen.
=20
--=20
1.7.2.3

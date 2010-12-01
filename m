From: jari.aalto@cante.net
Subject: [PATCH] merge-options.txt: order options alphabetically
Date: Wed,  1 Dec 2010 19:36:37 +0200
Organization: Private
Message-ID: <1291224997-16813-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 18:36:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNqbm-0007J8-DZ
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 18:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329Ab0LARgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 12:36:41 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:36831 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755111Ab0LARgk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 12:36:40 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 6F69BC7CA0
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 19:36:39 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A02BE56BF50; Wed, 01 Dec 2010 19:36:39 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 6251941BE2
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 19:36:38 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNqbd-0004Nb-Ry; Wed, 01 Dec 2010 19:36:37 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162554>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/merge-options.txt |   51 +++++++++++++++++++--------------=
------
 1 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-option=
s.txt
index e33e0f8..15b6236 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -16,6 +16,11 @@ inspect and further tweak the merge result before comm=
itting.
 With --no-ff Generate a merge commit even if the merge
 resolved as a fast-forward.
=20
+--ff-only::
+	Refuse to merge and exit with a non-zero status unless the
+	current `HEAD` is already up-to-date or the merge can be
+	resolved as a fast-forward.
+
 --log[=3D<n>]::
 --no-log::
 	In addition to branch names, populate the log message with
@@ -25,15 +30,13 @@ resolved as a fast-forward.
 With --no-log do not list one-line descriptions from the
 actual commits being merged.
=20
-
---stat::
--n::
---no-stat::
-	Show a diffstat at the end of the merge. The diffstat is also
-	controlled by the configuration option merge.stat.
-+
-With -n or --no-stat do not show a diffstat at the end of the
-merge.
+-s <strategy>::
+--strategy=3D<strategy>::
+	Use the given merge strategy; can be supplied more than
+	once to specify them in the order they should be tried.
+	If there is no `-s` option, a built-in list of strategies
+	is used instead ('git merge-recursive' when merging a single
+	head, 'git merge-octopus' otherwise).
=20
 --squash::
 --no-squash::
@@ -49,23 +52,14 @@ merge.
 With --no-squash perform the merge and commit the result. This
 option can be used to override --squash.
=20
---ff-only::
-	Refuse to merge and exit with a non-zero status unless the
-	current `HEAD` is already up-to-date or the merge can be
-	resolved as a fast-forward.
-
--s <strategy>::
---strategy=3D<strategy>::
-	Use the given merge strategy; can be supplied more than
-	once to specify them in the order they should be tried.
-	If there is no `-s` option, a built-in list of strategies
-	is used instead ('git merge-recursive' when merging a single
-	head, 'git merge-octopus' otherwise).
-
--X <option>::
---strategy-option=3D<option>::
-	Pass merge strategy specific option through to the merge
-	strategy.
+--stat::
+-n::
+--no-stat::
+	Show a diffstat at the end of the merge. The diffstat is also
+	controlled by the configuration option merge.stat.
++
+With -n or --no-stat do not show a diffstat at the end of the
+merge.
=20
 --summary::
 --no-summary::
@@ -77,6 +71,11 @@ ifndef::git-pull[]
 --quiet::
 	Operate quietly.
=20
+-X <option>::
+--strategy-option=3D<option>::
+	Pass merge strategy specific option through to the merge
+	strategy.
+
 -v::
 --verbose::
 	Be verbose.
--=20
1.7.2.3

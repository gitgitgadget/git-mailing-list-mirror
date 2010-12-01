From: jari.aalto@cante.net
Subject: [PATCH] git-revert.txt: order options alphabetically
Date: Wed,  1 Dec 2010 22:55:13 +0200
Organization: Private
Message-ID: <1291236913-22693-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 21:55:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNthz-0004XU-7N
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179Ab0LAUzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 15:55:17 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:58730 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002Ab0LAUzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 15:55:16 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 2D8A18C674
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:55:15 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0570A2A882; Wed, 01 Dec 2010 22:55:15 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 1769141BE5
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:55:14 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNthp-0005uR-Hi; Wed, 01 Dec 2010 22:55:13 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162612>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-revert.txt |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index f40984d..5dcaddf 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -28,13 +28,6 @@ both will discard uncommitted changes in your working =
directory.
=20
 OPTIONS
 -------
-<commit>...::
-	Commits to revert.
-	For a more complete list of ways to spell commit names, see
-	linkgit:gitrevisions[7].
-	Sets of commits can also be given but no traversal is done by
-	default, see linkgit:git-rev-list[1] and its '--no-walk'
-	option.
=20
 -e::
 --edit::
@@ -58,10 +51,6 @@ reverted merge.  This may or may not be what you want.
 See the link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-T=
o] for
 more details.
=20
---no-edit::
-	With this option, 'git revert' will not start the commit
-	message editor.
-
 -n::
 --no-commit::
 	Usually the command automatically creates some commits with
@@ -76,10 +65,23 @@ more details.
 This is useful when reverting more than one commits'
 effect to your index in a row.
=20
+--no-edit::
+	With this option, 'git revert' will not start the commit
+	message editor.
+
 -s::
 --signoff::
 	Add Signed-off-by line at the end of the commit message.
=20
+<commit>...::
+	Commits to revert.
+	For a more complete list of ways to spell commit names, see
+	linkgit:gitrevisions[7].
+	Sets of commits can also be given but no traversal is done by
+	default, see linkgit:git-rev-list[1] and its '--no-walk'
+	option.
+
+
 EXAMPLES
 --------
 git revert HEAD~3::
--=20
1.7.2.3

From: jari.aalto@cante.net
Subject: [PATCH] git-pull.txt, merge-options.txt: order options alphabetically
Date: Wed,  1 Dec 2010 22:51:18 +0200
Organization: Private
Message-ID: <1291236678-22365-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 21:51:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNteB-0002L8-M5
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757109Ab0LAUvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 15:51:23 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:57930 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018Ab0LAUvW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 15:51:22 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id DF53BEBE5D
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:51:20 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A031C3A77AC; Wed, 01 Dec 2010 22:51:20 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id C5D76E51A4
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:51:19 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNte3-0005p9-1C; Wed, 01 Dec 2010 22:51:19 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162610>

From: Jari Aalto <jari.aalto@cante.net>

Remove idndef from merge-options.txt because only two generic -q nad
-v options were used. Simplify git-pull.txt by dropping dependency on
merge-options.txt and copy definitions of -q and -v in order to list
all comman generic options in alphabetical order.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-pull.txt      |   14 ++++++++----
 Documentation/merge-options.txt |   44 ++++++++++++++++++---------------=
-----
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index e47361f..1648237 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -87,11 +87,12 @@ must be given before the options meant for 'git fetch=
'.
 Options related to merging
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
-include::merge-options.txt[]
-
-:git-pull: 1
+-q::
+--quiet::
+	Operate quietly.
=20
 --rebase::
+--no-rebase::
 	Rebase the current branch on top of the upstream branch after
 	fetching.  If there is a remote-tracking branch corresponding to
 	the upstream branch and the upstream branch was rebased since last
@@ -107,8 +108,11 @@ It rewrites history, which does not bode well when y=
ou
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
=20
---no-rebase::
-	Override earlier --rebase.
+	With `--no-rebase' Override earlier `--rebase'.
+
+-v::
+--verbose::
+	Be verbose.
=20
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/merge-options.txt b/Documentation/merge-option=
s.txt
index e33e0f8..684b7be 100644
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
@@ -25,15 +30,9 @@ resolved as a fast-forward.
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
+-q::
+--quiet::
+	Operate quietly.
=20
 --squash::
 --no-squash::
@@ -49,11 +48,6 @@ merge.
 With --no-squash perform the merge and commit the result. This
 option can be used to override --squash.
=20
---ff-only::
-	Refuse to merge and exit with a non-zero status unless the
-	current `HEAD` is already up-to-date or the merge can be
-	resolved as a fast-forward.
-
 -s <strategy>::
 --strategy=3D<strategy>::
 	Use the given merge strategy; can be supplied more than
@@ -62,22 +56,26 @@ option can be used to override --squash.
 	is used instead ('git merge-recursive' when merging a single
 	head, 'git merge-octopus' otherwise).
=20
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
 	Synonyms to --stat and --no-stat; these are deprecated and will be
 	removed in the future.
=20
-ifndef::git-pull[]
--q::
---quiet::
-	Operate quietly.
+-X <option>::
+--strategy-option=3D<option>::
+	Pass merge strategy specific option through to the merge
+	strategy.
=20
 -v::
 --verbose::
 	Be verbose.
-endif::git-pull[]
+
--=20
1.7.2.3

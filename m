From: jari.aalto@cante.net
Subject: [PATCH] Documentation/*merge*.txt: Order options alphabetically
Date: Wed,  1 Dec 2010 22:00:47 +0200
Organization: Private
Message-ID: <1291233647-20494-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 21:00:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNsrI-0002gk-FU
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756645Ab0LAUAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 15:00:51 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:35993 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756Ab0LAUAu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 15:00:50 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 7F01AEF658
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:00:49 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A00CCC7753E; Wed, 01 Dec 2010 22:00:49 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 5AB4E1C638A
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:00:48 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNsr9-0005Kz-Sd; Wed, 01 Dec 2010 22:00:47 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162593>

From: Jari Aalto <jari.aalto@cante.net>

In git-merge.txt, define asciidoc variable to flag processing in
merge-options.txt. Move all options from git-merge.txt to
merge-options.txt so that that options can be presented in
alphabetical order.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-merge.txt     |   19 +----------
 Documentation/merge-options.txt |   66 +++++++++++++++++++++++++--------=
-----
 2 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index d43416d..4a62d36 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -51,26 +51,11 @@ new scripts.  It is the same as `git merge -m <msg> <=
commit>...`.
 discouraged: while possible, it leaves you in a state that is hard to
 back out of in the case of a conflict.
=20
-
 OPTIONS
 -------
-include::merge-options.txt[]
=20
--m <msg>::
-	Set the commit message to be used for the merge commit (in
-	case one is created).
-+
-If `--log` is specified, a shortlog of the commits being merged
-will be appended to the specified message.
-+
-The 'git fmt-merge-msg' command can be
-used to give a good default for automated 'git merge'
-invocations.
-
---rerere-autoupdate::
---no-rerere-autoupdate::
-	Allow the rerere mechanism to update the index with the
-	result of auto-conflict resolution if possible.
+:git-merge: 1
+include::merge-options.txt[]
=20
 <commit>...::
 	Commits, usually other branch heads, to merge into our branch.
diff --git a/Documentation/merge-options.txt b/Documentation/merge-option=
s.txt
index e33e0f8..29aef16 100644
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
@@ -25,6 +30,38 @@ resolved as a fast-forward.
 With --no-log do not list one-line descriptions from the
 actual commits being merged.
=20
+ifdef::git-merge[]
+-m <msg>::
+	Set the commit message to be used for the merge commit (in
+	case one is created).
++
+If `--log` is specified, a shortlog of the commits being merged
+will be appended to the specified message.
++
+The 'git fmt-merge-msg' command can be
+used to give a good default for automated 'git merge'
+invocations.
+endif::git-merge[]
+
+ifndef::git-pull[]
+-q::
+--quiet::
+	Operate quietly.
+
+ifdef::git-merge[]
+--rerere-autoupdate::
+--no-rerere-autoupdate::
+	Allow the rerere mechanism to update the index with the
+	result of auto-conflict resolution if possible.
+endif::git-merge[]
+
+-s <strategy>::
+--strategy=3D<strategy>::
+	Use the given merge strategy; can be supplied more than
+	once to specify them in the order they should be tried.
+	If there is no `-s` option, a built-in list of strategies
+	is used instead ('git merge-recursive' when merging a single
+	head, 'git merge-octopus' otherwise).
=20
 --stat::
 -n::
@@ -49,35 +86,18 @@ merge.
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
-
 --summary::
 --no-summary::
 	Synonyms to --stat and --no-stat; these are deprecated and will be
 	removed in the future.
=20
-ifndef::git-pull[]
--q::
---quiet::
-	Operate quietly.
-
 -v::
 --verbose::
 	Be verbose.
 endif::git-pull[]
+
+-X <option>::
+--strategy-option=3D<option>::
+	Pass merge strategy specific option through to the merge
+	strategy.
+
--=20
1.7.2.3

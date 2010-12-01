From: jari.aalto@cante.net
Subject: [PATCH] git-log.txt: order options alphabetically
Date: Wed,  1 Dec 2010 20:20:40 +0200
Organization: Private
Message-ID: <1291227640-18108-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 19:20:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNrIO-0007sQ-Nq
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 19:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034Ab0LASUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 13:20:44 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:46307 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab0LASUn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 13:20:43 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 22E99C8363
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 20:20:42 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A056A91CDF2; Wed, 01 Dec 2010 20:20:42 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 0A71B2BD43
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 20:20:40 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNrIG-0004iU-I1; Wed, 01 Dec 2010 20:20:40 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162566>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-log.txt |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index ff41784..274b875 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -26,29 +26,10 @@ OPTIONS
 -<n>::
 	Limits the number of commits to show.
=20
-<since>..<until>::
-	Show only commits between the named two commits.  When
-	either <since> or <until> is omitted, it defaults to
-	`HEAD`, i.e. the tip of the current branch.
-	For a more complete list of ways to spell <since>
-	and <until>, see linkgit:gitrevisions[7].
-
 --follow::
 	Continue listing the history of a file beyond renames
 	(works only for a single file).
=20
---no-decorate::
---decorate[=3Dshort|full|no]::
-	Print out the ref names of any commits that are shown. If 'short' is
-	specified, the ref name prefixes 'refs/heads/', 'refs/tags/' and
-	'refs/remotes/' will not be printed. If 'full' is specified, the
-	full ref name (including prefix) will be printed. The default option
-	is 'short'.
-
---source::
-	Print out the ref name given on the command line by which each
-	commit was reached.
-
 --full-diff::
 	Without this flag, "git log -p <path>..." shows commits that
 	touch the specified paths, and diffs about the same specified
@@ -66,12 +47,31 @@ produced by --stat etc.
 	Note that only message is considered, if also a diff is shown
 	its size is not included.
=20
+--no-decorate::
+--decorate[=3Dshort|full|no]::
+	Print out the ref names of any commits that are shown. If 'short' is
+	specified, the ref name prefixes 'refs/heads/', 'refs/tags/' and
+	'refs/remotes/' will not be printed. If 'full' is specified, the
+	full ref name (including prefix) will be printed. The default option
+	is 'short'.
+
+--source::
+	Print out the ref name given on the command line by which each
+	commit was reached.
+
 [\--] <path>...::
 	Show only commits that affect any of the specified paths. To
 	prevent confusion with options and branch names, paths may need
 	to be prefixed with "\-- " to separate them from options or
 	refnames.
=20
+<since>..<until>::
+	Show only commits between the named two commits.  When
+	either <since> or <until> is omitted, it defaults to
+	`HEAD`, i.e. the tip of the current branch.
+	For a more complete list of ways to spell <since>
+	and <until>, see linkgit:gitrevisions[7].
+
 Common diff options
 ~~~~~~~~~~~~~~~~~~~
=20
--=20
1.7.2.3

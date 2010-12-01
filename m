From: jari.aalto@cante.net
Subject: [PATCH] git-rm.txt: Order options alphabetically
Date: Wed,  1 Dec 2010 17:44:50 +0200
Organization: Private
Message-ID: <1291218290-13159-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 16:45:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNorb-0003Yh-7l
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 16:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688Ab0LAPoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 10:44:54 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:37778 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab0LAPox (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 10:44:53 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id B249B18CFAF
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 17:44:52 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A04062AF928; Wed, 01 Dec 2010 17:44:52 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 9C85CE51A3
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 17:44:51 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNorT-0003Qf-16; Wed, 01 Dec 2010 17:44:51 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162536>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-rm.txt |   44 +++++++++++++++++++++-------------------=
----
 1 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 71e3d9f..5478e0c 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -22,29 +22,31 @@ When `--cached` is given, the staged content has to
 match either the tip of the branch or the file on disk,
 allowing the file to be removed from just the index.
=20
-
 OPTIONS
 -------
-<file>...::
-	Files to remove.  Fileglobs (e.g. `*.c`) can be given to
-	remove all matching files.  If you want git to expand
-	file glob characters, you may need to shell-escape them.
-	A leading directory name
-	(e.g. `dir` to remove `dir/file1` and `dir/file2`) can be
-	given to remove all files in the directory, and recursively
-	all sub-directories,
-	but this requires the `-r` option to be explicitly given.
+
+--cached::
+	Use this option to unstage and remove paths only from the index.
+	Working tree files, whether modified or not, will be
+	left alone.
=20
 -f::
 --force::
 	Override the up-to-date check.
=20
+--ignore-unmatch::
+	Exit with a zero status even if no files matched.
+
 -n::
 --dry-run::
 	Don't actually remove any file(s).  Instead, just show
 	if they exist in the index and would otherwise be removed
 	by the command.
=20
+-q::
+--quiet::
+	`git rm` normally outputs one line (in the form of an `rm` command)
+	for each file removed. This option suppresses that output.
 -r::
         Allow recursive removal when a leading directory name is
         given.
@@ -54,19 +56,15 @@ OPTIONS
 	the list of files, (useful when filenames might be mistaken
 	for command-line options).
=20
---cached::
-	Use this option to unstage and remove paths only from the index.
-	Working tree files, whether modified or not, will be
-	left alone.
-
---ignore-unmatch::
-	Exit with a zero status even if no files matched.
-
--q::
---quiet::
-	`git rm` normally outputs one line (in the form of an `rm` command)
-	for each file removed. This option suppresses that output.
-
+<file>...::
+	Files to remove.  Fileglobs (e.g. `*.c`) can be given to
+	remove all matching files.  If you want git to expand
+	file glob characters, you may need to shell-escape them.
+	A leading directory name
+	(e.g. `dir` to remove `dir/file1` and `dir/file2`) can be
+	given to remove all files in the directory, and recursively
+	all sub-directories,
+	but this requires the `-r` option to be explicitly given.
=20
 DISCUSSION
 ----------
--=20
1.7.2.3

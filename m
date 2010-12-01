From: jari.aalto@cante.net
Subject: [PATCH] git-tag.txt: order options alphabetically
Date: Wed,  1 Dec 2010 21:44:07 +0200
Organization: Private
Message-ID: <1291232647-19556-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 20:44:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNsbG-0001L7-FR
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 20:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756740Ab0LAToM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 14:44:12 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:45275 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576Ab0LAToL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 14:44:11 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id CDDDB8C39D
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 21:44:09 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A07E81AC46B; Wed, 01 Dec 2010 21:44:09 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id B11E7E51A4
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 21:44:08 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNsb1-00055q-Ux; Wed, 01 Dec 2010 21:44:08 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162584>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-tag.txt |   49 +++++++++++++++++++++++----------------=
------
 1 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 8b169e3..bfdbb09 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -41,39 +41,37 @@ GnuPG key for signing.
=20
 OPTIONS
 -------
+
+-n<num>::
+	<num> specifies how many lines from the annotation, if any,
+	are printed when using -l.
+	The default is not to print any annotation lines.
+	If no number is given to `-n`, only the first line is printed.
+	If the tag is not annotated, the commit message is displayed instead.
+
 -a::
 	Make an unsigned, annotated tag object
=20
--s::
-	Make a GPG-signed tag, using the default e-mail address's key
+--contains <commit>::
+	Only list tags which contain the specified commit.
=20
--u <key-id>::
-	Make a GPG-signed tag, using the given key
+-d::
+	Delete existing tags with the given names.
=20
 -f::
 --force::
 	Replace an existing tag with the given name (instead of failing)
=20
--d::
-	Delete existing tags with the given names.
-
--v::
-	Verify the gpg signature of the given tag names.
-
--n<num>::
-	<num> specifies how many lines from the annotation, if any,
-	are printed when using -l.
-	The default is not to print any annotation lines.
-	If no number is given to `-n`, only the first line is printed.
-	If the tag is not annotated, the commit message is displayed instead.
+-F <file>::
+	Take the tag message from the given file.  Use '-' to
+	read the message from the standard input.
+	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
+	is given.
=20
 -l <pattern>::
 	List tags with names that match the given pattern (or all if no pattern=
 is given).
 	Typing "git tag" without arguments, also lists all tags.
=20
---contains <commit>::
-	Only list tags which contain the specified commit.
-
 -m <msg>::
 	Use the given tag message (instead of prompting).
 	If multiple `-m` options are given, their values are
@@ -81,11 +79,14 @@ OPTIONS
 	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
 	is given.
=20
--F <file>::
-	Take the tag message from the given file.  Use '-' to
-	read the message from the standard input.
-	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
-	is given.
+-s::
+	Make a GPG-signed tag, using the default e-mail address's key
+
+-u <key-id>::
+	Make a GPG-signed tag, using the given key
+
+-v::
+	Verify the gpg signature of the given tag names.
=20
 <tagname>::
 	The name of the tag to create, delete, or describe.
--=20
1.7.2.3

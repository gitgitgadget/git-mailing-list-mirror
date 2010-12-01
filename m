From: jari.aalto@cante.net
Subject: [PATCH] pretty-options.txt: Order options alphabetically
Date: Wed,  1 Dec 2010 21:41:54 +0200
Organization: Private
Message-ID: <1291232514-19425-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 20:42:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNsZ0-0008V8-Ld
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 20:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756616Ab0LATl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 14:41:57 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:35712 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576Ab0LATl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 14:41:57 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id EFA9BC7BB9
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 21:41:55 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A01F43EB1C3; Wed, 01 Dec 2010 21:41:55 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id DC2071C6388
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 21:41:54 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNsYs-00053j-6p; Wed, 01 Dec 2010 21:41:54 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162583>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/pretty-options.txt |   31 +++++++++++++++----------------
 1 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-opti=
ons.txt
index 50923e2..2295f9d 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -1,15 +1,3 @@
---pretty[=3D<format>]::
---format=3D<format>::
-
-	Pretty-print the contents of the commit logs in a given format,
-	where '<format>' can be one of 'oneline', 'short', 'medium',
-	'full', 'fuller', 'email', 'raw' and 'format:<string>'.  See
-	the "PRETTY FORMATS" section for some additional details for each
-	format.  When omitted, the format defaults to 'medium'.
-+
-Note: you can specify the default pretty format in the repository
-configuration (see linkgit:git-config[1]).
-
 --abbrev-commit::
 	Instead of showing the full 40-byte hexadecimal commit object
 	name, show only a partial prefix.  Non default number of
@@ -19,10 +7,6 @@ configuration (see linkgit:git-config[1]).
 This should make "--pretty=3Doneline" a whole lot more readable for
 people using 80-column terminals.
=20
---oneline::
-	This is a shorthand for "--pretty=3Doneline --abbrev-commit"
-	used together.
-
 --encoding[=3D<encoding>]::
 	The commit objects record the encoding used for the log message
 	in their encoding header; this option can be used to tell the
@@ -46,3 +30,18 @@ is taken to be in `refs/notes/` if it is not qualified=
.
 	'core.notesRef' and 'notes.displayRef' variables (or
 	corresponding environment overrides).  Enabled by default.
 	See linkgit:git-config[1].
+--oneline::
+	This is a shorthand for "--pretty=3Doneline --abbrev-commit"
+	used together.
+
+--pretty[=3D<format>]::
+--format=3D<format>::
+
+	Pretty-print the contents of the commit logs in a given format,
+	where '<format>' can be one of 'oneline', 'short', 'medium',
+	'full', 'fuller', 'email', 'raw' and 'format:<string>'.  See
+	the "PRETTY FORMATS" section for some additional details for each
+	format.  When omitted, the format defaults to 'medium'.
++
+Note: you can specify the default pretty format in the repository
+configuration (see linkgit:git-config[1]).
--=20
1.7.2.3

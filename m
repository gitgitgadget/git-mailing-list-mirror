From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 3/3] gitk: fix display of copyright symbol
Date: Fri, 12 Mar 2010 18:31:49 +0000
Message-ID: <1268418709-4998-3-git-send-email-patthoyts@users.sourceforge.net>
References: <1268418709-4998-1-git-send-email-patthoyts@users.sourceforge.net>
 <1268418709-4998-2-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 12 19:32:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq9es-00044k-0A
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 19:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934443Ab0CLScT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 13:32:19 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:58655 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934085Ab0CLScR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Mar 2010 13:32:17 -0500
Received: from [172.23.170.138] (helo=anti-virus01-09)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Nq9ec-0004NR-PM; Fri, 12 Mar 2010 18:32:10 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1Nq9eb-0008Mr-TA; Fri, 12 Mar 2010 18:32:10 +0000
Received: from frog (pc014.patthoyts.tk [192.168.0.14])
	by fox.patthoyts.tk (Postfix) with ESMTP id 8B18B21945;
	Fri, 12 Mar 2010 18:32:09 +0000 (GMT)
Received: by frog (Postfix, from userid 1000)
	id 7E14C6D6A1D; Fri, 12 Mar 2010 18:32:30 +0000 (GMT)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1268418709-4998-2-git-send-email-patthoyts@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142059>

The script file uses utf-8 encoding but when sourced it will be read
using the default system encoding which is never utf8 on windows. This
causes the copyright symbol to display incorrectly in the about dialog.
Using the unicode escape sequence avoids incorrect decoding but does
require a double escape in the .po files.

Also adjusted the year range.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk     |    2 +-
 po/de.po |    4 ++--
 po/es.po |    4 ++--
 po/fr.po |    4 ++--
 po/hu.po |    4 ++--
 po/it.po |    4 ++--
 po/ja.po |    4 ++--
 po/ru.po |    4 ++--
 po/sv.po |    4 ++--
 9 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/gitk b/gitk
index 1f36a3e..e1f3740 100755
--- a/gitk
+++ b/gitk
@@ -2782,7 +2782,7 @@ proc about {} {
     message $w.m -text [mc "
 Gitk - a commit viewer for git
=20
-Copyright =C2=A9 2005-2009 Paul Mackerras
+Copyright \u00a9 2005-2010 Paul Mackerras
=20
 Use and redistribute under the terms of the GNU General Public License=
"] \
 	    -justify center -aspect 400 -border 2 -bg white -relief groove
diff --git a/po/de.po b/po/de.po
index c79aa9c..bd194a3 100644
--- a/po/de.po
+++ b/po/de.po
@@ -334,14 +334,14 @@ msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
-"Copyright =C2=A99 2005-2009 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public Licens=
e"
 msgstr ""
 "\n"
 "Gitk - eine Visualisierung der Git-Historie\n"
 "\n"
-"Copyright =C2=A9 2005-2009 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
 "\n"
 "Benutzung und Weiterverbreitung gem=C3=A4=C3=9F den Bedingungen der G=
NU General Public License"
=20
diff --git a/po/es.po b/po/es.po
index 0e19b5e..0471dd0 100644
--- a/po/es.po
+++ b/po/es.po
@@ -281,14 +281,14 @@ msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
-"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public Licens=
e"
 msgstr ""
 "\n"
 "Gitk - un visualizador de revisiones para git\n"
 "\n"
-"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
 "\n"
 "Uso y redistribuci=C3=B3n permitidos seg=C3=BAn los t=C3=A9rminos de =
la Licencia P=C3=BAblica "
 "General de GNU (GNU GPL)"
diff --git a/po/fr.po b/po/fr.po
index cb0e1ed..5370ddc 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -334,14 +334,14 @@ msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
-"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public Licens=
e"
 msgstr ""
 "\n"
 "Gitk - visualisateur de commit pour git\n"
 "\n"
-"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
 "\n"
 "Utilisation et redistribution soumises aux termes de la GNU General P=
ublic "
 "License"
diff --git a/po/hu.po b/po/hu.po
index 1df212e..7262b61 100644
--- a/po/hu.po
+++ b/po/hu.po
@@ -333,14 +333,14 @@ msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
-"Copyright =C2=A99 2005-2009 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public Licens=
e"
 msgstr ""
 "\n"
 "Gitk - commit n=C3=A9zeget=C5=91 a githez\n"
 "\n"
-"Szerz=C5=91i jog =C2=A99 2005-2009 Paul Mackerras\n"
+"Szerz=C5=91i jog \\u00a9 2005-2010 Paul Mackerras\n"
 "\n"
 "Haszn=C3=A1ld =C3=A9s terjeszd a GNU General Public License felt=C3=A9=
telei mellett"
=20
diff --git a/po/it.po b/po/it.po
index 4818652..a730d63 100644
--- a/po/it.po
+++ b/po/it.po
@@ -334,14 +334,14 @@ msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
-"Copyright =C2=A9 2005-2009 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public Licens=
e"
 msgstr ""
 "\n"
 "Gitk - un visualizzatore di revisioni per git\n"
 "\n"
-"Copyright =C2=A9 2005-2009 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
 "\n"
 "Utilizzo e redistribuzione permessi sotto i termini della GNU General=
 Public "
 "License"
diff --git a/po/ja.po b/po/ja.po
index c0c92ad..4f47051 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -335,14 +335,14 @@ msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
-"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public Licens=
e"
 msgstr ""
 "\n"
 "Gitk - git=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=93=E3=83=A5=E3=83=
=BC=E3=82=A2\n"
 "\n"
-"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
 "\n"
 "=E4=BD=BF=E7=94=A8=E3=81=8A=E3=82=88=E3=81=B3=E5=86=8D=E9=85=8D=E5=B8=
=83=E3=81=AF GNU General Public License =E3=81=AB=E5=BE=93=E3=81=A3=E3=81=
=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84"
=20
diff --git a/po/ru.po b/po/ru.po
index 704eba8..c3d0285 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -313,14 +313,14 @@ msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
-"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public Licens=
e"
 msgstr ""
 "\n"
 "Gitk - =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=BF=D1=
=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B0 =D0=B8=D1=81=D1=82=D0=BE=D1=
=80=D0=B8=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D0=B5=D0=B2 Git\n"
 "\n"
-"Copyright (c) 2005-2008 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
 "\n"
 "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D0=BD=D0=
=B8=D0=B5 =D0=B8 =D1=80=D0=B0=D1=81=D0=BF=D1=80=D0=BE=D1=81=D1=82=D1=80=
=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D1=81=D0=BE=D0=B3=D0=BB=D0=B0=D1=81=
=D0=BD=D0=BE =D1=83=D1=81=D0=BB=D0=BE=D0=B2=D0=B8=D1=8F=D0=BC GNU Gener=
al Public License"
=20
diff --git a/po/sv.po b/po/sv.po
index 0f5e2fd..386763a 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -334,14 +334,14 @@ msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
-"Copyright =C2=A99 2005-2009 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public Licens=
e"
 msgstr ""
 "\n"
 "Gitk - en incheckningsvisare f=C3=B6r git\n"
 "\n"
-"Copyright =C2=A9 2005-2009 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
 "\n"
 "Anv=C3=A4nd och vidaref=C3=B6rmedla enligt villkoren i GNU General Pu=
blic License"
=20
--=20
1.6.6

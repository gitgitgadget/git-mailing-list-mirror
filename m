From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] gitk: Updated German translation.
Date: Fri, 28 Nov 2008 11:46:55 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200811281146.55401.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fw8LJzjKwgE6Lvy"
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Nov 28 11:52:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L60xk-00021f-Nx
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 11:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbYK1Kuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 05:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbYK1Kuw
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 05:50:52 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:60918 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbYK1Kuu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 05:50:50 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id mASAojKb017027
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 28 Nov 2008 11:50:46 +0100
Received: from [192.168.0.101] (e176216226.adsl.alicedsl.de [85.176.216.226])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id mASAoihP030810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 28 Nov 2008 11:50:45 +0100
User-Agent: KMail/1.9.5
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101870>

--Boundary-00=_fw8LJzjKwgE6Lvy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patch against today's master of gitk.git at git.kernel.org. Attached to 
avoid whitespace problems. My last submitted patch from 2008-10-25 for 
whatever reason hasn't been committed to gitk.git so far.

Regards,

Christian

--Boundary-00=_fw8LJzjKwgE6Lvy
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-gitk-Update-German-translation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-gitk-Update-German-translation.patch"

=46rom 627fc16459e43f5577c16851332bf02a9d40595e Mon Sep 17 00:00:00 2001
=46rom: Christian Stimming <stimming@tuhh.de>
Date: Sat, 25 Oct 2008 13:25:35 +0200
Subject: [PATCH] gitk: Update German translation.

This takes into account the most recent po file merge. For future reference:
The German translator strongly preferes not to have po file merged by the
maintainer (thus causing tons of conflicts for already existing local trans=
lations),
but instead to run "make update-po" on his own.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
=2D--
 po/de.po |   51 +++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/po/de.po b/po/de.po
index c86cc2d..e0a6dee 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -7,8 +7,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2008-10-18 22:03+1100\n"
=2D"PO-Revision-Date: 2008-05-24 22:40+0200\n"
+"POT-Creation-Date: 2008-10-25 13:18+0200\n"
+"PO-Revision-Date: 2008-10-25 13:23+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -19,6 +19,14 @@ msgstr ""
 msgid "Couldn't get list of unmerged files:"
 msgstr "Liste der nicht-zusammengef=C3=BChrten Dateien nicht gefunden:"
=20
+#: gitk:272
+msgid "Error parsing revisions:"
+msgstr "Fehler beim Laden der Versionen:"
+
+#: gitk:327
+msgid "Error executing --argscmd command:"
+msgstr "Fehler beim --argscmd Kommando:"
+
 #: gitk:340
 msgid "No files selected: --merge specified but no files are unmerged."
 msgstr ""
@@ -283,9 +291,9 @@ msgstr "Nur diesen hervorheben"
 msgid "External diff"
 msgstr "Externer Vergleich"
=20
=2D#: gitk:2245
+#: gitk:2255
 msgid "Blame parent commit"
=2Dmsgstr ""
+msgstr "Annotieren der Elternversion"
=20
 #: gitk:2488
 msgid ""
@@ -471,7 +479,33 @@ msgstr "<%s-Minus>\tSchriftgr=C3=B6=C3=9Fe verkleinern"
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tAktualisieren"
=20
=2D#: gitk:3200
+#: gitk:2979
+#, tcl-format
+msgid "Error getting \"%s\" from %s:"
+msgstr "Fehler beim Holen von =C2=BB%s=C2=AB von =C2=BB%s=C2=AB:"
+
+#: gitk:3036 gitk:3045
+#, tcl-format
+msgid "Error creating temporary directory %s:"
+msgstr "Fehler beim Erzeugen eines tempor=C3=A4ren Verzeichnisses =C2=BB%s=
=C2=AB:"
+
+#: gitk:3058
+msgid "command failed:"
+msgstr "Kommando fehlgeschlagen:"
+
+#: gitk:3078
+msgid "No such commit"
+msgstr "Version nicht gefunden"
+
+#: gitk:3083
+msgid "git gui blame: command failed:"
+msgstr "git gui blame: Kommando fehlgeschlagen:"
+
+#: gitk:3092
+msgid "External diff viewer failed:"
+msgstr "Externes Vergleich-(Diff-)Programm fehlgeschlagen:"
+
+#: gitk:3210
 msgid "Gitk view definition"
 msgstr "Gitk Ansichten"
=20
@@ -692,9 +726,10 @@ msgstr "Bitte geben Sie einen Namen f=C3=BCr den neuen=
 Zweig an."
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
 msgstr ""
=2D"Version =C2=BB%s=C2=AB ist bereits im Zweig =C2=BB%s=C2=AB enthalten --=
 trotzdem erneut eintragen?"
+"Version =C2=BB%s=C2=AB ist bereits im Zweig =C2=BB%s=C2=AB enthalten -- t=
rotzdem erneut "
+"eintragen?"
=20
=2D#: gitk:7708
+#: gitk:7718
 msgid "Cherry-picking"
 msgstr "Version pfl=C3=BCcken"
=20
@@ -836,7 +871,7 @@ msgstr "Vergleich nur f=C3=BCr angezeigte Pfade"
=20
 #: gitk:9414
 msgid "Support per-file encodings"
=2Dmsgstr ""
+msgstr "Zeichenkodierung pro Datei ermitteln"
=20
 #: gitk:9421
 msgid "External diff tool"
=2D-=20
1.6.0.rc1.34.g0fe8c


--Boundary-00=_fw8LJzjKwgE6Lvy--

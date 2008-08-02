From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] gitk: Updated German translation.
Date: Sat, 2 Aug 2008 10:03:25 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200808021003.26041.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OTBlIu+5TlHmJPH"
Cc: Michele Ballabio <barra_cuda@katamail.com>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 10:05:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPC6z-00027o-JG
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 10:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbYHBID6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 04:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbYHBID6
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 04:03:58 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:38174 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbYHBIDz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 04:03:55 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Aug 2008 04:03:55 EDT
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m7283U1g009809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 2 Aug 2008 10:03:31 +0200
Received: from [192.168.0.101] (e176206164.adsl.alicedsl.de [85.176.206.164])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m7283T7B024256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 2 Aug 2008 10:03:30 +0200
User-Agent: KMail/1.9.5
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91136>

--Boundary-00=_OTBlIu+5TlHmJPH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is an update to gitk's German translation against current master of 
gitk.git at git.kernel.org. To my surprise, my submitted patch as of 
2008-05-24 hasn't been applied so far. I'm resending it (rebased on current 
master) in the hope that by now someone will actually commit it and the 
translation goes back to 100%. Thanks a lot!

Christian

--Boundary-00=_OTBlIu+5TlHmJPH
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-gitk-Updated-German-translation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-gitk-Updated-German-translation.patch"

=46rom 47f0b66d090a143a36d1d74592396b43dbbbbea2 Mon Sep 17 00:00:00 2001
=46rom: Christian Stimming <stimming@tuhh.de>
Date: Sat, 24 May 2008 22:42:30 +0200
Subject: [PATCH] gitk: Updated German translation.

This includes suggestions by Stephan Beyer.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
=2D--
 po/de.po |  106 ++++++++++++++++++++++++++++++++++++++--------------------=
=2D---
 1 files changed, 65 insertions(+), 41 deletions(-)

diff --git a/po/de.po b/po/de.po
index b9867bf..04ee570 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -7,19 +7,37 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2008-05-01 11:54+0200\n"
=2D"PO-Revision-Date: 2008-05-02 21:12+0200\n"
+"POT-Creation-Date: 2008-05-24 22:32+0200\n"
+"PO-Revision-Date: 2008-05-24 22:40+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
=2D#: gitk:111
=2Dmsgid "Error executing git rev-list:"
=2Dmsgstr "Fehler beim Ausf=C3=BChren von git-rev-list:"
+#: gitk:102
+msgid "Couldn't get list of unmerged files:"
+msgstr "Liste der nicht-zusammengef=C3=BChrten Dateien nicht gefunden:"
+
+#: gitk:329
+msgid "No files selected: --merge specified but no files are unmerged."
+msgstr ""
+"Keine Dateien ausgew=C3=A4hlt: --merge angegeben, es existieren aber kein=
e nicht-"
+"zusammengef=C3=BChrten Dateien."
+
+#: gitk:332
+msgid ""
+"No files selected: --merge specified but no unmerged files are within fil=
e "
+"limit."
+msgstr ""
+"Keine Dateien ausgew=C3=A4hle: --merge angegeben, aber keine nicht-"
+"zusammengef=C3=BChrten Dateien sind in der Dateiauswahl."
=20
=2D#: gitk:124
+#: gitk:354
+msgid "Error executing git log:"
+msgstr "Fehler beim Ausf=C3=BChren von git-log:"
+
+#: gitk:369
 msgid "Reading"
 msgstr "Lesen"
=20
@@ -56,7 +74,11 @@ msgstr "Datei"
 msgid "Update"
 msgstr "Aktualisieren"
=20
=2D#: gitk:664
+#: gitk:1722
+msgid "Reload"
+msgstr "Neu laden"
+
+#: gitk:1723
 msgid "Reread references"
 msgstr "Zweige neu laden"
=20
@@ -112,7 +134,11 @@ msgstr "Tastenk=C3=BCrzel"
 msgid "SHA1 ID: "
 msgstr "SHA1:"
=20
=2D#: gitk:791
+#: gitk:1831
+msgid "Row"
+msgstr "Zeile"
+
+#: gitk:1862
 msgid "Find"
 msgstr "Suche"
=20
@@ -126,19 +152,19 @@ msgstr "vorige"
=20
 #: gitk:794
 msgid "commit"
=2Dmsgstr "Version"
+msgstr "Version nach"
=20
 #: gitk:797 gitk:799 gitk:2356 gitk:2379 gitk:2403 gitk:4306 gitk:4369
 msgid "containing:"
=2Dmsgstr "enthaltend:"
+msgstr "Beschreibung:"
=20
 #: gitk:800 gitk:1778 gitk:1783 gitk:2431
 msgid "touching paths:"
=2Dmsgstr "Pfad betreffend:"
+msgstr "Dateien:"
=20
 #: gitk:801 gitk:2436
 msgid "adding/removing string:"
=2Dmsgstr "Zeichenkette =C3=A4ndernd:"
+msgstr "=C3=84nderungen:"
=20
 #: gitk:810 gitk:812
 msgid "Exact"
@@ -253,23 +279,25 @@ msgstr "Diesen auch hervorheben"
 msgid "Highlight this only"
 msgstr "Nur diesen hervorheben"
=20
=2D#: gitk:1318
+#: gitk:2162
+msgid "External diff"
+msgstr "Externer Vergleich"
+
+#: gitk:2403
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
=2D"Copyright =C2=A9 2005-2006 Paul Mackerras\n"
+"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public License"
 msgstr ""
 "\n"
 "Gitk - eine Visualisierung der Git Historie\n"
 "\n"
=2D"Copyright =C2=A9 2005-2006 Paul Mackerras\n"
+"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
 "\n"
=2D"Benutzung und Weiterverbreitung gem=C3=A4=C3=9F den Bedingungen der GNU=
 General Public "
=2D"License\n"
=2D"        "
+"Benutzung und Weiterverbreitung gem=C3=A4=C3=9F den Bedingungen der GNU G=
eneral Public License"
=20
 #: gitk:1326 gitk:1387 gitk:6582
 msgid "Close"
@@ -450,11 +478,11 @@ msgstr "Name"
 msgid "Remember this view"
 msgstr "Diese Ansicht speichern"
=20
=2D#: gitk:1928
=2Dmsgid "Commits to include (arguments to git rev-list):"
=2Dmsgstr "Versionen anzeigen (Argumente von git-rev-list):"
+#: gitk:3126
+msgid "Commits to include (arguments to git log):"
+msgstr "Versionen anzeigen (Argumente von git-log):"
=20
=2D#: gitk:1935
+#: gitk:3133
 msgid "Command to generate more commits to include:"
 msgstr "Versionsliste durch folgendes Kommando erzeugen lassen:"
=20
@@ -566,7 +594,11 @@ msgstr "Kinder"
 msgid "Reset %s branch to here"
 msgstr "Zweig =C2=BB%s=C2=AB hierher zur=C3=BCcksetzen"
=20
=2D#: gitk:6050
+#: gitk:7204
+msgid "Detached head: can't reset"
+msgstr "Zweigspitze ist abgetrennt: Zur=C3=BCcksetzen nicht m=C3=B6glich"
+
+#: gitk:7236
 msgid "Top"
 msgstr "Oben"
=20
@@ -798,7 +830,15 @@ msgstr "Naheliegende =C3=9Cberschriften anzeigen"
 msgid "Limit diffs to listed paths"
 msgstr "Vergleich nur f=C3=BCr angezeigte Pfade"
=20
=2D#: gitk:8045
+#: gitk:9264
+msgid "External diff tool"
+msgstr "Externes Vergleich-(Diff-)Programm"
+
+#: gitk:9266
+msgid "Choose..."
+msgstr "W=C3=A4hlen..."
+
+#: gitk:9271
 msgid "Colors: press to choose"
 msgstr "Farben: Klicken zum W=C3=A4hlen"
=20
@@ -873,22 +913,6 @@ msgstr "Mehrdeutige Angabe =C2=BB%s=C2=AB: Sowohl Vers=
ion als auch Dateiname existiert."
 msgid "Bad arguments to gitk:"
 msgstr "Falsche Kommandozeilen-Parameter f=C3=BCr gitk:"
=20
=2D#: gitk:8637
=2Dmsgid "Couldn't get list of unmerged files:"
=2Dmsgstr "Liste der nicht-zusammengef=C3=BChrten Dateien nicht gefunden:"
=2D
=2D#: gitk:8653
=2Dmsgid "No files selected: --merge specified but no files are unmerged."
=2Dmsgstr "Keine Dateien ausgew=C3=A4hlt: --merge angegeben, es existieren =
aber keine nicht-zusammengef=C3=BChrten Dateien."
=2D
=2D#: gitk:8656
=2Dmsgid ""
=2D"No files selected: --merge specified but no unmerged files are within f=
ile "
=2D"limit."
=2Dmsgstr ""
=2D"Keine Dateien ausgew=C3=A4hle: --merge angegeben, aber keine nicht-"
=2D"zusammengef=C3=BChrten Dateien sind in der Dateiauswahl."
=2D
=2D#: gitk:8717
+#: gitk:9915
 msgid "Command line"
 msgstr "Kommandozeile"
=2D-=20
1.5.5.1.316.g377d9


--Boundary-00=_OTBlIu+5TlHmJPH--

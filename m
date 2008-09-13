From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] git-gui: Updated German translation.
Date: Sat, 13 Sep 2008 10:25:59 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200809131026.00149.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Yk3yILm4MeLJZtQ"
Cc: git@vger.kernel.org
To: "Shawn Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 13 10:27:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeQTC-0004wP-Tr
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 10:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbYIMIZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 04:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753728AbYIMIZ6
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 04:25:58 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:33420 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbYIMIZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 04:25:56 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m8D8Po2l008726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 13 Sep 2008 10:25:51 +0200
Received: from [192.168.0.101] (e176207118.adsl.alicedsl.de [85.176.207.118])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m8D8Pnuc014144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 13 Sep 2008 10:25:50 +0200
User-Agent: KMail/1.9.5
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95794>

--Boundary-00=_Yk3yILm4MeLJZtQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patch against today's master of git-gui.git at repo.or.cz. Attached to avoid 
whitespace problems.

Regards,

Christian

--Boundary-00=_Yk3yILm4MeLJZtQ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-git-gui-Updated-German-translation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-git-gui-Updated-German-translation.patch"

=46rom 75a98bb3189683dfedb3a2bccdec0227a57ea6d6 Mon Sep 17 00:00:00 2001
=46rom: Christian Stimming <stimming@tuhh.de>
Date: Sat, 13 Sep 2008 10:24:47 +0200
Subject: [PATCH] git-gui: Updated German translation.

=2D--
 po/de.po |  193 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---=
=2D---
 1 files changed, 172 insertions(+), 21 deletions(-)

diff --git a/po/de.po b/po/de.po
index fa43947..793cca1 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -7,8 +7,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2008-08-02 08:58+0200\n"
=2D"PO-Revision-Date: 2008-08-02 09:09+0200\n"
+"POT-Creation-Date: 2008-09-13 10:20+0200\n"
+"PO-Revision-Date: 2008-09-13 10:24+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -110,7 +110,15 @@ msgstr "Teilweise bereitgestellt zum Eintragen"
 msgid "Staged for commit, missing"
 msgstr "Bereitgestellt zum Eintragen, fehlend"
=20
=2D#: git-gui.sh:1597
+#: git-gui.sh:1658
+msgid "File type changed, not staged"
+msgstr "Dateityp ge=C3=A4ndert, nicht bereitgestellt"
+
+#: git-gui.sh:1659
+msgid "File type changed, staged"
+msgstr "Dateityp ge=C3=A4ndert, bereitgestellt"
+
+#: git-gui.sh:1661
 msgid "Untracked, not staged"
 msgstr "Nicht unter Versionskontrolle, nicht bereitgestellt"
=20
@@ -396,15 +404,7 @@ msgstr "Alle kopieren"
 msgid "File:"
 msgstr "Datei:"
=20
=2D#: git-gui.sh:2589
=2Dmsgid "Apply/Reverse Hunk"
=2Dmsgstr "Kontext anwenden/umkehren"
=2D
=2D#: git-gui.sh:2696
=2Dmsgid "Apply/Reverse Line"
=2Dmsgstr "Zeile anwenden/umkehren"
=2D
=2D#: git-gui.sh:2711
+#: git-gui.sh:2834
 msgid "Refresh"
 msgstr "Aktualisieren"
=20
@@ -416,7 +416,35 @@ msgstr "Schriftgr=C3=B6=C3=9Fe verkleinern"
 msgid "Increase Font Size"
 msgstr "Schriftgr=C3=B6=C3=9Fe vergr=C3=B6=C3=9Fern"
=20
=2D#: git-gui.sh:2646
+#: git-gui.sh:2870
+msgid "Apply/Reverse Hunk"
+msgstr "Kontext anwenden/umkehren"
+
+#: git-gui.sh:2875
+msgid "Apply/Reverse Line"
+msgstr "Zeile anwenden/umkehren"
+
+#: git-gui.sh:2885
+msgid "Run Merge Tool"
+msgstr "Zusammenf=C3=BChrungswerkzeug"
+
+#: git-gui.sh:2890
+msgid "Use Remote Version"
+msgstr "Entfernte Version benutzen"
+
+#: git-gui.sh:2894
+msgid "Use Local Version"
+msgstr "Lokale Version benutzen"
+
+#: git-gui.sh:2898
+msgid "Revert To Base"
+msgstr "Urspr=C3=BCngliche Version benutzen"
+
+#: git-gui.sh:2906
+msgid "Stage Working Copy"
+msgstr "Arbeitskopie bereitstellen"
+
+#: git-gui.sh:2925
 msgid "Unstage Hunk From Commit"
 msgstr "Kontext aus Bereitstellung herausnehmen"
=20
@@ -498,7 +526,15 @@ msgstr "Version kopieren"
 msgid "Do Full Copy Detection"
 msgstr "Volle Kopie-Erkennung"
=20
=2D#: lib/blame.tcl:388
+#: lib/blame.tcl:263
+msgid "Show History Context"
+msgstr "Historien-Kontext anzeigen"
+
+#: lib/blame.tcl:266
+msgid "Blame Parent Commit"
+msgstr "Elternversion annotieren"
+
+#: lib/blame.tcl:394
 #, tcl-format
 msgid "Reading %s..."
 msgstr "%s lesen..."
@@ -547,7 +583,19 @@ msgstr "Eintragender:"
 msgid "Original File:"
 msgstr "Urspr=C3=BCngliche Datei:"
=20
=2D#: lib/blame.tcl:925
+#: lib/blame.tcl:990
+msgid "Cannot find parent commit:"
+msgstr "Elternversion kann nicht gefunden werden:"
+
+#: lib/blame.tcl:1001
+msgid "Unable to display parent"
+msgstr "Elternversion kann nicht angezeigt werden"
+
+#: lib/blame.tcl:1002 lib/diff.tcl:191
+msgid "Error loading diff:"
+msgstr "Fehler beim Laden des Vergleichs:"
+
+#: lib/blame.tcl:1142
 msgid "Originally By:"
 msgstr "Urspr=C3=BCnglich von:"
=20
@@ -1494,11 +1542,7 @@ msgstr "Git-Projektarchiv (Unterprojekt)"
 msgid "* Binary file (not showing content)."
 msgstr "* Bin=C3=A4rdatei (Inhalt wird nicht angezeigt)"
=20
=2D#: lib/diff.tcl:185
=2Dmsgid "Error loading diff:"
=2Dmsgstr "Fehler beim Laden des Vergleichs:"
=2D
=2D#: lib/diff.tcl:303
+#: lib/diff.tcl:313
 msgid "Failed to unstage selected hunk."
 msgstr ""
 "Fehler beim Herausnehmen des gew=C3=A4hlten Kontexts aus der Bereitstellu=
ng."
@@ -1586,6 +1630,15 @@ msgstr ""
 msgid "Do Nothing"
 msgstr "Nichts tun"
=20
+#: lib/index.tcl:419
+msgid "Reverting selected files"
+msgstr "=C3=84nderungen in gew=C3=A4hlten Dateien verwerfen"
+
+#: lib/index.tcl:423
+#, tcl-format
+msgid "Reverting %s"
+msgstr "=C3=84nderungen in %s verwerfen"
+
 #: lib/merge.tcl:13
 msgid ""
 "Cannot merge while amending.\n"
@@ -1730,6 +1783,96 @@ msgstr "Abbruch fehlgeschlagen."
 msgid "Abort completed.  Ready."
 msgstr "Abbruch durchgef=C3=BChrt. Bereit."
=20
+#: lib/mergetool.tcl:14
+msgid "Force resolution to the base version?"
+msgstr "Konflikt durch Basisversion ersetzen?"
+
+#: lib/mergetool.tcl:15
+msgid "Force resolution to this branch?"
+msgstr "Konflikt durch diesen Zweig ersetzen?"
+
+#: lib/mergetool.tcl:16
+msgid "Force resolution to the other branch?"
+msgstr "Konflikt durch anderen Zweig ersetzen?"
+
+#: lib/mergetool.tcl:20
+#, tcl-format
+msgid ""
+"Note that the diff shows only conflicting changes.\n"
+"\n"
+"%s will be overwritten.\n"
+"\n"
+"This operation can be undone only by restarting the merge."
+msgstr ""
+"Hinweis: Der Vergleich zeigt nur konfliktverursachende =C3=84nderungen an=
=2E\n"
+"\n"
+"=C2=BB%s=C2=AB wird =C3=BCberschrieben.\n"
+"\n"
+"Diese Operation kann nur r=C3=BCckg=C3=A4ngig gemacht werden, wenn die\n"
+"Zusammenf=C3=BChrung erneut gestartet wird."
+
+#: lib/mergetool.tcl:32
+#, tcl-format
+msgid "Adding resolution for %s"
+msgstr "Aufl=C3=B6sung hinzugef=C3=BCgt f=C3=BCr %s"
+
+#: lib/mergetool.tcl:119
+msgid "Cannot resolve deletion or link conflicts using a tool"
+msgstr ""
+"Konflikte durch gel=C3=B6schte Dateien oder symbolische Links k=C3=B6nnen=
 nicht durch "
+"das Zusamenf=C3=BChrungswerkzeug gel=C3=B6st werden."
+
+#: lib/mergetool.tcl:124
+msgid "Conflict file does not exist"
+msgstr "Konflikt-Datei existiert nicht"
+
+#: lib/mergetool.tcl:236
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
+msgstr "Kein GUI Zusammenf=C3=BChrungswerkzeug: =C2=BB%s=C2=AB"
+
+#: lib/mergetool.tcl:240
+#, tcl-format
+msgid "Unsupported merge tool '%s'"
+msgstr "Unbekanntes Zusammenf=C3=BChrungswerkzeug: =C2=BB%s=C2=AB"
+
+#: lib/mergetool.tcl:275
+msgid "Merge tool is already running, terminate it?"
+msgstr "Zusammenf=C3=BChrungswerkzeug l=C3=A4uft bereits. Soll es abgebroc=
hen werden?"
+
+#: lib/mergetool.tcl:295
+#, tcl-format
+msgid ""
+"Error retrieving versions:\n"
+"%s"
+msgstr ""
+"Fehler beim Abrufen der Dateiversionen:\n"
+"%s"
+
+#: lib/mergetool.tcl:315
+#, tcl-format
+msgid ""
+"Could not start the merge tool:\n"
+"\n"
+"%s"
+msgstr ""
+"Zusammenf=C3=BChrungswerkzeug konnte nicht gestartet werden:\n"
+"\n"
+"%s"
+
+#: lib/mergetool.tcl:319
+msgid "Running merge tool..."
+msgstr "Zusammenf=C3=BChrungswerkzeug starten..."
+
+#: lib/mergetool.tcl:347 lib/mergetool.tcl:363
+msgid "Merge tool failed."
+msgstr "Zusammenf=C3=BChrungswerkzeug fehlgeschlagen."
+
+#: lib/mergetool.tcl:353
+#, tcl-format
+msgid "File %s unchanged, still accept as resolved?"
+msgstr "Datei =C2=BB%s=C2=AB unver=C3=A4ndert. Trotzdem Konflikt als gel=
=C3=B6st akzeptieren?"
+
 #: lib/option.tcl:95
 msgid "Restore Defaults"
 msgstr "Voreinstellungen wiederherstellen"
@@ -1767,7 +1910,11 @@ msgstr "Ausf=C3=BChrlichkeit der Zusammenf=C3=BChren=
=2DMeldungen"
 msgid "Show Diffstat After Merge"
 msgstr "Vergleichsstatistik nach Zusammenf=C3=BChren anzeigen"
=20
=2D#: lib/option.tcl:123
+#: lib/option.tcl:122
+msgid "Use Merge Tool"
+msgstr "Zusammenf=C3=BChrungswerkzeug"
+
+#: lib/option.tcl:124
 msgid "Trust File Modification Timestamps"
 msgstr "Auf Datei=C3=A4nderungsdatum verlassen"
=20
@@ -1788,6 +1935,10 @@ msgid "Minimum Letters To Blame Copy On"
 msgstr "Mindestzahl Zeichen f=C3=BCr Kopie-Annotieren"
=20
 #: lib/option.tcl:128
+msgid "Blame History Context Radius (days)"
+msgstr "Anzahl Tage f=C3=BCr Historien-Kontext"
+
+#: lib/option.tcl:129
 msgid "Number of Diff Context Lines"
 msgstr "Anzahl der Kontextzeilen beim Vergleich"
=20
=2D-=20
1.6.0.rc1.34.g0fe8c


--Boundary-00=_Yk3yILm4MeLJZtQ--

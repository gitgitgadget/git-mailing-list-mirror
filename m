From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] git-gui: Update German translation.
Date: Sat, 25 Oct 2008 22:55:22 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200810252255.23416.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7e4AJhGB4rmPqB4"
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 25 22:58:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtqD4-0001a7-DS
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 22:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbYJYU4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 16:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbYJYU4f
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 16:56:35 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:45041 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbYJYU4d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 16:56:33 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m9PKuRgr028364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 25 Oct 2008 22:56:27 +0200
Received: from [192.168.0.101] (e176220121.adsl.alicedsl.de [85.176.220.121])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m9PKuPFK025657
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 25 Oct 2008 22:56:27 +0200
User-Agent: KMail/1.9.5
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99129>

--Boundary-00=_7e4AJhGB4rmPqB4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached to avoid whitespace problems.

By the way, the newly added menu entry "Remote"->"Remove Remote" is highly 
user-unfriendly, as it isn't obvious here what the menu item will do and the 
cost of erroneously selecting this is rather high. Obviously this is the 
counterpart to "Remote"->"Add...", which, as the menu promises, will give me 
the opportunity to confirm what I'm going to do next. In contrast to 
this, "Remote"->"Remove Remote" doesn't ask for any confirmation, but will 
directly remove the link to the remote from my working copy. As a 
non-git-guru, restoring this link to the remote is a non-trivial task. In the 
sense of GUI symmetry and meeting user expectations, "Remove" as a 
counterpart to "Add" should be a menu item like "Remove..." which also waits 
for confirmation before removing the remote. Or did I miss something?

Regards,

Christian

--Boundary-00=_7e4AJhGB4rmPqB4
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-git-gui-Update-German-translation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-git-gui-Update-German-translation.patch"

=46rom 2e80b2096cc662e7694b0ac774df169747831d33 Mon Sep 17 00:00:00 2001
=46rom: Christian Stimming <stimming@tuhh.de>
Date: Sat, 25 Oct 2008 22:51:05 +0200
Subject: [PATCH] git-gui: Update German translation.

Not yet completed, though.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
=2D--
 po/de.po |  279 +++++++++++++++++++++++++++++++++++++++++++++++++++-------=
=2D--
 1 files changed, 233 insertions(+), 46 deletions(-)

diff --git a/po/de.po b/po/de.po
index 793cca1..5c04812 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -7,8 +7,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2008-09-13 10:20+0200\n"
=2D"PO-Revision-Date: 2008-09-13 10:24+0200\n"
+"POT-Creation-Date: 2008-10-25 13:32+0200\n"
+"PO-Revision-Date: 2008-10-25 22:47+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -86,7 +86,17 @@ msgstr "Dateistatus aktualisieren..."
 msgid "Scanning for modified files ..."
 msgstr "Nach ge=C3=A4nderten Dateien suchen..."
=20
=2D#: git-gui.sh:1324 lib/browser.tcl:246
+#: git-gui.sh:1325
+#, fuzzy
+msgid "Calling prepare-commit-msg hook..."
+msgstr "Aufrufen der Vor-Eintragen-Kontrolle..."
+
+#: git-gui.sh:1342
+#, fuzzy
+msgid "Commit declined by prepare-commit-msg hook."
+msgstr "Eintragen abgelehnt durch Vor-Eintragen-Kontrolle (=C2=BBpre-commi=
t hook=C2=AB)."
+
+#: git-gui.sh:1502 lib/browser.tcl:246
 msgid "Ready."
 msgstr "Bereit."
=20
@@ -170,7 +180,11 @@ msgstr "Zusammenf=C3=BChren"
 msgid "Remote"
 msgstr "Andere Archive"
=20
=2D#: git-gui.sh:1879
+#: git-gui.sh:2242
+msgid "Explore Working Copy"
+msgstr "Arbeitskopie im Dateimanager"
+
+#: git-gui.sh:2247
 msgid "Browse Current Branch's Files"
 msgstr "Aktuellen Zweig durchbl=C3=A4ttern"
=20
@@ -267,7 +281,15 @@ msgstr "L=C3=B6schen..."
 msgid "Reset..."
 msgstr "Zur=C3=BCcksetzen..."
=20
=2D#: git-gui.sh:2002 git-gui.sh:2389
+#: git-gui.sh:2372
+msgid "Done"
+msgstr "Fertig"
+
+#: git-gui.sh:2374
+msgid "Commit@@verb"
+msgstr "Eintragen"
+
+#: git-gui.sh:2383 git-gui.sh:2786
 msgid "New Commit"
 msgstr "Neue Version"
=20
@@ -307,11 +329,7 @@ msgstr "Mehr Zeilen anzeigen"
 msgid "Sign Off"
 msgstr "Abzeichnen"
=20
=2D#: git-gui.sh:2053 git-gui.sh:2372
=2Dmsgid "Commit@@verb"
=2Dmsgstr "Eintragen"
=2D
=2D#: git-gui.sh:2064
+#: git-gui.sh:2458
 msgid "Local Merge..."
 msgstr "Lokales Zusammenf=C3=BChren..."
=20
@@ -319,11 +337,19 @@ msgstr "Lokales Zusammenf=C3=BChren..."
 msgid "Abort Merge..."
 msgstr "Zusammenf=C3=BChren abbrechen..."
=20
=2D#: git-gui.sh:2081
+#: git-gui.sh:2475
+msgid "Add..."
+msgstr "Hinzuf=C3=BCgen..."
+
+#: git-gui.sh:2479
 msgid "Push..."
 msgstr "Versenden..."
=20
=2D#: git-gui.sh:2197 git-gui.sh:2219 lib/about.tcl:14
+#: git-gui.sh:2483
+msgid "Delete Branch..."
+msgstr "Zweig l=C3=B6schen..."
+
+#: git-gui.sh:2493 git-gui.sh:2515 lib/about.tcl:14
 #: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
 #, tcl-format
 msgid "About %s"
@@ -416,7 +442,11 @@ msgstr "Schriftgr=C3=B6=C3=9Fe verkleinern"
 msgid "Increase Font Size"
 msgstr "Schriftgr=C3=B6=C3=9Fe vergr=C3=B6=C3=9Fern"
=20
=2D#: git-gui.sh:2870
+#: git-gui.sh:3033 lib/blame.tcl:281
+msgid "Encoding"
+msgstr "Zeichenkodierung"
+
+#: git-gui.sh:3044
 msgid "Apply/Reverse Hunk"
 msgstr "Kontext anwenden/umkehren"
=20
@@ -440,11 +470,7 @@ msgstr "Lokale Version benutzen"
 msgid "Revert To Base"
 msgstr "Urspr=C3=BCngliche Version benutzen"
=20
=2D#: git-gui.sh:2906
=2Dmsgid "Stage Working Copy"
=2Dmsgstr "Arbeitskopie bereitstellen"
=2D
=2D#: git-gui.sh:2925
+#: git-gui.sh:3091
 msgid "Unstage Hunk From Commit"
 msgstr "Kontext aus Bereitstellung herausnehmen"
=20
@@ -583,7 +609,12 @@ msgstr "Eintragender:"
 msgid "Original File:"
 msgstr "Urspr=C3=BCngliche Datei:"
=20
=2D#: lib/blame.tcl:990
+#: lib/blame.tcl:1013
+#, fuzzy
+msgid "Cannot find HEAD commit:"
+msgstr "Elternversion kann nicht gefunden werden:"
+
+#: lib/blame.tcl:1068
 msgid "Cannot find parent commit:"
 msgstr "Elternversion kann nicht gefunden werden:"
=20
@@ -1041,11 +1072,15 @@ msgstr "Datei =C2=BB%s=C2=AB existiert bereits."
 msgid "Clone"
 msgstr "Klonen"
=20
=2D#: lib/choose_repository.tcl:468
=2Dmsgid "URL:"
=2Dmsgstr "URL:"
+#: lib/choose_repository.tcl:467
+msgid "Source Location:"
+msgstr ""
+
+#: lib/choose_repository.tcl:478
+msgid "Target Directory:"
+msgstr "Zielverzeichnis:"
=20
=2D#: lib/choose_repository.tcl:489
+#: lib/choose_repository.tcl:490
 msgid "Clone Type:"
 msgstr "Art des Klonens:"
=20
@@ -1525,7 +1560,27 @@ msgstr ""
 msgid "Loading diff of %s..."
 msgstr "Vergleich von =C2=BB%s=C2=AB laden..."
=20
=2D#: lib/diff.tcl:114 lib/diff.tcl:184
+#: lib/diff.tcl:120
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr ""
+
+#: lib/diff.tcl:125
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr ""
+
+#: lib/diff.tcl:132
+msgid "LOCAL:\n"
+msgstr ""
+
+#: lib/diff.tcl:135
+msgid "REMOTE:\n"
+msgstr ""
+
+#: lib/diff.tcl:197 lib/diff.tcl:296
 #, tcl-format
 msgid "Unable to display %s"
 msgstr "Datei =C2=BB%s=C2=AB kann nicht angezeigt werden"
@@ -1542,7 +1597,22 @@ msgstr "Git-Projektarchiv (Unterprojekt)"
 msgid "* Binary file (not showing content)."
 msgstr "* Bin=C3=A4rdatei (Inhalt wird nicht angezeigt)"
=20
=2D#: lib/diff.tcl:313
+#: lib/diff.tcl:222
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr ""
+
+#: lib/diff.tcl:228
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
+msgstr ""
+
+#: lib/diff.tcl:437
 msgid "Failed to unstage selected hunk."
 msgstr ""
 "Fehler beim Herausnehmen des gew=C3=A4hlten Kontexts aus der Bereitstellu=
ng."
@@ -1559,6 +1629,19 @@ msgstr "Fehler beim Herausnehmen der gew=C3=A4hlten =
Zeile aus der Bereitstellung."
 msgid "Failed to stage selected line."
 msgstr "Fehler beim Bereitstellen der gew=C3=A4hlten Zeile."
=20
+#: lib/encoding.tcl:443
+msgid "Default"
+msgstr "Voreinstellung"
+
+#: lib/encoding.tcl:448
+#, tcl-format
+msgid "System (%s)"
+msgstr "Systemweit (%s)"
+
+#: lib/encoding.tcl:459 lib/encoding.tcl:465
+msgid "Other"
+msgstr "Andere"
+
 #: lib/error.tcl:20 lib/error.tcl:114
 msgid "error"
 msgstr "Fehler"
@@ -1811,7 +1894,12 @@ msgstr ""
 "Diese Operation kann nur r=C3=BCckg=C3=A4ngig gemacht werden, wenn die\n"
 "Zusammenf=C3=BChrung erneut gestartet wird."
=20
=2D#: lib/mergetool.tcl:32
+#: lib/mergetool.tcl:45
+#, tcl-format
+msgid "File %s seems to have unresolved conflicts, still stage?"
+msgstr "Datei =C2=BB%s=C2=AB hat nicht aufgel=C3=B6ste Konflikte. Trotzdem=
 bereitstellen?"
+
+#: lib/mergetool.tcl:60
 #, tcl-format
 msgid "Adding resolution for %s"
 msgstr "Aufl=C3=B6sung hinzugef=C3=BCgt f=C3=BCr %s"
@@ -1868,12 +1956,17 @@ msgstr "Zusammenf=C3=BChrungswerkzeug starten..."
 msgid "Merge tool failed."
 msgstr "Zusammenf=C3=BChrungswerkzeug fehlgeschlagen."
=20
=2D#: lib/mergetool.tcl:353
+#: lib/option.tcl:11
+#, tcl-format
+msgid "Invalid global encoding '%s'"
+msgstr "Ung=C3=BCltige globale Zeichenkodierung =C2=BB%s=C2=AB"
+
+#: lib/option.tcl:19
 #, tcl-format
=2Dmsgid "File %s unchanged, still accept as resolved?"
=2Dmsgstr "Datei =C2=BB%s=C2=AB unver=C3=A4ndert. Trotzdem Konflikt als gel=
=C3=B6st akzeptieren?"
+msgid "Invalid repo encoding '%s'"
+msgstr "Ung=C3=BCltige Archiv-Zeichenkodierung =C2=BB%s=C2=AB"
=20
=2D#: lib/option.tcl:95
+#: lib/option.tcl:117
 msgid "Restore Defaults"
 msgstr "Voreinstellungen wiederherstellen"
=20
@@ -1950,7 +2043,15 @@ msgstr "Textbreite der Versionsbeschreibung"
 msgid "New Branch Name Template"
 msgstr "Namensvorschlag f=C3=BCr neue Zweige"
=20
=2D#: lib/option.tcl:192
+#: lib/option.tcl:155
+msgid "Default File Contents Encoding"
+msgstr "Vorgestellte Zeichenkodierung"
+
+#: lib/option.tcl:203
+msgid "Change"
+msgstr "=C3=84ndern"
+
+#: lib/option.tcl:230
 msgid "Spelling Dictionary:"
 msgstr "W=C3=B6rterbuch Rechtschreibpr=C3=BCfung:"
=20
@@ -1975,9 +2076,85 @@ msgstr "Einstellungen"
 msgid "Failed to completely save options:"
 msgstr "Optionen konnten nicht gespeichert werden:"
=20
+#: lib/remote_add.tcl:19
+msgid "Add Remote"
+msgstr "Anderes Archiv hinzuf=C3=BCgen"
+
+#: lib/remote_add.tcl:24
+msgid "Add New Remote"
+msgstr "Neues anderes Archiv hinzuf=C3=BCgen"
+
+#: lib/remote_add.tcl:28
+msgid "Add"
+msgstr "Hinzuf=C3=BCgen"
+
+#: lib/remote_add.tcl:37
+msgid "Remote Details"
+msgstr "Einzelheiten des anderen Archivs"
+
+#: lib/remote_add.tcl:50
+msgid "Location:"
+msgstr "Adresse:"
+
+#: lib/remote_add.tcl:62
+msgid "Further Action"
+msgstr "Weitere Aktion jetzt"
+
+#: lib/remote_add.tcl:65
+msgid "Fetch Immediately"
+msgstr "Gleich anfordern"
+
+#: lib/remote_add.tcl:71
+msgid "Initialize Remote Repository and Push"
+msgstr "Anderes Archiv initialisieren und dahin versenden"
+
+#: lib/remote_add.tcl:77
+msgid "Do Nothing Else Now"
+msgstr "Nichts tun"
+
+#: lib/remote_add.tcl:101
+#, fuzzy
+msgid "Please supply a remote name."
+msgstr "Bitte geben Sie einen Zweignamen an."
+
+#: lib/remote_add.tcl:114
+#, fuzzy, tcl-format
+msgid "'%s' is not an acceptable remote name."
+msgstr "=C2=BB%s=C2=AB ist kein zul=C3=A4ssiger Zweigname."
+
+#: lib/remote_add.tcl:125
+#, fuzzy, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr "Fehler beim Umbenennen von =C2=BB%s=C2=AB."
+
+#: lib/remote_add.tcl:133 lib/transport.tcl:6
+#, tcl-format
+msgid "fetch %s"
+msgstr "=C2=BB%s=C2=AB anfordern"
+
+#: lib/remote_add.tcl:134
+#, fuzzy, tcl-format
+msgid "Fetching the %s"
+msgstr "=C3=84nderungen =C2=BB%s=C2=AB von =C2=BB%s=C2=AB anfordern"
+
+#: lib/remote_add.tcl:157
+#, tcl-format
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr "Initialisieren eines anderen Archivs an Adresse =C2=BB%s=C2=AB ist=
 nicht m=C3=B6glich."
+
+#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:71
+#, tcl-format
+msgid "push %s"
+msgstr "=C2=BB%s=C2=AB versenden..."
+
+#: lib/remote_add.tcl:164
+#, tcl-format
+msgid "Setting up the %s (at %s)"
+msgstr "Einrichten von =C2=BB%s=C2=AB an =C2=BB%s=C2=AB"
+
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
=2Dmsgid "Delete Remote Branch"
=2Dmsgstr "Zweig in anderem Projektarchiv l=C3=B6schen"
+msgid "Delete Branch Remotely"
+msgstr "Zweig in anderem Archiv l=C3=B6schen"
=20
 #: lib/remote_branch_delete.tcl:47
 msgid "From Repository"
@@ -1988,8 +2165,8 @@ msgid "Remote:"
 msgstr "Anderes Archiv:"
=20
 #: lib/remote_branch_delete.tcl:66 lib/transport.tcl:138
=2Dmsgid "Arbitrary URL:"
=2Dmsgstr "Archiv-URL:"
+msgid "Arbitrary Location:"
+msgstr "Adresse:"
=20
 #: lib/remote_branch_delete.tcl:84
 msgid "Branches"
@@ -2061,7 +2238,11 @@ msgstr "Kein Projektarchiv ausgew=C3=A4hlt."
 msgid "Scanning %s..."
 msgstr "=C2=BB%s=C2=AB laden..."
=20
=2D#: lib/remote.tcl:165
+#: lib/remote.tcl:163
+msgid "Remove Remote"
+msgstr "Anderes Archiv entfernen"
+
+#: lib/remote.tcl:168
 msgid "Prune from"
 msgstr "Aufr=C3=A4umen von"
=20
@@ -2073,6 +2254,22 @@ msgstr "Anfordern von"
 msgid "Push to"
 msgstr "Versenden nach"
=20
+#: lib/search.tcl:21
+msgid "Find:"
+msgstr "Suchen:"
+
+#: lib/search.tcl:22
+msgid "Next"
+msgstr "N=C3=A4chster"
+
+#: lib/search.tcl:23
+msgid "Prev"
+msgstr "Voriger"
+
+#: lib/search.tcl:24
+msgid "Case-Sensitive"
+msgstr ""
+
 #: lib/shortcut.tcl:20 lib/shortcut.tcl:61
 msgid "Cannot write shortcut:"
 msgstr "Fehler beim Schreiben der Verkn=C3=BCpfung:"
@@ -2123,11 +2320,6 @@ msgstr "Rechtschreibpr=C3=BCfung fehlgeschlagen"
 msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr "%s ... %*i von %*i %s (%3i%%)"
=20
=2D#: lib/transport.tcl:6
=2D#, tcl-format
=2Dmsgid "fetch %s"
=2Dmsgstr "=C2=BB%s=C2=AB anfordern"
=2D
 #: lib/transport.tcl:7
 #, tcl-format
 msgid "Fetching new changes from %s"
@@ -2143,11 +2335,6 @@ msgstr "Aufr=C3=A4umen von =C2=BB%s=C2=AB"
 msgid "Pruning tracking branches deleted from %s"
 msgstr "=C3=9Cbernahmezweige aufr=C3=A4umen und entfernen, die in =C2=BB%s=
=C2=AB gel=C3=B6scht wurden"
=20
=2D#: lib/transport.tcl:25 lib/transport.tcl:71
=2D#, tcl-format
=2Dmsgid "push %s"
=2Dmsgstr "=C2=BB%s=C2=AB versenden..."
=2D
 #: lib/transport.tcl:26
 #, tcl-format
 msgid "Pushing changes to %s"
=2D-=20
1.6.0.rc1.34.g0fe8c


--Boundary-00=_7e4AJhGB4rmPqB4--

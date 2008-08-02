From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] git-gui: Update German translation
Date: Sat, 2 Aug 2008 09:56:19 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200808020956.20070.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kMBlIei5kkSn7we"
Cc: Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 11:02:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPD03-0007lW-Ta
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 11:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbYHBJBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 05:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752296AbYHBJBE
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 05:01:04 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:54617 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbYHBJBD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 05:01:03 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m727uOsK008965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 2 Aug 2008 09:56:25 +0200
Received: from [192.168.0.101] (e176206164.adsl.alicedsl.de [85.176.206.164])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m727uNJ1016678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 2 Aug 2008 09:56:24 +0200
User-Agent: KMail/1.9.5
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91138>

--Boundary-00=_kMBlIei5kkSn7we
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The subject says it all. Thanks for the new features.

Christian

--Boundary-00=_kMBlIei5kkSn7we
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-git-gui-Update-German-translation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-git-gui-Update-German-translation.patch"

=46rom 9d1e970ced1ca4bacfe27901d239cb148b0b87da Mon Sep 17 00:00:00 2001
=46rom: Christian Stimming <stimming@tuhh.de>
Date: Sat, 2 Aug 2008 09:54:51 +0200
Subject: [PATCH] git-gui: Update German translation

=2D--
 po/de.po |  102 ++++++++++++++++++++++++++++++++++++++++++----------------=
=2D--
 1 files changed, 70 insertions(+), 32 deletions(-)

diff --git a/po/de.po b/po/de.po
index f20955c..fa43947 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -7,8 +7,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2008-03-14 07:18+0100\n"
=2D"PO-Revision-Date: 2008-05-01 11:51+0200\n"
+"POT-Creation-Date: 2008-08-02 08:58+0200\n"
+"PO-Revision-Date: 2008-08-02 09:09+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -134,18 +134,11 @@ msgstr "Konfliktaufl=C3=B6sung n=C3=B6tig"
 msgid "Starting gitk... please wait..."
 msgstr "Gitk wird gestartet... bitte warten."
=20
=2D#: git-gui.sh:1653
=2D#, tcl-format
=2Dmsgid ""
=2D"Unable to start gitk:\n"
=2D"\n"
=2D"%s does not exist"
=2Dmsgstr ""
=2D"Gitk kann nicht gestartet werden:\n"
=2D"\n"
=2D"%s existiert nicht"
+#: git-gui.sh:1698
+msgid "Couldn't find gitk in PATH"
+msgstr "Gitk kann im PATH nicht gefunden werden."
=20
=2D#: git-gui.sh:1860 lib/choose_repository.tcl:36
+#: git-gui.sh:1948 lib/choose_repository.tcl:36
 msgid "Repository"
 msgstr "Projektarchiv"
=20
@@ -294,7 +287,15 @@ msgstr "Aus der Bereitstellung herausnehmen"
 msgid "Revert Changes"
 msgstr "=C3=84nderungen verwerfen"
=20
=2D#: git-gui.sh:2049 git-gui.sh:2368 git-gui.sh:2467
+#: git-gui.sh:2141 git-gui.sh:2702
+msgid "Show Less Context"
+msgstr "Weniger Zeilen anzeigen"
+
+#: git-gui.sh:2145 git-gui.sh:2706
+msgid "Show More Context"
+msgstr "Mehr Zeilen anzeigen"
+
+#: git-gui.sh:2151 git-gui.sh:2470 git-gui.sh:2569
 msgid "Sign Off"
 msgstr "Abzeichnen"
=20
@@ -314,11 +315,7 @@ msgstr "Zusammenf=C3=BChren abbrechen..."
 msgid "Push..."
 msgstr "Versenden..."
=20
=2D#: git-gui.sh:2092 lib/choose_repository.tcl:41
=2Dmsgid "Apple"
=2Dmsgstr "Apple"
=2D
=2D#: git-gui.sh:2095 git-gui.sh:2117 lib/about.tcl:14
+#: git-gui.sh:2197 git-gui.sh:2219 lib/about.tcl:14
 #: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
 #, tcl-format
 msgid "About %s"
@@ -403,15 +400,11 @@ msgstr "Datei:"
 msgid "Apply/Reverse Hunk"
 msgstr "Kontext anwenden/umkehren"
=20
=2D#: git-gui.sh:2595
=2Dmsgid "Show Less Context"
=2Dmsgstr "Weniger Zeilen anzeigen"
+#: git-gui.sh:2696
+msgid "Apply/Reverse Line"
+msgstr "Zeile anwenden/umkehren"
=20
=2D#: git-gui.sh:2602
=2Dmsgid "Show More Context"
=2Dmsgstr "Mehr Zeilen anzeigen"
=2D
=2D#: git-gui.sh:2610
+#: git-gui.sh:2711
 msgid "Refresh"
 msgstr "Aktualisieren"
=20
@@ -427,11 +420,19 @@ msgstr "Schriftgr=C3=B6=C3=9Fe vergr=C3=B6=C3=9Fern"
 msgid "Unstage Hunk From Commit"
 msgstr "Kontext aus Bereitstellung herausnehmen"
=20
=2D#: git-gui.sh:2648
+#: git-gui.sh:2748
+msgid "Unstage Line From Commit"
+msgstr "Zeile aus der Bereitstellung herausnehmen"
+
+#: git-gui.sh:2750
 msgid "Stage Hunk For Commit"
 msgstr "Kontext zur Bereitstellung hinzuf=C3=BCgen"
=20
=2D#: git-gui.sh:2667
+#: git-gui.sh:2751
+msgid "Stage Line For Commit"
+msgstr "Zeile zur Bereitstellung hinzuf=C3=BCgen"
+
+#: git-gui.sh:2771
 msgid "Initializing..."
 msgstr "Initialisieren..."
=20
@@ -493,7 +494,11 @@ msgstr "Version:"
 msgid "Copy Commit"
 msgstr "Version kopieren"
=20
=2D#: lib/blame.tcl:384
+#: lib/blame.tcl:260
+msgid "Do Full Copy Detection"
+msgstr "Volle Kopie-Erkennung"
+
+#: lib/blame.tcl:388
 #, tcl-format
 msgid "Reading %s..."
 msgstr "%s lesen..."
@@ -514,7 +519,19 @@ msgstr "Annotierungen f=C3=BCr urspr=C3=BCnglichen Ort=
 werden geladen..."
 msgid "Annotation complete."
 msgstr "Annotierung vollst=C3=A4ndig."
=20
=2D#: lib/blame.tcl:746
+#: lib/blame.tcl:737
+msgid "Busy"
+msgstr "Verarbeitung l=C3=A4uft"
+
+#: lib/blame.tcl:738
+msgid "Annotation process is already running."
+msgstr "Annotierung l=C3=A4uft bereits."
+
+#: lib/blame.tcl:777
+msgid "Running thorough copy detection..."
+msgstr "Intensive Kopie-Erkennung l=C3=A4uft..."
+
+#: lib/blame.tcl:827
 msgid "Loading annotation..."
 msgstr "Annotierung laden..."
=20
@@ -759,7 +776,12 @@ msgstr "Schlie=C3=9Fen"
 msgid "Branch '%s' does not exist."
 msgstr "Zweig =C2=BB%s=C2=AB existiert nicht."
=20
=2D#: lib/checkout_op.tcl:206
+#: lib/checkout_op.tcl:193
+#, tcl-format
+msgid "Failed to configure simplified git-pull for '%s'."
+msgstr "Fehler beim Einrichten der vereinfachten git-pull f=C3=BCr =C2=BB%=
s=C2=AB."
+
+#: lib/checkout_op.tcl:228
 #, tcl-format
 msgid ""
 "Branch '%s' already exists.\n"
@@ -1485,6 +1507,14 @@ msgstr ""
 msgid "Failed to stage selected hunk."
 msgstr "Fehler beim Bereitstellen des gew=C3=A4hlten Kontexts."
=20
+#: lib/diff.tcl:386
+msgid "Failed to unstage selected line."
+msgstr "Fehler beim Herausnehmen der gew=C3=A4hlten Zeile aus der Bereitst=
ellung."
+
+#: lib/diff.tcl:394
+msgid "Failed to stage selected line."
+msgstr "Fehler beim Bereitstellen der gew=C3=A4hlten Zeile."
+
 #: lib/error.tcl:20 lib/error.tcl:114
 msgid "error"
 msgstr "Fehler"
@@ -1750,6 +1780,14 @@ msgid "Match Tracking Branches"
 msgstr "Passend zu =C3=9Cbernahmezweig"
=20
 #: lib/option.tcl:126
+msgid "Blame Copy Only On Changed Files"
+msgstr "Kopie-Annotieren nur bei ge=C3=A4nderten Dateien"
+
+#: lib/option.tcl:127
+msgid "Minimum Letters To Blame Copy On"
+msgstr "Mindestzahl Zeichen f=C3=BCr Kopie-Annotieren"
+
+#: lib/option.tcl:128
 msgid "Number of Diff Context Lines"
 msgstr "Anzahl der Kontextzeilen beim Vergleich"
=20
=2D-=20
1.5.5.1.316.g377d9


--Boundary-00=_kMBlIei5kkSn7we--

From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 3/4] git-gui i18n: Incorporate glossary changes into existing German translation.
Date: Fri, 5 Oct 2007 22:40:40 +0200
Message-ID: <200710052240.40591.stimming@tuhh.de>
References: <200710052239.02492.stimming@tuhh.de> <200710052239.47628.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 05 22:17:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdtcL-0001Z5-Sy
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 22:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760877AbXJEURk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2007 16:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760724AbXJEURk
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 16:17:40 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:35573 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759624AbXJEURj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2007 16:17:39 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l95KHYQB020100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 5 Oct 2007 22:17:34 +0200
Received: from [192.168.2.102] (p54900D20.dip0.t-ipconnect.de [84.144.13.32])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l95KHWxB021828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Oct 2007 22:17:33 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <200710052239.47628.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60128>

Signed-off-by: Christian Stimming <stimming@tuhh.de>

---
 po/de.po |  113 ++++++++++++++++++++++++++----------------------------=
--------
 1 files changed, 47 insertions(+), 66 deletions(-)

diff --git a/po/de.po b/po/de.po
index 94b7463..ee69d66 100644
--- a/po/de.po
+++ b/po/de.po
@@ -8,7 +8,7 @@ msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2007-08-11 17:28+0200\n"
-"PO-Revision-Date: 2007-08-11 17:37+0200\n"
+"PO-Revision-Date: 2007-10-05 22:00+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -80,15 +80,15 @@ msgstr "Ver=E4ndert, nicht bereitgestellt"
=20
 #: git-gui.sh:1325 git-gui.sh:1330
 msgid "Staged for commit"
-msgstr "Bereitgestellt zur =DCbertragung"
+msgstr "Bereitgestellt zum Eintragen"
=20
 #: git-gui.sh:1326 git-gui.sh:1331
 msgid "Portions staged for commit"
-msgstr "Teilweise bereitgestellt zur =DCbertragung"
+msgstr "Teilweise bereitgestellt zum Eintragen"
=20
 #: git-gui.sh:1327 git-gui.sh:1332
 msgid "Staged for commit, missing"
-msgstr "Bereitgestellt zur =DCbertragung, fehlend"
+msgstr "Bereitgestellt zum Eintragen, fehlend"
=20
 #: git-gui.sh:1329
 msgid "Untracked, not staged"
@@ -152,7 +152,7 @@ msgstr "Zweig"
=20
 #: git-gui.sh:1655 git-gui.sh:1842 git-gui.sh:2152
 msgid "Commit"
-msgstr "=DCbertragen"
+msgstr "Eintragen"
=20
 #: git-gui.sh:1658 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
@@ -249,7 +249,7 @@ msgstr "Erstellen..."
=20
 #: git-gui.sh:1764
 msgid "Checkout..."
-msgstr "Auschecken..."
+msgstr "Arbeitskopie erstellen..."
=20
 #: git-gui.sh:1770
 msgid "Rename..."
@@ -265,11 +265,11 @@ msgstr "Zur=FCcksetzen..."
=20
 #: git-gui.sh:1792 git-gui.sh:2169
 msgid "New Commit"
-msgstr "Neu =FCbertragen"
+msgstr "Neue Version"
=20
 #: git-gui.sh:1800 git-gui.sh:2176
 msgid "Amend Last Commit"
-msgstr "Letzte =DCbertragung nachbessern"
+msgstr "Letzte Version nachbessern"
=20
 #: git-gui.sh:1809 git-gui.sh:2136 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
@@ -277,11 +277,11 @@ msgstr "Neu laden"
=20
 #: git-gui.sh:1815
 msgid "Stage To Commit"
-msgstr "Zur =DCbertragung bereitstellen"
+msgstr "Zum Eintragen bereitstellen"
=20
 #: git-gui.sh:1820
 msgid "Stage Changed Files To Commit"
-msgstr "Ge=E4nderte Dateien zur =DCbertragung bereitstellen"
+msgstr "Ge=E4nderte Dateien zum Eintragen bereitstellen"
=20
 #: git-gui.sh:1826
 msgid "Unstage From Commit"
@@ -334,11 +334,11 @@ msgstr "Aktueller Zweig:"
=20
 #: git-gui.sh:2075
 msgid "Staged Changes (Will Be Committed)"
-msgstr "Bereitgestellte =C4nderungen (werden =FCbertragen)"
+msgstr "Bereitgestellte =C4nderungen (werden eingetragen)"
=20
 #: git-gui.sh:2095
 msgid "Unstaged Changes (Will Not Be Committed)"
-msgstr "Nicht bereitgestellte =C4nderungen (werden nicht =FCbertragen)=
"
+msgstr "Nicht bereitgestellte =C4nderungen (werden nicht eingetragen)"
=20
 #: git-gui.sh:2142
 msgid "Stage Changed"
@@ -346,27 +346,27 @@ msgstr "Ge=E4nderte bereitstellen"
=20
 #: git-gui.sh:2188
 msgid "Initial Commit Message:"
-msgstr "Erstmalige =DCbertragungsmeldung"
+msgstr "Beschreibung der ersten Version:"
=20
 #: git-gui.sh:2189
 msgid "Amended Commit Message:"
-msgstr "=DCbertragungsmeldung mit Nachbesserung:"
+msgstr "Beschreibung der nachgebesserten Version:"
=20
 #: git-gui.sh:2190
 msgid "Amended Initial Commit Message:"
-msgstr "Erstmalige =DCbertragungsmeldung mit Nachbesserung:"
+msgstr "Beschreibung der nachgebesserten ersten Version:"
=20
 #: git-gui.sh:2191
 msgid "Amended Merge Commit Message:"
-msgstr "Zusammenf=FChrungs-=DCbertragungsmeldung mit Nachbesserung"
+msgstr "Beschreibung der nachgebesserten Zusammenf=FChrungs-Version:"
=20
 #: git-gui.sh:2192
 msgid "Merge Commit Message:"
-msgstr "=DCbertragungsmeldung Zusammenf=FChrung:"
+msgstr "Beschreibung der Zusammenf=FChrungs-Version:"
=20
 #: git-gui.sh:2193
 msgid "Commit Message:"
-msgstr "=DCbertragungsmeldung:"
+msgstr "Versionsbeschreibung:"
=20
 #: git-gui.sh:2238 git-gui.sh:2376 lib/console.tcl:73
 msgid "Copy All"
@@ -418,11 +418,11 @@ msgstr "Datei-Browser"
=20
 #: lib/blame.tcl:81
 msgid "Commit:"
-msgstr "=DCbertragung:"
+msgstr "Version:"
=20
 #: lib/blame.tcl:249
 msgid "Copy Commit"
-msgstr "=DCbertragung kopieren"
+msgstr "Version kopieren"
=20
 #: lib/blame.tcl:369
 #, tcl-format
@@ -431,11 +431,11 @@ msgstr "%s lesen..."
=20
 #: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
 msgid "Checkout Branch"
-msgstr "Zweig auschecken"
+msgstr "Zweig umstellen"
=20
 #: lib/branch_checkout.tcl:23
 msgid "Checkout"
-msgstr "Auschecken"
+msgstr "Umstellen"
=20
 #: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
 #: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
83
@@ -507,7 +507,7 @@ msgstr "Zur=FCcksetzen"
=20
 #: lib/branch_create.tcl:97
 msgid "Checkout After Creation"
-msgstr "Auschecken nach Erstellen"
+msgstr "Arbeitskopie umstellen nach Erstellen"
=20
 #: lib/branch_create.tcl:131
 msgid "Please select a tracking branch."
@@ -686,8 +686,7 @@ msgstr ""
 #: lib/checkout_op.tcl:353
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
-msgstr ""
-"Auschecken von =BB%s=AB abgebrochen (Zusammenf=FChren der Dateien ist=
 notwendig)."
+msgstr "Zweig umstellen von =BB%s=AB abgebrochen (Zusammenf=FChren der=
 Dateien ist notwendig)."
=20
 #: lib/checkout_op.tcl:354
 msgid "File level merge required."
@@ -707,8 +706,7 @@ msgid ""
 msgstr ""
 "Die Arbeitskopie ist nicht auf einem lokalen Zweig.\n"
 "\n"
-"Wenn Sie auf einem Zwei arbeiten m=F6chten, erstellen Sie bitte jetzt=
 einen "
-"Zweig mit der Auswahl =BBAbgetrennte Auscheck-Version=AB."
+"Wenn Sie auf einem Zweig arbeiten m=F6chten, erstellen Sie bitte jetz=
t einen Zweig mit der Auswahl =BBAbgetrennte Arbeitskopie-Version=AB."
=20
 #: lib/checkout_op.tcl:478
 #, tcl-format
@@ -750,7 +748,7 @@ msgstr ""
=20
 #: lib/choose_rev.tcl:53
 msgid "This Detached Checkout"
-msgstr "Abgetrennte Auscheck-Version"
+msgstr "Abgetrennte Arbeitskopie-Version"
=20
 #: lib/choose_rev.tcl:60
 msgid "Revision Expression:"
@@ -831,8 +829,7 @@ msgid ""
 msgstr ""
 "Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv =FC=
berein.\n"
 "\n"
-"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden=
 "
-"ge=E4ndert.  Vor einer neuen =DCbertragung muss neu geladen werden.\n=
"
+"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden=
 ge=E4ndert.  Vor dem Eintragen einer neuen Version muss neu geladen we=
rden.\n"
 "\n"
 "Es wird gleich neu geladen.\n"
=20
@@ -844,10 +841,9 @@ msgid ""
 "File %s has merge conflicts.  You must resolve them and stage the fil=
e "
 "before committing.\n"
 msgstr ""
-"Nicht zusammengef=FChrte Dateien k=F6nnen nicht =FCbertragen werden.\=
n"
+"Nicht zusammengef=FChrte Dateien k=F6nnen nicht eingetragen werden.\n=
"
 "\n"
-"Die Datei %s hat noch nicht aufgel=F6ste Zusammenf=FChrungs-Konflikte=
=2E Sie "
-"m=FCssen diese Konflikte aufl=F6sen, bevor Sie =FCbertragen k=F6nnen.=
\n"
+"Die Datei =BB%s=AB hat noch nicht aufgel=F6ste Zusammenf=FChrungs-Kon=
flikte. Sie m=FCssen diese Konflikte aufl=F6sen, bevor Sie eintragen k=F6=
nnen.\n"
=20
 #: lib/commit.tcl:162
 #, tcl-format
@@ -858,7 +854,7 @@ msgid ""
 msgstr ""
 "Unbekannter Dateizustand =BB%s=AB.\n"
 "\n"
-"Datei =BB%s=AB kann nicht =FCbertragen werden.\n"
+"Datei =BB%s=AB kann nicht eingetragen werden.\n"
=20
 #: lib/commit.tcl:170
 msgid ""
@@ -866,10 +862,9 @@ msgid ""
 "\n"
 "You must stage at least 1 file before you can commit.\n"
 msgstr ""
-"Keine =C4nderungen vorhanden, die =FCbertragen werden k=F6nnten.\n"
+"Keine =C4nderungen vorhanden, die eingetragen werden k=F6nnten.\n"
 "\n"
-"Sie m=FCssen mindestens eine Datei bereitstellen, bevor Sie =FCbertra=
gen "
-"k=F6nnen.\n"
+"Sie m=FCssen mindestens eine Datei bereitstellen, bevor Sie eintragen=
 k=F6nnen.\n"
=20
 #: lib/commit.tcl:183
 msgid ""
@@ -881,16 +876,15 @@ msgid ""
 "- Second line: Blank\n"
 "- Remaining lines: Describe why this change is good.\n"
 msgstr ""
-"Bitte geben Sie eine =DCbertragungsmeldung ein.\n"
+"Bitte geben Sie eine Versionsbeschreibung ein.\n"
 "\n"
-"Eine gute =DCbertragungsmeldung enth=E4lt folgende Abschnitte:\n"
+"Eine gute Versionsbeschreibung enth=E4lt folgende Abschnitte:\n"
 "\n"
 "- Erste Zeile: Eine Zusammenfassung, was man gemacht hat.\n"
 "\n"
 "- Zweite Zeile: Leerzeile\n"
 "\n"
-"- Rest der Meldung: Eine ausf=FChrliche Beschreibung, warum diese =C4=
nderung "
-"hilfreich ist.\n"
+"- Rest: Eine ausf=FChrliche Beschreibung, warum diese =C4nderung hilf=
reich ist.\n"
=20
 #: lib/commit.tcl:257
 msgid "write-tree failed:"
@@ -904,16 +898,15 @@ msgid ""
 "\n"
 "A rescan will be automatically started now.\n"
 msgstr ""
-"Keine =C4nderungen zu =FCbertragen.\n"
+"Keine =C4nderungen einzutragen.\n"
 "\n"
-"Es gibt keine ge=E4nderte Datei bei dieser =DCbertragung und es wurde=
 auch "
-"nichts zusammengef=FChrt.\n"
+"Es gibt keine ge=E4nderte Datei bei dieser Version und es wurde auch =
nichts zusammengef=FChrt.\n"
 "\n"
 "Das Arbeitsverzeichnis wird daher jetzt neu geladen.\n"
=20
 #: lib/commit.tcl:286
 msgid "No changes to commit."
-msgstr "Keine =C4nderungen, die =FCbertragen werden k=F6nnen."
+msgstr "Keine =C4nderungen, die eingetragen werden k=F6nnen."
=20
 #: lib/commit.tcl:317
 msgid "commit-tree failed:"
@@ -1024,8 +1017,7 @@ msgstr "Warnung"
=20
 #: lib/error.tcl:81
 msgid "You must correct the above errors before committing."
-msgstr ""
-"Sie m=FCssen die obigen Fehler zuerst beheben, bevor Sie =FCbertragen=
 k=F6nnen."
+msgstr "Sie m=FCssen die obigen Fehler zuerst beheben, bevor Sie eintr=
agen k=F6nnen."
=20
 #: lib/index.tcl:364
 #, tcl-format
@@ -1054,8 +1046,7 @@ msgid ""
 msgstr ""
 "Zusammenf=FChren kann nicht gleichzeitig mit Nachbessern durchgef=FCh=
rt werden.\n"
 "\n"
-"Sie m=FCssen zuerst die Nachbesserungs-=DCbertragung abschlie=DFen, b=
evor Sie "
-"zusammenf=FChren k=F6nnen.\n"
+"Sie m=FCssen zuerst die Nachbesserungs-Version abschlie=DFen, bevor S=
ie zusammenf=FChren k=F6nnen.\n"
=20
 #: lib/merge.tcl:27
 msgid ""
@@ -1085,10 +1076,7 @@ msgid ""
 msgstr ""
 "Zusammenf=FChrung mit Konflikten.\n"
 "\n"
-"Die Datei =BB%s=AB enth=E4lt Konflikte beim Zusammenf=FChren. Sie m=FC=
ssen diese "
-"Konflikte per Hand aufl=F6sen. Anschlie=DFend m=FCssen Sie die Datei =
wieder "
-"bereitstellen und =FCbertragen, um die Zusammenf=FChrung abzuschlie=DF=
en. Erst "
-"danach kann eine neue Zusammenf=FChrung begonnen werden.\n"
+"Die Datei =BB%s=AB enth=E4lt Konflikte beim Zusammenf=FChren. Sie m=FC=
ssen diese Konflikte per Hand aufl=F6sen. Anschlie=DFend m=FCssen Sie d=
ie Datei wieder bereitstellen und eintragen, um die Zusammenf=FChrung a=
bzuschlie=DFen. Erst danach kann eine neue Zusammenf=FChrung begonnen w=
erden.\n"
=20
 #: lib/merge.tcl:54
 #, tcl-format
@@ -1102,10 +1090,7 @@ msgid ""
 msgstr ""
 "Es liegen =C4nderungen vor.\n"
 "\n"
-"Die Datei =BB%s=AB wurde ge=E4ndert.  Sie sollten zuerst die bereitge=
stellte "
-"=DCbertragung abschlie=DFen, bevor Sie eine Zusammenf=FChrung beginne=
n.  Mit "
-"dieser Reihenfolge k=F6nnen Sie m=F6gliche Konflikte beim Zusammenf=FC=
hren "
-"wesentlich einfacher beheben oder abbrechen.\n"
+"Die Datei =BB%s=AB wurde ge=E4ndert.  Sie sollten zuerst die bereitge=
stellte Version abschlie=DFen, bevor Sie eine Zusammenf=FChrung beginne=
n.  Mit dieser Reihenfolge k=F6nnen Sie m=F6gliche Konflikte beim Zusam=
menf=FChren wesentlich einfacher beheben oder abbrechen.\n"
=20
 #: lib/merge.tcl:106
 #, tcl-format
@@ -1142,7 +1127,7 @@ msgid ""
 msgstr ""
 "Abbruch der Nachbesserung ist nicht m=F6glich.\n"
 "\n"
-"Sie m=FCssen die Nachbesserung der =DCbertragung abschlie=DFen.\n"
+"Sie m=FCssen die Nachbesserung der Version abschlie=DFen.\n"
=20
 #: lib/merge.tcl:222
 msgid ""
@@ -1154,7 +1139,7 @@ msgid ""
 msgstr ""
 "Zusammenf=FChren abbrechen?\n"
 "\n"
-"Wenn Sie abbrechen, gehen alle noch nicht =FCbertragenen =C4nderungen=
 verloren.\n"
+"Wenn Sie abbrechen, gehen alle noch nicht eingetragenen =C4nderungen =
verloren.\n"
 "\n"
 "Zusammenf=FChren jetzt abbrechen?"
=20
@@ -1168,8 +1153,7 @@ msgid ""
 msgstr ""
 "=C4nderungen zur=FCcksetzen?\n"
 "\n"
-"Wenn Sie zur=FCcksetzen, gehen alle noch nicht =FCbertragenen =C4nder=
ungen "
-"verloren.\n"
+"Wenn Sie zur=FCcksetzen, gehen alle noch nicht eingetragenen =C4nderu=
ngen verloren.\n"
 "\n"
 "=C4nderungen jetzt zur=FCcksetzen?"
=20
@@ -1216,7 +1200,7 @@ msgstr "E-Mail-Adresse"
=20
 #: lib/option.tcl:188
 msgid "Summarize Merge Commits"
-msgstr "Zusammenf=FChrungs-=DCbertragungen zusammenfassen"
+msgstr "Zusammenf=FChrungs-Versionen zusammenfassen"
=20
 #: lib/option.tcl:189
 msgid "Merge Verbosity"
@@ -1291,10 +1275,7 @@ msgstr "F=FCr =BBZusammenf=FChren mit=AB muss ei=
n Zweig angegeben werden."
 msgid ""
 "One or more of the merge tests failed because you have not fetched th=
e "
 "necessary commits.  Try fetching from %s first."
-msgstr ""
-"Ein oder mehrere Zusammenf=FChrungen sind fehlgeschlagen, da Sie nich=
t die "
-"notwendigen Versionen vorher angefordert haben.  Sie sollten versuche=
n, "
-"zuerst von =BB%s=AB anzufordern."
+msgstr "Ein oder mehrere Zusammenf=FChrungen sind fehlgeschlagen, da S=
ie nicht die notwendigen Versionen vorher angefordert haben.  Sie sollt=
en versuchen, zuerst von =BB%s=AB anzufordern."
=20
 #: lib/remote_branch_delete.tcl:207
 msgid "Please select one or more branches to delete."
--=20
1.5.3.rc2.6.g40240

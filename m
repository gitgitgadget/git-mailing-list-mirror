From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 4/4] git-gui i18n: Update German translation, including latest glossary changes.
Date: Fri, 5 Oct 2007 22:41:16 +0200
Message-ID: <200710052241.16395.stimming@tuhh.de>
References: <200710052239.02492.stimming@tuhh.de> <200710052239.47628.stimming@tuhh.de> <200710052240.40591.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 05 22:19:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdtdX-00020k-4f
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 22:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761810AbXJEUSR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2007 16:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760724AbXJEUSR
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 16:18:17 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:35604 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbXJEUSP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2007 16:18:15 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l95KIAdX020192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 5 Oct 2007 22:18:10 +0200
Received: from [192.168.2.102] (p54900D20.dip0.t-ipconnect.de [84.144.13.32])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l95KI8Xn022093
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Oct 2007 22:18:09 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <200710052240.40591.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60129>

Signed-off-by: Christian Stimming <stimming@tuhh.de>

---
 po/de.po |  798 +++++++++++++++++++++++++++++++++++++++++++++++++-----=
--------
 1 files changed, 633 insertions(+), 165 deletions(-)

diff --git a/po/de.po b/po/de.po
index ee69d66..60b9ea5 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7,23 +7,41 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2007-08-11 17:28+0200\n"
-"PO-Revision-Date: 2007-10-05 22:00+0200\n"
+"POT-Creation-Date: 2007-10-05 22:01+0200\n"
+"PO-Revision-Date: 2007-10-05 22:27+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: git-gui.sh:531
+#: git-gui.sh:41 git-gui.sh:631 git-gui.sh:645 git-gui.sh:658 git-gui.=
sh:740
+#: git-gui.sh:759
+msgid "git-gui: fatal error"
+msgstr "git-gui: Programmfehler"
+
+#: git-gui.sh:592
+#, tcl-format
+msgid "Invalid font specified in %s:"
+msgstr "Ung=FCltige Zeichensatz-Angabe in %s:"
+
+#: git-gui.sh:617
+msgid "Main Font"
+msgstr "Programmschriftart"
+
+#: git-gui.sh:618
+msgid "Diff/Console Font"
+msgstr "Vergleich-Schriftart"
+
+#: git-gui.sh:632
 msgid "Cannot find git in PATH."
 msgstr "Git kann im PATH nicht gefunden werden."
=20
-#: git-gui.sh:550
+#: git-gui.sh:659
 msgid "Cannot parse Git version string:"
 msgstr "Git Versionsangabe kann nicht erkannt werden:"
=20
-#: git-gui.sh:567
+#: git-gui.sh:676
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -42,79 +60,79 @@ msgstr ""
 "\n"
 "Soll angenommen werden, =BB%s=AB sei Version 1.5.0?\n"
=20
-#: git-gui.sh:689
-msgid "Cannot find the git directory:"
-msgstr "Git-Verzeichnis kann nicht gefunden werden:"
-
-#: git-gui.sh:697
+#: git-gui.sh:849
 msgid "Git directory not found:"
 msgstr "Git-Verzeichnis nicht gefunden:"
=20
-#: git-gui.sh:703
+#: git-gui.sh:856
+msgid "Cannot move to top of working directory:"
+msgstr "Es konnte nicht in das oberste Verzeichnis der Arbeitskopie ge=
wechselt werden:"
+
+#: git-gui.sh:863
 msgid "Cannot use funny .git directory:"
 msgstr "Unerwartete Struktur des .git Verzeichnis:"
=20
-#: git-gui.sh:708
+#: git-gui.sh:868
 msgid "No working directory"
 msgstr "Kein Arbeitsverzeichnis"
=20
-#: git-gui.sh:854
+#: git-gui.sh:1015
 msgid "Refreshing file status..."
 msgstr "Dateistatus aktualisieren..."
=20
-#: git-gui.sh:891
+#: git-gui.sh:1080
 msgid "Scanning for modified files ..."
 msgstr "Nach ge=E4nderten Dateien suchen..."
=20
-#: git-gui.sh:1057 lib/browser.tcl:247
+#: git-gui.sh:1255 lib/browser.tcl:245
 msgid "Ready."
 msgstr "Bereit."
=20
-#: git-gui.sh:1322
+#: git-gui.sh:1521
 msgid "Unmodified"
 msgstr "Unver=E4ndert"
=20
-#: git-gui.sh:1324
+#: git-gui.sh:1523
 msgid "Modified, not staged"
 msgstr "Ver=E4ndert, nicht bereitgestellt"
=20
-#: git-gui.sh:1325 git-gui.sh:1330
+#: git-gui.sh:1524 git-gui.sh:1529
 msgid "Staged for commit"
 msgstr "Bereitgestellt zum Eintragen"
=20
-#: git-gui.sh:1326 git-gui.sh:1331
+#: git-gui.sh:1525 git-gui.sh:1530
 msgid "Portions staged for commit"
 msgstr "Teilweise bereitgestellt zum Eintragen"
=20
-#: git-gui.sh:1327 git-gui.sh:1332
+#: git-gui.sh:1526 git-gui.sh:1531
 msgid "Staged for commit, missing"
 msgstr "Bereitgestellt zum Eintragen, fehlend"
=20
-#: git-gui.sh:1329
+#: git-gui.sh:1528
 msgid "Untracked, not staged"
 msgstr "Nicht unter Versionskontrolle, nicht bereitgestellt"
=20
-#: git-gui.sh:1334
+#: git-gui.sh:1533
 msgid "Missing"
 msgstr "Fehlend"
=20
-#: git-gui.sh:1335
+#: git-gui.sh:1534
 msgid "Staged for removal"
 msgstr "Bereitgestellt zum L=F6schen"
=20
-#: git-gui.sh:1336
+#: git-gui.sh:1535
 msgid "Staged for removal, still present"
 msgstr "Bereitgestellt zum L=F6schen, trotzdem vorhanden"
=20
-#: git-gui.sh:1338 git-gui.sh:1339 git-gui.sh:1340 git-gui.sh:1341
+#: git-gui.sh:1537 git-gui.sh:1538 git-gui.sh:1539 git-gui.sh:1540
 msgid "Requires merge resolution"
 msgstr "Konfliktaufl=F6sung n=F6tig"
=20
-#: git-gui.sh:1383
+#: git-gui.sh:1575
 msgid "Starting gitk... please wait..."
 msgstr "Gitk wird gestartet... bitte warten."
=20
-#: git-gui.sh:1392
+#: git-gui.sh:1584
 #, tcl-format
 msgid ""
 "Unable to start gitk:\n"
@@ -125,293 +143,319 @@ msgstr ""
 "\n"
 "%s existiert nicht"
=20
-#: git-gui.sh:1609
-#, tcl-format
-msgid "Invalid font specified in gui.%s:"
-msgstr "Ung=FCltige Zeichensatz-Angabe in gui.%s:"
-
-#: git-gui.sh:1634
-msgid "Main Font"
-msgstr "Programmschriftart"
-
-#: git-gui.sh:1635
-msgid "Diff/Console Font"
-msgstr "Vergleich-Schriftart"
-
-#: git-gui.sh:1649
+#: git-gui.sh:1784 lib/choose_repository.tcl:64
 msgid "Repository"
 msgstr "Projektarchiv"
=20
-#: git-gui.sh:1650
+#: git-gui.sh:1785
 msgid "Edit"
 msgstr "Bearbeiten"
=20
-#: git-gui.sh:1652
+#: git-gui.sh:1787 lib/choose_rev.tcl:560
 msgid "Branch"
 msgstr "Zweig"
=20
-#: git-gui.sh:1655 git-gui.sh:1842 git-gui.sh:2152
-msgid "Commit"
-msgstr "Eintragen"
+#: git-gui.sh:1790 lib/choose_rev.tcl:547
+msgid "Commit@@noun"
+msgstr "Version"
=20
-#: git-gui.sh:1658 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
+#: git-gui.sh:1793 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
 msgstr "Zusammenf=FChren"
=20
-#: git-gui.sh:1659
+#: git-gui.sh:1794
 msgid "Fetch"
 msgstr "Anfordern"
=20
-#: git-gui.sh:1660 git-gui.sh:2158 lib/transport.tcl:88 lib/transport.=
tcl:172
+#: git-gui.sh:1795 git-gui.sh:2294 lib/transport.tcl:93 lib/transport.=
tcl:182
 msgid "Push"
 msgstr "Ausliefern"
=20
-#: git-gui.sh:1669
+#: git-gui.sh:1804
 msgid "Browse Current Branch's Files"
 msgstr "Aktuellen Zweig durchbl=E4ttern"
=20
-#: git-gui.sh:1673
+#: git-gui.sh:1808
 msgid "Browse Branch Files..."
 msgstr "Einen Zweig durchbl=E4ttern..."
=20
-#: git-gui.sh:1678
+#: git-gui.sh:1813
 msgid "Visualize Current Branch's History"
 msgstr "Aktuellen Zweig darstellen"
=20
-#: git-gui.sh:1682
+#: git-gui.sh:1817
 msgid "Visualize All Branch History"
 msgstr "Alle Zweige darstellen"
=20
-#: git-gui.sh:1689
+#: git-gui.sh:1824
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "Zweig =BB%s=AB durchbl=E4ttern"
=20
-#: git-gui.sh:1691
+#: git-gui.sh:1826
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "Historie von =BB%s=AB darstellen"
=20
-#: git-gui.sh:1696 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:1831 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "Datenbankstatistik"
=20
-#: git-gui.sh:1699 lib/database.tcl:34
+#: git-gui.sh:1834 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "Datenbank komprimieren"
=20
-#: git-gui.sh:1702
+#: git-gui.sh:1837
 msgid "Verify Database"
 msgstr "Datenbank =FCberpr=FCfen"
=20
-#: git-gui.sh:1709 git-gui.sh:1713 git-gui.sh:1717 lib/shortcut.tcl:9
+#: git-gui.sh:1844 git-gui.sh:1848 git-gui.sh:1852 lib/shortcut.tcl:9
 #: lib/shortcut.tcl:45 lib/shortcut.tcl:84
 msgid "Create Desktop Icon"
 msgstr "Desktop-Icon erstellen"
=20
-#: git-gui.sh:1722
+#: git-gui.sh:1857 lib/choose_repository.tcl:68 lib/choose_repository.=
tcl:132
 msgid "Quit"
 msgstr "Beenden"
=20
-#: git-gui.sh:1729
+#: git-gui.sh:1864
 msgid "Undo"
 msgstr "R=FCckg=E4ngig"
=20
-#: git-gui.sh:1732
+#: git-gui.sh:1867
 msgid "Redo"
 msgstr "Wiederholen"
=20
-#: git-gui.sh:1736 git-gui.sh:2222
+#: git-gui.sh:1871 git-gui.sh:2358
 msgid "Cut"
 msgstr "Ausschneiden"
=20
-#: git-gui.sh:1739 git-gui.sh:2225 git-gui.sh:2296 git-gui.sh:2368
-#: lib/console.tcl:69
+#: git-gui.sh:1874 git-gui.sh:2361 git-gui.sh:2432 git-gui.sh:2504
+#: lib/console.tcl:67
 msgid "Copy"
 msgstr "Kopieren"
=20
-#: git-gui.sh:1742 git-gui.sh:2228
+#: git-gui.sh:1877 git-gui.sh:2364
 msgid "Paste"
 msgstr "Einf=FCgen"
=20
-#: git-gui.sh:1745 git-gui.sh:2231 lib/branch_delete.tcl:26
+#: git-gui.sh:1880 git-gui.sh:2367 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "L=F6schen"
=20
-#: git-gui.sh:1749 git-gui.sh:2235 git-gui.sh:2372 lib/console.tcl:71
+#: git-gui.sh:1884 git-gui.sh:2371 git-gui.sh:2508 lib/console.tcl:69
 msgid "Select All"
 msgstr "Alle ausw=E4hlen"
=20
-#: git-gui.sh:1758
+#: git-gui.sh:1893
 msgid "Create..."
 msgstr "Erstellen..."
=20
-#: git-gui.sh:1764
+#: git-gui.sh:1899
 msgid "Checkout..."
-msgstr "Arbeitskopie erstellen..."
+msgstr "Umstellen..."
=20
-#: git-gui.sh:1770
+#: git-gui.sh:1905
 msgid "Rename..."
 msgstr "Umbenennen..."
=20
-#: git-gui.sh:1775 git-gui.sh:1873
+#: git-gui.sh:1910 git-gui.sh:2008
 msgid "Delete..."
 msgstr "L=F6schen..."
=20
-#: git-gui.sh:1780
+#: git-gui.sh:1915
 msgid "Reset..."
 msgstr "Zur=FCcksetzen..."
=20
-#: git-gui.sh:1792 git-gui.sh:2169
+#: git-gui.sh:1927 git-gui.sh:2305
 msgid "New Commit"
 msgstr "Neue Version"
=20
-#: git-gui.sh:1800 git-gui.sh:2176
+#: git-gui.sh:1935 git-gui.sh:2312
 msgid "Amend Last Commit"
 msgstr "Letzte Version nachbessern"
=20
-#: git-gui.sh:1809 git-gui.sh:2136 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:1944 git-gui.sh:2272 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "Neu laden"
=20
-#: git-gui.sh:1815
+#: git-gui.sh:1950
 msgid "Stage To Commit"
 msgstr "Zum Eintragen bereitstellen"
=20
-#: git-gui.sh:1820
+#: git-gui.sh:1955
 msgid "Stage Changed Files To Commit"
 msgstr "Ge=E4nderte Dateien zum Eintragen bereitstellen"
=20
-#: git-gui.sh:1826
+#: git-gui.sh:1961
 msgid "Unstage From Commit"
 msgstr "Aus der Bereitstellung herausnehmen"
=20
-#: git-gui.sh:1831 lib/index.tcl:376
+#: git-gui.sh:1966 lib/index.tcl:382
 msgid "Revert Changes"
 msgstr "=C4nderungen revidieren"
=20
-#: git-gui.sh:1838 git-gui.sh:2148 git-gui.sh:2246
+#: git-gui.sh:1973 git-gui.sh:2284 git-gui.sh:2382
 msgid "Sign Off"
 msgstr "Abzeichnen"
=20
-#: git-gui.sh:1853
+#: git-gui.sh:1977 git-gui.sh:2288
+msgid "Commit@@verb"
+msgstr "Eintragen"
+
+#: git-gui.sh:1988
 msgid "Local Merge..."
 msgstr "Lokales Zusammenf=FChren..."
=20
-#: git-gui.sh:1858
+#: git-gui.sh:1993
 msgid "Abort Merge..."
 msgstr "Zusammenf=FChren abbrechen..."
=20
-#: git-gui.sh:1870
+#: git-gui.sh:2005
 msgid "Push..."
 msgstr "Ausliefern..."
=20
-#: git-gui.sh:1880
+#: git-gui.sh:2015 lib/choose_repository.tcl:73
 msgid "Apple"
 msgstr "Apple"
=20
-#: git-gui.sh:1883 git-gui.sh:1901 lib/option.tcl:65
+#: git-gui.sh:2018 git-gui.sh:2036 lib/choose_repository.tcl:76
+#: lib/choose_repository.tcl:82 lib/option.tcl:65
 #, tcl-format
 msgid "About %s"
 msgstr "=DCber %s"
=20
-#: git-gui.sh:1885 git-gui.sh:1891 git-gui.sh:2414
+#: git-gui.sh:2020 git-gui.sh:2026 git-gui.sh:2550
 msgid "Options..."
 msgstr "Optionen..."
=20
-#: git-gui.sh:1897
+#: git-gui.sh:2032 lib/choose_repository.tcl:79
 msgid "Help"
 msgstr "Hilfe"
=20
-#: git-gui.sh:1938
+#: git-gui.sh:2073
 msgid "Online Documentation"
 msgstr "Online-Dokumentation"
=20
-#: git-gui.sh:2054
+#: git-gui.sh:2157
+#, tcl-format
+msgid "fatal: cannot stat path %s: No such file or directory"
+msgstr ""
+
+#: git-gui.sh:2190
 msgid "Current Branch:"
 msgstr "Aktueller Zweig:"
=20
-#: git-gui.sh:2075
+#: git-gui.sh:2211
 msgid "Staged Changes (Will Be Committed)"
 msgstr "Bereitgestellte =C4nderungen (werden eingetragen)"
=20
-#: git-gui.sh:2095
+#: git-gui.sh:2231
 msgid "Unstaged Changes (Will Not Be Committed)"
 msgstr "Nicht bereitgestellte =C4nderungen (werden nicht eingetragen)"
=20
-#: git-gui.sh:2142
+#: git-gui.sh:2278
 msgid "Stage Changed"
 msgstr "Ge=E4nderte bereitstellen"
=20
-#: git-gui.sh:2188
+#: git-gui.sh:2324
 msgid "Initial Commit Message:"
 msgstr "Beschreibung der ersten Version:"
=20
-#: git-gui.sh:2189
+#: git-gui.sh:2325
 msgid "Amended Commit Message:"
 msgstr "Beschreibung der nachgebesserten Version:"
=20
-#: git-gui.sh:2190
+#: git-gui.sh:2326
 msgid "Amended Initial Commit Message:"
 msgstr "Beschreibung der nachgebesserten ersten Version:"
=20
-#: git-gui.sh:2191
+#: git-gui.sh:2327
 msgid "Amended Merge Commit Message:"
 msgstr "Beschreibung der nachgebesserten Zusammenf=FChrungs-Version:"
=20
-#: git-gui.sh:2192
+#: git-gui.sh:2328
 msgid "Merge Commit Message:"
 msgstr "Beschreibung der Zusammenf=FChrungs-Version:"
=20
-#: git-gui.sh:2193
+#: git-gui.sh:2329
 msgid "Commit Message:"
 msgstr "Versionsbeschreibung:"
=20
-#: git-gui.sh:2238 git-gui.sh:2376 lib/console.tcl:73
+#: git-gui.sh:2374 git-gui.sh:2512 lib/console.tcl:71
 msgid "Copy All"
 msgstr "Alle kopieren"
=20
-#: git-gui.sh:2262 lib/blame.tcl:104
+#: git-gui.sh:2398 lib/blame.tcl:104
 msgid "File:"
 msgstr "Datei:"
=20
-#: git-gui.sh:2364
+#: git-gui.sh:2500
 msgid "Refresh"
 msgstr "Aktualisieren"
=20
-#: git-gui.sh:2385
+#: git-gui.sh:2521
 msgid "Apply/Reverse Hunk"
 msgstr "=C4nderung anwenden/umkehren"
=20
-#: git-gui.sh:2391
+#: git-gui.sh:2527
 msgid "Decrease Font Size"
 msgstr "Schriftgr=F6=DFe verkleinern"
=20
-#: git-gui.sh:2395
+#: git-gui.sh:2531
 msgid "Increase Font Size"
 msgstr "Schriftgr=F6=DFe vergr=F6=DFern"
=20
-#: git-gui.sh:2400
+#: git-gui.sh:2536
 msgid "Show Less Context"
 msgstr "Weniger Kontext anzeigen"
=20
-#: git-gui.sh:2407
+#: git-gui.sh:2543
 msgid "Show More Context"
 msgstr "Mehr Kontext anzeigen"
=20
-#: git-gui.sh:2422
+#: git-gui.sh:2557
 msgid "Unstage Hunk From Commit"
 msgstr "Aus der Bereitstellung herausnehmen"
=20
-#: git-gui.sh:2426 git-gui.sh:2430
+#: git-gui.sh:2559
 msgid "Stage Hunk For Commit"
 msgstr "In die Bereitstellung hinzuf=FCgen"
=20
-#: git-gui.sh:2440
+#: git-gui.sh:2578
 msgid "Initializing..."
 msgstr "Initialisieren..."
=20
+#: git-gui.sh:2669
+#, tcl-format
+msgid ""
+"Possible environment issues exist.\n"
+"\n"
+"The following environment variables are probably\n"
+"going to be ignored by any Git subprocess run\n"
+"by %s:\n"
+"\n"
+msgstr ""
+
+#: git-gui.sh:2699
+msgid ""
+"\n"
+"This is due to a known issue with the\n"
+"Tcl binary distributed by Cygwin."
+msgstr ""
+
+#: git-gui.sh:2704
+#, tcl-format
+msgid ""
+"\n"
+"\n"
+"A good replacement for %s\n"
+"is placing values for the user.name and\n"
+"user.email settings into your personal\n"
+"~/.gitconfig file.\n"
+msgstr ""
+
 #: lib/blame.tcl:77
 msgid "File Viewer"
 msgstr "Datei-Browser"
@@ -429,6 +473,50 @@ msgstr "Version kopieren"
 msgid "Reading %s..."
 msgstr "%s lesen..."
=20
+#: lib/blame.tcl:473
+msgid "Loading copy/move tracking annotations..."
+msgstr ""
+
+#: lib/blame.tcl:493
+msgid "lines annotated"
+msgstr ""
+
+#: lib/blame.tcl:674
+msgid "Loading original location annotations..."
+msgstr ""
+
+#: lib/blame.tcl:677
+msgid "Annotation complete."
+msgstr ""
+
+#: lib/blame.tcl:731
+msgid "Loading annotation..."
+msgstr "Annotierung laden..."
+
+#: lib/blame.tcl:787
+msgid "Author:"
+msgstr "Autor:"
+
+#: lib/blame.tcl:791
+msgid "Committer:"
+msgstr "Eintragender:"
+
+#: lib/blame.tcl:796
+msgid "Original File:"
+msgstr ""
+
+#: lib/blame.tcl:910
+msgid "Originally By:"
+msgstr ""
+
+#: lib/blame.tcl:916
+msgid "In File:"
+msgstr "In Datei:"
+
+#: lib/blame.tcl:921
+msgid "Copied Or Moved Here By:"
+msgstr ""
+
 #: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
 msgid "Checkout Branch"
 msgstr "Zweig umstellen"
@@ -438,18 +526,18 @@ msgid "Checkout"
 msgstr "Umstellen"
=20
 #: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
-#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
83
-#: lib/checkout_op.tcl:522 lib/merge.tcl:172 lib/option.tcl:172
-#: lib/remote_branch_delete.tcl:42 lib/transport.tcl:92
+#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
81
+#: lib/checkout_op.tcl:522 lib/choose_font.tcl:43 lib/merge.tcl:172
+#: lib/option.tcl:172 lib/remote_branch_delete.tcl:42 lib/transport.tc=
l:97
 msgid "Cancel"
 msgstr "Abbrechen"
=20
-#: lib/branch_checkout.tcl:32 lib/browser.tcl:288
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:286
 msgid "Revision"
 msgstr "Version"
=20
 #: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
159
-#: lib/option.tcl:274
+#: lib/option.tcl:280
 msgid "Options"
 msgstr "Optionen"
=20
@@ -469,7 +557,7 @@ msgstr "Zweig erstellen"
 msgid "Create New Branch"
 msgstr "Neuen Zweig erstellen"
=20
-#: lib/branch_create.tcl:31
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:236
 msgid "Create"
 msgstr "Erstellen"
=20
@@ -609,20 +697,22 @@ msgstr "Starten..."
 msgid "File Browser"
 msgstr "Datei-Browser"
=20
-#: lib/browser.tcl:127 lib/browser.tcl:144
+#: lib/browser.tcl:125 lib/browser.tcl:142
 #, tcl-format
 msgid "Loading %s..."
 msgstr "%s laden..."
=20
-#: lib/browser.tcl:188
+#: lib/browser.tcl:186
 msgid "[Up To Parent]"
 msgstr "[Nach oben]"
=20
-#: lib/browser.tcl:268 lib/browser.tcl:274
+#: lib/browser.tcl:266 lib/browser.tcl:272
 msgid "Browse Branch Files"
 msgstr "Dateien des Zweigs durchbl=E4ttern"
=20
-#: lib/browser.tcl:279
+#: lib/browser.tcl:277 lib/choose_repository.tcl:252
+#: lib/choose_repository.tcl:342 lib/choose_repository.tcl:352
+#: lib/choose_repository.tcl:848
 msgid "Browse"
 msgstr "Bl=E4ttern"
=20
@@ -631,7 +721,12 @@ msgstr "Bl=E4ttern"
 msgid "Fetching %s from %s"
 msgstr "=C4nderungen =BB%s=AB von =BB%s=AB anfordern"
=20
-#: lib/checkout_op.tcl:140 lib/console.tcl:81 lib/database.tcl:31
+#: lib/checkout_op.tcl:127
+#, tcl-format
+msgid "fatal: Cannot resolve %s"
+msgstr ""
+
+#: lib/checkout_op.tcl:140 lib/console.tcl:79 lib/database.tcl:31
 msgid "Close"
 msgstr "Schlie=DFen"
=20
@@ -683,10 +778,17 @@ msgstr ""
 "\n"
 "Es wird gleich neu geladen.\n"
=20
+#: lib/checkout_op.tcl:322
+#, tcl-format
+msgid "Updating working directory to '%s'..."
+msgstr "Arbeitskopie umstellen auf =BB%s=AB..."
+
 #: lib/checkout_op.tcl:353
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
-msgstr "Zweig umstellen von =BB%s=AB abgebrochen (Zusammenf=FChren der=
 Dateien ist notwendig)."
+msgstr ""
+"Zweig umstellen von =BB%s=AB abgebrochen (Zusammenf=FChren der Dateie=
n ist "
+"notwendig)."
=20
 #: lib/checkout_op.tcl:354
 msgid "File level merge required."
@@ -706,7 +808,13 @@ msgid ""
 msgstr ""
 "Die Arbeitskopie ist nicht auf einem lokalen Zweig.\n"
 "\n"
-"Wenn Sie auf einem Zweig arbeiten m=F6chten, erstellen Sie bitte jetz=
t einen Zweig mit der Auswahl =BBAbgetrennte Arbeitskopie-Version=AB."
+"Wenn Sie auf einem Zweig arbeiten m=F6chten, erstellen Sie bitte jetz=
t einen "
+"Zweig mit der Auswahl =BBAbgetrennte Arbeitskopie-Version=AB."
+
+#: lib/checkout_op.tcl:446
+#, tcl-format
+msgid "Checked out '%s'."
+msgstr "Umgestellt auf =BB%s=AB."
=20
 #: lib/checkout_op.tcl:478
 #, tcl-format
@@ -746,6 +854,236 @@ msgstr ""
 "\n"
 "Dies ist ein interner Programmfehler von %s. Programm wird jetzt abge=
brochen."
=20
+#: lib/choose_font.tcl:39
+msgid "Select"
+msgstr "Ausw=E4hlen"
+
+#: lib/choose_font.tcl:53
+msgid "Font Family"
+msgstr "Schriftfamilie"
+
+#: lib/choose_font.tcl:73
+msgid "Font Size"
+msgstr "Schriftgr=F6=DFe"
+
+#: lib/choose_font.tcl:90
+msgid "Font Example"
+msgstr "Schriftbeispiel"
+
+#: lib/choose_font.tcl:101
+msgid ""
+"This is example text.\n"
+"If you like this text, it can be your font."
+msgstr ""
+"Dies ist ein Beispieltext.\n"
+"Wenn Ihnen dieser Text gef=E4llt, sollten Sie diese Schriftart w=E4hl=
en."
+
+#: lib/choose_repository.tcl:57
+msgid "Git Gui"
+msgstr "Git Gui"
+
+#: lib/choose_repository.tcl:106 lib/choose_repository.tcl:241
+msgid "Create New Repository"
+msgstr "Neues Projektarchiv"
+
+#: lib/choose_repository.tcl:111 lib/choose_repository.tcl:328
+msgid "Clone Existing Repository"
+msgstr "Projektarchiv kopieren"
+
+#: lib/choose_repository.tcl:116 lib/choose_repository.tcl:837
+msgid "Open Existing Repository"
+msgstr "Projektarchiv =F6ffnen"
+
+#: lib/choose_repository.tcl:128
+msgid "Next >"
+msgstr "Weiter >"
+
+#: lib/choose_repository.tcl:189
+#, tcl-format
+msgid "Location %s already exists."
+msgstr "Projektarchiv =BB%s=AB existiert bereits."
+
+#: lib/choose_repository.tcl:195 lib/choose_repository.tcl:202
+#: lib/choose_repository.tcl:209
+#, tcl-format
+msgid "Failed to create repository %s:"
+msgstr "Projektarchiv =BB%s=AB konnte nicht erstellt werden:"
+
+#: lib/choose_repository.tcl:246 lib/choose_repository.tcl:346
+msgid "Directory:"
+msgstr "Verzeichnis:"
+
+#: lib/choose_repository.tcl:275 lib/choose_repository.tcl:400
+#: lib/choose_repository.tcl:871
+msgid "Git Repository"
+msgstr "Git Projektarchiv"
+
+#: lib/choose_repository.tcl:290 lib/choose_repository.tcl:297
+#, tcl-format
+msgid "Directory %s already exists."
+msgstr "Verzeichnis =BB%s=AB existiert bereits."
+
+#: lib/choose_repository.tcl:302
+#, tcl-format
+msgid "File %s already exists."
+msgstr "Datei =BB%s=AB existiert bereits."
+
+#: lib/choose_repository.tcl:323
+msgid "Clone"
+msgstr "Kopieren"
+
+#: lib/choose_repository.tcl:336
+msgid "URL:"
+msgstr "URL:"
+
+#: lib/choose_repository.tcl:356
+msgid "Clone Type:"
+msgstr "Art der Kopie:"
+
+#: lib/choose_repository.tcl:362
+msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
+msgstr ""
+
+#: lib/choose_repository.tcl:368
+msgid "Full Copy (Slower, Redundant Backup)"
+msgstr ""
+
+#: lib/choose_repository.tcl:374
+msgid "Shared (Fastest, Not Recommended, No Backup)"
+msgstr ""
+
+#: lib/choose_repository.tcl:406 lib/choose_repository.tcl:455
+#: lib/choose_repository.tcl:597 lib/choose_repository.tcl:667
+#: lib/choose_repository.tcl:877 lib/choose_repository.tcl:885
+#, tcl-format
+msgid "Not a Git repository: %s"
+msgstr "Kein Git-Projektarchiv in =BB%s=AB gefunden."
+
+#: lib/choose_repository.tcl:442
+msgid "Standard only available for local repository."
+msgstr ""
+
+#: lib/choose_repository.tcl:446
+msgid "Shared only available for local repository."
+msgstr ""
+
+#: lib/choose_repository.tcl:476
+msgid "Failed to configure origin"
+msgstr ""
+
+#: lib/choose_repository.tcl:488
+msgid "Counting objects"
+msgstr ""
+
+#: lib/choose_repository.tcl:489
+msgid "buckets"
+msgstr ""
+
+#: lib/choose_repository.tcl:513
+#, tcl-format
+msgid "Unable to copy objects/info/alternates: %s"
+msgstr ""
+
+#: lib/choose_repository.tcl:549
+#, tcl-format
+msgid "Nothing to clone from %s."
+msgstr "Von =BB%s=AB konnte nichts kopiert werden."
+
+#: lib/choose_repository.tcl:551 lib/choose_repository.tcl:765
+#: lib/choose_repository.tcl:777
+msgid "The 'master' branch has not been initialized."
+msgstr ""
+
+#: lib/choose_repository.tcl:564
+msgid "Hardlinks are unavailable.  Falling back to copying."
+msgstr ""
+
+#: lib/choose_repository.tcl:576
+#, tcl-format
+msgid "Cloning from %s"
+msgstr "Kopieren von =BB%s=AB"
+
+#: lib/choose_repository.tcl:607
+msgid "Copying objects"
+msgstr "Objektdatenbank kopieren"
+
+#: lib/choose_repository.tcl:608
+msgid "KiB"
+msgstr "KB"
+
+#: lib/choose_repository.tcl:632
+#, tcl-format
+msgid "Unable to copy object: %s"
+msgstr "Objekt kann nicht kopiert werden: %s"
+
+#: lib/choose_repository.tcl:642
+msgid "Linking objects"
+msgstr "Objekte verlinken"
+
+#: lib/choose_repository.tcl:643
+msgid "objects"
+msgstr "Objekte"
+
+#: lib/choose_repository.tcl:651
+#, tcl-format
+msgid "Unable to hardlink object: %s"
+msgstr "Objekt kann nicht hartverlinkt werden: %s"
+
+#: lib/choose_repository.tcl:706
+msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
+msgstr ""
+
+#: lib/choose_repository.tcl:717
+msgid "Cannot fetch tags.  See console output for details."
+msgstr ""
+
+#: lib/choose_repository.tcl:741
+msgid "Cannot determine HEAD.  See console output for details."
+msgstr ""
+
+#: lib/choose_repository.tcl:750
+#, tcl-format
+msgid "Unable to cleanup %s"
+msgstr ""
+
+#: lib/choose_repository.tcl:756
+msgid "Clone failed."
+msgstr "Kopieren fehlgeschlagen."
+
+#: lib/choose_repository.tcl:763
+msgid "No default branch obtained."
+msgstr ""
+
+#: lib/choose_repository.tcl:774
+#, tcl-format
+msgid "Cannot resolve %s as a commit."
+msgstr ""
+
+#: lib/choose_repository.tcl:786
+msgid "Creating working directory"
+msgstr "Arbeitskopie erstellen"
+
+#: lib/choose_repository.tcl:787
+msgid "files"
+msgstr "Dateien"
+
+#: lib/choose_repository.tcl:816
+msgid "Initial file checkout failed."
+msgstr ""
+
+#: lib/choose_repository.tcl:832
+msgid "Open"
+msgstr "=D6ffnen"
+
+#: lib/choose_repository.tcl:842
+msgid "Repository:"
+msgstr "Projektarchiv:"
+
+#: lib/choose_repository.tcl:891
+#, tcl-format
+msgid "Failed to open repository %s:"
+msgstr "Projektarchiv =BB%s=AB konnte nicht ge=F6ffnet werden."
+
 #: lib/choose_rev.tcl:53
 msgid "This Detached Checkout"
 msgstr "Abgetrennte Arbeitskopie-Version"
@@ -762,7 +1100,7 @@ msgstr "Lokaler Zweig"
 msgid "Tracking Branch"
 msgstr "=DCbernahmezweig"
=20
-#: lib/choose_rev.tcl:84
+#: lib/choose_rev.tcl:84 lib/choose_rev.tcl:537
 msgid "Tag"
 msgstr "Markierung"
=20
@@ -779,6 +1117,18 @@ msgstr "Keine Version ausgew=E4hlt."
 msgid "Revision expression is empty."
 msgstr "Versions-Ausdruck ist leer."
=20
+#: lib/choose_rev.tcl:530
+msgid "Updated"
+msgstr "Aktualisiert"
+
+#: lib/choose_rev.tcl:556
+msgid "Remote"
+msgstr "Gegenseite"
+
+#: lib/choose_rev.tcl:558
+msgid "URL"
+msgstr "URL"
+
 #: lib/commit.tcl:9
 msgid ""
 "There is nothing to amend.\n"
@@ -829,7 +1179,8 @@ msgid ""
 msgstr ""
 "Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv =FC=
berein.\n"
 "\n"
-"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden=
 ge=E4ndert.  Vor dem Eintragen einer neuen Version muss neu geladen we=
rden.\n"
+"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden=
 "
+"ge=E4ndert.  Vor dem Eintragen einer neuen Version muss neu geladen w=
erden.\n"
 "\n"
 "Es wird gleich neu geladen.\n"
=20
@@ -843,7 +1194,8 @@ msgid ""
 msgstr ""
 "Nicht zusammengef=FChrte Dateien k=F6nnen nicht eingetragen werden.\n=
"
 "\n"
-"Die Datei =BB%s=AB hat noch nicht aufgel=F6ste Zusammenf=FChrungs-Kon=
flikte. Sie m=FCssen diese Konflikte aufl=F6sen, bevor Sie eintragen k=F6=
nnen.\n"
+"Die Datei =BB%s=AB hat noch nicht aufgel=F6ste Zusammenf=FChrungs-Kon=
flikte. Sie "
+"m=FCssen diese Konflikte aufl=F6sen, bevor Sie eintragen k=F6nnen.\n"
=20
 #: lib/commit.tcl:162
 #, tcl-format
@@ -890,6 +1242,11 @@ msgstr ""
 msgid "write-tree failed:"
 msgstr "write-tree fehlgeschlagen:"
=20
+#: lib/commit.tcl:275
+#, tcl-format
+msgid "Commit %s appears to be corrupt"
+msgstr "Version =BB%s=AB scheint besch=E4digt zu sein"
+
 #: lib/commit.tcl:279
 msgid ""
 "No changes to commit.\n"
@@ -900,7 +1257,8 @@ msgid ""
 msgstr ""
 "Keine =C4nderungen einzutragen.\n"
 "\n"
-"Es gibt keine ge=E4nderte Datei bei dieser Version und es wurde auch =
nichts zusammengef=FChrt.\n"
+"Es gibt keine ge=E4nderte Datei bei dieser Version und es wurde auch =
nichts "
+"zusammengef=FChrt.\n"
 "\n"
 "Das Arbeitsverzeichnis wird daher jetzt neu geladen.\n"
=20
@@ -908,6 +1266,11 @@ msgstr ""
 msgid "No changes to commit."
 msgstr "Keine =C4nderungen, die eingetragen werden k=F6nnen."
=20
+#: lib/commit.tcl:303
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr ""
+
 #: lib/commit.tcl:317
 msgid "commit-tree failed:"
 msgstr "commit-tree fehlgeschlagen:"
@@ -921,15 +1284,15 @@ msgstr "update-ref fehlgeschlagen:"
 msgid "Created commit %s: %s"
 msgstr "Version %s =FCbertragen: %s"
=20
-#: lib/console.tcl:55
+#: lib/console.tcl:57
 msgid "Working... please wait..."
 msgstr "Verarbeitung. Bitte warten..."
=20
-#: lib/console.tcl:184
+#: lib/console.tcl:183
 msgid "Success"
 msgstr "Erfolgreich"
=20
-#: lib/console.tcl:194
+#: lib/console.tcl:196
 msgid "Error: Command Failed"
 msgstr "Fehler: Kommando fehlgeschlagen"
=20
@@ -969,6 +1332,27 @@ msgstr "Objektdatenbank komprimieren"
 msgid "Verifying the object database with fsck-objects"
 msgstr "Die Objektdatenbank durch =BBfsck-objects=AB =FCberpr=FCfen la=
ssen"
=20
+#: lib/database.tcl:108
+#, tcl-format
+msgid ""
+"This repository currently has approximately %i loose objects.\n"
+"\n"
+"To maintain optimal performance it is strongly recommended that you c=
ompress "
+"the database when more than %i loose objects exist.\n"
+"\n"
+"Compress the database now?"
+msgstr ""
+"Dieses Projektarchiv enth=E4lt ungef=E4hr %i nicht verkn=FCpfte Objek=
te.\n"
+"\n"
+"F=FCr eine optimale Performance wird empfohlen, die Datenbank des Pro=
jektarchivs zu komprimieren, sobald mehr als %i nicht verkn=FCpfte Obje=
kte vorliegen.\n"
+"\n"
+"Soll die Datenbank jetzt komprimiert werden?"
+
+#: lib/date.tcl:25
+#, tcl-format
+msgid "Invalid date from Git: %s"
+msgstr "Ung=FCltiges Datum von Git: %s"
+
 #: lib/diff.tcl:42
 #, tcl-format
 msgid ""
@@ -991,19 +1375,37 @@ msgstr ""
 "Das Arbeitsverzeichnis wird jetzt neu geladen, um diese =C4nderung be=
i allen "
 "Dateien zu pr=FCfen."
=20
-#: lib/diff.tcl:97
+#: lib/diff.tcl:81
+#, tcl-format
+msgid "Loading diff of %s..."
+msgstr "Vergleich von =BB%s=AB laden..."
+
+#: lib/diff.tcl:114 lib/diff.tcl:184
+#, tcl-format
+msgid "Unable to display %s"
+msgstr "Datei =BB%s=AB kann nicht angezeigt werden"
+
+#: lib/diff.tcl:115
 msgid "Error loading file:"
 msgstr "Fehler beim Laden der Datei:"
=20
-#: lib/diff.tcl:162
+#: lib/diff.tcl:122
+msgid "Git Repository (subproject)"
+msgstr "Git-Projektarchiv (Unterprojekt)"
+
+#: lib/diff.tcl:134
+msgid "* Binary file (not showing content)."
+msgstr "* Bin=E4rdatei (Inhalt wird nicht angezeigt)"
+
+#: lib/diff.tcl:185
 msgid "Error loading diff:"
 msgstr "Fehler beim Laden des Vergleichs:"
=20
-#: lib/diff.tcl:278
+#: lib/diff.tcl:302
 msgid "Failed to unstage selected hunk."
 msgstr "Fehler beim Herausnehmen der gew=E4hlten Dateien aus der Berei=
tstellung."
=20
-#: lib/diff.tcl:285
+#: lib/diff.tcl:309
 msgid "Failed to stage selected hunk."
 msgstr "Fehler beim Bereitstellen der gew=E4hlten Dateien."
=20
@@ -1017,24 +1419,35 @@ msgstr "Warnung"
=20
 #: lib/error.tcl:81
 msgid "You must correct the above errors before committing."
-msgstr "Sie m=FCssen die obigen Fehler zuerst beheben, bevor Sie eintr=
agen k=F6nnen."
+msgstr ""
+"Sie m=FCssen die obigen Fehler zuerst beheben, bevor Sie eintragen k=F6=
nnen."
=20
-#: lib/index.tcl:364
+#: lib/index.tcl:271
+#, tcl-format
+msgid "Unstaging %s from commit"
+msgstr "Datei =BB%s=AB aus der Bereitstellung herausnehmen"
+
+#: lib/index.tcl:315
+#, tcl-format
+msgid "Adding %s"
+msgstr "=BB%s=AB hinzuf=FCgen..."
+
+#: lib/index.tcl:370
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "=C4nderungen in Datei =BB%s=AB revidieren?"
=20
-#: lib/index.tcl:366
+#: lib/index.tcl:372
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "=C4nderungen in den gew=E4hlten %i Dateien revidieren?"
=20
-#: lib/index.tcl:372
+#: lib/index.tcl:378
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
 "Alle nicht bereitgestellten =C4nderungen werden beim Revidieren verlo=
ren gehen."
=20
-#: lib/index.tcl:375
+#: lib/index.tcl:381
 msgid "Do Nothing"
 msgstr "Nichts tun"
=20
@@ -1046,7 +1459,8 @@ msgid ""
 msgstr ""
 "Zusammenf=FChren kann nicht gleichzeitig mit Nachbessern durchgef=FCh=
rt werden.\n"
 "\n"
-"Sie m=FCssen zuerst die Nachbesserungs-Version abschlie=DFen, bevor S=
ie zusammenf=FChren k=F6nnen.\n"
+"Sie m=FCssen zuerst die Nachbesserungs-Version abschlie=DFen, bevor S=
ie "
+"zusammenf=FChren k=F6nnen.\n"
=20
 #: lib/merge.tcl:27
 msgid ""
@@ -1076,7 +1490,10 @@ msgid ""
 msgstr ""
 "Zusammenf=FChrung mit Konflikten.\n"
 "\n"
-"Die Datei =BB%s=AB enth=E4lt Konflikte beim Zusammenf=FChren. Sie m=FC=
ssen diese Konflikte per Hand aufl=F6sen. Anschlie=DFend m=FCssen Sie d=
ie Datei wieder bereitstellen und eintragen, um die Zusammenf=FChrung a=
bzuschlie=DFen. Erst danach kann eine neue Zusammenf=FChrung begonnen w=
erden.\n"
+"Die Datei =BB%s=AB enth=E4lt Konflikte beim Zusammenf=FChren. Sie m=FC=
ssen diese "
+"Konflikte per Hand aufl=F6sen. Anschlie=DFend m=FCssen Sie die Datei =
wieder "
+"bereitstellen und eintragen, um die Zusammenf=FChrung abzuschlie=DFen=
=2E Erst "
+"danach kann eine neue Zusammenf=FChrung begonnen werden.\n"
=20
 #: lib/merge.tcl:54
 #, tcl-format
@@ -1090,7 +1507,10 @@ msgid ""
 msgstr ""
 "Es liegen =C4nderungen vor.\n"
 "\n"
-"Die Datei =BB%s=AB wurde ge=E4ndert.  Sie sollten zuerst die bereitge=
stellte Version abschlie=DFen, bevor Sie eine Zusammenf=FChrung beginne=
n.  Mit dieser Reihenfolge k=F6nnen Sie m=F6gliche Konflikte beim Zusam=
menf=FChren wesentlich einfacher beheben oder abbrechen.\n"
+"Die Datei =BB%s=AB wurde ge=E4ndert.  Sie sollten zuerst die bereitge=
stellte "
+"Version abschlie=DFen, bevor Sie eine Zusammenf=FChrung beginnen.  Mi=
t dieser "
+"Reihenfolge k=F6nnen Sie m=F6gliche Konflikte beim Zusammenf=FChren w=
esentlich "
+"einfacher beheben oder abbrechen.\n"
=20
 #: lib/merge.tcl:106
 #, tcl-format
@@ -1139,7 +1559,8 @@ msgid ""
 msgstr ""
 "Zusammenf=FChren abbrechen?\n"
 "\n"
-"Wenn Sie abbrechen, gehen alle noch nicht eingetragenen =C4nderungen =
verloren.\n"
+"Wenn Sie abbrechen, gehen alle noch nicht eingetragenen =C4nderungen =
"
+"verloren.\n"
 "\n"
 "Zusammenf=FChren jetzt abbrechen?"
=20
@@ -1153,7 +1574,8 @@ msgid ""
 msgstr ""
 "=C4nderungen zur=FCcksetzen?\n"
 "\n"
-"Wenn Sie zur=FCcksetzen, gehen alle noch nicht eingetragenen =C4nderu=
ngen verloren.\n"
+"Wenn Sie zur=FCcksetzen, gehen alle noch nicht eingetragenen =C4nderu=
ngen "
+"verloren.\n"
 "\n"
 "=C4nderungen jetzt zur=FCcksetzen?"
=20
@@ -1230,7 +1652,20 @@ msgstr "Anzahl der Kontextzeilen beim Vergleich"
 msgid "New Branch Name Template"
 msgstr "Namensvorschlag f=FCr neue Zweige"
=20
-#: lib/option.tcl:305
+#: lib/option.tcl:258
+msgid "Change Font"
+msgstr "Schriftart =E4ndern"
+
+#: lib/option.tcl:262
+#, tcl-format
+msgid "Choose %s"
+msgstr "%s w=E4hlen"
+
+#: lib/option.tcl:268
+msgid "pt."
+msgstr "pt."
+
+#: lib/option.tcl:311
 msgid "Failed to completely save options:"
 msgstr "Optionen konnten nicht gespeichert werden:"
=20
@@ -1242,11 +1677,11 @@ msgstr "Zweig im Projektarchiv der Gegenseite l=
=F6schen"
 msgid "From Repository"
 msgstr "Von Projektarchiv"
=20
-#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:118
+#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:123
 msgid "Remote:"
 msgstr "Gegenseite:"
=20
-#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:133
+#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:138
 msgid "Arbitrary URL:"
 msgstr "Kommunikation mit URL:"
=20
@@ -1270,12 +1705,26 @@ msgstr "Immer (Keine Zusammenf=FChrungspr=FCfun=
g)"
 msgid "A branch is required for 'Merged Into'."
 msgstr "F=FCr =BBZusammenf=FChren mit=AB muss ein Zweig angegeben werd=
en."
=20
+#: lib/remote_branch_delete.tcl:184
+#, tcl-format
+msgid ""
+"The following branches are not completely merged into %s:\n"
+"\n"
+" - %s"
+msgstr ""
+"Folgende Zweige sind noch nicht mit =BB%s=AB zusammengef=FChrt:\n"
+"\n"
+" - %s"
+
 #: lib/remote_branch_delete.tcl:189
 #, tcl-format
 msgid ""
 "One or more of the merge tests failed because you have not fetched th=
e "
 "necessary commits.  Try fetching from %s first."
-msgstr "Ein oder mehrere Zusammenf=FChrungen sind fehlgeschlagen, da S=
ie nicht die notwendigen Versionen vorher angefordert haben.  Sie sollt=
en versuchen, zuerst von =BB%s=AB anzufordern."
+msgstr ""
+"Ein oder mehrere Zusammenf=FChrungen sind fehlgeschlagen, da Sie nich=
t die "
+"notwendigen Versionen vorher angefordert haben.  Sie sollten versuche=
n, "
+"zuerst von =BB%s=AB anzufordern."
=20
 #: lib/remote_branch_delete.tcl:207
 msgid "Please select one or more branches to delete."
@@ -1304,22 +1753,22 @@ msgstr "Kein Projektarchiv ausgew=E4hlt."
 #: lib/remote_branch_delete.tcl:291
 #, tcl-format
 msgid "Scanning %s..."
-msgstr "%s laden..."
+msgstr "=BB%s=AB laden..."
=20
 #: lib/remote.tcl:162
 #, tcl-format
-msgid "Fetch from %s..."
-msgstr "Von =BB%s=AB anfordern..."
+msgid "Fetch from %s"
+msgstr "Von =BB%s=AB anfordern"
=20
 #: lib/remote.tcl:172
 #, tcl-format
-msgid "Prune from %s..."
-msgstr "L=F6schen von =BB%s=AB..."
+msgid "Prune from %s"
+msgstr "L=F6schen von =BB%s=AB"
=20
 #: lib/remote.tcl:206
 #, tcl-format
-msgid "Push to %s..."
-msgstr "Nach %s ausliefern..."
+msgid "Push to %s"
+msgstr "Nach =BB%s=AB ausliefern"
=20
 #: lib/shortcut.tcl:26 lib/shortcut.tcl:74
 msgid "Cannot write script:"
@@ -1329,51 +1778,70 @@ msgstr "Fehler beim Schreiben des Scripts:"
 msgid "Cannot write icon:"
 msgstr "Fehler beim Erstellen des Icons:"
=20
-#: lib/status_bar.tcl:58
+#: lib/status_bar.tcl:83
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr "%s ... %*i von %*i %s (%3i%%)"
=20
+#: lib/transport.tcl:6
+#, tcl-format
+msgid "fetch %s"
+msgstr "=BB%s=AB anfordern"
+
 #: lib/transport.tcl:7
 #, tcl-format
 msgid "Fetching new changes from %s"
 msgstr "Neue =C4nderungen von =BB%s=AB holen"
=20
+#: lib/transport.tcl:18
+#, tcl-format
+msgid "remote prune %s"
+msgstr ""
+
 #: lib/transport.tcl:19
 #, tcl-format
 msgid "Pruning tracking branches deleted from %s"
 msgstr "=DCbernahmezweige l=F6schen, die in =BB%s=AB gel=F6scht wurden=
"
=20
+#: lib/transport.tcl:25 lib/transport.tcl:71
+#, tcl-format
+msgid "push %s"
+msgstr "=BB%s=AB ausliefern..."
+
 #: lib/transport.tcl:26
 #, tcl-format
 msgid "Pushing changes to %s"
-msgstr "=C4nderungen nach %s ausliefern"
+msgstr "=C4nderungen nach =BB%s=AB ausliefern"
=20
-#: lib/transport.tcl:68
+#: lib/transport.tcl:72
 #, tcl-format
 msgid "Pushing %s %s to %s"
 msgstr "%s %s nach %s ausliefern"
=20
-#: lib/transport.tcl:84
+#: lib/transport.tcl:89
 msgid "Push Branches"
 msgstr "Zweige ausliefern"
=20
-#: lib/transport.tcl:98
+#: lib/transport.tcl:103
 msgid "Source Branches"
 msgstr "Herkunftszweige"
=20
-#: lib/transport.tcl:115
+#: lib/transport.tcl:120
 msgid "Destination Repository"
 msgstr "Ziel-Projektarchiv"
=20
-#: lib/transport.tcl:153
+#: lib/transport.tcl:158
 msgid "Transfer Options"
 msgstr "Netzwerk-Einstellungen"
=20
-#: lib/transport.tcl:155
+#: lib/transport.tcl:160
+msgid "Force overwrite existing branch (may discard changes)"
+msgstr "=DCberschreiben von existierenden Zweigen erzwingen (k=F6nnte =
=C4nderungen l=F6schen)"
+
+#: lib/transport.tcl:164
 msgid "Use thin pack (for slow network connections)"
 msgstr "Kompaktes Datenformat benutzen (f=FCr langsame Netzverbindunge=
n)"
=20
-#: lib/transport.tcl:159
+#: lib/transport.tcl:168
 msgid "Include tags"
 msgstr "Mit Markierungen =FCbertragen"
--=20
1.5.3.rc2.6.g40240

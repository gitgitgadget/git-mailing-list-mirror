From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 2/2] git-gui: Update German translation
Date: Sat, 20 Oct 2007 15:31:43 +0200
Message-ID: <200710201531.43573.stimming@tuhh.de>
References: <200710052239.02492.stimming@tuhh.de> <20071010060328.GO2137@spearce.org> <200710201530.53483.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 15:34:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjESm-0000Vw-JG
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 15:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbXJTNdt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Oct 2007 09:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752923AbXJTNdt
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 09:33:49 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:54178 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbXJTNdq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Oct 2007 09:33:46 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l9KDXdgw001302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 20 Oct 2007 15:33:39 +0200
Received: from [192.168.2.102] (p549007A6.dip0.t-ipconnect.de [84.144.7.166])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l9KDXbm3004456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 20 Oct 2007 15:33:39 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <200710201530.53483.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61831>

---
Updated German glossary and German translation. Based on git-gui.git's =
master.

 po/de.po          |  444 +++++++++++++++++++++++++++------------------=
--------
 po/glossary/de.po |   14 +-
 2 files changed, 238 insertions(+), 220 deletions(-)

diff --git a/po/de.po b/po/de.po
index 4ba2fbe..3df30ed 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7,41 +7,41 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2007-10-10 04:04-0400\n"
-"PO-Revision-Date: 2007-10-05 22:27+0200\n"
+"POT-Creation-Date: 2007-10-19 21:10+0200\n"
+"PO-Revision-Date: 2007-10-20 15:28+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: git-gui.sh:41 git-gui.sh:634 git-gui.sh:648 git-gui.sh:661 git-gui.=
sh:744
-#: git-gui.sh:763
+#: git-gui.sh:41 git-gui.sh:590 git-gui.sh:604 git-gui.sh:617 git-gui.=
sh:700
+#: git-gui.sh:719
 msgid "git-gui: fatal error"
 msgstr "git-gui: Programmfehler"
=20
-#: git-gui.sh:595
+#: git-gui.sh:551
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "Ung=C3=BCltige Zeichensatz-Angabe in %s:"
=20
-#: git-gui.sh:620
+#: git-gui.sh:576
 msgid "Main Font"
 msgstr "Programmschriftart"
=20
-#: git-gui.sh:621
+#: git-gui.sh:577
 msgid "Diff/Console Font"
 msgstr "Vergleich-Schriftart"
=20
-#: git-gui.sh:635
+#: git-gui.sh:591
 msgid "Cannot find git in PATH."
 msgstr "Git kann im PATH nicht gefunden werden."
=20
-#: git-gui.sh:662
+#: git-gui.sh:618
 msgid "Cannot parse Git version string:"
 msgstr "Git Versionsangabe kann nicht erkannt werden:"
=20
-#: git-gui.sh:680
+#: git-gui.sh:636
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -60,81 +60,81 @@ msgstr ""
 "\n"
 "Soll angenommen werden, =C2=BB%s=C2=AB sei Version 1.5.0?\n"
=20
-#: git-gui.sh:853
+#: git-gui.sh:874
 msgid "Git directory not found:"
 msgstr "Git-Verzeichnis nicht gefunden:"
=20
-#: git-gui.sh:860
+#: git-gui.sh:881
 msgid "Cannot move to top of working directory:"
 msgstr ""
 "Es konnte nicht in das oberste Verzeichnis der Arbeitskopie gewechsel=
t "
 "werden:"
=20
-#: git-gui.sh:867
+#: git-gui.sh:888
 msgid "Cannot use funny .git directory:"
 msgstr "Unerwartete Struktur des .git Verzeichnis:"
=20
-#: git-gui.sh:872
+#: git-gui.sh:893
 msgid "No working directory"
 msgstr "Kein Arbeitsverzeichnis"
=20
-#: git-gui.sh:1019
+#: git-gui.sh:1040
 msgid "Refreshing file status..."
 msgstr "Dateistatus aktualisieren..."
=20
-#: git-gui.sh:1084
+#: git-gui.sh:1105
 msgid "Scanning for modified files ..."
 msgstr "Nach ge=C3=A4nderten Dateien suchen..."
=20
-#: git-gui.sh:1259 lib/browser.tcl:245
+#: git-gui.sh:1280 lib/browser.tcl:245
 msgid "Ready."
 msgstr "Bereit."
=20
-#: git-gui.sh:1525
+#: git-gui.sh:1546
 msgid "Unmodified"
 msgstr "Unver=C3=A4ndert"
=20
-#: git-gui.sh:1527
+#: git-gui.sh:1548
 msgid "Modified, not staged"
 msgstr "Ver=C3=A4ndert, nicht bereitgestellt"
=20
-#: git-gui.sh:1528 git-gui.sh:1533
+#: git-gui.sh:1549 git-gui.sh:1554
 msgid "Staged for commit"
 msgstr "Bereitgestellt zum Eintragen"
=20
-#: git-gui.sh:1529 git-gui.sh:1534
+#: git-gui.sh:1550 git-gui.sh:1555
 msgid "Portions staged for commit"
 msgstr "Teilweise bereitgestellt zum Eintragen"
=20
-#: git-gui.sh:1530 git-gui.sh:1535
+#: git-gui.sh:1551 git-gui.sh:1556
 msgid "Staged for commit, missing"
 msgstr "Bereitgestellt zum Eintragen, fehlend"
=20
-#: git-gui.sh:1532
+#: git-gui.sh:1553
 msgid "Untracked, not staged"
 msgstr "Nicht unter Versionskontrolle, nicht bereitgestellt"
=20
-#: git-gui.sh:1537
+#: git-gui.sh:1558
 msgid "Missing"
 msgstr "Fehlend"
=20
-#: git-gui.sh:1538
+#: git-gui.sh:1559
 msgid "Staged for removal"
 msgstr "Bereitgestellt zum L=C3=B6schen"
=20
-#: git-gui.sh:1539
+#: git-gui.sh:1560
 msgid "Staged for removal, still present"
 msgstr "Bereitgestellt zum L=C3=B6schen, trotzdem vorhanden"
=20
-#: git-gui.sh:1541 git-gui.sh:1542 git-gui.sh:1543 git-gui.sh:1544
+#: git-gui.sh:1562 git-gui.sh:1563 git-gui.sh:1564 git-gui.sh:1565
 msgid "Requires merge resolution"
 msgstr "Konfliktaufl=C3=B6sung n=C3=B6tig"
=20
-#: git-gui.sh:1579
+#: git-gui.sh:1600
 msgid "Starting gitk... please wait..."
 msgstr "Gitk wird gestartet... bitte warten."
=20
-#: git-gui.sh:1588
+#: git-gui.sh:1609
 #, tcl-format
 msgid ""
 "Unable to start gitk:\n"
@@ -145,297 +145,295 @@ msgstr ""
 "\n"
 "%s existiert nicht"
=20
-#: git-gui.sh:1788 lib/choose_repository.tcl:32
+#: git-gui.sh:1809 lib/choose_repository.tcl:35
 msgid "Repository"
 msgstr "Projektarchiv"
=20
-#: git-gui.sh:1789
+#: git-gui.sh:1810
 msgid "Edit"
 msgstr "Bearbeiten"
=20
-#: git-gui.sh:1791 lib/choose_rev.tcl:560
+#: git-gui.sh:1812 lib/choose_rev.tcl:560
 msgid "Branch"
 msgstr "Zweig"
=20
-#: git-gui.sh:1794 lib/choose_rev.tcl:547
+#: git-gui.sh:1815 lib/choose_rev.tcl:547
 msgid "Commit@@noun"
 msgstr "Version"
=20
-#: git-gui.sh:1797 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
+#: git-gui.sh:1818 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
 msgstr "Zusammenf=C3=BChren"
=20
-#: git-gui.sh:1798 lib/choose_rev.tcl:556
+#: git-gui.sh:1819 lib/choose_rev.tcl:556
 msgid "Remote"
-msgstr "Gegenseite"
+msgstr "Andere Archive"
=20
-#: git-gui.sh:1807
+#: git-gui.sh:1828
 msgid "Browse Current Branch's Files"
 msgstr "Aktuellen Zweig durchbl=C3=A4ttern"
=20
-#: git-gui.sh:1811
+#: git-gui.sh:1832
 msgid "Browse Branch Files..."
 msgstr "Einen Zweig durchbl=C3=A4ttern..."
=20
-#: git-gui.sh:1816
+#: git-gui.sh:1837
 msgid "Visualize Current Branch's History"
 msgstr "Aktuellen Zweig darstellen"
=20
-#: git-gui.sh:1820
+#: git-gui.sh:1841
 msgid "Visualize All Branch History"
 msgstr "Alle Zweige darstellen"
=20
-#: git-gui.sh:1827
+#: git-gui.sh:1848
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "Zweig =C2=BB%s=C2=AB durchbl=C3=A4ttern"
=20
-#: git-gui.sh:1829
+#: git-gui.sh:1850
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "Historie von =C2=BB%s=C2=AB darstellen"
=20
-#: git-gui.sh:1834 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:1855 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "Datenbankstatistik"
=20
-#: git-gui.sh:1837 lib/database.tcl:34
+#: git-gui.sh:1858 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "Datenbank komprimieren"
=20
-#: git-gui.sh:1840
+#: git-gui.sh:1861
 msgid "Verify Database"
 msgstr "Datenbank =C3=BCberpr=C3=BCfen"
=20
-#: git-gui.sh:1847 git-gui.sh:1851 git-gui.sh:1855 lib/shortcut.tcl:9
-#: lib/shortcut.tcl:45 lib/shortcut.tcl:84
+#: git-gui.sh:1868 git-gui.sh:1872 git-gui.sh:1876 lib/shortcut.tcl:7
+#: lib/shortcut.tcl:39 lib/shortcut.tcl:71
 msgid "Create Desktop Icon"
 msgstr "Desktop-Icon erstellen"
=20
-#: git-gui.sh:1860 lib/choose_repository.tcl:36 lib/choose_repository.=
tcl:95
+#: git-gui.sh:1881 lib/choose_repository.tcl:176 lib/choose_repository=
=2Etcl:184
 msgid "Quit"
 msgstr "Beenden"
=20
-#: git-gui.sh:1867
+#: git-gui.sh:1888
 msgid "Undo"
 msgstr "R=C3=BCckg=C3=A4ngig"
=20
-#: git-gui.sh:1870
+#: git-gui.sh:1891
 msgid "Redo"
 msgstr "Wiederholen"
=20
-#: git-gui.sh:1874 git-gui.sh:2366
+#: git-gui.sh:1895 git-gui.sh:2388
 msgid "Cut"
 msgstr "Ausschneiden"
=20
-#: git-gui.sh:1877 git-gui.sh:2369 git-gui.sh:2440 git-gui.sh:2512
+#: git-gui.sh:1898 git-gui.sh:2391 git-gui.sh:2462 git-gui.sh:2534
 #: lib/console.tcl:67
 msgid "Copy"
 msgstr "Kopieren"
=20
-#: git-gui.sh:1880 git-gui.sh:2372
+#: git-gui.sh:1901 git-gui.sh:2394
 msgid "Paste"
 msgstr "Einf=C3=BCgen"
=20
-#: git-gui.sh:1883 git-gui.sh:2375 lib/branch_delete.tcl:26
+#: git-gui.sh:1904 git-gui.sh:2397 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "L=C3=B6schen"
=20
-#: git-gui.sh:1887 git-gui.sh:2379 git-gui.sh:2516 lib/console.tcl:69
+#: git-gui.sh:1908 git-gui.sh:2401 git-gui.sh:2538 lib/console.tcl:69
 msgid "Select All"
 msgstr "Alle ausw=C3=A4hlen"
=20
-#: git-gui.sh:1896
+#: git-gui.sh:1917
 msgid "Create..."
 msgstr "Erstellen..."
=20
-#: git-gui.sh:1902
+#: git-gui.sh:1923
 msgid "Checkout..."
 msgstr "Umstellen..."
=20
-#: git-gui.sh:1908
+#: git-gui.sh:1929
 msgid "Rename..."
 msgstr "Umbenennen..."
=20
-#: git-gui.sh:1913 git-gui.sh:2012
+#: git-gui.sh:1934 git-gui.sh:2033
 msgid "Delete..."
 msgstr "L=C3=B6schen..."
=20
-#: git-gui.sh:1918
+#: git-gui.sh:1939
 msgid "Reset..."
 msgstr "Zur=C3=BCcksetzen..."
=20
-#: git-gui.sh:1930 git-gui.sh:2313
+#: git-gui.sh:1951 git-gui.sh:2335
 msgid "New Commit"
 msgstr "Neue Version"
=20
-#: git-gui.sh:1938 git-gui.sh:2320
+#: git-gui.sh:1959 git-gui.sh:2342
 msgid "Amend Last Commit"
 msgstr "Letzte Version nachbessern"
=20
-#: git-gui.sh:1947 git-gui.sh:2280 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:1968 git-gui.sh:2302 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "Neu laden"
=20
-#: git-gui.sh:1953
+#: git-gui.sh:1974
 msgid "Stage To Commit"
 msgstr "Zum Eintragen bereitstellen"
=20
-#: git-gui.sh:1958
+#: git-gui.sh:1979
 msgid "Stage Changed Files To Commit"
 msgstr "Ge=C3=A4nderte Dateien zum Eintragen bereitstellen"
=20
-#: git-gui.sh:1964
+#: git-gui.sh:1985
 msgid "Unstage From Commit"
 msgstr "Aus der Bereitstellung herausnehmen"
=20
-#: git-gui.sh:1969 lib/index.tcl:352
+#: git-gui.sh:1990 lib/index.tcl:352
 msgid "Revert Changes"
 msgstr "=C3=84nderungen revidieren"
=20
-#: git-gui.sh:1976 git-gui.sh:2292 git-gui.sh:2390
+#: git-gui.sh:1997 git-gui.sh:2314 git-gui.sh:2412
 msgid "Sign Off"
 msgstr "Abzeichnen"
=20
-#: git-gui.sh:1980 git-gui.sh:2296
+#: git-gui.sh:2001 git-gui.sh:2318
 msgid "Commit@@verb"
 msgstr "Eintragen"
=20
-#: git-gui.sh:1991
+#: git-gui.sh:2012
 msgid "Local Merge..."
 msgstr "Lokales Zusammenf=C3=BChren..."
=20
-#: git-gui.sh:1996
+#: git-gui.sh:2017
 msgid "Abort Merge..."
 msgstr "Zusammenf=C3=BChren abbrechen..."
=20
-#: git-gui.sh:2008
+#: git-gui.sh:2029
 msgid "Push..."
-msgstr "Ausliefern..."
+msgstr "Versenden..."
=20
-#: git-gui.sh:2019 lib/choose_repository.tcl:41
+#: git-gui.sh:2040 lib/choose_repository.tcl:40
 msgid "Apple"
 msgstr "Apple"
=20
-#: git-gui.sh:2022 git-gui.sh:2044 lib/about.tcl:13
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
+#: git-gui.sh:2043 git-gui.sh:2065 lib/about.tcl:13
+#: lib/choose_repository.tcl:43 lib/choose_repository.tcl:49
 #, tcl-format
 msgid "About %s"
 msgstr "=C3=9Cber %s"
=20
-#: git-gui.sh:2026
+#: git-gui.sh:2047
 msgid "Preferences..."
-msgstr ""
+msgstr "Einstellungen..."
=20
-#: git-gui.sh:2034 git-gui.sh:2558
+#: git-gui.sh:2055 git-gui.sh:2580
 msgid "Options..."
 msgstr "Optionen..."
=20
-#: git-gui.sh:2040 lib/choose_repository.tcl:47
+#: git-gui.sh:2061 lib/choose_repository.tcl:46
 msgid "Help"
 msgstr "Hilfe"
=20
-#: git-gui.sh:2081
+#: git-gui.sh:2102
 msgid "Online Documentation"
 msgstr "Online-Dokumentation"
=20
-#: git-gui.sh:2165
+#: git-gui.sh:2186
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
=20
-#: git-gui.sh:2198
+#: git-gui.sh:2219
 msgid "Current Branch:"
 msgstr "Aktueller Zweig:"
=20
-#: git-gui.sh:2219
-#, fuzzy
+#: git-gui.sh:2240
 msgid "Staged Changes (Will Commit)"
-msgstr "Bereitgestellte =C3=84nderungen (werden eingetragen)"
+msgstr "Bereitgestellte =C3=84nderungen (zum Eintragen)"
=20
-#: git-gui.sh:2239
-#, fuzzy
+#: git-gui.sh:2259
 msgid "Unstaged Changes"
-msgstr "Ge=C3=A4nderte bereitstellen"
+msgstr "Nicht bereitgestellte =C3=84nderungen"
=20
-#: git-gui.sh:2286
+#: git-gui.sh:2308
 msgid "Stage Changed"
-msgstr "Ge=C3=A4nderte bereitstellen"
+msgstr "Alles bereitstellen"
=20
-#: git-gui.sh:2302 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:2324 lib/transport.tcl:93 lib/transport.tcl:182
 msgid "Push"
-msgstr "Ausliefern"
+msgstr "Versenden"
=20
-#: git-gui.sh:2332
+#: git-gui.sh:2354
 msgid "Initial Commit Message:"
-msgstr "Beschreibung der ersten Version:"
+msgstr "Erste Versionsbeschreibung:"
=20
-#: git-gui.sh:2333
+#: git-gui.sh:2355
 msgid "Amended Commit Message:"
-msgstr "Beschreibung der nachgebesserten Version:"
+msgstr "Nachgebesserte Versionsbeschreibung:"
=20
-#: git-gui.sh:2334
+#: git-gui.sh:2356
 msgid "Amended Initial Commit Message:"
-msgstr "Beschreibung der nachgebesserten ersten Version:"
+msgstr "Nachgebesserte erste Versionsbeschreibung:"
=20
-#: git-gui.sh:2335
+#: git-gui.sh:2357
 msgid "Amended Merge Commit Message:"
-msgstr "Beschreibung der nachgebesserten Zusammenf=C3=BChrungs-Version=
:"
+msgstr "Nachgebesserte Zusammenf=C3=BChrungs-Versionsbeschreibung:"
=20
-#: git-gui.sh:2336
+#: git-gui.sh:2358
 msgid "Merge Commit Message:"
-msgstr "Beschreibung der Zusammenf=C3=BChrungs-Version:"
+msgstr "Zusammenf=C3=BChrungs-Versionsbeschreibung:"
=20
-#: git-gui.sh:2337
+#: git-gui.sh:2359
 msgid "Commit Message:"
 msgstr "Versionsbeschreibung:"
=20
-#: git-gui.sh:2382 git-gui.sh:2520 lib/console.tcl:71
+#: git-gui.sh:2404 git-gui.sh:2542 lib/console.tcl:71
 msgid "Copy All"
 msgstr "Alle kopieren"
=20
-#: git-gui.sh:2406 lib/blame.tcl:104
+#: git-gui.sh:2428 lib/blame.tcl:104
 msgid "File:"
 msgstr "Datei:"
=20
-#: git-gui.sh:2508
+#: git-gui.sh:2530
 msgid "Refresh"
 msgstr "Aktualisieren"
=20
-#: git-gui.sh:2529
+#: git-gui.sh:2551
 msgid "Apply/Reverse Hunk"
 msgstr "=C3=84nderung anwenden/umkehren"
=20
-#: git-gui.sh:2535
+#: git-gui.sh:2557
 msgid "Decrease Font Size"
 msgstr "Schriftgr=C3=B6=C3=9Fe verkleinern"
=20
-#: git-gui.sh:2539
+#: git-gui.sh:2561
 msgid "Increase Font Size"
 msgstr "Schriftgr=C3=B6=C3=9Fe vergr=C3=B6=C3=9Fern"
=20
-#: git-gui.sh:2544
+#: git-gui.sh:2566
 msgid "Show Less Context"
 msgstr "Weniger Kontext anzeigen"
=20
-#: git-gui.sh:2551
+#: git-gui.sh:2573
 msgid "Show More Context"
 msgstr "Mehr Kontext anzeigen"
=20
-#: git-gui.sh:2565
+#: git-gui.sh:2587
 msgid "Unstage Hunk From Commit"
 msgstr "Aus der Bereitstellung herausnehmen"
=20
-#: git-gui.sh:2567
+#: git-gui.sh:2589
 msgid "Stage Hunk For Commit"
 msgstr "In die Bereitstellung hinzuf=C3=BCgen"
=20
-#: git-gui.sh:2586
+#: git-gui.sh:2608
 msgid "Initializing..."
 msgstr "Initialisieren..."
=20
-#: git-gui.sh:2677
+#: git-gui.sh:2699
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -446,14 +444,14 @@ msgid ""
 "\n"
 msgstr ""
=20
-#: git-gui.sh:2707
+#: git-gui.sh:2729
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
 "Tcl binary distributed by Cygwin."
 msgstr ""
=20
-#: git-gui.sh:2712
+#: git-gui.sh:2734
 #, tcl-format
 msgid ""
 "\n"
@@ -515,11 +513,11 @@ msgstr "Eintragender:"
=20
 #: lib/blame.tcl:796
 msgid "Original File:"
-msgstr ""
+msgstr "Urspr=C3=BCngliche Datei:"
=20
 #: lib/blame.tcl:910
 msgid "Originally By:"
-msgstr ""
+msgstr "Urspr=C3=BCnglich von:"
=20
 #: lib/blame.tcl:916
 msgid "In File:"
@@ -527,7 +525,7 @@ msgstr "In Datei:"
=20
 #: lib/blame.tcl:921
 msgid "Copied Or Moved Here By:"
-msgstr ""
+msgstr "Kopiert oder verschoben durch:"
=20
 #: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
 msgid "Checkout Branch"
@@ -568,7 +566,7 @@ msgstr "Zweig erstellen"
 msgid "Create New Branch"
 msgstr "Neuen Zweig erstellen"
=20
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:199
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:375
 msgid "Create"
 msgstr "Erstellen"
=20
@@ -615,7 +613,7 @@ msgstr "Bitte w=C3=A4hlen Sie einen =C3=9Cbernahmez=
weig."
 #: lib/branch_create.tcl:140
 #, tcl-format
 msgid "Tracking branch %s is not a branch in the remote repository."
-msgstr "=C3=9Cbernahmezweig =C2=BB%s=C2=AB ist kein Zweig im Projektar=
chiv der Gegenseite."
+msgstr "=C3=9Cbernahmezweig =C2=BB%s=C2=AB ist kein Zweig im anderen P=
rojektarchiv."
=20
 #: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
 msgid "Please supply a branch name."
@@ -721,9 +719,9 @@ msgstr "[Nach oben]"
 msgid "Browse Branch Files"
 msgstr "Dateien des Zweigs durchbl=C3=A4ttern"
=20
-#: lib/browser.tcl:277 lib/choose_repository.tcl:215
-#: lib/choose_repository.tcl:305 lib/choose_repository.tcl:315
-#: lib/choose_repository.tcl:811
+#: lib/browser.tcl:277 lib/choose_repository.tcl:391
+#: lib/choose_repository.tcl:482 lib/choose_repository.tcl:492
+#: lib/choose_repository.tcl:989
 msgid "Browse"
 msgstr "Bl=C3=A4ttern"
=20
@@ -889,209 +887,225 @@ msgstr ""
 "Dies ist ein Beispieltext.\n"
 "Wenn Ihnen dieser Text gef=C3=A4llt, sollten Sie diese Schriftart w=C3=
=A4hlen."
=20
-#: lib/choose_repository.tcl:25
+#: lib/choose_repository.tcl:27
 msgid "Git Gui"
 msgstr "Git Gui"
=20
-#: lib/choose_repository.tcl:69 lib/choose_repository.tcl:204
+#: lib/choose_repository.tcl:80 lib/choose_repository.tcl:380
 msgid "Create New Repository"
 msgstr "Neues Projektarchiv"
=20
-#: lib/choose_repository.tcl:74 lib/choose_repository.tcl:291
+#: lib/choose_repository.tcl:86
+msgid "New..."
+msgstr "Neu..."
+
+#: lib/choose_repository.tcl:93 lib/choose_repository.tcl:468
 msgid "Clone Existing Repository"
 msgstr "Projektarchiv kopieren"
=20
-#: lib/choose_repository.tcl:79 lib/choose_repository.tcl:800
+#: lib/choose_repository.tcl:99
+msgid "Clone..."
+msgstr "Kopieren..."
+
+#: lib/choose_repository.tcl:106 lib/choose_repository.tcl:978
 msgid "Open Existing Repository"
 msgstr "Projektarchiv =C3=B6ffnen"
=20
-#: lib/choose_repository.tcl:91
-msgid "Next >"
-msgstr "Weiter >"
+#: lib/choose_repository.tcl:112
+msgid "Open..."
+msgstr "=C3=96ffnen..."
+
+#: lib/choose_repository.tcl:125
+msgid "Recent Repositories"
+msgstr "Zuletzt benutzte Projektarchive"
=20
-#: lib/choose_repository.tcl:152
+#: lib/choose_repository.tcl:131
+msgid "Open Recent Repository:"
+msgstr "Zuletzt benutztes Projektarchiv =C3=B6ffnen:"
+
+#: lib/choose_repository.tcl:294
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "Projektarchiv =C2=BB%s=C2=AB existiert bereits."
=20
-#: lib/choose_repository.tcl:158 lib/choose_repository.tcl:165
-#: lib/choose_repository.tcl:172
+#: lib/choose_repository.tcl:300 lib/choose_repository.tcl:307
+#: lib/choose_repository.tcl:314
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr "Projektarchiv =C2=BB%s=C2=AB konnte nicht erstellt werden:"
=20
-#: lib/choose_repository.tcl:209 lib/choose_repository.tcl:309
+#: lib/choose_repository.tcl:385 lib/choose_repository.tcl:486
 msgid "Directory:"
 msgstr "Verzeichnis:"
=20
-#: lib/choose_repository.tcl:238 lib/choose_repository.tcl:363
-#: lib/choose_repository.tcl:834
+#: lib/choose_repository.tcl:415 lib/choose_repository.tcl:544
+#: lib/choose_repository.tcl:1013
 msgid "Git Repository"
 msgstr "Git Projektarchiv"
=20
-#: lib/choose_repository.tcl:253 lib/choose_repository.tcl:260
+#: lib/choose_repository.tcl:430 lib/choose_repository.tcl:437
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "Verzeichnis =C2=BB%s=C2=AB existiert bereits."
=20
-#: lib/choose_repository.tcl:265
+#: lib/choose_repository.tcl:442
 #, tcl-format
 msgid "File %s already exists."
 msgstr "Datei =C2=BB%s=C2=AB existiert bereits."
=20
-#: lib/choose_repository.tcl:286
+#: lib/choose_repository.tcl:463
 msgid "Clone"
 msgstr "Kopieren"
=20
-#: lib/choose_repository.tcl:299
+#: lib/choose_repository.tcl:476
 msgid "URL:"
 msgstr "URL:"
=20
-#: lib/choose_repository.tcl:319
+#: lib/choose_repository.tcl:496
 msgid "Clone Type:"
 msgstr "Art der Kopie:"
=20
-#: lib/choose_repository.tcl:325
+#: lib/choose_repository.tcl:502
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
-msgstr ""
+msgstr "Standard (schnell, teilweise redundant, Hardlinks)"
=20
-#: lib/choose_repository.tcl:331
+#: lib/choose_repository.tcl:508
 msgid "Full Copy (Slower, Redundant Backup)"
-msgstr ""
+msgstr "Alles kopieren (langsamer, volle Redundanz)"
=20
-#: lib/choose_repository.tcl:337
+#: lib/choose_repository.tcl:514
 msgid "Shared (Fastest, Not Recommended, No Backup)"
-msgstr ""
+msgstr "Verkn=C3=BCpft (schnell, nicht empfohlen, kein Backup)"
=20
-#: lib/choose_repository.tcl:369 lib/choose_repository.tcl:418
-#: lib/choose_repository.tcl:560 lib/choose_repository.tcl:630
-#: lib/choose_repository.tcl:840 lib/choose_repository.tcl:848
+#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
+#: lib/choose_repository.tcl:738 lib/choose_repository.tcl:808
+#: lib/choose_repository.tcl:1019 lib/choose_repository.tcl:1027
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "Kein Git-Projektarchiv in =C2=BB%s=C2=AB gefunden."
=20
-#: lib/choose_repository.tcl:405
+#: lib/choose_repository.tcl:586
 msgid "Standard only available for local repository."
-msgstr ""
+msgstr "Standard ist nur f=C3=BCr lokale Projektarchive verf=C3=BCgbar=
=2E"
=20
-#: lib/choose_repository.tcl:409
+#: lib/choose_repository.tcl:590
 msgid "Shared only available for local repository."
-msgstr ""
+msgstr "Verkn=C3=BCpft ist nur f=C3=BCr lokale Projektarchive verf=C3=BC=
gbar."
=20
-#: lib/choose_repository.tcl:439
+#: lib/choose_repository.tcl:617
 msgid "Failed to configure origin"
 msgstr ""
=20
-#: lib/choose_repository.tcl:451
+#: lib/choose_repository.tcl:629
 msgid "Counting objects"
 msgstr ""
=20
-#: lib/choose_repository.tcl:452
+#: lib/choose_repository.tcl:630
 msgid "buckets"
 msgstr ""
=20
-#: lib/choose_repository.tcl:476
+#: lib/choose_repository.tcl:654
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr ""
=20
-#: lib/choose_repository.tcl:512
+#: lib/choose_repository.tcl:690
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "Von =C2=BB%s=C2=AB konnte nichts kopiert werden."
=20
-#: lib/choose_repository.tcl:514 lib/choose_repository.tcl:728
-#: lib/choose_repository.tcl:740
+#: lib/choose_repository.tcl:692 lib/choose_repository.tcl:906
+#: lib/choose_repository.tcl:918
 msgid "The 'master' branch has not been initialized."
 msgstr ""
=20
-#: lib/choose_repository.tcl:527
+#: lib/choose_repository.tcl:705
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr ""
=20
-#: lib/choose_repository.tcl:539
+#: lib/choose_repository.tcl:717
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "Kopieren von =C2=BB%s=C2=AB"
=20
-#: lib/choose_repository.tcl:570
+#: lib/choose_repository.tcl:748
 msgid "Copying objects"
 msgstr "Objektdatenbank kopieren"
=20
-#: lib/choose_repository.tcl:571
+#: lib/choose_repository.tcl:749
 msgid "KiB"
 msgstr "KB"
=20
-#: lib/choose_repository.tcl:595
+#: lib/choose_repository.tcl:773
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "Objekt kann nicht kopiert werden: %s"
=20
-#: lib/choose_repository.tcl:605
+#: lib/choose_repository.tcl:783
 msgid "Linking objects"
 msgstr "Objekte verlinken"
=20
-#: lib/choose_repository.tcl:606
+#: lib/choose_repository.tcl:784
 msgid "objects"
 msgstr "Objekte"
=20
-#: lib/choose_repository.tcl:614
+#: lib/choose_repository.tcl:792
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "Objekt kann nicht hartverlinkt werden: %s"
=20
-#: lib/choose_repository.tcl:669
+#: lib/choose_repository.tcl:847
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
 msgstr ""
=20
-#: lib/choose_repository.tcl:680
+#: lib/choose_repository.tcl:858
 msgid "Cannot fetch tags.  See console output for details."
 msgstr ""
=20
-#: lib/choose_repository.tcl:704
+#: lib/choose_repository.tcl:882
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr ""
=20
-#: lib/choose_repository.tcl:713
+#: lib/choose_repository.tcl:891
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr ""
=20
-#: lib/choose_repository.tcl:719
+#: lib/choose_repository.tcl:897
 msgid "Clone failed."
 msgstr "Kopieren fehlgeschlagen."
=20
-#: lib/choose_repository.tcl:726
+#: lib/choose_repository.tcl:904
 msgid "No default branch obtained."
 msgstr ""
=20
-#: lib/choose_repository.tcl:737
+#: lib/choose_repository.tcl:915
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr ""
=20
-#: lib/choose_repository.tcl:749
+#: lib/choose_repository.tcl:927
 msgid "Creating working directory"
 msgstr "Arbeitskopie erstellen"
=20
-#: lib/choose_repository.tcl:750 lib/index.tcl:15 lib/index.tcl:80
+#: lib/choose_repository.tcl:928 lib/index.tcl:15 lib/index.tcl:80
 #: lib/index.tcl:149
 msgid "files"
 msgstr "Dateien"
=20
-#: lib/choose_repository.tcl:779
+#: lib/choose_repository.tcl:957
 msgid "Initial file checkout failed."
 msgstr ""
=20
-#: lib/choose_repository.tcl:795
+#: lib/choose_repository.tcl:973
 msgid "Open"
 msgstr "=C3=96ffnen"
=20
-#: lib/choose_repository.tcl:805
+#: lib/choose_repository.tcl:983
 msgid "Repository:"
 msgstr "Projektarchiv:"
=20
-#: lib/choose_repository.tcl:854
+#: lib/choose_repository.tcl:1033
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "Projektarchiv =C2=BB%s=C2=AB konnte nicht ge=C3=B6ffnet werden=
=2E"
@@ -1326,7 +1340,7 @@ msgstr "Festplattenplatz von komprimierten Objekt=
en"
=20
 #: lib/database.tcl:48
 msgid "Packed objects waiting for pruning"
-msgstr "Komprimierte Objekte, die zum L=C3=B6schen vorgesehen sind"
+msgstr "Komprimierte Objekte, die zum Entfernen vorgesehen sind"
=20
 #: lib/database.tcl:49
 msgid "Garbage files"
@@ -1644,7 +1658,7 @@ msgstr "Auf Datei=C3=A4nderungsdatum verlassen"
=20
 #: lib/option.tcl:111
 msgid "Prune Tracking Branches During Fetch"
-msgstr "=C3=9Cbernahmezweige l=C3=B6schen w=C3=A4hrend Anforderung"
+msgstr "=C3=9Cbernahmezweige entfernen w=C3=A4hrend Anforderung"
=20
 #: lib/option.tcl:112
 msgid "Match Tracking Branches"
@@ -1673,30 +1687,15 @@ msgstr "pt."
=20
 #: lib/option.tcl:200
 msgid "Preferences"
-msgstr ""
+msgstr "Einstellungen"
=20
 #: lib/option.tcl:235
 msgid "Failed to completely save options:"
 msgstr "Optionen konnten nicht gespeichert werden:"
=20
-#: lib/remote.tcl:165
-#, fuzzy
-msgid "Prune from"
-msgstr "L=C3=B6schen von =C2=BB%s=C2=AB"
-
-#: lib/remote.tcl:170
-#, fuzzy
-msgid "Fetch from"
-msgstr "Von =C2=BB%s=C2=AB anfordern"
-
-#: lib/remote.tcl:213
-#, fuzzy
-msgid "Push to"
-msgstr "Nach =C2=BB%s=C2=AB ausliefern"
-
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
 msgid "Delete Remote Branch"
-msgstr "Zweig im Projektarchiv der Gegenseite l=C3=B6schen"
+msgstr "Zweig im anderen Projektarchiv l=C3=B6schen"
=20
 #: lib/remote_branch_delete.tcl:47
 msgid "From Repository"
@@ -1704,7 +1703,7 @@ msgstr "Von Projektarchiv"
=20
 #: lib/remote_branch_delete.tcl:50 lib/transport.tcl:123
 msgid "Remote:"
-msgstr "Gegenseite:"
+msgstr "Anderes Archiv:"
=20
 #: lib/remote_branch_delete.tcl:66 lib/transport.tcl:138
 msgid "Arbitrary URL:"
@@ -1780,11 +1779,23 @@ msgstr "Kein Projektarchiv ausgew=C3=A4hlt."
 msgid "Scanning %s..."
 msgstr "=C2=BB%s=C2=AB laden..."
=20
-#: lib/shortcut.tcl:26 lib/shortcut.tcl:74
-msgid "Cannot write script:"
-msgstr "Fehler beim Schreiben des Scripts:"
+#: lib/remote.tcl:165
+msgid "Prune from"
+msgstr "Entfernen von"
+
+#: lib/remote.tcl:170
+msgid "Fetch from"
+msgstr "Anfordern von"
+
+#: lib/remote.tcl:213
+msgid "Push to"
+msgstr "Versenden nach"
+
+#: lib/shortcut.tcl:20 lib/shortcut.tcl:61
+msgid "Cannot write shortcut:"
+msgstr "Fehler beim Schreiben der Verkn=C3=BCpfung:"
=20
-#: lib/shortcut.tcl:149
+#: lib/shortcut.tcl:136
 msgid "Cannot write icon:"
 msgstr "Fehler beim Erstellen des Icons:"
=20
@@ -1806,31 +1817,31 @@ msgstr "Neue =C3=84nderungen von =C2=BB%s=C2=AB=
 holen"
 #: lib/transport.tcl:18
 #, tcl-format
 msgid "remote prune %s"
-msgstr ""
+msgstr "Entfernen von =C2=BB%s=C2=AB im anderen Archiv"
=20
 #: lib/transport.tcl:19
 #, tcl-format
 msgid "Pruning tracking branches deleted from %s"
-msgstr "=C3=9Cbernahmezweige l=C3=B6schen, die in =C2=BB%s=C2=AB gel=C3=
=B6scht wurden"
+msgstr "=C3=9Cbernahmezweige entfernen, die in =C2=BB%s=C2=AB gel=C3=B6=
scht wurden"
=20
 #: lib/transport.tcl:25 lib/transport.tcl:71
 #, tcl-format
 msgid "push %s"
-msgstr "=C2=BB%s=C2=AB ausliefern..."
+msgstr "=C2=BB%s=C2=AB versenden..."
=20
 #: lib/transport.tcl:26
 #, tcl-format
 msgid "Pushing changes to %s"
-msgstr "=C3=84nderungen nach =C2=BB%s=C2=AB ausliefern"
+msgstr "=C3=84nderungen nach =C2=BB%s=C2=AB versenden"
=20
 #: lib/transport.tcl:72
 #, tcl-format
 msgid "Pushing %s %s to %s"
-msgstr "%s %s nach %s ausliefern"
+msgstr "%s %s nach %s versenden"
=20
 #: lib/transport.tcl:89
 msgid "Push Branches"
-msgstr "Zweige ausliefern"
+msgstr "Zweige versenden"
=20
 #: lib/transport.tcl:103
 msgid "Source Branches"
@@ -1857,6 +1868,9 @@ msgstr "Kompaktes Datenformat benutzen (f=C3=BCr =
langsame Netzverbindungen)"
 msgid "Include tags"
 msgstr "Mit Markierungen =C3=BCbertragen"
=20
+#~ msgid "Next >"
+#~ msgstr "Weiter >"
+
 #~ msgid "Fetch"
 #~ msgstr "Anfordern"
=20
diff --git a/po/glossary/de.po b/po/glossary/de.po
index 054cf4d..c94786c 100644
--- a/po/glossary/de.po
+++ b/po/glossary/de.po
@@ -6,8 +6,8 @@
 msgid ""
 msgstr ""
 "Project-Id-Version: git-gui glossary\n"
-"POT-Creation-Date: 2007-10-05 22:30+0200\n"
-"PO-Revision-Date: 2007-10-05 22:32+0200\n"
+"POT-Creation-Date: 2007-10-19 21:43+0200\n"
+"PO-Revision-Date: 2007-10-20 15:24+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German \n"
 "MIME-Version: 1.0\n"
@@ -108,9 +108,9 @@ msgstr "zusammenf=C3=BChren"
 msgid "message"
 msgstr "Beschreibung (Meldung?, Nachricht?; Source Safe: Kommentar)"
=20
-#. ""
+#. "Deletes all stale tracking branches under <name>. These stale bran=
ches have already been removed from the remote repository referenced by=
 <name>, but are still locally available in 'remotes/<name>'."
 msgid "prune"
-msgstr "l=C3=B6schen"
+msgstr "entfernen"
=20
 #. "Pulling a branch means to fetch it and merge it."
 msgid "pull"
@@ -118,12 +118,16 @@ msgstr "=C3=BCbernehmen (ziehen?)"
=20
 #. "Pushing a branch means to get the branch's head ref from a remote =
repository, and ... (well, can someone please explain it for mere morta=
ls?)"
 msgid "push"
-msgstr "ausliefern (hochladen? verschicken? schieben?)"
+msgstr "versenden (ausliefern? hochladen? verschicken? schieben?)"
=20
 #. ""
 msgid "redo"
 msgstr "wiederholen"
=20
+#. "An other repository ('remote'). One might have a set of remotes wh=
ose branches one tracks."
+msgid "remote"
+msgstr "Andere Archive (Gegenseite?, Entfernte?, Server?)"
+
 #. "A collection of refs (?) together with an object database containi=
ng all objects which are reachable from the refs... (oops, you've lost =
me here. Again, please an explanation for mere mortals?)"
 msgid "repository"
 msgstr "Projektarchiv"
--=20
1.5.3.4.206.g58ba4

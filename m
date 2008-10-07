From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [Gitk PATCH 3/6] gitk: regenerated po files
Date: Tue,  7 Oct 2008 23:56:46 +0200
Message-ID: <1223416609-18864-4-git-send-email-robin.rosenberg@dewire.com>
References: <1223416609-18864-1-git-send-email-robin.rosenberg@dewire.com>
 <1223416609-18864-2-git-send-email-robin.rosenberg@dewire.com>
 <1223416609-18864-3-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: speace@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 08 00:00:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnKbA-0003He-DZ
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 00:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbYJGV6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 17:58:22 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755042AbYJGV6V
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 17:58:21 -0400
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:45991 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767AbYJGV6J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 17:58:09 -0400
Received: by av8-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id E95BF3800C; Tue,  7 Oct 2008 23:58:06 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av8-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id A15A937ECC; Tue,  7 Oct 2008 23:58:06 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 4F44437E43;
	Tue,  7 Oct 2008 23:58:05 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.308.gef4a
In-Reply-To: <1223416609-18864-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97750>

We intend to change the source strings. This is a "null" update
using make update-po to make the real changes easier to see later on.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 po/de.po |  443 ++++++++++++++++++++++++++++--------------------------=
-
 po/es.po |  500 +++++++++++++++++++++++++++++++++---------------------=
--------
 po/it.po |  489 +++++++++++++++++++++++++++++++++---------------------=
-------
 po/sv.po |  431 +++++++++++++++++++++++++++--------------------------
 4 files changed, 978 insertions(+), 885 deletions(-)

diff --git a/po/de.po b/po/de.po
index 04ee570..af18389 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7,7 +7,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-05-24 22:32+0200\n"
+"POT-Creation-Date: 2008-10-07 23:06+0200\n"
 "PO-Revision-Date: 2008-05-24 22:40+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
@@ -15,17 +15,17 @@ msgstr ""
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: gitk:102
+#: gitk:113
 msgid "Couldn't get list of unmerged files:"
 msgstr "Liste der nicht-zusammengef=C3=BChrten Dateien nicht gefunden:=
"
=20
-#: gitk:329
+#: gitk:340
 msgid "No files selected: --merge specified but no files are unmerged.=
"
 msgstr ""
 "Keine Dateien ausgew=C3=A4hlt: --merge angegeben, es existieren aber =
keine nicht-"
 "zusammengef=C3=BChrten Dateien."
=20
-#: gitk:332
+#: gitk:343
 msgid ""
 "No files selected: --merge specified but no unmerged files are within=
 file "
 "limit."
@@ -33,257 +33,261 @@ msgstr ""
 "Keine Dateien ausgew=C3=A4hle: --merge angegeben, aber keine nicht-"
 "zusammengef=C3=BChrten Dateien sind in der Dateiauswahl."
=20
-#: gitk:354
+#: gitk:365
 msgid "Error executing git log:"
 msgstr "Fehler beim Ausf=C3=BChren von git-log:"
=20
-#: gitk:369
+#: gitk:378
 msgid "Reading"
 msgstr "Lesen"
=20
-#: gitk:151 gitk:2191
+#: gitk:438 gitk:3459
 msgid "Reading commits..."
 msgstr "Versionen lesen..."
=20
-#: gitk:275
-msgid "Can't parse git log output:"
-msgstr "Ausgabe von git-log kann nicht erkannt werden:"
-
-#: gitk:386 gitk:2195
+#: gitk:441 gitk:1528 gitk:3462
 msgid "No commits selected"
 msgstr "Keine Versionen ausgew=C3=A4hlt."
=20
-#: gitk:500
+#: gitk:1399
+msgid "Can't parse git log output:"
+msgstr "Ausgabe von git-log kann nicht erkannt werden:"
+
+#: gitk:1605
 msgid "No commit information available"
 msgstr "Keine Versionsinformation verf=C3=BCgbar"
=20
-#: gitk:599 gitk:621 gitk:1955 gitk:6424 gitk:7924 gitk:8083
+#: gitk:1709 gitk:1731 gitk:3256 gitk:7727 gitk:9256 gitk:9424
 msgid "OK"
 msgstr "Ok"
=20
-#: gitk:623 gitk:1956 gitk:6108 gitk:6179 gitk:6276 gitk:6322 gitk:642=
6
-#: gitk:7925 gitk:8084
+#: gitk:1733 gitk:3257 gitk:7403 gitk:7474 gitk:7577 gitk:7623 gitk:77=
29
+#: gitk:9257 gitk:9425
 msgid "Cancel"
 msgstr "Abbrechen"
=20
-#: gitk:661
+#: gitk:1798
 msgid "File"
 msgstr "Datei"
=20
-#: gitk:663
+#: gitk:1800
 msgid "Update"
 msgstr "Aktualisieren"
=20
-#: gitk:1722
+#: gitk:1801
 msgid "Reload"
 msgstr "Neu laden"
=20
-#: gitk:1723
+#: gitk:1802
 msgid "Reread references"
 msgstr "Zweige neu laden"
=20
-#: gitk:665
+#: gitk:1803
 msgid "List references"
 msgstr "Zweige/Markierungen auflisten"
=20
-#: gitk:666
+#: gitk:1804
 msgid "Quit"
 msgstr "Beenden"
=20
-#: gitk:668
+#: gitk:1806
 msgid "Edit"
 msgstr "Bearbeiten"
=20
-#: gitk:669
+#: gitk:1807
 msgid "Preferences"
 msgstr "Einstellungen"
=20
-#: gitk:672 gitk:1892
+#: gitk:1810 gitk:3193
 msgid "View"
 msgstr "Ansicht"
=20
-#: gitk:673
+#: gitk:1811
 msgid "New view..."
 msgstr "Neue Ansicht..."
=20
-#: gitk:674 gitk:2133 gitk:8723
+#: gitk:1812
 msgid "Edit view..."
 msgstr "Ansicht bearbeiten..."
=20
-#: gitk:676 gitk:2134 gitk:8724
+#: gitk:1814
 msgid "Delete view"
 msgstr "Ansicht l=C3=B6schen"
=20
-#: gitk:678
+#: gitk:1816
 msgid "All files"
 msgstr "Alle Dateien"
=20
-#: gitk:682
+#: gitk:1820
 msgid "Help"
 msgstr "Hilfe"
=20
-#: gitk:683 gitk:1317
+#: gitk:1821 gitk:2484
 msgid "About gitk"
 msgstr "=C3=9Cber gitk"
=20
-#: gitk:684
+#: gitk:1822
 msgid "Key bindings"
 msgstr "Tastenk=C3=BCrzel"
=20
-#: gitk:741
+#: gitk:1879
 msgid "SHA1 ID: "
 msgstr "SHA1:"
=20
-#: gitk:1831
+#: gitk:1910
 msgid "Row"
 msgstr "Zeile"
=20
-#: gitk:1862
+#: gitk:1941
 msgid "Find"
 msgstr "Suche"
=20
-#: gitk:792
+#: gitk:1942
 msgid "next"
 msgstr "n=C3=A4chste"
=20
-#: gitk:793
+#: gitk:1943
 msgid "prev"
 msgstr "vorige"
=20
-#: gitk:794
+#: gitk:1944
 msgid "commit"
 msgstr "Version nach"
=20
-#: gitk:797 gitk:799 gitk:2356 gitk:2379 gitk:2403 gitk:4306 gitk:4369
+#: gitk:1947 gitk:1949 gitk:3614 gitk:3637 gitk:3661 gitk:5547 gitk:56=
18
 msgid "containing:"
 msgstr "Beschreibung:"
=20
-#: gitk:800 gitk:1778 gitk:1783 gitk:2431
+#: gitk:1950 gitk:2951 gitk:2956 gitk:3689
 msgid "touching paths:"
 msgstr "Dateien:"
=20
-#: gitk:801 gitk:2436
+#: gitk:1951 gitk:3694
 msgid "adding/removing string:"
 msgstr "=C3=84nderungen:"
=20
-#: gitk:810 gitk:812
+#: gitk:1960 gitk:1962
 msgid "Exact"
 msgstr "Exakt"
=20
-#: gitk:812 gitk:2514 gitk:4274
+#: gitk:1962 gitk:3770 gitk:5515
 msgid "IgnCase"
 msgstr "Kein Gro=C3=9F/Klein"
=20
-#: gitk:812 gitk:2405 gitk:2512 gitk:4270
+#: gitk:1962 gitk:3663 gitk:3768 gitk:5511
 msgid "Regexp"
 msgstr "Regexp"
=20
-#: gitk:814 gitk:815 gitk:2533 gitk:2563 gitk:2570 gitk:4380 gitk:4436
+#: gitk:1964 gitk:1965 gitk:3789 gitk:3819 gitk:3826 gitk:5638 gitk:57=
05
 msgid "All fields"
 msgstr "Alle Felder"
=20
-#: gitk:815 gitk:2531 gitk:2563 gitk:4336
+#: gitk:1965 gitk:3787 gitk:3819 gitk:5577
 msgid "Headline"
 msgstr "=C3=9Cberschrift"
=20
-#: gitk:816 gitk:2531 gitk:4336 gitk:4436 gitk:4827
+#: gitk:1966 gitk:3787 gitk:5577 gitk:5705 gitk:6106
 msgid "Comments"
 msgstr "Beschreibung"
=20
-#: gitk:816 gitk:2531 gitk:2535 gitk:2570 gitk:4336 gitk:4763 gitk:595=
7
-#: gitk:5972
+#: gitk:1966 gitk:3787 gitk:3791 gitk:3826 gitk:5577 gitk:6042 gitk:72=
49
+#: gitk:7264
 msgid "Author"
 msgstr "Autor"
=20
-#: gitk:816 gitk:2531 gitk:4336 gitk:4765
+#: gitk:1966 gitk:3787 gitk:5577 gitk:6044
 msgid "Committer"
 msgstr "Eintragender"
=20
-#: gitk:845
+#: gitk:1995
 msgid "Search"
 msgstr "Suche"
=20
-#: gitk:852
+#: gitk:2002
 msgid "Diff"
 msgstr "Vergleich"
=20
-#: gitk:854
+#: gitk:2004
 msgid "Old version"
 msgstr "Alte Version"
=20
-#: gitk:856
+#: gitk:2006
 msgid "New version"
 msgstr "Neue Version"
=20
-#: gitk:858
+#: gitk:2008
 msgid "Lines of context"
 msgstr "Kontextzeilen"
=20
-#: gitk:868
+#: gitk:2018
 msgid "Ignore space change"
 msgstr "Leerzeichen=C3=A4nderungen ignorieren"
=20
-#: gitk:926
+#: gitk:2076
 msgid "Patch"
 msgstr "Patch"
=20
-#: gitk:928
+#: gitk:2078
 msgid "Tree"
 msgstr "Baum"
=20
-#: gitk:1053 gitk:1068 gitk:6023
+#: gitk:2204 gitk:2219
 msgid "Diff this -> selected"
 msgstr "Vergleich diese -> gew=C3=A4hlte"
=20
-#: gitk:1055 gitk:1070 gitk:6024
+#: gitk:2206 gitk:2221
 msgid "Diff selected -> this"
 msgstr "Vergleich gew=C3=A4hlte -> diese"
=20
-#: gitk:1057 gitk:1072 gitk:6025
+#: gitk:2208 gitk:2223
 msgid "Make patch"
 msgstr "Patch erstellen"
=20
-#: gitk:1058 gitk:6163
+#: gitk:2209 gitk:7458
 msgid "Create tag"
 msgstr "Markierung erstellen"
=20
-#: gitk:1059 gitk:6256
+#: gitk:2210 gitk:7557
 msgid "Write commit to file"
 msgstr "Version in Datei schreiben"
=20
-#: gitk:1060 gitk:6310
+#: gitk:2211 gitk:7611
 msgid "Create new branch"
 msgstr "Neuen Zweig erstellen"
=20
-#: gitk:1061
+#: gitk:2212
 msgid "Cherry-pick this commit"
 msgstr "Diese Version pfl=C3=BCcken"
=20
-#: gitk:1063
+#: gitk:2214
 msgid "Reset HEAD branch to here"
 msgstr "HEAD-Zweig auf diese Version zur=C3=BCcksetzen"
=20
-#: gitk:1079
+#: gitk:2230
 msgid "Check out this branch"
 msgstr "Auf diesen Zweig umstellen"
=20
-#: gitk:1081
+#: gitk:2232
 msgid "Remove this branch"
 msgstr "Zweig l=C3=B6schen"
=20
-#: gitk:1087
+#: gitk:2238
 msgid "Highlight this too"
 msgstr "Diesen auch hervorheben"
=20
-#: gitk:1089
+#: gitk:2240
 msgid "Highlight this only"
 msgstr "Nur diesen hervorheben"
=20
-#: gitk:2162
+#: gitk:2242
 msgid "External diff"
 msgstr "Externer Vergleich"
=20
-#: gitk:2403
+#: gitk:2244
+msgid "Blame parent commit"
+msgstr ""
+
+#: gitk:2485
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -297,431 +301,436 @@ msgstr ""
 "\n"
 "Copyright =C2=A9 2005-2008 Paul Mackerras\n"
 "\n"
-"Benutzung und Weiterverbreitung gem=C3=A4=C3=9F den Bedingungen der G=
NU General Public License"
+"Benutzung und Weiterverbreitung gem=C3=A4=C3=9F den Bedingungen der G=
NU General Public "
+"License"
=20
-#: gitk:1326 gitk:1387 gitk:6582
+#: gitk:2493 gitk:2554 gitk:7906
 msgid "Close"
 msgstr "Schlie=C3=9Fen"
=20
-#: gitk:1345
+#: gitk:2512
 msgid "Gitk key bindings"
 msgstr "Gitk Tastaturbelegung"
=20
-#: gitk:1347
+#: gitk:2514
 msgid "Gitk key bindings:"
 msgstr "Gitk Tastaturbelegung:"
=20
-#: gitk:1349
+#: gitk:2516
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tBeenden"
=20
-#: gitk:1350
+#: gitk:2517
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Pos1>\t\tZur neuesten Version springen"
=20
-#: gitk:1351
+#: gitk:2518
 msgid "<End>\t\tMove to last commit"
 msgstr "<Ende>\t\tZur =C3=A4ltesten Version springen"
=20
-#: gitk:1352
+#: gitk:2519
 msgid "<Up>, p, i\tMove up one commit"
 msgstr "<Hoch>, p, i\tN=C3=A4chste neuere Version"
=20
-#: gitk:1353
+#: gitk:2520
 msgid "<Down>, n, k\tMove down one commit"
 msgstr "<Runter>, n, k\tN=C3=A4chste =C3=A4ltere Version"
=20
-#: gitk:1354
+#: gitk:2521
 msgid "<Left>, z, j\tGo back in history list"
 msgstr "<Links>, z, j\tEine Version zur=C3=BCckgehen"
=20
-#: gitk:1355
+#: gitk:2522
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Rechts>, x, l\tEine Version weitergehen"
=20
-#: gitk:1356
+#: gitk:2523
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<BildHoch>\tEine Seite nach oben bl=C3=A4ttern"
=20
-#: gitk:1357
+#: gitk:2524
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<BildRunter>\tEine Seite nach unten bl=C3=A4ttern"
=20
-#: gitk:1358
+#: gitk:2525
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Pos1>\tZum oberen Ende der Versionsliste bl=C3=A4ttern"
=20
-#: gitk:1359
+#: gitk:2526
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-Ende>\tZum unteren Ende der Versionsliste bl=C3=A4ttern"
=20
-#: gitk:1360
+#: gitk:2527
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Hoch>\tVersionsliste eine Zeile nach oben bl=C3=A4ttern"
=20
-#: gitk:1361
+#: gitk:2528
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Runter>\tVersionsliste eine Zeile nach unten bl=C3=A4ttern=
"
=20
-#: gitk:1362
+#: gitk:2529
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-BildHoch>\tVersionsliste eine Seite hoch bl=C3=A4ttern"
=20
-#: gitk:1363
+#: gitk:2530
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-BildRunter>\tVersionsliste eine Seite nach unten bl=C3=A4t=
tern"
=20
-#: gitk:1364
+#: gitk:2531
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Umschalt-Hoch>\tR=C3=BCckw=C3=A4rts suchen (nach oben; neuere=
 Versionen)"
=20
-#: gitk:1365
+#: gitk:2532
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr "<Umschalt-Runter> Suchen (nach unten; =C3=A4ltere Versionen)"
=20
-#: gitk:1366
+#: gitk:2533
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Entf>, b\t\tVergleich eine Seite nach oben bl=C3=A4ttern"
=20
-#: gitk:1367
+#: gitk:2534
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<L=C3=B6schtaste>\tVergleich eine Seite nach oben bl=C3=A4tter=
n"
=20
-#: gitk:1368
+#: gitk:2535
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Leertaste>\tVergleich eine Seite nach unten bl=C3=A4ttern"
=20
-#: gitk:1369
+#: gitk:2536
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\tVergleich um 18 Zeilen nach oben (=C2=BBup=C2=AB) bl=C3=A4=
ttern"
=20
-#: gitk:1370
+#: gitk:2537
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\tVergleich um 18 Zeilen nach unten (=C2=BBdown=C2=AB) bl=C3=
=A4ttern"
=20
-#: gitk:1371
+#: gitk:2538
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tSuchen"
=20
-#: gitk:1372
+#: gitk:2539
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tWeitersuchen"
=20
-#: gitk:1373
+#: gitk:2540
 msgid "<Return>\tMove to next find hit"
 msgstr "<Eingabetaste>\tWeitersuchen"
=20
-#: gitk:1374
+#: gitk:2541
 msgid "/\t\tMove to next find hit, or redo find"
 msgstr "/\t\tWeitersuchen oder neue Suche beginnen"
=20
-#: gitk:1375
+#: gitk:2542
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tR=C3=BCckw=C3=A4rts weitersuchen"
=20
-#: gitk:1376
+#: gitk:2543
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tVergleich zur n=C3=A4chsten Datei (=C2=BBfile=C2=AB) bl=C3=
=A4ttern"
=20
-#: gitk:1377
+#: gitk:2544
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tWeitersuchen im Vergleich"
=20
-#: gitk:1378
+#: gitk:2545
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tR=C3=BCckw=C3=A4rts weitersuchen im Vergleich"
=20
-#: gitk:1379
+#: gitk:2546
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-Nummerblock-Plus>\tSchriftgr=C3=B6=C3=9Fe vergr=C3=B6=C3=9F=
ern"
=20
-#: gitk:1380
+#: gitk:2547
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-Plus>\tSchriftgr=C3=B6=C3=9Fe vergr=C3=B6=C3=9Fern"
=20
-#: gitk:1381
+#: gitk:2548
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-Nummernblock-> Schriftgr=C3=B6=C3=9Fe verkleinern"
=20
-#: gitk:1382
+#: gitk:2549
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-Minus>\tSchriftgr=C3=B6=C3=9Fe verkleinern"
=20
-#: gitk:1383
+#: gitk:2550
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tAktualisieren"
=20
-#: gitk:1896
+#: gitk:3065
+#, fuzzy
+msgid "No such commit"
+msgstr "Keine =C3=84nderungen eingetragen"
+
+#: gitk:3197
 msgid "Gitk view definition"
 msgstr "Gitk Ansichten"
=20
-#: gitk:1921
+#: gitk:3222
 msgid "Name"
 msgstr "Name"
=20
-#: gitk:1924
+#: gitk:3225
 msgid "Remember this view"
 msgstr "Diese Ansicht speichern"
=20
-#: gitk:3126
+#: gitk:3229
 msgid "Commits to include (arguments to git log):"
 msgstr "Versionen anzeigen (Argumente von git-log):"
=20
-#: gitk:3133
+#: gitk:3236
 msgid "Command to generate more commits to include:"
 msgstr "Versionsliste durch folgendes Kommando erzeugen lassen:"
=20
-#: gitk:1942
+#: gitk:3243
 msgid "Enter files and directories to include, one per line:"
 msgstr "Folgende Dateien und Verzeichnisse anzeigen (eine pro Zeile):"
=20
-#: gitk:1989
+#: gitk:3290
 msgid "Error in commit selection arguments:"
 msgstr "Fehler in den ausgew=C3=A4hlten Versionen:"
=20
-#: gitk:2043 gitk:2127 gitk:2583 gitk:2597 gitk:3781 gitk:8689 gitk:86=
90
+#: gitk:3344 gitk:3396 gitk:3839 gitk:3853 gitk:5057 gitk:10013 gitk:1=
0014
 msgid "None"
 msgstr "Keine"
=20
-#: gitk:2531 gitk:4336 gitk:5959 gitk:5974
+#: gitk:3787 gitk:5577 gitk:7251 gitk:7266
 msgid "Date"
 msgstr "Datum"
=20
-#: gitk:2531 gitk:4336
+#: gitk:3787 gitk:5577
 msgid "CDate"
 msgstr "Eintragedatum"
=20
-#: gitk:2680 gitk:2685
+#: gitk:3936 gitk:3941
 msgid "Descendant"
 msgstr "Abk=C3=B6mmling"
=20
-#: gitk:2681
+#: gitk:3937
 msgid "Not descendant"
 msgstr "Nicht Abk=C3=B6mmling"
=20
-#: gitk:2688 gitk:2693
+#: gitk:3944 gitk:3949
 msgid "Ancestor"
 msgstr "Vorg=C3=A4nger"
=20
-#: gitk:2689
+#: gitk:3945
 msgid "Not ancestor"
 msgstr "Nicht Vorg=C3=A4nger"
=20
-#: gitk:2924
+#: gitk:4184
 msgid "Local changes checked in to index but not committed"
 msgstr "Lokale =C3=84nderungen bereitgestellt, aber nicht eingetragen"
=20
-#: gitk:2954
+#: gitk:4217
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokale =C3=84nderungen, nicht bereitgestellt"
=20
-#: gitk:4305
+#: gitk:5546
 msgid "Searching"
 msgstr "Suchen"
=20
-#: gitk:4767
+#: gitk:6046
 msgid "Tags:"
 msgstr "Markierungen:"
=20
-#: gitk:4784 gitk:4790 gitk:5952
+#: gitk:6063 gitk:6069 gitk:7244
 msgid "Parent"
 msgstr "Eltern"
=20
-#: gitk:4795
+#: gitk:6074
 msgid "Child"
 msgstr "Kind"
=20
-#: gitk:4804
+#: gitk:6083
 msgid "Branch"
 msgstr "Zweig"
=20
-#: gitk:4807
+#: gitk:6086
 msgid "Follows"
 msgstr "Folgt auf"
=20
-#: gitk:4810
+#: gitk:6089
 msgid "Precedes"
 msgstr "Vorg=C3=A4nger von"
=20
-#: gitk:5094
+#: gitk:6373
 msgid "Error getting merge diffs:"
 msgstr "Fehler beim Laden des Vergleichs:"
=20
-#: gitk:5779
+#: gitk:7077
 msgid "Goto:"
 msgstr "Gehe zu:"
=20
-#: gitk:5781
+#: gitk:7079
 msgid "SHA1 ID:"
 msgstr "SHA1-Hashwert:"
=20
-#: gitk:5806
+#: gitk:7098
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "Kurzer SHA1-Hashwert =C2=BB%s=C2=AB ist mehrdeutig"
=20
-#: gitk:5818
+#: gitk:7110
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "SHA1-Hashwert =C2=BB%s=C2=AB unbekannt"
=20
-#: gitk:5820
+#: gitk:7112
 #, tcl-format
 msgid "Tag/Head %s is not known"
 msgstr "Markierung/Zweig =C2=BB%s=C2=AB ist unbekannt"
=20
-#: gitk:5962
+#: gitk:7254
 msgid "Children"
 msgstr "Kinder"
=20
-#: gitk:6019
+#: gitk:7311
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Zweig =C2=BB%s=C2=AB hierher zur=C3=BCcksetzen"
=20
-#: gitk:7204
+#: gitk:7313
 msgid "Detached head: can't reset"
 msgstr "Zweigspitze ist abgetrennt: Zur=C3=BCcksetzen nicht m=C3=B6gli=
ch"
=20
-#: gitk:7236
+#: gitk:7345
 msgid "Top"
 msgstr "Oben"
=20
-#: gitk:6051
+#: gitk:7346
 msgid "From"
 msgstr "Von"
=20
-#: gitk:6056
+#: gitk:7351
 msgid "To"
 msgstr "bis"
=20
-#: gitk:6079
+#: gitk:7374
 msgid "Generate patch"
 msgstr "Patch erstellen"
=20
-#: gitk:6081
+#: gitk:7376
 msgid "From:"
 msgstr "Von:"
=20
-#: gitk:6090
+#: gitk:7385
 msgid "To:"
 msgstr "bis:"
=20
-#: gitk:6099
+#: gitk:7394
 msgid "Reverse"
 msgstr "Umgekehrt"
=20
-#: gitk:6101 gitk:6270
+#: gitk:7396 gitk:7571
 msgid "Output file:"
 msgstr "Ausgabedatei:"
=20
-#: gitk:6107
+#: gitk:7402
 msgid "Generate"
 msgstr "Erzeugen"
=20
-#: gitk:6143
+#: gitk:7438
 msgid "Error creating patch:"
 msgstr "Fehler beim Patch erzeugen:"
=20
-#: gitk:6165 gitk:6258 gitk:6312
+#: gitk:7460 gitk:7559 gitk:7613
 msgid "ID:"
 msgstr "ID:"
=20
-#: gitk:6174
+#: gitk:7469
 msgid "Tag name:"
 msgstr "Markierungsname:"
=20
-#: gitk:6178 gitk:6321
+#: gitk:7473 gitk:7622
 msgid "Create"
 msgstr "Erstellen"
=20
-#: gitk:6193
+#: gitk:7488
 msgid "No tag name specified"
 msgstr "Kein Markierungsname angegeben"
=20
-#: gitk:6197
+#: gitk:7492
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Markierung =C2=BB%s=C2=AB existiert bereits."
=20
-#: gitk:6203
+#: gitk:7498
 msgid "Error creating tag:"
 msgstr "Fehler bei Markierung erstellen:"
=20
-#: gitk:6267
+#: gitk:7568
 msgid "Command:"
 msgstr "Kommando:"
=20
-#: gitk:6275
+#: gitk:7576
 msgid "Write"
 msgstr "Schreiben"
=20
-#: gitk:6291
+#: gitk:7592
 msgid "Error writing commit:"
 msgstr "Fehler beim Schreiben der Version:"
=20
-#: gitk:6317
+#: gitk:7618
 msgid "Name:"
 msgstr "Name:"
=20
-#: gitk:6336
+#: gitk:7637
 msgid "Please specify a name for the new branch"
 msgstr "Bitte geben Sie einen Namen f=C3=BCr den neuen Zweig an."
=20
-#: gitk:6365
+#: gitk:7666
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
 msgstr ""
-"Version =C2=BB%s=C2=AB ist bereits im Zweig =C2=BB%s=C2=AB enthalten =
-- trotzdem erneut "
-"eintragen?"
+"Version =C2=BB%s=C2=AB ist bereits im Zweig =C2=BB%s=C2=AB enthalten =
-- trotzdem erneut eintragen?"
=20
-#: gitk:6370
+#: gitk:7671
 msgid "Cherry-picking"
 msgstr "Version pfl=C3=BCcken"
=20
-#: gitk:6382
+#: gitk:7683
 msgid "No changes committed"
 msgstr "Keine =C3=84nderungen eingetragen"
=20
-#: gitk:6405
+#: gitk:7708
 msgid "Confirm reset"
 msgstr "Zur=C3=BCcksetzen best=C3=A4tigen"
=20
-#: gitk:6407
+#: gitk:7710
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "Zweig =C2=BB%s=C2=AB auf =C2=BB%s=C2=AB zur=C3=BCcksetzen?"
=20
-#: gitk:6411
+#: gitk:7714
 msgid "Reset type:"
 msgstr "Art des Zur=C3=BCcksetzens:"
=20
-#: gitk:6415
+#: gitk:7718
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Harmlos: Arbeitskopie und Bereitstellung unver=C3=A4ndert"
=20
-#: gitk:6418
+#: gitk:7721
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr ""
 "Gemischt: Arbeitskopie unver=C3=A4ndert,\n"
 "Bereitstellung zur=C3=BCckgesetzt"
=20
-#: gitk:6421
+#: gitk:7724
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -729,21 +738,21 @@ msgstr ""
 "Hart: Arbeitskopie und Bereitstellung\n"
 "(Alle lokalen =C3=84nderungen werden gel=C3=B6scht)"
=20
-#: gitk:6437
+#: gitk:7740
 msgid "Resetting"
 msgstr "Zur=C3=BCcksetzen"
=20
-#: gitk:6494
+#: gitk:7797
 msgid "Checking out"
 msgstr "Umstellen"
=20
-#: gitk:6524
+#: gitk:7848
 msgid "Cannot delete the currently checked-out branch"
 msgstr ""
 "Der Zweig, auf den die Arbeitskopie momentan umgestellt ist, kann nic=
ht "
 "gel=C3=B6scht werden."
=20
-#: gitk:6530
+#: gitk:7854
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -752,16 +761,16 @@ msgstr ""
 "Die Versionen auf Zweig =C2=BB%s=C2=AB existieren auf keinem anderen =
Zweig.\n"
 "Zweig =C2=BB%s=C2=AB trotzdem l=C3=B6schen?"
=20
-#: gitk:6561
+#: gitk:7885
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Markierungen und Zweige: %s"
=20
-#: gitk:6575
+#: gitk:7899
 msgid "Filter"
 msgstr "Filtern"
=20
-#: gitk:6869
+#: gitk:8193
 msgid ""
 "Error reading commit topology information; branch and preceding/follo=
wing "
 "tag information will be incomplete."
@@ -769,125 +778,125 @@ msgstr ""
 "Fehler beim Lesen der Strukturinformationen; Zweige und Vorg=C3=A4nge=
r/Nachfolger "
 "Informationen werden unvollst=C3=A4ndig sein."
=20
-#: gitk:7853
+#: gitk:9179
 msgid "Tag"
 msgstr "Markierung"
=20
-#: gitk:7853
+#: gitk:9179
 msgid "Id"
 msgstr "Id"
=20
-#: gitk:7893
+#: gitk:9225
 msgid "Gitk font chooser"
 msgstr "Gitk Schriften w=C3=A4hlen"
=20
-#: gitk:7910
+#: gitk:9242
 msgid "B"
 msgstr "F"
=20
-#: gitk:7913
+#: gitk:9245
 msgid "I"
 msgstr "K"
=20
-#: gitk:8006
+#: gitk:9338
 msgid "Gitk preferences"
 msgstr "Gitk Einstellungen"
=20
-#: gitk:8007
+#: gitk:9339
 msgid "Commit list display options"
 msgstr "Anzeige Versionsliste"
=20
-#: gitk:8010
+#: gitk:9342
 msgid "Maximum graph width (lines)"
 msgstr "Maximale Graphenbreite (Zeilen)"
=20
-#: gitk:8014
+#: gitk:9346
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Maximale Graphenbreite (% des Fensters)"
=20
-#: gitk:8019
+#: gitk:9351
 msgid "Show local changes"
 msgstr "Lokale =C3=84nderungen anzeigen"
=20
-#: gitk:8024
+#: gitk:9356
 msgid "Auto-select SHA1"
 msgstr "SHA1-Hashwert automatisch markieren"
=20
-#: gitk:8029
+#: gitk:9361
 msgid "Diff display options"
 msgstr "Anzeige Vergleich"
=20
-#: gitk:8031
+#: gitk:9363
 msgid "Tab spacing"
 msgstr "Tabulatorbreite"
=20
-#: gitk:8035
+#: gitk:9367
 msgid "Display nearby tags"
 msgstr "Naheliegende =C3=9Cberschriften anzeigen"
=20
-#: gitk:8040
+#: gitk:9372
 msgid "Limit diffs to listed paths"
 msgstr "Vergleich nur f=C3=BCr angezeigte Pfade"
=20
-#: gitk:9264
+#: gitk:9379
 msgid "External diff tool"
 msgstr "Externes Vergleich-(Diff-)Programm"
=20
-#: gitk:9266
+#: gitk:9381
 msgid "Choose..."
 msgstr "W=C3=A4hlen..."
=20
-#: gitk:9271
+#: gitk:9386
 msgid "Colors: press to choose"
 msgstr "Farben: Klicken zum W=C3=A4hlen"
=20
-#: gitk:8048
+#: gitk:9389
 msgid "Background"
 msgstr "Hintergrund"
=20
-#: gitk:8052
+#: gitk:9393
 msgid "Foreground"
 msgstr "Vordergrund"
=20
-#: gitk:8056
+#: gitk:9397
 msgid "Diff: old lines"
 msgstr "Vergleich: Alte Zeilen"
=20
-#: gitk:8061
+#: gitk:9402
 msgid "Diff: new lines"
 msgstr "Vergleich: Neue Zeilen"
=20
-#: gitk:8066
+#: gitk:9407
 msgid "Diff: hunk header"
 msgstr "Vergleich: =C3=84nderungstitel"
=20
-#: gitk:8072
+#: gitk:9413
 msgid "Select bg"
 msgstr "Hintergrundfarbe Ausw=C3=A4hlen"
=20
-#: gitk:8076
+#: gitk:9417
 msgid "Fonts: press to choose"
 msgstr "Schriftart: Klicken zum W=C3=A4hlen"
=20
-#: gitk:8078
+#: gitk:9419
 msgid "Main font"
 msgstr "Programmschriftart"
=20
-#: gitk:8079
+#: gitk:9420
 msgid "Diff display font"
 msgstr "Vergleich"
=20
-#: gitk:8080
+#: gitk:9421
 msgid "User interface font"
 msgstr "Beschriftungen"
=20
-#: gitk:8096
+#: gitk:9446
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: Farbe w=C3=A4hlen f=C3=BCr %s"
=20
-#: gitk:8477
+#: gitk:9827
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
@@ -895,24 +904,24 @@ msgstr ""
 "Gitk l=C3=A4uft nicht mit dieser Version von Tcl/Tk.\n"
 "Gitk ben=C3=B6tigt mindestens Tcl/Tk 8.4."
=20
-#: gitk:8566
+#: gitk:9919
 msgid "Cannot find a git repository here."
 msgstr "Kein Git-Projektarchiv gefunden."
=20
-#: gitk:8570
+#: gitk:9923
 #, tcl-format
 msgid "Cannot find the git directory \"%s\"."
 msgstr "Git-Verzeichnis =C2=BB%s=C2=AB wurde nicht gefunden."
=20
-#: gitk:8613
+#: gitk:9970
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Mehrdeutige Angabe =C2=BB%s=C2=AB: Sowohl Version als auch Dat=
einame existiert."
=20
-#: gitk:8625
+#: gitk:9982
 msgid "Bad arguments to gitk:"
 msgstr "Falsche Kommandozeilen-Parameter f=C3=BCr gitk:"
=20
-#: gitk:9915
+#: gitk:10042
 msgid "Command line"
 msgstr "Kommandozeile"
diff --git a/po/es.po b/po/es.po
index 2cb1486..620eebd 100644
--- a/po/es.po
+++ b/po/es.po
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: gitk\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-03-13 17:29+0100\n"
+"POT-Creation-Date: 2008-10-07 23:06+0200\n"
 "PO-Revision-Date: 2008-03-25 11:20+0100\n"
 "Last-Translator: Santiago Gala <santiago.gala@gmail.com>\n"
 "Language-Team: Spanish\n"
@@ -16,250 +16,287 @@ msgstr ""
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: gitk:111
-msgid "Error executing git rev-list:"
+#: gitk:113
+msgid "Couldn't get list of unmerged files:"
+msgstr "Imposible obtener la lista de archivos pendientes de fusi=C3=B3=
n:"
+
+#: gitk:340
+msgid "No files selected: --merge specified but no files are unmerged.=
"
+msgstr ""
+"No hay archivos seleccionados: se seleccion=C3=B3 la opci=C3=B3n --me=
rge pero no hay "
+"archivos pendientes de fusi=C3=B3n."
+
+#: gitk:343
+msgid ""
+"No files selected: --merge specified but no unmerged files are within=
 file "
+"limit."
+msgstr ""
+"No hay archivos seleccionados: se seleccion=C3=B3 la opci=C3=B3n --me=
rge pero los "
+"archivos especificados no necesitan fusi=C3=B3n."
+
+#: gitk:365
+#, fuzzy
+msgid "Error executing git log:"
 msgstr "Error al ejecutar git rev-list:"
=20
-#: gitk:124
+#: gitk:378
 msgid "Reading"
 msgstr "Leyendo"
=20
-#: gitk:151 gitk:2191
+#: gitk:438 gitk:3459
 msgid "Reading commits..."
 msgstr "Leyendo revisiones..."
=20
-#: gitk:275
-msgid "Can't parse git log output:"
-msgstr "Error analizando la salida de git log:"
-
-#: gitk:386 gitk:2195
+#: gitk:441 gitk:1528 gitk:3462
 msgid "No commits selected"
 msgstr "No se seleccionaron revisiones"
=20
-#: gitk:500
+#: gitk:1399
+msgid "Can't parse git log output:"
+msgstr "Error analizando la salida de git log:"
+
+#: gitk:1605
 msgid "No commit information available"
 msgstr "Falta informaci=C3=B3n sobre las revisiones"
=20
-#: gitk:599 gitk:621 gitk:1955 gitk:6423 gitk:7923 gitk:8082
+#: gitk:1709 gitk:1731 gitk:3256 gitk:7727 gitk:9256 gitk:9424
 msgid "OK"
 msgstr "Aceptar"
=20
-#: gitk:623 gitk:1956 gitk:6107 gitk:6178 gitk:6275 gitk:6321 gitk:642=
5
-#: gitk:7924 gitk:8083
+#: gitk:1733 gitk:3257 gitk:7403 gitk:7474 gitk:7577 gitk:7623 gitk:77=
29
+#: gitk:9257 gitk:9425
 msgid "Cancel"
 msgstr "Cancelar"
=20
-#: gitk:661
+#: gitk:1798
 msgid "File"
 msgstr "Archivo"
=20
-#: gitk:663
+#: gitk:1800
 msgid "Update"
 msgstr "Actualizar"
=20
-#: gitk:664
+#: gitk:1801
+#, fuzzy
+msgid "Reload"
+msgstr "Leyendo"
+
+#: gitk:1802
 msgid "Reread references"
 msgstr "Releer referencias"
=20
-#: gitk:665
+#: gitk:1803
 msgid "List references"
 msgstr "Lista de referencias"
=20
-#: gitk:666
+#: gitk:1804
 msgid "Quit"
 msgstr "Salir"
=20
-#: gitk:668
+#: gitk:1806
 msgid "Edit"
 msgstr "Editar"
=20
-#: gitk:669
+#: gitk:1807
 msgid "Preferences"
 msgstr "Preferencias"
=20
-#: gitk:672 gitk:1892
+#: gitk:1810 gitk:3193
 msgid "View"
 msgstr "Vista"
=20
-#: gitk:673
+#: gitk:1811
 msgid "New view..."
 msgstr "Nueva vista..."
=20
-#: gitk:674 gitk:2133 gitk:8722
+#: gitk:1812
 msgid "Edit view..."
 msgstr "Modificar vista..."
=20
-#: gitk:676 gitk:2134 gitk:8723
+#: gitk:1814
 msgid "Delete view"
 msgstr "Eliminar vista"
=20
-#: gitk:678
+#: gitk:1816
 msgid "All files"
 msgstr "Todos los archivos"
=20
-#: gitk:682
+#: gitk:1820
 msgid "Help"
 msgstr "Ayuda"
=20
-#: gitk:683 gitk:1317
+#: gitk:1821 gitk:2484
 msgid "About gitk"
 msgstr "Acerca de gitk"
=20
-#: gitk:684
+#: gitk:1822
 msgid "Key bindings"
 msgstr "Combinaciones de teclas"
=20
-#: gitk:741
+#: gitk:1879
 msgid "SHA1 ID: "
 msgstr "SHA1 ID: "
=20
-#: gitk:791
+#: gitk:1910
+msgid "Row"
+msgstr ""
+
+#: gitk:1941
 msgid "Find"
 msgstr "Buscar"
=20
-#: gitk:792
+#: gitk:1942
 msgid "next"
 msgstr "<<"
=20
-#: gitk:793
+#: gitk:1943
 msgid "prev"
 msgstr ">>"
=20
-#: gitk:794
+#: gitk:1944
 msgid "commit"
 msgstr "revisi=C3=B3n"
=20
-#: gitk:797 gitk:799 gitk:2356 gitk:2379 gitk:2403 gitk:4306 gitk:4369
+#: gitk:1947 gitk:1949 gitk:3614 gitk:3637 gitk:3661 gitk:5547 gitk:56=
18
 msgid "containing:"
 msgstr "que contiene:"
=20
-#: gitk:800 gitk:1778 gitk:1783 gitk:2431
+#: gitk:1950 gitk:2951 gitk:2956 gitk:3689
 msgid "touching paths:"
 msgstr "que modifica la ruta:"
=20
-#: gitk:801 gitk:2436
+#: gitk:1951 gitk:3694
 msgid "adding/removing string:"
 msgstr "que a=C3=B1ade/elimina cadena:"
=20
-#: gitk:810 gitk:812
+#: gitk:1960 gitk:1962
 msgid "Exact"
 msgstr "Exacto"
=20
-#: gitk:812 gitk:2514 gitk:4274
+#: gitk:1962 gitk:3770 gitk:5515
 msgid "IgnCase"
 msgstr "NoMay=C3=BAs"
=20
-#: gitk:812 gitk:2405 gitk:2512 gitk:4270
+#: gitk:1962 gitk:3663 gitk:3768 gitk:5511
 msgid "Regexp"
 msgstr "Regex"
=20
-#: gitk:814 gitk:815 gitk:2533 gitk:2563 gitk:2570 gitk:4380 gitk:4436
+#: gitk:1964 gitk:1965 gitk:3789 gitk:3819 gitk:3826 gitk:5638 gitk:57=
05
 msgid "All fields"
 msgstr "Todos los campos"
=20
-#: gitk:815 gitk:2531 gitk:2563 gitk:4336
+#: gitk:1965 gitk:3787 gitk:3819 gitk:5577
 msgid "Headline"
 msgstr "T=C3=ADtulo"
=20
-#: gitk:816 gitk:2531 gitk:4336 gitk:4436 gitk:4827
+#: gitk:1966 gitk:3787 gitk:5577 gitk:5705 gitk:6106
 msgid "Comments"
 msgstr "Comentarios"
=20
-#: gitk:816 gitk:2531 gitk:2535 gitk:2570 gitk:4336 gitk:4763 gitk:595=
6
-#: gitk:5971
+#: gitk:1966 gitk:3787 gitk:3791 gitk:3826 gitk:5577 gitk:6042 gitk:72=
49
+#: gitk:7264
 msgid "Author"
 msgstr "Autor"
=20
-#: gitk:816 gitk:2531 gitk:4336 gitk:4765
+#: gitk:1966 gitk:3787 gitk:5577 gitk:6044
 msgid "Committer"
 msgstr ""
=20
-#: gitk:845
+#: gitk:1995
 msgid "Search"
 msgstr "Buscar"
=20
-#: gitk:852
+#: gitk:2002
 msgid "Diff"
 msgstr "Diferencia"
=20
-#: gitk:854
+#: gitk:2004
 msgid "Old version"
 msgstr "Versi=C3=B3n antigua"
=20
-#: gitk:856
+#: gitk:2006
 msgid "New version"
 msgstr "Versi=C3=B3n nueva"
=20
-#: gitk:858
+#: gitk:2008
 msgid "Lines of context"
 msgstr "L=C3=ADneas de contexto"
=20
-#: gitk:868
+#: gitk:2018
 msgid "Ignore space change"
 msgstr "Ignora cambios de espaciado"
=20
-#: gitk:926
+#: gitk:2076
 msgid "Patch"
 msgstr "Parche"
=20
-#: gitk:928
+#: gitk:2078
 msgid "Tree"
 msgstr "=C3=81rbol"
=20
-#: gitk:1053 gitk:1068 gitk:6022
+#: gitk:2204 gitk:2219
 msgid "Diff this -> selected"
 msgstr "Diferencia de esta -> seleccionada"
=20
-#: gitk:1055 gitk:1070 gitk:6023
+#: gitk:2206 gitk:2221
 msgid "Diff selected -> this"
 msgstr "Diferencia de seleccionada -> esta"
=20
-#: gitk:1057 gitk:1072 gitk:6024
+#: gitk:2208 gitk:2223
 msgid "Make patch"
 msgstr "Crear patch"
=20
-#: gitk:1058 gitk:6162
+#: gitk:2209 gitk:7458
 msgid "Create tag"
 msgstr "Crear etiqueta"
=20
-#: gitk:1059 gitk:6255
+#: gitk:2210 gitk:7557
 msgid "Write commit to file"
 msgstr "Escribir revisiones a archivo"
=20
-#: gitk:1060 gitk:6309
+#: gitk:2211 gitk:7611
 msgid "Create new branch"
 msgstr "Crear nueva rama"
=20
-#: gitk:1061
+#: gitk:2212
 msgid "Cherry-pick this commit"
 msgstr "A=C3=B1adir esta revisi=C3=B3n a la rama actual (cherry-pick)"
=20
-#: gitk:1063
+#: gitk:2214
 msgid "Reset HEAD branch to here"
 msgstr "Traer la rama HEAD aqu=C3=AD"
=20
-#: gitk:1079
+#: gitk:2230
 msgid "Check out this branch"
 msgstr "Cambiar a esta rama"
=20
-#: gitk:1081
+#: gitk:2232
 msgid "Remove this branch"
 msgstr "Eliminar esta rama"
=20
-#: gitk:1087
+#: gitk:2238
 msgid "Highlight this too"
 msgstr "Seleccionar tambi=C3=A9n"
=20
-#: gitk:1089
+#: gitk:2240
 msgid "Highlight this only"
 msgstr "Seleccionar s=C3=B3lo"
=20
-#: gitk:1318
+#: gitk:2242
+msgid "External diff"
+msgstr ""
+
+#: gitk:2244
+msgid "Blame parent commit"
+msgstr ""
+
+#: gitk:2485
+#, fuzzy
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
-"Copyright =C2=A9 2005-2006 Paul Mackerras\n"
+"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public Licens=
e"
 msgstr ""
@@ -268,424 +305,434 @@ msgstr ""
 "\n"
 "Copyright =C2=A9 2005-2006 Paul Mackerras\n"
 "\n"
-"Uso y redistribuci=C3=B3n permitidos seg=C3=BAn los t=C3=A9rminos de =
la Licencia P=C3=BAblica General de "
-"GNU (GNU GPL)"
+"Uso y redistribuci=C3=B3n permitidos seg=C3=BAn los t=C3=A9rminos de =
la Licencia P=C3=BAblica "
+"General de GNU (GNU GPL)"
=20
-#: gitk:1326 gitk:1387 gitk:6581
+#: gitk:2493 gitk:2554 gitk:7906
 msgid "Close"
 msgstr "Cerrar"
=20
-#: gitk:1345
+#: gitk:2512
 msgid "Gitk key bindings"
 msgstr "Combinaciones de tecla de Gitk"
=20
-#: gitk:1347
+#: gitk:2514
 msgid "Gitk key bindings:"
 msgstr "Combinaciones de tecla de Gitk:"
=20
-#: gitk:1349
+#: gitk:2516
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tSalir"
=20
-#: gitk:1350
+#: gitk:2517
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Home>\t\tIr a la primera revisi=C3=B3n"
=20
-#: gitk:1351
+#: gitk:2518
 msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\tIr a la =C3=BAltima revisi=C3=B3n"
=20
-#: gitk:1352
+#: gitk:2519
 msgid "<Up>, p, i\tMove up one commit"
 msgstr "<Up>, p, i\tSubir una revisi=C3=B3n"
=20
-#: gitk:1353
+#: gitk:2520
 msgid "<Down>, n, k\tMove down one commit"
 msgstr "<Down>, n, k\tBajar una revisi=C3=B3n"
=20
-#: gitk:1354
+#: gitk:2521
 msgid "<Left>, z, j\tGo back in history list"
 msgstr "<Left>, z, j\tRetroceder en la historia"
=20
-#: gitk:1355
+#: gitk:2522
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Right>, x, l\tAvanzar en la historia"
=20
-#: gitk:1356
+#: gitk:2523
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<PageUp>\tSubir una p=C3=A1gina en la lista de revisiones"
=20
-#: gitk:1357
+#: gitk:2524
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<PageDown>\tBajar una p=C3=A1gina en la lista de revisiones"
=20
-#: gitk:1358
+#: gitk:2525
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Home>\tDesplazarse al inicio de la lista de revisiones"
=20
-#: gitk:1359
+#: gitk:2526
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-End>\tDesplazarse al final de la lista de revisiones"
=20
-#: gitk:1360
+#: gitk:2527
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Up>\tDesplazar una l=C3=ADnea hacia arriba la lista de rev=
isiones"
=20
-#: gitk:1361
+#: gitk:2528
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Down>\tDesplazar una l=C3=ADnea hacia abajo la lista de re=
visiones"
=20
-#: gitk:1362
+#: gitk:2529
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-PageUp>\tDesplazar una p=C3=A1gina hacia arriba la lista d=
e revisiones"
=20
-#: gitk:1363
+#: gitk:2530
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-PageDown>\tDesplazar una p=C3=A1gina hacia abajo la lista =
de revisiones"
=20
-#: gitk:1364
+#: gitk:2531
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Shift-Up>\tBuscar hacia atr=C3=A1s (arriba, revisiones siguie=
ntes)"
=20
-#: gitk:1365
+#: gitk:2532
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr "<Shift-Down>\tBuscar hacia adelante (abajo, revisiones anterio=
res)"
=20
-#: gitk:1366
+#: gitk:2533
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Delete>, b\tDesplaza hacia arriba una p=C3=A1gina la vista de=
 diferencias"
=20
-#: gitk:1367
+#: gitk:2534
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<Backspace>\tDesplaza hacia arriba una p=C3=A1gina la vista de=
 diferencias"
=20
-#: gitk:1368
+#: gitk:2535
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Space>\t\tDesplaza hacia abajo una p=C3=A1gina la vista de di=
ferencias"
=20
-#: gitk:1369
+#: gitk:2536
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\tDesplaza hacia arriba 18 l=C3=ADneas la vista de diferenc=
ias"
=20
-#: gitk:1370
+#: gitk:2537
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\tDesplaza hacia abajo 18 l=C3=ADneas la vista de diferenci=
as"
=20
-#: gitk:1371
+#: gitk:2538
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tBuscar"
=20
-#: gitk:1372
+#: gitk:2539
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tBuscar el siguiente"
=20
-#: gitk:1373
+#: gitk:2540
 msgid "<Return>\tMove to next find hit"
 msgstr "<Return>\tBuscar el siguiente"
=20
-#: gitk:1374
+#: gitk:2541
 msgid "/\t\tMove to next find hit, or redo find"
 msgstr "/\t\tBuscar el siguiente, o reiniciar la b=C3=BAsqueda"
=20
-#: gitk:1375
+#: gitk:2542
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tBuscar el anterior"
=20
-#: gitk:1376
+#: gitk:2543
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tDesplazar la vista de diferencias al archivo siguiente"
=20
-#: gitk:1377
+#: gitk:2544
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tBuscar siguiente en la vista de diferencias"
=20
-#: gitk:1378
+#: gitk:2545
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tBuscar anterior en la vista de diferencias"
=20
-#: gitk:1379
+#: gitk:2546
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-KP+>\tAumentar tama=C3=B1o del texto"
=20
-#: gitk:1380
+#: gitk:2547
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-plus>\tAumentar tama=C3=B1o del texto"
=20
-#: gitk:1381
+#: gitk:2548
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-KP->\tDisminuir tama=C3=B1o del texto"
=20
-#: gitk:1382
+#: gitk:2549
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-minus>\tDisminuir tama=C3=B1o del texto"
=20
-#: gitk:1383
+#: gitk:2550
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tActualizar"
=20
-#: gitk:1896
+#: gitk:3065
+#, fuzzy
+msgid "No such commit"
+msgstr "No se han guardado cambios"
+
+#: gitk:3197
 msgid "Gitk view definition"
 msgstr "Definici=C3=B3n de vistas de Gitk"
=20
-#: gitk:1921
+#: gitk:3222
 msgid "Name"
 msgstr "Nombre"
=20
-#: gitk:1924
+#: gitk:3225
 msgid "Remember this view"
 msgstr "Recordar esta vista"
=20
-#: gitk:1928
-msgid "Commits to include (arguments to git rev-list):"
+#: gitk:3229
+#, fuzzy
+msgid "Commits to include (arguments to git log):"
 msgstr "Revisiones a incluir (argumentos a git rev-list):"
=20
-#: gitk:1935
+#: gitk:3236
 msgid "Command to generate more commits to include:"
 msgstr "Comando que genera m=C3=A1s revisiones a incluir:"
=20
-#: gitk:1942
+#: gitk:3243
 msgid "Enter files and directories to include, one per line:"
 msgstr "Introducir archivos y directorios a incluir, uno por l=C3=ADne=
a:"
=20
-#: gitk:1989
+#: gitk:3290
 msgid "Error in commit selection arguments:"
 msgstr "Error en los argumentos de selecci=C3=B3n de las revisiones:"
=20
-#: gitk:2043 gitk:2127 gitk:2583 gitk:2597 gitk:3781 gitk:8688 gitk:86=
89
+#: gitk:3344 gitk:3396 gitk:3839 gitk:3853 gitk:5057 gitk:10013 gitk:1=
0014
 msgid "None"
 msgstr "Ninguno"
=20
-#: gitk:2531 gitk:4336 gitk:5958 gitk:5973
+#: gitk:3787 gitk:5577 gitk:7251 gitk:7266
 msgid "Date"
 msgstr "Fecha"
=20
-#: gitk:2531 gitk:4336
+#: gitk:3787 gitk:5577
 msgid "CDate"
 msgstr "Fecha de creaci=C3=B3n"
=20
-#: gitk:2680 gitk:2685
+#: gitk:3936 gitk:3941
 msgid "Descendant"
 msgstr "Descendiente"
=20
-#: gitk:2681
+#: gitk:3937
 msgid "Not descendant"
 msgstr "No descendiente"
=20
-#: gitk:2688 gitk:2693
+#: gitk:3944 gitk:3949
 msgid "Ancestor"
 msgstr "Antepasado"
=20
-#: gitk:2689
+#: gitk:3945
 msgid "Not ancestor"
 msgstr "No antepasado"
=20
-#: gitk:2924
+#: gitk:4184
 msgid "Local changes checked in to index but not committed"
 msgstr "Cambios locales a=C3=B1adidos al =C3=ADndice pero sin completa=
r revisi=C3=B3n"
=20
-#: gitk:2954
+#: gitk:4217
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Cambios locales sin a=C3=B1adir al =C3=ADndice"
=20
-#: gitk:4305
+#: gitk:5546
 msgid "Searching"
 msgstr "Buscando"
=20
-#: gitk:4767
+#: gitk:6046
 msgid "Tags:"
 msgstr "Etiquetas:"
=20
-#: gitk:4784 gitk:4790 gitk:5951
+#: gitk:6063 gitk:6069 gitk:7244
 msgid "Parent"
 msgstr "Padre"
=20
-#: gitk:4795
+#: gitk:6074
 msgid "Child"
 msgstr "Hija"
=20
-#: gitk:4804
+#: gitk:6083
 msgid "Branch"
 msgstr "Rama"
=20
-#: gitk:4807
+#: gitk:6086
 msgid "Follows"
 msgstr "Sigue-a"
=20
-#: gitk:4810
+#: gitk:6089
 msgid "Precedes"
 msgstr "Precede-a"
=20
-#: gitk:5093
+#: gitk:6373
 msgid "Error getting merge diffs:"
 msgstr "Error al leer las diferencias de fusi=C3=B3n:"
=20
-#: gitk:5778
+#: gitk:7077
 msgid "Goto:"
 msgstr "Ir a:"
=20
-#: gitk:5780
+#: gitk:7079
 msgid "SHA1 ID:"
 msgstr "SHA1 ID:"
=20
-#: gitk:5805
+#: gitk:7098
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "La id SHA1 abreviada %s es ambigua"
=20
-#: gitk:5817
+#: gitk:7110
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "La id SHA1 %s es desconocida"
=20
-#: gitk:5819
+#: gitk:7112
 #, tcl-format
 msgid "Tag/Head %s is not known"
 msgstr "La etiqueta/rama %s es deconocida"
=20
-#: gitk:5961
+#: gitk:7254
 msgid "Children"
 msgstr "Hijas"
=20
-#: gitk:6018
+#: gitk:7311
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Poner la rama %s en esta revisi=C3=B3n"
=20
-#: gitk:6049
+#: gitk:7313
+msgid "Detached head: can't reset"
+msgstr ""
+
+#: gitk:7345
 msgid "Top"
 msgstr "Origen"
=20
-#: gitk:6050
+#: gitk:7346
 msgid "From"
 msgstr "De"
=20
-#: gitk:6055
+#: gitk:7351
 msgid "To"
 msgstr "A"
=20
-#: gitk:6078
+#: gitk:7374
 msgid "Generate patch"
 msgstr "Generar parche"
=20
-#: gitk:6080
+#: gitk:7376
 msgid "From:"
 msgstr "De:"
=20
-#: gitk:6089
+#: gitk:7385
 msgid "To:"
 msgstr "Para:"
=20
-#: gitk:6098
+#: gitk:7394
 msgid "Reverse"
 msgstr "Invertir"
=20
-#: gitk:6100 gitk:6269
+#: gitk:7396 gitk:7571
 msgid "Output file:"
 msgstr "Escribir a archivo:"
=20
-#: gitk:6106
+#: gitk:7402
 msgid "Generate"
 msgstr "Generar"
=20
-#: gitk:6142
+#: gitk:7438
 msgid "Error creating patch:"
 msgstr "Error en la creaci=C3=B3n del parche:"
=20
-#: gitk:6164 gitk:6257 gitk:6311
+#: gitk:7460 gitk:7559 gitk:7613
 msgid "ID:"
 msgstr "ID:"
=20
-#: gitk:6173
+#: gitk:7469
 msgid "Tag name:"
 msgstr "Nombre de etiqueta:"
=20
-#: gitk:6177 gitk:6320
+#: gitk:7473 gitk:7622
 msgid "Create"
 msgstr "Crear"
=20
-#: gitk:6192
+#: gitk:7488
 msgid "No tag name specified"
 msgstr "No se ha especificado etiqueta"
=20
-#: gitk:6196
+#: gitk:7492
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "La etiqueta \"%s\" ya existe"
=20
-#: gitk:6202
+#: gitk:7498
 msgid "Error creating tag:"
 msgstr "Error al crear la etiqueta:"
=20
-#: gitk:6266
+#: gitk:7568
 msgid "Command:"
 msgstr "Comando:"
=20
-#: gitk:6274
+#: gitk:7576
 msgid "Write"
 msgstr "Escribir"
=20
-#: gitk:6290
+#: gitk:7592
 msgid "Error writing commit:"
 msgstr "Error al escribir revisi=C3=B3n:"
=20
-#: gitk:6316
+#: gitk:7618
 msgid "Name:"
 msgstr "Nombre:"
=20
-#: gitk:6335
+#: gitk:7637
 msgid "Please specify a name for the new branch"
 msgstr "Especifique un nombre para la nueva rama"
=20
-#: gitk:6364
+#: gitk:7666
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
 msgstr "La revisi=C3=B3n %s ya est=C3=A1 incluida en la rama %s -- =C2=
=BFVolver a aplicarla?"
=20
-#: gitk:6369
+#: gitk:7671
 msgid "Cherry-picking"
 msgstr "Eligiendo revisiones (cherry-picking)"
=20
-#: gitk:6381
+#: gitk:7683
 msgid "No changes committed"
 msgstr "No se han guardado cambios"
=20
-#: gitk:6404
+#: gitk:7708
 msgid "Confirm reset"
 msgstr "Confirmar git reset"
=20
-#: gitk:6406
+#: gitk:7710
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "=C2=BFReponer la rama %s a %s?"
=20
-#: gitk:6410
+#: gitk:7714
 msgid "Reset type:"
 msgstr "Tipo de reposici=C3=B3n:"
=20
-#: gitk:6414
+#: gitk:7718
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Suave: No altera la copia de trabajo ni el =C3=ADndice"
=20
-#: gitk:6417
+#: gitk:7721
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr "Mixta: Actualiza el =C3=ADndice, no altera la copia de trabajo=
"
=20
-#: gitk:6420
+#: gitk:7724
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -693,19 +740,19 @@ msgstr ""
 "Dura: Actualiza el =C3=ADndice y la copia de trabajo\n"
 "(abandona TODAS las modificaciones locales)"
=20
-#: gitk:6436
+#: gitk:7740
 msgid "Resetting"
 msgstr "Reponiendo"
=20
-#: gitk:6493
+#: gitk:7797
 msgid "Checking out"
 msgstr "Creando copia de trabajo"
=20
-#: gitk:6523
+#: gitk:7848
 msgid "Cannot delete the currently checked-out branch"
 msgstr "No se puede borrar la rama actual"
=20
-#: gitk:6529
+#: gitk:7854
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -714,134 +761,142 @@ msgstr ""
 "Las revisiones de la rama %s no est=C3=A1n presentes en otras ramas.\=
n"
 "=C2=BFBorrar la rama %s?"
=20
-#: gitk:6560
+#: gitk:7885
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Etiquetas y ramas: %s"
=20
-#: gitk:6574
+#: gitk:7899
 msgid "Filter"
 msgstr "Filtro"
=20
-#: gitk:6868
+#: gitk:8193
 msgid ""
 "Error reading commit topology information; branch and preceding/follo=
wing "
 "tag information will be incomplete."
 msgstr ""
-"Error al leer la topolog=C3=ADa de revisiones: la informaci=C3=B3n so=
bre "
-"las ramas y etiquetas precedentes y siguientes ser=C3=A1 incompleta."
+"Error al leer la topolog=C3=ADa de revisiones: la informaci=C3=B3n so=
bre las ramas y "
+"etiquetas precedentes y siguientes ser=C3=A1 incompleta."
=20
-#: gitk:7852
+#: gitk:9179
 msgid "Tag"
 msgstr "Etiqueta"
=20
-#: gitk:7852
+#: gitk:9179
 msgid "Id"
 msgstr "Id"
=20
-#: gitk:7892
+#: gitk:9225
 msgid "Gitk font chooser"
 msgstr "Selector de tipograf=C3=ADas gitk"
=20
-#: gitk:7909
+#: gitk:9242
 msgid "B"
 msgstr "B"
=20
-#: gitk:7912
+#: gitk:9245
 msgid "I"
 msgstr "I"
=20
-#: gitk:8005
+#: gitk:9338
 msgid "Gitk preferences"
 msgstr "Preferencias de gitk"
=20
-#: gitk:8006
+#: gitk:9339
 msgid "Commit list display options"
 msgstr "Opciones de visualizaci=C3=B3n de la lista de revisiones"
=20
-#: gitk:8009
+#: gitk:9342
 msgid "Maximum graph width (lines)"
 msgstr "Ancho m=C3=A1ximo del gr=C3=A1fico (en l=C3=ADneas)"
=20
-#: gitk:8013
+#: gitk:9346
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Ancho m=C3=A1ximo del gr=C3=A1fico (en % del panel)"
=20
-#: gitk:8018
+#: gitk:9351
 msgid "Show local changes"
 msgstr "Mostrar cambios locales"
=20
-#: gitk:8023
+#: gitk:9356
 msgid "Auto-select SHA1"
 msgstr "Seleccionar autom=C3=A1ticamente SHA1 hash"
=20
-#: gitk:8028
+#: gitk:9361
 msgid "Diff display options"
 msgstr "Opciones de visualizaci=C3=B3n de diferencias"
=20
-#: gitk:8030
+#: gitk:9363
 msgid "Tab spacing"
 msgstr "Espaciado de tabulador"
=20
-#: gitk:8034
+#: gitk:9367
 msgid "Display nearby tags"
 msgstr "Mostrar etiquetas cercanas"
=20
-#: gitk:8039
+#: gitk:9372
 msgid "Limit diffs to listed paths"
 msgstr "Limitar las diferencias a las rutas seleccionadas"
=20
-#: gitk:8044
+#: gitk:9379
+msgid "External diff tool"
+msgstr ""
+
+#: gitk:9381
+msgid "Choose..."
+msgstr ""
+
+#: gitk:9386
 msgid "Colors: press to choose"
 msgstr "Colores: pulse para seleccionar"
=20
-#: gitk:8047
+#: gitk:9389
 msgid "Background"
 msgstr "Fondo"
=20
-#: gitk:8051
+#: gitk:9393
 msgid "Foreground"
 msgstr "Primer plano"
=20
-#: gitk:8055
+#: gitk:9397
 msgid "Diff: old lines"
 msgstr "Diff: l=C3=ADneas viejas"
=20
-#: gitk:8060
+#: gitk:9402
 msgid "Diff: new lines"
 msgstr "Diff: l=C3=ADneas nuevas"
=20
-#: gitk:8065
+#: gitk:9407
 msgid "Diff: hunk header"
 msgstr "Diff: cabecera de fragmento"
=20
-#: gitk:8071
+#: gitk:9413
 msgid "Select bg"
 msgstr "Color de fondo de la selecci=C3=B3n"
=20
-#: gitk:8075
+#: gitk:9417
 msgid "Fonts: press to choose"
 msgstr "Tipograf=C3=ADas: pulse para elegir"
=20
-#: gitk:8077
+#: gitk:9419
 msgid "Main font"
 msgstr "Tipograf=C3=ADa principal"
=20
-#: gitk:8078
+#: gitk:9420
 msgid "Diff display font"
 msgstr "Tipograf=C3=ADa para diferencias"
=20
-#: gitk:8079
+#: gitk:9421
 msgid "User interface font"
 msgstr "Tipograf=C3=ADa para interfaz de usuario"
=20
-#: gitk:8095
+#: gitk:9446
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: elegir color para %s"
=20
-#: gitk:8476
+#: gitk:9827
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
@@ -849,42 +904,25 @@ msgstr ""
 "Esta versi=C3=B3n de Tcl/Tk es demasiado antigua.\n"
 " Gitk requiere Tcl/Tk versi=C3=B3n 8.4 o superior."
=20
-#: gitk:8565
+#: gitk:9919
 msgid "Cannot find a git repository here."
 msgstr "No hay un repositorio git aqu=C3=AD."
=20
-#: gitk:8569
+#: gitk:9923
 #, tcl-format
 msgid "Cannot find the git directory \"%s\"."
 msgstr "No hay directorio git \"%s\"."
=20
-#: gitk:8612
+#: gitk:9970
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
-msgstr "Argumento ambiguo: '%s' es tanto una revisi=C3=B3n como un nom=
bre de archivo"
+msgstr ""
+"Argumento ambiguo: '%s' es tanto una revisi=C3=B3n como un nombre de =
archivo"
=20
-#: gitk:8624
+#: gitk:9982
 msgid "Bad arguments to gitk:"
 msgstr "Argumentos incorrectos a Gitk:"
=20
-#: gitk:8636
-msgid "Couldn't get list of unmerged files:"
-msgstr "Imposible obtener la lista de archivos pendientes de fusi=C3=B3=
n:"
-
-#: gitk:8652
-msgid "No files selected: --merge specified but no files are unmerged.=
"
-msgstr ""
-"No hay archivos seleccionados: se seleccion=C3=B3 la opci=C3=B3n --me=
rge pero no hay "
-"archivos pendientes de fusi=C3=B3n."
-
-#: gitk:8655
-msgid ""
-"No files selected: --merge specified but no unmerged files are within=
 file "
-"limit."
-msgstr ""
-"No hay archivos seleccionados: se seleccion=C3=B3 la opci=C3=B3n --me=
rge pero los archivos "
-"especificados no necesitan fusi=C3=B3n."
-
-#: gitk:8716
+#: gitk:10042
 msgid "Command line"
 msgstr "L=C3=ADnea de comandos"
diff --git a/po/it.po b/po/it.po
index d0f4c2e..15efe29 100644
--- a/po/it.po
+++ b/po/it.po
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: gitk\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-03-13 17:29+0100\n"
+"POT-Creation-Date: 2008-10-07 23:06+0200\n"
 "PO-Revision-Date: 2008-03-13 17:34+0100\n"
 "Last-Translator: Michele Ballabio <barra_cuda@katamail.com>\n"
 "Language-Team: Italian\n"
@@ -16,250 +16,287 @@ msgstr ""
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: gitk:111
-msgid "Error executing git rev-list:"
+#: gitk:113
+msgid "Couldn't get list of unmerged files:"
+msgstr "Impossibile ottenere l'elenco dei file in attesa di fusione:"
+
+#: gitk:340
+msgid "No files selected: --merge specified but no files are unmerged.=
"
+msgstr ""
+"Nessun file selezionato: =C3=A8 stata specificata l'opzione --merge m=
a non ci "
+"sono file in attesa di fusione."
+
+#: gitk:343
+msgid ""
+"No files selected: --merge specified but no unmerged files are within=
 file "
+"limit."
+msgstr ""
+"Nessun file selezionato: =C3=A8 stata specificata l'opzione --merge m=
a i file "
+"specificati non sono in attesa di fusione."
+
+#: gitk:365
+#, fuzzy
+msgid "Error executing git log:"
 msgstr "Errore nell'esecuzione di git rev-list:"
=20
-#: gitk:124
+#: gitk:378
 msgid "Reading"
 msgstr "Lettura in corso"
=20
-#: gitk:151 gitk:2191
+#: gitk:438 gitk:3459
 msgid "Reading commits..."
 msgstr "Lettura delle revisioni in corso..."
=20
-#: gitk:275
-msgid "Can't parse git log output:"
-msgstr "Impossibile elaborare i dati di git log:"
-
-#: gitk:386 gitk:2195
+#: gitk:441 gitk:1528 gitk:3462
 msgid "No commits selected"
 msgstr "Nessuna revisione selezionata"
=20
-#: gitk:500
+#: gitk:1399
+msgid "Can't parse git log output:"
+msgstr "Impossibile elaborare i dati di git log:"
+
+#: gitk:1605
 msgid "No commit information available"
 msgstr "Nessuna informazione disponibile sulle revisioni"
=20
-#: gitk:599 gitk:621 gitk:1955 gitk:6423 gitk:7923 gitk:8082
+#: gitk:1709 gitk:1731 gitk:3256 gitk:7727 gitk:9256 gitk:9424
 msgid "OK"
 msgstr "OK"
=20
-#: gitk:623 gitk:1956 gitk:6107 gitk:6178 gitk:6275 gitk:6321 gitk:642=
5
-#: gitk:7924 gitk:8083
+#: gitk:1733 gitk:3257 gitk:7403 gitk:7474 gitk:7577 gitk:7623 gitk:77=
29
+#: gitk:9257 gitk:9425
 msgid "Cancel"
 msgstr "Annulla"
=20
-#: gitk:661
+#: gitk:1798
 msgid "File"
 msgstr "File"
=20
-#: gitk:663
+#: gitk:1800
 msgid "Update"
 msgstr "Aggiorna"
=20
-#: gitk:664
+#: gitk:1801
+#, fuzzy
+msgid "Reload"
+msgstr "Lettura in corso"
+
+#: gitk:1802
 msgid "Reread references"
 msgstr "Rileggi riferimenti"
=20
-#: gitk:665
+#: gitk:1803
 msgid "List references"
 msgstr "Elenca riferimenti"
=20
-#: gitk:666
+#: gitk:1804
 msgid "Quit"
 msgstr "Esci"
=20
-#: gitk:668
+#: gitk:1806
 msgid "Edit"
 msgstr "Modifica"
=20
-#: gitk:669
+#: gitk:1807
 msgid "Preferences"
 msgstr "Preferenze"
=20
-#: gitk:672 gitk:1892
+#: gitk:1810 gitk:3193
 msgid "View"
 msgstr "Vista"
=20
-#: gitk:673
+#: gitk:1811
 msgid "New view..."
 msgstr "Nuova vista..."
=20
-#: gitk:674 gitk:2133 gitk:8722
+#: gitk:1812
 msgid "Edit view..."
 msgstr "Modifica vista..."
=20
-#: gitk:676 gitk:2134 gitk:8723
+#: gitk:1814
 msgid "Delete view"
 msgstr "Elimina vista"
=20
-#: gitk:678
+#: gitk:1816
 msgid "All files"
 msgstr "Tutti i file"
=20
-#: gitk:682
+#: gitk:1820
 msgid "Help"
 msgstr "Aiuto"
=20
-#: gitk:683 gitk:1317
+#: gitk:1821 gitk:2484
 msgid "About gitk"
 msgstr "Informazioni su gitk"
=20
-#: gitk:684
+#: gitk:1822
 msgid "Key bindings"
 msgstr "Scorciatoie da tastiera"
=20
-#: gitk:741
+#: gitk:1879
 msgid "SHA1 ID: "
 msgstr "SHA1 ID: "
=20
-#: gitk:791
+#: gitk:1910
+msgid "Row"
+msgstr ""
+
+#: gitk:1941
 msgid "Find"
 msgstr "Trova"
=20
-#: gitk:792
+#: gitk:1942
 msgid "next"
 msgstr "succ"
=20
-#: gitk:793
+#: gitk:1943
 msgid "prev"
 msgstr "prec"
=20
-#: gitk:794
+#: gitk:1944
 msgid "commit"
 msgstr "revisione"
=20
-#: gitk:797 gitk:799 gitk:2356 gitk:2379 gitk:2403 gitk:4306 gitk:4369
+#: gitk:1947 gitk:1949 gitk:3614 gitk:3637 gitk:3661 gitk:5547 gitk:56=
18
 msgid "containing:"
 msgstr "contenente:"
=20
-#: gitk:800 gitk:1778 gitk:1783 gitk:2431
+#: gitk:1950 gitk:2951 gitk:2956 gitk:3689
 msgid "touching paths:"
 msgstr "che riguarda i percorsi:"
=20
-#: gitk:801 gitk:2436
+#: gitk:1951 gitk:3694
 msgid "adding/removing string:"
 msgstr "che aggiunge/rimuove la stringa:"
=20
-#: gitk:810 gitk:812
+#: gitk:1960 gitk:1962
 msgid "Exact"
 msgstr "Esatto"
=20
-#: gitk:812 gitk:2514 gitk:4274
+#: gitk:1962 gitk:3770 gitk:5515
 msgid "IgnCase"
 msgstr ""
=20
-#: gitk:812 gitk:2405 gitk:2512 gitk:4270
+#: gitk:1962 gitk:3663 gitk:3768 gitk:5511
 msgid "Regexp"
 msgstr ""
=20
-#: gitk:814 gitk:815 gitk:2533 gitk:2563 gitk:2570 gitk:4380 gitk:4436
+#: gitk:1964 gitk:1965 gitk:3789 gitk:3819 gitk:3826 gitk:5638 gitk:57=
05
 msgid "All fields"
 msgstr "Tutti i campi"
=20
-#: gitk:815 gitk:2531 gitk:2563 gitk:4336
+#: gitk:1965 gitk:3787 gitk:3819 gitk:5577
 msgid "Headline"
 msgstr "Titolo"
=20
-#: gitk:816 gitk:2531 gitk:4336 gitk:4436 gitk:4827
+#: gitk:1966 gitk:3787 gitk:5577 gitk:5705 gitk:6106
 msgid "Comments"
 msgstr "Commenti"
=20
-#: gitk:816 gitk:2531 gitk:2535 gitk:2570 gitk:4336 gitk:4763 gitk:595=
6
-#: gitk:5971
+#: gitk:1966 gitk:3787 gitk:3791 gitk:3826 gitk:5577 gitk:6042 gitk:72=
49
+#: gitk:7264
 msgid "Author"
 msgstr "Autore"
=20
-#: gitk:816 gitk:2531 gitk:4336 gitk:4765
+#: gitk:1966 gitk:3787 gitk:5577 gitk:6044
 msgid "Committer"
 msgstr "Revisione creata da"
=20
-#: gitk:845
+#: gitk:1995
 msgid "Search"
 msgstr "Cerca"
=20
-#: gitk:852
+#: gitk:2002
 msgid "Diff"
 msgstr ""
=20
-#: gitk:854
+#: gitk:2004
 msgid "Old version"
 msgstr "Vecchia versione"
=20
-#: gitk:856
+#: gitk:2006
 msgid "New version"
 msgstr "Nuova versione"
=20
-#: gitk:858
+#: gitk:2008
 msgid "Lines of context"
 msgstr "Linee di contesto"
=20
-#: gitk:868
+#: gitk:2018
 msgid "Ignore space change"
 msgstr "Ignora modifiche agli spazi"
=20
-#: gitk:926
+#: gitk:2076
 msgid "Patch"
 msgstr "Modifiche"
=20
-#: gitk:928
+#: gitk:2078
 msgid "Tree"
 msgstr "Directory"
=20
-#: gitk:1053 gitk:1068 gitk:6022
+#: gitk:2204 gitk:2219
 msgid "Diff this -> selected"
 msgstr "Diff questo -> selezionato"
=20
-#: gitk:1055 gitk:1070 gitk:6023
+#: gitk:2206 gitk:2221
 msgid "Diff selected -> this"
 msgstr "Diff selezionato -> questo"
=20
-#: gitk:1057 gitk:1072 gitk:6024
+#: gitk:2208 gitk:2223
 msgid "Make patch"
 msgstr "Crea patch"
=20
-#: gitk:1058 gitk:6162
+#: gitk:2209 gitk:7458
 msgid "Create tag"
 msgstr "Crea etichetta"
=20
-#: gitk:1059 gitk:6255
+#: gitk:2210 gitk:7557
 msgid "Write commit to file"
 msgstr "Scrivi revisione in un file"
=20
-#: gitk:1060 gitk:6309
+#: gitk:2211 gitk:7611
 msgid "Create new branch"
 msgstr "Crea un nuovo ramo"
=20
-#: gitk:1061
+#: gitk:2212
 msgid "Cherry-pick this commit"
 msgstr "Porta questa revisione in cima al ramo attuale"
=20
-#: gitk:1063
+#: gitk:2214
 msgid "Reset HEAD branch to here"
 msgstr "Aggiorna il ramo HEAD a questa revisione"
=20
-#: gitk:1079
+#: gitk:2230
 msgid "Check out this branch"
 msgstr "Attiva questo ramo"
=20
-#: gitk:1081
+#: gitk:2232
 msgid "Remove this branch"
 msgstr "Elimina questo ramo"
=20
-#: gitk:1087
+#: gitk:2238
 msgid "Highlight this too"
 msgstr "Evidenzia anche questo"
=20
-#: gitk:1089
+#: gitk:2240
 msgid "Highlight this only"
 msgstr "Evidenzia solo questo"
=20
-#: gitk:1318
+#: gitk:2242
+msgid "External diff"
+msgstr ""
+
+#: gitk:2244
+msgid "Blame parent commit"
+msgstr ""
+
+#: gitk:2485
+#, fuzzy
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
-"Copyright =C2=A9 2005-2006 Paul Mackerras\n"
+"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public Licens=
e"
 msgstr ""
@@ -271,421 +308,431 @@ msgstr ""
 "Utilizzo e redistribuzione permessi sotto i termini della GNU General=
 Public "
 "License"
=20
-#: gitk:1326 gitk:1387 gitk:6581
+#: gitk:2493 gitk:2554 gitk:7906
 msgid "Close"
 msgstr "Chiudi"
=20
-#: gitk:1345
+#: gitk:2512
 msgid "Gitk key bindings"
 msgstr "Scorciatoie da tastiera di Gitk"
=20
-#: gitk:1347
+#: gitk:2514
 msgid "Gitk key bindings:"
 msgstr "Scorciatoie da tastiera di Gitk:"
=20
-#: gitk:1349
+#: gitk:2516
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tEsci"
=20
-#: gitk:1350
+#: gitk:2517
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Home>\t\tVai alla prima revisione"
=20
-#: gitk:1351
+#: gitk:2518
 msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\tVai all'ultima revisione"
=20
-#: gitk:1352
+#: gitk:2519
 msgid "<Up>, p, i\tMove up one commit"
 msgstr "<Up>, p, i\tVai pi=C3=B9 in alto di una revisione"
=20
-#: gitk:1353
+#: gitk:2520
 msgid "<Down>, n, k\tMove down one commit"
 msgstr "<Down>, n, k\tVai pi=C3=B9 in basso di una revisione"
=20
-#: gitk:1354
+#: gitk:2521
 msgid "<Left>, z, j\tGo back in history list"
 msgstr "<Left>, z, j\tTorna indietro nella cronologia"
=20
-#: gitk:1355
+#: gitk:2522
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Right>, x, l\tVai avanti nella cronologia"
=20
-#: gitk:1356
+#: gitk:2523
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<PageUp>\tVai pi=C3=B9 in alto di una pagina nella lista delle=
 revisioni"
=20
-#: gitk:1357
+#: gitk:2524
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<PageDown>\tVai pi=C3=B9 in basso di una pagina nella lista de=
lle revisioni"
=20
-#: gitk:1358
+#: gitk:2525
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Home>\tScorri alla cima della lista delle revisioni"
=20
-#: gitk:1359
+#: gitk:2526
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-End>\tScorri alla fine della lista delle revisioni"
=20
-#: gitk:1360
+#: gitk:2527
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Up>\tScorri la lista delle revisioni in alto di una riga"
=20
-#: gitk:1361
+#: gitk:2528
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Down>\tScorri la lista delle revisioni in basso di una rig=
a"
=20
-#: gitk:1362
+#: gitk:2529
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-PageUp>\tScorri la lista delle revisioni in alto di una pa=
gina"
=20
-#: gitk:1363
+#: gitk:2530
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-PageDown>\tScorri la lista delle revisioni in basso di una=
 pagina"
=20
-#: gitk:1364
+#: gitk:2531
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Shift-Up>\tTrova all'indietro (verso l'alto, revisioni succes=
sive)"
=20
-#: gitk:1365
+#: gitk:2532
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr "<Shift-Down>\tTrova in avanti (verso il basso, revisioni prece=
denti)"
=20
-#: gitk:1366
+#: gitk:2533
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Delete>, b\tScorri la vista delle differenze in alto di una p=
agina"
=20
-#: gitk:1367
+#: gitk:2534
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<Backspace>\tScorri la vista delle differenze in alto di una p=
agina"
=20
-#: gitk:1368
+#: gitk:2535
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Space>\t\tScorri la vista delle differenze in basso di una pa=
gina"
=20
-#: gitk:1369
+#: gitk:2536
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\tScorri la vista delle differenze in alto di 18 linee"
=20
-#: gitk:1370
+#: gitk:2537
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\tScorri la vista delle differenze in basso di 18 linee"
=20
-#: gitk:1371
+#: gitk:2538
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tTrova"
=20
-#: gitk:1372
+#: gitk:2539
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tTrova in avanti"
=20
-#: gitk:1373
+#: gitk:2540
 msgid "<Return>\tMove to next find hit"
 msgstr "<Return>\tTrova in avanti"
=20
-#: gitk:1374
+#: gitk:2541
 msgid "/\t\tMove to next find hit, or redo find"
 msgstr "/\t\tTrova in avanti, o cerca di nuovo"
=20
-#: gitk:1375
+#: gitk:2542
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tTrova all'indietro"
=20
-#: gitk:1376
+#: gitk:2543
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tScorri la vista delle differenze al file successivo"
=20
-#: gitk:1377
+#: gitk:2544
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tCerca in avanti nella vista delle differenze"
=20
-#: gitk:1378
+#: gitk:2545
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tCerca all'indietro nella vista delle differenze"
=20
-#: gitk:1379
+#: gitk:2546
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-KP+>\tAumenta grandezza carattere"
=20
-#: gitk:1380
+#: gitk:2547
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-plus>\tAumenta grandezza carattere"
=20
-#: gitk:1381
+#: gitk:2548
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-KP->\tDiminuisci grandezza carattere"
=20
-#: gitk:1382
+#: gitk:2549
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-minus>\tDiminuisci grandezza carattere"
=20
-#: gitk:1383
+#: gitk:2550
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tAggiorna"
=20
-#: gitk:1896
+#: gitk:3065
+#, fuzzy
+msgid "No such commit"
+msgstr "Nessuna modifica archiviata"
+
+#: gitk:3197
 msgid "Gitk view definition"
 msgstr "Scelta vista Gitk"
=20
-#: gitk:1921
+#: gitk:3222
 msgid "Name"
 msgstr "Nome"
=20
-#: gitk:1924
+#: gitk:3225
 msgid "Remember this view"
 msgstr "Ricorda questa vista"
=20
-#: gitk:1928
-msgid "Commits to include (arguments to git rev-list):"
+#: gitk:3229
+#, fuzzy
+msgid "Commits to include (arguments to git log):"
 msgstr "Revisioni da includere (argomenti di git rev-list):"
=20
-#: gitk:1935
+#: gitk:3236
 msgid "Command to generate more commits to include:"
 msgstr "Comando che genera altre revisioni da visualizzare:"
=20
-#: gitk:1942
+#: gitk:3243
 msgid "Enter files and directories to include, one per line:"
 msgstr "Inserire file e directory da includere, uno per riga:"
=20
-#: gitk:1989
+#: gitk:3290
 msgid "Error in commit selection arguments:"
 msgstr "Errore negli argomenti di selezione delle revisioni:"
=20
-#: gitk:2043 gitk:2127 gitk:2583 gitk:2597 gitk:3781 gitk:8688 gitk:86=
89
+#: gitk:3344 gitk:3396 gitk:3839 gitk:3853 gitk:5057 gitk:10013 gitk:1=
0014
 msgid "None"
 msgstr "Nessuno"
=20
-#: gitk:2531 gitk:4336 gitk:5958 gitk:5973
+#: gitk:3787 gitk:5577 gitk:7251 gitk:7266
 msgid "Date"
 msgstr "Data"
=20
-#: gitk:2531 gitk:4336
+#: gitk:3787 gitk:5577
 msgid "CDate"
 msgstr ""
=20
-#: gitk:2680 gitk:2685
+#: gitk:3936 gitk:3941
 msgid "Descendant"
 msgstr "Discendente"
=20
-#: gitk:2681
+#: gitk:3937
 msgid "Not descendant"
 msgstr "Non discendente"
=20
-#: gitk:2688 gitk:2693
+#: gitk:3944 gitk:3949
 msgid "Ancestor"
 msgstr "Ascendente"
=20
-#: gitk:2689
+#: gitk:3945
 msgid "Not ancestor"
 msgstr "Non ascendente"
=20
-#: gitk:2924
+#: gitk:4184
 msgid "Local changes checked in to index but not committed"
 msgstr "Modifiche locali presenti nell'indice ma non nell'archivio"
=20
-#: gitk:2954
+#: gitk:4217
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Modifiche locali non presenti n=C3=A9 nell'archivio n=C3=A9 ne=
ll'indice"
=20
-#: gitk:4305
+#: gitk:5546
 msgid "Searching"
 msgstr "Ricerca in corso"
=20
-#: gitk:4767
+#: gitk:6046
 msgid "Tags:"
 msgstr "Etichette:"
=20
-#: gitk:4784 gitk:4790 gitk:5951
+#: gitk:6063 gitk:6069 gitk:7244
 msgid "Parent"
 msgstr "Genitore"
=20
-#: gitk:4795
+#: gitk:6074
 msgid "Child"
 msgstr "Figlio"
=20
-#: gitk:4804
+#: gitk:6083
 msgid "Branch"
 msgstr "Ramo"
=20
-#: gitk:4807
+#: gitk:6086
 msgid "Follows"
 msgstr "Segue"
=20
-#: gitk:4810
+#: gitk:6089
 msgid "Precedes"
 msgstr "Precede"
=20
-#: gitk:5093
+#: gitk:6373
 msgid "Error getting merge diffs:"
 msgstr "Errore nella lettura delle differenze di fusione:"
=20
-#: gitk:5778
+#: gitk:7077
 msgid "Goto:"
 msgstr "Vai a:"
=20
-#: gitk:5780
+#: gitk:7079
 msgid "SHA1 ID:"
 msgstr "SHA1 ID:"
=20
-#: gitk:5805
+#: gitk:7098
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "La SHA1 id abbreviata %s =C3=A8 ambigua"
=20
-#: gitk:5817
+#: gitk:7110
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "La SHA1 id %s =C3=A8 sconosciuta"
=20
-#: gitk:5819
+#: gitk:7112
 #, tcl-format
 msgid "Tag/Head %s is not known"
 msgstr "L'etichetta/ramo %s =C3=A8 sconosciuto"
=20
-#: gitk:5961
+#: gitk:7254
 msgid "Children"
 msgstr "Figli"
=20
-#: gitk:6018
+#: gitk:7311
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Aggiorna il ramo %s a questa revisione"
=20
-#: gitk:6049
+#: gitk:7313
+msgid "Detached head: can't reset"
+msgstr ""
+
+#: gitk:7345
 msgid "Top"
 msgstr "Inizio"
=20
-#: gitk:6050
+#: gitk:7346
 msgid "From"
 msgstr "Da"
=20
-#: gitk:6055
+#: gitk:7351
 msgid "To"
 msgstr "A"
=20
-#: gitk:6078
+#: gitk:7374
 msgid "Generate patch"
 msgstr "Genera patch"
=20
-#: gitk:6080
+#: gitk:7376
 msgid "From:"
 msgstr "Da:"
=20
-#: gitk:6089
+#: gitk:7385
 msgid "To:"
 msgstr "A:"
=20
-#: gitk:6098
+#: gitk:7394
 msgid "Reverse"
 msgstr "Inverti"
=20
-#: gitk:6100 gitk:6269
+#: gitk:7396 gitk:7571
 msgid "Output file:"
 msgstr "Scrivi sul file:"
=20
-#: gitk:6106
+#: gitk:7402
 msgid "Generate"
 msgstr "Genera"
=20
-#: gitk:6142
+#: gitk:7438
 msgid "Error creating patch:"
 msgstr "Errore nella creazione della patch:"
=20
-#: gitk:6164 gitk:6257 gitk:6311
+#: gitk:7460 gitk:7559 gitk:7613
 msgid "ID:"
 msgstr "ID:"
=20
-#: gitk:6173
+#: gitk:7469
 msgid "Tag name:"
 msgstr "Nome etichetta:"
=20
-#: gitk:6177 gitk:6320
+#: gitk:7473 gitk:7622
 msgid "Create"
 msgstr "Crea"
=20
-#: gitk:6192
+#: gitk:7488
 msgid "No tag name specified"
 msgstr "Nessuna etichetta specificata"
=20
-#: gitk:6196
+#: gitk:7492
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "L'etichetta \"%s\" esiste gi=C3=A0"
=20
-#: gitk:6202
+#: gitk:7498
 msgid "Error creating tag:"
 msgstr "Errore nella creazione dell'etichetta:"
=20
-#: gitk:6266
+#: gitk:7568
 msgid "Command:"
 msgstr "Comando:"
=20
-#: gitk:6274
+#: gitk:7576
 msgid "Write"
 msgstr "Scrivi"
=20
-#: gitk:6290
+#: gitk:7592
 msgid "Error writing commit:"
 msgstr "Errore nella scrittura della revisione:"
=20
-#: gitk:6316
+#: gitk:7618
 msgid "Name:"
 msgstr "Nome:"
=20
-#: gitk:6335
+#: gitk:7637
 msgid "Please specify a name for the new branch"
 msgstr "Specificare un nome per il nuovo ramo"
=20
-#: gitk:6364
+#: gitk:7666
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
 msgstr "La revisione %s =C3=A8 gi=C3=A0 inclusa nel ramo %s -- applica=
rla di nuovo?"
=20
-#: gitk:6369
+#: gitk:7671
 msgid "Cherry-picking"
 msgstr ""
=20
-#: gitk:6381
+#: gitk:7683
 msgid "No changes committed"
 msgstr "Nessuna modifica archiviata"
=20
-#: gitk:6404
+#: gitk:7708
 msgid "Confirm reset"
 msgstr "Conferma git reset"
=20
-#: gitk:6406
+#: gitk:7710
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "Aggiornare il ramo %s a %s?"
=20
-#: gitk:6410
+#: gitk:7714
 msgid "Reset type:"
 msgstr "Tipo di aggiornamento:"
=20
-#: gitk:6414
+#: gitk:7718
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Soft: Lascia la direcory di lavoro e l'indice come sono"
=20
-#: gitk:6417
+#: gitk:7721
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr "Mixed: Lascia la directory di lavoro come =C3=A8, aggiorna l'i=
ndice"
=20
-#: gitk:6420
+#: gitk:7724
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -693,19 +740,19 @@ msgstr ""
 "Hard: Aggiorna la directory di lavoro e l'indice\n"
 "(abbandona TUTTE le modifiche locali)"
=20
-#: gitk:6436
+#: gitk:7740
 msgid "Resetting"
 msgstr "git reset in corso"
=20
-#: gitk:6493
+#: gitk:7797
 msgid "Checking out"
 msgstr "Attivazione in corso"
=20
-#: gitk:6523
+#: gitk:7848
 msgid "Cannot delete the currently checked-out branch"
 msgstr "Impossibile cancellare il ramo attualmente attivo"
=20
-#: gitk:6529
+#: gitk:7854
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -714,16 +761,16 @@ msgstr ""
 "Le revisioni nel ramo %s non sono presenti su altri rami.\n"
 "Cancellare il ramo %s?"
=20
-#: gitk:6560
+#: gitk:7885
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Etichette e rami: %s"
=20
-#: gitk:6574
+#: gitk:7899
 msgid "Filter"
 msgstr "Filtro"
=20
-#: gitk:6868
+#: gitk:8193
 msgid ""
 "Error reading commit topology information; branch and preceding/follo=
wing "
 "tag information will be incomplete."
@@ -731,117 +778,125 @@ msgstr ""
 "Errore nella lettura della topologia delle revisioni: le informazioni=
 sul "
 "ramo e le etichette precedenti e seguenti saranno incomplete."
=20
-#: gitk:7852
+#: gitk:9179
 msgid "Tag"
 msgstr "Etichetta"
=20
-#: gitk:7852
+#: gitk:9179
 msgid "Id"
 msgstr "Id"
=20
-#: gitk:7892
+#: gitk:9225
 msgid "Gitk font chooser"
 msgstr "Scelta caratteri gitk"
=20
-#: gitk:7909
+#: gitk:9242
 msgid "B"
 msgstr "B"
=20
-#: gitk:7912
+#: gitk:9245
 msgid "I"
 msgstr "I"
=20
-#: gitk:8005
+#: gitk:9338
 msgid "Gitk preferences"
 msgstr "Preferenze gitk"
=20
-#: gitk:8006
+#: gitk:9339
 msgid "Commit list display options"
 msgstr "Opzioni visualizzazione dell'elenco revisioni"
=20
-#: gitk:8009
+#: gitk:9342
 msgid "Maximum graph width (lines)"
 msgstr "Larghezza massima del grafico (in linee)"
=20
-#: gitk:8013
+#: gitk:9346
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Larghezza massima del grafico (% del pannello)"
=20
-#: gitk:8018
+#: gitk:9351
 msgid "Show local changes"
 msgstr "Mostra modifiche locali"
=20
-#: gitk:8023
+#: gitk:9356
 msgid "Auto-select SHA1"
 msgstr "Seleziona automaticamente SHA1 hash"
=20
-#: gitk:8028
+#: gitk:9361
 msgid "Diff display options"
 msgstr "Opzioni di visualizzazione delle differenze"
=20
-#: gitk:8030
+#: gitk:9363
 msgid "Tab spacing"
 msgstr "Spaziatura tabulazioni"
=20
-#: gitk:8034
+#: gitk:9367
 msgid "Display nearby tags"
 msgstr "Mostra etichette vicine"
=20
-#: gitk:8039
+#: gitk:9372
 msgid "Limit diffs to listed paths"
 msgstr "Limita le differenze ai percorsi elencati"
=20
-#: gitk:8044
+#: gitk:9379
+msgid "External diff tool"
+msgstr ""
+
+#: gitk:9381
+msgid "Choose..."
+msgstr ""
+
+#: gitk:9386
 msgid "Colors: press to choose"
 msgstr "Colori: premere per scegliere"
=20
-#: gitk:8047
+#: gitk:9389
 msgid "Background"
 msgstr "Sfondo"
=20
-#: gitk:8051
+#: gitk:9393
 msgid "Foreground"
 msgstr "Primo piano"
=20
-#: gitk:8055
+#: gitk:9397
 msgid "Diff: old lines"
 msgstr "Diff: vecchie linee"
=20
-#: gitk:8060
+#: gitk:9402
 msgid "Diff: new lines"
 msgstr "Diff: nuove linee"
=20
-#: gitk:8065
+#: gitk:9407
 msgid "Diff: hunk header"
 msgstr "Diff: intestazione della sezione"
=20
-#: gitk:8071
+#: gitk:9413
 msgid "Select bg"
 msgstr "Sfondo selezione"
=20
-#: gitk:8075
+#: gitk:9417
 msgid "Fonts: press to choose"
 msgstr "Carattere: premere per scegliere"
=20
-#: gitk:8077
+#: gitk:9419
 msgid "Main font"
 msgstr "Carattere principale"
=20
-#: gitk:8078
+#: gitk:9420
 msgid "Diff display font"
 msgstr "Carattere per differenze"
=20
-#: gitk:8079
+#: gitk:9421
 msgid "User interface font"
 msgstr "Carattere per interfaccia utente"
=20
-#: gitk:8095
+#: gitk:9446
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: scegliere un colore per %s"
=20
-#: gitk:8476
+#: gitk:9827
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
@@ -849,42 +904,24 @@ msgstr ""
 "Questa versione di Tcl/Tk non pu=C3=B2 avviare gitk.\n"
 " Gitk richiede Tcl/Tk versione 8.4 o superiore."
=20
-#: gitk:8565
+#: gitk:9919
 msgid "Cannot find a git repository here."
 msgstr "Archivio git non trovato."
=20
-#: gitk:8569
+#: gitk:9923
 #, tcl-format
 msgid "Cannot find the git directory \"%s\"."
 msgstr "Directory git \"%s\" non trovata."
=20
-#: gitk:8612
+#: gitk:9970
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Argomento ambiguo: '%s' =C3=A8 sia revisione che nome di file"
=20
-#: gitk:8624
+#: gitk:9982
 msgid "Bad arguments to gitk:"
 msgstr "Gitk: argomenti errati:"
=20
-#: gitk:8636
-msgid "Couldn't get list of unmerged files:"
-msgstr "Impossibile ottenere l'elenco dei file in attesa di fusione:"
-
-#: gitk:8652
-msgid "No files selected: --merge specified but no files are unmerged.=
"
-msgstr ""
-"Nessun file selezionato: =C3=A8 stata specificata l'opzione --merge m=
a non ci "
-"sono file in attesa di fusione."
-
-#: gitk:8655
-msgid ""
-"No files selected: --merge specified but no unmerged files are within=
 file "
-"limit."
-msgstr ""
-"Nessun file selezionato: =C3=A8 stata specificata l'opzione --merge m=
a i file "
-"specificati non sono in attesa di fusione."
-
-#: gitk:8716
+#: gitk:10042
 msgid "Command line"
 msgstr "Linea di comando"
diff --git a/po/sv.po b/po/sv.po
index e1ecfb7..85b65dd 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: sv\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-08-03 18:58+0200\n"
+"POT-Creation-Date: 2008-10-07 23:06+0200\n"
 "PO-Revision-Date: 2008-08-03 19:03+0200\n"
 "Last-Translator: Mikael Magnusson <mikachu@gmail.com>\n"
 "Language-Team: Swedish <sv@li.org>\n"
@@ -16,17 +16,17 @@ msgstr ""
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: gitk:102
+#: gitk:113
 msgid "Couldn't get list of unmerged files:"
 msgstr "Kunde inta h=C3=A4mta lista =C3=B6ver ej sammanslagna filer:"
=20
-#: gitk:329
+#: gitk:340
 msgid "No files selected: --merge specified but no files are unmerged.=
"
 msgstr ""
 "Inga filer valdes: --merge angavs men det finns inga filer som inte h=
ar "
 "slagits samman."
=20
-#: gitk:332
+#: gitk:343
 msgid ""
 "No files selected: --merge specified but no unmerged files are within=
 file "
 "limit."
@@ -34,257 +34,261 @@ msgstr ""
 "Inga filer valdes: --merge angavs men det finns inga filer inom "
 "filbegr=C3=A4nsningen."
=20
-#: gitk:354
+#: gitk:365
 msgid "Error executing git log:"
 msgstr "Fel vid k=C3=B6rning av git log:"
=20
-#: gitk:369
+#: gitk:378
 msgid "Reading"
 msgstr "L=C3=A4ser"
=20
-#: gitk:400 gitk:3356
+#: gitk:438 gitk:3459
 msgid "Reading commits..."
 msgstr "L=C3=A4ser incheckningar..."
=20
-#: gitk:403 gitk:1480 gitk:3359
+#: gitk:441 gitk:1528 gitk:3462
 msgid "No commits selected"
 msgstr "Inga incheckningar markerade"
=20
-#: gitk:1358
+#: gitk:1399
 msgid "Can't parse git log output:"
 msgstr "Kan inte tolka utdata fr=C3=A5n git log:"
=20
-#: gitk:1557
+#: gitk:1605
 msgid "No commit information available"
 msgstr "Ingen incheckningsinformation =C3=A4r tillg=C3=A4nglig"
=20
-#: gitk:1654 gitk:1676 gitk:3150 gitk:7620 gitk:9149 gitk:9317
+#: gitk:1709 gitk:1731 gitk:3256 gitk:7727 gitk:9256 gitk:9424
 msgid "OK"
 msgstr "OK"
=20
-#: gitk:1678 gitk:3151 gitk:7296 gitk:7367 gitk:7470 gitk:7516 gitk:76=
22
-#: gitk:9150 gitk:9318
+#: gitk:1733 gitk:3257 gitk:7403 gitk:7474 gitk:7577 gitk:7623 gitk:77=
29
+#: gitk:9257 gitk:9425
 msgid "Cancel"
 msgstr "Avbryt"
=20
-#: gitk:1716
+#: gitk:1798
 msgid "File"
 msgstr "Arkiv"
=20
-#: gitk:1718
+#: gitk:1800
 msgid "Update"
 msgstr "Uppdatera"
=20
-#: gitk:1719
+#: gitk:1801
 msgid "Reload"
 msgstr "Ladda om"
=20
-#: gitk:1720
+#: gitk:1802
 msgid "Reread references"
 msgstr "L=C3=A4s om referenser"
=20
-#: gitk:1721
+#: gitk:1803
 msgid "List references"
 msgstr "Visa referenser"
=20
-#: gitk:1722
+#: gitk:1804
 msgid "Quit"
 msgstr "Avsluta"
=20
-#: gitk:1724
+#: gitk:1806
 msgid "Edit"
 msgstr "Redigera"
=20
-#: gitk:1725
+#: gitk:1807
 msgid "Preferences"
 msgstr "Inst=C3=A4llningar"
=20
-#: gitk:1728 gitk:3087
+#: gitk:1810 gitk:3193
 msgid "View"
 msgstr "Visa"
=20
-#: gitk:1729
+#: gitk:1811
 msgid "New view..."
 msgstr "Ny vy..."
=20
-#: gitk:1730 gitk:3298 gitk:9932
+#: gitk:1812
 msgid "Edit view..."
 msgstr "=C3=84ndra vy..."
=20
-#: gitk:1732 gitk:3299 gitk:9933
+#: gitk:1814
 msgid "Delete view"
 msgstr "Ta bort vy"
=20
-#: gitk:1734
+#: gitk:1816
 msgid "All files"
 msgstr "Alla filer"
=20
-#: gitk:1738
+#: gitk:1820
 msgid "Help"
 msgstr "Hj=C3=A4lp"
=20
-#: gitk:1739 gitk:2399
+#: gitk:1821 gitk:2484
 msgid "About gitk"
 msgstr "Om gitk"
=20
-#: gitk:1740
+#: gitk:1822
 msgid "Key bindings"
 msgstr "Tangentbordsbindningar"
=20
-#: gitk:1797
+#: gitk:1879
 msgid "SHA1 ID: "
 msgstr "SHA1-id: "
=20
-#: gitk:1828
+#: gitk:1910
 msgid "Row"
 msgstr "Rad"
=20
-#: gitk:1859
+#: gitk:1941
 msgid "Find"
 msgstr "S=C3=B6k"
=20
-#: gitk:1860
+#: gitk:1942
 msgid "next"
 msgstr "n=C3=A4sta"
=20
-#: gitk:1861
+#: gitk:1943
 msgid "prev"
 msgstr "f=C3=B6reg"
=20
-#: gitk:1862
+#: gitk:1944
 msgid "commit"
 msgstr "incheckning"
=20
-#: gitk:1865 gitk:1867 gitk:3511 gitk:3534 gitk:3558 gitk:5441 gitk:55=
12
+#: gitk:1947 gitk:1949 gitk:3614 gitk:3637 gitk:3661 gitk:5547 gitk:56=
18
 msgid "containing:"
 msgstr "som inneh=C3=A5ller:"
=20
-#: gitk:1868 gitk:2866 gitk:2871 gitk:3586
+#: gitk:1950 gitk:2951 gitk:2956 gitk:3689
 msgid "touching paths:"
 msgstr "som r=C3=B6r s=C3=B6kv=C3=A4g:"
=20
-#: gitk:1869 gitk:3591
+#: gitk:1951 gitk:3694
 msgid "adding/removing string:"
 msgstr "som l=C3=A4gger/till tar bort str=C3=A4ng:"
=20
-#: gitk:1878 gitk:1880
+#: gitk:1960 gitk:1962
 msgid "Exact"
 msgstr "Exakt"
=20
-#: gitk:1880 gitk:3667 gitk:5409
+#: gitk:1962 gitk:3770 gitk:5515
 msgid "IgnCase"
 msgstr "IgnVersaler"
=20
-#: gitk:1880 gitk:3560 gitk:3665 gitk:5405
+#: gitk:1962 gitk:3663 gitk:3768 gitk:5511
 msgid "Regexp"
 msgstr "Reg.uttr."
=20
-#: gitk:1882 gitk:1883 gitk:3686 gitk:3716 gitk:3723 gitk:5532 gitk:55=
99
+#: gitk:1964 gitk:1965 gitk:3789 gitk:3819 gitk:3826 gitk:5638 gitk:57=
05
 msgid "All fields"
 msgstr "Alla f=C3=A4lt"
=20
-#: gitk:1883 gitk:3684 gitk:3716 gitk:5471
+#: gitk:1965 gitk:3787 gitk:3819 gitk:5577
 msgid "Headline"
 msgstr "Rubrik"
=20
-#: gitk:1884 gitk:3684 gitk:5471 gitk:5599 gitk:6000
+#: gitk:1966 gitk:3787 gitk:5577 gitk:5705 gitk:6106
 msgid "Comments"
 msgstr "Kommentarer"
=20
-#: gitk:1884 gitk:3684 gitk:3688 gitk:3723 gitk:5471 gitk:5936 gitk:71=
42
-#: gitk:7157
+#: gitk:1966 gitk:3787 gitk:3791 gitk:3826 gitk:5577 gitk:6042 gitk:72=
49
+#: gitk:7264
 msgid "Author"
 msgstr "F=C3=B6rfattare"
=20
-#: gitk:1884 gitk:3684 gitk:5471 gitk:5938
+#: gitk:1966 gitk:3787 gitk:5577 gitk:6044
 msgid "Committer"
 msgstr "Incheckare"
=20
-#: gitk:1913
+#: gitk:1995
 msgid "Search"
 msgstr "S=C3=B6k"
=20
-#: gitk:1920
+#: gitk:2002
 msgid "Diff"
 msgstr "Diff"
=20
-#: gitk:1922
+#: gitk:2004
 msgid "Old version"
 msgstr "Gammal version"
=20
-#: gitk:1924
+#: gitk:2006
 msgid "New version"
 msgstr "Ny version"
=20
-#: gitk:1926
+#: gitk:2008
 msgid "Lines of context"
 msgstr "Rader sammanhang"
=20
-#: gitk:1936
+#: gitk:2018
 msgid "Ignore space change"
 msgstr "Ignorera =C3=A4ndringar i blanksteg"
=20
-#: gitk:1994
+#: gitk:2076
 msgid "Patch"
 msgstr "Patch"
=20
-#: gitk:1996
+#: gitk:2078
 msgid "Tree"
 msgstr "Tr=C3=A4d"
=20
-#: gitk:2121 gitk:2136 gitk:7211
+#: gitk:2204 gitk:2219
 msgid "Diff this -> selected"
 msgstr "Diff denna -> markerad"
=20
-#: gitk:2123 gitk:2138 gitk:7212
+#: gitk:2206 gitk:2221
 msgid "Diff selected -> this"
 msgstr "Diff markerad -> denna"
=20
-#: gitk:2125 gitk:2140 gitk:7213
+#: gitk:2208 gitk:2223
 msgid "Make patch"
 msgstr "Skapa patch"
=20
-#: gitk:2126 gitk:7351
+#: gitk:2209 gitk:7458
 msgid "Create tag"
 msgstr "Skapa tagg"
=20
-#: gitk:2127 gitk:7450
+#: gitk:2210 gitk:7557
 msgid "Write commit to file"
 msgstr "Skriv incheckning till fil"
=20
-#: gitk:2128 gitk:7504
+#: gitk:2211 gitk:7611
 msgid "Create new branch"
 msgstr "Skapa ny gren"
=20
-#: gitk:2129
+#: gitk:2212
 msgid "Cherry-pick this commit"
 msgstr "Plocka denna incheckning"
=20
-#: gitk:2131
+#: gitk:2214
 msgid "Reset HEAD branch to here"
 msgstr "=C3=85terst=C3=A4ll HEAD-grenen hit"
=20
-#: gitk:2147
+#: gitk:2230
 msgid "Check out this branch"
 msgstr "Checka ut denna gren"
=20
-#: gitk:2149
+#: gitk:2232
 msgid "Remove this branch"
 msgstr "Ta bort denna gren"
=20
-#: gitk:2155
+#: gitk:2238
 msgid "Highlight this too"
 msgstr "Markera =C3=A4ven detta"
=20
-#: gitk:2157
+#: gitk:2240
 msgid "Highlight this only"
 msgstr "Markera bara detta"
=20
-#: gitk:2159
+#: gitk:2242
 msgid "External diff"
 msgstr "Extern diff"
=20
-#: gitk:2400
+#: gitk:2244
+msgid "Blame parent commit"
+msgstr ""
+
+#: gitk:2485
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -300,427 +304,432 @@ msgstr ""
 "\n"
 "Anv=C3=A4nd och vidaref=C3=B6rmedla enligt villkoren i GNU General Pu=
blic License"
=20
-#: gitk:2408 gitk:2469 gitk:7799
+#: gitk:2493 gitk:2554 gitk:7906
 msgid "Close"
 msgstr "St=C3=A4ng"
=20
-#: gitk:2427
+#: gitk:2512
 msgid "Gitk key bindings"
 msgstr "Tangentbordsbindningar f=C3=B6r Gitk"
=20
-#: gitk:2429
+#: gitk:2514
 msgid "Gitk key bindings:"
 msgstr "Tangentbordsbindningar f=C3=B6r Gitk:"
=20
-#: gitk:2431
+#: gitk:2516
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tAvsluta"
=20
-#: gitk:2432
+#: gitk:2517
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Home>\t\tG=C3=A5 till f=C3=B6rsta incheckning"
=20
-#: gitk:2433
+#: gitk:2518
 msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\tG=C3=A5 till sista incheckning"
=20
-#: gitk:2434
+#: gitk:2519
 msgid "<Up>, p, i\tMove up one commit"
 msgstr "<Upp>, p, i\tG=C3=A5 en incheckning upp"
=20
-#: gitk:2435
+#: gitk:2520
 msgid "<Down>, n, k\tMove down one commit"
 msgstr "<Ned>, n, k\tG=C3=A5 en incheckning ned"
=20
-#: gitk:2436
+#: gitk:2521
 msgid "<Left>, z, j\tGo back in history list"
 msgstr "<V=C3=A4nster>, z, j\tG=C3=A5 bak=C3=A5t i historiken"
=20
-#: gitk:2437
+#: gitk:2522
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<H=C3=B6ger>, x, l\tG=C3=A5 fram=C3=A5t i historiken"
=20
-#: gitk:2438
+#: gitk:2523
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<PageUp>\tG=C3=A5 upp en sida i incheckningslistan"
=20
-#: gitk:2439
+#: gitk:2524
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<PageDown>\tG=C3=A5 ned en sida i incheckningslistan"
=20
-#: gitk:2440
+#: gitk:2525
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Home>\tRulla till b=C3=B6rjan av incheckningslistan"
=20
-#: gitk:2441
+#: gitk:2526
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-End>\tRulla till slutet av incheckningslistan"
=20
-#: gitk:2442
+#: gitk:2527
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Upp>\tRulla incheckningslistan upp ett steg"
=20
-#: gitk:2443
+#: gitk:2528
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Ned>\tRulla incheckningslistan ned ett steg"
=20
-#: gitk:2444
+#: gitk:2529
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-PageUp>\tRulla incheckningslistan upp en sida"
=20
-#: gitk:2445
+#: gitk:2530
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-PageDown>\tRulla incheckningslistan ned en sida"
=20
-#: gitk:2446
+#: gitk:2531
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Skift-Upp>\tS=C3=B6k bak=C3=A5t (upp=C3=A5t, senare incheckni=
ngar)"
=20
-#: gitk:2447
+#: gitk:2532
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr "<Skift-Ned>\tS=C3=B6k fram=C3=A5t (ned=C3=A5t, tidigare inchec=
kningar)"
=20
-#: gitk:2448
+#: gitk:2533
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Delete>, b\tRulla diffvisningen upp en sida"
=20
-#: gitk:2449
+#: gitk:2534
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<Baksteg>\tRulla diffvisningen upp en sida"
=20
-#: gitk:2450
+#: gitk:2535
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Blanksteg>\tRulla diffvisningen ned en sida"
=20
-#: gitk:2451
+#: gitk:2536
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\tRulla diffvisningen upp 18 rader"
=20
-#: gitk:2452
+#: gitk:2537
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\tRulla diffvisningen ned 18 rader"
=20
-#: gitk:2453
+#: gitk:2538
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tS=C3=B6k"
=20
-#: gitk:2454
+#: gitk:2539
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tG=C3=A5 till n=C3=A4sta s=C3=B6ktr=C3=A4ff"
=20
-#: gitk:2455
+#: gitk:2540
 msgid "<Return>\tMove to next find hit"
 msgstr "<Return>\t\tG=C3=A5 till n=C3=A4sta s=C3=B6ktr=C3=A4ff"
=20
-#: gitk:2456
+#: gitk:2541
 msgid "/\t\tMove to next find hit, or redo find"
 msgstr "/\t\tG=C3=A5 till n=C3=A4sta s=C3=B6ktr=C3=A4ff, eller s=C3=B6=
k p=C3=A5 nytt"
=20
-#: gitk:2457
+#: gitk:2542
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tG=C3=A5 till f=C3=B6reg=C3=A5ende s=C3=B6ktr=C3=A4ff"
=20
-#: gitk:2458
+#: gitk:2543
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tRulla diffvisningen till n=C3=A4sta fil"
=20
-#: gitk:2459
+#: gitk:2544
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tG=C3=A5 till n=C3=A4sta s=C3=B6ktr=C3=A4ff i diffvis=
ningen"
=20
-#: gitk:2460
+#: gitk:2545
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tG=C3=A5 till f=C3=B6reg=C3=A5ende s=C3=B6ktr=C3=A4ff=
 i diffvisningen"
=20
-#: gitk:2461
+#: gitk:2546
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-Num+>\t=C3=96ka teckenstorlek"
=20
-#: gitk:2462
+#: gitk:2547
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-plus>\t=C3=96ka teckenstorlek"
=20
-#: gitk:2463
+#: gitk:2548
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-Num->\tMinska teckenstorlek"
=20
-#: gitk:2464
+#: gitk:2549
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-minus>\tMinska teckenstorlek"
=20
-#: gitk:2465
+#: gitk:2550
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tUppdatera"
=20
-#: gitk:3091
+#: gitk:3065
+#, fuzzy
+msgid "No such commit"
+msgstr "Inga =C3=A4ndringar incheckade"
+
+#: gitk:3197
 msgid "Gitk view definition"
 msgstr "Definition av Gitk-vy"
=20
-#: gitk:3116
+#: gitk:3222
 msgid "Name"
 msgstr "Namn"
=20
-#: gitk:3119
+#: gitk:3225
 msgid "Remember this view"
 msgstr "Spara denna vy"
=20
-#: gitk:3123
+#: gitk:3229
 msgid "Commits to include (arguments to git log):"
 msgstr "Incheckningar att ta med (argument till git log):"
=20
-#: gitk:3130
+#: gitk:3236
 msgid "Command to generate more commits to include:"
 msgstr "Kommando f=C3=B6r att generera fler incheckningar att ta med:"
=20
-#: gitk:3137
+#: gitk:3243
 msgid "Enter files and directories to include, one per line:"
 msgstr "Ange filer och kataloger att ta med, en per rad:"
=20
-#: gitk:3184
+#: gitk:3290
 msgid "Error in commit selection arguments:"
 msgstr "Fel i argument f=C3=B6r val av incheckningar:"
=20
-#: gitk:3238 gitk:3290 gitk:3736 gitk:3750 gitk:4951 gitk:9896 gitk:98=
97
+#: gitk:3344 gitk:3396 gitk:3839 gitk:3853 gitk:5057 gitk:10013 gitk:1=
0014
 msgid "None"
 msgstr "Inget"
=20
-#: gitk:3684 gitk:5471 gitk:7144 gitk:7159
+#: gitk:3787 gitk:5577 gitk:7251 gitk:7266
 msgid "Date"
 msgstr "Datum"
=20
-#: gitk:3684 gitk:5471
+#: gitk:3787 gitk:5577
 msgid "CDate"
 msgstr "Skapat datum"
=20
-#: gitk:3833 gitk:3838
+#: gitk:3936 gitk:3941
 msgid "Descendant"
 msgstr "Avkomling"
=20
-#: gitk:3834
+#: gitk:3937
 msgid "Not descendant"
 msgstr "Inte avkomling"
=20
-#: gitk:3841 gitk:3846
+#: gitk:3944 gitk:3949
 msgid "Ancestor"
 msgstr "F=C3=B6rfader"
=20
-#: gitk:3842
+#: gitk:3945
 msgid "Not ancestor"
 msgstr "Inte f=C3=B6rfader"
=20
-#: gitk:4078
+#: gitk:4184
 msgid "Local changes checked in to index but not committed"
 msgstr "Lokala =C3=A4ndringar sparade i indexet men inte incheckade"
=20
-#: gitk:4111
+#: gitk:4217
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokala =C3=A4ndringar, ej sparade i indexet"
=20
-#: gitk:5440
+#: gitk:5546
 msgid "Searching"
 msgstr "S=C3=B6ker"
=20
-#: gitk:5940
+#: gitk:6046
 msgid "Tags:"
 msgstr "Taggar:"
=20
-#: gitk:5957 gitk:5963 gitk:7137
+#: gitk:6063 gitk:6069 gitk:7244
 msgid "Parent"
 msgstr "F=C3=B6r=C3=A4lder"
=20
-#: gitk:5968
+#: gitk:6074
 msgid "Child"
 msgstr "Barn"
=20
-#: gitk:5977
+#: gitk:6083
 msgid "Branch"
 msgstr "Gren"
=20
-#: gitk:5980
+#: gitk:6086
 msgid "Follows"
 msgstr "F=C3=B6ljer"
=20
-#: gitk:5983
+#: gitk:6089
 msgid "Precedes"
 msgstr "F=C3=B6reg=C3=A5r"
=20
-#: gitk:6267
+#: gitk:6373
 msgid "Error getting merge diffs:"
 msgstr "Fel vid h=C3=A4mtning av sammanslagningsdiff:"
=20
-#: gitk:6970
+#: gitk:7077
 msgid "Goto:"
 msgstr "G=C3=A5 till:"
=20
-#: gitk:6972
+#: gitk:7079
 msgid "SHA1 ID:"
 msgstr "SHA1-id:"
=20
-#: gitk:6991
+#: gitk:7098
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "F=C3=B6rkortat SHA1-id %s =C3=A4r tvetydigt"
=20
-#: gitk:7003
+#: gitk:7110
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "SHA-id:t %s =C3=A4r inte k=C3=A4nt"
=20
-#: gitk:7005
+#: gitk:7112
 #, tcl-format
 msgid "Tag/Head %s is not known"
 msgstr "Tagg/huvud %s =C3=A4r ok=C3=A4nt"
=20
-#: gitk:7147
+#: gitk:7254
 msgid "Children"
 msgstr "Barn"
=20
-#: gitk:7204
+#: gitk:7311
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "=C3=85terst=C3=A4ll grenen %s hit"
=20
-#: gitk:7206
+#: gitk:7313
 msgid "Detached head: can't reset"
 msgstr "Fr=C3=A5nkopplad head: kan inte =C3=A5terst=C3=A4lla"
=20
-#: gitk:7238
+#: gitk:7345
 msgid "Top"
 msgstr "Topp"
=20
-#: gitk:7239
+#: gitk:7346
 msgid "From"
 msgstr "Fr=C3=A5n"
=20
-#: gitk:7244
+#: gitk:7351
 msgid "To"
 msgstr "Till"
=20
-#: gitk:7267
+#: gitk:7374
 msgid "Generate patch"
 msgstr "Generera patch"
=20
-#: gitk:7269
+#: gitk:7376
 msgid "From:"
 msgstr "Fr=C3=A5n:"
=20
-#: gitk:7278
+#: gitk:7385
 msgid "To:"
 msgstr "Till:"
=20
-#: gitk:7287
+#: gitk:7394
 msgid "Reverse"
 msgstr "V=C3=A4nd"
=20
-#: gitk:7289 gitk:7464
+#: gitk:7396 gitk:7571
 msgid "Output file:"
 msgstr "Utdatafil:"
=20
-#: gitk:7295
+#: gitk:7402
 msgid "Generate"
 msgstr "Generera"
=20
-#: gitk:7331
+#: gitk:7438
 msgid "Error creating patch:"
 msgstr "Fel vid generering av patch:"
=20
-#: gitk:7353 gitk:7452 gitk:7506
+#: gitk:7460 gitk:7559 gitk:7613
 msgid "ID:"
 msgstr "Id:"
=20
-#: gitk:7362
+#: gitk:7469
 msgid "Tag name:"
 msgstr "Taggnamn:"
=20
-#: gitk:7366 gitk:7515
+#: gitk:7473 gitk:7622
 msgid "Create"
 msgstr "Skapa"
=20
-#: gitk:7381
+#: gitk:7488
 msgid "No tag name specified"
 msgstr "Inget taggnamn angavs"
=20
-#: gitk:7385
+#: gitk:7492
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Taggen \"%s\" finns redan"
=20
-#: gitk:7391
+#: gitk:7498
 msgid "Error creating tag:"
 msgstr "Fel vid skapande av tagg:"
=20
-#: gitk:7461
+#: gitk:7568
 msgid "Command:"
 msgstr "Kommando:"
=20
-#: gitk:7469
+#: gitk:7576
 msgid "Write"
 msgstr "Skriv"
=20
-#: gitk:7485
+#: gitk:7592
 msgid "Error writing commit:"
 msgstr "Fel vid skrivning av incheckning:"
=20
-#: gitk:7511
+#: gitk:7618
 msgid "Name:"
 msgstr "Namn:"
=20
-#: gitk:7530
+#: gitk:7637
 msgid "Please specify a name for the new branch"
 msgstr "Ange ett namn f=C3=B6r den nya grenen"
=20
-#: gitk:7559
+#: gitk:7666
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
 msgstr ""
 "Incheckningen %s finns redan p=C3=A5 grenen %s -- skall den verkligen=
 appliceras "
 "p=C3=A5 nytt?"
=20
-#: gitk:7564
+#: gitk:7671
 msgid "Cherry-picking"
 msgstr "Plockar"
=20
-#: gitk:7576
+#: gitk:7683
 msgid "No changes committed"
 msgstr "Inga =C3=A4ndringar incheckade"
=20
-#: gitk:7601
+#: gitk:7708
 msgid "Confirm reset"
 msgstr "Bekr=C3=A4fta =C3=A5terst=C3=A4llning"
=20
-#: gitk:7603
+#: gitk:7710
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "=C3=85terst=C3=A4lla grenen %s till %s?"
=20
-#: gitk:7607
+#: gitk:7714
 msgid "Reset type:"
 msgstr "Typ av =C3=A5terst=C3=A4llning:"
=20
-#: gitk:7611
+#: gitk:7718
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Mjuk: R=C3=B6r inte utcheckning och index"
=20
-#: gitk:7614
+#: gitk:7721
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr "Blandad: R=C3=B6r inte utcheckning, =C3=A5terst=C3=A4ll index"
=20
-#: gitk:7617
+#: gitk:7724
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -728,19 +737,19 @@ msgstr ""
 "H=C3=A5rd: =C3=85terst=C3=A4ll utcheckning och index\n"
 "(f=C3=B6rkastar ALLA lokala =C3=A4ndringar)"
=20
-#: gitk:7633
+#: gitk:7740
 msgid "Resetting"
 msgstr "=C3=85terst=C3=A4ller"
=20
-#: gitk:7690
+#: gitk:7797
 msgid "Checking out"
 msgstr "Checkar ut"
=20
-#: gitk:7741
+#: gitk:7848
 msgid "Cannot delete the currently checked-out branch"
 msgstr "Kan inte ta bort den just nu utcheckade grenen"
=20
-#: gitk:7747
+#: gitk:7854
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -749,16 +758,16 @@ msgstr ""
 "Incheckningarna p=C3=A5 grenen %s existerar inte p=C3=A5 n=C3=A5gon a=
nnan gren.\n"
 "Vill du verkligen ta bort grenen %s?"
=20
-#: gitk:7778
+#: gitk:7885
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Taggar och huvuden: %s"
=20
-#: gitk:7792
+#: gitk:7899
 msgid "Filter"
 msgstr "Filter"
=20
-#: gitk:8086
+#: gitk:8193
 msgid ""
 "Error reading commit topology information; branch and preceding/follo=
wing "
 "tag information will be incomplete."
@@ -766,125 +775,125 @@ msgstr ""
 "Fel vid l=C3=A4sning av information om incheckningstopologi; informat=
ion om "
 "grenar och f=C3=B6reg=C3=A5ende/senare taggar kommer inte vara komple=
tt."
=20
-#: gitk:9072
+#: gitk:9179
 msgid "Tag"
 msgstr "Tagg"
=20
-#: gitk:9072
+#: gitk:9179
 msgid "Id"
 msgstr "Id"
=20
-#: gitk:9118
+#: gitk:9225
 msgid "Gitk font chooser"
 msgstr "Teckensnittsv=C3=A4ljare f=C3=B6r Gitk"
=20
-#: gitk:9135
+#: gitk:9242
 msgid "B"
 msgstr "F"
=20
-#: gitk:9138
+#: gitk:9245
 msgid "I"
 msgstr "K"
=20
-#: gitk:9231
+#: gitk:9338
 msgid "Gitk preferences"
 msgstr "Inst=C3=A4llningar f=C3=B6r Gitk"
=20
-#: gitk:9232
+#: gitk:9339
 msgid "Commit list display options"
 msgstr "Alternativ f=C3=B6r incheckningslistvy"
=20
-#: gitk:9235
+#: gitk:9342
 msgid "Maximum graph width (lines)"
 msgstr "Maximal grafbredd (rader)"
=20
-#: gitk:9239
+#: gitk:9346
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Maximal grafbredd (% av ruta)"
=20
-#: gitk:9244
+#: gitk:9351
 msgid "Show local changes"
 msgstr "Visa lokala =C3=A4ndringar"
=20
-#: gitk:9249
+#: gitk:9356
 msgid "Auto-select SHA1"
 msgstr "V=C3=A4lj SHA1 automatiskt"
=20
-#: gitk:9254
+#: gitk:9361
 msgid "Diff display options"
 msgstr "Alternativ f=C3=B6r diffvy"
=20
-#: gitk:9256
+#: gitk:9363
 msgid "Tab spacing"
 msgstr "Blanksteg f=C3=B6r tabulatortecken"
=20
-#: gitk:9260
+#: gitk:9367
 msgid "Display nearby tags"
 msgstr "Visa n=C3=A4rliggande taggar"
=20
-#: gitk:9265
+#: gitk:9372
 msgid "Limit diffs to listed paths"
 msgstr "Begr=C3=A4nsa diff till listade s=C3=B6kv=C3=A4gar"
=20
-#: gitk:9272
+#: gitk:9379
 msgid "External diff tool"
 msgstr "Externt diff-verktyg"
=20
-#: gitk:9274
+#: gitk:9381
 msgid "Choose..."
 msgstr "V=C3=A4lj..."
=20
-#: gitk:9279
+#: gitk:9386
 msgid "Colors: press to choose"
 msgstr "F=C3=A4rger: tryck f=C3=B6r att v=C3=A4lja"
=20
-#: gitk:9282
+#: gitk:9389
 msgid "Background"
 msgstr "Bakgrund"
=20
-#: gitk:9286
+#: gitk:9393
 msgid "Foreground"
 msgstr "F=C3=B6rgrund"
=20
-#: gitk:9290
+#: gitk:9397
 msgid "Diff: old lines"
 msgstr "Diff: gamla rader"
=20
-#: gitk:9295
+#: gitk:9402
 msgid "Diff: new lines"
 msgstr "Diff: nya rader"
=20
-#: gitk:9300
+#: gitk:9407
 msgid "Diff: hunk header"
 msgstr "Diff: delhuvud"
=20
-#: gitk:9306
+#: gitk:9413
 msgid "Select bg"
 msgstr "Markerad bakgrund"
=20
-#: gitk:9310
+#: gitk:9417
 msgid "Fonts: press to choose"
 msgstr "Teckensnitt: tryck f=C3=B6r att v=C3=A4lja"
=20
-#: gitk:9312
+#: gitk:9419
 msgid "Main font"
 msgstr "Huvudteckensnitt"
=20
-#: gitk:9313
+#: gitk:9420
 msgid "Diff display font"
 msgstr "Teckensnitt f=C3=B6r diffvisning"
=20
-#: gitk:9314
+#: gitk:9421
 msgid "User interface font"
 msgstr "Teckensnitt f=C3=B6r anv=C3=A4ndargr=C3=A4nssnitt"
=20
-#: gitk:9339
+#: gitk:9446
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: v=C3=A4lj f=C3=A4rg f=C3=B6r %s"
=20
-#: gitk:9720
+#: gitk:9827
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
@@ -892,24 +901,24 @@ msgstr ""
 "Gitk kan tyv=C3=A4rr inte k=C3=B6ra med denna version av Tcl/Tk.\n"
 " Gitk kr=C3=A4ver =C3=A5tminstone Tcl/Tk 8.4."
=20
-#: gitk:9812
+#: gitk:9919
 msgid "Cannot find a git repository here."
 msgstr "Hittar inget gitk-arkiv h=C3=A4r."
=20
-#: gitk:9816
+#: gitk:9923
 #, tcl-format
 msgid "Cannot find the git directory \"%s\"."
 msgstr "Hittar inte git-katalogen \"%s\"."
=20
-#: gitk:9853
+#: gitk:9970
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Tvetydigt argument \"%s\": b=C3=A5de revision och filnamn"
=20
-#: gitk:9865
+#: gitk:9982
 msgid "Bad arguments to gitk:"
 msgstr "Felaktiga argument till gitk:"
=20
-#: gitk:9925
+#: gitk:10042
 msgid "Command line"
 msgstr "Kommandorad"
--=20
1.6.0.2.308.gef4a

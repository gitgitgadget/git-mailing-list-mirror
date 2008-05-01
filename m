From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] gitk: Update German translation
Date: Thu, 1 May 2008 21:42:09 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200805012142.10151.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_S0hGIvM6ReqkAb/"
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu May 01 21:43:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrego-0005Jj-7O
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 21:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759361AbYEATmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 15:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758038AbYEATmp
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 15:42:45 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:42116 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756677AbYEATmo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 15:42:44 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m41JgJwn022957
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 1 May 2008 21:42:19 +0200
Received: from [192.168.2.102] (p549025F5.dip0.t-ipconnect.de [84.144.37.245])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m41JgHcm004594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 May 2008 21:42:18 +0200
User-Agent: KMail/1.9.5
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80936>

--Boundary-00=_S0hGIvM6ReqkAb/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached to avoid whitespace problems. This patch is against master of 
gitk.git at git.kernel.org.

By the way, the following two keybinding explanations seem ambiguous to me:

>   <Home>  Move to first commit
>   <End>   Move to last commit

What happens is that <home> jumps to the newest commit and <end> jumps to the 
oldest commit. Whether the "first" commit should be the newest or the oldest 
is, well, somewhat ambiguous. I'd propose to talk about the newest or topmost 
commit, but rather not about the "first".

Regards,

Christian

--Boundary-00=_S0hGIvM6ReqkAb/
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-gitk-Update-German-translation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-gitk-Update-German-translation.patch"

=46rom 73e062a073c429f199af84d855c784b94a70220f Mon Sep 17 00:00:00 2001
=46rom: Christian Stimming <stimming@tuhh.de>
Date: Thu, 1 May 2008 21:38:37 +0200
Subject: [PATCH] gitk: Update German translation

=2D--
 po/de.po |  505 +++++++++++++++++++++++++++++++++++++++++-----------------=
=2D---
 1 files changed, 338 insertions(+), 167 deletions(-)

diff --git a/po/de.po b/po/de.po
index 5ee2fca..58b342a 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -7,249 +7,253 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2008-01-09 22:20+0100\n"
=2D"PO-Revision-Date: 2008-01-09 22:21+0100\n"
+"POT-Creation-Date: 2008-05-01 11:54+0200\n"
+"PO-Revision-Date: 2008-05-01 21:32+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
=2D#: gitk:101
+#: gitk:111
 msgid "Error executing git rev-list:"
 msgstr "Fehler beim Ausf=C3=BChren von git-rev-list:"
=20
=2D#: gitk:114
+#: gitk:124
 msgid "Reading"
 msgstr "Lesen"
=20
=2D#: gitk:141 gitk:2143
+#: gitk:151 gitk:2191
 msgid "Reading commits..."
 msgstr "Versionen lesen..."
=20
=2D#: gitk:264
+#: gitk:275
 msgid "Can't parse git log output:"
 msgstr "Git log Ausgabe kann nicht erkannt werden:"
=20
=2D#: gitk:375 gitk:2147
+#: gitk:386 gitk:2195
 msgid "No commits selected"
 msgstr "Keine Versionen ausgew=C3=A4hlt."
=20
=2D#: gitk:486
+#: gitk:500
 msgid "No commit information available"
 msgstr "Keine Versionsinformation verf=C3=BCgbar"
=20
=2D#: gitk:585 gitk:607 gitk:1908 gitk:6366 gitk:7866 gitk:8020
+#: gitk:599 gitk:621 gitk:1955 gitk:6424 gitk:7924 gitk:8083
 msgid "OK"
 msgstr "Ok"
=20
=2D#: gitk:609 gitk:1909 gitk:6046 gitk:6117 gitk:6218 gitk:6264 gitk:6368
=2D#: gitk:7867 gitk:8021
+#: gitk:623 gitk:1956 gitk:6108 gitk:6179 gitk:6276 gitk:6322 gitk:6426
+#: gitk:7925 gitk:8084
 msgid "Cancel"
 msgstr "Abbrechen"
=20
=2D#: gitk:646
+#: gitk:661
 msgid "File"
 msgstr "Datei"
=20
=2D#: gitk:648
+#: gitk:663
 msgid "Update"
 msgstr "Aktualisieren"
=20
=2D#: gitk:649
+#: gitk:664
 msgid "Reread references"
 msgstr "Zweige neu laden"
=20
=2D#: gitk:650
+#: gitk:665
 msgid "List references"
 msgstr "Zweige auflisten"
=20
=2D#: gitk:651
+#: gitk:666
 msgid "Quit"
 msgstr "Beenden"
=20
=2D#: gitk:653
+#: gitk:668
 msgid "Edit"
 msgstr "Bearbeiten"
=20
=2D#: gitk:654
+#: gitk:669
 msgid "Preferences"
 msgstr "Einstellungen"
=20
=2D#: gitk:657
+#: gitk:672 gitk:1892
 msgid "View"
 msgstr "Ansicht"
=20
=2D#: gitk:658
+#: gitk:673
 msgid "New view..."
 msgstr "Neue Ansicht..."
=20
=2D#: gitk:659 gitk:2085 gitk:8651
+#: gitk:674 gitk:2133 gitk:8723
 msgid "Edit view..."
 msgstr "Ansicht bearbeiten..."
=20
=2D#: gitk:661 gitk:2086 gitk:8652
+#: gitk:676 gitk:2134 gitk:8724
 msgid "Delete view"
 msgstr "Ansicht l=C3=B6schen"
=20
=2D#: gitk:663
+#: gitk:678
 msgid "All files"
 msgstr "Alle Dateien"
=20
=2D#: gitk:667
+#: gitk:682
 msgid "Help"
 msgstr "Hilfe"
=20
=2D#: gitk:668 gitk:1280
+#: gitk:683 gitk:1317
 msgid "About gitk"
 msgstr "=C3=9Cber gitk"
=20
=2D#: gitk:669
+#: gitk:684
 msgid "Key bindings"
 msgstr "Tastenk=C3=BCrzel"
=20
=2D#: gitk:726
+#: gitk:741
 msgid "SHA1 ID: "
 msgstr "SHA1:"
=20
=2D#: gitk:776
+#: gitk:791
 msgid "Find"
 msgstr "Suche"
=20
=2D#: gitk:777
+#: gitk:792
 msgid "next"
 msgstr "n=C3=A4chste"
=20
=2D#: gitk:778
+#: gitk:793
 msgid "prev"
 msgstr "vorige"
=20
=2D#: gitk:779
+#: gitk:794
 msgid "commit"
 msgstr "Version"
=20
=2D#: gitk:782 gitk:784 gitk:2308 gitk:2331 gitk:2355 gitk:4257 gitk:4320
+#: gitk:797 gitk:799 gitk:2356 gitk:2379 gitk:2403 gitk:4306 gitk:4369
 msgid "containing:"
 msgstr "enthaltend:"
=20
=2D#: gitk:785 gitk:1741 gitk:1746 gitk:2383
+#: gitk:800 gitk:1778 gitk:1783 gitk:2431
 msgid "touching paths:"
 msgstr "Pfad betreffend:"
=20
=2D#: gitk:786 gitk:2388
+#: gitk:801 gitk:2436
 msgid "adding/removing string:"
 msgstr "String dazu/l=C3=B6schen:"
=20
=2D#: gitk:795 gitk:797
+#: gitk:810 gitk:812
 msgid "Exact"
 msgstr "Exakt"
=20
=2D#: gitk:797 gitk:2466 gitk:4225
+#: gitk:812 gitk:2514 gitk:4274
 msgid "IgnCase"
 msgstr "Kein Gro=C3=9F/Klein"
=20
=2D#: gitk:797 gitk:2357 gitk:2464 gitk:4221
+#: gitk:812 gitk:2405 gitk:2512 gitk:4270
 msgid "Regexp"
 msgstr "Regexp"
=20
=2D#: gitk:799 gitk:800 gitk:2485 gitk:2515 gitk:2522 gitk:4331 gitk:4387
+#: gitk:814 gitk:815 gitk:2533 gitk:2563 gitk:2570 gitk:4380 gitk:4436
 msgid "All fields"
 msgstr "Alle Felder"
=20
=2D#: gitk:800 gitk:2483 gitk:2515 gitk:4287
+#: gitk:815 gitk:2531 gitk:2563 gitk:4336
 msgid "Headline"
 msgstr "=C3=9Cberschrift"
=20
=2D#: gitk:801 gitk:2483 gitk:4287 gitk:4387 gitk:4775
+#: gitk:816 gitk:2531 gitk:4336 gitk:4436 gitk:4827
 msgid "Comments"
 msgstr "Beschreibung"
=20
=2D#: gitk:801 gitk:2483 gitk:2487 gitk:2522 gitk:4287 gitk:4711 gitk:5895
=2D#: gitk:5910
+#: gitk:816 gitk:2531 gitk:2535 gitk:2570 gitk:4336 gitk:4763 gitk:5957
+#: gitk:5972
 msgid "Author"
 msgstr "Autor"
=20
=2D#: gitk:801 gitk:2483 gitk:4287 gitk:4713
+#: gitk:816 gitk:2531 gitk:4336 gitk:4765
 msgid "Committer"
 msgstr "Eintragender"
=20
=2D#: gitk:829
+#: gitk:845
 msgid "Search"
 msgstr "Suche"
=20
=2D#: gitk:836
+#: gitk:852
 msgid "Diff"
 msgstr "Vergleich"
=20
=2D#: gitk:838
+#: gitk:854
 msgid "Old version"
 msgstr "Alte Version"
=20
=2D#: gitk:840
+#: gitk:856
 msgid "New version"
 msgstr "Neue Version"
=20
=2D#: gitk:842
+#: gitk:858
 msgid "Lines of context"
 msgstr "Kontextzeilen"
=20
=2D#: gitk:900
+#: gitk:868
+msgid "Ignore space change"
+msgstr "Leerzeichen=C3=A4nderungen ignorieren"
+
+#: gitk:926
 msgid "Patch"
 msgstr "Patch"
=20
=2D#: gitk:902
+#: gitk:928
 msgid "Tree"
 msgstr "Baum"
=20
=2D#: gitk:1018 gitk:1033 gitk:5961
+#: gitk:1053 gitk:1068 gitk:6023
 msgid "Diff this -> selected"
 msgstr "Vergleich diese -> gew=C3=A4hlte"
=20
=2D#: gitk:1020 gitk:1035 gitk:5962
+#: gitk:1055 gitk:1070 gitk:6024
 msgid "Diff selected -> this"
 msgstr "Vergleich gew=C3=A4hlte -> diese"
=20
=2D#: gitk:1022 gitk:1037 gitk:5963
+#: gitk:1057 gitk:1072 gitk:6025
 msgid "Make patch"
 msgstr "Patch erstellen"
=20
=2D#: gitk:1023 gitk:6101
+#: gitk:1058 gitk:6163
 msgid "Create tag"
 msgstr "Markierung erstellen"
=20
=2D#: gitk:1024 gitk:6198
+#: gitk:1059 gitk:6256
 msgid "Write commit to file"
 msgstr "Version in Datei schreiben"
=20
=2D#: gitk:1025 gitk:6252
+#: gitk:1060 gitk:6310
 msgid "Create new branch"
 msgstr "Neuen Zweig erstellen"
=20
=2D#: gitk:1026
+#: gitk:1061
 msgid "Cherry-pick this commit"
 msgstr "Diese Version pfl=C3=BCcken"
=20
=2D#: gitk:1028
+#: gitk:1063
 msgid "Reset HEAD branch to here"
 msgstr "HEAD-Zweig auf diese Version zur=C3=BCcksetzen"
=20
=2D#: gitk:1044
+#: gitk:1079
 msgid "Check out this branch"
 msgstr "Auf diesen Zweig umstellen"
=20
=2D#: gitk:1046
+#: gitk:1081
 msgid "Remove this branch"
 msgstr "Zweig l=C3=B6schen"
=20
=2D#: gitk:1052
+#: gitk:1087
 msgid "Highlight this too"
 msgstr "Diesen auch hervorheben"
=20
=2D#: gitk:1054
+#: gitk:1089
 msgid "Highlight this only"
 msgstr "Nur diesen hervorheben"
=20
=2D#: gitk:1281
+#: gitk:1318
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -267,262 +271,425 @@ msgstr ""
 "License\n"
 "        "
=20
=2D#: gitk:1289 gitk:1350 gitk:6524
+#: gitk:1326 gitk:1387 gitk:6582
 msgid "Close"
 msgstr "Schlie=C3=9Fen"
=20
=2D#: gitk:1308
+#: gitk:1345
 msgid "Gitk key bindings"
 msgstr "Gitk Tastaturbelegung"
=20
=2D#: gitk:1858
+#: gitk:1347
+msgid "Gitk key bindings:"
+msgstr "Gitk Tastaturbelegung:"
+
+#: gitk:1349
+#, tcl-format
+msgid "<%s-Q>\t\tQuit"
+msgstr "<%s-Q>\t\tBeenden"
+
+#: gitk:1350
+msgid "<Home>\t\tMove to first commit"
+msgstr "<Pos1>\t\tZur neuesten Version springen"
+
+#: gitk:1351
+msgid "<End>\t\tMove to last commit"
+msgstr "<Ende>\t\tZur =C3=A4ltesten Version springen"
+
+#: gitk:1352
+msgid "<Up>, p, i\tMove up one commit"
+msgstr "<Hoch>, p, i\tN=C3=A4chste neuere Version"
+
+#: gitk:1353
+msgid "<Down>, n, k\tMove down one commit"
+msgstr "<Runter>, n, k\tN=C3=A4chste =C3=A4ltere Version"
+
+#: gitk:1354
+msgid "<Left>, z, j\tGo back in history list"
+msgstr "<Links>, z, j\tEine Version zur=C3=BCck gehen"
+
+#: gitk:1355
+msgid "<Right>, x, l\tGo forward in history list"
+msgstr "<Rechts>, x, l\tEine Version nach vorne gehen"
+
+#: gitk:1356
+msgid "<PageUp>\tMove up one page in commit list"
+msgstr "<BildHoch>\tEine Seite nach oben bl=C3=A4ttern"
+
+#: gitk:1357
+msgid "<PageDown>\tMove down one page in commit list"
+msgstr "<BildRunter>\tEine Seite nach unten bl=C3=A4ttern"
+
+#: gitk:1358
+#, tcl-format
+msgid "<%s-Home>\tScroll to top of commit list"
+msgstr "<%s-Pos1>\tZum oberen Ende der Versionsliste bl=C3=A4ttern"
+
+#: gitk:1359
+#, tcl-format
+msgid "<%s-End>\tScroll to bottom of commit list"
+msgstr "<%s-Ende>\tZum unteren Ende der Versionsliste bl=C3=A4ttern"
+
+#: gitk:1360
+#, tcl-format
+msgid "<%s-Up>\tScroll commit list up one line"
+msgstr "<%s-Hoch>\tVersionsliste eine Zeile nach oben bl=C3=A4ttern"
+
+#: gitk:1361
+#, tcl-format
+msgid "<%s-Down>\tScroll commit list down one line"
+msgstr "<%s-Runter>\tVersionsliste eine Zeile nach unten bl=C3=A4ttern"
+
+#: gitk:1362
+#, tcl-format
+msgid "<%s-PageUp>\tScroll commit list up one page"
+msgstr "<%s-BildHoch>\tVersionsliste eine Seite hoch bl=C3=A4ttern"
+
+#: gitk:1363
+#, tcl-format
+msgid "<%s-PageDown>\tScroll commit list down one page"
+msgstr "<%s-BildRunter>\tVersionsliste eine Seite nach unten bl=C3=A4ttern"
+
+#: gitk:1364
+msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
+msgstr "<Umschalt-Hoch>\tR=C3=BCckw=C3=A4rts suchen (nach oben; neuere Ver=
sionen)"
+
+#: gitk:1365
+msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
+msgstr "<Umschalt-Runter> Suchen (nach unten; =C3=A4ltere Versionen)"
+
+#: gitk:1366
+msgid "<Delete>, b\tScroll diff view up one page"
+msgstr "<Entf>, b\t\tVergleich eine Seite nach oben bl=C3=A4ttern"
+
+#: gitk:1367
+msgid "<Backspace>\tScroll diff view up one page"
+msgstr "<L=C3=B6schtaste>\tVergleich eine Seite nach oben bl=C3=A4ttern"
+
+#: gitk:1368
+msgid "<Space>\t\tScroll diff view down one page"
+msgstr "<Leertaste>\tVergleich eine Seite nach unten bl=C3=A4ttern"
+
+#: gitk:1369
+msgid "u\t\tScroll diff view up 18 lines"
+msgstr "u\t\tVergleich um 18 Zeilen nach oben (=C2=BBup=C2=AB) bl=C3=A4tte=
rn"
+
+#: gitk:1370
+msgid "d\t\tScroll diff view down 18 lines"
+msgstr "d\t\tVergleich um 18 Zeilen nach unten (=C2=BBdown=C2=AB) bl=C3=A4=
ttern"
+
+#: gitk:1371
+#, tcl-format
+msgid "<%s-F>\t\tFind"
+msgstr "<%s-F>\t\tSuchen"
+
+#: gitk:1372
+#, tcl-format
+msgid "<%s-G>\t\tMove to next find hit"
+msgstr "<%s-G>\t\tWeitersuchen"
+
+#: gitk:1373
+msgid "<Return>\tMove to next find hit"
+msgstr "<Eingabetaste>\tWeitersuchen"
+
+#: gitk:1374
+msgid "/\t\tMove to next find hit, or redo find"
+msgstr "/\t\tWeitersuchen oder neue Suche beginnen"
+
+#: gitk:1375
+msgid "?\t\tMove to previous find hit"
+msgstr "?\t\tR=C3=BCckw=C3=A4rts weitersuchen"
+
+#: gitk:1376
+msgid "f\t\tScroll diff view to next file"
+msgstr "f\t\tVergleich zur n=C3=A4chsten Datei (=C2=BBfile=C2=AB) bl=C3=A4=
ttern"
+
+#: gitk:1377
+#, tcl-format
+msgid "<%s-S>\t\tSearch for next hit in diff view"
+msgstr "<%s-S>\t\tWeitersuchen im Vergleich"
+
+#: gitk:1378
+#, tcl-format
+msgid "<%s-R>\t\tSearch for previous hit in diff view"
+msgstr "<%s-R>\t\tR=C3=BCckw=C3=A4rts weitersuchen im Vergleich"
+
+#: gitk:1379
+#, tcl-format
+msgid "<%s-KP+>\tIncrease font size"
+msgstr "<%s-Nummerblock-Plus>\tSchriftgr=C3=B6=C3=9Fe vergr=C3=B6=C3=9Fern"
+
+#: gitk:1380
+#, tcl-format
+msgid "<%s-plus>\tIncrease font size"
+msgstr "<%s-Plus>\tSchriftgr=C3=B6=C3=9Fe vergr=C3=B6=C3=9Fern"
+
+#: gitk:1381
+#, tcl-format
+msgid "<%s-KP->\tDecrease font size"
+msgstr "<%s-Nummernblock-> Schriftgr=C3=B6=C3=9Fe verkleinern"
+
+#: gitk:1382
+#, tcl-format
+msgid "<%s-minus>\tDecrease font size"
+msgstr "<%s-Minus>\tSchriftgr=C3=B6=C3=9Fe verkleinern"
+
+#: gitk:1383
+msgid "<F5>\t\tUpdate"
+msgstr "<F5>\t\tAktualisieren"
+
+#: gitk:1896
 msgid "Gitk view definition"
 msgstr "Gitk Ansichten"
=20
=2D#: gitk:1882
+#: gitk:1921
 msgid "Name"
 msgstr "Name"
=20
=2D#: gitk:1885
+#: gitk:1924
 msgid "Remember this view"
 msgstr "Diese Ansicht speichern"
=20
=2D#: gitk:1889
+#: gitk:1928
 msgid "Commits to include (arguments to git rev-list):"
 msgstr "Versionen anzeigen (Argumente von git-rev-list):"
=20
=2D#: gitk:1895
+#: gitk:1935
+msgid "Command to generate more commits to include:"
+msgstr "Versionsliste durch folgendes Kommando erzeugen lassen:"
+
+#: gitk:1942
 msgid "Enter files and directories to include, one per line:"
 msgstr "Folgende Dateien und Verzeichnisse anzeigen (eine pro Zeile):"
=20
=2D#: gitk:1942
+#: gitk:1989
 msgid "Error in commit selection arguments:"
 msgstr "Fehler in den ausgew=C3=A4hlten Versionen:"
=20
=2D#: gitk:1993 gitk:2079 gitk:2535 gitk:2549 gitk:3732 gitk:8620 gitk:8621
+#: gitk:2043 gitk:2127 gitk:2583 gitk:2597 gitk:3781 gitk:8689 gitk:8690
 msgid "None"
 msgstr "Keine"
=20
=2D#: gitk:2483 gitk:4287 gitk:5897 gitk:5912
+#: gitk:2531 gitk:4336 gitk:5959 gitk:5974
 msgid "Date"
 msgstr "Datum"
=20
=2D#: gitk:2483 gitk:4287
+#: gitk:2531 gitk:4336
 msgid "CDate"
 msgstr "Eintragedatum"
=20
=2D#: gitk:2632 gitk:2637
+#: gitk:2680 gitk:2685
 msgid "Descendant"
 msgstr "Abk=C3=B6mmling"
=20
=2D#: gitk:2633
+#: gitk:2681
 msgid "Not descendant"
 msgstr "Nicht Abk=C3=B6mmling"
=20
=2D#: gitk:2640 gitk:2645
+#: gitk:2688 gitk:2693
 msgid "Ancestor"
 msgstr "Vorg=C3=A4nger"
=20
=2D#: gitk:2641
+#: gitk:2689
 msgid "Not ancestor"
 msgstr "Nicht Vorg=C3=A4nger"
=20
=2D#: gitk:2875
+#: gitk:2924
 msgid "Local changes checked in to index but not committed"
 msgstr "Lokale =C3=84nderungen bereitgestellt, aber nicht eingetragen"
=20
=2D#: gitk:2905
+#: gitk:2954
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokale =C3=84nderungen, nicht bereitgestellt"
=20
=2D#: gitk:4256
+#: gitk:4305
 msgid "Searching"
 msgstr "Suchen"
=20
=2D#: gitk:4715
+#: gitk:4767
 msgid "Tags:"
 msgstr "Markierungen:"
=20
=2D#: gitk:4732 gitk:4738 gitk:5890
+#: gitk:4784 gitk:4790 gitk:5952
 msgid "Parent"
 msgstr "Eltern"
=20
=2D#: gitk:4743
+#: gitk:4795
 msgid "Child"
 msgstr "Kind"
=20
=2D#: gitk:4752
+#: gitk:4804
 msgid "Branch"
 msgstr "Zweig"
=20
=2D#: gitk:4755
+#: gitk:4807
 msgid "Follows"
 msgstr "Folgt auf"
=20
=2D#: gitk:4758
+#: gitk:4810
 msgid "Precedes"
 msgstr "Vorg=C3=A4nger von"
=20
=2D#: gitk:5040
+#: gitk:5094
 msgid "Error getting merge diffs:"
 msgstr "Fehler beim Laden des Vergleichs:"
=20
=2D#: gitk:5717
+#: gitk:5779
 msgid "Goto:"
 msgstr "Gehe zu:"
=20
=2D#: gitk:5719
+#: gitk:5781
 msgid "SHA1 ID:"
 msgstr "SHA1 Kennung:"
=20
=2D#: gitk:5744
+#: gitk:5806
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "Kurze SHA1-Kennung =C2=BB%s=C2=AB ist mehrdeutig"
=20
=2D#: gitk:5756
+#: gitk:5818
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "SHA1-Kennung =C2=BB%s=C2=AB unbekannt"
=20
=2D#: gitk:5758
+#: gitk:5820
 #, tcl-format
 msgid "Tag/Head %s is not known"
 msgstr "Markierung/Zweig =C2=BB%s=C2=AB ist unbekannt"
=20
=2D#: gitk:5900
+#: gitk:5962
 msgid "Children"
 msgstr "Kinder"
=20
=2D#: gitk:5957
+#: gitk:6019
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Zweig =C2=BB%s=C2=AB hierher zur=C3=BCcksetzen"
=20
=2D#: gitk:5988
+#: gitk:6050
 msgid "Top"
 msgstr "Oben"
=20
=2D#: gitk:5989
+#: gitk:6051
 msgid "From"
 msgstr "Von"
=20
=2D#: gitk:5994
+#: gitk:6056
 msgid "To"
 msgstr "bis"
=20
=2D#: gitk:6017
+#: gitk:6079
 msgid "Generate patch"
 msgstr "Patch erstellen"
=20
=2D#: gitk:6019
+#: gitk:6081
 msgid "From:"
 msgstr "Von:"
=20
=2D#: gitk:6028
+#: gitk:6090
 msgid "To:"
 msgstr "bis:"
=20
=2D#: gitk:6037
+#: gitk:6099
 msgid "Reverse"
 msgstr "Umgekehrt"
=20
=2D#: gitk:6039 gitk:6212
+#: gitk:6101 gitk:6270
 msgid "Output file:"
 msgstr "Ausgabedatei:"
=20
=2D#: gitk:6045
+#: gitk:6107
 msgid "Generate"
 msgstr "Erzeugen"
=20
=2D#: gitk:6081
+#: gitk:6143
 msgid "Error creating patch:"
 msgstr "Fehler beim Patch erzeugen:"
=20
=2D#: gitk:6103 gitk:6200 gitk:6254
+#: gitk:6165 gitk:6258 gitk:6312
 msgid "ID:"
 msgstr "ID:"
=20
=2D#: gitk:6112
+#: gitk:6174
 msgid "Tag name:"
 msgstr "Markierungsname:"
=20
=2D#: gitk:6116 gitk:6263
+#: gitk:6178 gitk:6321
 msgid "Create"
 msgstr "Erstellen"
=20
=2D#: gitk:6131
+#: gitk:6193
 msgid "No tag name specified"
 msgstr "Kein Markierungsname angegeben"
=20
=2D#: gitk:6135
+#: gitk:6197
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Markierung =C2=BB%s=C2=AB existiert bereits."
=20
=2D#: gitk:6145
+#: gitk:6203
 msgid "Error creating tag:"
 msgstr "Fehler bei Markierung erstellen:"
=20
=2D#: gitk:6209
+#: gitk:6267
 msgid "Command:"
 msgstr "Kommando:"
=20
=2D#: gitk:6217
+#: gitk:6275
 msgid "Write"
 msgstr "Schreiben"
=20
=2D#: gitk:6233
+#: gitk:6291
 msgid "Error writing commit:"
 msgstr "Fehler beim Version eintragen:"
=20
=2D#: gitk:6259
+#: gitk:6317
 msgid "Name:"
 msgstr "Name:"
=20
=2D#: gitk:6278
+#: gitk:6336
 msgid "Please specify a name for the new branch"
 msgstr "Bitte geben Sie einen Namen f=C3=BCr den neuen Zweig an."
=20
=2D#: gitk:6307
+#: gitk:6365
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
 msgstr ""
 "Version =C2=BB%s=C2=AB ist bereits im Zweig =C2=BB%s=C2=AB enthalten -- t=
rotzdem erneut "
 "eintragen?"
=20
=2D#: gitk:6312
+#: gitk:6370
 msgid "Cherry-picking"
 msgstr "Version pfl=C3=BCcken"
=20
=2D#: gitk:6324
+#: gitk:6382
 msgid "No changes committed"
 msgstr "Keine =C3=84nderungen eingetragen"
=20
=2D#: gitk:6347
+#: gitk:6405
 msgid "Confirm reset"
 msgstr "Zur=C3=BCcksetzen best=C3=A4tigen"
=20
=2D#: gitk:6349
+#: gitk:6407
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "Zweig =C2=BB%s=C2=AB auf =C2=BB%s=C2=AB zur=C3=BCcksetzen?"
=20
=2D#: gitk:6353
+#: gitk:6411
 msgid "Reset type:"
 msgstr "Art des Zur=C3=BCcksetzens:"
=20
=2D#: gitk:6357
+#: gitk:6415
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Harmlos: Arbeitskopie und Bereitstellung unver=C3=A4ndert"
=20
=2D#: gitk:6360
+#: gitk:6418
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr ""
 "Gemischt: Arbeitskopie unver=C3=A4ndert,\n"
 "Bereitstellung zur=C3=BCckgesetzt"
=20
=2D#: gitk:6363
+#: gitk:6421
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -530,21 +697,21 @@ msgstr ""
 "Hart: Arbeitskopie und Bereitstellung\n"
 "(Alle lokalen =C3=84nderungen werden gel=C3=B6scht)"
=20
=2D#: gitk:6379
+#: gitk:6437
 msgid "Resetting"
 msgstr "Zur=C3=BCcksetzen"
=20
=2D#: gitk:6436
+#: gitk:6494
 msgid "Checking out"
 msgstr "Umstellen"
=20
=2D#: gitk:6466
+#: gitk:6524
 msgid "Cannot delete the currently checked-out branch"
 msgstr ""
 "Der Zweig, auf den die Arbeitskopie momentan umgestellt ist, kann nicht "
 "gel=C3=B6scht werden."
=20
=2D#: gitk:6472
+#: gitk:6530
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -553,16 +720,16 @@ msgstr ""
 "Die Versionen auf Zweig =C2=BB%s=C2=AB existieren auf keinem anderen Zwei=
g.\n"
 "Zweig =C2=BB%s=C2=AB trotzdem l=C3=B6schen?"
=20
=2D#: gitk:6503
+#: gitk:6561
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Markierungen und Zweige: %s"
=20
=2D#: gitk:6517
+#: gitk:6575
 msgid "Filter"
 msgstr "Filtern"
=20
=2D#: gitk:6811
+#: gitk:6869
 msgid ""
 "Error reading commit topology information; branch and preceding/following=
 "
 "tag information will be incomplete."
@@ -570,113 +737,117 @@ msgstr ""
 "Fehler beim Lesen der Strukturinformationen; Zweige und Vorg=C3=A4nger/Na=
chfolger "
 "Informationen werden unvollst=C3=A4ndig sein."
=20
=2D#: gitk:7795
+#: gitk:7853
 msgid "Tag"
 msgstr "Markierung"
=20
=2D#: gitk:7795
+#: gitk:7853
 msgid "Id"
 msgstr "Id"
=20
=2D#: gitk:7835
+#: gitk:7893
 msgid "Gitk font chooser"
 msgstr "Gitk Schriften w=C3=A4hlen"
=20
=2D#: gitk:7852
+#: gitk:7910
 msgid "B"
 msgstr "F"
=20
=2D#: gitk:7855
+#: gitk:7913
 msgid "I"
 msgstr "K"
=20
=2D#: gitk:7948
+#: gitk:8006
 msgid "Gitk preferences"
 msgstr "Gitk Einstellungen"
=20
=2D#: gitk:7949
+#: gitk:8007
 msgid "Commit list display options"
 msgstr "Anzeige Versionsliste"
=20
=2D#: gitk:7952
+#: gitk:8010
 msgid "Maximum graph width (lines)"
 msgstr "Maximale Graphenbreite (Zeilen)"
=20
=2D#: gitk:7956
+#: gitk:8014
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Maximale Graphenbreite (% des Fensters)"
=20
=2D#: gitk:7961
+#: gitk:8019
 msgid "Show local changes"
 msgstr "Lokale =C3=84nderungen anzeigen"
=20
=2D#: gitk:7966
+#: gitk:8024
+msgid "Auto-select SHA1"
+msgstr "SHA1 Hashwert automatisch markieren"
+
+#: gitk:8029
 msgid "Diff display options"
 msgstr "Anzeige Vergleich"
=20
=2D#: gitk:7968
+#: gitk:8031
 msgid "Tab spacing"
 msgstr "Tabulatorbreite"
=20
=2D#: gitk:7972
+#: gitk:8035
 msgid "Display nearby tags"
 msgstr "Naheliegende =C3=9Cberschriften anzeigen"
=20
=2D#: gitk:7977
+#: gitk:8040
 msgid "Limit diffs to listed paths"
 msgstr "Vergleich nur f=C3=BCr angezeigte Pfade"
=20
=2D#: gitk:7982
+#: gitk:8045
 msgid "Colors: press to choose"
 msgstr "Farben: Klicken zum W=C3=A4hlen"
=20
=2D#: gitk:7985
+#: gitk:8048
 msgid "Background"
 msgstr "Vordergrund"
=20
=2D#: gitk:7989
+#: gitk:8052
 msgid "Foreground"
 msgstr "Hintergrund"
=20
=2D#: gitk:7993
+#: gitk:8056
 msgid "Diff: old lines"
 msgstr "Vergleich: Alte Zeilen"
=20
=2D#: gitk:7998
+#: gitk:8061
 msgid "Diff: new lines"
 msgstr "Vergleich: Neue Zeilen"
=20
=2D#: gitk:8003
+#: gitk:8066
 msgid "Diff: hunk header"
 msgstr "Vergleich: =C3=84nderungstitel"
=20
=2D#: gitk:8009
+#: gitk:8072
 msgid "Select bg"
 msgstr "Hintergrundfarbe Ausw=C3=A4hlen"
=20
=2D#: gitk:8013
+#: gitk:8076
 msgid "Fonts: press to choose"
 msgstr "Schriftart: Klicken zum W=C3=A4hlen"
=20
=2D#: gitk:8015
+#: gitk:8078
 msgid "Main font"
 msgstr "Programmschriftart"
=20
=2D#: gitk:8016
+#: gitk:8079
 msgid "Diff display font"
 msgstr "Vergleich"
=20
=2D#: gitk:8017
+#: gitk:8080
 msgid "User interface font"
 msgstr "Beschriftungen"
=20
=2D#: gitk:8033
+#: gitk:8096
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: Farbe w=C3=A4hlen f=C3=BCr %s"
=20
=2D#: gitk:8414
+#: gitk:8477
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
@@ -684,35 +855,35 @@ msgstr ""
 "Gitk l=C3=A4uft nicht mit dieser Version von Tcl/Tk.\n"
 "Gitk ben=C3=B6tigt mindestens Tcl/Tk 8.4."
=20
=2D#: gitk:8501
+#: gitk:8566
 msgid "Cannot find a git repository here."
 msgstr "Kein Git-Projektarchiv gefunden."
=20
=2D#: gitk:8505
+#: gitk:8570
 #, tcl-format
 msgid "Cannot find the git directory \"%s\"."
 msgstr "Git-Verzeichnis =C2=BB%s=C2=AB wurde nicht gefunden."
=20
=2D#: gitk:8544
+#: gitk:8613
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Mehrdeutige Angabe =C2=BB%s=C2=AB: Sowohl Version als auch Dateina=
me existiert."
=20
=2D#: gitk:8556
+#: gitk:8625
 msgid "Bad arguments to gitk:"
 msgstr "Falsche Kommandozeilen-Parameter f=C3=BCr gitk:"
=20
=2D#: gitk:8568
+#: gitk:8637
 msgid "Couldn't get list of unmerged files:"
 msgstr "Liste der nicht-zusammengef=C3=BChrten Dateien nicht gefunden:"
=20
=2D#: gitk:8584
+#: gitk:8653
 msgid "No files selected: --merge specified but no files are unmerged."
 msgstr ""
 "Keine Dateien ausgew=C3=A4hle: --merge angegeben, es existieren aber kein=
e nicht-"
 "zusammengef=C3=BChrten Dateien."
=20
=2D#: gitk:8587
+#: gitk:8656
 msgid ""
 "No files selected: --merge specified but no unmerged files are within fil=
e "
 "limit."
@@ -720,6 +891,6 @@ msgstr ""
 "Keine Dateien ausgew=C3=A4hle: --merge angegeben, aber keine nicht-"
 "zusammengef=C3=BChrten Dateien sind in der Dateiauswahl."
=20
=2D#: gitk:8646
+#: gitk:8717
 msgid "Command line"
 msgstr "Kommandozeile"
=2D-=20
1.5.4.2.133.g3d51e


--Boundary-00=_S0hGIvM6ReqkAb/--

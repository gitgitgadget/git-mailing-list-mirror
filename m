From: Mikael Magnusson <mikachu@gmail.com>
Subject: [PATCH v2] gitk: Update swedish translation.
Date: Thu, 25 Sep 2008 14:17:07 +0200 (CEST)
Message-ID: <alpine.LNX.1.00.0809251413300.11806@localhost>
References: <237967ef0809232333y40e36d6bs3205091e3baa701c@mail.gmail.com>  <Pine.LNX.4.64.0809241527170.22419@ds9.cixit.se>  <237967ef0809240746n25c74e9ambb2c512e96e006ca@mail.gmail.com>  <Pine.LNX.4.64.0809250940120.5683@ds9.cixit.se>
 <237967ef0809250328q630dc36dj8aa3d3a9bc1f63ca@mail.gmail.com> <Pine.LNX.4.64.0809251247450.5683@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-12967266-1222345028=:11806"
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Sep 25 14:18:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kipnb-0005y6-V6
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 14:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbYIYMRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 08:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752626AbYIYMRO
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 08:17:14 -0400
Received: from mail.bredband2.net ([82.209.166.4]:24570 "EHLO
	smtp.bredband2.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751669AbYIYMRL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 08:17:11 -0400
Received: (qmail 2850 invoked from network); 25 Sep 2008 12:18:16 -0000
Received: from lkf-194-200-233-83.3.cust.bredband2.com (HELO mika.l3ib.org) ([83.233.200.194])
          (envelope-sender <mikachu@gmail.com>)
          by smtp.bredband2.net (qmail-ldap-1.03) with SMTP
          for <peter@softwolves.pp.se>; 25 Sep 2008 12:18:16 -0000
In-Reply-To: <Pine.LNX.4.64.0809251247450.5683@ds9.cixit.se>
User-Agent: Alpine 1.00 (LNX )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96754>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-12967266-1222345028=:11806
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Signed-off-by: Mikael Magnusson <mikachu@gmail.com>

---
This should be incorporating all the changes we discussed.

 po/sv.po |  462 +++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 250 insertions(+), 212 deletions(-)

diff --git a/po/sv.po b/po/sv.po
index e1ecfb7..50a508e 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: sv\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-08-03 18:58+0200\n"
+"POT-Creation-Date: 2008-09-24 08:23+0200\n"
-"PO-Revision-Date: 2008-08-03 19:03+0200\n"
+"PO-Revision-Date: 2008-09-25 14:15+0200\n"
 "Last-Translator: Mikael Magnusson <mikachu@gmail.com>\n"
 "Language-Team: Swedish <sv@li.org>\n"
@@ -16,17 +16,25 @@ msgstr ""
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"

-#: gitk:102
+#: gitk:113
 msgid "Couldn't get list of unmerged files:"
 msgstr "Kunde inta hämta lista över ej sammanslagna filer:"

-#: gitk:329
+#: gitk:272
+msgid "Error parsing revisions:"
+msgstr "Fel vid tolkning av revisioner:"
+
+#: gitk:327
+msgid "Error executing --argscmd command:"
+msgstr "Fel vid körning av --argscmd-kommandot:"
+
+#: gitk:340
 msgid "No files selected: --merge specified but no files are unmerged."
 msgstr ""
 "Inga filer valdes: --merge angavs men det finns inga filer som inte har "
 "slagits samman."

-#: gitk:332
+#: gitk:343
 msgid ""
 "No files selected: --merge specified but no unmerged files are within file "
 "limit."
@@ -34,257 +42,261 @@ msgstr ""
 "Inga filer valdes: --merge angavs men det finns inga filer inom "
 "filbegränsningen."

-#: gitk:354
+#: gitk:365 gitk:503
 msgid "Error executing git log:"
 msgstr "Fel vid körning av git log:"

-#: gitk:369
+#: gitk:378
 msgid "Reading"
 msgstr "Läser"

-#: gitk:400 gitk:3356
+#: gitk:438 gitk:3433
 msgid "Reading commits..."
 msgstr "Läser incheckningar..."

-#: gitk:403 gitk:1480 gitk:3359
+#: gitk:441 gitk:1528 gitk:3436
 msgid "No commits selected"
 msgstr "Inga incheckningar markerade"

-#: gitk:1358
+#: gitk:1399
 msgid "Can't parse git log output:"
 msgstr "Kan inte tolka utdata från git log:"

-#: gitk:1557
+#: gitk:1605
 msgid "No commit information available"
 msgstr "Ingen incheckningsinformation är tillgänglig"

-#: gitk:1654 gitk:1676 gitk:3150 gitk:7620 gitk:9149 gitk:9317
+#: gitk:1709 gitk:1731 gitk:3230 gitk:7701 gitk:9230 gitk:9398
 msgid "OK"
 msgstr "OK"

-#: gitk:1678 gitk:3151 gitk:7296 gitk:7367 gitk:7470 gitk:7516 gitk:7622
-#: gitk:9150 gitk:9318
+#: gitk:1733 gitk:3231 gitk:7377 gitk:7448 gitk:7551 gitk:7597 gitk:7703
+#: gitk:9231 gitk:9399
 msgid "Cancel"
 msgstr "Avbryt"

-#: gitk:1716
+#: gitk:1771
 msgid "File"
 msgstr "Arkiv"

-#: gitk:1718
+#: gitk:1773
 msgid "Update"
 msgstr "Uppdatera"

-#: gitk:1719
+#: gitk:1774
 msgid "Reload"
 msgstr "Ladda om"

-#: gitk:1720
+#: gitk:1775
 msgid "Reread references"
 msgstr "Läs om referenser"

-#: gitk:1721
+#: gitk:1776
 msgid "List references"
 msgstr "Visa referenser"

-#: gitk:1722
+#: gitk:1777
 msgid "Quit"
 msgstr "Avsluta"

-#: gitk:1724
+#: gitk:1779
 msgid "Edit"
 msgstr "Redigera"

-#: gitk:1725
+#: gitk:1780
 msgid "Preferences"
 msgstr "Inställningar"

-#: gitk:1728 gitk:3087
+#: gitk:1783 gitk:3167
 msgid "View"
 msgstr "Visa"

-#: gitk:1729
+#: gitk:1784
 msgid "New view..."
 msgstr "Ny vy..."

-#: gitk:1730 gitk:3298 gitk:9932
+#: gitk:1785 gitk:3378 gitk:10030
 msgid "Edit view..."
 msgstr "Ändra vy..."

-#: gitk:1732 gitk:3299 gitk:9933
+#: gitk:1787 gitk:3379 gitk:10031
 msgid "Delete view"
 msgstr "Ta bort vy"

-#: gitk:1734
+#: gitk:1789
 msgid "All files"
 msgstr "Alla filer"

-#: gitk:1738
+#: gitk:1793
 msgid "Help"
 msgstr "Hjälp"

-#: gitk:1739 gitk:2399
+#: gitk:1794 gitk:2458
 msgid "About gitk"
 msgstr "Om gitk"

-#: gitk:1740
+#: gitk:1795
 msgid "Key bindings"
 msgstr "Tangentbordsbindningar"

-#: gitk:1797
+#: gitk:1852
 msgid "SHA1 ID: "
 msgstr "SHA1-id: "

-#: gitk:1828
+#: gitk:1883
 msgid "Row"
 msgstr "Rad"

-#: gitk:1859
+#: gitk:1914
 msgid "Find"
 msgstr "Sök"

-#: gitk:1860
+#: gitk:1915
 msgid "next"
 msgstr "nästa"

-#: gitk:1861
+#: gitk:1916
 msgid "prev"
 msgstr "föreg"

-#: gitk:1862
+#: gitk:1917
 msgid "commit"
 msgstr "incheckning"

-#: gitk:1865 gitk:1867 gitk:3511 gitk:3534 gitk:3558 gitk:5441 gitk:5512
+#: gitk:1920 gitk:1922 gitk:3588 gitk:3611 gitk:3635 gitk:5521 gitk:5592
 msgid "containing:"
 msgstr "som innehåller:"

-#: gitk:1868 gitk:2866 gitk:2871 gitk:3586
+#: gitk:1923 gitk:2925 gitk:2930 gitk:3663
 msgid "touching paths:"
 msgstr "som rör sökväg:"

-#: gitk:1869 gitk:3591
+#: gitk:1924 gitk:3668
 msgid "adding/removing string:"
 msgstr "som lägger/till tar bort sträng:"

-#: gitk:1878 gitk:1880
+#: gitk:1933 gitk:1935
 msgid "Exact"
 msgstr "Exakt"

-#: gitk:1880 gitk:3667 gitk:5409
+#: gitk:1935 gitk:3744 gitk:5489
 msgid "IgnCase"
 msgstr "IgnVersaler"

-#: gitk:1880 gitk:3560 gitk:3665 gitk:5405
+#: gitk:1935 gitk:3637 gitk:3742 gitk:5485
 msgid "Regexp"
 msgstr "Reg.uttr."

-#: gitk:1882 gitk:1883 gitk:3686 gitk:3716 gitk:3723 gitk:5532 gitk:5599
+#: gitk:1937 gitk:1938 gitk:3763 gitk:3793 gitk:3800 gitk:5612 gitk:5679
 msgid "All fields"
 msgstr "Alla fält"

-#: gitk:1883 gitk:3684 gitk:3716 gitk:5471
+#: gitk:1938 gitk:3761 gitk:3793 gitk:5551
 msgid "Headline"
 msgstr "Rubrik"

-#: gitk:1884 gitk:3684 gitk:5471 gitk:5599 gitk:6000
+#: gitk:1939 gitk:3761 gitk:5551 gitk:5679 gitk:6080
 msgid "Comments"
 msgstr "Kommentarer"

-#: gitk:1884 gitk:3684 gitk:3688 gitk:3723 gitk:5471 gitk:5936 gitk:7142
-#: gitk:7157
+#: gitk:1939 gitk:3761 gitk:3765 gitk:3800 gitk:5551 gitk:6016 gitk:7223
+#: gitk:7238
 msgid "Author"
 msgstr "Författare"

-#: gitk:1884 gitk:3684 gitk:5471 gitk:5938
+#: gitk:1939 gitk:3761 gitk:5551 gitk:6018
 msgid "Committer"
 msgstr "Incheckare"

-#: gitk:1913
+#: gitk:1968
 msgid "Search"
 msgstr "Sök"

-#: gitk:1920
+#: gitk:1975
 msgid "Diff"
 msgstr "Diff"

-#: gitk:1922
+#: gitk:1977
 msgid "Old version"
 msgstr "Gammal version"

-#: gitk:1924
+#: gitk:1979
 msgid "New version"
 msgstr "Ny version"

-#: gitk:1926
+#: gitk:1981
 msgid "Lines of context"
 msgstr "Rader sammanhang"

-#: gitk:1936
+#: gitk:1991
 msgid "Ignore space change"
 msgstr "Ignorera ändringar i blanksteg"

-#: gitk:1994
+#: gitk:2049
 msgid "Patch"
 msgstr "Patch"

-#: gitk:1996
+#: gitk:2051
 msgid "Tree"
 msgstr "Träd"

-#: gitk:2121 gitk:2136 gitk:7211
+#: gitk:2178 gitk:2193 gitk:7292
 msgid "Diff this -> selected"
 msgstr "Diff denna -> markerad"

-#: gitk:2123 gitk:2138 gitk:7212
+#: gitk:2180 gitk:2195 gitk:7293
 msgid "Diff selected -> this"
 msgstr "Diff markerad -> denna"

-#: gitk:2125 gitk:2140 gitk:7213
+#: gitk:2182 gitk:2197 gitk:7294
 msgid "Make patch"
 msgstr "Skapa patch"

-#: gitk:2126 gitk:7351
+#: gitk:2183 gitk:7432
 msgid "Create tag"
 msgstr "Skapa tagg"

-#: gitk:2127 gitk:7450
+#: gitk:2184 gitk:7531
 msgid "Write commit to file"
 msgstr "Skriv incheckning till fil"

-#: gitk:2128 gitk:7504
+#: gitk:2185 gitk:7585
 msgid "Create new branch"
 msgstr "Skapa ny gren"

-#: gitk:2129
+#: gitk:2186
 msgid "Cherry-pick this commit"
 msgstr "Plocka denna incheckning"

-#: gitk:2131
+#: gitk:2188
 msgid "Reset HEAD branch to here"
 msgstr "Återställ HEAD-grenen hit"

-#: gitk:2147
+#: gitk:2204
 msgid "Check out this branch"
 msgstr "Checka ut denna gren"

-#: gitk:2149
+#: gitk:2206
 msgid "Remove this branch"
 msgstr "Ta bort denna gren"

-#: gitk:2155
+#: gitk:2212
 msgid "Highlight this too"
 msgstr "Markera även detta"

-#: gitk:2157
+#: gitk:2214
 msgid "Highlight this only"
 msgstr "Markera bara detta"

-#: gitk:2159
+#: gitk:2216
 msgid "External diff"
 msgstr "Extern diff"

-#: gitk:2400
+#: gitk:2218
+msgid "Blame parent commit"
+msgstr "Annotera föregående incheckning"
+
+#: gitk:2459
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -300,427 +312,453 @@ msgstr ""
 "\n"
 "Använd och vidareförmedla enligt villkoren i GNU General Public License"

-#: gitk:2408 gitk:2469 gitk:7799
+#: gitk:2467 gitk:2528 gitk:7880
 msgid "Close"
 msgstr "Stäng"

-#: gitk:2427
+#: gitk:2486
 msgid "Gitk key bindings"
 msgstr "Tangentbordsbindningar för Gitk"

-#: gitk:2429
+#: gitk:2488
 msgid "Gitk key bindings:"
 msgstr "Tangentbordsbindningar för Gitk:"

-#: gitk:2431
+#: gitk:2490
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tAvsluta"

-#: gitk:2432
+#: gitk:2491
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Home>\t\tGå till första incheckning"

-#: gitk:2433
+#: gitk:2492
 msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\tGå till sista incheckning"

-#: gitk:2434
+#: gitk:2493
 msgid "<Up>, p, i\tMove up one commit"
 msgstr "<Upp>, p, i\tGå en incheckning upp"

-#: gitk:2435
+#: gitk:2494
 msgid "<Down>, n, k\tMove down one commit"
 msgstr "<Ned>, n, k\tGå en incheckning ned"

-#: gitk:2436
+#: gitk:2495
 msgid "<Left>, z, j\tGo back in history list"
 msgstr "<Vänster>, z, j\tGå bakåt i historiken"

-#: gitk:2437
+#: gitk:2496
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Höger>, x, l\tGå framåt i historiken"

-#: gitk:2438
+#: gitk:2497
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<PageUp>\tGå upp en sida i incheckningslistan"

-#: gitk:2439
+#: gitk:2498
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<PageDown>\tGå ned en sida i incheckningslistan"

-#: gitk:2440
+#: gitk:2499
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Home>\tRulla till början av incheckningslistan"

-#: gitk:2441
+#: gitk:2500
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-End>\tRulla till slutet av incheckningslistan"

-#: gitk:2442
+#: gitk:2501
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Upp>\tRulla incheckningslistan upp ett steg"

-#: gitk:2443
+#: gitk:2502
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Ned>\tRulla incheckningslistan ned ett steg"

-#: gitk:2444
+#: gitk:2503
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-PageUp>\tRulla incheckningslistan upp en sida"

-#: gitk:2445
+#: gitk:2504
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-PageDown>\tRulla incheckningslistan ned en sida"

-#: gitk:2446
+#: gitk:2505
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Skift-Upp>\tSök bakåt (uppåt, senare incheckningar)"

-#: gitk:2447
+#: gitk:2506
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr "<Skift-Ned>\tSök framåt (nedåt, tidigare incheckningar)"

-#: gitk:2448
+#: gitk:2507
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Delete>, b\tRulla diffvisningen upp en sida"

-#: gitk:2449
+#: gitk:2508
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<Baksteg>\tRulla diffvisningen upp en sida"

-#: gitk:2450
+#: gitk:2509
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Blanksteg>\tRulla diffvisningen ned en sida"

-#: gitk:2451
+#: gitk:2510
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\tRulla diffvisningen upp 18 rader"

-#: gitk:2452
+#: gitk:2511
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\tRulla diffvisningen ned 18 rader"

-#: gitk:2453
+#: gitk:2512
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tSök"

-#: gitk:2454
+#: gitk:2513
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tGå till nästa sökträff"

-#: gitk:2455
+#: gitk:2514
 msgid "<Return>\tMove to next find hit"
 msgstr "<Return>\t\tGå till nästa sökträff"

-#: gitk:2456
+#: gitk:2515
 msgid "/\t\tMove to next find hit, or redo find"
 msgstr "/\t\tGå till nästa sökträff, eller sök på nytt"

-#: gitk:2457
+#: gitk:2516
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tGå till föregående sökträff"

-#: gitk:2458
+#: gitk:2517
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tRulla diffvisningen till nästa fil"

-#: gitk:2459
+#: gitk:2518
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tGå till nästa sökträff i diffvisningen"

-#: gitk:2460
+#: gitk:2519
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tGå till föregående sökträff i diffvisningen"

-#: gitk:2461
+#: gitk:2520
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-Num+>\tÖka teckenstorlek"

-#: gitk:2462
+#: gitk:2521
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-plus>\tÖka teckenstorlek"

-#: gitk:2463
+#: gitk:2522
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-Num->\tMinska teckenstorlek"

-#: gitk:2464
+#: gitk:2523
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-minus>\tMinska teckenstorlek"

-#: gitk:2465
+#: gitk:2524
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tUppdatera"

-#: gitk:3091
+#: gitk:2940
+#, tcl-format
+msgid "Error getting \"%s\" from %s:"
+msgstr "Fel vid hämtning av \"%s\" från %s:"
+
+#: gitk:2997 gitk:3006
+#, tcl-format
+msgid "Error creating temporary directory %s:"
+msgstr "Fel när tillfällig katalog %s skulle skapas:"
+
+#: gitk:3019
+msgid "command failed:"
+msgstr "kommando misslyckades:"
+
+#: gitk:3039
+msgid "No such commit"
+msgstr "Ingen sådan incheckning finns"
+
+#: gitk:3044
+msgid "git gui blame: command failed:"
+msgstr "git gui blame: kommandot misslyckades:"
+
+#: gitk:3053
+msgid "External diff viewer failed:"
+msgstr "Externt diff-verktyg misslyckades:"
+
+#: gitk:3171
 msgid "Gitk view definition"
 msgstr "Definition av Gitk-vy"

-#: gitk:3116
+#: gitk:3196
 msgid "Name"
 msgstr "Namn"

-#: gitk:3119
+#: gitk:3199
 msgid "Remember this view"
 msgstr "Spara denna vy"

-#: gitk:3123
+#: gitk:3203
 msgid "Commits to include (arguments to git log):"
 msgstr "Incheckningar att ta med (argument till git log):"

-#: gitk:3130
+#: gitk:3210
 msgid "Command to generate more commits to include:"
 msgstr "Kommando för att generera fler incheckningar att ta med:"

-#: gitk:3137
+#: gitk:3217
 msgid "Enter files and directories to include, one per line:"
 msgstr "Ange filer och kataloger att ta med, en per rad:"

-#: gitk:3184
+#: gitk:3264
 msgid "Error in commit selection arguments:"
 msgstr "Fel i argument för val av incheckningar:"

-#: gitk:3238 gitk:3290 gitk:3736 gitk:3750 gitk:4951 gitk:9896 gitk:9897
+#: gitk:3318 gitk:3370 gitk:3813 gitk:3827 gitk:5031 gitk:9994 gitk:9995
 msgid "None"
 msgstr "Inget"

-#: gitk:3684 gitk:5471 gitk:7144 gitk:7159
+#: gitk:3761 gitk:5551 gitk:7225 gitk:7240
 msgid "Date"
 msgstr "Datum"

-#: gitk:3684 gitk:5471
+#: gitk:3761 gitk:5551
 msgid "CDate"
 msgstr "Skapat datum"

-#: gitk:3833 gitk:3838
+#: gitk:3910 gitk:3915
 msgid "Descendant"
 msgstr "Avkomling"

-#: gitk:3834
+#: gitk:3911
 msgid "Not descendant"
 msgstr "Inte avkomling"

-#: gitk:3841 gitk:3846
+#: gitk:3918 gitk:3923
 msgid "Ancestor"
 msgstr "Förfader"

-#: gitk:3842
+#: gitk:3919
 msgid "Not ancestor"
 msgstr "Inte förfader"

-#: gitk:4078
+#: gitk:4158
 msgid "Local changes checked in to index but not committed"
 msgstr "Lokala ändringar sparade i indexet men inte incheckade"

-#: gitk:4111
+#: gitk:4191
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokala ändringar, ej sparade i indexet"

-#: gitk:5440
+#: gitk:5520
 msgid "Searching"
 msgstr "Söker"

-#: gitk:5940
+#: gitk:6020
 msgid "Tags:"
 msgstr "Taggar:"

-#: gitk:5957 gitk:5963 gitk:7137
+#: gitk:6037 gitk:6043 gitk:7218
 msgid "Parent"
 msgstr "Förälder"

-#: gitk:5968
+#: gitk:6048
 msgid "Child"
 msgstr "Barn"

-#: gitk:5977
+#: gitk:6057
 msgid "Branch"
 msgstr "Gren"

-#: gitk:5980
+#: gitk:6060
 msgid "Follows"
 msgstr "Följer"

-#: gitk:5983
+#: gitk:6063
 msgid "Precedes"
 msgstr "Föregår"

-#: gitk:6267
+#: gitk:6347
 msgid "Error getting merge diffs:"
 msgstr "Fel vid hämtning av sammanslagningsdiff:"

-#: gitk:6970
+#: gitk:7051
 msgid "Goto:"
 msgstr "Gå till:"

-#: gitk:6972
+#: gitk:7053
 msgid "SHA1 ID:"
 msgstr "SHA1-id:"

-#: gitk:6991
+#: gitk:7072
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "Förkortat SHA1-id %s är tvetydigt"

-#: gitk:7003
+#: gitk:7084
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "SHA-id:t %s är inte känt"

-#: gitk:7005
+#: gitk:7086
 #, tcl-format
 msgid "Tag/Head %s is not known"
 msgstr "Tagg/huvud %s är okänt"

-#: gitk:7147
+#: gitk:7228
 msgid "Children"
 msgstr "Barn"

-#: gitk:7204
+#: gitk:7285
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Återställ grenen %s hit"

-#: gitk:7206
+#: gitk:7287
 msgid "Detached head: can't reset"
 msgstr "Frånkopplad head: kan inte återställa"

-#: gitk:7238
+#: gitk:7319
 msgid "Top"
 msgstr "Topp"

-#: gitk:7239
+#: gitk:7320
 msgid "From"
 msgstr "Från"

-#: gitk:7244
+#: gitk:7325
 msgid "To"
 msgstr "Till"

-#: gitk:7267
+#: gitk:7348
 msgid "Generate patch"
 msgstr "Generera patch"

-#: gitk:7269
+#: gitk:7350
 msgid "From:"
 msgstr "Från:"

-#: gitk:7278
+#: gitk:7359
 msgid "To:"
 msgstr "Till:"

-#: gitk:7287
+#: gitk:7368
 msgid "Reverse"
 msgstr "Vänd"

-#: gitk:7289 gitk:7464
+#: gitk:7370 gitk:7545
 msgid "Output file:"
 msgstr "Utdatafil:"

-#: gitk:7295
+#: gitk:7376
 msgid "Generate"
 msgstr "Generera"

-#: gitk:7331
+#: gitk:7412
 msgid "Error creating patch:"
 msgstr "Fel vid generering av patch:"

-#: gitk:7353 gitk:7452 gitk:7506
+#: gitk:7434 gitk:7533 gitk:7587
 msgid "ID:"
 msgstr "Id:"

-#: gitk:7362
+#: gitk:7443
 msgid "Tag name:"
 msgstr "Taggnamn:"

-#: gitk:7366 gitk:7515
+#: gitk:7447 gitk:7596
 msgid "Create"
 msgstr "Skapa"

-#: gitk:7381
+#: gitk:7462
 msgid "No tag name specified"
 msgstr "Inget taggnamn angavs"

-#: gitk:7385
+#: gitk:7466
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Taggen \"%s\" finns redan"

-#: gitk:7391
+#: gitk:7472
 msgid "Error creating tag:"
-msgstr "Fel vid skapande av tagg:"
+msgstr "Fel n? tagg skulle skapas:"

-#: gitk:7461
+#: gitk:7542
 msgid "Command:"
 msgstr "Kommando:"

-#: gitk:7469
+#: gitk:7550
 msgid "Write"
 msgstr "Skriv"

-#: gitk:7485
+#: gitk:7566
 msgid "Error writing commit:"
 msgstr "Fel vid skrivning av incheckning:"

-#: gitk:7511
+#: gitk:7592
 msgid "Name:"
 msgstr "Namn:"

-#: gitk:7530
+#: gitk:7611
 msgid "Please specify a name for the new branch"
 msgstr "Ange ett namn för den nya grenen"

-#: gitk:7559
+#: gitk:7640
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
 msgstr ""
 "Incheckningen %s finns redan på grenen %s -- skall den verkligen appliceras "
 "på nytt?"

-#: gitk:7564
+#: gitk:7645
 msgid "Cherry-picking"
 msgstr "Plockar"

-#: gitk:7576
+#: gitk:7657
 msgid "No changes committed"
 msgstr "Inga ändringar incheckade"

-#: gitk:7601
+#: gitk:7682
 msgid "Confirm reset"
 msgstr "Bekräfta återställning"

-#: gitk:7603
+#: gitk:7684
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "Återställa grenen %s till %s?"

-#: gitk:7607
+#: gitk:7688
 msgid "Reset type:"
 msgstr "Typ av återställning:"

-#: gitk:7611
+#: gitk:7692
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Mjuk: Rör inte utcheckning och index"

-#: gitk:7614
+#: gitk:7695
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr "Blandad: Rör inte utcheckning, återställ index"

-#: gitk:7617
+#: gitk:7698
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -728,19 +766,19 @@ msgstr ""
 "Hård: Återställ utcheckning och index\n"
 "(förkastar ALLA lokala ändringar)"

-#: gitk:7633
+#: gitk:7714
 msgid "Resetting"
 msgstr "Återställer"

-#: gitk:7690
+#: gitk:7771
 msgid "Checking out"
 msgstr "Checkar ut"

-#: gitk:7741
+#: gitk:7822
 msgid "Cannot delete the currently checked-out branch"
 msgstr "Kan inte ta bort den just nu utcheckade grenen"

-#: gitk:7747
+#: gitk:7828
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -749,16 +787,16 @@ msgstr ""
 "Incheckningarna på grenen %s existerar inte på någon annan gren.\n"
 "Vill du verkligen ta bort grenen %s?"

-#: gitk:7778
+#: gitk:7859
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Taggar och huvuden: %s"

-#: gitk:7792
+#: gitk:7873
 msgid "Filter"
 msgstr "Filter"

-#: gitk:8086
+#: gitk:8167
 msgid ""
 "Error reading commit topology information; branch and preceding/following "
 "tag information will be incomplete."
@@ -766,125 +804,125 @@ msgstr ""
 "Fel vid läsning av information om incheckningstopologi; information om "
 "grenar och föregående/senare taggar kommer inte vara komplett."

-#: gitk:9072
+#: gitk:9153
 msgid "Tag"
 msgstr "Tagg"

-#: gitk:9072
+#: gitk:9153
 msgid "Id"
 msgstr "Id"

-#: gitk:9118
+#: gitk:9199
 msgid "Gitk font chooser"
 msgstr "Teckensnittsväljare för Gitk"

-#: gitk:9135
+#: gitk:9216
 msgid "B"
 msgstr "F"

-#: gitk:9138
+#: gitk:9219
 msgid "I"
 msgstr "K"

-#: gitk:9231
+#: gitk:9312
 msgid "Gitk preferences"
 msgstr "Inställningar för Gitk"

-#: gitk:9232
+#: gitk:9313
 msgid "Commit list display options"
 msgstr "Alternativ för incheckningslistvy"

-#: gitk:9235
+#: gitk:9316
 msgid "Maximum graph width (lines)"
 msgstr "Maximal grafbredd (rader)"

-#: gitk:9239
+#: gitk:9320
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Maximal grafbredd (% av ruta)"

-#: gitk:9244
+#: gitk:9325
 msgid "Show local changes"
 msgstr "Visa lokala ändringar"

-#: gitk:9249
+#: gitk:9330
 msgid "Auto-select SHA1"
 msgstr "Välj SHA1 automatiskt"

-#: gitk:9254
+#: gitk:9335
 msgid "Diff display options"
 msgstr "Alternativ för diffvy"

-#: gitk:9256
+#: gitk:9337
 msgid "Tab spacing"
 msgstr "Blanksteg för tabulatortecken"

-#: gitk:9260
+#: gitk:9341
 msgid "Display nearby tags"
 msgstr "Visa närliggande taggar"

-#: gitk:9265
+#: gitk:9346
 msgid "Limit diffs to listed paths"
 msgstr "Begränsa diff till listade sökvägar"

-#: gitk:9272
+#: gitk:9353
 msgid "External diff tool"
 msgstr "Externt diff-verktyg"

-#: gitk:9274
+#: gitk:9355
 msgid "Choose..."
 msgstr "Välj..."

-#: gitk:9279
+#: gitk:9360
 msgid "Colors: press to choose"
 msgstr "Färger: tryck för att välja"

-#: gitk:9282
+#: gitk:9363
 msgid "Background"
 msgstr "Bakgrund"

-#: gitk:9286
+#: gitk:9367
 msgid "Foreground"
 msgstr "Förgrund"

-#: gitk:9290
+#: gitk:9371
 msgid "Diff: old lines"
 msgstr "Diff: gamla rader"

-#: gitk:9295
+#: gitk:9376
 msgid "Diff: new lines"
 msgstr "Diff: nya rader"

-#: gitk:9300
+#: gitk:9381
 msgid "Diff: hunk header"
 msgstr "Diff: delhuvud"

-#: gitk:9306
+#: gitk:9387
 msgid "Select bg"
 msgstr "Markerad bakgrund"

-#: gitk:9310
+#: gitk:9391
 msgid "Fonts: press to choose"
 msgstr "Teckensnitt: tryck för att välja"

-#: gitk:9312
+#: gitk:9393
 msgid "Main font"
 msgstr "Huvudteckensnitt"

-#: gitk:9313
+#: gitk:9394
 msgid "Diff display font"
 msgstr "Teckensnitt för diffvisning"

-#: gitk:9314
+#: gitk:9395
 msgid "User interface font"
 msgstr "Teckensnitt för användargränssnitt"

-#: gitk:9339
+#: gitk:9420
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: välj färg för %s"

-#: gitk:9720
+#: gitk:9801
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
@@ -892,24 +930,24 @@ msgstr ""
 "Gitk kan tyvärr inte köra med denna version av Tcl/Tk.\n"
 " Gitk kräver åtminstone Tcl/Tk 8.4."

-#: gitk:9812
+#: gitk:9900
 msgid "Cannot find a git repository here."
 msgstr "Hittar inget gitk-arkiv här."

-#: gitk:9816
+#: gitk:9904
 #, tcl-format
 msgid "Cannot find the git directory \"%s\"."
 msgstr "Hittar inte git-katalogen \"%s\"."

-#: gitk:9853
+#: gitk:9951
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Tvetydigt argument \"%s\": både revision och filnamn"

-#: gitk:9865
+#: gitk:9963
 msgid "Bad arguments to gitk:"
 msgstr "Felaktiga argument till gitk:"

-#: gitk:9925
+#: gitk:10023
 msgid "Command line"
 msgstr "Kommandorad"
-- 
1.6.0.2.GIT


On Thu, 25 Sep 2008, Peter Krefting wrote:

> Mikael Magnusson:
>
>> Want me to change that one too?
>
> Yeah, most probably should do that, if we change the other.
>
>> I personally think "Fel vid skapande av ~"is better than "Fel när ~
>> skulle skapas" but we should probably decide on one or the other :).
>
> as long as it is consistent, it should probably be good enough.
>
>> -- Mikael Magnusson???{.n?+???????+%?????ÿÿ??w??{.n?+???????^n?r??z???h????&???z??z?ÿÿ?+??+zf???h???~????i????????z_??j:+v???)ÿÿ?m
>
> Something weird is happening with your e-mail messages, not sure if it
> is on your end or mine...

I'll try alpine instead.

--
Mikael Magnusson
--8323328-12967266-1222345028=:11806--

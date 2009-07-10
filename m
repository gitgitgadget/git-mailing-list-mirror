From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH] gitk: Update Swedish translation (278t0f0u).
Date: Fri, 10 Jul 2009 08:15:22 +0100 (CET)
Message-ID: <alpine.DEB.2.00.0907100811180.17673@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 09:15:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPAKs-000244-CK
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 09:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbZGJHPv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2009 03:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbZGJHPu
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 03:15:50 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:53978 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750786AbZGJHPs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 03:15:48 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n6A7FNhV017881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 10 Jul 2009 09:15:23 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n6A7FMnu017878;
	Fri, 10 Jul 2009 09:15:22 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Fri, 10 Jul 2009 09:15:23 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123038>

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
This patch is against git://git.kernel.org/pub/scm/gitk/gitk.git - is t=
hat=20
the correct upstream to work from?

  po/sv.po |  775 +++++++++++++++++++++++++++++++++++++++++++----------=
---------
  1 files changed, 542 insertions(+), 233 deletions(-)

diff --git a/po/sv.po b/po/sv.po
index 947b53f..7a20bc0 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -1,32 +1,40 @@
  # Swedish translation for gitk
-# Copyright (C) 2005-2008 Paul Mackerras
+# Copyright (C) 2005-2009 Paul Mackerras
  # This file is distributed under the same license as the gitk package=
=2E
  #
-# Peter Karlsson <peter@softwolves.pp.se>, 2008.
+# Peter Krefting <peter@softwolves.pp.se>, 2008-2009.
  # Mikael Magnusson <mikachu@gmail.com>, 2008.
  msgid ""
  msgstr ""
  "Project-Id-Version: sv\n"
  "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-10-18 22:03+1100\n"
-"PO-Revision-Date: 2008-08-03 19:03+0200\n"
-"Last-Translator: Mikael Magnusson <mikachu@gmail.com>\n"
-"Language-Team: Swedish <sv@li.org>\n"
+"POT-Creation-Date: 2009-07-10 07:50+0100\n"
+"PO-Revision-Date: 2009-07-10 08:04+0100\n"
+"Last-Translator: Peter Krefting <peter@softwolves.pp.se>\n"
+"Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
  "MIME-Version: 1.0\n"
  "Content-Type: text/plain; charset=3DUTF-8\n"
  "Content-Transfer-Encoding: 8bit\n"

  #: gitk:113
  msgid "Couldn't get list of unmerged files:"
-msgstr "Kunde inta h=E4mta lista =F6ver ej sammanslagna filer:"
+msgstr "Kunde inte h=E4mta lista =F6ver ej sammanslagna filer:"

-#: gitk:340
+#: gitk:269
+msgid "Error parsing revisions:"
+msgstr "Fel vid tolkning av revisioner:"
+
+#: gitk:324
+msgid "Error executing --argscmd command:"
+msgstr "Fel vid k=F6rning av --argscmd-kommando:"
+
+#: gitk:337
  msgid "No files selected: --merge specified but no files are unmerged=
=2E"
  msgstr ""
  "Inga filer valdes: --merge angavs men det finns inga filer som inte =
har "
  "slagits samman."

-#: gitk:343
+#: gitk:340
  msgid ""
  "No files selected: --merge specified but no unmerged files are withi=
n file "
  "limit."
@@ -34,261 +42,290 @@ msgstr ""
  "Inga filer valdes: --merge angavs men det finns inga filer inom "
  "filbegr=E4nsningen."

-#: gitk:365 gitk:503
+#: gitk:362 gitk:509
  msgid "Error executing git log:"
  msgstr "Fel vid k=F6rning av git log:"

-#: gitk:378
+#: gitk:380 gitk:525
  msgid "Reading"
  msgstr "L=E4ser"

-#: gitk:438 gitk:3462
+#: gitk:440 gitk:4120
  msgid "Reading commits..."
  msgstr "L=E4ser incheckningar..."

-#: gitk:441 gitk:1528 gitk:3465
+#: gitk:443 gitk:1561 gitk:4123
  msgid "No commits selected"
  msgstr "Inga incheckningar markerade"

-#: gitk:1399
+#: gitk:1437
  msgid "Can't parse git log output:"
  msgstr "Kan inte tolka utdata fr=E5n git log:"

-#: gitk:1605
+#: gitk:1657
  msgid "No commit information available"
  msgstr "Ingen incheckningsinformation =E4r tillg=E4nglig"

-#: gitk:1709 gitk:1731 gitk:3259 gitk:7764 gitk:9293 gitk:9466
+#: gitk:1792 gitk:1816 gitk:3913 gitk:8778 gitk:10314 gitk:10486
  msgid "OK"
  msgstr "OK"

-#: gitk:1733 gitk:3260 gitk:7439 gitk:7510 gitk:7613 gitk:7660 gitk:77=
66
-#: gitk:9294 gitk:9467
+#: gitk:1818 gitk:3915 gitk:8375 gitk:8449 gitk:8559 gitk:8608 gitk:87=
80
+#: gitk:10315 gitk:10487
  msgid "Cancel"
  msgstr "Avbryt"

-#: gitk:1811
+#: gitk:1918
  msgid "Update"
  msgstr "Uppdatera"

-#: gitk:1812
+#: gitk:1919
  msgid "Reload"
  msgstr "Ladda om"

-#: gitk:1813
+#: gitk:1920
  msgid "Reread references"
  msgstr "L=E4s om referenser"

-#: gitk:1814
+#: gitk:1921
  msgid "List references"
  msgstr "Visa referenser"

-#: gitk:1815
+#: gitk:1923
+msgid "Start git gui"
+msgstr "Starta git gui"
+
+#: gitk:1925
  msgid "Quit"
  msgstr "Avsluta"

-#: gitk:1810
+#: gitk:1917
  msgid "File"
  msgstr "Arkiv"

-#: gitk:1818
+#: gitk:1929
  msgid "Preferences"
  msgstr "Inst=E4llningar"

-#: gitk:1817
+#: gitk:1928
  msgid "Edit"
  msgstr "Redigera"

-#: gitk:1821
+#: gitk:1933
  msgid "New view..."
  msgstr "Ny vy..."

-#: gitk:1822
+#: gitk:1934
  msgid "Edit view..."
  msgstr "=C4ndra vy..."

-#: gitk:1823
+#: gitk:1935
  msgid "Delete view"
  msgstr "Ta bort vy"

-#: gitk:1825
+#: gitk:1937
  msgid "All files"
  msgstr "Alla filer"

-#: gitk:1820 gitk:3196
+#: gitk:1932 gitk:3667
  msgid "View"
  msgstr "Visa"

-#: gitk:1828 gitk:2487
+#: gitk:1942 gitk:1952 gitk:2651
  msgid "About gitk"
  msgstr "Om gitk"

-#: gitk:1829
+#: gitk:1943 gitk:1957
  msgid "Key bindings"
  msgstr "Tangentbordsbindningar"

-#: gitk:1827
+#: gitk:1941 gitk:1956
  msgid "Help"
  msgstr "Hj=E4lp"

-#: gitk:1887
+#: gitk:2017
  msgid "SHA1 ID: "
  msgstr "SHA1-id: "

-#: gitk:1918
+#: gitk:2048
  msgid "Row"
  msgstr "Rad"

-#: gitk:1949
+#: gitk:2079
  msgid "Find"
  msgstr "S=F6k"

-#: gitk:1950
+#: gitk:2080
  msgid "next"
  msgstr "n=E4sta"

-#: gitk:1951
+#: gitk:2081
  msgid "prev"
  msgstr "f=F6reg"

-#: gitk:1952
+#: gitk:2082
  msgid "commit"
  msgstr "incheckning"

-#: gitk:1955 gitk:1957 gitk:3617 gitk:3640 gitk:3664 gitk:5550 gitk:56=
21
+#: gitk:2085 gitk:2087 gitk:4281 gitk:4304 gitk:4328 gitk:6269 gitk:63=
41
+#: gitk:6425
  msgid "containing:"
  msgstr "som inneh=E5ller:"

-#: gitk:1958 gitk:2954 gitk:2959 gitk:3692
+#: gitk:2088 gitk:3159 gitk:3164 gitk:4356
  msgid "touching paths:"
  msgstr "som r=F6r s=F6kv=E4g:"

-#: gitk:1959 gitk:3697
+#: gitk:2089 gitk:4361
  msgid "adding/removing string:"
  msgstr "som l=E4gger/till tar bort str=E4ng:"

-#: gitk:1968 gitk:1970
+#: gitk:2098 gitk:2100
  msgid "Exact"
  msgstr "Exakt"

-#: gitk:1970 gitk:3773 gitk:5518
+#: gitk:2100 gitk:4436 gitk:6237
  msgid "IgnCase"
  msgstr "IgnVersaler"

-#: gitk:1970 gitk:3666 gitk:3771 gitk:5514
+#: gitk:2100 gitk:4330 gitk:4434 gitk:6233
  msgid "Regexp"
  msgstr "Reg.uttr."

-#: gitk:1972 gitk:1973 gitk:3792 gitk:3822 gitk:3829 gitk:5641 gitk:57=
08
+#: gitk:2102 gitk:2103 gitk:4455 gitk:4485 gitk:4492 gitk:6361 gitk:64=
29
  msgid "All fields"
  msgstr "Alla f=E4lt"

-#: gitk:1973 gitk:3790 gitk:3822 gitk:5580
+#: gitk:2103 gitk:4453 gitk:4485 gitk:6300
  msgid "Headline"
  msgstr "Rubrik"

-#: gitk:1974 gitk:3790 gitk:5580 gitk:5708 gitk:6109
+#: gitk:2104 gitk:4453 gitk:6300 gitk:6429 gitk:6863
  msgid "Comments"
  msgstr "Kommentarer"

-#: gitk:1974 gitk:3790 gitk:3794 gitk:3829 gitk:5580 gitk:6045 gitk:72=
85
-#: gitk:7300
+#: gitk:2104 gitk:4453 gitk:4457 gitk:4492 gitk:6300 gitk:6798 gitk:80=
55
+#: gitk:8070
  msgid "Author"
  msgstr "F=F6rfattare"

-#: gitk:1974 gitk:3790 gitk:5580 gitk:6047
+#: gitk:2104 gitk:4453 gitk:6300 gitk:6800
  msgid "Committer"
  msgstr "Incheckare"

-#: gitk:2003
+#: gitk:2133
  msgid "Search"
  msgstr "S=F6k"

-#: gitk:2010
+#: gitk:2140
  msgid "Diff"
  msgstr "Diff"

-#: gitk:2012
+#: gitk:2142
  msgid "Old version"
  msgstr "Gammal version"

-#: gitk:2014
+#: gitk:2144
  msgid "New version"
  msgstr "Ny version"

-#: gitk:2016
+#: gitk:2146
  msgid "Lines of context"
  msgstr "Rader sammanhang"

-#: gitk:2026
+#: gitk:2156
  msgid "Ignore space change"
  msgstr "Ignorera =E4ndringar i blanksteg"

-#: gitk:2084
+#: gitk:2214
  msgid "Patch"
  msgstr "Patch"

-#: gitk:2086
+#: gitk:2216
  msgid "Tree"
  msgstr "Tr=E4d"

-#: gitk:2213 gitk:2226
+#: gitk:2360 gitk:2377
  msgid "Diff this -> selected"
  msgstr "Diff denna -> markerad"

-#: gitk:2214 gitk:2227
+#: gitk:2361 gitk:2378
  msgid "Diff selected -> this"
  msgstr "Diff markerad -> denna"

-#: gitk:2215 gitk:2228
+#: gitk:2362 gitk:2379
  msgid "Make patch"
  msgstr "Skapa patch"

-#: gitk:2216 gitk:7494
+#: gitk:2363 gitk:8433
  msgid "Create tag"
  msgstr "Skapa tagg"

-#: gitk:2217 gitk:7593
+#: gitk:2364 gitk:8539
  msgid "Write commit to file"
  msgstr "Skriv incheckning till fil"

-#: gitk:2218 gitk:7647
+#: gitk:2365 gitk:8596
  msgid "Create new branch"
  msgstr "Skapa ny gren"

-#: gitk:2219
+#: gitk:2366
  msgid "Cherry-pick this commit"
  msgstr "Plocka denna incheckning"

-#: gitk:2220
+#: gitk:2367
  msgid "Reset HEAD branch to here"
  msgstr "=C5terst=E4ll HEAD-grenen hit"

-#: gitk:2234
+#: gitk:2368
+msgid "Mark this commit"
+msgstr "Markera denna incheckning"
+
+#: gitk:2369
+msgid "Return to mark"
+msgstr "=C5terg=E5 till markering"
+
+#: gitk:2370
+msgid "Find descendant of this and mark"
+msgstr "Hitta efterf=F6ljare till denna och markera"
+
+#: gitk:2371
+msgid "Compare with marked commit"
+msgstr "J=E4mf=F6r med markerad incheckning"
+
+#: gitk:2385
  msgid "Check out this branch"
  msgstr "Checka ut denna gren"

-#: gitk:2235
+#: gitk:2386
  msgid "Remove this branch"
  msgstr "Ta bort denna gren"

-#: gitk:2242
+#: gitk:2393
  msgid "Highlight this too"
  msgstr "Markera =E4ven detta"

-#: gitk:2243
+#: gitk:2394
  msgid "Highlight this only"
  msgstr "Markera bara detta"

-#: gitk:2244
+#: gitk:2395
  msgid "External diff"
  msgstr "Extern diff"

-#: gitk:2245
+#: gitk:2396
  msgid "Blame parent commit"
-msgstr ""
+msgstr "Klandra f=F6r=E4ldraincheckning"
+
+#: gitk:2403
+msgid "Show origin of this line"
+msgstr "Visa ursprunget f=F6r den h=E4r raden"
+
+#: gitk:2404
+msgid "Run git gui blame on this line"
+msgstr "K=F6r git gui blame p=E5 den h=E4r raden"

-#: gitk:2488
+#: gitk:2653
  msgid ""
  "\n"
  "Gitk - a commit viewer for git\n"
@@ -304,427 +341,665 @@ msgstr ""
  "\n"
  "Anv=E4nd och vidaref=F6rmedla enligt villkoren i GNU General Public =
License"

-#: gitk:2496 gitk:2557 gitk:7943
+#: gitk:2661 gitk:2723 gitk:8961
  msgid "Close"
  msgstr "St=E4ng"

-#: gitk:2515
+#: gitk:2680
  msgid "Gitk key bindings"
  msgstr "Tangentbordsbindningar f=F6r Gitk"

-#: gitk:2517
+#: gitk:2683
  msgid "Gitk key bindings:"
  msgstr "Tangentbordsbindningar f=F6r Gitk:"

-#: gitk:2519
+#: gitk:2685
  #, tcl-format
  msgid "<%s-Q>\t\tQuit"
  msgstr "<%s-Q>\t\tAvsluta"

-#: gitk:2520
+#: gitk:2686
  msgid "<Home>\t\tMove to first commit"
  msgstr "<Home>\t\tG=E5 till f=F6rsta incheckning"

-#: gitk:2521
+#: gitk:2687
  msgid "<End>\t\tMove to last commit"
  msgstr "<End>\t\tG=E5 till sista incheckning"

-#: gitk:2522
+#: gitk:2688
  msgid "<Up>, p, i\tMove up one commit"
  msgstr "<Upp>, p, i\tG=E5 en incheckning upp"

-#: gitk:2523
+#: gitk:2689
  msgid "<Down>, n, k\tMove down one commit"
  msgstr "<Ned>, n, k\tG=E5 en incheckning ned"

-#: gitk:2524
+#: gitk:2690
  msgid "<Left>, z, j\tGo back in history list"
  msgstr "<V=E4nster>, z, j\tG=E5 bak=E5t i historiken"

-#: gitk:2525
+#: gitk:2691
  msgid "<Right>, x, l\tGo forward in history list"
  msgstr "<H=F6ger>, x, l\tG=E5 fram=E5t i historiken"

-#: gitk:2526
+#: gitk:2692
  msgid "<PageUp>\tMove up one page in commit list"
  msgstr "<PageUp>\tG=E5 upp en sida i incheckningslistan"

-#: gitk:2527
+#: gitk:2693
  msgid "<PageDown>\tMove down one page in commit list"
  msgstr "<PageDown>\tG=E5 ned en sida i incheckningslistan"

-#: gitk:2528
+#: gitk:2694
  #, tcl-format
  msgid "<%s-Home>\tScroll to top of commit list"
  msgstr "<%s-Home>\tRulla till b=F6rjan av incheckningslistan"

-#: gitk:2529
+#: gitk:2695
  #, tcl-format
  msgid "<%s-End>\tScroll to bottom of commit list"
  msgstr "<%s-End>\tRulla till slutet av incheckningslistan"

-#: gitk:2530
+#: gitk:2696
  #, tcl-format
  msgid "<%s-Up>\tScroll commit list up one line"
  msgstr "<%s-Upp>\tRulla incheckningslistan upp ett steg"

-#: gitk:2531
+#: gitk:2697
  #, tcl-format
  msgid "<%s-Down>\tScroll commit list down one line"
  msgstr "<%s-Ned>\tRulla incheckningslistan ned ett steg"

-#: gitk:2532
+#: gitk:2698
  #, tcl-format
  msgid "<%s-PageUp>\tScroll commit list up one page"
  msgstr "<%s-PageUp>\tRulla incheckningslistan upp en sida"

-#: gitk:2533
+#: gitk:2699
  #, tcl-format
  msgid "<%s-PageDown>\tScroll commit list down one page"
  msgstr "<%s-PageDown>\tRulla incheckningslistan ned en sida"

-#: gitk:2534
+#: gitk:2700
  msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
  msgstr "<Skift-Upp>\tS=F6k bak=E5t (upp=E5t, senare incheckningar)"

-#: gitk:2535
+#: gitk:2701
  msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
  msgstr "<Skift-Ned>\tS=F6k fram=E5t (ned=E5t, tidigare incheckningar)=
"

-#: gitk:2536
+#: gitk:2702
  msgid "<Delete>, b\tScroll diff view up one page"
  msgstr "<Delete>, b\tRulla diffvisningen upp en sida"

-#: gitk:2537
+#: gitk:2703
  msgid "<Backspace>\tScroll diff view up one page"
  msgstr "<Baksteg>\tRulla diffvisningen upp en sida"

-#: gitk:2538
+#: gitk:2704
  msgid "<Space>\t\tScroll diff view down one page"
  msgstr "<Blanksteg>\tRulla diffvisningen ned en sida"

-#: gitk:2539
+#: gitk:2705
  msgid "u\t\tScroll diff view up 18 lines"
  msgstr "u\t\tRulla diffvisningen upp 18 rader"

-#: gitk:2540
+#: gitk:2706
  msgid "d\t\tScroll diff view down 18 lines"
  msgstr "d\t\tRulla diffvisningen ned 18 rader"

-#: gitk:2541
+#: gitk:2707
  #, tcl-format
  msgid "<%s-F>\t\tFind"
  msgstr "<%s-F>\t\tS=F6k"

-#: gitk:2542
+#: gitk:2708
  #, tcl-format
  msgid "<%s-G>\t\tMove to next find hit"
  msgstr "<%s-G>\t\tG=E5 till n=E4sta s=F6ktr=E4ff"

-#: gitk:2543
+#: gitk:2709
  msgid "<Return>\tMove to next find hit"
  msgstr "<Return>\t\tG=E5 till n=E4sta s=F6ktr=E4ff"

-#: gitk:2544
-msgid "/\t\tMove to next find hit, or redo find"
-msgstr "/\t\tG=E5 till n=E4sta s=F6ktr=E4ff, eller s=F6k p=E5 nytt"
+#: gitk:2710
+msgid "/\t\tFocus the search box"
+msgstr "/\t\tFokusera s=F6krutan"

-#: gitk:2545
+#: gitk:2711
  msgid "?\t\tMove to previous find hit"
  msgstr "?\t\tG=E5 till f=F6reg=E5ende s=F6ktr=E4ff"

-#: gitk:2546
+#: gitk:2712
  msgid "f\t\tScroll diff view to next file"
  msgstr "f\t\tRulla diffvisningen till n=E4sta fil"

-#: gitk:2547
+#: gitk:2713
  #, tcl-format
  msgid "<%s-S>\t\tSearch for next hit in diff view"
  msgstr "<%s-S>\t\tG=E5 till n=E4sta s=F6ktr=E4ff i diffvisningen"

-#: gitk:2548
+#: gitk:2714
  #, tcl-format
  msgid "<%s-R>\t\tSearch for previous hit in diff view"
  msgstr "<%s-R>\t\tG=E5 till f=F6reg=E5ende s=F6ktr=E4ff i diffvisning=
en"

-#: gitk:2549
+#: gitk:2715
  #, tcl-format
  msgid "<%s-KP+>\tIncrease font size"
  msgstr "<%s-Num+>\t=D6ka teckenstorlek"

-#: gitk:2550
+#: gitk:2716
  #, tcl-format
  msgid "<%s-plus>\tIncrease font size"
  msgstr "<%s-plus>\t=D6ka teckenstorlek"

-#: gitk:2551
+#: gitk:2717
  #, tcl-format
  msgid "<%s-KP->\tDecrease font size"
  msgstr "<%s-Num->\tMinska teckenstorlek"

-#: gitk:2552
+#: gitk:2718
  #, tcl-format
  msgid "<%s-minus>\tDecrease font size"
  msgstr "<%s-minus>\tMinska teckenstorlek"

-#: gitk:2553
+#: gitk:2719
  msgid "<F5>\t\tUpdate"
  msgstr "<F5>\t\tUppdatera"

-#: gitk:3200
+#: gitk:3174
+#, tcl-format
+msgid "Error getting \"%s\" from %s:"
+msgstr "Fel vid h=E4mtning av  \"%s\" fr=E5n %s:"
+
+#: gitk:3231 gitk:3240
+#, tcl-format
+msgid "Error creating temporary directory %s:"
+msgstr "Fel vid skapande av tempor=E4r katalog %s:"
+
+#: gitk:3252
+msgid "command failed:"
+msgstr "kommando misslyckades:"
+
+#: gitk:3398
+msgid "No such commit"
+msgstr "Incheckning saknas"
+
+#: gitk:3412
+msgid "git gui blame: command failed:"
+msgstr "git gui blame: kommando misslyckades:"
+
+#: gitk:3443
+#, tcl-format
+msgid "Couldn't read merge head: %s"
+msgstr "Kunde inte l=E4sa sammanslagningshuvud: %s"
+
+#: gitk:3451
+#, tcl-format
+msgid "Error reading index: %s"
+msgstr "Fel vid l=E4sning av index: %s"
+
+#: gitk:3476
+#, tcl-format
+msgid "Couldn't start git blame: %s"
+msgstr "Kunde inte starta git blame: %s"
+
+#: gitk:3479 gitk:6268
+msgid "Searching"
+msgstr "S=F6ker"
+
+#: gitk:3511
+#, tcl-format
+msgid "Error running git blame: %s"
+msgstr "Fel vid k=F6rning av git blame: %s"
+
+#: gitk:3539
+#, tcl-format
+msgid "That line comes from commit %s,  which is not in this view"
+msgstr "Raden kommer fr=E5n incheckningen %s, som inte finns i denna v=
y"
+
+#: gitk:3553
+msgid "External diff viewer failed:"
+msgstr "Externt diff-verktyg misslyckades:"
+
+#: gitk:3671
  msgid "Gitk view definition"
  msgstr "Definition av Gitk-vy"

-#: gitk:3225
-msgid "Name"
-msgstr "Namn"
-
-#: gitk:3228
+#: gitk:3675
  msgid "Remember this view"
  msgstr "Spara denna vy"

-#: gitk:3232
-msgid "Commits to include (arguments to git log):"
-msgstr "Incheckningar att ta med (argument till git log):"
+#: gitk:3676
+msgid "References (space separated list):"
+msgstr "Referenser (blankstegsavdelad lista):"

-#: gitk:3239
-msgid "Command to generate more commits to include:"
-msgstr "Kommando f=F6r att generera fler incheckningar att ta med:"
+#: gitk:3677
+msgid "Branches & tags:"
+msgstr "Grenar & taggar:"
+
+#: gitk:3678
+msgid "All refs"
+msgstr "Alla referenser"
+
+#: gitk:3679
+msgid "All (local) branches"
+msgstr "Alla (lokala) grenar"
+
+#: gitk:3680
+msgid "All tags"
+msgstr "Alla taggar"
+
+#: gitk:3681
+msgid "All remote-tracking branches"
+msgstr "Alla fj=E4rrsp=E5rande grenar"
+
+#: gitk:3682
+msgid "Commit Info (regular expressions):"
+msgstr "Incheckningsinfo (regulj=E4ra uttryck):"
+
+#: gitk:3683
+msgid "Author:"
+msgstr "F=F6rfattare:"
+
+#: gitk:3684
+msgid "Committer:"
+msgstr "Incheckare:"
+
+#: gitk:3685
+msgid "Commit Message:"
+msgstr "Incheckningsmeddelande:"
+
+#: gitk:3686
+msgid "Matches all Commit Info criteria"
+msgstr "Motsvarar alla kriterier f=F6r incheckningsinfo"
+
+#: gitk:3687
+msgid "Changes to Files:"
+msgstr "=C4ndringar av filer:"
+
+#: gitk:3688
+msgid "Fixed String"
+msgstr "Fast str=E4ng"
+
+#: gitk:3689
+msgid "Regular Expression"
+msgstr "Regulj=E4rt uttryck"
+
+#: gitk:3690
+msgid "Search string:"
+msgstr "S=F6kstr=E4ng:"
+
+#: gitk:3691
+msgid ""
+"Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2=
009 "
+"15:27:38\"):"
+msgstr ""
+"Incheckingsdatum (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 1=
7, 2009 "
+"15:27:38\"):"
+
+#: gitk:3692
+msgid "Since:"
+msgstr "Fr=E5n:"
+
+#: gitk:3693
+msgid "Until:"
+msgstr "Till:"
+
+#: gitk:3694
+msgid "Limit and/or skip a number of revisions (positive integer):"
+msgstr "Begr=E4nsa och/eller hoppa =F6ver ett antal revisioner (positi=
vt heltal):"
+
+#: gitk:3695
+msgid "Number to show:"
+msgstr "Antal att visa:"
+
+#: gitk:3696
+msgid "Number to skip:"
+msgstr "Antal att hoppa =F6ver:"
+
+#: gitk:3697
+msgid "Miscellaneous options:"
+msgstr "Diverse alternativ:"

-#: gitk:3246
+#: gitk:3698
+msgid "Strictly sort by date"
+msgstr "Strikt datumsortering"
+
+#: gitk:3699
+msgid "Mark branch sides"
+msgstr "Markera sidogrenar"
+
+#: gitk:3700
+msgid "Limit to first parent"
+msgstr "Begr=E4nsa till f=F6rsta f=F6r=E4lder"
+
+#: gitk:3701
+msgid "Simple history"
+msgstr "Enkel historik"
+
+#: gitk:3702
+msgid "Additional arguments to git log:"
+msgstr "Ytterligare argument till git log:"
+
+#: gitk:3703
  msgid "Enter files and directories to include, one per line:"
  msgstr "Ange filer och kataloger att ta med, en per rad:"

-#: gitk:3293
+#: gitk:3704
+msgid "Command to generate more commits to include:"
+msgstr "Kommando f=F6r att generera fler incheckningar att ta med:"
+
+#: gitk:3826
+msgid "Gitk: edit view"
+msgstr "Gitk: redigera vy"
+
+#: gitk:3834
+msgid "-- criteria for selecting revisions"
+msgstr " - kriterier f=F6r val av revisioner"
+
+#: gitk:3839
+msgid "View Name:"
+msgstr "Namn p=E5 vy:"
+
+#: gitk:3914
+msgid "Apply (F5)"
+msgstr "Anv=E4nd (F5)"
+
+#: gitk:3952
  msgid "Error in commit selection arguments:"
  msgstr "Fel i argument f=F6r val av incheckningar:"

-#: gitk:3347 gitk:3399 gitk:3842 gitk:3856 gitk:5060 gitk:10141 gitk:1=
0142
+#: gitk:4005 gitk:4057 gitk:4505 gitk:4519 gitk:5780 gitk:11179 gitk:1=
1180
  msgid "None"
  msgstr "Inget"

-#: gitk:3790 gitk:5580 gitk:7287 gitk:7302
+#: gitk:4453 gitk:6300 gitk:8057 gitk:8072
  msgid "Date"
  msgstr "Datum"

-#: gitk:3790 gitk:5580
+#: gitk:4453 gitk:6300
  msgid "CDate"
  msgstr "Skapat datum"

-#: gitk:3939 gitk:3944
+#: gitk:4602 gitk:4607
  msgid "Descendant"
  msgstr "Avkomling"

-#: gitk:3940
+#: gitk:4603
  msgid "Not descendant"
  msgstr "Inte avkomling"

-#: gitk:3947 gitk:3952
+#: gitk:4610 gitk:4615
  msgid "Ancestor"
  msgstr "F=F6rfader"

-#: gitk:3948
+#: gitk:4611
  msgid "Not ancestor"
  msgstr "Inte f=F6rfader"

-#: gitk:4187
+#: gitk:4901
  msgid "Local changes checked in to index but not committed"
  msgstr "Lokala =E4ndringar sparade i indexet men inte incheckade"

-#: gitk:4220
+#: gitk:4937
  msgid "Local uncommitted changes, not checked in to index"
  msgstr "Lokala =E4ndringar, ej sparade i indexet"

-#: gitk:5549
-msgid "Searching"
-msgstr "S=F6ker"
+#: gitk:6618
+msgid "many"
+msgstr "m=E5nga"

-#: gitk:6049
+#: gitk:6802
  msgid "Tags:"
  msgstr "Taggar:"

-#: gitk:6066 gitk:6072 gitk:7280
+#: gitk:6819 gitk:6825 gitk:8050
  msgid "Parent"
  msgstr "F=F6r=E4lder"

-#: gitk:6077
+#: gitk:6830
  msgid "Child"
  msgstr "Barn"

-#: gitk:6086
+#: gitk:6839
  msgid "Branch"
  msgstr "Gren"

-#: gitk:6089
+#: gitk:6842
  msgid "Follows"
  msgstr "F=F6ljer"

-#: gitk:6092
+#: gitk:6845
  msgid "Precedes"
  msgstr "F=F6reg=E5r"

-#: gitk:6378
-msgid "Error getting merge diffs:"
-msgstr "Fel vid h=E4mtning av sammanslagningsdiff:"
+#: gitk:7343
+#, tcl-format
+msgid "Error getting diffs: %s"
+msgstr "Fel vid h=E4mtning av diff: %s"

-#: gitk:7113
+#: gitk:7883
  msgid "Goto:"
  msgstr "G=E5 till:"

-#: gitk:7115
+#: gitk:7885
  msgid "SHA1 ID:"
  msgstr "SHA1-id:"

-#: gitk:7134
+#: gitk:7904
  #, tcl-format
  msgid "Short SHA1 id %s is ambiguous"
  msgstr "F=F6rkortat SHA1-id %s =E4r tvetydigt"

-#: gitk:7146
+#: gitk:7916
  #, tcl-format
  msgid "SHA1 id %s is not known"
  msgstr "SHA-id:t %s =E4r inte k=E4nt"

-#: gitk:7148
+#: gitk:7918
  #, tcl-format
  msgid "Tag/Head %s is not known"
  msgstr "Tagg/huvud %s =E4r ok=E4nt"

-#: gitk:7290
+#: gitk:8060
  msgid "Children"
  msgstr "Barn"

-#: gitk:7347
+#: gitk:8117
  #, tcl-format
  msgid "Reset %s branch to here"
  msgstr "=C5terst=E4ll grenen %s hit"

-#: gitk:7349
+#: gitk:8119
  msgid "Detached head: can't reset"
  msgstr "Fr=E5nkopplad head: kan inte =E5terst=E4lla"

-#: gitk:7381
+#: gitk:8228 gitk:8234
+msgid "Skipping merge commit "
+msgstr "Hoppar =F6ver sammanslagningsincheckning "
+
+#: gitk:8243 gitk:8248
+msgid "Error getting patch ID for "
+msgstr "Fel vid h=E4mtning av patch-id f=F6r "
+
+#: gitk:8244 gitk:8249
+msgid " - stopping\n"
+msgstr " - stannar\n"
+
+#: gitk:8254 gitk:8257 gitk:8265 gitk:8275 gitk:8284
+msgid "Commit "
+msgstr "Incheckning "
+
+#: gitk:8258
+msgid ""
+" is the same patch as\n"
+"       "
+msgstr " =E4r samma patch som\n"
+"       "
+
+#: gitk:8266
+msgid ""
+" differs from\n"
+"       "
+msgstr ""
+" skiljer sig fr=E5n\n"
+"       "
+
+#: gitk:8268
+msgid "- stopping\n"
+msgstr "- stannar\n"
+
+#: gitk:8276 gitk:8285
+#, tcl-format
+msgid " has %s children - stopping\n"
+msgstr " har %s barn - stannar\n"
+
+#: gitk:8316
  msgid "Top"
  msgstr "Topp"

-#: gitk:7382
+#: gitk:8317
  msgid "From"
  msgstr "Fr=E5n"

-#: gitk:7387
+#: gitk:8322
  msgid "To"
  msgstr "Till"

-#: gitk:7410
+#: gitk:8346
  msgid "Generate patch"
  msgstr "Generera patch"

-#: gitk:7412
+#: gitk:8348
  msgid "From:"
  msgstr "Fr=E5n:"

-#: gitk:7421
+#: gitk:8357
  msgid "To:"
  msgstr "Till:"

-#: gitk:7430
+#: gitk:8366
  msgid "Reverse"
  msgstr "V=E4nd"

-#: gitk:7432 gitk:7607
+#: gitk:8368 gitk:8553
  msgid "Output file:"
  msgstr "Utdatafil:"

-#: gitk:7438
+#: gitk:8374
  msgid "Generate"
  msgstr "Generera"

-#: gitk:7474
+#: gitk:8412
  msgid "Error creating patch:"
  msgstr "Fel vid generering av patch:"

-#: gitk:7496 gitk:7595 gitk:7649
+#: gitk:8435 gitk:8541 gitk:8598
  msgid "ID:"
  msgstr "Id:"

-#: gitk:7505
+#: gitk:8444
  msgid "Tag name:"
  msgstr "Taggnamn:"

-#: gitk:7509 gitk:7659
+#: gitk:8448 gitk:8607
  msgid "Create"
  msgstr "Skapa"

-#: gitk:7524
+#: gitk:8465
  msgid "No tag name specified"
  msgstr "Inget taggnamn angavs"

-#: gitk:7528
+#: gitk:8469
  #, tcl-format
  msgid "Tag \"%s\" already exists"
  msgstr "Taggen \"%s\" finns redan"

-#: gitk:7534
+#: gitk:8475
  msgid "Error creating tag:"
  msgstr "Fel vid skapande av tagg:"

-#: gitk:7604
+#: gitk:8550
  msgid "Command:"
  msgstr "Kommando:"

-#: gitk:7612
+#: gitk:8558
  msgid "Write"
  msgstr "Skriv"

-#: gitk:7628
+#: gitk:8576
  msgid "Error writing commit:"
  msgstr "Fel vid skrivning av incheckning:"

-#: gitk:7654
+#: gitk:8603
  msgid "Name:"
  msgstr "Namn:"

-#: gitk:7674
+#: gitk:8626
  msgid "Please specify a name for the new branch"
  msgstr "Ange ett namn f=F6r den nya grenen"

-#: gitk:7703
+#: gitk:8631
+#, tcl-format
+msgid "Branch '%s' already exists. Overwrite?"
+msgstr "Grenen \"%s\" finns redan. Skriva =F6ver?"
+
+#: gitk:8697
  #, tcl-format
  msgid "Commit %s is already included in branch %s -- really re-apply =
it?"
  msgstr ""
  "Incheckningen %s finns redan p=E5 grenen %s -- skall den verkligen a=
ppliceras "
  "p=E5 nytt?"

-#: gitk:7708
+#: gitk:8702
  msgid "Cherry-picking"
  msgstr "Plockar"

-#: gitk:7720
+#: gitk:8711
+#, tcl-format
+msgid ""
+"Cherry-pick failed because of local changes to file '%s'.\n"
+"Please commit, reset or stash your changes and try again."
+msgstr ""
+"Cherry-pick misslyckades p=E5 grund av lokala =E4ndringar i filen \"%=
s\".\n"
+"Checka in, =E5terst=E4ll eller spara undan (stash) dina =E4ndringar o=
ch f=F6rs=F6k igen."
+
+#: gitk:8717
+msgid ""
+"Cherry-pick failed because of merge conflict.\n"
+"Do you wish to run git citool to resolve it?"
+msgstr ""
+"Cherry-pick misslyckades p=E5 grund av en sammanslagningskonflikt.\n"
+"Vill du k=F6ra git citool f=F6r att l=F6sa den?"
+
+#: gitk:8733
  msgid "No changes committed"
  msgstr "Inga =E4ndringar incheckade"

-#: gitk:7745
+#: gitk:8759
  msgid "Confirm reset"
  msgstr "Bekr=E4fta =E5terst=E4llning"

-#: gitk:7747
+#: gitk:8761
  #, tcl-format
  msgid "Reset branch %s to %s?"
  msgstr "=C5terst=E4lla grenen %s till %s?"

-#: gitk:7751
+#: gitk:8765
  msgid "Reset type:"
  msgstr "Typ av =E5terst=E4llning:"

-#: gitk:7755
+#: gitk:8769
  msgid "Soft: Leave working tree and index untouched"
  msgstr "Mjuk: R=F6r inte utcheckning och index"

-#: gitk:7758
+#: gitk:8772
  msgid "Mixed: Leave working tree untouched, reset index"
  msgstr "Blandad: R=F6r inte utcheckning, =E5terst=E4ll index"

-#: gitk:7761
+#: gitk:8775
  msgid ""
  "Hard: Reset working tree and index\n"
  "(discard ALL local changes)"
@@ -732,19 +1007,19 @@ msgstr ""
  "H=E5rd: =C5terst=E4ll utcheckning och index\n"
  "(f=F6rkastar ALLA lokala =E4ndringar)"

-#: gitk:7777
+#: gitk:8792
  msgid "Resetting"
  msgstr "=C5terst=E4ller"

-#: gitk:7834
+#: gitk:8849
  msgid "Checking out"
  msgstr "Checkar ut"

-#: gitk:7885
+#: gitk:8902
  msgid "Cannot delete the currently checked-out branch"
  msgstr "Kan inte ta bort den just nu utcheckade grenen"

-#: gitk:7891
+#: gitk:8908
  #, tcl-format
  msgid ""
  "The commits on branch %s aren't on any other branch.\n"
@@ -753,16 +1028,16 @@ msgstr ""
  "Incheckningarna p=E5 grenen %s existerar inte p=E5 n=E5gon annan gre=
n.\n"
  "Vill du verkligen ta bort grenen %s?"

-#: gitk:7922
+#: gitk:8939
  #, tcl-format
  msgid "Tags and heads: %s"
  msgstr "Taggar och huvuden: %s"

-#: gitk:7936
+#: gitk:8954
  msgid "Filter"
  msgstr "Filter"

-#: gitk:8230
+#: gitk:9249
  msgid ""
  "Error reading commit topology information; branch and preceding/foll=
owing "
  "tag information will be incomplete."
@@ -770,129 +1045,157 @@ msgstr ""
  "Fel vid l=E4sning av information om incheckningstopologi; informatio=
n om "
  "grenar och f=F6reg=E5ende/senare taggar kommer inte vara komplett."

-#: gitk:9216
+#: gitk:10235
  msgid "Tag"
  msgstr "Tagg"

-#: gitk:9216
+#: gitk:10235
  msgid "Id"
  msgstr "Id"

-#: gitk:9262
+#: gitk:10283
  msgid "Gitk font chooser"
  msgstr "Teckensnittsv=E4ljare f=F6r Gitk"

-#: gitk:9279
+#: gitk:10300
  msgid "B"
  msgstr "F"

-#: gitk:9282
+#: gitk:10303
  msgid "I"
  msgstr "K"

-#: gitk:9375
+#: gitk:10398
  msgid "Gitk preferences"
  msgstr "Inst=E4llningar f=F6r Gitk"

-#: gitk:9376
+#: gitk:10400
  msgid "Commit list display options"
  msgstr "Alternativ f=F6r incheckningslistvy"

-#: gitk:9379
+#: gitk:10403
  msgid "Maximum graph width (lines)"
  msgstr "Maximal grafbredd (rader)"

-#: gitk:9383
+#: gitk:10407
  #, tcl-format
  msgid "Maximum graph width (% of pane)"
  msgstr "Maximal grafbredd (% av ruta)"

-#: gitk:9388
+#: gitk:10411
  msgid "Show local changes"
  msgstr "Visa lokala =E4ndringar"

-#: gitk:9393
+#: gitk:10414
  msgid "Auto-select SHA1"
  msgstr "V=E4lj SHA1 automatiskt"

-#: gitk:9398
+#: gitk:10418
  msgid "Diff display options"
  msgstr "Alternativ f=F6r diffvy"

-#: gitk:9400
+#: gitk:10420
  msgid "Tab spacing"
  msgstr "Blanksteg f=F6r tabulatortecken"

-#: gitk:9404
+#: gitk:10423
  msgid "Display nearby tags"
  msgstr "Visa n=E4rliggande taggar"

-#: gitk:9409
+#: gitk:10426
  msgid "Limit diffs to listed paths"
  msgstr "Begr=E4nsa diff till listade s=F6kv=E4gar"

-#: gitk:9414
+#: gitk:10429
  msgid "Support per-file encodings"
-msgstr ""
+msgstr "St=F6d f=F6r filspecifika teckenkodningar"

-#: gitk:9421
+#: gitk:10435 gitk:10500
  msgid "External diff tool"
  msgstr "Externt diff-verktyg"

-#: gitk:9423
+#: gitk:10437
  msgid "Choose..."
  msgstr "V=E4lj..."

-#: gitk:9428
+#: gitk:10442
  msgid "Colors: press to choose"
  msgstr "F=E4rger: tryck f=F6r att v=E4lja"

-#: gitk:9431
+#: gitk:10445
  msgid "Background"
  msgstr "Bakgrund"

-#: gitk:9435
+#: gitk:10446 gitk:10476
+msgid "background"
+msgstr "bakgrund"
+
+#: gitk:10449
  msgid "Foreground"
  msgstr "F=F6rgrund"

-#: gitk:9439
+#: gitk:10450
+msgid "foreground"
+msgstr "f=F6rgrund"
+
+#: gitk:10453
  msgid "Diff: old lines"
  msgstr "Diff: gamla rader"

-#: gitk:9444
+#: gitk:10454
+msgid "diff old lines"
+msgstr "diff gamla rader"
+
+#: gitk:10458
  msgid "Diff: new lines"
  msgstr "Diff: nya rader"

-#: gitk:9449
+#: gitk:10459
+msgid "diff new lines"
+msgstr "diff nya rader"
+
+#: gitk:10463
  msgid "Diff: hunk header"
  msgstr "Diff: delhuvud"

-#: gitk:9455
+#: gitk:10465
+msgid "diff hunk header"
+msgstr "diff delhuvud"
+
+#: gitk:10469
+msgid "Marked line bg"
+msgstr "Markerad rad bakgrund"
+
+#: gitk:10471
+msgid "marked line background"
+msgstr "markerad rad bakgrund"
+
+#: gitk:10475
  msgid "Select bg"
  msgstr "Markerad bakgrund"

-#: gitk:9459
+#: gitk:10479
  msgid "Fonts: press to choose"
  msgstr "Teckensnitt: tryck f=F6r att v=E4lja"

-#: gitk:9461
+#: gitk:10481
  msgid "Main font"
  msgstr "Huvudteckensnitt"

-#: gitk:9462
+#: gitk:10482
  msgid "Diff display font"
  msgstr "Teckensnitt f=F6r diffvisning"

-#: gitk:9463
+#: gitk:10483
  msgid "User interface font"
  msgstr "Teckensnitt f=F6r anv=E4ndargr=E4nssnitt"

-#: gitk:9488
+#: gitk:10510
  #, tcl-format
  msgid "Gitk: choose color for %s"
  msgstr "Gitk: v=E4lj f=E4rg f=F6r %s"

-#: gitk:9934
+#: gitk:10957
  msgid ""
  "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
  " Gitk requires at least Tcl/Tk 8.4."
@@ -900,24 +1203,30 @@ msgstr ""
  "Gitk kan tyv=E4rr inte k=F6ra med denna version av Tcl/Tk.\n"
  " Gitk kr=E4ver =E5tminstone Tcl/Tk 8.4."

-#: gitk:10047
+#: gitk:11084
  msgid "Cannot find a git repository here."
  msgstr "Hittar inget gitk-arkiv h=E4r."

-#: gitk:10051
+#: gitk:11088
  #, tcl-format
  msgid "Cannot find the git directory \"%s\"."
  msgstr "Hittar inte git-katalogen \"%s\"."

-#: gitk:10098
+#: gitk:11135
  #, tcl-format
  msgid "Ambiguous argument '%s': both revision and filename"
  msgstr "Tvetydigt argument \"%s\": b=E5de revision och filnamn"

-#: gitk:10110
+#: gitk:11147
  msgid "Bad arguments to gitk:"
  msgstr "Felaktiga argument till gitk:"

-#: gitk:10170
+#: gitk:11232
  msgid "Command line"
  msgstr "Kommandorad"
+
+#~ msgid "/\t\tMove to next find hit, or redo find"
+#~ msgstr "/\t\tG=E5 till n=E4sta s=F6ktr=E4ff, eller s=F6k p=E5 nytt"
+
+#~ msgid "Name"
+#~ msgstr "Namn"
--=20
1.5.6.5

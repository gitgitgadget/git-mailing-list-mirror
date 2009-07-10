From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH] gitk: Update Swedish translation (280t0f0u).
Date: Fri, 10 Jul 2009 08:08:15 +0100
Message-ID: <20090813124816.618FE2FC1C@perkele>
References: <alpine.DEB.2.00.0907100811180.17673@ds9.cixit.se>
 <19075.65114.64967.831062@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 14:48:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbZjM-00026H-8B
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 14:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459AbZHMMsU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2009 08:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754430AbZHMMsU
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 08:48:20 -0400
Received: from smtp.getmail.no ([84.208.15.66]:63938 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754409AbZHMMsS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2009 08:48:18 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOB008LDFKJHQ70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 13 Aug 2009 14:48:19 +0200 (MEST)
Received: from perkele ([84.215.142.63]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOB00ARKFKGY1F0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 13 Aug 2009 14:48:19 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.13.123619
Received: by perkele (Postfix, from userid 501)	id 618FE2FC1C; Thu,
 13 Aug 2009 14:48:16 +0200 (CEST)
In-reply-to: <19075.65114.64967.831062@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125821>

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
Use this version instead, I forgot to add the last changes in the last
version (it just had the updated commit message.)

 po/sv.po |  795 +++++++++++++++++++++++++++++++++++++++++++-----------=
--------
 1 files changed, 559 insertions(+), 236 deletions(-)

diff --git a/po/sv.po b/po/sv.po
index 947b53f..624eb22 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -1,32 +1,40 @@
 # Swedish translation for gitk
-# Copyright (C) 2005-2008 Paul Mackerras
+# Copyright (C) 2005-2009 Paul Mackerras
 # This file is distributed under the same license as the gitk package.
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
+"POT-Creation-Date: 2009-08-13 13:38+0100\n"
+"PO-Revision-Date: 2009-08-13 13:40+0100\n"
+"Last-Translator: Peter Krefting <peter@softwolves.pp.se>\n"
+"Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
-"Content-Transfer-Encoding: 8bit\n"
+"Content-Transfer-Encoding: 8bit"
=20
 #: gitk:113
 msgid "Couldn't get list of unmerged files:"
-msgstr "Kunde inta h=C3=A4mta lista =C3=B6ver ej sammanslagna filer:"
+msgstr "Kunde inte h=C3=A4mta lista =C3=B6ver ej sammanslagna filer:"
=20
-#: gitk:340
+#: gitk:269
+msgid "Error parsing revisions:"
+msgstr "Fel vid tolkning av revisioner:"
+
+#: gitk:324
+msgid "Error executing --argscmd command:"
+msgstr "Fel vid k=C3=B6rning av --argscmd-kommando:"
+
+#: gitk:337
 msgid "No files selected: --merge specified but no files are unmerged.=
"
 msgstr ""
 "Inga filer valdes: --merge angavs men det finns inga filer som inte h=
ar "
 "slagits samman."
=20
-#: gitk:343
+#: gitk:340
 msgid ""
 "No files selected: --merge specified but no unmerged files are within=
 file "
 "limit."
@@ -34,261 +42,290 @@ msgstr ""
 "Inga filer valdes: --merge angavs men det finns inga filer inom "
 "filbegr=C3=A4nsningen."
=20
-#: gitk:365 gitk:503
+#: gitk:362 gitk:509
 msgid "Error executing git log:"
 msgstr "Fel vid k=C3=B6rning av git log:"
=20
-#: gitk:378
+#: gitk:380 gitk:525
 msgid "Reading"
 msgstr "L=C3=A4ser"
=20
-#: gitk:438 gitk:3462
+#: gitk:440 gitk:4123
 msgid "Reading commits..."
 msgstr "L=C3=A4ser incheckningar..."
=20
-#: gitk:441 gitk:1528 gitk:3465
+#: gitk:443 gitk:1561 gitk:4126
 msgid "No commits selected"
 msgstr "Inga incheckningar markerade"
=20
-#: gitk:1399
+#: gitk:1437
 msgid "Can't parse git log output:"
 msgstr "Kan inte tolka utdata fr=C3=A5n git log:"
=20
-#: gitk:1605
+#: gitk:1657
 msgid "No commit information available"
 msgstr "Ingen incheckningsinformation =C3=A4r tillg=C3=A4nglig"
=20
-#: gitk:1709 gitk:1731 gitk:3259 gitk:7764 gitk:9293 gitk:9466
+#: gitk:1793 gitk:1817 gitk:3916 gitk:8786 gitk:10322 gitk:10498
 msgid "OK"
 msgstr "OK"
=20
-#: gitk:1733 gitk:3260 gitk:7439 gitk:7510 gitk:7613 gitk:7660 gitk:77=
66
-#: gitk:9294 gitk:9467
+#: gitk:1819 gitk:3918 gitk:8383 gitk:8457 gitk:8567 gitk:8616 gitk:87=
88
+#: gitk:10323 gitk:10499
 msgid "Cancel"
 msgstr "Avbryt"
=20
-#: gitk:1811
+#: gitk:1919
 msgid "Update"
 msgstr "Uppdatera"
=20
-#: gitk:1812
+#: gitk:1920
 msgid "Reload"
 msgstr "Ladda om"
=20
-#: gitk:1813
+#: gitk:1921
 msgid "Reread references"
 msgstr "L=C3=A4s om referenser"
=20
-#: gitk:1814
+#: gitk:1922
 msgid "List references"
 msgstr "Visa referenser"
=20
-#: gitk:1815
+#: gitk:1924
+msgid "Start git gui"
+msgstr "Starta git gui"
+
+#: gitk:1926
 msgid "Quit"
 msgstr "Avsluta"
=20
-#: gitk:1810
+#: gitk:1918
 msgid "File"
 msgstr "Arkiv"
=20
-#: gitk:1818
+#: gitk:1930
 msgid "Preferences"
 msgstr "Inst=C3=A4llningar"
=20
-#: gitk:1817
+#: gitk:1929
 msgid "Edit"
 msgstr "Redigera"
=20
-#: gitk:1821
+#: gitk:1934
 msgid "New view..."
 msgstr "Ny vy..."
=20
-#: gitk:1822
+#: gitk:1935
 msgid "Edit view..."
 msgstr "=C3=84ndra vy..."
=20
-#: gitk:1823
+#: gitk:1936
 msgid "Delete view"
 msgstr "Ta bort vy"
=20
-#: gitk:1825
+#: gitk:1938
 msgid "All files"
 msgstr "Alla filer"
=20
-#: gitk:1820 gitk:3196
+#: gitk:1933 gitk:3670
 msgid "View"
 msgstr "Visa"
=20
-#: gitk:1828 gitk:2487
+#: gitk:1943 gitk:1953 gitk:2654
 msgid "About gitk"
 msgstr "Om gitk"
=20
-#: gitk:1829
+#: gitk:1944 gitk:1958
 msgid "Key bindings"
 msgstr "Tangentbordsbindningar"
=20
-#: gitk:1827
+#: gitk:1942 gitk:1957
 msgid "Help"
 msgstr "Hj=C3=A4lp"
=20
-#: gitk:1887
+#: gitk:2018
 msgid "SHA1 ID: "
 msgstr "SHA1-id: "
=20
-#: gitk:1918
+#: gitk:2049
 msgid "Row"
 msgstr "Rad"
=20
-#: gitk:1949
+#: gitk:2080
 msgid "Find"
 msgstr "S=C3=B6k"
=20
-#: gitk:1950
+#: gitk:2081
 msgid "next"
 msgstr "n=C3=A4sta"
=20
-#: gitk:1951
+#: gitk:2082
 msgid "prev"
 msgstr "f=C3=B6reg"
=20
-#: gitk:1952
+#: gitk:2083
 msgid "commit"
 msgstr "incheckning"
=20
-#: gitk:1955 gitk:1957 gitk:3617 gitk:3640 gitk:3664 gitk:5550 gitk:56=
21
+#: gitk:2086 gitk:2088 gitk:4284 gitk:4307 gitk:4331 gitk:6272 gitk:63=
44
+#: gitk:6428
 msgid "containing:"
 msgstr "som inneh=C3=A5ller:"
=20
-#: gitk:1958 gitk:2954 gitk:2959 gitk:3692
+#: gitk:2089 gitk:3162 gitk:3167 gitk:4359
 msgid "touching paths:"
 msgstr "som r=C3=B6r s=C3=B6kv=C3=A4g:"
=20
-#: gitk:1959 gitk:3697
+#: gitk:2090 gitk:4364
 msgid "adding/removing string:"
 msgstr "som l=C3=A4gger/till tar bort str=C3=A4ng:"
=20
-#: gitk:1968 gitk:1970
+#: gitk:2099 gitk:2101
 msgid "Exact"
 msgstr "Exakt"
=20
-#: gitk:1970 gitk:3773 gitk:5518
+#: gitk:2101 gitk:4439 gitk:6240
 msgid "IgnCase"
 msgstr "IgnVersaler"
=20
-#: gitk:1970 gitk:3666 gitk:3771 gitk:5514
+#: gitk:2101 gitk:4333 gitk:4437 gitk:6236
 msgid "Regexp"
 msgstr "Reg.uttr."
=20
-#: gitk:1972 gitk:1973 gitk:3792 gitk:3822 gitk:3829 gitk:5641 gitk:57=
08
+#: gitk:2103 gitk:2104 gitk:4458 gitk:4488 gitk:4495 gitk:6364 gitk:64=
32
 msgid "All fields"
 msgstr "Alla f=C3=A4lt"
=20
-#: gitk:1973 gitk:3790 gitk:3822 gitk:5580
+#: gitk:2104 gitk:4456 gitk:4488 gitk:6303
 msgid "Headline"
 msgstr "Rubrik"
=20
-#: gitk:1974 gitk:3790 gitk:5580 gitk:5708 gitk:6109
+#: gitk:2105 gitk:4456 gitk:6303 gitk:6432 gitk:6866
 msgid "Comments"
 msgstr "Kommentarer"
=20
-#: gitk:1974 gitk:3790 gitk:3794 gitk:3829 gitk:5580 gitk:6045 gitk:72=
85
-#: gitk:7300
+#: gitk:2105 gitk:4456 gitk:4460 gitk:4495 gitk:6303 gitk:6801 gitk:80=
63
+#: gitk:8078
 msgid "Author"
 msgstr "F=C3=B6rfattare"
=20
-#: gitk:1974 gitk:3790 gitk:5580 gitk:6047
+#: gitk:2105 gitk:4456 gitk:6303 gitk:6803
 msgid "Committer"
 msgstr "Incheckare"
=20
-#: gitk:2003
+#: gitk:2134
 msgid "Search"
 msgstr "S=C3=B6k"
=20
-#: gitk:2010
+#: gitk:2141
 msgid "Diff"
 msgstr "Diff"
=20
-#: gitk:2012
+#: gitk:2143
 msgid "Old version"
 msgstr "Gammal version"
=20
-#: gitk:2014
+#: gitk:2145
 msgid "New version"
 msgstr "Ny version"
=20
-#: gitk:2016
+#: gitk:2147
 msgid "Lines of context"
 msgstr "Rader sammanhang"
=20
-#: gitk:2026
+#: gitk:2157
 msgid "Ignore space change"
 msgstr "Ignorera =C3=A4ndringar i blanksteg"
=20
-#: gitk:2084
+#: gitk:2215
 msgid "Patch"
 msgstr "Patch"
=20
-#: gitk:2086
+#: gitk:2217
 msgid "Tree"
 msgstr "Tr=C3=A4d"
=20
-#: gitk:2213 gitk:2226
+#: gitk:2361 gitk:2378
 msgid "Diff this -> selected"
 msgstr "Diff denna -> markerad"
=20
-#: gitk:2214 gitk:2227
+#: gitk:2362 gitk:2379
 msgid "Diff selected -> this"
 msgstr "Diff markerad -> denna"
=20
-#: gitk:2215 gitk:2228
+#: gitk:2363 gitk:2380
 msgid "Make patch"
 msgstr "Skapa patch"
=20
-#: gitk:2216 gitk:7494
+#: gitk:2364 gitk:8441
 msgid "Create tag"
 msgstr "Skapa tagg"
=20
-#: gitk:2217 gitk:7593
+#: gitk:2365 gitk:8547
 msgid "Write commit to file"
 msgstr "Skriv incheckning till fil"
=20
-#: gitk:2218 gitk:7647
+#: gitk:2366 gitk:8604
 msgid "Create new branch"
 msgstr "Skapa ny gren"
=20
-#: gitk:2219
+#: gitk:2367
 msgid "Cherry-pick this commit"
 msgstr "Plocka denna incheckning"
=20
-#: gitk:2220
+#: gitk:2368
 msgid "Reset HEAD branch to here"
 msgstr "=C3=85terst=C3=A4ll HEAD-grenen hit"
=20
-#: gitk:2234
+#: gitk:2369
+msgid "Mark this commit"
+msgstr "Markera denna incheckning"
+
+#: gitk:2370
+msgid "Return to mark"
+msgstr "=C3=85terg=C3=A5 till markering"
+
+#: gitk:2371
+msgid "Find descendant of this and mark"
+msgstr "Hitta efterf=C3=B6ljare till denna och markera"
+
+#: gitk:2372
+msgid "Compare with marked commit"
+msgstr "J=C3=A4mf=C3=B6r med markerad incheckning"
+
+#: gitk:2386
 msgid "Check out this branch"
 msgstr "Checka ut denna gren"
=20
-#: gitk:2235
+#: gitk:2387
 msgid "Remove this branch"
 msgstr "Ta bort denna gren"
=20
-#: gitk:2242
+#: gitk:2394
 msgid "Highlight this too"
 msgstr "Markera =C3=A4ven detta"
=20
-#: gitk:2243
+#: gitk:2395
 msgid "Highlight this only"
 msgstr "Markera bara detta"
=20
-#: gitk:2244
+#: gitk:2396
 msgid "External diff"
 msgstr "Extern diff"
=20
-#: gitk:2245
+#: gitk:2397
 msgid "Blame parent commit"
-msgstr ""
+msgstr "Klandra f=C3=B6r=C3=A4ldraincheckning"
=20
-#: gitk:2488
+#: gitk:2404
+msgid "Show origin of this line"
+msgstr "Visa ursprunget f=C3=B6r den h=C3=A4r raden"
+
+#: gitk:2405
+msgid "Run git gui blame on this line"
+msgstr "K=C3=B6r git gui blame p=C3=A5 den h=C3=A4r raden"
+
+#: gitk:2656
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -304,427 +341,672 @@ msgstr ""
 "\n"
 "Anv=C3=A4nd och vidaref=C3=B6rmedla enligt villkoren i GNU General Pu=
blic License"
=20
-#: gitk:2496 gitk:2557 gitk:7943
+#: gitk:2664 gitk:2726 gitk:8969
 msgid "Close"
 msgstr "St=C3=A4ng"
=20
-#: gitk:2515
+#: gitk:2683
 msgid "Gitk key bindings"
 msgstr "Tangentbordsbindningar f=C3=B6r Gitk"
=20
-#: gitk:2517
+#: gitk:2686
 msgid "Gitk key bindings:"
 msgstr "Tangentbordsbindningar f=C3=B6r Gitk:"
=20
-#: gitk:2519
+#: gitk:2688
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tAvsluta"
=20
-#: gitk:2520
+#: gitk:2689
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Home>\t\tG=C3=A5 till f=C3=B6rsta incheckning"
=20
-#: gitk:2521
+#: gitk:2690
 msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\tG=C3=A5 till sista incheckning"
=20
-#: gitk:2522
+#: gitk:2691
 msgid "<Up>, p, i\tMove up one commit"
 msgstr "<Upp>, p, i\tG=C3=A5 en incheckning upp"
=20
-#: gitk:2523
+#: gitk:2692
 msgid "<Down>, n, k\tMove down one commit"
 msgstr "<Ned>, n, k\tG=C3=A5 en incheckning ned"
=20
-#: gitk:2524
+#: gitk:2693
 msgid "<Left>, z, j\tGo back in history list"
 msgstr "<V=C3=A4nster>, z, j\tG=C3=A5 bak=C3=A5t i historiken"
=20
-#: gitk:2525
+#: gitk:2694
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<H=C3=B6ger>, x, l\tG=C3=A5 fram=C3=A5t i historiken"
=20
-#: gitk:2526
+#: gitk:2695
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<PageUp>\tG=C3=A5 upp en sida i incheckningslistan"
=20
-#: gitk:2527
+#: gitk:2696
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<PageDown>\tG=C3=A5 ned en sida i incheckningslistan"
=20
-#: gitk:2528
+#: gitk:2697
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Home>\tRulla till b=C3=B6rjan av incheckningslistan"
=20
-#: gitk:2529
+#: gitk:2698
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-End>\tRulla till slutet av incheckningslistan"
=20
-#: gitk:2530
+#: gitk:2699
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Upp>\tRulla incheckningslistan upp ett steg"
=20
-#: gitk:2531
+#: gitk:2700
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Ned>\tRulla incheckningslistan ned ett steg"
=20
-#: gitk:2532
+#: gitk:2701
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-PageUp>\tRulla incheckningslistan upp en sida"
=20
-#: gitk:2533
+#: gitk:2702
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-PageDown>\tRulla incheckningslistan ned en sida"
=20
-#: gitk:2534
+#: gitk:2703
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Skift-Upp>\tS=C3=B6k bak=C3=A5t (upp=C3=A5t, senare incheckni=
ngar)"
=20
-#: gitk:2535
+#: gitk:2704
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr "<Skift-Ned>\tS=C3=B6k fram=C3=A5t (ned=C3=A5t, tidigare inchec=
kningar)"
=20
-#: gitk:2536
+#: gitk:2705
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Delete>, b\tRulla diffvisningen upp en sida"
=20
-#: gitk:2537
+#: gitk:2706
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<Baksteg>\tRulla diffvisningen upp en sida"
=20
-#: gitk:2538
+#: gitk:2707
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Blanksteg>\tRulla diffvisningen ned en sida"
=20
-#: gitk:2539
+#: gitk:2708
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\tRulla diffvisningen upp 18 rader"
=20
-#: gitk:2540
+#: gitk:2709
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\tRulla diffvisningen ned 18 rader"
=20
-#: gitk:2541
+#: gitk:2710
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tS=C3=B6k"
=20
-#: gitk:2542
+#: gitk:2711
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tG=C3=A5 till n=C3=A4sta s=C3=B6ktr=C3=A4ff"
=20
-#: gitk:2543
+#: gitk:2712
 msgid "<Return>\tMove to next find hit"
 msgstr "<Return>\t\tG=C3=A5 till n=C3=A4sta s=C3=B6ktr=C3=A4ff"
=20
-#: gitk:2544
-msgid "/\t\tMove to next find hit, or redo find"
-msgstr "/\t\tG=C3=A5 till n=C3=A4sta s=C3=B6ktr=C3=A4ff, eller s=C3=B6=
k p=C3=A5 nytt"
+#: gitk:2713
+msgid "/\t\tFocus the search box"
+msgstr "/\t\tFokusera s=C3=B6krutan"
=20
-#: gitk:2545
+#: gitk:2714
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tG=C3=A5 till f=C3=B6reg=C3=A5ende s=C3=B6ktr=C3=A4ff"
=20
-#: gitk:2546
+#: gitk:2715
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tRulla diffvisningen till n=C3=A4sta fil"
=20
-#: gitk:2547
+#: gitk:2716
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tG=C3=A5 till n=C3=A4sta s=C3=B6ktr=C3=A4ff i diffvis=
ningen"
=20
-#: gitk:2548
+#: gitk:2717
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tG=C3=A5 till f=C3=B6reg=C3=A5ende s=C3=B6ktr=C3=A4ff=
 i diffvisningen"
=20
-#: gitk:2549
+#: gitk:2718
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-Num+>\t=C3=96ka teckenstorlek"
=20
-#: gitk:2550
+#: gitk:2719
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-plus>\t=C3=96ka teckenstorlek"
=20
-#: gitk:2551
+#: gitk:2720
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-Num->\tMinska teckenstorlek"
=20
-#: gitk:2552
+#: gitk:2721
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-minus>\tMinska teckenstorlek"
=20
-#: gitk:2553
+#: gitk:2722
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tUppdatera"
=20
-#: gitk:3200
+#: gitk:3177
+#, tcl-format
+msgid "Error getting \"%s\" from %s:"
+msgstr "Fel vid h=C3=A4mtning av  \"%s\" fr=C3=A5n %s:"
+
+#: gitk:3234 gitk:3243
+#, tcl-format
+msgid "Error creating temporary directory %s:"
+msgstr "Fel vid skapande av tempor=C3=A4r katalog %s:"
+
+#: gitk:3255
+msgid "command failed:"
+msgstr "kommando misslyckades:"
+
+#: gitk:3401
+msgid "No such commit"
+msgstr "Incheckning saknas"
+
+#: gitk:3415
+msgid "git gui blame: command failed:"
+msgstr "git gui blame: kommando misslyckades:"
+
+#: gitk:3446
+#, tcl-format
+msgid "Couldn't read merge head: %s"
+msgstr "Kunde inte l=C3=A4sa sammanslagningshuvud: %s"
+
+#: gitk:3454
+#, tcl-format
+msgid "Error reading index: %s"
+msgstr "Fel vid l=C3=A4sning av index: %s"
+
+#: gitk:3479
+#, tcl-format
+msgid "Couldn't start git blame: %s"
+msgstr "Kunde inte starta git blame: %s"
+
+#: gitk:3482 gitk:6271
+msgid "Searching"
+msgstr "S=C3=B6ker"
+
+#: gitk:3514
+#, tcl-format
+msgid "Error running git blame: %s"
+msgstr "Fel vid k=C3=B6rning av git blame: %s"
+
+#: gitk:3542
+#, tcl-format
+msgid "That line comes from commit %s,  which is not in this view"
+msgstr "Raden kommer fr=C3=A5n incheckningen %s, som inte finns i denn=
a vy"
+
+#: gitk:3556
+msgid "External diff viewer failed:"
+msgstr "Externt diff-verktyg misslyckades:"
+
+#: gitk:3674
 msgid "Gitk view definition"
 msgstr "Definition av Gitk-vy"
=20
-#: gitk:3225
-msgid "Name"
-msgstr "Namn"
-
-#: gitk:3228
+#: gitk:3678
 msgid "Remember this view"
 msgstr "Spara denna vy"
=20
-#: gitk:3232
-msgid "Commits to include (arguments to git log):"
-msgstr "Incheckningar att ta med (argument till git log):"
+#: gitk:3679
+msgid "References (space separated list):"
+msgstr "Referenser (blankstegsavdelad lista):"
=20
-#: gitk:3239
-msgid "Command to generate more commits to include:"
-msgstr "Kommando f=C3=B6r att generera fler incheckningar att ta med:"
+#: gitk:3680
+msgid "Branches & tags:"
+msgstr "Grenar & taggar:"
+
+#: gitk:3681
+msgid "All refs"
+msgstr "Alla referenser"
+
+#: gitk:3682
+msgid "All (local) branches"
+msgstr "Alla (lokala) grenar"
+
+#: gitk:3683
+msgid "All tags"
+msgstr "Alla taggar"
+
+#: gitk:3684
+msgid "All remote-tracking branches"
+msgstr "Alla fj=C3=A4rrsp=C3=A5rande grenar"
+
+#: gitk:3685
+msgid "Commit Info (regular expressions):"
+msgstr "Incheckningsinfo (regulj=C3=A4ra uttryck):"
=20
-#: gitk:3246
+#: gitk:3686
+msgid "Author:"
+msgstr "F=C3=B6rfattare:"
+
+#: gitk:3687
+msgid "Committer:"
+msgstr "Incheckare:"
+
+#: gitk:3688
+msgid "Commit Message:"
+msgstr "Incheckningsmeddelande:"
+
+#: gitk:3689
+msgid "Matches all Commit Info criteria"
+msgstr "Motsvarar alla kriterier f=C3=B6r incheckningsinfo"
+
+#: gitk:3690
+msgid "Changes to Files:"
+msgstr "=C3=84ndringar av filer:"
+
+#: gitk:3691
+msgid "Fixed String"
+msgstr "Fast str=C3=A4ng"
+
+#: gitk:3692
+msgid "Regular Expression"
+msgstr "Regulj=C3=A4rt uttryck"
+
+#: gitk:3693
+msgid "Search string:"
+msgstr "S=C3=B6kstr=C3=A4ng:"
+
+#: gitk:3694
+msgid ""
+"Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2=
009 "
+"15:27:38\"):"
+msgstr ""
+"Incheckingsdatum (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 1=
7, 2009 "
+"15:27:38\"):"
+
+#: gitk:3695
+msgid "Since:"
+msgstr "Fr=C3=A5n:"
+
+#: gitk:3696
+msgid "Until:"
+msgstr "Till:"
+
+#: gitk:3697
+msgid "Limit and/or skip a number of revisions (positive integer):"
+msgstr "Begr=C3=A4nsa och/eller hoppa =C3=B6ver ett antal revisioner (=
positivt heltal):"
+
+#: gitk:3698
+msgid "Number to show:"
+msgstr "Antal att visa:"
+
+#: gitk:3699
+msgid "Number to skip:"
+msgstr "Antal att hoppa =C3=B6ver:"
+
+#: gitk:3700
+msgid "Miscellaneous options:"
+msgstr "Diverse alternativ:"
+
+#: gitk:3701
+msgid "Strictly sort by date"
+msgstr "Strikt datumsortering"
+
+#: gitk:3702
+msgid "Mark branch sides"
+msgstr "Markera sidogrenar"
+
+#: gitk:3703
+msgid "Limit to first parent"
+msgstr "Begr=C3=A4nsa till f=C3=B6rsta f=C3=B6r=C3=A4lder"
+
+#: gitk:3704
+msgid "Simple history"
+msgstr "Enkel historik"
+
+#: gitk:3705
+msgid "Additional arguments to git log:"
+msgstr "Ytterligare argument till git log:"
+
+#: gitk:3706
 msgid "Enter files and directories to include, one per line:"
 msgstr "Ange filer och kataloger att ta med, en per rad:"
=20
-#: gitk:3293
+#: gitk:3707
+msgid "Command to generate more commits to include:"
+msgstr "Kommando f=C3=B6r att generera fler incheckningar att ta med:"
+
+#: gitk:3829
+msgid "Gitk: edit view"
+msgstr "Gitk: redigera vy"
+
+#: gitk:3837
+msgid "-- criteria for selecting revisions"
+msgstr " - kriterier f=C3=B6r val av revisioner"
+
+#: gitk:3842
+msgid "View Name:"
+msgstr "Namn p=C3=A5 vy:"
+
+#: gitk:3917
+msgid "Apply (F5)"
+msgstr "Anv=C3=A4nd (F5)"
+
+#: gitk:3955
 msgid "Error in commit selection arguments:"
 msgstr "Fel i argument f=C3=B6r val av incheckningar:"
=20
-#: gitk:3347 gitk:3399 gitk:3842 gitk:3856 gitk:5060 gitk:10141 gitk:1=
0142
+#: gitk:4008 gitk:4060 gitk:4508 gitk:4522 gitk:5783 gitk:11196 gitk:1=
1197
 msgid "None"
 msgstr "Inget"
=20
-#: gitk:3790 gitk:5580 gitk:7287 gitk:7302
+#: gitk:4456 gitk:6303 gitk:8065 gitk:8080
 msgid "Date"
 msgstr "Datum"
=20
-#: gitk:3790 gitk:5580
+#: gitk:4456 gitk:6303
 msgid "CDate"
 msgstr "Skapat datum"
=20
-#: gitk:3939 gitk:3944
+#: gitk:4605 gitk:4610
 msgid "Descendant"
 msgstr "Avkomling"
=20
-#: gitk:3940
+#: gitk:4606
 msgid "Not descendant"
 msgstr "Inte avkomling"
=20
-#: gitk:3947 gitk:3952
+#: gitk:4613 gitk:4618
 msgid "Ancestor"
 msgstr "F=C3=B6rfader"
=20
-#: gitk:3948
+#: gitk:4614
 msgid "Not ancestor"
 msgstr "Inte f=C3=B6rfader"
=20
-#: gitk:4187
+#: gitk:4904
 msgid "Local changes checked in to index but not committed"
 msgstr "Lokala =C3=A4ndringar sparade i indexet men inte incheckade"
=20
-#: gitk:4220
+#: gitk:4940
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokala =C3=A4ndringar, ej sparade i indexet"
=20
-#: gitk:5549
-msgid "Searching"
-msgstr "S=C3=B6ker"
+#: gitk:6621
+msgid "many"
+msgstr "m=C3=A5nga"
=20
-#: gitk:6049
+#: gitk:6805
 msgid "Tags:"
 msgstr "Taggar:"
=20
-#: gitk:6066 gitk:6072 gitk:7280
+#: gitk:6822 gitk:6828 gitk:8058
 msgid "Parent"
 msgstr "F=C3=B6r=C3=A4lder"
=20
-#: gitk:6077
+#: gitk:6833
 msgid "Child"
 msgstr "Barn"
=20
-#: gitk:6086
+#: gitk:6842
 msgid "Branch"
 msgstr "Gren"
=20
-#: gitk:6089
+#: gitk:6845
 msgid "Follows"
 msgstr "F=C3=B6ljer"
=20
-#: gitk:6092
+#: gitk:6848
 msgid "Precedes"
 msgstr "F=C3=B6reg=C3=A5r"
=20
-#: gitk:6378
-msgid "Error getting merge diffs:"
-msgstr "Fel vid h=C3=A4mtning av sammanslagningsdiff:"
+#: gitk:7346
+#, tcl-format
+msgid "Error getting diffs: %s"
+msgstr "Fel vid h=C3=A4mtning av diff: %s"
=20
-#: gitk:7113
+#: gitk:7886
 msgid "Goto:"
 msgstr "G=C3=A5 till:"
=20
-#: gitk:7115
+#: gitk:7888
 msgid "SHA1 ID:"
 msgstr "SHA1-id:"
=20
-#: gitk:7134
+#: gitk:7907
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "F=C3=B6rkortat SHA1-id %s =C3=A4r tvetydigt"
=20
-#: gitk:7146
+#: gitk:7914
+#, tcl-format
+msgid "Revision %s is not known"
+msgstr "Revisionen %s =C3=A4r inte k=C3=A4nd"
+
+#: gitk:7924
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "SHA-id:t %s =C3=A4r inte k=C3=A4nt"
=20
-#: gitk:7148
+#: gitk:7926
 #, tcl-format
-msgid "Tag/Head %s is not known"
-msgstr "Tagg/huvud %s =C3=A4r ok=C3=A4nt"
+msgid "Revision %s is not in the current view"
+msgstr "Revisionen %s finns inte i den nuvarande vyn"
=20
-#: gitk:7290
+#: gitk:8068
 msgid "Children"
 msgstr "Barn"
=20
-#: gitk:7347
+#: gitk:8125
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "=C3=85terst=C3=A4ll grenen %s hit"
=20
-#: gitk:7349
+#: gitk:8127
 msgid "Detached head: can't reset"
 msgstr "Fr=C3=A5nkopplad head: kan inte =C3=A5terst=C3=A4lla"
=20
-#: gitk:7381
+#: gitk:8236 gitk:8242
+msgid "Skipping merge commit "
+msgstr "Hoppar =C3=B6ver sammanslagningsincheckning "
+
+#: gitk:8251 gitk:8256
+msgid "Error getting patch ID for "
+msgstr "Fel vid h=C3=A4mtning av patch-id f=C3=B6r "
+
+#: gitk:8252 gitk:8257
+msgid " - stopping\n"
+msgstr " - stannar\n"
+
+#: gitk:8262 gitk:8265 gitk:8273 gitk:8283 gitk:8292
+msgid "Commit "
+msgstr "Incheckning "
+
+#: gitk:8266
+msgid ""
+" is the same patch as\n"
+"       "
+msgstr ""
+" =C3=A4r samma patch som\n"
+"       "
+
+#: gitk:8274
+msgid ""
+" differs from\n"
+"       "
+msgstr ""
+" skiljer sig fr=C3=A5n\n"
+"       "
+
+#: gitk:8276
+msgid "- stopping\n"
+msgstr "- stannar\n"
+
+#: gitk:8284 gitk:8293
+#, tcl-format
+msgid " has %s children - stopping\n"
+msgstr " har %s barn - stannar\n"
+
+#: gitk:8324
 msgid "Top"
 msgstr "Topp"
=20
-#: gitk:7382
+#: gitk:8325
 msgid "From"
 msgstr "Fr=C3=A5n"
=20
-#: gitk:7387
+#: gitk:8330
 msgid "To"
 msgstr "Till"
=20
-#: gitk:7410
+#: gitk:8354
 msgid "Generate patch"
 msgstr "Generera patch"
=20
-#: gitk:7412
+#: gitk:8356
 msgid "From:"
 msgstr "Fr=C3=A5n:"
=20
-#: gitk:7421
+#: gitk:8365
 msgid "To:"
 msgstr "Till:"
=20
-#: gitk:7430
+#: gitk:8374
 msgid "Reverse"
 msgstr "V=C3=A4nd"
=20
-#: gitk:7432 gitk:7607
+#: gitk:8376 gitk:8561
 msgid "Output file:"
 msgstr "Utdatafil:"
=20
-#: gitk:7438
+#: gitk:8382
 msgid "Generate"
 msgstr "Generera"
=20
-#: gitk:7474
+#: gitk:8420
 msgid "Error creating patch:"
 msgstr "Fel vid generering av patch:"
=20
-#: gitk:7496 gitk:7595 gitk:7649
+#: gitk:8443 gitk:8549 gitk:8606
 msgid "ID:"
 msgstr "Id:"
=20
-#: gitk:7505
+#: gitk:8452
 msgid "Tag name:"
 msgstr "Taggnamn:"
=20
-#: gitk:7509 gitk:7659
+#: gitk:8456 gitk:8615
 msgid "Create"
 msgstr "Skapa"
=20
-#: gitk:7524
+#: gitk:8473
 msgid "No tag name specified"
 msgstr "Inget taggnamn angavs"
=20
-#: gitk:7528
+#: gitk:8477
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Taggen \"%s\" finns redan"
=20
-#: gitk:7534
+#: gitk:8483
 msgid "Error creating tag:"
 msgstr "Fel vid skapande av tagg:"
=20
-#: gitk:7604
+#: gitk:8558
 msgid "Command:"
 msgstr "Kommando:"
=20
-#: gitk:7612
+#: gitk:8566
 msgid "Write"
 msgstr "Skriv"
=20
-#: gitk:7628
+#: gitk:8584
 msgid "Error writing commit:"
 msgstr "Fel vid skrivning av incheckning:"
=20
-#: gitk:7654
+#: gitk:8611
 msgid "Name:"
 msgstr "Namn:"
=20
-#: gitk:7674
+#: gitk:8634
 msgid "Please specify a name for the new branch"
 msgstr "Ange ett namn f=C3=B6r den nya grenen"
=20
-#: gitk:7703
+#: gitk:8639
+#, tcl-format
+msgid "Branch '%s' already exists. Overwrite?"
+msgstr "Grenen \"%s\" finns redan. Skriva =C3=B6ver?"
+
+#: gitk:8705
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
 msgstr ""
 "Incheckningen %s finns redan p=C3=A5 grenen %s -- skall den verkligen=
 appliceras "
 "p=C3=A5 nytt?"
=20
-#: gitk:7708
+#: gitk:8710
 msgid "Cherry-picking"
 msgstr "Plockar"
=20
-#: gitk:7720
+#: gitk:8719
+#, tcl-format
+msgid ""
+"Cherry-pick failed because of local changes to file '%s'.\n"
+"Please commit, reset or stash your changes and try again."
+msgstr ""
+"Cherry-pick misslyckades p=C3=A5 grund av lokala =C3=A4ndringar i fil=
en \"%s\".\n"
+"Checka in, =C3=A5terst=C3=A4ll eller spara undan (stash) dina =C3=A4n=
dringar och f=C3=B6rs=C3=B6k "
+"igen."
+
+#: gitk:8725
+msgid ""
+"Cherry-pick failed because of merge conflict.\n"
+"Do you wish to run git citool to resolve it?"
+msgstr ""
+"Cherry-pick misslyckades p=C3=A5 grund av en sammanslagningskonflikt.=
\n"
+"Vill du k=C3=B6ra git citool f=C3=B6r att l=C3=B6sa den?"
+
+#: gitk:8741
 msgid "No changes committed"
 msgstr "Inga =C3=A4ndringar incheckade"
=20
-#: gitk:7745
+#: gitk:8767
 msgid "Confirm reset"
 msgstr "Bekr=C3=A4fta =C3=A5terst=C3=A4llning"
=20
-#: gitk:7747
+#: gitk:8769
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "=C3=85terst=C3=A4lla grenen %s till %s?"
=20
-#: gitk:7751
+#: gitk:8773
 msgid "Reset type:"
 msgstr "Typ av =C3=A5terst=C3=A4llning:"
=20
-#: gitk:7755
+#: gitk:8777
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Mjuk: R=C3=B6r inte utcheckning och index"
=20
-#: gitk:7758
+#: gitk:8780
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr "Blandad: R=C3=B6r inte utcheckning, =C3=A5terst=C3=A4ll index"
=20
-#: gitk:7761
+#: gitk:8783
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -732,19 +1014,19 @@ msgstr ""
 "H=C3=A5rd: =C3=85terst=C3=A4ll utcheckning och index\n"
 "(f=C3=B6rkastar ALLA lokala =C3=A4ndringar)"
=20
-#: gitk:7777
+#: gitk:8800
 msgid "Resetting"
 msgstr "=C3=85terst=C3=A4ller"
=20
-#: gitk:7834
+#: gitk:8857
 msgid "Checking out"
 msgstr "Checkar ut"
=20
-#: gitk:7885
+#: gitk:8910
 msgid "Cannot delete the currently checked-out branch"
 msgstr "Kan inte ta bort den just nu utcheckade grenen"
=20
-#: gitk:7891
+#: gitk:8916
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -753,16 +1035,16 @@ msgstr ""
 "Incheckningarna p=C3=A5 grenen %s existerar inte p=C3=A5 n=C3=A5gon a=
nnan gren.\n"
 "Vill du verkligen ta bort grenen %s?"
=20
-#: gitk:7922
+#: gitk:8947
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Taggar och huvuden: %s"
=20
-#: gitk:7936
+#: gitk:8962
 msgid "Filter"
 msgstr "Filter"
=20
-#: gitk:8230
+#: gitk:9257
 msgid ""
 "Error reading commit topology information; branch and preceding/follo=
wing "
 "tag information will be incomplete."
@@ -770,129 +1052,161 @@ msgstr ""
 "Fel vid l=C3=A4sning av information om incheckningstopologi; informat=
ion om "
 "grenar och f=C3=B6reg=C3=A5ende/senare taggar kommer inte vara komple=
tt."
=20
-#: gitk:9216
+#: gitk:10243
 msgid "Tag"
 msgstr "Tagg"
=20
-#: gitk:9216
+#: gitk:10243
 msgid "Id"
 msgstr "Id"
=20
-#: gitk:9262
+#: gitk:10291
 msgid "Gitk font chooser"
 msgstr "Teckensnittsv=C3=A4ljare f=C3=B6r Gitk"
=20
-#: gitk:9279
+#: gitk:10308
 msgid "B"
 msgstr "F"
=20
-#: gitk:9282
+#: gitk:10311
 msgid "I"
 msgstr "K"
=20
-#: gitk:9375
+#: gitk:10407
 msgid "Gitk preferences"
 msgstr "Inst=C3=A4llningar f=C3=B6r Gitk"
=20
-#: gitk:9376
+#: gitk:10409
 msgid "Commit list display options"
 msgstr "Alternativ f=C3=B6r incheckningslistvy"
=20
-#: gitk:9379
+#: gitk:10412
 msgid "Maximum graph width (lines)"
 msgstr "Maximal grafbredd (rader)"
=20
-#: gitk:9383
+#: gitk:10416
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Maximal grafbredd (% av ruta)"
=20
-#: gitk:9388
+#: gitk:10420
 msgid "Show local changes"
 msgstr "Visa lokala =C3=A4ndringar"
=20
-#: gitk:9393
+#: gitk:10423
 msgid "Auto-select SHA1"
 msgstr "V=C3=A4lj SHA1 automatiskt"
=20
-#: gitk:9398
+#: gitk:10427
 msgid "Diff display options"
 msgstr "Alternativ f=C3=B6r diffvy"
=20
-#: gitk:9400
+#: gitk:10429
 msgid "Tab spacing"
 msgstr "Blanksteg f=C3=B6r tabulatortecken"
=20
-#: gitk:9404
+#: gitk:10432
 msgid "Display nearby tags"
 msgstr "Visa n=C3=A4rliggande taggar"
=20
-#: gitk:9409
+#: gitk:10435
+msgid "Hide remote refs"
+msgstr "D=C3=B6lj fj=C3=A4rr-referenser"
+
+#: gitk:10438
 msgid "Limit diffs to listed paths"
 msgstr "Begr=C3=A4nsa diff till listade s=C3=B6kv=C3=A4gar"
=20
-#: gitk:9414
+#: gitk:10441
 msgid "Support per-file encodings"
-msgstr ""
+msgstr "St=C3=B6d f=C3=B6r filspecifika teckenkodningar"
=20
-#: gitk:9421
+#: gitk:10447 gitk:10512
 msgid "External diff tool"
 msgstr "Externt diff-verktyg"
=20
-#: gitk:9423
+#: gitk:10449
 msgid "Choose..."
 msgstr "V=C3=A4lj..."
=20
-#: gitk:9428
+#: gitk:10454
 msgid "Colors: press to choose"
 msgstr "F=C3=A4rger: tryck f=C3=B6r att v=C3=A4lja"
=20
-#: gitk:9431
+#: gitk:10457
 msgid "Background"
 msgstr "Bakgrund"
=20
-#: gitk:9435
+#: gitk:10458 gitk:10488
+msgid "background"
+msgstr "bakgrund"
+
+#: gitk:10461
 msgid "Foreground"
 msgstr "F=C3=B6rgrund"
=20
-#: gitk:9439
+#: gitk:10462
+msgid "foreground"
+msgstr "f=C3=B6rgrund"
+
+#: gitk:10465
 msgid "Diff: old lines"
 msgstr "Diff: gamla rader"
=20
-#: gitk:9444
+#: gitk:10466
+msgid "diff old lines"
+msgstr "diff gamla rader"
+
+#: gitk:10470
 msgid "Diff: new lines"
 msgstr "Diff: nya rader"
=20
-#: gitk:9449
+#: gitk:10471
+msgid "diff new lines"
+msgstr "diff nya rader"
+
+#: gitk:10475
 msgid "Diff: hunk header"
 msgstr "Diff: delhuvud"
=20
-#: gitk:9455
+#: gitk:10477
+msgid "diff hunk header"
+msgstr "diff delhuvud"
+
+#: gitk:10481
+msgid "Marked line bg"
+msgstr "Markerad rad bakgrund"
+
+#: gitk:10483
+msgid "marked line background"
+msgstr "markerad rad bakgrund"
+
+#: gitk:10487
 msgid "Select bg"
 msgstr "Markerad bakgrund"
=20
-#: gitk:9459
+#: gitk:10491
 msgid "Fonts: press to choose"
 msgstr "Teckensnitt: tryck f=C3=B6r att v=C3=A4lja"
=20
-#: gitk:9461
+#: gitk:10493
 msgid "Main font"
 msgstr "Huvudteckensnitt"
=20
-#: gitk:9462
+#: gitk:10494
 msgid "Diff display font"
 msgstr "Teckensnitt f=C3=B6r diffvisning"
=20
-#: gitk:9463
+#: gitk:10495
 msgid "User interface font"
 msgstr "Teckensnitt f=C3=B6r anv=C3=A4ndargr=C3=A4nssnitt"
=20
-#: gitk:9488
+#: gitk:10522
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: v=C3=A4lj f=C3=A4rg f=C3=B6r %s"
=20
-#: gitk:9934
+#: gitk:10973
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
@@ -900,24 +1214,33 @@ msgstr ""
 "Gitk kan tyv=C3=A4rr inte k=C3=B6ra med denna version av Tcl/Tk.\n"
 " Gitk kr=C3=A4ver =C3=A5tminstone Tcl/Tk 8.4."
=20
-#: gitk:10047
+#: gitk:11101
 msgid "Cannot find a git repository here."
 msgstr "Hittar inget gitk-arkiv h=C3=A4r."
=20
-#: gitk:10051
+#: gitk:11105
 #, tcl-format
 msgid "Cannot find the git directory \"%s\"."
 msgstr "Hittar inte git-katalogen \"%s\"."
=20
-#: gitk:10098
+#: gitk:11152
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Tvetydigt argument \"%s\": b=C3=A5de revision och filnamn"
=20
-#: gitk:10110
+#: gitk:11164
 msgid "Bad arguments to gitk:"
 msgstr "Felaktiga argument till gitk:"
=20
-#: gitk:10170
+#: gitk:11249
 msgid "Command line"
 msgstr "Kommandorad"
+
+#~ msgid "Tag/Head %s is not known"
+#~ msgstr "Tagg/huvud %s =C3=A4r ok=C3=A4nt"
+
+#~ msgid "/\t\tMove to next find hit, or redo find"
+#~ msgstr "/\t\tG=C3=A5 till n=C3=A4sta s=C3=B6ktr=C3=A4ff, eller s=C3=
=B6k p=C3=A5 nytt"
+
+#~ msgid "Name"
+#~ msgstr "Namn"
--=20
1.6.3.3

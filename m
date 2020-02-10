Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5AFC352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 21:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F8D2072C
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 21:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgBJV5M convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 10 Feb 2020 16:57:12 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.205.38]:39090 "EHLO
        smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJV5L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 16:57:11 -0500
Received: from mail.tu-harburg.de (mail4.rz.tu-harburg.de [134.28.202.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.tuhh.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by smtp1.rz.tu-harburg.de (Postfix) with ESMTPS id 48Gfrg0N6YzxS8;
        Mon, 10 Feb 2020 22:57:07 +0100 (CET)
Received: from mailspring.rz.tuhh.de (mailspring.rz.tuhh.de [134.28.202.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alucst@KERBEROS.TU-HARBURG.DE)
        by mail.tu-harburg.de (Postfix) with ESMTPSA id 48Gfrf657BzJpRP;
        Mon, 10 Feb 2020 22:57:05 +0100 (CET)
From:   Christian Stimming <christian@cstimming.de>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Git List <git@vger.kernel.org>
Subject: [PATCH 1/2] gitk: re-generate German po file from current source code
Date:   Mon, 10 Feb 2020 22:57:05 +0100
Message-ID: <2527491.s4PuAgMcOf@ckiste>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So that subsequent translation updates have an up-to-date
starting point.

Signed-off-by: Christian Stimming <christian@cstimming.de>
---
 po/de.po | 672 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 365 insertions(+), 307 deletions(-)

diff --git a/po/de.po b/po/de.po
index 5db3824..b30dfb0 100644
--- a/po/de.po
+++ b/po/de.po
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2015-05-17 14:32+1000\n"
+"POT-Creation-Date: 2020-01-24 23:48+0100\n"
 "PO-Revision-Date: 2015-10-20 14:20+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
@@ -21,11 +21,11 @@ msgstr ""
 msgid "Couldn't get list of unmerged files:"
 msgstr "Liste der nicht zusammengeführten Dateien nicht gefunden:"
 
-#: gitk:212 gitk:2381
+#: gitk:212 gitk:2407
 msgid "Color words"
 msgstr "Wörter einfärben"
 
-#: gitk:217 gitk:2381 gitk:8220 gitk:8253
+#: gitk:217 gitk:2407 gitk:8290 gitk:8323
 msgid "Markup words"
 msgstr "Wörter kennzeichnen"
 
@@ -59,306 +59,321 @@ msgstr "Fehler beim Ausführen von »git log«:"
 msgid "Reading"
 msgstr "Lesen"
 
-#: gitk:496 gitk:4525
+#: gitk:496 gitk:4555
 msgid "Reading commits..."
 msgstr "Versionen werden gelesen ..."
 
-#: gitk:499 gitk:1637 gitk:4528
+#: gitk:499 gitk:1641 gitk:4558
 msgid "No commits selected"
 msgstr "Keine Versionen ausgewählt"
 
-#: gitk:1445 gitk:4045 gitk:12432
+#: gitk:1449 gitk:4075 gitk:12643
 msgid "Command line"
 msgstr "Kommandozeile"
 
-#: gitk:1511
+#: gitk:1515
 msgid "Can't parse git log output:"
 msgstr "Ausgabe von »git log« kann nicht erkannt werden:"
 
-#: gitk:1740
+#: gitk:1744
 msgid "No commit information available"
 msgstr "Keine Versionsinformation verfügbar"
 
-#: gitk:1903 gitk:1932 gitk:4315 gitk:9669 gitk:11241 gitk:11521
+#: gitk:1911 gitk:1940 gitk:4345 gitk:9830 gitk:11434 gitk:11721
 msgid "OK"
 msgstr "Ok"
 
-#: gitk:1934 gitk:4317 gitk:9196 gitk:9275 gitk:9391 gitk:9440 gitk:9671
-#: gitk:11242 gitk:11522
+#: gitk:1942 gitk:4347 gitk:9266 gitk:9345 gitk:9475 gitk:9561 gitk:9832
+#: gitk:11435 gitk:11722
 msgid "Cancel"
 msgstr "Abbrechen"
 
-#: gitk:2069
+#: gitk:2091
 msgid "&Update"
 msgstr "&Aktualisieren"
 
-#: gitk:2070
+#: gitk:2092
 msgid "&Reload"
 msgstr "&Neu laden"
 
-#: gitk:2071
+#: gitk:2093
 msgid "Reread re&ferences"
 msgstr "&Zweige neu laden"
 
-#: gitk:2072
+#: gitk:2094
 msgid "&List references"
 msgstr "Zweige/Markierungen auf&listen"
 
-#: gitk:2074
+#: gitk:2096
 msgid "Start git &gui"
 msgstr "»git &gui« starten"
 
-#: gitk:2076
+#: gitk:2098
 msgid "&Quit"
 msgstr "&Beenden"
 
-#: gitk:2068
+#: gitk:2090
 msgid "&File"
 msgstr "&Datei"
 
-#: gitk:2080
+#: gitk:2102
 msgid "&Preferences"
 msgstr "&Einstellungen"
 
-#: gitk:2079
+#: gitk:2101
 msgid "&Edit"
 msgstr "&Bearbeiten"
 
-#: gitk:2084
+#: gitk:2106
 msgid "&New view..."
 msgstr "&Neue Ansicht ..."
 
-#: gitk:2085
+#: gitk:2107
 msgid "&Edit view..."
 msgstr "Ansicht &bearbeiten ..."
 
-#: gitk:2086
+#: gitk:2108
 msgid "&Delete view"
 msgstr "Ansicht &entfernen"
 
-#: gitk:2088 gitk:4043
+#: gitk:2110
 msgid "&All files"
 msgstr "&Alle Dateien"
 
-#: gitk:2083 gitk:4067
+#: gitk:2105
 msgid "&View"
 msgstr "&Ansicht"
 
-#: gitk:2093 gitk:2103 gitk:3012
+#: gitk:2115 gitk:2125
 msgid "&About gitk"
 msgstr "Über &gitk"
 
-#: gitk:2094 gitk:2108
+#: gitk:2116 gitk:2130
 msgid "&Key bindings"
 msgstr "&Tastenkürzel"
 
-#: gitk:2092 gitk:2107
+#: gitk:2114 gitk:2129
 msgid "&Help"
 msgstr "&Hilfe"
 
-#: gitk:2185 gitk:8652
+#: gitk:2207 gitk:8722
 msgid "SHA1 ID:"
 msgstr "SHA1 ID:"
 
-#: gitk:2229
+#: gitk:2251
 msgid "Row"
 msgstr "Zeile"
 
-#: gitk:2267
+#: gitk:2289
 msgid "Find"
 msgstr "Suche"
 
-#: gitk:2295
+#: gitk:2317
 msgid "commit"
 msgstr "Version nach"
 
-#: gitk:2299 gitk:2301 gitk:4687 gitk:4710 gitk:4734 gitk:6755 gitk:6827
-#: gitk:6912
+#: gitk:2321 gitk:2323 gitk:4717 gitk:4740 gitk:4764 gitk:6785 gitk:6857
+#: gitk:6942
 msgid "containing:"
 msgstr "Beschreibung:"
 
-#: gitk:2302 gitk:3526 gitk:3531 gitk:4763
+#: gitk:2324 gitk:3556 gitk:3561 gitk:4793
 msgid "touching paths:"
 msgstr "Dateien:"
 
-#: gitk:2303 gitk:4777
+#: gitk:2325 gitk:4807
 msgid "adding/removing string:"
 msgstr "Änderungen:"
 
-#: gitk:2304 gitk:4779
+#: gitk:2326 gitk:4809
 msgid "changing lines matching:"
 msgstr "Geänderte Zeilen entsprechen:"
 
-#: gitk:2313 gitk:2315 gitk:4766
+#: gitk:2335 gitk:2337 gitk:4796
 msgid "Exact"
 msgstr "Exakt"
 
-#: gitk:2315 gitk:4854 gitk:6723
+#: gitk:2337 gitk:4884 gitk:6753
 msgid "IgnCase"
 msgstr "Kein Groß/Klein"
 
-#: gitk:2315 gitk:4736 gitk:4852 gitk:6719
+#: gitk:2337 gitk:4766 gitk:4882 gitk:6749
 msgid "Regexp"
 msgstr "Regexp"
 
-#: gitk:2317 gitk:2318 gitk:4874 gitk:4904 gitk:4911 gitk:6848 gitk:6916
+#: gitk:2339 gitk:2340 gitk:4904 gitk:4934 gitk:4941 gitk:6878 gitk:6946
 msgid "All fields"
 msgstr "Alle Felder"
 
-#: gitk:2318 gitk:4871 gitk:4904 gitk:6786
+#: gitk:2340 gitk:4901 gitk:4934 gitk:6816
 msgid "Headline"
 msgstr "Überschrift"
 
-#: gitk:2319 gitk:4871 gitk:6786 gitk:6916 gitk:7389
+#: gitk:2341 gitk:4901 gitk:6816 gitk:6946 gitk:7454
 msgid "Comments"
 msgstr "Beschreibung"
 
-#: gitk:2319 gitk:4871 gitk:4876 gitk:4911 gitk:6786 gitk:7324 gitk:8830
-#: gitk:8845
+#: gitk:2341 gitk:4901 gitk:4906 gitk:4941 gitk:6816 gitk:7389 gitk:8900
+#: gitk:8915
 msgid "Author"
 msgstr "Autor"
 
-#: gitk:2319 gitk:4871 gitk:6786 gitk:7326
+#: gitk:2341 gitk:4901 gitk:6816 gitk:7391
 msgid "Committer"
 msgstr "Eintragender"
 
-#: gitk:2350
+#: gitk:2375
 msgid "Search"
 msgstr "Suchen"
 
-#: gitk:2358
+#: gitk:2383
 msgid "Diff"
 msgstr "Vergleich"
 
-#: gitk:2360
+#: gitk:2385
 msgid "Old version"
 msgstr "Alte Version"
 
-#: gitk:2362
+#: gitk:2387
 msgid "New version"
 msgstr "Neue Version"
 
-#: gitk:2364
+#: gitk:2390
 msgid "Lines of context"
 msgstr "Kontextzeilen"
 
-#: gitk:2374
+#: gitk:2400
 msgid "Ignore space change"
 msgstr "Leerzeichenänderungen ignorieren"
 
-#: gitk:2378 gitk:2380 gitk:7959 gitk:8206
+#: gitk:2404 gitk:2406 gitk:8024 gitk:8276
 msgid "Line diff"
 msgstr "Zeilenunterschied"
 
-#: gitk:2445
+#: gitk:2471
 msgid "Patch"
 msgstr "Patch"
 
-#: gitk:2447
+#: gitk:2473
 msgid "Tree"
 msgstr "Baum"
 
-#: gitk:2617 gitk:2637
+#: gitk:2643 gitk:2664
 msgid "Diff this -> selected"
 msgstr "Vergleich: diese -> gewählte"
 
-#: gitk:2618 gitk:2638
+#: gitk:2644 gitk:2665
 msgid "Diff selected -> this"
 msgstr "Vergleich: gewählte -> diese"
 
-#: gitk:2619 gitk:2639
+#: gitk:2645 gitk:2666
 msgid "Make patch"
 msgstr "Patch erstellen"
 
-#: gitk:2620 gitk:9254
+#: gitk:2646 gitk:9324
 msgid "Create tag"
 msgstr "Markierung erstellen"
 
-#: gitk:2621 gitk:9371
+#: gitk:2647
+#, fuzzy
+msgid "Copy commit reference"
+msgstr "Keine Versionen ausgewählt"
+
+#: gitk:2648 gitk:9455
 msgid "Write commit to file"
 msgstr "Version in Datei schreiben"
 
-#: gitk:2622 gitk:9428
+#: gitk:2649
 msgid "Create new branch"
 msgstr "Neuen Zweig erstellen"
 
-#: gitk:2623
+#: gitk:2650
 msgid "Cherry-pick this commit"
 msgstr "Diese Version pflücken"
 
-#: gitk:2624
+#: gitk:2651
 msgid "Reset HEAD branch to here"
 msgstr "HEAD-Zweig auf diese Version zurücksetzen"
 
-#: gitk:2625
+#: gitk:2652
 msgid "Mark this commit"
 msgstr "Lesezeichen setzen"
 
-#: gitk:2626
+#: gitk:2653
 msgid "Return to mark"
 msgstr "Zum Lesezeichen"
 
-#: gitk:2627
+#: gitk:2654
 msgid "Find descendant of this and mark"
 msgstr "Abkömmling von Lesezeichen und dieser Version finden"
 
-#: gitk:2628
+#: gitk:2655
 msgid "Compare with marked commit"
 msgstr "Mit Lesezeichen vergleichen"
 
-#: gitk:2629 gitk:2640
+#: gitk:2656 gitk:2667
 msgid "Diff this -> marked commit"
 msgstr "Vergleich: diese -> gewählte Version"
 
-#: gitk:2630 gitk:2641
+#: gitk:2657 gitk:2668
 msgid "Diff marked commit -> this"
 msgstr "Vergleich: gewählte -> diese Version"
 
-#: gitk:2631
+#: gitk:2658
 msgid "Revert this commit"
 msgstr "Version umkehren"
 
-#: gitk:2647
+#: gitk:2674
 msgid "Check out this branch"
 msgstr "Auf diesen Zweig umstellen"
 
-#: gitk:2648
+#: gitk:2675
+#, fuzzy
+msgid "Rename this branch"
+msgstr "Zweig löschen"
+
+#: gitk:2676
 msgid "Remove this branch"
 msgstr "Zweig löschen"
 
-#: gitk:2649
+#: gitk:2677
 msgid "Copy branch name"
 msgstr "Zweigname kopieren"
 
-#: gitk:2656
+#: gitk:2684
 msgid "Highlight this too"
 msgstr "Diesen auch hervorheben"
 
-#: gitk:2657
+#: gitk:2685
 msgid "Highlight this only"
 msgstr "Nur diesen hervorheben"
 
-#: gitk:2658
+#: gitk:2686
 msgid "External diff"
 msgstr "Externes Diff-Programm"
 
-#: gitk:2659
+#: gitk:2687
 msgid "Blame parent commit"
 msgstr "Annotieren der Elternversion"
 
-#: gitk:2660
+#: gitk:2688
 msgid "Copy path"
 msgstr "Pfad kopieren"
 
-#: gitk:2667
+#: gitk:2695
 msgid "Show origin of this line"
 msgstr "Herkunft dieser Zeile anzeigen"
 
-#: gitk:2668
+#: gitk:2696
 msgid "Run git gui blame on this line"
 msgstr "Diese Zeile annotieren (»git gui blame«)"
 
-#: gitk:3014
+#: gitk:3040
+#, fuzzy
+msgid "About gitk"
+msgstr "Über &gitk"
+
+#: gitk:3042
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -375,517 +390,532 @@ msgstr ""
 "Benutzung und Weiterverbreitung gemäß den Bedingungen der GNU General Public "
 "License"
 
-#: gitk:3022 gitk:3089 gitk:9857
+#: gitk:3050 gitk:3117 gitk:10045
 msgid "Close"
 msgstr "Schließen"
 
-#: gitk:3043
+#: gitk:3071
 msgid "Gitk key bindings"
 msgstr "Gitk-Tastaturbelegung"
 
-#: gitk:3046
+#: gitk:3074
 msgid "Gitk key bindings:"
 msgstr "Gitk-Tastaturbelegung:"
 
-#: gitk:3048
+#: gitk:3076
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tBeenden"
 
-#: gitk:3049
+#: gitk:3077
 #, tcl-format
 msgid "<%s-W>\t\tClose window"
 msgstr "<%s-F>\t\tFenster schließen"
 
-#: gitk:3050
+#: gitk:3078
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Pos1>\t\tZur neuesten Version springen"
 
-#: gitk:3051
+#: gitk:3079
 msgid "<End>\t\tMove to last commit"
 msgstr "<Ende>\t\tZur ältesten Version springen"
 
-#: gitk:3052
+#: gitk:3080
 msgid "<Up>, p, k\tMove up one commit"
 msgstr "<Hoch>, p, k\tNächste neuere Version"
 
-#: gitk:3053
+#: gitk:3081
 msgid "<Down>, n, j\tMove down one commit"
 msgstr "<Runter>, n, j\tNächste ältere Version"
 
-#: gitk:3054
+#: gitk:3082
 msgid "<Left>, z, h\tGo back in history list"
 msgstr "<Links>, z, h\tEine Version zurückgehen"
 
-#: gitk:3055
+#: gitk:3083
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Rechts>, x, l\tEine Version weitergehen"
 
-#: gitk:3056
+#: gitk:3084
 #, tcl-format
 msgid "<%s-n>\tGo to n-th parent of current commit in history list"
 msgstr "<%s-n>\tZu n-ter Elternversion in Versionshistorie springen"
 
-#: gitk:3057
+#: gitk:3085
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<BildHoch>\tEine Seite nach oben blättern"
 
-#: gitk:3058
+#: gitk:3086
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<BildRunter>\tEine Seite nach unten blättern"
 
-#: gitk:3059
+#: gitk:3087
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Pos1>\tZum oberen Ende der Versionsliste blättern"
 
-#: gitk:3060
+#: gitk:3088
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-Ende>\tZum unteren Ende der Versionsliste blättern"
 
-#: gitk:3061
+#: gitk:3089
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Hoch>\tVersionsliste eine Zeile nach oben blättern"
 
-#: gitk:3062
+#: gitk:3090
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Runter>\tVersionsliste eine Zeile nach unten blättern"
 
-#: gitk:3063
+#: gitk:3091
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-BildHoch>\tVersionsliste eine Seite nach oben blättern"
 
-#: gitk:3064
+#: gitk:3092
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-BildRunter>\tVersionsliste eine Seite nach unten blättern"
 
-#: gitk:3065
+#: gitk:3093
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Umschalt-Hoch>\tRückwärts suchen (nach oben; neuere Versionen)"
 
-#: gitk:3066
+#: gitk:3094
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr "<Umschalt-Runter> Suchen (nach unten; ältere Versionen)"
 
-#: gitk:3067
+#: gitk:3095
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Entf>, b\t\tVergleich eine Seite nach oben blättern"
 
-#: gitk:3068
+#: gitk:3096
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<Löschtaste>\tVergleich eine Seite nach oben blättern"
 
-#: gitk:3069
+#: gitk:3097
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Leertaste>\tVergleich eine Seite nach unten blättern"
 
-#: gitk:3070
+#: gitk:3098
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\tVergleich um 18 Zeilen nach oben blättern"
 
-#: gitk:3071
+#: gitk:3099
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\tVergleich um 18 Zeilen nach unten blättern"
 
-#: gitk:3072
+#: gitk:3100
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tSuchen"
 
-#: gitk:3073
+#: gitk:3101
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tWeitersuchen"
 
-#: gitk:3074
+#: gitk:3102
 msgid "<Return>\tMove to next find hit"
 msgstr "<Eingabetaste>\tWeitersuchen"
 
-#: gitk:3075
+#: gitk:3103
 msgid "g\t\tGo to commit"
 msgstr "g\t\tZu Version springen"
 
-#: gitk:3076
+#: gitk:3104
 msgid "/\t\tFocus the search box"
 msgstr "/\t\tTastaturfokus ins Suchfeld"
 
-#: gitk:3077
+#: gitk:3105
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tRückwärts weitersuchen"
 
-#: gitk:3078
+#: gitk:3106
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tVergleich zur nächsten Datei blättern"
 
-#: gitk:3079
+#: gitk:3107
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tWeitersuchen im Vergleich"
 
-#: gitk:3080
+#: gitk:3108
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tRückwärts weitersuchen im Vergleich"
 
-#: gitk:3081
+#: gitk:3109
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-Nummerblock-Plus>\tSchrift vergrößern"
 
-#: gitk:3082
+#: gitk:3110
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-Plus>\tSchrift vergrößern"
 
-#: gitk:3083
+#: gitk:3111
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-Nummernblock-Minus> Schrift verkleinern"
 
-#: gitk:3084
+#: gitk:3112
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-Minus>\tSchrift verkleinern"
 
-#: gitk:3085
+#: gitk:3113
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tAktualisieren"
 
-#: gitk:3550 gitk:3559
+#: gitk:3580 gitk:3589
 #, tcl-format
 msgid "Error creating temporary directory %s:"
 msgstr "Fehler beim Erzeugen des temporären Verzeichnisses »%s«:"
 
-#: gitk:3572
+#: gitk:3602
 #, tcl-format
 msgid "Error getting \"%s\" from %s:"
 msgstr "Fehler beim Holen von »%s« von »%s«:"
 
-#: gitk:3635
+#: gitk:3665
 msgid "command failed:"
 msgstr "Kommando fehlgeschlagen:"
 
-#: gitk:3784
+#: gitk:3814
 msgid "No such commit"
 msgstr "Version nicht gefunden"
 
-#: gitk:3798
+#: gitk:3828
 msgid "git gui blame: command failed:"
 msgstr "git gui blame: Kommando fehlgeschlagen:"
 
-#: gitk:3829
+#: gitk:3859
 #, tcl-format
 msgid "Couldn't read merge head: %s"
 msgstr "Zusammenführungs-Spitze konnte nicht gelesen werden: %s"
 
-#: gitk:3837
+#: gitk:3867
 #, tcl-format
 msgid "Error reading index: %s"
 msgstr "Fehler beim Lesen der Bereitstellung (»index«): %s"
 
-#: gitk:3862
+#: gitk:3892
 #, tcl-format
 msgid "Couldn't start git blame: %s"
 msgstr "»git blame« konnte nicht gestartet werden: %s"
 
-#: gitk:3865 gitk:6754
+#: gitk:3895 gitk:6784
 msgid "Searching"
 msgstr "Suchen"
 
-#: gitk:3897
+#: gitk:3927
 #, tcl-format
 msgid "Error running git blame: %s"
 msgstr "Fehler beim Ausführen von »git blame«: %s"
 
-#: gitk:3925
+#: gitk:3955
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
 msgstr ""
 "Diese Zeile stammt aus Version %s, die nicht in dieser Ansicht gezeigt wird"
 
-#: gitk:3939
+#: gitk:3969
 msgid "External diff viewer failed:"
 msgstr "Externes Diff-Programm fehlgeschlagen:"
 
-#: gitk:4070
+#: gitk:4073
+#, fuzzy
+msgid "All files"
+msgstr "&Alle Dateien"
+
+#: gitk:4097
+#, fuzzy
+msgid "View"
+msgstr "&Ansicht"
+
+#: gitk:4100
 msgid "Gitk view definition"
 msgstr "Gitk-Ansichten"
 
-#: gitk:4074
+#: gitk:4104
 msgid "Remember this view"
 msgstr "Diese Ansicht speichern"
 
-#: gitk:4075
+#: gitk:4105
 msgid "References (space separated list):"
 msgstr "Zweige/Markierungen (durch Leerzeichen getrennte Liste):"
 
-#: gitk:4076
+#: gitk:4106
 msgid "Branches & tags:"
 msgstr "Zweige/Markierungen:"
 
-#: gitk:4077
+#: gitk:4107
 msgid "All refs"
 msgstr "Alle Markierungen und Zweige"
 
-#: gitk:4078
+#: gitk:4108
 msgid "All (local) branches"
 msgstr "Alle (lokalen) Zweige"
 
-#: gitk:4079
+#: gitk:4109
 msgid "All tags"
 msgstr "Alle Markierungen"
 
-#: gitk:4080
+#: gitk:4110
 msgid "All remote-tracking branches"
 msgstr "Alle Übernahmezweige"
 
-#: gitk:4081
+#: gitk:4111
 msgid "Commit Info (regular expressions):"
 msgstr "Versionsinformationen (reguläre Ausdrücke):"
 
-#: gitk:4082
+#: gitk:4112
 msgid "Author:"
 msgstr "Autor:"
 
-#: gitk:4083
+#: gitk:4113
 msgid "Committer:"
 msgstr "Eintragender:"
 
-#: gitk:4084
+#: gitk:4114
 msgid "Commit Message:"
 msgstr "Versionsbeschreibung:"
 
-#: gitk:4085
+#: gitk:4115
 msgid "Matches all Commit Info criteria"
 msgstr "Alle Versionsinformationen-Kriterien erfüllen"
 
-#: gitk:4086
+#: gitk:4116
 msgid "Matches no Commit Info criteria"
 msgstr "keine Versionsinformationen-Kriterien erfüllen"
 
-#: gitk:4087
+#: gitk:4117
 msgid "Changes to Files:"
 msgstr "Dateien:"
 
-#: gitk:4088
+#: gitk:4118
 msgid "Fixed String"
 msgstr "Zeichenkette"
 
-#: gitk:4089
+#: gitk:4119
 msgid "Regular Expression"
 msgstr "Regulärer Ausdruck"
 
-#: gitk:4090
+#: gitk:4120
 msgid "Search string:"
 msgstr "Suchausdruck:"
 
-#: gitk:4091
+#: gitk:4121
 msgid ""
 "Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2009 "
 "15:27:38\"):"
 msgstr ""
 "Datum (»2 weeks ago«, »2009-03-17 15:27:38«, »March 17, 2009 15:27:38«)"
 
-#: gitk:4092
+#: gitk:4122
 msgid "Since:"
 msgstr "Von:"
 
-#: gitk:4093
+#: gitk:4123
 msgid "Until:"
 msgstr "Bis:"
 
-#: gitk:4094
+#: gitk:4124
 msgid "Limit and/or skip a number of revisions (positive integer):"
 msgstr "Versionsanzahl begrenzen oder einige überspringen (ganzzahliger Wert):"
 
-#: gitk:4095
+#: gitk:4125
 msgid "Number to show:"
 msgstr "Anzeigen:"
 
-#: gitk:4096
+#: gitk:4126
 msgid "Number to skip:"
 msgstr "Überspringen:"
 
-#: gitk:4097
+#: gitk:4127
 msgid "Miscellaneous options:"
 msgstr "Sonstiges:"
 
-#: gitk:4098
+#: gitk:4128
 msgid "Strictly sort by date"
 msgstr "Streng nach Datum sortieren"
 
-#: gitk:4099
+#: gitk:4129
 msgid "Mark branch sides"
 msgstr "Zweig-Seiten markieren"
 
-#: gitk:4100
+#: gitk:4130
 msgid "Limit to first parent"
 msgstr "Auf erste Elternversion beschränken"
 
-#: gitk:4101
+#: gitk:4131
 msgid "Simple history"
 msgstr "Einfache Historie"
 
-#: gitk:4102
+#: gitk:4132
 msgid "Additional arguments to git log:"
 msgstr "Zusätzliche Argumente für »git log«:"
 
-#: gitk:4103
+#: gitk:4133
 msgid "Enter files and directories to include, one per line:"
 msgstr "Folgende Dateien und Verzeichnisse anzeigen (eine pro Zeile):"
 
-#: gitk:4104
+#: gitk:4134
 msgid "Command to generate more commits to include:"
 msgstr "Versionsliste durch folgendes Kommando erzeugen lassen:"
 
-#: gitk:4228
+#: gitk:4258
 msgid "Gitk: edit view"
 msgstr "Gitk: Ansicht bearbeiten"
 
-#: gitk:4236
+#: gitk:4266
 msgid "-- criteria for selecting revisions"
 msgstr "-- Auswahl der angezeigten Versionen"
 
-#: gitk:4241
+#: gitk:4271
 msgid "View Name"
 msgstr "Ansichtsname"
 
-#: gitk:4316
+#: gitk:4346
 msgid "Apply (F5)"
 msgstr "Anwenden (F5)"
 
-#: gitk:4354
+#: gitk:4384
 msgid "Error in commit selection arguments:"
 msgstr "Fehler in den ausgewählten Versionen:"
 
-#: gitk:4409 gitk:4462 gitk:4924 gitk:4938 gitk:6208 gitk:12373 gitk:12374
+#: gitk:4439 gitk:4492 gitk:4954 gitk:4968 gitk:6238 gitk:12584 gitk:12585
 msgid "None"
 msgstr "Keine"
 
-#: gitk:5021 gitk:5026
+#: gitk:5051 gitk:5056
 msgid "Descendant"
 msgstr "Abkömmling"
 
-#: gitk:5022
+#: gitk:5052
 msgid "Not descendant"
 msgstr "Kein Abkömmling"
 
-#: gitk:5029 gitk:5034
+#: gitk:5059 gitk:5064
 msgid "Ancestor"
 msgstr "Vorgänger"
 
-#: gitk:5030
+#: gitk:5060
 msgid "Not ancestor"
 msgstr "Kein Vorgänger"
 
-#: gitk:5324
+#: gitk:5354
 msgid "Local changes checked in to index but not committed"
 msgstr "Lokale Änderungen bereitgestellt, aber nicht eingetragen"
 
-#: gitk:5360
+#: gitk:5390
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokale Änderungen, nicht bereitgestellt"
 
-#: gitk:7134
+#: gitk:7138
+#, fuzzy
+msgid "Error starting web browser:"
+msgstr "Fehler beim Holen von »%s« von »%s«:"
+
+#: gitk:7199
 msgid "and many more"
 msgstr "und weitere"
 
-#: gitk:7137
+#: gitk:7202
 msgid "many"
 msgstr "viele"
 
-#: gitk:7328
+#: gitk:7393
 msgid "Tags:"
 msgstr "Markierungen:"
 
-#: gitk:7345 gitk:7351 gitk:8825
+#: gitk:7410 gitk:7416 gitk:8895
 msgid "Parent"
 msgstr "Eltern"
 
-#: gitk:7356
+#: gitk:7421
 msgid "Child"
 msgstr "Kind"
 
-#: gitk:7365
+#: gitk:7430
 msgid "Branch"
 msgstr "Zweig"
 
-#: gitk:7368
+#: gitk:7433
 msgid "Follows"
 msgstr "Folgt auf"
 
-#: gitk:7371
+#: gitk:7436
 msgid "Precedes"
 msgstr "Vorgänger von"
 
-#: gitk:7966
+#: gitk:8031
 #, tcl-format
 msgid "Error getting diffs: %s"
 msgstr "Fehler beim Laden des Vergleichs: %s"
 
-#: gitk:8650
+#: gitk:8720
 msgid "Goto:"
 msgstr "Gehe zu:"
 
-#: gitk:8671
+#: gitk:8741
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "Kurzer SHA1-Hashwert »%s« ist mehrdeutig"
 
-#: gitk:8678
+#: gitk:8748
 #, tcl-format
 msgid "Revision %s is not known"
 msgstr "Version »%s« ist unbekannt"
 
-#: gitk:8688
+#: gitk:8758
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "SHA1-Hashwert »%s« ist unbekannt"
 
-#: gitk:8690
+#: gitk:8760
 #, tcl-format
 msgid "Revision %s is not in the current view"
 msgstr "Version »%s« wird in der aktuellen Ansicht nicht angezeigt"
 
-#: gitk:8832 gitk:8847
+#: gitk:8902 gitk:8917
 msgid "Date"
 msgstr "Datum"
 
-#: gitk:8835
+#: gitk:8905
 msgid "Children"
 msgstr "Kinder"
 
-#: gitk:8898
+#: gitk:8968
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Zweig »%s« hierher zurücksetzen"
 
-#: gitk:8900
+#: gitk:8970
 msgid "Detached head: can't reset"
 msgstr "Zweigspitze ist abgetrennt: Zurücksetzen nicht möglich"
 
-#: gitk:9005 gitk:9011
+#: gitk:9075 gitk:9081
 msgid "Skipping merge commit "
 msgstr "Überspringe Zusammenführungs-Version "
 
-#: gitk:9020 gitk:9025
+#: gitk:9090 gitk:9095
 msgid "Error getting patch ID for "
 msgstr "Fehler beim Holen der Patch-ID für "
 
-#: gitk:9021 gitk:9026
+#: gitk:9091 gitk:9096
 msgid " - stopping\n"
 msgstr " - Abbruch.\n"
 
-#: gitk:9031 gitk:9034 gitk:9042 gitk:9056 gitk:9065
+#: gitk:9101 gitk:9104 gitk:9112 gitk:9126 gitk:9135
 msgid "Commit "
 msgstr "Version "
 
-#: gitk:9035
+#: gitk:9105
 msgid ""
 " is the same patch as\n"
 "       "
@@ -893,7 +923,7 @@ msgstr ""
 " ist das gleiche Patch wie\n"
 "       "
 
-#: gitk:9043
+#: gitk:9113
 msgid ""
 " differs from\n"
 "       "
@@ -901,7 +931,7 @@ msgstr ""
 " ist unterschiedlich von\n"
 "       "
 
-#: gitk:9045
+#: gitk:9115
 msgid ""
 "Diff of commits:\n"
 "\n"
@@ -909,131 +939,150 @@ msgstr ""
 "Vergleich der Versionen:\n"
 "\n"
 
-#: gitk:9057 gitk:9066
+#: gitk:9127 gitk:9136
 #, tcl-format
 msgid " has %s children - stopping\n"
 msgstr " hat %s Kinder. Abbruch\n"
 
-#: gitk:9085
+#: gitk:9155
 #, tcl-format
 msgid "Error writing commit to file: %s"
 msgstr "Fehler beim Schreiben der Version in Datei: %s"
 
-#: gitk:9091
+#: gitk:9161
 #, tcl-format
 msgid "Error diffing commits: %s"
 msgstr "Fehler beim Vergleichen der Versionen: %s"
 
-#: gitk:9137
+#: gitk:9207
 msgid "Top"
 msgstr "Oben"
 
-#: gitk:9138
+#: gitk:9208
 msgid "From"
 msgstr "Von"
 
-#: gitk:9143
+#: gitk:9213
 msgid "To"
 msgstr "bis"
 
-#: gitk:9167
+#: gitk:9237
 msgid "Generate patch"
 msgstr "Patch erstellen"
 
-#: gitk:9169
+#: gitk:9239
 msgid "From:"
 msgstr "Von:"
 
-#: gitk:9178
+#: gitk:9248
 msgid "To:"
 msgstr "bis:"
 
-#: gitk:9187
+#: gitk:9257
 msgid "Reverse"
 msgstr "Umgekehrt"
 
-#: gitk:9189 gitk:9385
+#: gitk:9259 gitk:9469
 msgid "Output file:"
 msgstr "Ausgabedatei:"
 
-#: gitk:9195
+#: gitk:9265
 msgid "Generate"
 msgstr "Erzeugen"
 
-#: gitk:9233
+#: gitk:9303
 msgid "Error creating patch:"
 msgstr "Fehler beim Erzeugen des Patches:"
 
-#: gitk:9256 gitk:9373 gitk:9430
+#: gitk:9326 gitk:9457 gitk:9545
 msgid "ID:"
 msgstr "ID:"
 
-#: gitk:9265
+#: gitk:9335
 msgid "Tag name:"
 msgstr "Markierungsname:"
 
-#: gitk:9268
+#: gitk:9338
 msgid "Tag message is optional"
 msgstr "Eine Markierungsbeschreibung ist optional"
 
-#: gitk:9270
+#: gitk:9340
 msgid "Tag message:"
 msgstr "Markierungsbeschreibung:"
 
-#: gitk:9274 gitk:9439
+#: gitk:9344 gitk:9515
 msgid "Create"
 msgstr "Erstellen"
 
-#: gitk:9292
+#: gitk:9362
 msgid "No tag name specified"
 msgstr "Kein Markierungsname angegeben"
 
-#: gitk:9296
+#: gitk:9366
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Markierung »%s« existiert bereits."
 
-#: gitk:9306
+#: gitk:9376
 msgid "Error creating tag:"
 msgstr "Fehler beim Erstellen der Markierung:"
 
-#: gitk:9382
+#: gitk:9466
 msgid "Command:"
 msgstr "Kommando:"
 
-#: gitk:9390
+#: gitk:9474
 msgid "Write"
 msgstr "Schreiben"
 
-#: gitk:9408
+#: gitk:9492
 msgid "Error writing commit:"
 msgstr "Fehler beim Schreiben der Version:"
 
-#: gitk:9435
+#: gitk:9514
+#, fuzzy
+msgid "Create branch"
+msgstr "Neuen Zweig erstellen"
+
+#: gitk:9530
+#, fuzzy, tcl-format
+msgid "Rename branch %s"
+msgstr "Zweig »%s« auf »%s« zurücksetzen?"
+
+#: gitk:9531
+msgid "Rename"
+msgstr ""
+
+#: gitk:9555
 msgid "Name:"
 msgstr "Name:"
 
-#: gitk:9458
+#: gitk:9579
 msgid "Please specify a name for the new branch"
 msgstr "Bitte geben Sie einen Namen für den neuen Zweig an."
 
-#: gitk:9463
+#: gitk:9584
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
 msgstr "Zweig »%s« existiert bereits. Soll er überschrieben werden?"
 
-#: gitk:9530
+#: gitk:9628
+#, fuzzy
+msgid "Please specify a new name for the branch"
+msgstr "Bitte geben Sie einen Namen für den neuen Zweig an."
+
+#: gitk:9691
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
 msgstr ""
 "Version »%s« ist bereits im Zweig »%s« enthalten -- trotzdem erneut "
 "eintragen?"
 
-#: gitk:9535
+#: gitk:9696
 msgid "Cherry-picking"
 msgstr "Version pflücken"
 
-#: gitk:9544
+#: gitk:9705
 #, tcl-format
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
@@ -1043,7 +1092,7 @@ msgstr ""
 "vorliegen. Bitte diese Änderungen eintragen, zurücksetzen oder\n"
 "zwischenspeichern (»git stash«) und dann erneut versuchen."
 
-#: gitk:9550
+#: gitk:9711
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
@@ -1052,21 +1101,20 @@ msgstr ""
 "ist. Soll das Zusammenführungs-Werkzeug (»git citool«) aufgerufen\n"
 "werden, um diesen Konflikt aufzulösen?"
 
-#: gitk:9566 gitk:9624
+#: gitk:9727 gitk:9785
 msgid "No changes committed"
 msgstr "Keine Änderungen eingetragen"
 
-#: gitk:9593
+#: gitk:9754
 #, tcl-format
 msgid "Commit %s is not included in branch %s -- really revert it?"
-msgstr ""
-"Version »%s« ist nicht im Zweig »%s« enthalten -- trotzdem umkehren?"
+msgstr "Version »%s« ist nicht im Zweig »%s« enthalten -- trotzdem umkehren?"
 
-#: gitk:9598
+#: gitk:9759
 msgid "Reverting"
 msgstr "Umkehren"
 
-#: gitk:9606
+#: gitk:9767
 #, tcl-format
 msgid ""
 "Revert failed because of local changes to the following files:%s Please "
@@ -1076,7 +1124,7 @@ msgstr ""
 "vorliegen. Bitte diese Änderungen eintragen, zurücksetzen oder\n"
 "zwischenspeichern (»git stash«) und dann erneut versuchen."
 
-#: gitk:9610
+#: gitk:9771
 msgid ""
 "Revert failed because of merge conflict.\n"
 " Do you wish to run git citool to resolve it?"
@@ -1085,30 +1133,30 @@ msgstr ""
 "ist. Soll das Zusammenführungs-Werkzeug (»git citool«) aufgerufen\n"
 "werden, um diesen Konflikt aufzulösen?"
 
-#: gitk:9653
+#: gitk:9814
 msgid "Confirm reset"
 msgstr "Zurücksetzen bestätigen"
 
-#: gitk:9655
+#: gitk:9816
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "Zweig »%s« auf »%s« zurücksetzen?"
 
-#: gitk:9657
+#: gitk:9818
 msgid "Reset type:"
 msgstr "Art des Zurücksetzens:"
 
-#: gitk:9660
+#: gitk:9821
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Harmlos: Arbeitskopie und Bereitstellung unverändert"
 
-#: gitk:9663
+#: gitk:9824
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr ""
 "Gemischt: Arbeitskopie unverändert,\n"
 "Bereitstellung zurückgesetzt"
 
-#: gitk:9666
+#: gitk:9827
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -1116,21 +1164,26 @@ msgstr ""
 "Hart: Arbeitskopie und Bereitstellung\n"
 "(Alle lokalen Änderungen werden gelöscht)"
 
-#: gitk:9683
+#: gitk:9844
 msgid "Resetting"
 msgstr "Zurücksetzen"
 
-#: gitk:9743
+#: gitk:9917
+#, tcl-format
+msgid "A local branch named %s exists already"
+msgstr ""
+
+#: gitk:9925
 msgid "Checking out"
 msgstr "Umstellen"
 
-#: gitk:9796
+#: gitk:9984
 msgid "Cannot delete the currently checked-out branch"
 msgstr ""
 "Der Zweig, auf den die Arbeitskopie momentan umgestellt ist, kann nicht "
 "gelöscht werden."
 
-#: gitk:9802
+#: gitk:9990
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -1139,16 +1192,16 @@ msgstr ""
 "Die Versionen auf Zweig »%s« existieren auf keinem anderen Zweig.\n"
 "Zweig »%s« trotzdem löschen?"
 
-#: gitk:9833
+#: gitk:10021
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Markierungen und Zweige: %s"
 
-#: gitk:9850
+#: gitk:10038
 msgid "Filter"
 msgstr "Filtern"
 
-#: gitk:10146
+#: gitk:10339
 msgid ""
 "Error reading commit topology information; branch and preceding/following "
 "tag information will be incomplete."
@@ -1156,218 +1209,223 @@ msgstr ""
 "Fehler beim Lesen der Strukturinformationen; Zweige und Informationen zu "
 "Vorgänger/Nachfolger werden unvollständig sein."
 
-#: gitk:11123
+#: gitk:11316
 msgid "Tag"
 msgstr "Markierung"
 
-#: gitk:11127
+#: gitk:11320
 msgid "Id"
 msgstr "Id"
 
-#: gitk:11210
+#: gitk:11403
 msgid "Gitk font chooser"
 msgstr "Gitk-Schriften wählen"
 
-#: gitk:11227
+#: gitk:11420
 msgid "B"
 msgstr "F"
 
-#: gitk:11230
+#: gitk:11423
 msgid "I"
 msgstr "K"
 
-#: gitk:11348
+#: gitk:11541
 msgid "Commit list display options"
 msgstr "Anzeige der Versionsliste"
 
-#: gitk:11351
+#: gitk:11544
 msgid "Maximum graph width (lines)"
 msgstr "Maximale Graphenbreite (Zeilen)"
 
-#: gitk:11355
+#: gitk:11548
 #, no-tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Maximale Graphenbreite (% des Fensters)"
 
-#: gitk:11358
+#: gitk:11551
 msgid "Show local changes"
 msgstr "Lokale Änderungen anzeigen"
 
-#: gitk:11361
+#: gitk:11554
 msgid "Auto-select SHA1 (length)"
 msgstr "SHA1-Hashwert (Länge) automatisch auswählen"
 
-#: gitk:11365
+#: gitk:11558
 msgid "Hide remote refs"
 msgstr "Entfernte Zweige/Markierungen ausblenden"
 
-#: gitk:11369
+#: gitk:11562
 msgid "Diff display options"
 msgstr "Anzeige des Vergleichs"
 
-#: gitk:11371
+#: gitk:11564
 msgid "Tab spacing"
 msgstr "Tabulatorbreite"
 
-#: gitk:11374
+#: gitk:11567
 msgid "Display nearby tags/heads"
 msgstr "Naheliegende Markierungen/Zweigspitzen anzeigen"
 
-#: gitk:11377
+#: gitk:11570
 msgid "Maximum # tags/heads to show"
 msgstr "Maximale Anzahl anzuzeigender Markierungen/Zweigspitzen"
 
-#: gitk:11380
+#: gitk:11573
 msgid "Limit diffs to listed paths"
 msgstr "Vergleich nur für angezeigte Pfade"
 
-#: gitk:11383
+#: gitk:11576
 msgid "Support per-file encodings"
 msgstr "Zeichenkodierung pro Datei ermitteln"
 
-#: gitk:11389 gitk:11536
+#: gitk:11582 gitk:11736
 msgid "External diff tool"
 msgstr "Externes Diff-Programm"
 
-#: gitk:11390
+#: gitk:11583
 msgid "Choose..."
 msgstr "Wählen ..."
 
-#: gitk:11395
+#: gitk:11590
+msgid "Web browser"
+msgstr ""
+
+#: gitk:11595
 msgid "General options"
 msgstr "Allgemeine Optionen"
 
-#: gitk:11398
+#: gitk:11598
 msgid "Use themed widgets"
 msgstr "Aussehen der Benutzeroberfläche durch Thema bestimmen"
 
-#: gitk:11400
+#: gitk:11600
 msgid "(change requires restart)"
 msgstr "(Änderungen werden erst nach Neustart wirksam)"
 
-#: gitk:11402
+#: gitk:11602
 msgid "(currently unavailable)"
 msgstr "(Momentan nicht verfügbar)"
 
-#: gitk:11413
+#: gitk:11613
 msgid "Colors: press to choose"
 msgstr "Farben: Klicken zum Wählen"
 
-#: gitk:11416
+#: gitk:11616
 msgid "Interface"
 msgstr "Benutzeroberfläche"
 
-#: gitk:11417
+#: gitk:11617
 msgid "interface"
 msgstr "Benutzeroberfläche"
 
-#: gitk:11420
+#: gitk:11620
 msgid "Background"
 msgstr "Hintergrund"
 
-#: gitk:11421 gitk:11451
+#: gitk:11621 gitk:11651
 msgid "background"
 msgstr "Hintergrund"
 
-#: gitk:11424
+#: gitk:11624
 msgid "Foreground"
 msgstr "Vordergrund"
 
-#: gitk:11425
+#: gitk:11625
 msgid "foreground"
 msgstr "Vordergrund"
 
-#: gitk:11428
+#: gitk:11628
 msgid "Diff: old lines"
 msgstr "Vergleich: Alte Zeilen"
 
-#: gitk:11429
+#: gitk:11629
 msgid "diff old lines"
 msgstr "Vergleich - Alte Zeilen"
 
-#: gitk:11433
+#: gitk:11633
 msgid "Diff: new lines"
 msgstr "Vergleich: Neue Zeilen"
 
-#: gitk:11434
+#: gitk:11634
 msgid "diff new lines"
 msgstr "Vergleich - Neue Zeilen"
 
-#: gitk:11438
+#: gitk:11638
 msgid "Diff: hunk header"
 msgstr "Vergleich: Änderungstitel"
 
-#: gitk:11440
+#: gitk:11640
 msgid "diff hunk header"
 msgstr "Vergleich - Änderungstitel"
 
-#: gitk:11444
+#: gitk:11644
 msgid "Marked line bg"
 msgstr "Hintergrund für markierte Zeile"
 
-#: gitk:11446
+#: gitk:11646
 msgid "marked line background"
 msgstr "Hintergrund für markierte Zeile"
 
-#: gitk:11450
+#: gitk:11650
 msgid "Select bg"
 msgstr "Hintergrundfarbe auswählen"
 
-#: gitk:11459
+#: gitk:11659
 msgid "Fonts: press to choose"
 msgstr "Schriftart: Klicken zum Wählen"
 
-#: gitk:11461
+#: gitk:11661
 msgid "Main font"
 msgstr "Programmschriftart"
 
-#: gitk:11462
+#: gitk:11662
 msgid "Diff display font"
 msgstr "Schriftart für Vergleich"
 
-#: gitk:11463
+#: gitk:11663
 msgid "User interface font"
 msgstr "Beschriftungen"
 
-#: gitk:11485
+#: gitk:11685
 msgid "Gitk preferences"
 msgstr "Gitk-Einstellungen"
 
-#: gitk:11494
+#: gitk:11694
 msgid "General"
 msgstr "Allgemein"
 
-#: gitk:11495
+#: gitk:11695
 msgid "Colors"
 msgstr "Farben"
 
-#: gitk:11496
+#: gitk:11696
 msgid "Fonts"
 msgstr "Schriftarten"
 
-#: gitk:11546
+#: gitk:11746
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: Farbe wählen für %s"
 
-#: gitk:12059
+#: gitk:12259
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
 msgstr ""
-"Entschuldigung, gitk kann nicht mit dieser Tcl/Tk Version ausgeführt werden.\n"
+"Entschuldigung, gitk kann nicht mit dieser Tcl/Tk Version ausgeführt "
+"werden.\n"
 " Gitk erfordert mindestens Tcl/Tk 8.4."
 
-#: gitk:12269
+#: gitk:12476
 msgid "Cannot find a git repository here."
 msgstr "Kein Git-Projektarchiv gefunden."
 
-#: gitk:12316
+#: gitk:12523
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Mehrdeutige Angabe »%s«: Sowohl Version als auch Dateiname existiert."
 
-#: gitk:12328
+#: gitk:12535
 msgid "Bad arguments to gitk:"
 msgstr "Falsche Kommandozeilen-Parameter für gitk:"
 
-- 
2.17.1





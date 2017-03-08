Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E846D202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 21:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754631AbdCHVCp (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 16:02:45 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36234 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754367AbdCHVCm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 16:02:42 -0500
Received: by mail-wm0-f53.google.com with SMTP id n11so124896382wma.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 13:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kn55t8nM8aEfhNFtR4FZe23wSFelDbZYZLEL7vBj1Eo=;
        b=EEOa6XxkDoKMEG/2WKW9L4ta5ULWtmEh4cAVjLZXGr9BCCNHXm0MxxvwSBXAGsZW5X
         y08U2g/ls0pR23XAP1mHyzP7osZl/oJIYg3pCws91lKJq1DjWlki1AjcoMu/km4td+kE
         ozIVOm/R9lyNPpxW0Urif2iHuFVxDGNgVqC/ejfg+Yl/4oNywDy1klpr8cXeMqs9a5a1
         XEwHzVqZBK+Vw7vtfTVRWDDaR+5XwOBvyEJaolEEKraJjARqQrnQGhNRok2NbsvrxqSM
         TU7J4nqOGtgW+AfdoDW0kOhr0pVSips6pj8iZ5mSch7zH9COd4OcvO1wwTVwfXKTF6rw
         pkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kn55t8nM8aEfhNFtR4FZe23wSFelDbZYZLEL7vBj1Eo=;
        b=AiwfqqafTelkUbIrb1Yim7A/fpsySg7RsfDAZ4G1/tQ1L1s8OmkOK9H73WjDIvupA/
         xmQs4806/T8OYocImXk3VWDng6Qibi6JoVwoPpZsp9RhYdvSxLWy3NR/+iiSYWK+qXuN
         0fPyrx06m2EyYsDz1Axouy+e3h1oGml9KwbO4dHakgge8A6yD1ANeL3VJyxpjFTbYlkj
         EXCCrpq1OChcLLAPhGy+ziKNDTmhcj9WUjdtP7pqlZHul9fq9GI56ozV1q2hwUJcSa5r
         Dxa/xrzeBhDztA1NDKknDBX/WQA16DNzkEnx7wyzVxLinmao35ZxfHQVvHLu2pgKDQoP
         JcdA==
X-Gm-Message-State: AMke39kKUQS42YpdM0TPBjnAWNHH1V4nAdUQiOlxTT7+XhGNSeYQVTSdTjuxGylfxUWFuA==
X-Received: by 10.28.84.18 with SMTP id i18mr7801877wmb.12.1489006399875;
        Wed, 08 Mar 2017 12:53:19 -0800 (PST)
Received: from localhost.localdomain (2a02-8388-0b40-0580-f50d-465b-b746-dc93.cable.dynamic.v6.surfer.at. [2a02:8388:b40:580:f50d:465b:b746:dc93])
        by smtp.gmail.com with ESMTPSA id 40sm5604065wry.22.2017.03.08.12.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Mar 2017 12:53:19 -0800 (PST)
From:   =?UTF-8?q?Florian=20Sch=C3=BCller?= <florian.schueller@gmail.com>
To:     paulus@ozlabs.org, git@vger.kernel.org
Cc:     =?UTF-8?q?Florian=20Sch=C3=BCller?= <florian.schueller@gmail.com>
Subject: [PATCH 2/4] Update of German translation
Date:   Wed,  8 Mar 2017 21:52:53 +0100
Message-Id: <20170308205255.18976-3-florian.schueller@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170308205255.18976-1-florian.schueller@gmail.com>
References: <20170308205255.18976-1-florian.schueller@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 po/de.po | 681 ++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 366 insertions(+), 315 deletions(-)

diff --git a/po/de.po b/po/de.po
index 5db3824..ab90c34 100644
--- a/po/de.po
+++ b/po/de.po
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2015-05-17 14:32+1000\n"
+"POT-Creation-Date: 2017-01-02 10:08+0100\n"
 "PO-Revision-Date: 2015-10-20 14:20+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
@@ -17,33 +17,33 @@ msgstr ""
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
 
-#: gitk:140
+#: gitk:146
 msgid "Couldn't get list of unmerged files:"
 msgstr "Liste der nicht zusammengeführten Dateien nicht gefunden:"
 
-#: gitk:212 gitk:2381
+#: gitk:218 gitk:2409
 msgid "Color words"
 msgstr "Wörter einfärben"
 
-#: gitk:217 gitk:2381 gitk:8220 gitk:8253
+#: gitk:223 gitk:2409 gitk:8255 gitk:8288
 msgid "Markup words"
 msgstr "Wörter kennzeichnen"
 
-#: gitk:324
+#: gitk:330
 msgid "Error parsing revisions:"
 msgstr "Fehler beim Laden der Versionen:"
 
-#: gitk:380
+#: gitk:386
 msgid "Error executing --argscmd command:"
 msgstr "Fehler beim Ausführen des --argscmd-Kommandos:"
 
-#: gitk:393
+#: gitk:399
 msgid "No files selected: --merge specified but no files are unmerged."
 msgstr ""
 "Keine Dateien ausgewählt: Es wurde --merge angegeben, aber es existieren "
 "keine nicht zusammengeführten Dateien."
 
-#: gitk:396
+#: gitk:402
 msgid ""
 "No files selected: --merge specified but no unmerged files are within file "
 "limit."
@@ -51,314 +51,327 @@ msgstr ""
 "Keine Dateien ausgewählt: Es wurde --merge angegeben, aber es sind keine "
 "nicht zusammengeführten Dateien in der Dateiauswahl."
 
-#: gitk:418 gitk:566
+#: gitk:424 gitk:572
 msgid "Error executing git log:"
 msgstr "Fehler beim Ausführen von »git log«:"
 
-#: gitk:436 gitk:582
+#: gitk:442 gitk:588
 msgid "Reading"
 msgstr "Lesen"
 
-#: gitk:496 gitk:4525
+#: gitk:502 gitk:4555
 msgid "Reading commits..."
 msgstr "Versionen werden gelesen ..."
 
-#: gitk:499 gitk:1637 gitk:4528
+#: gitk:505 gitk:1647 gitk:4558
 msgid "No commits selected"
 msgstr "Keine Versionen ausgewählt"
 
-#: gitk:1445 gitk:4045 gitk:12432
+#: gitk:1455 gitk:4075 gitk:12752
 msgid "Command line"
 msgstr "Kommandozeile"
 
-#: gitk:1511
+#: gitk:1521
 msgid "Can't parse git log output:"
 msgstr "Ausgabe von »git log« kann nicht erkannt werden:"
 
-#: gitk:1740
+#: gitk:1750
 msgid "No commit information available"
 msgstr "Keine Versionsinformation verfügbar"
 
-#: gitk:1903 gitk:1932 gitk:4315 gitk:9669 gitk:11241 gitk:11521
+#: gitk:1913 gitk:1942 gitk:4345 gitk:9795 gitk:11394 gitk:11683
 msgid "OK"
 msgstr "Ok"
 
-#: gitk:1934 gitk:4317 gitk:9196 gitk:9275 gitk:9391 gitk:9440 gitk:9671
-#: gitk:11242 gitk:11522
+#: gitk:1944 gitk:4347 gitk:9231 gitk:9310 gitk:9440 gitk:9526 gitk:9797
+#: gitk:11395 gitk:11684
 msgid "Cancel"
 msgstr "Abbrechen"
 
-#: gitk:2069
+#: gitk:2093
 msgid "&Update"
 msgstr "&Aktualisieren"
 
-#: gitk:2070
+#: gitk:2094
 msgid "&Reload"
 msgstr "&Neu laden"
 
-#: gitk:2071
+#: gitk:2095
 msgid "Reread re&ferences"
 msgstr "&Zweige neu laden"
 
-#: gitk:2072
+#: gitk:2096
 msgid "&List references"
 msgstr "Zweige/Markierungen auf&listen"
 
-#: gitk:2074
+#: gitk:2098
 msgid "Start git &gui"
 msgstr "»git &gui« starten"
 
-#: gitk:2076
+#: gitk:2100
 msgid "&Quit"
 msgstr "&Beenden"
 
-#: gitk:2068
+#: gitk:2092
 msgid "&File"
 msgstr "&Datei"
 
-#: gitk:2080
+#: gitk:2104
 msgid "&Preferences"
 msgstr "&Einstellungen"
 
-#: gitk:2079
+#: gitk:2103
 msgid "&Edit"
 msgstr "&Bearbeiten"
 
-#: gitk:2084
+#: gitk:2108
 msgid "&New view..."
 msgstr "&Neue Ansicht ..."
 
-#: gitk:2085
+#: gitk:2109
 msgid "&Edit view..."
 msgstr "Ansicht &bearbeiten ..."
 
-#: gitk:2086
+#: gitk:2110
 msgid "&Delete view"
 msgstr "Ansicht &entfernen"
 
-#: gitk:2088 gitk:4043
+#: gitk:2112
 msgid "&All files"
 msgstr "&Alle Dateien"
 
-#: gitk:2083 gitk:4067
+#: gitk:2107
 msgid "&View"
 msgstr "&Ansicht"
 
-#: gitk:2093 gitk:2103 gitk:3012
+#: gitk:2117 gitk:2127
 msgid "&About gitk"
 msgstr "Über &gitk"
 
-#: gitk:2094 gitk:2108
+#: gitk:2118 gitk:2132
 msgid "&Key bindings"
 msgstr "&Tastenkürzel"
 
-#: gitk:2092 gitk:2107
+#: gitk:2116 gitk:2131
 msgid "&Help"
 msgstr "&Hilfe"
 
-#: gitk:2185 gitk:8652
+#: gitk:2209 gitk:8687
 msgid "SHA1 ID:"
 msgstr "SHA1 ID:"
 
-#: gitk:2229
+#: gitk:2253
 msgid "Row"
 msgstr "Zeile"
 
-#: gitk:2267
+#: gitk:2291
 msgid "Find"
 msgstr "Suche"
 
-#: gitk:2295
+#: gitk:2319
 msgid "commit"
 msgstr "Version nach"
 
-#: gitk:2299 gitk:2301 gitk:4687 gitk:4710 gitk:4734 gitk:6755 gitk:6827
-#: gitk:6912
+#: gitk:2323 gitk:2325 gitk:4717 gitk:4740 gitk:4764 gitk:6785 gitk:6857
+#: gitk:6942
 msgid "containing:"
 msgstr "Beschreibung:"
 
-#: gitk:2302 gitk:3526 gitk:3531 gitk:4763
+#: gitk:2326 gitk:3556 gitk:3561 gitk:4793
 msgid "touching paths:"
 msgstr "Dateien:"
 
-#: gitk:2303 gitk:4777
+#: gitk:2327 gitk:4807
 msgid "adding/removing string:"
 msgstr "Änderungen:"
 
-#: gitk:2304 gitk:4779
+#: gitk:2328 gitk:4809
 msgid "changing lines matching:"
 msgstr "Geänderte Zeilen entsprechen:"
 
-#: gitk:2313 gitk:2315 gitk:4766
+#: gitk:2337 gitk:2339 gitk:4796
 msgid "Exact"
 msgstr "Exakt"
 
-#: gitk:2315 gitk:4854 gitk:6723
+#: gitk:2339 gitk:4884 gitk:6753
 msgid "IgnCase"
 msgstr "Kein Groß/Klein"
 
-#: gitk:2315 gitk:4736 gitk:4852 gitk:6719
+#: gitk:2339 gitk:4766 gitk:4882 gitk:6749
 msgid "Regexp"
 msgstr "Regexp"
 
-#: gitk:2317 gitk:2318 gitk:4874 gitk:4904 gitk:4911 gitk:6848 gitk:6916
+#: gitk:2341 gitk:2342 gitk:4904 gitk:4934 gitk:4941 gitk:6878 gitk:6946
 msgid "All fields"
 msgstr "Alle Felder"
 
-#: gitk:2318 gitk:4871 gitk:4904 gitk:6786
+#: gitk:2342 gitk:4901 gitk:4934 gitk:6816
 msgid "Headline"
 msgstr "Überschrift"
 
-#: gitk:2319 gitk:4871 gitk:6786 gitk:6916 gitk:7389
+#: gitk:2343 gitk:4901 gitk:6816 gitk:6946 gitk:7419
 msgid "Comments"
 msgstr "Beschreibung"
 
-#: gitk:2319 gitk:4871 gitk:4876 gitk:4911 gitk:6786 gitk:7324 gitk:8830
-#: gitk:8845
+#: gitk:2343 gitk:4901 gitk:4906 gitk:4941 gitk:6816 gitk:7354 gitk:8865
+#: gitk:8880
 msgid "Author"
 msgstr "Autor"
 
-#: gitk:2319 gitk:4871 gitk:6786 gitk:7326
+#: gitk:2343 gitk:4901 gitk:6816 gitk:7356
 msgid "Committer"
 msgstr "Eintragender"
 
-#: gitk:2350
+#: gitk:2377
 msgid "Search"
 msgstr "Suchen"
 
-#: gitk:2358
+#: gitk:2385
 msgid "Diff"
 msgstr "Vergleich"
 
-#: gitk:2360
+#: gitk:2387
 msgid "Old version"
 msgstr "Alte Version"
 
-#: gitk:2362
+#: gitk:2389
 msgid "New version"
 msgstr "Neue Version"
 
-#: gitk:2364
+#: gitk:2392
 msgid "Lines of context"
 msgstr "Kontextzeilen"
 
-#: gitk:2374
+#: gitk:2402
 msgid "Ignore space change"
 msgstr "Leerzeichenänderungen ignorieren"
 
-#: gitk:2378 gitk:2380 gitk:7959 gitk:8206
+#: gitk:2406 gitk:2408 gitk:7989 gitk:8241
 msgid "Line diff"
 msgstr "Zeilenunterschied"
 
-#: gitk:2445
+#: gitk:2473
 msgid "Patch"
 msgstr "Patch"
 
-#: gitk:2447
+#: gitk:2475
 msgid "Tree"
 msgstr "Baum"
 
-#: gitk:2617 gitk:2637
+#: gitk:2645 gitk:2666
 msgid "Diff this -> selected"
 msgstr "Vergleich: diese -> gewählte"
 
-#: gitk:2618 gitk:2638
+#: gitk:2646 gitk:2667
 msgid "Diff selected -> this"
 msgstr "Vergleich: gewählte -> diese"
 
-#: gitk:2619 gitk:2639
+#: gitk:2647 gitk:2668
 msgid "Make patch"
 msgstr "Patch erstellen"
 
-#: gitk:2620 gitk:9254
+#: gitk:2648 gitk:9289
 msgid "Create tag"
 msgstr "Markierung erstellen"
 
-#: gitk:2621 gitk:9371
+#: gitk:2649
+msgid "Copy commit summary"
+msgstr "Übersicht der Version kopieren"
+
+#: gitk:2650 gitk:9420
 msgid "Write commit to file"
 msgstr "Version in Datei schreiben"
 
-#: gitk:2622 gitk:9428
+#: gitk:2651
 msgid "Create new branch"
 msgstr "Neuen Zweig erstellen"
 
-#: gitk:2623
+#: gitk:2652
 msgid "Cherry-pick this commit"
 msgstr "Diese Version pflücken"
 
-#: gitk:2624
+#: gitk:2653
 msgid "Reset HEAD branch to here"
 msgstr "HEAD-Zweig auf diese Version zurücksetzen"
 
-#: gitk:2625
+#: gitk:2654
 msgid "Mark this commit"
 msgstr "Lesezeichen setzen"
 
-#: gitk:2626
+#: gitk:2655
 msgid "Return to mark"
 msgstr "Zum Lesezeichen"
 
-#: gitk:2627
+#: gitk:2656
 msgid "Find descendant of this and mark"
 msgstr "Abkömmling von Lesezeichen und dieser Version finden"
 
-#: gitk:2628
+#: gitk:2657
 msgid "Compare with marked commit"
 msgstr "Mit Lesezeichen vergleichen"
 
-#: gitk:2629 gitk:2640
+#: gitk:2658 gitk:2669
 msgid "Diff this -> marked commit"
 msgstr "Vergleich: diese -> gewählte Version"
 
-#: gitk:2630 gitk:2641
+#: gitk:2659 gitk:2670
 msgid "Diff marked commit -> this"
 msgstr "Vergleich: gewählte -> diese Version"
 
-#: gitk:2631
+#: gitk:2660
 msgid "Revert this commit"
 msgstr "Version umkehren"
 
-#: gitk:2647
+#: gitk:2676
 msgid "Check out this branch"
 msgstr "Auf diesen Zweig umstellen"
 
-#: gitk:2648
+#: gitk:2677
+msgid "Rename this branch"
+msgstr "Zweig umbenennen"
+
+#: gitk:2678
 msgid "Remove this branch"
 msgstr "Zweig löschen"
 
-#: gitk:2649
+#: gitk:2679
 msgid "Copy branch name"
 msgstr "Zweigname kopieren"
 
-#: gitk:2656
+#: gitk:2686
 msgid "Highlight this too"
 msgstr "Diesen auch hervorheben"
 
-#: gitk:2657
+#: gitk:2687
 msgid "Highlight this only"
 msgstr "Nur diesen hervorheben"
 
-#: gitk:2658
+#: gitk:2688
 msgid "External diff"
 msgstr "Externes Diff-Programm"
 
-#: gitk:2659
+#: gitk:2689
 msgid "Blame parent commit"
 msgstr "Annotieren der Elternversion"
 
-#: gitk:2660
+#: gitk:2690
 msgid "Copy path"
 msgstr "Pfad kopieren"
 
-#: gitk:2667
+#: gitk:2697
 msgid "Show origin of this line"
 msgstr "Herkunft dieser Zeile anzeigen"
 
-#: gitk:2668
+#: gitk:2698
 msgid "Run git gui blame on this line"
 msgstr "Diese Zeile annotieren (»git gui blame«)"
 
-#: gitk:3014
+#: gitk:3042
+#, fuzzy
+msgid "About gitk"
+msgstr "Über &gitk"
+
+#: gitk:3044
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -370,522 +383,532 @@ msgstr ""
 "\n"
 "Gitk - eine Visualisierung der Git-Historie\n"
 "\n"
-"Copyright \\u00a9 2005-2016 Paul Mackerras\n"
+"Copyright © 2005-2016 Paul Mackerras\n"
 "\n"
 "Benutzung und Weiterverbreitung gemäß den Bedingungen der GNU General Public "
 "License"
 
-#: gitk:3022 gitk:3089 gitk:9857
+#: gitk:3052 gitk:3119 gitk:10010
 msgid "Close"
 msgstr "Schließen"
 
-#: gitk:3043
+#: gitk:3073
 msgid "Gitk key bindings"
 msgstr "Gitk-Tastaturbelegung"
 
-#: gitk:3046
+#: gitk:3076
 msgid "Gitk key bindings:"
 msgstr "Gitk-Tastaturbelegung:"
 
-#: gitk:3048
+#: gitk:3078
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tBeenden"
 
-#: gitk:3049
+#: gitk:3079
 #, tcl-format
 msgid "<%s-W>\t\tClose window"
 msgstr "<%s-F>\t\tFenster schließen"
 
-#: gitk:3050
+#: gitk:3080
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Pos1>\t\tZur neuesten Version springen"
 
-#: gitk:3051
+#: gitk:3081
 msgid "<End>\t\tMove to last commit"
 msgstr "<Ende>\t\tZur ältesten Version springen"
 
-#: gitk:3052
+#: gitk:3082
 msgid "<Up>, p, k\tMove up one commit"
 msgstr "<Hoch>, p, k\tNächste neuere Version"
 
-#: gitk:3053
+#: gitk:3083
 msgid "<Down>, n, j\tMove down one commit"
 msgstr "<Runter>, n, j\tNächste ältere Version"
 
-#: gitk:3054
+#: gitk:3084
 msgid "<Left>, z, h\tGo back in history list"
 msgstr "<Links>, z, h\tEine Version zurückgehen"
 
-#: gitk:3055
+#: gitk:3085
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Rechts>, x, l\tEine Version weitergehen"
 
-#: gitk:3056
+#: gitk:3086
 #, tcl-format
 msgid "<%s-n>\tGo to n-th parent of current commit in history list"
 msgstr "<%s-n>\tZu n-ter Elternversion in Versionshistorie springen"
 
-#: gitk:3057
+#: gitk:3087
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<BildHoch>\tEine Seite nach oben blättern"
 
-#: gitk:3058
+#: gitk:3088
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<BildRunter>\tEine Seite nach unten blättern"
 
-#: gitk:3059
+#: gitk:3089
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Pos1>\tZum oberen Ende der Versionsliste blättern"
 
-#: gitk:3060
+#: gitk:3090
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-Ende>\tZum unteren Ende der Versionsliste blättern"
 
-#: gitk:3061
+#: gitk:3091
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Hoch>\tVersionsliste eine Zeile nach oben blättern"
 
-#: gitk:3062
+#: gitk:3092
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Runter>\tVersionsliste eine Zeile nach unten blättern"
 
-#: gitk:3063
+#: gitk:3093
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-BildHoch>\tVersionsliste eine Seite nach oben blättern"
 
-#: gitk:3064
+#: gitk:3094
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-BildRunter>\tVersionsliste eine Seite nach unten blättern"
 
-#: gitk:3065
+#: gitk:3095
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Umschalt-Hoch>\tRückwärts suchen (nach oben; neuere Versionen)"
 
-#: gitk:3066
+#: gitk:3096
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr "<Umschalt-Runter> Suchen (nach unten; ältere Versionen)"
 
-#: gitk:3067
+#: gitk:3097
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Entf>, b\t\tVergleich eine Seite nach oben blättern"
 
-#: gitk:3068
+#: gitk:3098
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<Löschtaste>\tVergleich eine Seite nach oben blättern"
 
-#: gitk:3069
+#: gitk:3099
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Leertaste>\tVergleich eine Seite nach unten blättern"
 
-#: gitk:3070
+#: gitk:3100
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\tVergleich um 18 Zeilen nach oben blättern"
 
-#: gitk:3071
+#: gitk:3101
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\tVergleich um 18 Zeilen nach unten blättern"
 
-#: gitk:3072
+#: gitk:3102
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tSuchen"
 
-#: gitk:3073
+#: gitk:3103
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tWeitersuchen"
 
-#: gitk:3074
+#: gitk:3104
 msgid "<Return>\tMove to next find hit"
 msgstr "<Eingabetaste>\tWeitersuchen"
 
-#: gitk:3075
+#: gitk:3105
 msgid "g\t\tGo to commit"
 msgstr "g\t\tZu Version springen"
 
-#: gitk:3076
+#: gitk:3106
 msgid "/\t\tFocus the search box"
 msgstr "/\t\tTastaturfokus ins Suchfeld"
 
-#: gitk:3077
+#: gitk:3107
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tRückwärts weitersuchen"
 
-#: gitk:3078
+#: gitk:3108
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tVergleich zur nächsten Datei blättern"
 
-#: gitk:3079
+#: gitk:3109
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tWeitersuchen im Vergleich"
 
-#: gitk:3080
+#: gitk:3110
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tRückwärts weitersuchen im Vergleich"
 
-#: gitk:3081
+#: gitk:3111
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-Nummerblock-Plus>\tSchrift vergrößern"
 
-#: gitk:3082
+#: gitk:3112
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-Plus>\tSchrift vergrößern"
 
-#: gitk:3083
+#: gitk:3113
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-Nummernblock-Minus> Schrift verkleinern"
 
-#: gitk:3084
+#: gitk:3114
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-Minus>\tSchrift verkleinern"
 
-#: gitk:3085
+#: gitk:3115
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
+#: gitk:4439 gitk:4492 gitk:4954 gitk:4968 gitk:6238 gitk:12693 gitk:12694
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
+#: gitk:7164
 msgid "and many more"
 msgstr "und weitere"
 
-#: gitk:7137
+#: gitk:7167
 msgid "many"
 msgstr "viele"
 
-#: gitk:7328
+#: gitk:7358
 msgid "Tags:"
 msgstr "Markierungen:"
 
-#: gitk:7345 gitk:7351 gitk:8825
+#: gitk:7375 gitk:7381 gitk:8860
 msgid "Parent"
 msgstr "Eltern"
 
-#: gitk:7356
+#: gitk:7386
 msgid "Child"
 msgstr "Kind"
 
-#: gitk:7365
+#: gitk:7395
 msgid "Branch"
 msgstr "Zweig"
 
-#: gitk:7368
+#: gitk:7398
 msgid "Follows"
 msgstr "Folgt auf"
 
-#: gitk:7371
+#: gitk:7401
 msgid "Precedes"
 msgstr "Vorgänger von"
 
-#: gitk:7966
+#: gitk:7996
 #, tcl-format
 msgid "Error getting diffs: %s"
 msgstr "Fehler beim Laden des Vergleichs: %s"
 
-#: gitk:8650
+#: gitk:8685
 msgid "Goto:"
 msgstr "Gehe zu:"
 
-#: gitk:8671
+#: gitk:8706
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "Kurzer SHA1-Hashwert »%s« ist mehrdeutig"
 
-#: gitk:8678
+#: gitk:8713
 #, tcl-format
 msgid "Revision %s is not known"
 msgstr "Version »%s« ist unbekannt"
 
-#: gitk:8688
+#: gitk:8723
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "SHA1-Hashwert »%s« ist unbekannt"
 
-#: gitk:8690
+#: gitk:8725
 #, tcl-format
 msgid "Revision %s is not in the current view"
 msgstr "Version »%s« wird in der aktuellen Ansicht nicht angezeigt"
 
-#: gitk:8832 gitk:8847
+#: gitk:8867 gitk:8882
 msgid "Date"
 msgstr "Datum"
 
-#: gitk:8835
+#: gitk:8870
 msgid "Children"
 msgstr "Kinder"
 
-#: gitk:8898
+#: gitk:8933
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Zweig »%s« hierher zurücksetzen"
 
-#: gitk:8900
+#: gitk:8935
 msgid "Detached head: can't reset"
 msgstr "Zweigspitze ist abgetrennt: Zurücksetzen nicht möglich"
 
-#: gitk:9005 gitk:9011
+#: gitk:9040 gitk:9046
 msgid "Skipping merge commit "
 msgstr "Überspringe Zusammenführungs-Version "
 
-#: gitk:9020 gitk:9025
+#: gitk:9055 gitk:9060
 msgid "Error getting patch ID for "
 msgstr "Fehler beim Holen der Patch-ID für "
 
-#: gitk:9021 gitk:9026
+#: gitk:9056 gitk:9061
 msgid " - stopping\n"
 msgstr " - Abbruch.\n"
 
-#: gitk:9031 gitk:9034 gitk:9042 gitk:9056 gitk:9065
+#: gitk:9066 gitk:9069 gitk:9077 gitk:9091 gitk:9100
 msgid "Commit "
 msgstr "Version "
 
-#: gitk:9035
+#: gitk:9070
 msgid ""
 " is the same patch as\n"
 "       "
@@ -893,7 +916,7 @@ msgstr ""
 " ist das gleiche Patch wie\n"
 "       "
 
-#: gitk:9043
+#: gitk:9078
 msgid ""
 " differs from\n"
 "       "
@@ -901,7 +924,7 @@ msgstr ""
 " ist unterschiedlich von\n"
 "       "
 
-#: gitk:9045
+#: gitk:9080
 msgid ""
 "Diff of commits:\n"
 "\n"
@@ -909,131 +932,150 @@ msgstr ""
 "Vergleich der Versionen:\n"
 "\n"
 
-#: gitk:9057 gitk:9066
+#: gitk:9092 gitk:9101
 #, tcl-format
 msgid " has %s children - stopping\n"
 msgstr " hat %s Kinder. Abbruch\n"
 
-#: gitk:9085
+#: gitk:9120
 #, tcl-format
 msgid "Error writing commit to file: %s"
 msgstr "Fehler beim Schreiben der Version in Datei: %s"
 
-#: gitk:9091
+#: gitk:9126
 #, tcl-format
 msgid "Error diffing commits: %s"
 msgstr "Fehler beim Vergleichen der Versionen: %s"
 
-#: gitk:9137
+#: gitk:9172
 msgid "Top"
 msgstr "Oben"
 
-#: gitk:9138
+#: gitk:9173
 msgid "From"
 msgstr "Von"
 
-#: gitk:9143
+#: gitk:9178
 msgid "To"
 msgstr "bis"
 
-#: gitk:9167
+#: gitk:9202
 msgid "Generate patch"
 msgstr "Patch erstellen"
 
-#: gitk:9169
+#: gitk:9204
 msgid "From:"
 msgstr "Von:"
 
-#: gitk:9178
+#: gitk:9213
 msgid "To:"
 msgstr "bis:"
 
-#: gitk:9187
+#: gitk:9222
 msgid "Reverse"
 msgstr "Umgekehrt"
 
-#: gitk:9189 gitk:9385
+#: gitk:9224 gitk:9434
 msgid "Output file:"
 msgstr "Ausgabedatei:"
 
-#: gitk:9195
+#: gitk:9230
 msgid "Generate"
 msgstr "Erzeugen"
 
-#: gitk:9233
+#: gitk:9268
 msgid "Error creating patch:"
 msgstr "Fehler beim Erzeugen des Patches:"
 
-#: gitk:9256 gitk:9373 gitk:9430
+#: gitk:9291 gitk:9422 gitk:9510
 msgid "ID:"
 msgstr "ID:"
 
-#: gitk:9265
+#: gitk:9300
 msgid "Tag name:"
 msgstr "Markierungsname:"
 
-#: gitk:9268
+#: gitk:9303
 msgid "Tag message is optional"
 msgstr "Eine Markierungsbeschreibung ist optional"
 
-#: gitk:9270
+#: gitk:9305
 msgid "Tag message:"
 msgstr "Markierungsbeschreibung:"
 
-#: gitk:9274 gitk:9439
+#: gitk:9309 gitk:9480
 msgid "Create"
 msgstr "Erstellen"
 
-#: gitk:9292
+#: gitk:9327
 msgid "No tag name specified"
 msgstr "Kein Markierungsname angegeben"
 
-#: gitk:9296
+#: gitk:9331
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Markierung »%s« existiert bereits."
 
-#: gitk:9306
+#: gitk:9341
 msgid "Error creating tag:"
 msgstr "Fehler beim Erstellen der Markierung:"
 
-#: gitk:9382
+#: gitk:9431
 msgid "Command:"
 msgstr "Kommando:"
 
-#: gitk:9390
+#: gitk:9439
 msgid "Write"
 msgstr "Schreiben"
 
-#: gitk:9408
+#: gitk:9457
 msgid "Error writing commit:"
 msgstr "Fehler beim Schreiben der Version:"
 
-#: gitk:9435
+#: gitk:9479
+#, fuzzy
+msgid "Create branch"
+msgstr "Neuen Zweig erstellen"
+
+#: gitk:9495
+#, tcl-format
+msgid "Rename branch %s"
+msgstr "Zweig »%s« umbenennen?"
+
+#: gitk:9496
+msgid "Rename"
+msgstr "Umbenennen"
+
+#: gitk:9520
 msgid "Name:"
 msgstr "Name:"
 
-#: gitk:9458
+#: gitk:9544
 msgid "Please specify a name for the new branch"
 msgstr "Bitte geben Sie einen Namen für den neuen Zweig an."
 
-#: gitk:9463
+#: gitk:9549
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
 msgstr "Zweig »%s« existiert bereits. Soll er überschrieben werden?"
 
-#: gitk:9530
+#: gitk:9593
+#, fuzzy
+msgid "Please specify a new name for the branch"
+msgstr "Bitte geben Sie einen Namen für den neuen Zweig an."
+
+#: gitk:9656
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
 msgstr ""
 "Version »%s« ist bereits im Zweig »%s« enthalten -- trotzdem erneut "
 "eintragen?"
 
-#: gitk:9535
+#: gitk:9661
 msgid "Cherry-picking"
 msgstr "Version pflücken"
 
-#: gitk:9544
+#: gitk:9670
 #, tcl-format
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
@@ -1043,7 +1085,7 @@ msgstr ""
 "vorliegen. Bitte diese Änderungen eintragen, zurücksetzen oder\n"
 "zwischenspeichern (»git stash«) und dann erneut versuchen."
 
-#: gitk:9550
+#: gitk:9676
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
@@ -1052,21 +1094,20 @@ msgstr ""
 "ist. Soll das Zusammenführungs-Werkzeug (»git citool«) aufgerufen\n"
 "werden, um diesen Konflikt aufzulösen?"
 
-#: gitk:9566 gitk:9624
+#: gitk:9692 gitk:9750
 msgid "No changes committed"
 msgstr "Keine Änderungen eingetragen"
 
-#: gitk:9593
+#: gitk:9719
 #, tcl-format
 msgid "Commit %s is not included in branch %s -- really revert it?"
-msgstr ""
-"Version »%s« ist nicht im Zweig »%s« enthalten -- trotzdem umkehren?"
+msgstr "Version »%s« ist nicht im Zweig »%s« enthalten -- trotzdem umkehren?"
 
-#: gitk:9598
+#: gitk:9724
 msgid "Reverting"
 msgstr "Umkehren"
 
-#: gitk:9606
+#: gitk:9732
 #, tcl-format
 msgid ""
 "Revert failed because of local changes to the following files:%s Please "
@@ -1076,7 +1117,7 @@ msgstr ""
 "vorliegen. Bitte diese Änderungen eintragen, zurücksetzen oder\n"
 "zwischenspeichern (»git stash«) und dann erneut versuchen."
 
-#: gitk:9610
+#: gitk:9736
 msgid ""
 "Revert failed because of merge conflict.\n"
 " Do you wish to run git citool to resolve it?"
@@ -1085,30 +1126,30 @@ msgstr ""
 "ist. Soll das Zusammenführungs-Werkzeug (»git citool«) aufgerufen\n"
 "werden, um diesen Konflikt aufzulösen?"
 
-#: gitk:9653
+#: gitk:9779
 msgid "Confirm reset"
 msgstr "Zurücksetzen bestätigen"
 
-#: gitk:9655
+#: gitk:9781
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "Zweig »%s« auf »%s« zurücksetzen?"
 
-#: gitk:9657
+#: gitk:9783
 msgid "Reset type:"
 msgstr "Art des Zurücksetzens:"
 
-#: gitk:9660
+#: gitk:9786
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Harmlos: Arbeitskopie und Bereitstellung unverändert"
 
-#: gitk:9663
+#: gitk:9789
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr ""
 "Gemischt: Arbeitskopie unverändert,\n"
 "Bereitstellung zurückgesetzt"
 
-#: gitk:9666
+#: gitk:9792
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -1116,21 +1157,26 @@ msgstr ""
 "Hart: Arbeitskopie und Bereitstellung\n"
 "(Alle lokalen Änderungen werden gelöscht)"
 
-#: gitk:9683
+#: gitk:9809
 msgid "Resetting"
 msgstr "Zurücksetzen"
 
-#: gitk:9743
+#: gitk:9882
+#, tcl-format
+msgid "A local branch named %s exists already"
+msgstr ""
+
+#: gitk:9890
 msgid "Checking out"
 msgstr "Umstellen"
 
-#: gitk:9796
+#: gitk:9949
 msgid "Cannot delete the currently checked-out branch"
 msgstr ""
 "Der Zweig, auf den die Arbeitskopie momentan umgestellt ist, kann nicht "
 "gelöscht werden."
 
-#: gitk:9802
+#: gitk:9955
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -1139,16 +1185,16 @@ msgstr ""
 "Die Versionen auf Zweig »%s« existieren auf keinem anderen Zweig.\n"
 "Zweig »%s« trotzdem löschen?"
 
-#: gitk:9833
+#: gitk:9986
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Markierungen und Zweige: %s"
 
-#: gitk:9850
+#: gitk:10003
 msgid "Filter"
 msgstr "Filtern"
 
-#: gitk:10146
+#: gitk:10299
 msgid ""
 "Error reading commit topology information; branch and preceding/following "
 "tag information will be incomplete."
@@ -1156,218 +1202,223 @@ msgstr ""
 "Fehler beim Lesen der Strukturinformationen; Zweige und Informationen zu "
 "Vorgänger/Nachfolger werden unvollständig sein."
 
-#: gitk:11123
+#: gitk:11276
 msgid "Tag"
 msgstr "Markierung"
 
-#: gitk:11127
+#: gitk:11280
 msgid "Id"
 msgstr "Id"
 
-#: gitk:11210
+#: gitk:11363
 msgid "Gitk font chooser"
 msgstr "Gitk-Schriften wählen"
 
-#: gitk:11227
+#: gitk:11380
 msgid "B"
 msgstr "F"
 
-#: gitk:11230
+#: gitk:11383
 msgid "I"
 msgstr "K"
 
-#: gitk:11348
+#: gitk:11502
 msgid "Commit list display options"
 msgstr "Anzeige der Versionsliste"
 
-#: gitk:11351
+#: gitk:11505
 msgid "Maximum graph width (lines)"
 msgstr "Maximale Graphenbreite (Zeilen)"
 
-#: gitk:11355
+#: gitk:11509
 #, no-tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Maximale Graphenbreite (% des Fensters)"
 
-#: gitk:11358
+#: gitk:11512
 msgid "Show local changes"
 msgstr "Lokale Änderungen anzeigen"
 
-#: gitk:11361
+#: gitk:11516
 msgid "Auto-select SHA1 (length)"
 msgstr "SHA1-Hashwert (Länge) automatisch auswählen"
 
-#: gitk:11365
+#: gitk:11521
 msgid "Hide remote refs"
 msgstr "Entfernte Zweige/Markierungen ausblenden"
 
-#: gitk:11369
+#: gitk:11525
+msgid "Auto-update upon change (ms)"
+msgstr "Automatisches Neuladen bei Änderung (ms)"
+
+#: gitk:11531
 msgid "Diff display options"
 msgstr "Anzeige des Vergleichs"
 
-#: gitk:11371
+#: gitk:11533
 msgid "Tab spacing"
 msgstr "Tabulatorbreite"
 
-#: gitk:11374
+#: gitk:11536
 msgid "Display nearby tags/heads"
 msgstr "Naheliegende Markierungen/Zweigspitzen anzeigen"
 
-#: gitk:11377
+#: gitk:11539
 msgid "Maximum # tags/heads to show"
 msgstr "Maximale Anzahl anzuzeigender Markierungen/Zweigspitzen"
 
-#: gitk:11380
+#: gitk:11542
 msgid "Limit diffs to listed paths"
 msgstr "Vergleich nur für angezeigte Pfade"
 
-#: gitk:11383
+#: gitk:11545
 msgid "Support per-file encodings"
 msgstr "Zeichenkodierung pro Datei ermitteln"
 
-#: gitk:11389 gitk:11536
+#: gitk:11551 gitk:11698
 msgid "External diff tool"
 msgstr "Externes Diff-Programm"
 
-#: gitk:11390
+#: gitk:11552
 msgid "Choose..."
 msgstr "Wählen ..."
 
-#: gitk:11395
+#: gitk:11557
 msgid "General options"
 msgstr "Allgemeine Optionen"
 
-#: gitk:11398
+#: gitk:11560
 msgid "Use themed widgets"
 msgstr "Aussehen der Benutzeroberfläche durch Thema bestimmen"
 
-#: gitk:11400
+#: gitk:11562
 msgid "(change requires restart)"
 msgstr "(Änderungen werden erst nach Neustart wirksam)"
 
-#: gitk:11402
+#: gitk:11564
 msgid "(currently unavailable)"
 msgstr "(Momentan nicht verfügbar)"
 
-#: gitk:11413
+#: gitk:11575
 msgid "Colors: press to choose"
 msgstr "Farben: Klicken zum Wählen"
 
-#: gitk:11416
+#: gitk:11578
 msgid "Interface"
 msgstr "Benutzeroberfläche"
 
-#: gitk:11417
+#: gitk:11579
 msgid "interface"
 msgstr "Benutzeroberfläche"
 
-#: gitk:11420
+#: gitk:11582
 msgid "Background"
 msgstr "Hintergrund"
 
-#: gitk:11421 gitk:11451
+#: gitk:11583 gitk:11613
 msgid "background"
 msgstr "Hintergrund"
 
-#: gitk:11424
+#: gitk:11586
 msgid "Foreground"
 msgstr "Vordergrund"
 
-#: gitk:11425
+#: gitk:11587
 msgid "foreground"
 msgstr "Vordergrund"
 
-#: gitk:11428
+#: gitk:11590
 msgid "Diff: old lines"
 msgstr "Vergleich: Alte Zeilen"
 
-#: gitk:11429
+#: gitk:11591
 msgid "diff old lines"
 msgstr "Vergleich - Alte Zeilen"
 
-#: gitk:11433
+#: gitk:11595
 msgid "Diff: new lines"
 msgstr "Vergleich: Neue Zeilen"
 
-#: gitk:11434
+#: gitk:11596
 msgid "diff new lines"
 msgstr "Vergleich - Neue Zeilen"
 
-#: gitk:11438
+#: gitk:11600
 msgid "Diff: hunk header"
 msgstr "Vergleich: Änderungstitel"
 
-#: gitk:11440
+#: gitk:11602
 msgid "diff hunk header"
 msgstr "Vergleich - Änderungstitel"
 
-#: gitk:11444
+#: gitk:11606
 msgid "Marked line bg"
 msgstr "Hintergrund für markierte Zeile"
 
-#: gitk:11446
+#: gitk:11608
 msgid "marked line background"
 msgstr "Hintergrund für markierte Zeile"
 
-#: gitk:11450
+#: gitk:11612
 msgid "Select bg"
 msgstr "Hintergrundfarbe auswählen"
 
-#: gitk:11459
+#: gitk:11621
 msgid "Fonts: press to choose"
 msgstr "Schriftart: Klicken zum Wählen"
 
-#: gitk:11461
+#: gitk:11623
 msgid "Main font"
 msgstr "Programmschriftart"
 
-#: gitk:11462
+#: gitk:11624
 msgid "Diff display font"
 msgstr "Schriftart für Vergleich"
 
-#: gitk:11463
+#: gitk:11625
 msgid "User interface font"
 msgstr "Beschriftungen"
 
-#: gitk:11485
+#: gitk:11647
 msgid "Gitk preferences"
 msgstr "Gitk-Einstellungen"
 
-#: gitk:11494
+#: gitk:11656
 msgid "General"
 msgstr "Allgemein"
 
-#: gitk:11495
+#: gitk:11657
 msgid "Colors"
 msgstr "Farben"
 
-#: gitk:11496
+#: gitk:11658
 msgid "Fonts"
 msgstr "Schriftarten"
 
-#: gitk:11546
+#: gitk:11708
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: Farbe wählen für %s"
 
-#: gitk:12059
+#: gitk:12224
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
 msgstr ""
-"Entschuldigung, gitk kann nicht mit dieser Tcl/Tk Version ausgeführt werden.\n"
+"Entschuldigung, gitk kann nicht mit dieser Tcl/Tk Version ausgeführt "
+"werden.\n"
 " Gitk erfordert mindestens Tcl/Tk 8.4."
 
-#: gitk:12269
+#: gitk:12442
 msgid "Cannot find a git repository here."
 msgstr "Kein Git-Projektarchiv gefunden."
 
-#: gitk:12316
+#: gitk:12489
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Mehrdeutige Angabe »%s«: Sowohl Version als auch Dateiname existiert."
 
-#: gitk:12328
+#: gitk:12501
 msgid "Bad arguments to gitk:"
 msgstr "Falsche Kommandozeilen-Parameter für gitk:"
 
-- 
2.9.3


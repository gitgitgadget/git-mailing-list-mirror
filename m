Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B24C352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 21:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AC420838
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 21:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJV6l convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 10 Feb 2020 16:58:41 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.205.38]:39118 "EHLO
        smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJV6l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 16:58:41 -0500
Received: from mail.tu-harburg.de (mail4.rz.tu-harburg.de [134.28.202.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.tuhh.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by smtp1.rz.tu-harburg.de (Postfix) with ESMTPS id 48GftM3PnczxRS;
        Mon, 10 Feb 2020 22:58:35 +0100 (CET)
Received: from mailspring.rz.tuhh.de (mailspring.rz.tuhh.de [134.28.202.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alucst@KERBEROS.TU-HARBURG.DE)
        by mail.tu-harburg.de (Postfix) with ESMTPSA id 48GftM28dJzJpRP;
        Mon, 10 Feb 2020 22:58:35 +0100 (CET)
From:   Christian Stimming <christian@cstimming.de>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Git List <git@vger.kernel.org>
Subject: [PATCH 2/2] gitk: update German translation
Date:   Mon, 10 Feb 2020 22:58:34 +0100
Message-ID: <5991383.UWvF6XjTAM@ckiste>
In-Reply-To: <2527491.s4PuAgMcOf@ckiste>
References: <2527491.s4PuAgMcOf@ckiste>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adapt to recent wording changes in git-gui, so that both tools use the
common glossary. Notably, switch several terms from uncommon
translations back to English vocabulary.

This most prominently concerns "commit" (noun, verb), "repository",
"branch", and some more. These uncommon translations have been introduced
long ago and never been changed since. However, in German literature
and magazines, gitk and git-gui is regularly noted for its uncommon
choice of translated vocabulary. This somewhat distracts from the actual
benefits of this tool. So it is probably better to abandon the uncommon
translations and rather stick to the common English vocabulary in git
version control.

Signed-off-by: Christian Stimming <christian@cstimming.de>
---
 po/de.po | 312 +++++++++++++++++++++++++------------------------------
 1 file changed, 139 insertions(+), 173 deletions(-)

diff --git a/po/de.po b/po/de.po
index b30dfb0..f87710f 100644
--- a/po/de.po
+++ b/po/de.po
@@ -9,10 +9,10 @@ msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2020-01-24 23:48+0100\n"
-"PO-Revision-Date: 2015-10-20 14:20+0200\n"
-"Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
+"PO-Revision-Date: 2020-02-10 22:48+0100\n"
+"Last-Translator: Christian Stimming <christian@cstimming.de>\n"
 "Language-Team: German\n"
-"Language: \n"
+"Language: de_DE\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
@@ -31,7 +31,7 @@ msgstr "Wörter kennzeichnen"
 
 #: gitk:324
 msgid "Error parsing revisions:"
-msgstr "Fehler beim Laden der Versionen:"
+msgstr "Fehler beim Laden der Commits:"
 
 #: gitk:380
 msgid "Error executing --argscmd command:"
@@ -61,11 +61,11 @@ msgstr "Lesen"
 
 #: gitk:496 gitk:4555
 msgid "Reading commits..."
-msgstr "Versionen werden gelesen ..."
+msgstr "Commits werden gelesen ..."
 
 #: gitk:499 gitk:1641 gitk:4558
 msgid "No commits selected"
-msgstr "Keine Versionen ausgewählt"
+msgstr "Keine Commits ausgewählt"
 
 #: gitk:1449 gitk:4075 gitk:12643
 msgid "Command line"
@@ -77,7 +77,7 @@ msgstr "Ausgabe von »git log« kann nicht erkannt werden:"
 
 #: gitk:1744
 msgid "No commit information available"
-msgstr "Keine Versionsinformation verfügbar"
+msgstr "Keine Commit-Information verfügbar"
 
 #: gitk:1911 gitk:1940 gitk:4345 gitk:9830 gitk:11434 gitk:11721
 msgid "OK"
@@ -98,11 +98,11 @@ msgstr "&Neu laden"
 
 #: gitk:2093
 msgid "Reread re&ferences"
-msgstr "&Zweige neu laden"
+msgstr "&Branches neu laden"
 
 #: gitk:2094
 msgid "&List references"
-msgstr "Zweige/Markierungen auf&listen"
+msgstr "Branches/Tags auf&listen"
 
 #: gitk:2096
 msgid "Start git &gui"
@@ -170,7 +170,7 @@ msgstr "Suche"
 
 #: gitk:2317
 msgid "commit"
-msgstr "Version nach"
+msgstr "Commit nach"
 
 #: gitk:2321 gitk:2323 gitk:4717 gitk:4740 gitk:4764 gitk:6785 gitk:6857
 #: gitk:6942
@@ -220,7 +220,7 @@ msgstr "Autor"
 
 #: gitk:2341 gitk:4901 gitk:6816 gitk:7391
 msgid "Committer"
-msgstr "Eintragender"
+msgstr "Committer"
 
 #: gitk:2375
 msgid "Search"
@@ -260,11 +260,11 @@ msgstr "Baum"
 
 #: gitk:2643 gitk:2664
 msgid "Diff this -> selected"
-msgstr "Vergleich: diese -> gewählte"
+msgstr "Vergleich: dieser -> gewählter"
 
 #: gitk:2644 gitk:2665
 msgid "Diff selected -> this"
-msgstr "Vergleich: gewählte -> diese"
+msgstr "Vergleich: gewählter -> dieser"
 
 #: gitk:2645 gitk:2666
 msgid "Make patch"
@@ -272,28 +272,27 @@ msgstr "Patch erstellen"
 
 #: gitk:2646 gitk:9324
 msgid "Create tag"
-msgstr "Markierung erstellen"
+msgstr "Tag erstellen"
 
 #: gitk:2647
-#, fuzzy
 msgid "Copy commit reference"
-msgstr "Keine Versionen ausgewählt"
+msgstr "Commit-Bezeichnung kopieren"
 
 #: gitk:2648 gitk:9455
 msgid "Write commit to file"
-msgstr "Version in Datei schreiben"
+msgstr "Commit in Datei schreiben"
 
 #: gitk:2649
 msgid "Create new branch"
-msgstr "Neuen Zweig erstellen"
+msgstr "Neuen Branch erstellen"
 
 #: gitk:2650
 msgid "Cherry-pick this commit"
-msgstr "Diese Version pflücken"
+msgstr "Diesen Commit pflücken (»cherry-pick«)"
 
 #: gitk:2651
 msgid "Reset HEAD branch to here"
-msgstr "HEAD-Zweig auf diese Version zurücksetzen"
+msgstr "Branch-HEAD auf diesen Commit umsetzen"
 
 #: gitk:2652
 msgid "Mark this commit"
@@ -305,7 +304,7 @@ msgstr "Zum Lesezeichen"
 
 #: gitk:2654
 msgid "Find descendant of this and mark"
-msgstr "Abkömmling von Lesezeichen und dieser Version finden"
+msgstr "Nachfolge-Commit von Lesezeichen und diesem finden"
 
 #: gitk:2655
 msgid "Compare with marked commit"
@@ -313,32 +312,31 @@ msgstr "Mit Lesezeichen vergleichen"
 
 #: gitk:2656 gitk:2667
 msgid "Diff this -> marked commit"
-msgstr "Vergleich: diese -> gewählte Version"
+msgstr "Vergleich: dieser Commit -> Lesezeichen"
 
 #: gitk:2657 gitk:2668
 msgid "Diff marked commit -> this"
-msgstr "Vergleich: gewählte -> diese Version"
+msgstr "Vergleich: Lesezeichen -> dieser Commit"
 
 #: gitk:2658
 msgid "Revert this commit"
-msgstr "Version umkehren"
+msgstr "Commit zurücknehmen (»revert«)"
 
 #: gitk:2674
 msgid "Check out this branch"
-msgstr "Auf diesen Zweig umstellen"
+msgstr "Branch auschecken"
 
 #: gitk:2675
-#, fuzzy
 msgid "Rename this branch"
-msgstr "Zweig löschen"
+msgstr "Branch umbenennen"
 
 #: gitk:2676
 msgid "Remove this branch"
-msgstr "Zweig löschen"
+msgstr "Branch löschen"
 
 #: gitk:2677
 msgid "Copy branch name"
-msgstr "Zweigname kopieren"
+msgstr "Branch-Name kopieren"
 
 #: gitk:2684
 msgid "Highlight this too"
@@ -369,9 +367,8 @@ msgid "Run git gui blame on this line"
 msgstr "Diese Zeile annotieren (»git gui blame«)"
 
 #: gitk:3040
-#, fuzzy
 msgid "About gitk"
-msgstr "Über &gitk"
+msgstr "Über gitk"
 
 #: gitk:3042
 msgid ""
@@ -385,10 +382,9 @@ msgstr ""
 "\n"
 "Gitk - eine Visualisierung der Git-Historie\n"
 "\n"
-"Copyright \\u00a9 2005-2016 Paul Mackerras\n"
+"Copyright © 2005-2016 Paul Mackerras\n"
 "\n"
-"Benutzung und Weiterverbreitung gemäß den Bedingungen der GNU General Public "
-"License"
+"Benutzung und Weiterverbreitung gemäß den Bedingungen der GNU General Public License"
 
 #: gitk:3050 gitk:3117 gitk:10045
 msgid "Close"
@@ -414,32 +410,32 @@ msgstr "<%s-F>\t\tFenster schließen"
 
 #: gitk:3078
 msgid "<Home>\t\tMove to first commit"
-msgstr "<Pos1>\t\tZur neuesten Version springen"
+msgstr "<Pos1>\t\tZum neuesten Commit springen"
 
 #: gitk:3079
 msgid "<End>\t\tMove to last commit"
-msgstr "<Ende>\t\tZur ältesten Version springen"
+msgstr "<Ende>\t\tZum ältesten Commit springen"
 
 #: gitk:3080
 msgid "<Up>, p, k\tMove up one commit"
-msgstr "<Hoch>, p, k\tNächste neuere Version"
+msgstr "<Hoch>, p, k\tEinen Commit nach oben"
 
 #: gitk:3081
 msgid "<Down>, n, j\tMove down one commit"
-msgstr "<Runter>, n, j\tNächste ältere Version"
+msgstr "<Runter>, n, j\tEinen Commit nach unten"
 
 #: gitk:3082
 msgid "<Left>, z, h\tGo back in history list"
-msgstr "<Links>, z, h\tEine Version zurückgehen"
+msgstr "<Links>, z, h\tEinen Commit zurückgehen"
 
 #: gitk:3083
 msgid "<Right>, x, l\tGo forward in history list"
-msgstr "<Rechts>, x, l\tEine Version weitergehen"
+msgstr "<Rechts>, x, l\tEinen Commit weitergehen"
 
 #: gitk:3084
 #, tcl-format
 msgid "<%s-n>\tGo to n-th parent of current commit in history list"
-msgstr "<%s-n>\tZu n-ter Elternversion in Versionshistorie springen"
+msgstr "<%s-n>\t\tZu n-tem Eltern-Commit in Commit-Historie springen"
 
 #: gitk:3085
 msgid "<PageUp>\tMove up one page in commit list"
@@ -452,44 +448,44 @@ msgstr "<BildRunter>\tEine Seite nach unten blättern"
 #: gitk:3087
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
-msgstr "<%s-Pos1>\tZum oberen Ende der Versionsliste blättern"
+msgstr "<%s-Pos1>\tZum oberen Ende der Commit-Liste blättern"
 
 #: gitk:3088
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
-msgstr "<%s-Ende>\tZum unteren Ende der Versionsliste blättern"
+msgstr "<%s-Ende>\tZum unteren Ende der Commit-Liste blättern"
 
 #: gitk:3089
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
-msgstr "<%s-Hoch>\tVersionsliste eine Zeile nach oben blättern"
+msgstr "<%s-Hoch>\tCommit-Liste eine Zeile nach oben blättern"
 
 #: gitk:3090
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
-msgstr "<%s-Runter>\tVersionsliste eine Zeile nach unten blättern"
+msgstr "<%s-Runter>\tCommit-Liste eine Zeile nach unten blättern"
 
 #: gitk:3091
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
-msgstr "<%s-BildHoch>\tVersionsliste eine Seite nach oben blättern"
+msgstr "<%s-BildHoch>\tCommit-Liste eine Seite nach oben blättern"
 
 #: gitk:3092
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
-msgstr "<%s-BildRunter>\tVersionsliste eine Seite nach unten blättern"
+msgstr "<%s-BildRunter>\tCommit-Liste eine Seite nach unten blättern"
 
 #: gitk:3093
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
-msgstr "<Umschalt-Hoch>\tRückwärts suchen (nach oben; neuere Versionen)"
+msgstr "<Umschalt-Hoch>\tRückwärts suchen (nach oben; neuere Commits)"
 
 #: gitk:3094
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
-msgstr "<Umschalt-Runter> Suchen (nach unten; ältere Versionen)"
+msgstr "<Umschalt-Runter> Suchen (nach unten; ältere Commits)"
 
 #: gitk:3095
 msgid "<Delete>, b\tScroll diff view up one page"
-msgstr "<Entf>, b\t\tVergleich eine Seite nach oben blättern"
+msgstr "<Entf>, b\tVergleich eine Seite nach oben blättern"
 
 #: gitk:3096
 msgid "<Backspace>\tScroll diff view up one page"
@@ -523,7 +519,7 @@ msgstr "<Eingabetaste>\tWeitersuchen"
 
 #: gitk:3103
 msgid "g\t\tGo to commit"
-msgstr "g\t\tZu Version springen"
+msgstr "g\t\tZu Commit springen"
 
 #: gitk:3104
 msgid "/\t\tFocus the search box"
@@ -587,7 +583,7 @@ msgstr "Kommando fehlgeschlagen:"
 
 #: gitk:3814
 msgid "No such commit"
-msgstr "Version nicht gefunden"
+msgstr "Commit nicht gefunden"
 
 #: gitk:3828
 msgid "git gui blame: command failed:"
@@ -620,22 +616,19 @@ msgstr "Fehler beim Ausführen von »git blame«: %s"
 #: gitk:3955
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
-msgstr ""
-"Diese Zeile stammt aus Version %s, die nicht in dieser Ansicht gezeigt wird"
+msgstr "Diese Zeile stammt aus Commit %s, der nicht in dieser Ansicht gezeigt wird"
 
 #: gitk:3969
 msgid "External diff viewer failed:"
 msgstr "Externes Diff-Programm fehlgeschlagen:"
 
 #: gitk:4073
-#, fuzzy
 msgid "All files"
-msgstr "&Alle Dateien"
+msgstr "Alle Dateien"
 
 #: gitk:4097
-#, fuzzy
 msgid "View"
-msgstr "&Ansicht"
+msgstr "Ansicht"
 
 #: gitk:4100
 msgid "Gitk view definition"
@@ -647,31 +640,31 @@ msgstr "Diese Ansicht speichern"
 
 #: gitk:4105
 msgid "References (space separated list):"
-msgstr "Zweige/Markierungen (durch Leerzeichen getrennte Liste):"
+msgstr "Branches/Tags (durch Leerzeichen getrennte Liste):"
 
 #: gitk:4106
 msgid "Branches & tags:"
-msgstr "Zweige/Markierungen:"
+msgstr "Branches/Tags:"
 
 #: gitk:4107
 msgid "All refs"
-msgstr "Alle Markierungen und Zweige"
+msgstr "Alle Tags und Branches"
 
 #: gitk:4108
 msgid "All (local) branches"
-msgstr "Alle (lokalen) Zweige"
+msgstr "Alle (lokalen) Branches"
 
 #: gitk:4109
 msgid "All tags"
-msgstr "Alle Markierungen"
+msgstr "Alle Tags"
 
 #: gitk:4110
 msgid "All remote-tracking branches"
-msgstr "Alle Übernahmezweige"
+msgstr "Alle Tracking-Branches"
 
 #: gitk:4111
 msgid "Commit Info (regular expressions):"
-msgstr "Versionsinformationen (reguläre Ausdrücke):"
+msgstr "Commit-Informationen (reguläre Ausdrücke):"
 
 #: gitk:4112
 msgid "Author:"
@@ -679,23 +672,23 @@ msgstr "Autor:"
 
 #: gitk:4113
 msgid "Committer:"
-msgstr "Eintragender:"
+msgstr "Committer:"
 
 #: gitk:4114
 msgid "Commit Message:"
-msgstr "Versionsbeschreibung:"
+msgstr "Commit-Beschreibung:"
 
 #: gitk:4115
 msgid "Matches all Commit Info criteria"
-msgstr "Alle Versionsinformationen-Kriterien erfüllen"
+msgstr "Alle Commit-Informationen-Kriterien erfüllen"
 
 #: gitk:4116
 msgid "Matches no Commit Info criteria"
-msgstr "keine Versionsinformationen-Kriterien erfüllen"
+msgstr "Keine Commit-Informationen-Kriterien erfüllen"
 
 #: gitk:4117
 msgid "Changes to Files:"
-msgstr "Dateien:"
+msgstr "Änderungen in Dateien:"
 
 #: gitk:4118
 msgid "Fixed String"
@@ -713,8 +706,7 @@ msgstr "Suchausdruck:"
 msgid ""
 "Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2009 "
 "15:27:38\"):"
-msgstr ""
-"Datum (»2 weeks ago«, »2009-03-17 15:27:38«, »March 17, 2009 15:27:38«)"
+msgstr "Commit-Datum (»2 weeks ago«, »2009-03-17 15:27:38«, »March 17, 2009 15:27:38«)"
 
 #: gitk:4122
 msgid "Since:"
@@ -726,15 +718,15 @@ msgstr "Bis:"
 
 #: gitk:4124
 msgid "Limit and/or skip a number of revisions (positive integer):"
-msgstr "Versionsanzahl begrenzen oder einige überspringen (ganzzahliger Wert):"
+msgstr "Commit-Anzahl begrenzen oder einige überspringen (ganzzahliger Wert):"
 
 #: gitk:4125
 msgid "Number to show:"
-msgstr "Anzeigen:"
+msgstr "Anzahl zu zeigen:"
 
 #: gitk:4126
 msgid "Number to skip:"
-msgstr "Überspringen:"
+msgstr "Anzahl zu überspringen:"
 
 #: gitk:4127
 msgid "Miscellaneous options:"
@@ -746,11 +738,11 @@ msgstr "Streng nach Datum sortieren"
 
 #: gitk:4129
 msgid "Mark branch sides"
-msgstr "Zweig-Seiten markieren"
+msgstr "Branch-Seiten markieren"
 
 #: gitk:4130
 msgid "Limit to first parent"
-msgstr "Auf erste Elternversion beschränken"
+msgstr "Auf ersten Eltern-Commit beschränken"
 
 #: gitk:4131
 msgid "Simple history"
@@ -766,7 +758,7 @@ msgstr "Folgende Dateien und Verzeichnisse anzeigen (eine pro Zeile):"
 
 #: gitk:4134
 msgid "Command to generate more commits to include:"
-msgstr "Versionsliste durch folgendes Kommando erzeugen lassen:"
+msgstr "Commit-Liste durch folgendes Kommando erzeugen lassen:"
 
 #: gitk:4258
 msgid "Gitk: edit view"
@@ -774,7 +766,7 @@ msgstr "Gitk: Ansicht bearbeiten"
 
 #: gitk:4266
 msgid "-- criteria for selecting revisions"
-msgstr "-- Auswahl der angezeigten Versionen"
+msgstr "-- Kriterien für angezeigte Commits"
 
 #: gitk:4271
 msgid "View Name"
@@ -786,7 +778,7 @@ msgstr "Anwenden (F5)"
 
 #: gitk:4384
 msgid "Error in commit selection arguments:"
-msgstr "Fehler in den ausgewählten Versionen:"
+msgstr "Fehler in den Argumenten zur Commit-Auswahl:"
 
 #: gitk:4439 gitk:4492 gitk:4954 gitk:4968 gitk:6238 gitk:12584 gitk:12585
 msgid "None"
@@ -794,32 +786,31 @@ msgstr "Keine"
 
 #: gitk:5051 gitk:5056
 msgid "Descendant"
-msgstr "Abkömmling"
+msgstr "Nachfolge-Commit"
 
 #: gitk:5052
 msgid "Not descendant"
-msgstr "Kein Abkömmling"
+msgstr "Kein Nachfolge-Commit"
 
 #: gitk:5059 gitk:5064
 msgid "Ancestor"
-msgstr "Vorgänger"
+msgstr "Vorgänger-Commit"
 
 #: gitk:5060
 msgid "Not ancestor"
-msgstr "Kein Vorgänger"
+msgstr "Kein Vorgänger-Commit"
 
 #: gitk:5354
 msgid "Local changes checked in to index but not committed"
-msgstr "Lokale Änderungen bereitgestellt, aber nicht eingetragen"
+msgstr "Lokale Änderungen bereitgestellt, aber nicht committet"
 
 #: gitk:5390
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokale Änderungen, nicht bereitgestellt"
 
 #: gitk:7138
-#, fuzzy
 msgid "Error starting web browser:"
-msgstr "Fehler beim Holen von »%s« von »%s«:"
+msgstr "Fehler beim Starten des Browsers:"
 
 #: gitk:7199
 msgid "and many more"
@@ -831,7 +822,7 @@ msgstr "viele"
 
 #: gitk:7393
 msgid "Tags:"
-msgstr "Markierungen:"
+msgstr "Tags:"
 
 #: gitk:7410 gitk:7416 gitk:8895
 msgid "Parent"
@@ -843,7 +834,7 @@ msgstr "Kind"
 
 #: gitk:7430
 msgid "Branch"
-msgstr "Zweig"
+msgstr "Branch"
 
 #: gitk:7433
 msgid "Follows"
@@ -870,7 +861,7 @@ msgstr "Kurzer SHA1-Hashwert »%s« ist mehrdeutig"
 #: gitk:8748
 #, tcl-format
 msgid "Revision %s is not known"
-msgstr "Version »%s« ist unbekannt"
+msgstr "Commit »%s« ist unbekannt"
 
 #: gitk:8758
 #, tcl-format
@@ -880,7 +871,7 @@ msgstr "SHA1-Hashwert »%s« ist unbekannt"
 #: gitk:8760
 #, tcl-format
 msgid "Revision %s is not in the current view"
-msgstr "Version »%s« wird in der aktuellen Ansicht nicht angezeigt"
+msgstr "Commit »%s« wird in der aktuellen Ansicht nicht angezeigt"
 
 #: gitk:8902 gitk:8917
 msgid "Date"
@@ -893,15 +884,15 @@ msgstr "Kinder"
 #: gitk:8968
 #, tcl-format
 msgid "Reset %s branch to here"
-msgstr "Zweig »%s« hierher zurücksetzen"
+msgstr "Branch »%s« hierher umsetzen (»reset«)"
 
 #: gitk:8970
 msgid "Detached head: can't reset"
-msgstr "Zweigspitze ist abgetrennt: Zurücksetzen nicht möglich"
+msgstr "Branchspitze ist losgelöst: Umsetzen nicht möglich"
 
 #: gitk:9075 gitk:9081
 msgid "Skipping merge commit "
-msgstr "Überspringe Zusammenführungs-Version "
+msgstr "Überspringe Zusammenführungs-Commit "
 
 #: gitk:9090 gitk:9095
 msgid "Error getting patch ID for "
@@ -913,7 +904,7 @@ msgstr " - Abbruch.\n"
 
 #: gitk:9101 gitk:9104 gitk:9112 gitk:9126 gitk:9135
 msgid "Commit "
-msgstr "Version "
+msgstr "Commit "
 
 #: gitk:9105
 msgid ""
@@ -935,9 +926,7 @@ msgstr ""
 msgid ""
 "Diff of commits:\n"
 "\n"
-msgstr ""
-"Vergleich der Versionen:\n"
-"\n"
+msgstr "Vergleich der Commits:\n\n"
 
 #: gitk:9127 gitk:9136
 #, tcl-format
@@ -947,12 +936,12 @@ msgstr " hat %s Kinder. Abbruch\n"
 #: gitk:9155
 #, tcl-format
 msgid "Error writing commit to file: %s"
-msgstr "Fehler beim Schreiben der Version in Datei: %s"
+msgstr "Fehler beim Schreiben des Commits in Datei: %s"
 
 #: gitk:9161
 #, tcl-format
 msgid "Error diffing commits: %s"
-msgstr "Fehler beim Vergleichen der Versionen: %s"
+msgstr "Fehler beim Vergleichen der Commits: %s"
 
 #: gitk:9207
 msgid "Top"
@@ -1000,15 +989,15 @@ msgstr "ID:"
 
 #: gitk:9335
 msgid "Tag name:"
-msgstr "Markierungsname:"
+msgstr "Tag-Name:"
 
 #: gitk:9338
 msgid "Tag message is optional"
-msgstr "Eine Markierungsbeschreibung ist optional"
+msgstr "Eine Tag-Beschreibung ist optional"
 
 #: gitk:9340
 msgid "Tag message:"
-msgstr "Markierungsbeschreibung:"
+msgstr "Tag-Beschreibung:"
 
 #: gitk:9344 gitk:9515
 msgid "Create"
@@ -1016,16 +1005,16 @@ msgstr "Erstellen"
 
 #: gitk:9362
 msgid "No tag name specified"
-msgstr "Kein Markierungsname angegeben"
+msgstr "Kein Tag-Name angegeben"
 
 #: gitk:9366
 #, tcl-format
 msgid "Tag \"%s\" already exists"
-msgstr "Markierung »%s« existiert bereits."
+msgstr "Tag »%s« existiert bereits."
 
 #: gitk:9376
 msgid "Error creating tag:"
-msgstr "Fehler beim Erstellen der Markierung:"
+msgstr "Fehler beim Erstellen des Tags:"
 
 #: gitk:9466
 msgid "Command:"
@@ -1037,21 +1026,20 @@ msgstr "Schreiben"
 
 #: gitk:9492
 msgid "Error writing commit:"
-msgstr "Fehler beim Schreiben der Version:"
+msgstr "Fehler beim Schreiben der Commits:"
 
 #: gitk:9514
-#, fuzzy
 msgid "Create branch"
-msgstr "Neuen Zweig erstellen"
+msgstr "Branch erstellen"
 
 #: gitk:9530
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Rename branch %s"
-msgstr "Zweig »%s« auf »%s« zurücksetzen?"
+msgstr "Branch »%s« umbenennen"
 
 #: gitk:9531
 msgid "Rename"
-msgstr ""
+msgstr "Umbenennen"
 
 #: gitk:9555
 msgid "Name:"
@@ -1059,28 +1047,25 @@ msgstr "Name:"
 
 #: gitk:9579
 msgid "Please specify a name for the new branch"
-msgstr "Bitte geben Sie einen Namen für den neuen Zweig an."
+msgstr "Bitte geben Sie einen Namen für den neuen Branch an."
 
 #: gitk:9584
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
-msgstr "Zweig »%s« existiert bereits. Soll er überschrieben werden?"
+msgstr "Branch »%s« existiert bereits. Soll er überschrieben werden?"
 
 #: gitk:9628
-#, fuzzy
 msgid "Please specify a new name for the branch"
-msgstr "Bitte geben Sie einen Namen für den neuen Zweig an."
+msgstr "Bitte geben Sie einen neuen Namen für den Branch an."
 
 #: gitk:9691
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
-msgstr ""
-"Version »%s« ist bereits im Zweig »%s« enthalten -- trotzdem erneut "
-"eintragen?"
+msgstr "Commit »%s« ist bereits im Branch »%s« enthalten -- trotzdem erneut committen?"
 
 #: gitk:9696
 msgid "Cherry-picking"
-msgstr "Version pflücken"
+msgstr "Cherry-pick"
 
 #: gitk:9705
 #, tcl-format
@@ -1088,31 +1073,31 @@ msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
 "Please commit, reset or stash your changes and try again."
 msgstr ""
-"Pflücken fehlgeschlagen, da noch lokale Änderungen in Datei »%s«\n"
-"vorliegen. Bitte diese Änderungen eintragen, zurücksetzen oder\n"
-"zwischenspeichern (»git stash«) und dann erneut versuchen."
+"Cherry-pick fehlgeschlagen, da noch lokale Änderungen in Datei »%s«\n"
+"vorliegen. Bitte diese Änderungen committen, verwerfen oder\n"
+"im Stash speichern (»git stash«) und dann erneut versuchen."
 
 #: gitk:9711
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
 msgstr ""
-"Pflücken fehlgeschlagen, da ein Zusammenführungs-Konflikt aufgetreten\n"
-"ist. Soll das Zusammenführungs-Werkzeug (»git citool«) aufgerufen\n"
-"werden, um diesen Konflikt aufzulösen?"
+"Cherry-pick fehlgeschlagen, da ein Zusammenführungs-Konflikt\n"
+"aufgetreten ist. Soll das Zusammenführungs-Werkzeug (»git citool«)\n"
+"aufgerufen werden, um diesen Konflikt aufzulösen?"
 
 #: gitk:9727 gitk:9785
 msgid "No changes committed"
-msgstr "Keine Änderungen eingetragen"
+msgstr "Keine Änderungen committet"
 
 #: gitk:9754
 #, tcl-format
 msgid "Commit %s is not included in branch %s -- really revert it?"
-msgstr "Version »%s« ist nicht im Zweig »%s« enthalten -- trotzdem umkehren?"
+msgstr "Commit »%s« ist nicht im Branch »%s« enthalten -- trotzdem zurücknehmen?"
 
 #: gitk:9759
 msgid "Reverting"
-msgstr "Umkehren"
+msgstr "Zurücknehmen"
 
 #: gitk:9767
 #, tcl-format
@@ -1120,31 +1105,31 @@ msgid ""
 "Revert failed because of local changes to the following files:%s Please "
 "commit, reset or stash  your changes and try again."
 msgstr ""
-"Umkehren fehlgeschlagen, da noch lokale Änderungen in Datei »%s«\n"
-"vorliegen. Bitte diese Änderungen eintragen, zurücksetzen oder\n"
-"zwischenspeichern (»git stash«) und dann erneut versuchen."
+"Zurücknehmen fehlgeschlagen, da noch lokale Änderungen in Datei »%s«\n"
+"vorliegen. Bitte diese Änderungen committen, verwerfen oder im Stash\n"
+"speichern und dann erneut versuchen."
 
 #: gitk:9771
 msgid ""
 "Revert failed because of merge conflict.\n"
 " Do you wish to run git citool to resolve it?"
 msgstr ""
-"Umkehren fehlgeschlagen, da ein Zusammenführungs-Konflikt aufgetreten\n"
-"ist. Soll das Zusammenführungs-Werkzeug (»git citool«) aufgerufen\n"
-"werden, um diesen Konflikt aufzulösen?"
+"Zurücknehmen fehlgeschlagen, da ein Zusammenführungs-Konflikt\n"
+"aufgetreten ist. Soll das Zusammenführungs-Werkzeug (»git citool«)\n"
+"aufgerufen werden, um diesen Konflikt aufzulösen?"
 
 #: gitk:9814
 msgid "Confirm reset"
-msgstr "Zurücksetzen bestätigen"
+msgstr "Umsetzen bestätigen"
 
 #: gitk:9816
 #, tcl-format
 msgid "Reset branch %s to %s?"
-msgstr "Zweig »%s« auf »%s« zurücksetzen?"
+msgstr "Branch »%s« auf »%s« umsetzen?"
 
 #: gitk:9818
 msgid "Reset type:"
-msgstr "Art des Zurücksetzens:"
+msgstr "Art des Umsetzens:"
 
 #: gitk:9821
 msgid "Soft: Leave working tree and index untouched"
@@ -1166,12 +1151,12 @@ msgstr ""
 
 #: gitk:9844
 msgid "Resetting"
-msgstr "Zurücksetzen"
+msgstr "Umsetzen"
 
 #: gitk:9917
 #, tcl-format
 msgid "A local branch named %s exists already"
-msgstr ""
+msgstr "Ein lokaler Branch mit dem Namen »%s« existiert bereits."
 
 #: gitk:9925
 msgid "Checking out"
@@ -1179,9 +1164,7 @@ msgstr "Umstellen"
 
 #: gitk:9984
 msgid "Cannot delete the currently checked-out branch"
-msgstr ""
-"Der Zweig, auf den die Arbeitskopie momentan umgestellt ist, kann nicht "
-"gelöscht werden."
+msgstr "Der Branch, der in der Arbeitskopie gerade ausgecheckt ist, kann nicht gelöscht werden."
 
 #: gitk:9990
 #, tcl-format
@@ -1189,13 +1172,13 @@ msgid ""
 "The commits on branch %s aren't on any other branch.\n"
 "Really delete branch %s?"
 msgstr ""
-"Die Versionen auf Zweig »%s« existieren auf keinem anderen Zweig.\n"
-"Zweig »%s« trotzdem löschen?"
+"Die Commits von Branch »%s« existieren auf keinem anderen Branch.\n"
+"Branch »%s« trotzdem löschen?"
 
 #: gitk:10021
 #, tcl-format
 msgid "Tags and heads: %s"
-msgstr "Markierungen und Zweige: %s"
+msgstr "Branches und Tags: %s"
 
 #: gitk:10038
 msgid "Filter"
@@ -1205,13 +1188,11 @@ msgstr "Filtern"
 msgid ""
 "Error reading commit topology information; branch and preceding/following "
 "tag information will be incomplete."
-msgstr ""
-"Fehler beim Lesen der Strukturinformationen; Zweige und Informationen zu "
-"Vorgänger/Nachfolger werden unvollständig sein."
+msgstr "Fehler beim Lesen der Strukturinformationen; Informationen zu Branch und Vorgänger-/Nachfolge-Tags werden unvollständig sein."
 
 #: gitk:11316
 msgid "Tag"
-msgstr "Markierung"
+msgstr "Tag"
 
 #: gitk:11320
 msgid "Id"
@@ -1231,7 +1212,7 @@ msgstr "K"
 
 #: gitk:11541
 msgid "Commit list display options"
-msgstr "Anzeige der Versionsliste"
+msgstr "Anzeige der Commit-Liste"
 
 #: gitk:11544
 msgid "Maximum graph width (lines)"
@@ -1252,7 +1233,7 @@ msgstr "SHA1-Hashwert (Länge) automatisch auswählen"
 
 #: gitk:11558
 msgid "Hide remote refs"
-msgstr "Entfernte Zweige/Markierungen ausblenden"
+msgstr "Externe Branches/Tags ausblenden"
 
 #: gitk:11562
 msgid "Diff display options"
@@ -1264,11 +1245,11 @@ msgstr "Tabulatorbreite"
 
 #: gitk:11567
 msgid "Display nearby tags/heads"
-msgstr "Naheliegende Markierungen/Zweigspitzen anzeigen"
+msgstr "Naheliegende Tags/Branches anzeigen"
 
 #: gitk:11570
 msgid "Maximum # tags/heads to show"
-msgstr "Maximale Anzahl anzuzeigender Markierungen/Zweigspitzen"
+msgstr "Maximale Anzahl anzuzeigender Tags/Branches"
 
 #: gitk:11573
 msgid "Limit diffs to listed paths"
@@ -1288,7 +1269,7 @@ msgstr "Wählen ..."
 
 #: gitk:11590
 msgid "Web browser"
-msgstr ""
+msgstr "Browser"
 
 #: gitk:11595
 msgid "General options"
@@ -1352,11 +1333,11 @@ msgstr "Vergleich - Neue Zeilen"
 
 #: gitk:11638
 msgid "Diff: hunk header"
-msgstr "Vergleich: Änderungstitel"
+msgstr "Vergleich: Titel des Patch-Block"
 
 #: gitk:11640
 msgid "diff hunk header"
-msgstr "Vergleich - Änderungstitel"
+msgstr "Vergleich - Titel des Patch-Block"
 
 #: gitk:11644
 msgid "Marked line bg"
@@ -1423,23 +1404,8 @@ msgstr "Kein Git-Projektarchiv gefunden."
 #: gitk:12523
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
-msgstr "Mehrdeutige Angabe »%s«: Sowohl Version als auch Dateiname existiert."
+msgstr "Mehrdeutige Angabe »%s«: Sowohl Commit als auch Dateiname existiert."
 
 #: gitk:12535
 msgid "Bad arguments to gitk:"
 msgstr "Falsche Kommandozeilen-Parameter für gitk:"
-
-#~ msgid "mc"
-#~ msgstr "mc"
-
-#~ msgid "next"
-#~ msgstr "nächste"
-
-#~ msgid "prev"
-#~ msgstr "vorige"
-
-#~ msgid "CDate"
-#~ msgstr "Eintragedatum"
-
-#~ msgid "Cannot find the git directory \"%s\"."
-#~ msgstr "Git-Verzeichnis »%s« wurde nicht gefunden."
-- 
2.17.1





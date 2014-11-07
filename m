From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v3 5/7] part5: l10n: de.po: use imperative form for command options
Date: Fri,  7 Nov 2014 21:11:18 +0100
Message-ID: <1415391080-26841-6-git-send-email-ralf.thielow@gmail.com>
References: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com>
 <1415391080-26841-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org, phillip.szelat@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 07 21:12:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmpsq-0002qR-A3
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 21:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbaKGULj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Nov 2014 15:11:39 -0500
Received: from mail-wi0-f181.google.com ([209.85.212.181]:55537 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbaKGULe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 15:11:34 -0500
Received: by mail-wi0-f181.google.com with SMTP id n3so5654172wiv.8
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 12:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=63s88fLM9ROjMhE9F1IxglbY8UzGJH6/KnaTBMDN0gs=;
        b=zD6troNZmK2xhjH7lSZmQN3wIln0n1UiCG0jNtVSULlQ7YsxxCgHtZFj9PJqJ1HdF8
         9qgoki8hTp57HtChJnGRwqEkvtw/UMEK7Mm/6qMTcURKGs6qQzGODrgoWthwJCmpCibJ
         KUJvLb52LIbmQx+gwXG5fqHiijkdNgu+bg2n/lWUTztA7R5TqnqTaAJZMmE3vKCZ6ZM+
         2uqisbxS1pdK5kHbq9mceinOfq8tpJJObHG2+Lc22eQlTSdpOvGhhXBtl2uDCCQYNZp0
         Bm+ANCN0JA0vgL3oxzMqJWWVuV9CmA3gwljsHzerNYfWKa98jvfoW6i9EqOW6H0+/yLb
         /LIg==
X-Received: by 10.180.107.136 with SMTP id hc8mr8157705wib.78.1415391093061;
        Fri, 07 Nov 2014 12:11:33 -0800 (PST)
Received: from localhost (dslb-088-073-206-248.088.073.pools.vodafone-ip.de. [88.73.206.248])
        by mx.google.com with ESMTPSA id ce1sm13045985wjc.2.2014.11.07.12.11.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Nov 2014 12:11:32 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc0.232.g8ec773f
In-Reply-To: <1415391080-26841-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 162 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/po/de.po b/po/de.po
index 64ee621..f94d46f 100644
--- a/po/de.po
+++ b/po/de.po
@@ -6749,7 +6749,7 @@ msgstr "Ausgabe relativ zum Projektverzeichnis"
 #: builtin/ls-files.c:501
 msgid "if any <file> is not in the index, treat this as an error"
 msgstr ""
-"behandle es als Fehler, wenn sich eine <Datei> nicht in der Staging-A=
rea "
+"als Fehler behandeln, wenn sich eine <Datei> nicht in der Staging-Are=
a "
 "befindet"
=20
 #: builtin/ls-files.c:502
@@ -6759,12 +6759,12 @@ msgstr "Commit-Referenz"
 #: builtin/ls-files.c:503
 msgid "pretend that paths removed since <tree-ish> are still present"
 msgstr ""
-"gibt vor, dass Pfade, die seit <Commit-Referenz> gel=C3=B6scht wurden=
, immer noch "
+"vorgeben, dass Pfade, die seit <Commit-Referenz> gel=C3=B6scht wurden=
, immer noch "
 "vorhanden sind"
=20
 #: builtin/ls-files.c:505
 msgid "show debugging data"
-msgstr "zeigt Ausgaben zur Fehlersuche an"
+msgstr "Ausgaben zur Fehlersuche anzeigen"
=20
 #: builtin/ls-tree.c:28
 msgid "git ls-tree [<options>] <tree-ish> [<path>...]"
@@ -6772,36 +6772,36 @@ msgstr "git ls-tree [<Optionen>] <Commit-Refere=
nz> [<Pfad>...]"
=20
 #: builtin/ls-tree.c:126
 msgid "only show trees"
-msgstr "zeigt nur Verzeichnisse an"
+msgstr "nur Verzeichnisse anzeigen"
=20
 #: builtin/ls-tree.c:128
 msgid "recurse into subtrees"
-msgstr "f=C3=BChrt Rekursion in Unterverzeichnissen durch"
+msgstr "Rekursion in Unterverzeichnissen durchf=C3=BChren"
=20
 #: builtin/ls-tree.c:130
 msgid "show trees when recursing"
-msgstr "zeigt Verzeichnisse bei Rekursion an"
+msgstr "Verzeichnisse bei Rekursion anzeigen"
=20
 #: builtin/ls-tree.c:133
 msgid "terminate entries with NUL byte"
-msgstr "schlie=C3=9Ft Eintr=C3=A4ge mit NUL-Byte ab"
+msgstr "Eintr=C3=A4ge mit NUL-Byte abschlie=C3=9Fen"
=20
 #: builtin/ls-tree.c:134
 msgid "include object size"
-msgstr "schlie=C3=9Ft Objektgr=C3=B6=C3=9Fe ein"
+msgstr "Objektgr=C3=B6=C3=9Fe einschlie=C3=9Fen"
=20
 #: builtin/ls-tree.c:136 builtin/ls-tree.c:138
 msgid "list only filenames"
-msgstr "listet nur Dateinamen auf"
+msgstr "nur Dateinamen auflisten"
=20
 #: builtin/ls-tree.c:141
 msgid "use full path names"
-msgstr "verwendet vollst=C3=A4ndige Pfadnamen"
+msgstr "vollst=C3=A4ndige Pfadnamen verwenden"
=20
 #: builtin/ls-tree.c:143
 msgid "list entire tree; not just current directory (implies --full-na=
me)"
 msgstr ""
-"listet das gesamte Verzeichnis auf; nicht nur das aktuelle Verzeichni=
s "
+"das gesamte Verzeichnis auflisten; nicht nur das aktuelle Verzeichnis=
 "
 "(impliziert --full-name)"
=20
 #: builtin/merge.c:43
@@ -6837,11 +6837,11 @@ msgstr "Verf=C3=BCgbare benutzerdefinierte Stra=
tegien sind:"
=20
 #: builtin/merge.c:191
 msgid "do not show a diffstat at the end of the merge"
-msgstr "zeigt keine Zusammenfassung der Unterschiede am Schluss des Me=
rges an"
+msgstr "keine Zusammenfassung der Unterschiede am Schluss des Merges a=
nzeigen"
=20
 #: builtin/merge.c:194
 msgid "show a diffstat at the end of the merge"
-msgstr "zeigt eine Zusammenfassung der Unterschiede am Schluss des Mer=
ges an"
+msgstr "eine Zusammenfassung der Unterschiede am Schluss des Merges an=
zeigen"
=20
 #: builtin/merge.c:195
 msgid "(synonym to --stat)"
@@ -6850,16 +6850,16 @@ msgstr "(Synonym f=C3=BCr --stat)"
 #: builtin/merge.c:197
 msgid "add (at most <n>) entries from shortlog to merge commit message=
"
 msgstr ""
-"f=C3=BCgt (h=C3=B6chstens <n>) Eintr=C3=A4ge von \"shortlog\" zur Bes=
chreibung des Merge-"
-"Commits hinzu"
+"(h=C3=B6chstens <n>) Eintr=C3=A4ge von \"shortlog\" zur Beschreibung =
des Merge-"
+"Commits hinzuf=C3=BCgen"
=20
 #: builtin/merge.c:200
 msgid "create a single commit instead of doing a merge"
-msgstr "erzeugt einen einzelnen Commit anstatt eines Merges"
+msgstr "einen einzelnen Commit anstatt eines Merges erzeugen"
=20
 #: builtin/merge.c:202
 msgid "perform a commit if the merge succeeds (default)"
-msgstr "f=C3=BChrt einen Commit durch, wenn der Merge erfolgreich war =
(Standard)"
+msgstr "einen Commit durchf=C3=BChren, wenn der Merge erfolgreich war =
(Standard)"
=20
 #: builtin/merge.c:204
 msgid "edit message before committing"
@@ -6867,15 +6867,15 @@ msgstr "Bearbeitung der Beschreibung vor dem Co=
mmit"
=20
 #: builtin/merge.c:205
 msgid "allow fast-forward (default)"
-msgstr "erlaubt Vorspulen (Standard)"
+msgstr "Vorspulen erlauben (Standard)"
=20
 #: builtin/merge.c:207
 msgid "abort if fast-forward is not possible"
-msgstr "bricht ab, wenn kein Vorspulen m=C3=B6glich ist"
+msgstr "abbrechen, wenn kein Vorspulen m=C3=B6glich ist"
=20
 #: builtin/merge.c:211
 msgid "Verify that the named commit has a valid GPG signature"
-msgstr "=C3=BCberpr=C3=BCft den genannten Commit auf eine g=C3=BCltige=
 GPG-Signatur"
+msgstr "den genannten Commit auf eine g=C3=BCltige GPG-Signatur =C3=BC=
berpr=C3=BCfen"
=20
 #: builtin/merge.c:212 builtin/notes.c:742 builtin/revert.c:89
 msgid "strategy"
@@ -6896,11 +6896,11 @@ msgstr "Option f=C3=BCr ausgew=C3=A4hlte Merge-=
Strategie"
 #: builtin/merge.c:217
 msgid "merge commit message (for a non-fast-forward merge)"
 msgstr ""
-"f=C3=BChrt Commit-Beschreibung zusammen (f=C3=BCr einen Merge, der ke=
in Vorspulen war)"
+"Commit-Beschreibung zusammenf=C3=BChren (f=C3=BCr einen Merge, der ke=
in Vorspulen war)"
=20
 #: builtin/merge.c:221
 msgid "abort the current in-progress merge"
-msgstr "bricht den sich im Gange befindlichen Merge ab"
+msgstr "den sich im Gange befindlichen Merge abbrechen"
=20
 #: builtin/merge.c:250
 msgid "could not run stash."
@@ -7190,11 +7190,11 @@ msgstr "Ausgabe aller gemeinsamen Vorg=C3=A4nge=
r-Commits"
=20
 #: builtin/merge-base.c:216
 msgid "find ancestors for a single n-way merge"
-msgstr "findet Vorg=C3=A4nger-Commits f=C3=BCr einen einzelnen n-Wege-=
Merge"
+msgstr "Vorg=C3=A4nger-Commits f=C3=BCr einen einzelnen n-Wege-Merge f=
inden"
=20
 #: builtin/merge-base.c:218
 msgid "list revs not reachable from others"
-msgstr "listet Commits auf, die nicht durch Andere erreichbar sind"
+msgstr "Commits auflisten, die nicht durch Andere erreichbar sind"
=20
 #: builtin/merge-base.c:220
 msgid "is the first one ancestor of the other?"
@@ -7202,7 +7202,7 @@ msgstr "ist der Erste ein Vorg=C3=A4nger-Commit v=
on dem Anderen?"
=20
 #: builtin/merge-base.c:222
 msgid "find where <commit> forked from reflog of <ref>"
-msgstr "findet wo <Commit> von Reflog von <Referenz> abgespalten wurde=
"
+msgstr "<Commit> finden, von wo Reflog von <Referenz> abgespalten wurd=
e"
=20
 #: builtin/merge-file.c:8
 msgid ""
@@ -7214,27 +7214,27 @@ msgstr ""
=20
 #: builtin/merge-file.c:33
 msgid "send results to standard output"
-msgstr "sendet Ergebnisse zur Standard-Ausgabe"
+msgstr "Ergebnisse zur Standard-Ausgabe senden"
=20
 #: builtin/merge-file.c:34
 msgid "use a diff3 based merge"
-msgstr "verwendet einen diff3 basierten Merge"
+msgstr "einen diff3 basierten Merge verwenden"
=20
 #: builtin/merge-file.c:35
 msgid "for conflicts, use our version"
-msgstr "verwendet bei Konflikten unsere Variante"
+msgstr "bei Konflikten unsere Variante verwenden"
=20
 #: builtin/merge-file.c:37
 msgid "for conflicts, use their version"
-msgstr "verwendet bei Konflikten ihre Variante"
+msgstr "bei Konflikten ihre Variante verwenden"
=20
 #: builtin/merge-file.c:39
 msgid "for conflicts, use a union version"
-msgstr "verwendet bei Konflikten eine gemeinsame Variante"
+msgstr "bei Konflikten eine gemeinsame Variante verwenden"
=20
 #: builtin/merge-file.c:42
 msgid "for conflicts, use this marker size"
-msgstr "verwendet bei Konflikten diese Kennzeichnungsl=C3=A4nge"
+msgstr "bei Konflikten diese Kennzeichnungsl=C3=A4nge verwenden"
=20
 #: builtin/merge-file.c:43
 msgid "do not warn about conflicts"
@@ -7242,7 +7242,7 @@ msgstr "keine Warnung bei Konflikten"
=20
 #: builtin/merge-file.c:45
 msgid "set labels for file1/orig_file/file2"
-msgstr "setzt Beschriftung f=C3=BCr Datei1/orig_Datei/Datei2"
+msgstr "Beschriftung f=C3=BCr Datei1/orig_Datei/Datei2 setzen"
=20
 #: builtin/mktree.c:64
 msgid "git mktree [-z] [--missing] [--batch]"
@@ -7254,11 +7254,11 @@ msgstr "Eingabe ist durch NUL-Zeichen abgeschlo=
ssen"
=20
 #: builtin/mktree.c:151 builtin/write-tree.c:24
 msgid "allow missing objects"
-msgstr "erlaubt fehlende Objekte"
+msgstr "fehlende Objekte erlauben"
=20
 #: builtin/mktree.c:152
 msgid "allow creation of more than one tree"
-msgstr "erlaubt die Erstellung von mehr als einem \"Tree\"-Objekt"
+msgstr "die Erstellung von mehr als einem \"Tree\"-Objekt erlauben"
=20
 #: builtin/mv.c:15
 msgid "git mv [options] <source>... <destination>"
@@ -7266,11 +7266,11 @@ msgstr "git mv [Optionen] <Quelle>... <Ziel>"
=20
 #: builtin/mv.c:71
 msgid "force move/rename even if target exists"
-msgstr "erzwingt Verschieben/Umbenennen, auch wenn das Ziel existiert"
+msgstr "Verschieben/Umbenennen erzwingen, auch wenn das Ziel existiert=
"
=20
 #: builtin/mv.c:72
 msgid "skip move/rename errors"
-msgstr "=C3=BCberspringt Fehler beim Verschieben oder Umbenennen"
+msgstr "Fehler beim Verschieben oder Umbenennen =C3=BCberspringen"
=20
 #: builtin/mv.c:122
 #, c-format
@@ -7364,31 +7364,31 @@ msgstr "git name-rev [Optionen] --stdin"
=20
 #: builtin/name-rev.c:309
 msgid "print only names (no SHA-1)"
-msgstr "zeigt nur Namen an (keine SHA-1)"
+msgstr "nur Namen anzeigen (keine SHA-1)"
=20
 #: builtin/name-rev.c:310
 msgid "only use tags to name the commits"
-msgstr "verwendet nur Tags, um die Commits zu benennen"
+msgstr "nur Tags verwenden, um die Commits zu benennen"
=20
 #: builtin/name-rev.c:312
 msgid "only use refs matching <pattern>"
-msgstr "verwendet nur Referenzen die <Muster> entsprechen"
+msgstr "nur Referenzen verwenden die <Muster> entsprechen"
=20
 #: builtin/name-rev.c:314
 msgid "list all commits reachable from all refs"
-msgstr "listet alle Commits auf, die von allen Referenzen erreichbar s=
ind"
+msgstr "alle Commits auflisten, die von allen Referenzen erreichbar si=
nd"
=20
 #: builtin/name-rev.c:315
 msgid "read from stdin"
-msgstr "liest von der Standard-Eingabe"
+msgstr "von der Standard-Eingabe lesen"
=20
 #: builtin/name-rev.c:316
 msgid "allow to print `undefined` names (default)"
-msgstr "erlaubt Ausgabe von `undefinierten` Namen (Standard)"
+msgstr "Ausgabe von `undefinierten` Namen erlauben (Standard)"
=20
 #: builtin/name-rev.c:322
 msgid "dereference tags in the input (internal use)"
-msgstr "dereferenziert Tags in der Eingabe (interne Verwendung)"
+msgstr "Tags in der Eingabe dereferenzieren (interne Verwendung)"
=20
 #: builtin/notes.c:24
 msgid "git notes [--ref <notes_ref>] [list [<object>]]"
@@ -7612,7 +7612,7 @@ msgstr "Wiederverwendung des angegebenen Notiz-Ob=
jektes"
=20
 #: builtin/notes.c:421 builtin/notes.c:489
 msgid "replace existing notes"
-msgstr "ersetzt existierende Notizen"
+msgstr "existierende Notizen ersetzen"
=20
 #: builtin/notes.c:455
 #, c-format
@@ -7630,12 +7630,12 @@ msgstr "=C3=9Cberschreibe existierende Notizen =
f=C3=BCr Objekt %s\n"
=20
 #: builtin/notes.c:490
 msgid "read objects from stdin"
-msgstr "liest Objekte von der Standard-Eingabe"
+msgstr "Objekte von der Standard-Eingabe lesen"
=20
 #: builtin/notes.c:492
 msgid "load rewriting config for <command> (implies --stdin)"
 msgstr ""
-"l=C3=A4dt Konfiguration f=C3=BCr <Kommando> beim Umschreiben von Vers=
ionen (impliziert "
+"Konfiguration f=C3=BCr <Kommando> beim Umschreiben von Versionen lade=
n (impliziert "
 "--stdin)"
=20
 #: builtin/notes.c:510
@@ -7683,21 +7683,21 @@ msgstr ""
=20
 #: builtin/notes.c:745
 msgid "Committing unmerged notes"
-msgstr "tr=C3=A4gt nicht zusammengef=C3=BChrte Notizen ein"
+msgstr "nicht zusammengef=C3=BChrte Notizen eintragen"
=20
 #: builtin/notes.c:747
 msgid "finalize notes merge by committing unmerged notes"
 msgstr ""
-"schlie=C3=9Ft Merge von Notizen ab, in dem nicht zusammengef=C3=BChrt=
e Notizen "
+"Merge von Notizen abschlie=C3=9Fen, in dem nicht zusammengef=C3=BChrt=
e Notizen "
 "committet werden"
=20
 #: builtin/notes.c:749
 msgid "Aborting notes merge resolution"
-msgstr "bricht Konfliktaufl=C3=B6sung beim Merge von Notizen ab"
+msgstr "Konfliktaufl=C3=B6sung beim Merge von Notizen abbrechen"
=20
 #: builtin/notes.c:751
 msgid "abort notes merge"
-msgstr "bricht Merge von Notizen ab"
+msgstr "Merge von Notizen abbrechen"
=20
 #: builtin/notes.c:846
 #, c-format
@@ -7710,7 +7710,7 @@ msgstr "der Versuch, eine nicht existierende Noti=
z zu l=C3=B6schen, ist kein Fehler"
=20
 #: builtin/notes.c:861
 msgid "read object names from the standard input"
-msgstr "liest Objektnamen von der Standard-Eingabe"
+msgstr "Objektnamen von der Standard-Eingabe lesen"
=20
 #: builtin/notes.c:942
 msgid "notes-ref"
@@ -7718,7 +7718,7 @@ msgstr "Notiz-Referenz"
=20
 #: builtin/notes.c:943
 msgid "use notes from <notes_ref>"
-msgstr "verwendet Notizen von <Notiz-Referenz>"
+msgstr "Notizen von <Notiz-Referenz> verwenden"
=20
 #: builtin/notes.c:978 builtin/remote.c:1616
 #, c-format
@@ -7776,15 +7776,15 @@ msgstr "konnte Wert '%s' f=C3=BCr Option %s nic=
ht parsen"
=20
 #: builtin/pack-objects.c:2576
 msgid "do not show progress meter"
-msgstr "zeigt keine Fortschrittsanzeige"
+msgstr "keine Fortschrittsanzeige anzeigen"
=20
 #: builtin/pack-objects.c:2578
 msgid "show progress meter"
-msgstr "zeigt Fortschrittsanzeige"
+msgstr "Fortschrittsanzeige anzeigen"
=20
 #: builtin/pack-objects.c:2580
 msgid "show progress meter during object writing phase"
-msgstr "zeigt Forschrittsanzeige w=C3=A4hrend der Phase des Schreibens=
 der Objekte"
+msgstr "Forschrittsanzeige w=C3=A4hrend der Phase des Schreibens der O=
bjekte anzeigen"
=20
 #: builtin/pack-objects.c:2583
 msgid "similar to --all-progress when progress meter is shown"
@@ -7797,7 +7797,7 @@ msgstr "version[,offset]"
 #: builtin/pack-objects.c:2585
 msgid "write the pack index file in the specified idx format version"
 msgstr ""
-"schreibt die Index-Datei des Paketes in der angegebenen Indexformat-V=
ersion"
+"die Index-Datei des Paketes in der angegebenen Indexformat-Version sc=
hreiben"
=20
 #: builtin/pack-objects.c:2588
 msgid "maximum size of each output pack file"
@@ -7805,19 +7805,19 @@ msgstr "maximale Gr=C3=B6=C3=9Fe f=C3=BCr jede =
ausgegebene Paketdatei"
=20
 #: builtin/pack-objects.c:2590
 msgid "ignore borrowed objects from alternate object store"
-msgstr "ignoriert geliehene Objekte von alternativem Objektspeicher"
+msgstr "geliehene Objekte von alternativem Objektspeicher ignorieren"
=20
 #: builtin/pack-objects.c:2592
 msgid "ignore packed objects"
-msgstr "ignoriert gepackte Objekte"
+msgstr "gepackte Objekte ignorieren"
=20
 #: builtin/pack-objects.c:2594
 msgid "limit pack window by objects"
-msgstr "begrenzt Paketfenster durch Objekte"
+msgstr "Paketfenster durch Objekte begrenzen"
=20
 #: builtin/pack-objects.c:2596
 msgid "limit pack window by memory in addition to object limit"
-msgstr "begrenzt Paketfenster, zus=C3=A4tzlich zur Objektbegrenzung, d=
urch Speicher"
+msgstr "Paketfenster, zus=C3=A4tzlich zur Objektbegrenzung, durch Spei=
cher begrenzen"
=20
 #: builtin/pack-objects.c:2598
 msgid "maximum length of delta chain allowed in the resulting pack"
@@ -7826,54 +7826,54 @@ msgstr ""
=20
 #: builtin/pack-objects.c:2600
 msgid "reuse existing deltas"
-msgstr "verwendet existierende Unterschiede wieder"
+msgstr "existierende Unterschiede wiederverwenden"
=20
 #: builtin/pack-objects.c:2602
 msgid "reuse existing objects"
-msgstr "verwendet existierende Objekte wieder"
+msgstr "existierende Objekte wiederverwenden"
=20
 #: builtin/pack-objects.c:2604
 msgid "use OFS_DELTA objects"
-msgstr "verwendet OFS_DELTA Objekte"
+msgstr "OFS_DELTA Objekte verwenden"
=20
 #: builtin/pack-objects.c:2606
 msgid "use threads when searching for best delta matches"
 msgstr ""
-"verwendet Threads bei der Suche nach den besten =C3=9Cbereinstimmunge=
n bei "
-"Unterschieden"
+"Threads bei der Suche nach den besten =C3=9Cbereinstimmungen bei "
+"Unterschieden verwenden"
=20
 #: builtin/pack-objects.c:2608
 msgid "do not create an empty pack output"
-msgstr "erzeugt keine leeren Pakete"
+msgstr "keine leeren Pakete erzeugen"
=20
 #: builtin/pack-objects.c:2610
 msgid "read revision arguments from standard input"
-msgstr "liest Argumente bez=C3=BCglich Commits von der Standard-Eingab=
e"
+msgstr "Argumente bez=C3=BCglich Commits von der Standard-Eingabe lese=
n"
=20
 #: builtin/pack-objects.c:2612
 msgid "limit the objects to those that are not yet packed"
-msgstr "begrenzt die Objekte zu solchen, die noch nicht gepackt wurden=
"
+msgstr "die Objekte zu solchen, die noch nicht gepackt wurden, begrenz=
en"
=20
 #: builtin/pack-objects.c:2615
 msgid "include objects reachable from any reference"
-msgstr "schlie=C3=9Ft Objekte ein, die von jeder Referenz erreichbar s=
ind"
+msgstr "Objekte einschlie=C3=9Fen, die von jeder Referenz erreichbar s=
ind"
=20
 #: builtin/pack-objects.c:2618
 msgid "include objects referred by reflog entries"
 msgstr ""
-"schlie=C3=9Ft Objekte ein, die von Eintr=C3=A4gen des Reflogs referen=
ziert werden"
+"Objekte einschlie=C3=9Fen, die von Eintr=C3=A4gen des Reflogs referen=
ziert werden"
=20
 #: builtin/pack-objects.c:2621
 msgid "output pack to stdout"
-msgstr "schreibt Paket in die Standard-Ausgabe"
+msgstr "Paket in die Standard-Ausgabe schreiben"
=20
 #: builtin/pack-objects.c:2623
 msgid "include tag objects that refer to objects to be packed"
-msgstr "schlie=C3=9Ft Tag-Objekte ein, die auf gepackte Objekte refere=
nzieren"
+msgstr "Tag-Objekte einschlie=C3=9Fen, die auf gepackte Objekte refere=
nzieren"
=20
 #: builtin/pack-objects.c:2625
 msgid "keep unreachable objects"
-msgstr "beh=C3=A4lt nicht erreichbare Objekte"
+msgstr "nicht erreichbare Objekte behalten"
=20
 #: builtin/pack-objects.c:2626 parse-options.h:140
 msgid "time"
@@ -7881,15 +7881,15 @@ msgstr "Zeit"
=20
 #: builtin/pack-objects.c:2627
 msgid "unpack unreachable objects newer than <time>"
-msgstr "entpackt nicht erreichbare Objekte, die neuer als <Zeit> sind"
+msgstr "nicht erreichbare Objekte entpacken, die neuer als <Zeit> sind=
"
=20
 #: builtin/pack-objects.c:2630
 msgid "create thin packs"
-msgstr "erzeugt d=C3=BCnnere Pakete"
+msgstr "d=C3=BCnnere Pakete erzeugen"
=20
 #: builtin/pack-objects.c:2632
 msgid "ignore packs that have companion .keep file"
-msgstr "ignoriert Pakete die .keep Dateien haben"
+msgstr "Pakete ignorieren, die .keep Dateien haben"
=20
 #: builtin/pack-objects.c:2634
 msgid "pack compression level"
@@ -7897,16 +7897,16 @@ msgstr "Komprimierungsgrad f=C3=BCr Paketierung=
"
=20
 #: builtin/pack-objects.c:2636
 msgid "do not hide commits by grafts"
-msgstr "verbirgt keine k=C3=BCnstlichen Vorg=C3=A4nger-Commits (\"graf=
ts\")"
+msgstr "keine k=C3=BCnstlichen Vorg=C3=A4nger-Commit (\"grafts\") verb=
ergen"
=20
 #: builtin/pack-objects.c:2638
 msgid "use a bitmap index if available to speed up counting objects"
 msgstr ""
-"benutzt Bitmap-Index (falls verf=C3=BCgbar) zur Optimierung der Objek=
tz=C3=A4hlung"
+"Bitmap-Index (falls verf=C3=BCgbar) zur Optimierung der Objektz=C3=A4=
hlung benutzen"
=20
 #: builtin/pack-objects.c:2640
 msgid "write a bitmap index together with the pack index"
-msgstr "schreibt Bitmap-Index zusammen mit Pack-Index"
+msgstr "Bitmap-Index zusammen mit Pack-Index schreiben"
=20
 #: builtin/pack-objects.c:2719
 msgid "Counting objects"
@@ -7918,11 +7918,11 @@ msgstr "git pack-refs [Optionen]"
=20
 #: builtin/pack-refs.c:14
 msgid "pack everything"
-msgstr "packt alles"
+msgstr "alles packen"
=20
 #: builtin/pack-refs.c:15
 msgid "prune loose refs (default)"
-msgstr "entfernt lose Referenzen (Standard)"
+msgstr "lose Referenzen entfernen (Standard)"
=20
 #: builtin/prune-packed.c:7
 msgid "git prune-packed [-n|--dry-run] [-q|--quiet]"
--=20
2.2.0.rc0.232.g8ec773f

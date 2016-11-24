Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA7101FF76
	for <e@80x24.org>; Thu, 24 Nov 2016 18:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934900AbcKXSZQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 13:25:16 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33157 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934873AbcKXSZM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 13:25:12 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so5656583wmu.0
        for <git@vger.kernel.org>; Thu, 24 Nov 2016 10:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/On0eRFsHfpL2S6AzjIzKaHKgPdlN09FJxzRK5EPokw=;
        b=wmdMsR394GnaqtUMHc/J27gyqiKjR8PVBX0tMHUdGXSx7DMDKOP3qIjHrxRYjFREYC
         q73zhGYh/0r5OVn/FiF2toC8j9awWhdVFNwXZrunnMSfFK6GTp4f1odw+AkZYzNxXYMy
         B8ltjp51zUmtKUnLJwK+6TqPULXL6nTSfFx/KQIw90IfBckZY63vVt+fUAbaf9DmtKJo
         bCBeTiIXt4pbxD8tXzulmB1S19Mp/J/UMOGbWT/q7zukwkIz3JhaHsYDgr/n45B3ccxQ
         r2e9z0h9S/taoh2VXGv338gj8H8Ybo0DDfk53h9EOiwQNIfe2qINmM0sZcuVyngImMTZ
         mUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/On0eRFsHfpL2S6AzjIzKaHKgPdlN09FJxzRK5EPokw=;
        b=eE6QavGcN9O3BtwTxZxg7NPFosM5WggneMnfpcRY6nN5ZtSltHFYpW+oJVuE6dEAeP
         7PaNoEqMYmj9GNbGWG5MsWI0MI1DM08jrWtYjiO460XA3do60+TQMWn8cdwuigKkP2yd
         v7gQbT36+6H+O8ZZqwMY3Dh2j5IRaW1+dvBQiAZyZAVIqZxZUIzdScgcs6u1vdcIol8T
         ArJCGxB/517opfVOui+JwqS6AspCIJg+tlY13fhcpe50waVB3MeynLHb0QXmc8+OaUu1
         IVAxlH+I2IOqjNc6mZXXqgQ9xIVsC1DWTTQLRucE6AiQCOWQnSFsgW0wWNJVdeEwen8H
         XmzA==
X-Gm-Message-State: AKaTC03sXcPix3B/+tD284S0k0417U8/LuG4GjMb0Qm/n3txEwKcR2hBVHP+XVXLuMUhZA==
X-Received: by 10.28.148.81 with SMTP id w78mr3572178wmd.42.1480011908857;
        Thu, 24 Nov 2016 10:25:08 -0800 (PST)
Received: from localhost (cable-86-56-90-181.cust.telecolumbus.net. [86.56.90.181])
        by smtp.gmail.com with ESMTPSA id bj1sm43120682wjc.17.2016.11.24.10.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Nov 2016 10:25:07 -0800 (PST)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
        phillip.szelat@gmail.com, matthias.ruester@gmail.com,
        magnus.goerlitz@googlemail.com,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 210 new message
Date:   Thu, 24 Nov 2016 19:25:00 +0100
Message-Id: <20161124182500.6875-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2.160.gf034b25
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Translate 210 new messages came from git.pot update in fda7b09
(l10n: git.pot: v2.11.0 round 1 (209 new, 53 removed)) and c091ffb
(l10n: git.pot: v2.11.0 round 2 (1 new, 1 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 657 ++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 331 insertions(+), 326 deletions(-)

diff --git a/po/de.po b/po/de.po
index 766a8e1b0..6a37885f5 100644
--- a/po/de.po
+++ b/po/de.po
@@ -111,32 +111,30 @@ msgstr ""
 
 #: apply.c:57
 #, c-format
 msgid "unrecognized whitespace option '%s'"
 msgstr "nicht erkannte Whitespace-Option: '%s'"
 
 #: apply.c:73
 #, c-format
 msgid "unrecognized whitespace ignore option '%s'"
 msgstr "nicht erkannte Option zum Ignorieren von Whitespace: '%s'"
 
 #: apply.c:125
-#, fuzzy
 msgid "--reject and --3way cannot be used together."
-msgstr "Die Optionen -x und -X können nicht gemeinsam verwendet werden."
+msgstr "--reject und --3way können nicht gemeinsam verwendet werden."
 
 #: apply.c:127
-#, fuzzy
 msgid "--cached and --3way cannot be used together."
-msgstr "Die Optionen -x und -X können nicht gemeinsam verwendet werden."
+msgstr "--cached und --3way können nicht gemeinsam verwendet werden."
 
 #: apply.c:130
 msgid "--3way outside a repository"
 msgstr ""
 "Die Option --3way kann nicht außerhalb eines Repositories verwendet werden."
 
 #: apply.c:141
 msgid "--index outside a repository"
 msgstr ""
 "Die Option --index kann nicht außerhalb eines Repositories verwendet werden."
 
 #: apply.c:144
@@ -200,29 +198,27 @@ msgid ""
 "component (line %d)"
 msgid_plural ""
 "git diff header lacks filename information when removing %d leading pathname "
 "components (line %d)"
 msgstr[0] ""
 "Dem Kopfbereich von \"git diff\" fehlen Informationen zum Dateinamen, wenn "
 "%d vorangestellter Teil des Pfades entfernt wird (Zeile %d)"
 msgstr[1] ""
 "Dem Kopfbereich von \"git diff\" fehlen Informationen zum Dateinamen, wenn "
 "%d vorangestellte Teile des Pfades entfernt werden (Zeile %d)"
 
 #: apply.c:1589
-#, fuzzy, c-format
+#, c-format
 msgid "git diff header lacks filename information (line %d)"
-msgstr ""
-"Dem Kopfbereich von \"git diff\" fehlen Informationen zum Dateinamen, wenn "
-"%d vorangestellter Teil des Pfades entfernt wird (Zeile %d)"
+msgstr "Dem Kopfbereich von \"git diff\" fehlen Informationen zum Dateinamen (Zeile %d)"
 
 #: apply.c:1759
 msgid "new file depends on old contents"
 msgstr "neue Datei hängt von alten Inhalten ab"
 
 #: apply.c:1761
 msgid "deleted file still has contents"
 msgstr "entfernte Datei hat noch Inhalte"
 
 #: apply.c:1795
 #, c-format
 msgid "corrupt patch at line %d"
@@ -295,45 +291,49 @@ msgstr ""
 "bei der Suche nach:\n"
 "%.*s"
 
 #: apply.c:3090
 #, c-format
 msgid "missing binary patch data for '%s'"
 msgstr "keine Daten in Binär-Patch für '%s'"
 
 #: apply.c:3098
 #, c-format
 msgid "cannot reverse-apply a binary patch without the reverse hunk to '%s'"
 msgstr ""
+"kann binären Patch nicht in umgekehrter Reihenfolge anwenden ohne einen\n"
+"umgekehrten Patch-Block auf '%s'"
 
 #: apply.c:3144
 #, c-format
 msgid "cannot apply binary patch to '%s' without full index line"
-msgstr ""
+msgstr "kann binären Patch auf '%s' nicht ohne eine vollständige Index-Zeile anwenden"
 
 #: apply.c:3154
 #, c-format
 msgid ""
 "the patch applies to '%s' (%s), which does not match the current contents."
 msgstr ""
+"der Patch wird angewendet auf '%s' (%s), was nicht den aktuellen Inhalten\n"
+"entspricht"
 
 #: apply.c:3162
 #, c-format
 msgid "the patch applies to an empty '%s' but it is not empty"
-msgstr ""
+msgstr "der Patch wird auf ein leeres '%s' angewendet, was aber nicht leer ist"
 
 #: apply.c:3180
 #, c-format
 msgid "the necessary postimage %s for '%s' cannot be read"
-msgstr ""
+msgstr "das erforderliche Postimage %s für '%s' kann nicht gelesen werden"
 
 #: apply.c:3193
 #, c-format
 msgid "binary patch does not apply to '%s'"
 msgstr "Konnte Binär-Patch nicht auf '%s' anwenden"
 
 #: apply.c:3199
 #, c-format
 msgid "binary patch to '%s' creates incorrect result (expecting %s, got %s)"
 msgstr ""
 "Binär-Patch für '%s' erzeugt falsches Ergebnis (erwartete %s, bekam %s)"
 
@@ -364,55 +364,53 @@ msgstr "Pfad %s wurde umbenannt/gelöscht"
 
 #: apply.c:3510 apply.c:3681
 #, c-format
 msgid "%s: does not exist in index"
 msgstr "%s ist nicht im Index"
 
 #: apply.c:3519 apply.c:3689
 #, c-format
 msgid "%s: does not match index"
 msgstr "%s entspricht nicht der Version im Index"
 
 #: apply.c:3554
-#, fuzzy
 msgid "repository lacks the necessary blob to fall back on 3-way merge."
 msgstr ""
-"Dem Repository fehlen notwendige Blobs um auf einen 3-Wege-Merge "
+"Dem Repository fehlt der notwendige Blob, um auf einen 3-Wege-Merge\n"
 "zurückzufallen."
 
 #: apply.c:3557
-#, fuzzy, c-format
+#, c-format
 msgid "Falling back to three-way merge...\n"
-msgstr "Falle zurück zum Patchen der Basis und zum 3-Wege-Merge ..."
+msgstr "Falle zurück auf 3-Wege-Merge ...\n"
 
 #: apply.c:3573 apply.c:3577
-#, fuzzy, c-format
+#, c-format
 msgid "cannot read the current contents of '%s'"
-msgstr ""
-"Kann aktuellen Branch nicht umbenennen, solange Sie sich auf keinem befinden."
+msgstr "kann aktuelle Inhalte von '%s' nicht lesen"
 
 #: apply.c:3589
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to fall back on three-way merge...\n"
-msgstr "erlaube, falls notwendig, das Zurückfallen auf einen 3-Wege-Merge"
+msgstr "Fehler beim Zurückfallen auf 3-Wege-Merge...\n"
 
 #: apply.c:3603
-#, fuzzy, c-format
+#, c-format
 msgid "Applied patch to '%s' with conflicts.\n"
-msgstr "Patch %s sauber angewendet"
+msgstr "Patch auf '%s' mit Konflikten angewendet.\n"
 
 #: apply.c:3608
-#, fuzzy, c-format
+#, c-format
 msgid "Applied patch to '%s' cleanly.\n"
-msgstr "Patch %s sauber angewendet"
+msgstr "Patch auf '%s' sauber angewendet.\n"
 
 #: apply.c:3634
 msgid "removal patch leaves file contents"
 msgstr "Lösch-Patch hinterlässt Dateiinhalte"
 
 #: apply.c:3706
 #, c-format
 msgid "%s: wrong type"
 msgstr "%s: falscher Typ"
 
 #: apply.c:3708
 #, c-format
@@ -453,50 +451,50 @@ msgstr "betroffene Datei '%s' ist hinter einer symbolischen Verknüpfung"
 #, c-format
 msgid "%s: patch does not apply"
 msgstr "%s: Patch konnte nicht angewendet werden"
 
 #: apply.c:3984
 #, c-format
 msgid "Checking patch %s..."
 msgstr "Prüfe Patch %s ..."
 
 #: apply.c:4075
 #, c-format
 msgid "sha1 information is lacking or useless for submodule %s"
-msgstr ""
+msgstr "SHA-1 Information fehlt oder ist unbrauchbar für Submodul %s"
 
 #: apply.c:4082
 #, c-format
 msgid "mode change for %s, which is not in current HEAD"
-msgstr ""
+msgstr "Modusänderung für %s, was sich nicht im aktuellen HEAD befindet"
 
 #: apply.c:4085
 #, c-format
 msgid "sha1 information is lacking or useless (%s)."
-msgstr ""
+msgstr "SHA-1 Information fehlt oder ist unbrauchbar (%s)."
 
 #: apply.c:4090 builtin/checkout.c:233 builtin/reset.c:135
 #, c-format
 msgid "make_cache_entry failed for path '%s'"
 msgstr "make_cache_entry für Pfad '%s' fehlgeschlagen"
 
 #: apply.c:4094
-#, fuzzy, c-format
+#, c-format
 msgid "could not add %s to temporary index"
-msgstr "konnte temporäre Datei nicht erstellen"
+msgstr "konnte %s nicht zum temporären Index hinzufügen"
 
 #: apply.c:4104
-#, fuzzy, c-format
+#, c-format
 msgid "could not write temporary index to %s"
-msgstr "konnte temporäre Datei nicht zu %s umbenennen"
+msgstr "konnte temporären Index nicht nach %s schreiben"
 
 #: apply.c:4242
 #, c-format
 msgid "unable to remove %s from index"
 msgstr "konnte %s nicht aus dem Index entfernen"
 
 #: apply.c:4277
 #, c-format
 msgid "corrupt patch for submodule %s"
 msgstr "fehlerhafter Patch für Submodul %s"
 
 #: apply.c:4283
@@ -506,27 +504,27 @@ msgstr "konnte neu erstellte Datei '%s' nicht lesen"
 
 #: apply.c:4291
 #, c-format
 msgid "unable to create backing store for newly created file %s"
 msgstr "kann internen Speicher für eben erstellte Datei %s nicht erzeugen"
 
 #: apply.c:4297 apply.c:4441
 #, c-format
 msgid "unable to add cache entry for %s"
 msgstr "kann für %s keinen Eintrag in den Zwischenspeicher hinzufügen"
 
 #: apply.c:4338
-#, fuzzy, c-format
+#, c-format
 msgid "failed to write to '%s'"
-msgstr "Fehler beim Löschen von '%s'"
+msgstr "Fehler beim Schreiben nach '%s'"
 
 #: apply.c:4342
 #, c-format
 msgid "closing file '%s'"
 msgstr "schließe Datei '%s'"
 
 #: apply.c:4412
 #, c-format
 msgid "unable to write file '%s' mode %o"
 msgstr "konnte Datei '%s' mit Modus %o nicht schreiben"
 
 #: apply.c:4510
@@ -570,48 +568,48 @@ msgstr "Patch-Block #%d zurückgewiesen."
 msgid "Skipped patch '%s'."
 msgstr "Patch '%s' ausgelassen."
 
 #: apply.c:4676
 msgid "unrecognized input"
 msgstr "nicht erkannte Eingabe"
 
 #: apply.c:4695
 msgid "unable to read index file"
 msgstr "Konnte Index-Datei nicht lesen"
 
 #: apply.c:4833
-#, fuzzy, c-format
+#, c-format
 msgid "can't open patch '%s': %s"
-msgstr "kann Patch '%s' nicht öffnen"
+msgstr "kann Patch '%s' nicht öffnen: %s"
 
 #: apply.c:4858
 #, c-format
 msgid "squelched %d whitespace error"
 msgid_plural "squelched %d whitespace errors"
 msgstr[0] "unterdrückte %d Whitespace-Fehler"
 msgstr[1] "unterdrückte %d Whitespace-Fehler"
 
 #: apply.c:4864 apply.c:4879
 #, c-format
 msgid "%d line adds whitespace errors."
 msgid_plural "%d lines add whitespace errors."
 msgstr[0] "%d Zeile fügt Whitespace-Fehler hinzu."
 msgstr[1] "%d Zeilen fügen Whitespace-Fehler hinzu."
 
 #: apply.c:4872
-#, fuzzy, c-format
+#, c-format
 msgid "%d line applied after fixing whitespace errors."
 msgid_plural "%d lines applied after fixing whitespace errors."
-msgstr[0] "%d Zeile fügt Whitespace-Fehler hinzu."
-msgstr[1] "%d Zeilen fügen Whitespace-Fehler hinzu."
+msgstr[0] "%d Zeile nach Behebung von Whitespace-Fehlern angewendet."
+msgstr[1] "%d Zeilen nach Behebung von Whitespace-Fehlern angewendet."
 
 #: apply.c:4888 builtin/add.c:463 builtin/mv.c:286 builtin/rm.c:431
 msgid "Unable to write new index file"
 msgstr "Konnte neue Index-Datei nicht schreiben."
 
 #: apply.c:4919 apply.c:4922 builtin/am.c:2277 builtin/am.c:2280
 #: builtin/clone.c:95 builtin/fetch.c:98 builtin/pull.c:180
 #: builtin/submodule--helper.c:281 builtin/submodule--helper.c:407
 #: builtin/submodule--helper.c:589 builtin/submodule--helper.c:592
 #: builtin/submodule--helper.c:944 builtin/submodule--helper.c:947
 msgid "path"
 msgstr "Pfad"
@@ -1231,24 +1229,28 @@ msgstr "konnte %s nicht parsen"
 
 #: commit.c:42
 #, c-format
 msgid "%s %s is not a commit!"
 msgstr "%s %s ist kein Commit!"
 
 #: commit.c:1514
 msgid ""
 "Warning: commit message did not conform to UTF-8.\n"
 "You may want to amend it after fixing the message, or set the config\n"
 "variable i18n.commitencoding to the encoding your project uses.\n"
 msgstr ""
+"Warnung: Die Commit-Beschreibung ist nicht UTF-8 konform.\n"
+"Sie können das Nachbessern, nachdem Sie die Beschreibung korrigiert haben,\n"
+"oder Sie setzen die Konfigurationsvariable i18n.commitencoding auf das Encoding,\n"
+"welches von ihrem Projekt verwendet wird.\n"
 
 #: compat/obstack.c:406 compat/obstack.c:408
 msgid "memory exhausted"
 msgstr "Speicher verbraucht"
 
 #: config.c:516
 #, c-format
 msgid "bad config line %d in blob %s"
 msgstr "Ungültige Konfigurationszeile %d in Blob %s"
 
 #: config.c:520
 #, c-format
@@ -1370,73 +1372,81 @@ msgstr "%s hat mehrere Werte"
 #: config.c:2311
 #, c-format
 msgid "could not set '%s' to '%s'"
 msgstr "Konnte '%s' nicht zu '%s' setzen."
 
 #: config.c:2313
 #, c-format
 msgid "could not unset '%s'"
 msgstr "Konnte '%s' nicht aufheben."
 
 #: connect.c:49
 msgid "The remote end hung up upon initial contact"
-msgstr ""
+msgstr "Die Gegenseite hat sich nach dem erstmaligen Kontakt aufgehangen."
 
 #: connect.c:51
 msgid ""
 "Could not read from remote repository.\n"
 "\n"
 "Please make sure you have the correct access rights\n"
 "and the repository exists."
 msgstr ""
+"Konnte nicht vom Remote-Repository lesen.\n"
+"\n"
+"Bitte stellen Sie sicher, dass die korrekten Zugriffsberechtigungen bestehen\n"
+"und das Repository existiert."
 
 #: connected.c:63 builtin/fsck.c:173 builtin/prune.c:140
 msgid "Checking connectivity"
 msgstr "Prüfe Konnektivität"
 
 #: connected.c:75
 msgid "Could not run 'git rev-list'"
 msgstr "Konnte 'git rev-list' nicht ausführen"
 
 #: connected.c:95
 msgid "failed write to rev-list"
 msgstr "Fehler beim Schreiben nach rev-list"
 
 #: connected.c:102
 msgid "failed to close rev-list's stdin"
 msgstr "Fehler beim Schließen von rev-list's Standard-Eingabe"
 
 #: convert.c:201
 #, c-format
 msgid ""
 "CRLF will be replaced by LF in %s.\n"
 "The file will have its original line endings in your working directory."
 msgstr ""
+"CRLF wird in %s durch LF ersetzt.\n"
+"Die Datei wird ihre ursprünglichen Zeilenenden im Arbeitsverzeichnis behalten."
 
 #: convert.c:205
 #, c-format
 msgid "CRLF would be replaced by LF in %s."
-msgstr ""
+msgstr "CRLF würde in %s durch LF ersetzt werden."
 
 #: convert.c:211
 #, c-format
 msgid ""
 "LF will be replaced by CRLF in %s.\n"
 "The file will have its original line endings in your working directory."
 msgstr ""
+"LF wird in %s durch CRLF ersetzt.\n"
+"Die Datei wird ihre ursprünglichen Zeilenenden im Arbeitsverzeichnis behalten."
 
 #: convert.c:215
 #, c-format
 msgid "LF would be replaced by CRLF in %s"
-msgstr ""
+msgstr "LF würde in %s durch CRLF ersetzt werden."
 
 #: date.c:97
 msgid "in the future"
 msgstr "in der Zukunft"
 
 #: date.c:103
 #, c-format
 msgid "%lu second ago"
 msgid_plural "%lu seconds ago"
 msgstr[0] "vor %lu Sekunde"
 msgstr[1] "vor %lu Sekunden"
 
@@ -1498,27 +1508,27 @@ msgstr[0] "vor %lu Jahr"
 msgstr[1] "vor %lu Jahren"
 
 #: diffcore-order.c:24
 #, c-format
 msgid "failed to read orderfile '%s'"
 msgstr "Fehler beim Lesen der Reihenfolgedatei '%s'."
 
 #: diffcore-rename.c:536
 msgid "Performing inexact rename detection"
 msgstr "Führe Erkennung für ungenaue Umbenennung aus"
 
 #: diff.c:62
-#, fuzzy, c-format
+#, c-format
 msgid "option '%s' requires a value"
-msgstr "Schalter 'm' erfordert einen Wert."
+msgstr "Option '%s' erfordert einen Wert."
 
 #: diff.c:124
 #, c-format
 msgid "  Failed to parse dirstat cut-off percentage '%s'\n"
 msgstr ""
 "  Fehler beim Parsen des abgeschnittenen \"dirstat\" Prozentsatzes '%s'\n"
 
 #: diff.c:129
 #, c-format
 msgid "  Unknown dirstat parameter '%s'\n"
 msgstr "  Unbekannter \"dirstat\" Parameter '%s'\n"
 
@@ -1533,246 +1543,239 @@ msgid ""
 "Found errors in 'diff.dirstat' config variable:\n"
 "%s"
 msgstr ""
 "Fehler in 'diff.dirstat' Konfigurationsvariable gefunden:\n"
 "%s"
 
 #: diff.c:3087
 #, c-format
 msgid "external diff died, stopping at %s"
 msgstr "externes Diff-Programm unerwartet beendet, angehalten bei %s"
 
 #: diff.c:3412
-#, fuzzy
 msgid "--name-only, --name-status, --check and -s are mutually exclusive"
-msgstr "-b, -B und --detach schließen sich gegenseitig aus"
+msgstr "--name-only, --name-status, --check und -s schließen sich gegenseitig aus"
 
 #: diff.c:3502
 msgid "--follow requires exactly one pathspec"
 msgstr "--follow erfordert genau eine Pfadspezifikation"
 
 #: diff.c:3665
 #, c-format
 msgid ""
 "Failed to parse --dirstat/-X option parameter:\n"
 "%s"
 msgstr ""
 "Fehler beim Parsen des --dirstat/-X Optionsparameters:\n"
 "%s"
 
 #: diff.c:3679
 #, c-format
 msgid "Failed to parse --submodule option parameter: '%s'"
 msgstr "Fehler beim Parsen des --submodule Optionsparameters: '%s'"
 
 #: diff.c:4700
 msgid "inexact rename detection was skipped due to too many files."
 msgstr ""
+"Ungenaue Erkennung für Umbenennungen wurde aufgrund zu vieler Dateien\n"
+"übersprungen."
 
 #: diff.c:4703
 msgid "only found copies from modified paths due to too many files."
-msgstr ""
+msgstr "nur Kopien von geänderten Pfaden, aufgrund zu vieler Dateien, gefunden"
 
 #: diff.c:4706
 #, c-format
 msgid ""
 "you may want to set your %s variable to at least %d and retry the command."
 msgstr ""
+"Sie könnten die Variable %s auf mindestens %d setzen und den Befehl\n"
+"erneut versuchen."
 
 #: dir.c:1866
 msgid "failed to get kernel name and information"
 msgstr "Fehler beim Sammeln von Namen und Informationen zum Kernel"
 
 #: dir.c:1985
 msgid "Untracked cache is disabled on this system or location."
 msgstr ""
 "Cache für unversionierte Dateien ist auf diesem System oder\n"
 "für dieses Verzeichnis deaktiviert."
 
 #: fetch-pack.c:213
-#, fuzzy
 msgid "git fetch-pack: expected shallow list"
-msgstr "git archive: erwartete eine Spülung (flush)"
+msgstr "git fetch-pack: erwartete shallow-Liste"
 
 #: fetch-pack.c:225
-#, fuzzy
 msgid "git fetch-pack: expected ACK/NAK, got EOF"
-msgstr "git archive: habe ACK/NAK erwartet, aber EOF bekommen"
+msgstr "git fetch-pack: ACK/NAK erwartet, EOF bekommen"
 
 #: fetch-pack.c:243
-#, fuzzy, c-format
+#, c-format
 msgid "git fetch-pack: expected ACK/NAK, got '%s'"
-msgstr "git archive: habe ACK/NAK erwartet, aber EOF bekommen"
+msgstr "git fetch-pack: ACK/NAK erwartet, '%s' bekommen"
 
 #: fetch-pack.c:295
 msgid "--stateless-rpc requires multi_ack_detailed"
-msgstr ""
+msgstr "--stateless-rpc benötigt multi_ack_detailed"
 
 #: fetch-pack.c:381
-#, fuzzy, c-format
+#, c-format
 msgid "invalid shallow line: %s"
-msgstr "Ungültiger Zeilenanfang: '%c'"
+msgstr "Ungültige shallow-Zeile: %s"
 
 #: fetch-pack.c:387
-#, fuzzy, c-format
+#, c-format
 msgid "invalid unshallow line: %s"
-msgstr "Ungültige Identifikationszeile: %s"
+msgstr "Ungültige unshallow-Zeile: %s"
 
 #: fetch-pack.c:389
-#, fuzzy, c-format
+#, c-format
 msgid "object not found: %s"
-msgstr "Objekt %s nicht gefunden"
+msgstr "Objekt nicht gefunden: %s"
 
 #: fetch-pack.c:392
-#, fuzzy, c-format
+#, c-format
 msgid "error in object: %s"
-msgstr "Fehler in Objekt"
+msgstr "Fehler in Objekt: %s"
 
 #: fetch-pack.c:394
-#, fuzzy, c-format
+#, c-format
 msgid "no shallow found: %s"
-msgstr "Keine solche URL gefunden: %s"
+msgstr "Kein shallow-Objekt gefunden: %s"
 
 #: fetch-pack.c:397
 #, c-format
 msgid "expected shallow/unshallow, got %s"
-msgstr ""
+msgstr "shallow/unshallow erwartet, %s bekommen"
 
 #: fetch-pack.c:436
-#, fuzzy, c-format
+#, c-format
 msgid "got %s %d %s"
-msgstr "%s: %s - %s"
+msgstr "%s %d %s bekommen"
 
 #: fetch-pack.c:450
-#, fuzzy, c-format
+#, c-format
 msgid "invalid commit %s"
-msgstr "Ungültige Option: %s"
+msgstr "Ungültiger Commit %s"
 
 #: fetch-pack.c:483
 msgid "giving up"
-msgstr ""
+msgstr "Gebe auf"
 
 #: fetch-pack.c:493 progress.c:235
 msgid "done"
 msgstr "Fertig"
 
 #: fetch-pack.c:505
 #, c-format
 msgid "got %s (%d) %s"
-msgstr ""
+msgstr "%s (%d) %s bekommen"
 
 #: fetch-pack.c:551
 #, c-format
 msgid "Marking %s as complete"
-msgstr ""
+msgstr "Markiere %s als vollständig"
 
 #: fetch-pack.c:697
 #, c-format
 msgid "already have %s (%s)"
-msgstr ""
+msgstr "habe %s (%s) bereits"
 
 #: fetch-pack.c:735
 msgid "fetch-pack: unable to fork off sideband demultiplexer"
-msgstr ""
+msgstr "fetch-pack: Fehler beim Starten des sideband demultiplexer"
 
 #: fetch-pack.c:743
 msgid "protocol error: bad pack header"
-msgstr ""
+msgstr "Protokollfehler: ungültiger Pack-Header"
 
 #: fetch-pack.c:799
-#, fuzzy, c-format
+#, c-format
 msgid "fetch-pack: unable to fork off %s"
-msgstr "git rm: konnte %s nicht löschen"
+msgstr "fetch-pack: konnte %s nicht starten"
 
 #: fetch-pack.c:815
-#, fuzzy, c-format
+#, c-format
 msgid "%s failed"
-msgstr "\"fseek\" fehlgeschlagen"
+msgstr "%s fehlgeschlagen"
 
 #: fetch-pack.c:817
 msgid "error in sideband demultiplexer"
-msgstr ""
+msgstr "Fehler in sideband demultiplexer"
 
 #: fetch-pack.c:844
-#, fuzzy
 msgid "Server does not support shallow clients"
-msgstr "rev-list unterstützt keine Anzeige von Notizen"
+msgstr "Server unterstützt keine shallow-Clients"
 
 #: fetch-pack.c:848
 msgid "Server supports multi_ack_detailed"
-msgstr ""
+msgstr "Server unterstützt multi_ack_detailed"
 
 #: fetch-pack.c:851
 msgid "Server supports no-done"
-msgstr ""
+msgstr "Server unterstützt no-done"
 
 #: fetch-pack.c:857
 msgid "Server supports multi_ack"
-msgstr ""
+msgstr "Server unterstützt multi_ack"
 
 #: fetch-pack.c:861
 msgid "Server supports side-band-64k"
-msgstr ""
+msgstr "Server unterstützt side-band-64k"
 
 #: fetch-pack.c:865
 msgid "Server supports side-band"
-msgstr ""
+msgstr "Server unterstützt side-band"
 
 #: fetch-pack.c:869
 msgid "Server supports allow-tip-sha1-in-want"
-msgstr ""
+msgstr "Server unterstützt allow-tip-sha1-in-want"
 
 #: fetch-pack.c:873
 msgid "Server supports allow-reachable-sha1-in-want"
-msgstr ""
+msgstr "Server unterstützt allow-reachable-sha1-in-want"
 
 #: fetch-pack.c:883
 msgid "Server supports ofs-delta"
-msgstr ""
+msgstr "Server unterstützt ofs-delta"
 
 #: fetch-pack.c:890
 #, c-format
 msgid "Server version is %.*s"
-msgstr ""
+msgstr "Server-Version ist %.*s"
 
 #: fetch-pack.c:896
-#, fuzzy
 msgid "Server does not support --shallow-since"
-msgstr ""
-"die Gegenseite unterstützt keinen signierten Versand (\"--signed push\")"
+msgstr "Server unterstützt kein --shallow-since"
 
 #: fetch-pack.c:900
-#, fuzzy
 msgid "Server does not support --shallow-exclude"
-msgstr "die Gegenseite unterstützt keinen atomaren Versand (\"--atomic push\")"
+msgstr "Server unterstützt kein --shallow-exclude"
 
 #: fetch-pack.c:902
-#, fuzzy
 msgid "Server does not support --deepen"
-msgstr ""
-"die Gegenseite unterstützt keinen signierten Versand (\"--signed push\")"
+msgstr "Server unterstützt kein --deepen"
 
 #: fetch-pack.c:913
-#, fuzzy
 msgid "no common commits"
-msgstr "Unbekannter Commit %s"
+msgstr "keine gemeinsamen Commits"
 
 #: fetch-pack.c:925
-#, fuzzy
 msgid "git fetch-pack: fetch failed."
-msgstr "Bearbeitung des Patches fehlgeschlagen"
+msgstr "git fetch-pack: Abholen fehlgeschlagen."
 
 #: fetch-pack.c:1087
 msgid "no matching remote head"
-msgstr ""
+msgstr "kein übereinstimmender Remote-Branch"
 
 #: gpg-interface.c:185
 msgid "gpg failed to sign the data"
 msgstr "gpg beim Signieren der Daten fehlgeschlagen"
 
 #: gpg-interface.c:215
 msgid "could not create temporary file"
 msgstr "konnte temporäre Datei nicht erstellen"
 
 #: gpg-interface.c:217
 #, c-format
 msgid "failed writing detached signature to '%s'"
@@ -1862,24 +1865,35 @@ msgid ""
 "\n"
 "*** Please tell me who you are.\n"
 "\n"
 "Run\n"
 "\n"
 "  git config --global user.email \"you@example.com\"\n"
 "  git config --global user.name \"Your Name\"\n"
 "\n"
 "to set your account's default identity.\n"
 "Omit --global to set the identity only in this repository.\n"
 "\n"
 msgstr ""
+"\n"
+"*** Bitte geben Sie an, wer Sie sind.\n"
+"\n"
+"Führen Sie\n"
+"\n"
+"  git config --global user.email \"you@example.com\"\n"
+"  git config --global user.name \"Your Name\"\n"
+"\n"
+"aus, um das als Ihre standardmäßige Identität zu setzen.\n"
+"Lassen Sie die Option \"--global\" weg, um die Identität nur\n"
+"für dieses Repository zu setzen.\n"
 
 #: lockfile.c:152
 #, c-format
 msgid ""
 "Unable to create '%s.lock': %s.\n"
 "\n"
 "Another git process seems to be running in this repository, e.g.\n"
 "an editor opened by 'git commit'. Please make sure all processes\n"
 "are terminated then try again. If it still fails, a git process\n"
 "may have crashed in this repository earlier:\n"
 "remove the file manually to continue."
 msgstr ""
@@ -2146,29 +2160,33 @@ msgstr "Konnte Objekt '%s' nicht parsen."
 
 #: merge-recursive.c:2135 builtin/merge.c:641 builtin/merge.c:788
 msgid "Unable to write index."
 msgstr "Konnte Index nicht schreiben."
 
 #: notes-merge.c:273
 #, c-format
 msgid ""
 "You have not concluded your previous notes merge (%s exists).\n"
 "Please, use 'git notes merge --commit' or 'git notes merge --abort' to "
 "commit/abort the previous merge before you start a new notes merge."
 msgstr ""
+"Sie haben Ihren vorherigen Merge von Notizen nicht abgeschlossen (%s existiert).\n"
+"Bitte benutzen Sie 'git notes merge --commit' oder 'git notes merge --abort', um\n"
+"den vorherigen Merge zu committen bzw. abzubrechen, bevor Sie einen neuen Merge\n"
+"von Notizen beginnen."
 
 #: notes-merge.c:280
-#, fuzzy, c-format
+#, c-format
 msgid "You have not concluded your notes merge (%s exists)."
-msgstr "Sie haben Ihren Merge nicht abgeschlossen (MERGE_HEAD existiert)."
+msgstr "Sie haben Ihren Merge von Notizen nicht abgeschlossen (%s existiert)."
 
 #: notes-utils.c:41
 msgid "Cannot commit uninitialized/unreferenced notes tree"
 msgstr ""
 "Kann uninitialisiertes/unreferenzierte Notiz-Verzeichnis nicht committen."
 
 #: notes-utils.c:100
 #, c-format
 msgid "Bad notes.rewriteMode value: '%s'"
 msgstr "Ungültiger notes.rewriteMode Wert: '%s'"
 
 #: notes-utils.c:110
@@ -2274,24 +2292,26 @@ msgstr "Pfadspezifikation '%s' befindet sich in Submodul '%.*s'"
 
 #: pathspec.c:353
 #, c-format
 msgid "%s: pathspec magic not supported by this command: %s"
 msgstr ""
 "%s: Pfadspezifikationsangabe wird von diesem Befehl nicht unterstützt: %s"
 
 #: pathspec.c:408
 msgid ""
 "empty strings as pathspecs will be made invalid in upcoming releases. please "
 "use . instead if you meant to match all paths"
 msgstr ""
+"Leere Strings als Pfadspezifikationen werden in kommenden Releases ungültig.\n"
+"Bitte benutzen Sie stattdessen . wenn Sie alle Pfade meinen."
 
 #: pathspec.c:440
 #, c-format
 msgid "pathspec '%s' is beyond a symbolic link"
 msgstr "Pfadspezifikation '%s' ist hinter einer symbolischen Verknüpfung"
 
 #: pathspec.c:449
 msgid ""
 "There is nothing to exclude from by :(exclude) patterns.\n"
 "Perhaps you forgot to add either ':/' or '.' ?"
 msgstr ""
 ":(exclude) Muster, aber keine anderen Pfadspezifikationen angegeben.\n"
@@ -2637,180 +2657,173 @@ msgstr ""
 "kein Versand des \"push\"-Zertifikates, da die Gegenseite keinen signierten\n"
 "Versand (\"--signed push\") unterstützt"
 
 #: send-pack.c:424
 msgid "the receiving end does not support --atomic push"
 msgstr "die Gegenseite unterstützt keinen atomaren Versand (\"--atomic push\")"
 
 #: send-pack.c:429
 msgid "the receiving end does not support push options"
 msgstr "die Gegenseite unterstützt keine Push-Optionen"
 
 #: sequencer.c:171
-#, fuzzy
 msgid "revert"
-msgstr "\"revert\" fehlgeschlagen"
+msgstr "Revert"
 
 #: sequencer.c:171
-#, fuzzy
 msgid "cherry-pick"
-msgstr "\"cherry-pick\" fehlgeschlagen"
+msgstr "Cherry-Pick"
 
 #: sequencer.c:228
 msgid ""
 "after resolving the conflicts, mark the corrected paths\n"
 "with 'git add <paths>' or 'git rm <paths>'"
 msgstr ""
 "nach Auflösung der Konflikte, markieren Sie die korrigierten Pfade\n"
 "mit 'git add <Pfade>' oder 'git rm <Pfade>'"
 
 #: sequencer.c:231
 msgid ""
 "after resolving the conflicts, mark the corrected paths\n"
 "with 'git add <paths>' or 'git rm <paths>'\n"
 "and commit the result with 'git commit'"
 msgstr ""
 "nach Auflösung der Konflikte, markieren Sie die korrigierten Pfade\n"
 "mit 'git add <Pfade>' oder 'git rm <Pfade>'und tragen Sie das Ergebnis mit\n"
 "'git commit' ein"
 
 #: sequencer.c:244 sequencer.c:1209
-#, fuzzy, c-format
+#, c-format
 msgid "could not lock '%s'"
-msgstr "Konnte '%s' nicht anwenden."
+msgstr "Konnte '%s' nicht sperren"
 
 #: sequencer.c:247 sequencer.c:1125 sequencer.c:1214
-#, fuzzy, c-format
+#, c-format
 msgid "could not write to '%s'"
 msgstr "Konnte nicht nach '%s' schreiben."
 
 #: sequencer.c:251
-#, fuzzy, c-format
+#, c-format
 msgid "could not write eol to '%s"
-msgstr "Konnte nicht nach '%s' schreiben."
+msgstr "Konnte EOL nicht nach '%s' schreiben."
 
 #: sequencer.c:255 sequencer.c:1130 sequencer.c:1216
-#, fuzzy, c-format
+#, c-format
 msgid "failed to finalize '%s'."
-msgstr "Konnte '%s' nicht entfernen."
+msgstr "Fehler beim Fertigstellen von '%s'."
 
 #: sequencer.c:279 builtin/am.c:259 builtin/commit.c:749 builtin/merge.c:1032
 #, c-format
 msgid "could not read '%s'"
 msgstr "Konnte '%s' nicht lesen"
 
 #: sequencer.c:305
-#, fuzzy, c-format
+#, c-format
 msgid "your local changes would be overwritten by %s."
-msgstr "Ihre lokalen Änderungen würden durch den Revert überschrieben werden."
+msgstr "Ihre lokalen Änderungen würden durch den %s überschrieben werden."
 
 #: sequencer.c:309
-#, fuzzy
 msgid "commit your changes or stash them to proceed."
 msgstr ""
 "Committen Sie Ihre Änderungen oder benutzen Sie \"stash\", um fortzufahren."
 
 #: sequencer.c:324
 #, c-format
 msgid "%s: fast-forward"
 msgstr "%s: Vorspulen"
 
 #. TRANSLATORS: %s will be "revert" or "cherry-pick"
 #: sequencer.c:399
 #, c-format
 msgid "%s: Unable to write new index file"
 msgstr "%s: Konnte neue Index-Datei nicht schreiben"
 
 #: sequencer.c:418
-#, fuzzy
 msgid "could not resolve HEAD commit\n"
-msgstr "Konnte Commit von HEAD nicht auflösen\n"
+msgstr "Konnte HEAD-Commit nicht auflösen\n"
 
 #: sequencer.c:438
-#, fuzzy
 msgid "unable to update cache tree\n"
 msgstr "Konnte Cache-Verzeichnis nicht aktualisieren\n"
 
 #: sequencer.c:483
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "you have staged changes in your working tree\n"
 "If these changes are meant to be squashed into the previous commit, run:\n"
 "\n"
 "  git commit --amend %s\n"
 "\n"
 "If they are meant to go into a new commit, run:\n"
 "\n"
 "  git commit %s\n"
 "\n"
 "In both cases, once you're done, continue with:\n"
 "\n"
 "  git rebase --continue\n"
 msgstr ""
-"Es befinden sich zum Commit vorgemerkte Änderungen in Ihrem "
-"Arbeitsverzeichnis.\n"
+"Es befinden sich zum Commit vorgemerkte Änderungen in Ihrem Arbeitsverzeichnis.\n"
 "Wenn diese Änderungen in den vorherigen Commit aufgenommen werden sollen,\n"
 "führen Sie aus:\n"
 "\n"
-"  git commit --amend $gpg_sign_opt_quoted\n"
+"  git commit --amend %s\n"
 "\n"
 "Wenn daraus ein neuer Commit erzeugt werden soll, führen Sie aus:\n"
 "\n"
-"  git commit $gpg_sign_opt_quoted\n"
+"  git commit %s\n"
 "\n"
 "Im Anschluss führen Sie zum Fortfahren aus:\n"
 "\n"
 "  git rebase --continue\n"
 
 #: sequencer.c:567
-#, fuzzy, c-format
+#, c-format
 msgid "could not parse commit %s\n"
 msgstr "Konnte Commit %s nicht parsen\n"
 
 #: sequencer.c:572
-#, fuzzy, c-format
+#, c-format
 msgid "could not parse parent commit %s\n"
 msgstr "Konnte Eltern-Commit %s nicht parsen\n"
 
 #: sequencer.c:656
-#, fuzzy
 msgid "your index file is unmerged."
 msgstr "Ihre Index-Datei ist nicht zusammengeführt."
 
 #: sequencer.c:675
-#, fuzzy, c-format
+#, c-format
 msgid "commit %s is a merge but no -m option was given."
 msgstr "Commit %s ist ein Merge, aber die Option -m wurde nicht angegeben."
 
 #: sequencer.c:683
-#, fuzzy, c-format
+#, c-format
 msgid "commit %s does not have parent %d"
-msgstr "Commit %s hat keinen Elternteil %d"
+msgstr "Commit %s hat keinen Eltern-Commit %d"
 
 #: sequencer.c:687
-#, fuzzy, c-format
+#, c-format
 msgid "mainline was specified but commit %s is not a merge."
 msgstr "Hauptlinie wurde spezifiziert, aber Commit %s ist kein Merge."
 
 #. TRANSLATORS: The first %s will be a "todo" command like
 #. "revert" or "pick", the second %s a SHA1.
 #: sequencer.c:700
 #, c-format
 msgid "%s: cannot parse parent commit %s"
 msgstr "%s: kann Eltern-Commit %s nicht parsen"
 
 #: sequencer.c:705
-#, fuzzy, c-format
+#, c-format
 msgid "cannot get commit message for %s"
-msgstr "Kann keine Commit-Beschreibung für %s bekommen"
+msgstr "Kann keine Commit-Beschreibung für %s bekommen."
 
 #: sequencer.c:797
 #, c-format
 msgid "could not revert %s... %s"
 msgstr "Konnte \"revert\" nicht auf %s... (%s) ausführen"
 
 #: sequencer.c:798
 #, c-format
 msgid "could not apply %s... %s"
 msgstr "Konnte %s... (%s) nicht anwenden"
 
 #: sequencer.c:833
@@ -2819,129 +2832,124 @@ msgstr "leere Menge von Commits übergeben"
 
 #: sequencer.c:843
 #, c-format
 msgid "git %s: failed to read the index"
 msgstr "git %s: Fehler beim Lesen des Index"
 
 #: sequencer.c:850
 #, c-format
 msgid "git %s: failed to refresh the index"
 msgstr "git %s: Fehler beim Aktualisieren des Index"
 
 #: sequencer.c:944
-#, fuzzy, c-format
+#, c-format
 msgid "invalid line %d: %.*s"
-msgstr "Ungültige Identifikationszeile: %s"
+msgstr "Ungültige Zeile %d: %.*s"
 
 #: sequencer.c:950
-#, fuzzy
 msgid "no commits parsed."
 msgstr "Keine Commits geparst."
 
 #: sequencer.c:966
-#, fuzzy, c-format
+#, c-format
 msgid "could not read '%s'."
-msgstr "Konnte '%s' nicht lesen"
+msgstr "Konnte '%s' nicht lesen."
 
 #: sequencer.c:972
-#, fuzzy, c-format
+#, c-format
 msgid "unusable instruction sheet: '%s'"
-msgstr "Unbenutzbares Instruktionsblatt: %s"
+msgstr "Unbenutzbares Instruktionsblatt: '%s'"
 
 #: sequencer.c:983
-#, fuzzy
 msgid "cannot cherry-pick during a revert."
 msgstr "Kann Cherry-Pick nicht während eines Reverts ausführen."
 
 #: sequencer.c:985
-#, fuzzy
 msgid "cannot revert during a cherry-pick."
 msgstr "Kann Revert nicht während eines Cherry-Picks ausführen."
 
 #: sequencer.c:1028
-#, fuzzy, c-format
+#, c-format
 msgid "invalid key: %s"
 msgstr "Ungültiger Schlüssel: %s"
 
 #: sequencer.c:1031
-#, fuzzy, c-format
+#, c-format
 msgid "invalid value for %s: %s"
 msgstr "Ungültiger Wert für %s: %s"
 
 #: sequencer.c:1063
-#, fuzzy, c-format
+#, c-format
 msgid "malformed options sheet: '%s'"
-msgstr "Fehlerhaftes Optionsblatt: %s"
+msgstr "Fehlerhaftes Optionsblatt: '%s'"
 
 #: sequencer.c:1101
 msgid "a cherry-pick or revert is already in progress"
 msgstr "\"cherry-pick\" oder \"revert\" ist bereits im Gang"
 
 #: sequencer.c:1102
 msgid "try \"git cherry-pick (--continue | --quit | --abort)\""
 msgstr "versuchen Sie \"git cherry-pick (--continue | --quit | --abort)\""
 
 #: sequencer.c:1106
-#, fuzzy, c-format
+#, c-format
 msgid "could not create sequencer directory '%s'"
-msgstr "Konnte \"sequencer\"-Verzeichnis %s nicht erstellen"
+msgstr "Konnte \"sequencer\"-Verzeichnis '%s' nicht erstellen."
 
 #: sequencer.c:1120
-#, fuzzy
 msgid "could not lock HEAD"
-msgstr "Konnte HEAD nicht loslösen"
+msgstr "Konnte HEAD nicht sperren"
 
 #: sequencer.c:1151 sequencer.c:1289
 msgid "no cherry-pick or revert in progress"
 msgstr "kein \"cherry-pick\" oder \"revert\" im Gang"
 
 #: sequencer.c:1153
 msgid "cannot resolve HEAD"
 msgstr "kann HEAD nicht auflösen"
 
 #: sequencer.c:1155 sequencer.c:1189
 msgid "cannot abort from a branch yet to be born"
 msgstr "kann nicht abbrechen: bin auf einem Branch, der noch geboren wird"
 
 #: sequencer.c:1175 builtin/grep.c:578
 #, c-format
 msgid "cannot open '%s'"
 msgstr "kann '%s' nicht öffnen"
 
 #: sequencer.c:1177
-#, fuzzy, c-format
+#, c-format
 msgid "cannot read '%s': %s"
-msgstr "Kann %s nicht lesen: %s"
+msgstr "Kann '%s' nicht lesen: %s"
 
 #: sequencer.c:1178
 msgid "unexpected end of file"
 msgstr "Unerwartetes Dateiende"
 
 #: sequencer.c:1184
 #, c-format
 msgid "stored pre-cherry-pick HEAD file '%s' is corrupt"
 msgstr "gespeicherte \"pre-cherry-pick\" HEAD Datei '%s' ist beschädigt"
 
 #: sequencer.c:1354
 #, c-format
 msgid "%s: can't cherry-pick a %s"
 msgstr "%s: %s kann nicht in \"cherry-pick\" benutzt werden"
 
 #: sequencer.c:1358
 #, c-format
 msgid "%s: bad revision"
 msgstr "%s: ungültiger Commit"
 
 #: sequencer.c:1391
-#, fuzzy
 msgid "can't revert as initial commit"
 msgstr "Kann nicht als allerersten Commit einen Revert ausführen."
 
 #: setup.c:160
 #, c-format
 msgid ""
 "%s: no such path in the working tree.\n"
 "Use 'git <command> -- <path>...' to specify paths that do not exist locally."
 msgstr ""
 "%s: kein solcher Pfad im Arbeitsverzeichnis.\n"
 "Benutzen Sie 'git <Befehl> -- <Pfad>...' zur Angabe von Pfaden, die lokal\n"
 "nicht existieren."
@@ -3007,27 +3015,27 @@ msgid "Cannot change to '%s/..'"
 msgstr "Kann nicht in Verzeichnis '%s/..' wechseln"
 
 #: setup.c:989
 #, c-format
 msgid ""
 "Problem with core.sharedRepository filemode value (0%.3o).\n"
 "The owner of files must always have read and write permissions."
 msgstr ""
 "Problem mit Wert für Dateimodus (0%.3o) von core.sharedRepository.\n"
 "Der Besitzer der Dateien muss immer Lese- und Schreibrechte haben."
 
 #: sha1_file.c:473
-#, fuzzy, c-format
+#, c-format
 msgid "path '%s' does not exist"
-msgstr "Branch '%s' existiert nicht"
+msgstr "Pfad '%s' existiert nicht"
 
 #: sha1_file.c:499
 #, c-format
 msgid "reference repository '%s' as a linked checkout is not supported yet."
 msgstr ""
 "Referenziertes Repository '%s' wird noch nicht als verknüpftes\n"
 "Arbeitsverzeichnis unterstützt."
 
 #: sha1_file.c:505
 #, c-format
 msgid "reference repository '%s' is not a local repository."
 msgstr "Referenziertes Repository '%s' ist kein lokales Repository."
@@ -3053,30 +3061,29 @@ msgstr "Offset vor Ende der Packdatei (fehlerhafte Indexdatei?)"
 #, c-format
 msgid "offset before start of pack index for %s (corrupt index?)"
 msgstr "Offset vor Beginn des Pack-Index für %s (beschädigter Index?)"
 
 #: sha1_file.c:2596
 #, c-format
 msgid "offset beyond end of pack index for %s (truncated index?)"
 msgstr "Offset hinter Ende des Pack-Index für %s (abgeschnittener Index?)"
 
 #: sha1_name.c:407
 #, c-format
 msgid "short SHA1 %s is ambiguous"
-msgstr ""
+msgstr "Kurzer SHA-1 %s ist mehrdeutig."
 
 #: sha1_name.c:418
-#, fuzzy
 msgid "The candidates are:"
-msgstr "Die allgemein verwendeten Git-Anleitungen sind:\n"
+msgstr "Die Kandidaten sind:"
 
 #: sha1_name.c:578
 msgid ""
 "Git normally never creates a ref that ends with 40 hex characters\n"
 "because it will be ignored when you just specify 40-hex. These refs\n"
 "may be created by mistake. For example,\n"
 "\n"
 "  git checkout -b $br $(git rev-parse ...)\n"
 "\n"
 "where \"$br\" is somehow empty and a 40-hex ref is created. Please\n"
 "examine these refs and maybe delete them. Turn this message off by\n"
 "running \"git config advice.objectNameWarning false\""
@@ -3229,40 +3236,38 @@ msgstr ""
 "\n"
 
 #: transport.c:829
 msgid "Aborting."
 msgstr "Abbruch."
 
 #: transport-helper.c:1075
 #, c-format
 msgid "Could not read ref %s"
 msgstr "Konnte Referenz %s nicht lesen."
 
 #: tree-walk.c:31
-#, fuzzy
 msgid "too-short tree object"
-msgstr "unerreichbare Objekte anzeigen"
+msgstr "zu kurzes Tree-Objekt"
 
 #: tree-walk.c:37
-#, fuzzy
 msgid "malformed mode in tree entry"
-msgstr "Missgebildeter Objektname %s"
+msgstr "fehlerhafter Modus in Tree-Eintrag"
 
 #: tree-walk.c:41
 msgid "empty filename in tree entry"
-msgstr ""
+msgstr "leerer Dateiname in Tree-Eintrag"
 
 #: tree-walk.c:113
 msgid "too-short tree file"
-msgstr ""
+msgstr "zu kurze Tree-Datei"
 
 #: unpack-trees.c:64
 #, c-format
 msgid ""
 "Your local changes to the following files would be overwritten by checkout:\n"
 "%%sPlease commit your changes or stash them before you switch branches."
 msgstr ""
 "Ihre lokalen Änderungen in den folgenden Dateien würden beim Auschecken\n"
 "überschrieben werden:\n"
 "%%sBitte committen oder stashen Sie Ihre Änderungen, bevor Sie Branches\n"
 "wechseln."
 
@@ -3459,43 +3464,43 @@ msgstr "Eintrag '%s' überschneidet sich mit '%s'. Kann nicht verbinden."
 #: unpack-trees.c:124
 #, c-format
 msgid ""
 "Cannot update sparse checkout: the following entries are not up-to-date:\n"
 "%s"
 msgstr ""
 "Kann partiellen Checkout nicht aktualisieren: die folgenden Einträge sind "
 "nicht\n"
 "aktuell:\n"
 "%s"
 
 #: unpack-trees.c:126
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following working tree files would be overwritten by sparse checkout "
 "update:\n"
 "%s"
 msgstr ""
-"Die folgenden Dateien im Arbeitsbereich würden durch die Aktualisierung\n"
-"des partiellen Checkouts überschrieben werden:\n"
+"Die folgenden Dateien im Arbeitsverzeichnis würden durch die Aktualisierung\n"
+"über einen partiellen Checkout überschrieben werden:\n"
 "%s"
 
 #: unpack-trees.c:128
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following working tree files would be removed by sparse checkout "
 "update:\n"
 "%s"
 msgstr ""
-"Die folgenden Dateien im Arbeitsbereich würden durch die Aktualisierung\n"
-"des partiellen Checkouts entfernt werden:\n"
+"Die folgenden Dateien im Arbeitsverzeichnis würden durch die Aktualisierung\n"
+"über einen partiellen Checkout entfernt werden:\n"
 "%s"
 
 #: unpack-trees.c:205
 #, c-format
 msgid "Aborting\n"
 msgstr "Abbruch\n"
 
 #: unpack-trees.c:237
 msgid "Checking out files"
 msgstr "Checke Dateien aus"
 
 #: urlmatch.c:120
@@ -4054,41 +4059,36 @@ msgid "gone"
 msgstr "entfernt"
 
 #: wt-status.c:1763 wt-status.c:1771
 msgid "behind "
 msgstr "hinterher "
 
 #: wt-status.c:1766 wt-status.c:1769
 msgid "ahead "
 msgstr "voraus "
 
 #. TRANSLATORS: the action is e.g. "pull with rebase"
 #: wt-status.c:2270
-#, fuzzy, c-format
+#, c-format
 msgid "cannot %s: You have unstaged changes."
-msgstr ""
-"Rebase nicht möglich: Sie haben Änderungen, die nicht zum Commit vorgemerkt "
-"sind."
+msgstr "%s nicht möglich: Sie haben Änderungen, die nicht zum Commit vorgemerkt sind."
 
 #: wt-status.c:2276
-#, fuzzy
 msgid "additionally, your index contains uncommitted changes."
-msgstr "Zusätzlich beinhaltet die Staging-Area nicht committete Änderungen."
+msgstr "Zusätzlich enthält die Staging-Area nicht committete Änderungen."
 
 #: wt-status.c:2278
-#, fuzzy, c-format
+#, c-format
 msgid "cannot %s: Your index contains uncommitted changes."
-msgstr ""
-"Rebase nicht möglich: Die Staging-Area beinhaltet nicht committete "
-"Änderungen."
+msgstr "%s nicht möglich: Die Staging-Area enthält nicht committete Änderungen."
 
 #: compat/precompose_utf8.c:57 builtin/clone.c:414
 #, c-format
 msgid "failed to unlink '%s'"
 msgstr "Konnte '%s' nicht entfernen."
 
 #: builtin/add.c:22
 msgid "git add [<options>] [--] <pathspec>..."
 msgstr "git add [<Optionen>] [--] <Pfadspezifikation>..."
 
 #: builtin/add.c:80
 #, c-format
@@ -4464,27 +4464,26 @@ msgid ""
 "You seem to have moved HEAD since the last 'am' failure.\n"
 "Not rewinding to ORIG_HEAD"
 msgstr ""
 "Sie scheinen seit dem letzten gescheiterten 'am' HEAD geändert zu haben.\n"
 "Keine Zurücksetzung zu ORIG_HEAD."
 
 #: builtin/am.c:2200
 #, c-format
 msgid "Invalid value for --patch-format: %s"
 msgstr "Ungültiger Wert für --patch-format: %s"
 
 #: builtin/am.c:2233
-#, fuzzy
 msgid "git am [<options>] [(<mbox> | <Maildir>)...]"
-msgstr "git am [<Optionen>] [(<mbox>|<E-Mail-Verzeichnis>)...]"
+msgstr "git am [<Optionen>] [(<mbox> | <E-Mail-Verzeichnis>)...]"
 
 #: builtin/am.c:2234
 msgid "git am [<options>] (--continue | --skip | --abort)"
 msgstr "git am [<Optionen>] (--continue | --skip | --abort)"
 
 #: builtin/am.c:2240
 msgid "run interactively"
 msgstr "interaktiv ausführen"
 
 #: builtin/am.c:2242
 msgid "historical option -- no-op"
 msgstr "historische Option -- kein Effekt"
@@ -4749,28 +4748,32 @@ msgstr "Den Namen des Autors und den Zeitstempel unterdrücken (Standard: aus)"
 #: builtin/blame.c:2591
 msgid "Show author email instead of name (Default: off)"
 msgstr ""
 "Anstatt des Namens die E-Mail-Adresse des Autors anzeigen (Standard: aus)"
 
 #: builtin/blame.c:2592
 msgid "Ignore whitespace differences"
 msgstr "Unterschiede im Whitespace ignorieren"
 
 #: builtin/blame.c:2599
 msgid "Use an experimental indent-based heuristic to improve diffs"
 msgstr ""
+"eine experimentelle, auf Einrückungen basierende Heuristik zur Verbesserung\n"
+"der Darstellung von Unterschieden verwenden"
 
 #: builtin/blame.c:2600
 msgid "Use an experimental blank-line-based heuristic to improve diffs"
 msgstr ""
+"eine experimentelle, auf Leerzeilen basierende Heuristik zur Verbesserung\n"
+"der Darstellung von Unterschieden verwenden"
 
 #: builtin/blame.c:2602
 msgid "Spend extra cycles to find better match"
 msgstr "Länger arbeiten, um bessere Übereinstimmungen zu finden"
 
 #: builtin/blame.c:2603
 msgid "Use revisions from <file> instead of calling git-rev-list"
 msgstr "Commits von <Datei> benutzen, anstatt \"git-rev-list\" aufzurufen"
 
 #: builtin/blame.c:2604
 msgid "Use <file>'s contents as the final image"
 msgstr "Inhalte der <Datei>en als endgültiges Abbild benutzen"
@@ -4787,72 +4790,76 @@ msgstr "kopierte Zeilen innerhalb oder zwischen Dateien finden"
 msgid "Find line movements within and across files"
 msgstr "verschobene Zeilen innerhalb oder zwischen Dateien finden"
 
 #: builtin/blame.c:2607
 msgid "n,m"
 msgstr "n,m"
 
 #: builtin/blame.c:2607
 msgid "Process only line range n,m, counting from 1"
 msgstr "nur Zeilen im Bereich n,m verarbeiten, gezählt von 1"
 
 #: builtin/blame.c:2654
-#, fuzzy
 msgid "--progress can't be used with --incremental or porcelain formats"
-msgstr "Tags versenden (kann nicht mit --all oder --mirror verwendet werden)"
+msgstr ""
+"--progress kann nicht mit --incremental oder Formaten für Fremdprogramme\n"
+"verwendet werden"
 
 #. TRANSLATORS: This string is used to tell us the maximum
 #. display width for a relative timestamp in "git blame"
 #. output.  For C locale, "4 years, 11 months ago", which
 #. takes 22 places, is the longest among various forms of
 #. relative timestamps, but your language may need more or
 #. fewer display columns.
 #: builtin/blame.c:2700
 msgid "4 years, 11 months ago"
 msgstr "vor 4 Jahren, und 11 Monaten"
 
 #: builtin/blame.c:2780
-#, fuzzy
 msgid "--contents and --reverse do not blend well."
-msgstr "Die Optionen --column und --verbose sind inkompatibel."
+msgstr "--contents und --reverse funktionieren gemeinsam nicht."
 
 #: builtin/blame.c:2800
 msgid "cannot use --contents with final commit object name"
-msgstr ""
+msgstr "kann --contents nicht mit endgültigem Namen des Commit-Objektes benutzen"
 
 #: builtin/blame.c:2805
 msgid "--reverse and --first-parent together require specified latest commit"
 msgstr ""
+"--reverse und --first-parent zusammen erfordern die Angabe eines endgültigen\n"
+"Commits"
 
 #: builtin/blame.c:2832
 msgid ""
 "--reverse --first-parent together require range along first-parent chain"
 msgstr ""
+"--reverse und --first-parent zusammen erfordern einen Bereich entlang der\n"
+"\"first-parent\"-Kette"
 
 #: builtin/blame.c:2843
-#, fuzzy, c-format
+#, c-format
 msgid "no such path %s in %s"
-msgstr "Kein solcher Branch '%s'"
+msgstr "Pfad %s nicht in %s"
 
 #: builtin/blame.c:2854
-#, fuzzy, c-format
+#, c-format
 msgid "cannot read blob %s for path %s"
-msgstr "kann Objekt %s '%s' nicht lesen"
+msgstr "kann Blob %s für Pfad '%s' nicht lesen"
 
 #: builtin/blame.c:2873
 #, c-format
 msgid "file %s has only %lu line"
 msgid_plural "file %s has only %lu lines"
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "Datei %s hat nur %lu Zeile"
+msgstr[1] "Datei %s hat nur %lu Zeilen"
 
 #: builtin/branch.c:26
 msgid "git branch [<options>] [-r | -a] [--merged | --no-merged]"
 msgstr "git branch [<Optionen>] [-r | -a] [--merged | --no-merged]"
 
 #: builtin/branch.c:27
 msgid "git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"
 msgstr "git branch [<Optionen>] [-l] [-f] <Branchname> [<Startpunkt>]"
 
 #: builtin/branch.c:28
 msgid "git branch [<options>] [-r] (-d | -D) <branch-name>..."
 msgstr "git branch [<Optionen>] [-r] (-d | -D) <Branchname>..."
@@ -5088,27 +5095,26 @@ msgstr "den Übernahmemodus einstellen (siehe git-pull(1))"
 msgid "change upstream info"
 msgstr "Informationen zum Upstream-Branch ändern"
 
 #: builtin/branch.c:659
 msgid "upstream"
 msgstr "Upstream"
 
 #: builtin/branch.c:659
 msgid "change the upstream info"
 msgstr "Informationen zum Upstream-Branch ändern"
 
 #: builtin/branch.c:660
-#, fuzzy
 msgid "Unset the upstream info"
-msgstr "Informationen zum Upstream-Branch ändern"
+msgstr "Informationen zum Upstream-Branch entfernen"
 
 #: builtin/branch.c:661
 msgid "use colored output"
 msgstr "farbige Ausgaben verwenden"
 
 #: builtin/branch.c:662
 msgid "act on remote-tracking branches"
 msgstr "auf Remote-Tracking-Branches wirken"
 
 #: builtin/branch.c:664 builtin/branch.c:665
 msgid "print only branches that contain the commit"
 msgstr "nur Branches ausgeben, welche diesen Commit beinhalten"
@@ -5295,38 +5301,34 @@ msgstr ""
 msgid "%s is okay\n"
 msgstr "%s ist in Ordnung\n"
 
 #: builtin/bundle.c:64
 msgid "Need a repository to create a bundle."
 msgstr "Um ein Paket zu erstellen wird ein Repository benötigt."
 
 #: builtin/bundle.c:68
 msgid "Need a repository to unbundle."
 msgstr "Zum Entpacken wird ein Repository benötigt."
 
 #: builtin/cat-file.c:513
-#, fuzzy
 msgid ""
 "git cat-file (-t [--allow-unknown-type] | -s [--allow-unknown-type] | -e | -"
 "p | <type> | --textconv | --filters) [--path=<path>] <object>"
-msgstr ""
-"git cat-file (-t [--allow-unknown-type]|-s [--allow-unknown-type]|-e|-p|"
-"<Art>|--textconv) <Objekt>"
+msgstr "git cat-file (-t [--allow-unknown-type] | -s [--allow-unknown-type] | -e | -p | <Art> | --textconv | --filters) [--path=<Pfad>] <Objekt>"
 
 #: builtin/cat-file.c:514
-#, fuzzy
 msgid ""
 "git cat-file (--batch | --batch-check) [--follow-symlinks] [--textconv | --"
 "filters]"
-msgstr "git cat-file (--batch | --batch-check) [--follow-symlinks]"
+msgstr "git cat-file (--batch | --batch-check) [--follow-symlinks] [--textconv | --filters]"
 
 #: builtin/cat-file.c:551
 msgid "<type> can be one of: blob, tree, commit, tag"
 msgstr "<Art> kann sein: blob, tree, commit, tag"
 
 #: builtin/cat-file.c:552
 msgid "show object type"
 msgstr "Objektart anzeigen"
 
 #: builtin/cat-file.c:553
 msgid "show object size"
 msgstr "Objektgröße anzeigen"
@@ -5335,35 +5337,34 @@ msgstr "Objektgröße anzeigen"
 msgid "exit with zero when there's no error"
 msgstr "mit Rückgabewert 0 beenden, wenn kein Fehler aufgetreten ist"
 
 #: builtin/cat-file.c:556
 msgid "pretty-print object's content"
 msgstr "ansprechende Anzeige des Objektinhaltes"
 
 #: builtin/cat-file.c:558
 msgid "for blob objects, run textconv on object's content"
 msgstr "eine Textkonvertierung auf den Inhalt von Blob-Objekten ausführen"
 
 #: builtin/cat-file.c:560
-#, fuzzy
 msgid "for blob objects, run filters on object's content"
-msgstr "eine Textkonvertierung auf den Inhalt von Blob-Objekten ausführen"
+msgstr "für Blob-Objekte, Filter auf Objekt-Inhalte ausführen"
 
 #: builtin/cat-file.c:561 git-submodule.sh:923
 msgid "blob"
 msgstr "Blob"
 
 #: builtin/cat-file.c:562
 msgid "use a specific path for --textconv/--filters"
-msgstr ""
+msgstr "einen bestimmten Pfad für --textconv/--filters verwenden"
 
 #: builtin/cat-file.c:564
 msgid "allow -s and -t to work with broken/corrupt objects"
 msgstr "-s und -t mit beschädigten Objekten erlauben"
 
 #: builtin/cat-file.c:565
 msgid "buffer --batch output"
 msgstr "Ausgabe von --batch puffern"
 
 #: builtin/cat-file.c:567
 msgid "show info and content of objects fed from the standard input"
 msgstr ""
@@ -6098,39 +6099,38 @@ msgstr "Tiefe"
 
 #: builtin/clone.c:98
 msgid "create a shallow clone of that depth"
 msgstr ""
 "einen Klon mit unvollständiger Historie (shallow) in dieser Tiefe erstellen"
 
 #: builtin/clone.c:99 builtin/fetch.c:122 builtin/pack-objects.c:2848
 #: parse-options.h:142
 msgid "time"
 msgstr "Zeit"
 
 #: builtin/clone.c:100
-#, fuzzy
 msgid "create a shallow clone since a specific time"
 msgstr ""
-"einen Klon mit unvollständiger Historie (shallow) in dieser Tiefe erstellen"
+"einen Klon mit unvollständiger Historie (shallow) seit einer bestimmten Zeit\n"
+"erstellen"
 
 #: builtin/clone.c:101 builtin/fetch.c:124
-#, fuzzy
 msgid "revision"
-msgstr "%s: ungültiger Commit"
+msgstr "Commit"
 
 #: builtin/clone.c:102 builtin/fetch.c:125
-#, fuzzy
 msgid "deepen history of shallow clone by excluding rev"
 msgstr ""
-"die Historie eines Klons mit unvollständiger Historie (shallow) vertiefen"
+"die Historie eines Klons mit unvollständiger Historie (shallow) mittels\n"
+"Ausschluss eines Commits vertiefen"
 
 #: builtin/clone.c:104
 msgid "clone only one branch, HEAD or --branch"
 msgstr "nur einen Branch klonen, HEAD oder --branch"
 
 #: builtin/clone.c:106
 msgid "any cloned submodules will be shallow"
 msgstr "jedes geklonte Submodul mit unvollständiger Historie (shallow)"
 
 #: builtin/clone.c:107 builtin/init-db.c:484
 msgid "gitdir"
 msgstr ".git-Verzeichnis"
@@ -6155,27 +6155,27 @@ msgstr "nur IPv4-Adressen benutzen"
 msgid "use IPv6 addresses only"
 msgstr "nur IPv6-Adressen benutzen"
 
 #: builtin/clone.c:250
 msgid ""
 "No directory name could be guessed.\n"
 "Please specify a directory on the command line"
 msgstr ""
 "Konnte keinen Verzeichnisnamen erraten.\n"
 "Bitte geben Sie ein Verzeichnis auf der Befehlszeile an."
 
 #: builtin/clone.c:303
-#, fuzzy, c-format
+#, c-format
 msgid "info: Could not add alternate for '%s': %s\n"
-msgstr "Kann \"reflog\" für '%s' nicht durchführen: %s\n"
+msgstr "info: Konnte Alternative für '%s' nicht hinzufügen: %s\n"
 
 #: builtin/clone.c:375
 #, c-format
 msgid "failed to open '%s'"
 msgstr "Fehler beim Öffnen von '%s'"
 
 #: builtin/clone.c:383
 #, c-format
 msgid "%s exists and is not a directory"
 msgstr "%s existiert und ist kein Verzeichnis"
 
 #: builtin/clone.c:397
@@ -6297,45 +6297,39 @@ msgstr "Konnte Arbeitsverzeichnis '%s' nicht erstellen"
 msgid "Cloning into bare repository '%s'...\n"
 msgstr "Klone in Bare-Repository '%s' ...\n"
 
 #: builtin/clone.c:957
 #, c-format
 msgid "Cloning into '%s'...\n"
 msgstr "Klone nach '%s' ...\n"
 
 #: builtin/clone.c:963
 msgid ""
 "clone --recursive is not compatible with both --reference and --reference-if-"
 "able"
-msgstr ""
+msgstr "'clone --recursive' ist nicht kompatibel mit --reference und --reference-if-able"
 
 #: builtin/clone.c:1019
 msgid "--depth is ignored in local clones; use file:// instead."
 msgstr ""
 "Die Option --depth wird in lokalen Klonen ignoriert; benutzen Sie "
 "stattdessen file://"
 
 #: builtin/clone.c:1021
-#, fuzzy
 msgid "--shallow-since is ignored in local clones; use file:// instead."
-msgstr ""
-"Die Option --depth wird in lokalen Klonen ignoriert; benutzen Sie "
-"stattdessen file://"
+msgstr "--shallow-since wird in lokalen Klonen ignoriert; benutzen Sie stattdessen file://"
 
 #: builtin/clone.c:1023
-#, fuzzy
 msgid "--shallow-exclude is ignored in local clones; use file:// instead."
-msgstr ""
-"Die Option --depth wird in lokalen Klonen ignoriert; benutzen Sie "
-"stattdessen file://"
+msgstr "--shallow-exclude wird in lokalen Klonen ignoriert; benutzen Sie stattdessen file://"
 
 #: builtin/clone.c:1026
 msgid "source repository is shallow, ignoring --local"
 msgstr ""
 "Quelle ist ein Repository mit unvollständiger Historie (shallow),ignoriere --"
 "local"
 
 #: builtin/clone.c:1031
 msgid "--local is ignored"
 msgstr "--local wird ignoriert"
 
 #: builtin/clone.c:1035
@@ -6753,27 +6747,26 @@ msgstr "Ungültiger \"cleanup\" Modus %s"
 msgid "Paths with -a does not make sense."
 msgstr "Die Option -a kann nicht mit der Angabe von Pfaden verwendet werden."
 
 #: builtin/commit.c:1341 builtin/commit.c:1617
 msgid "show status concisely"
 msgstr "Status im Kurzformat anzeigen"
 
 #: builtin/commit.c:1343 builtin/commit.c:1619
 msgid "show branch information"
 msgstr "Branchinformationen anzeigen"
 
 #: builtin/commit.c:1345
-#, fuzzy
 msgid "version"
-msgstr "Berechtigungen"
+msgstr "Version"
 
 #: builtin/commit.c:1345 builtin/commit.c:1621 builtin/push.c:522
 #: builtin/worktree.c:440
 msgid "machine-readable output"
 msgstr "maschinenlesbare Ausgabe"
 
 #: builtin/commit.c:1348 builtin/commit.c:1623
 msgid "show status in long format (default)"
 msgstr "Status im Langformat anzeigen (Standard)"
 
 #: builtin/commit.c:1351 builtin/commit.c:1626
 msgid "terminate entries with NUL"
@@ -7168,24 +7161,27 @@ msgstr ""
 
 #: builtin/config.c:613
 #, c-format
 msgid "cannot create configuration file %s"
 msgstr "Konnte Konfigurationsdatei '%s' nicht erstellen."
 
 #: builtin/config.c:625
 #, c-format
 msgid ""
 "cannot overwrite multiple values with a single value\n"
 "       Use a regexp, --add or --replace-all to change %s."
 msgstr ""
+"kann nicht mehrere Werte mit einem einzigen Wert überschreiben\n"
+"       Benutzen Sie einen regulären Ausdruck, --add oder --replace, um %s\n"
+"       zu ändern."
 
 #: builtin/count-objects.c:86
 msgid "git count-objects [-v] [-H | --human-readable]"
 msgstr "git count-objects [-v] [-H | --human-readable]"
 
 #: builtin/count-objects.c:96
 msgid "print sizes in human readable format"
 msgstr "gibt Größenangaben in menschenlesbaren Format aus"
 
 #: builtin/describe.c:17
 msgid "git describe [<options>] [<commit-ish>...]"
 msgstr "git describe [<Optionen>] [<Commit-Angabe>...]"
@@ -7476,28 +7472,28 @@ msgid "keep downloaded pack"
 msgstr "heruntergeladenes Paket behalten"
 
 #: builtin/fetch.c:118
 msgid "allow updating of HEAD ref"
 msgstr "Aktualisierung der \"HEAD\"-Referenz erlauben"
 
 #: builtin/fetch.c:121 builtin/fetch.c:127 builtin/pull.c:203
 msgid "deepen history of shallow clone"
 msgstr ""
 "die Historie eines Klons mit unvollständiger Historie (shallow) vertiefen"
 
 #: builtin/fetch.c:123
-#, fuzzy
 msgid "deepen history of shallow repository based on time"
 msgstr ""
-"die Historie eines Klons mit unvollständiger Historie (shallow) vertiefen"
+"die Historie eines Klons mit unvollständiger Historie (shallow) auf Zeitbasis\n"
+"vertiefen"
 
 #: builtin/fetch.c:129 builtin/pull.c:206
 msgid "convert to a complete repository"
 msgstr "zu einem vollständigen Repository konvertieren"
 
 #: builtin/fetch.c:131 builtin/log.c:1433
 msgid "dir"
 msgstr "Verzeichnis"
 
 #: builtin/fetch.c:132
 msgid "prepend this to submodule path output"
 msgstr "dies an die Ausgabe der Submodul-Pfade voranstellen"
@@ -7655,30 +7651,29 @@ msgid ""
 "remote name from which new revisions should be fetched."
 msgstr ""
 "Kein Remote-Repository angegeben. Bitte geben Sie entweder eine URL\n"
 "oder den Namen des Remote-Repositories an, von welchem neue\n"
 "Commits angefordert werden sollen."
 
 #: builtin/fetch.c:1280
 msgid "You need to specify a tag name."
 msgstr "Sie müssen den Namen des Tags angeben."
 
 #: builtin/fetch.c:1322
 msgid "Negative depth in --deepen is not supported"
-msgstr ""
+msgstr "Negative Tiefe wird von --deepen nicht unterstützt."
 
 #: builtin/fetch.c:1324
-#, fuzzy
 msgid "--deepen and --depth are mutually exclusive"
-msgstr "-b, -B und --detach schließen sich gegenseitig aus"
+msgstr "--deepen und --depth schließen sich gegenseitig aus"
 
 #: builtin/fetch.c:1329
 msgid "--depth and --unshallow cannot be used together"
 msgstr ""
 "Die Optionen --depth und --unshallow können nicht gemeinsam verwendet werden."
 
 #: builtin/fetch.c:1331
 msgid "--unshallow on a complete repository does not make sense"
 msgstr ""
 "Die Option --unshallow kann nicht in einem Repository mit unvollständiger "
 "Historie verwendet werden."
 
@@ -8208,25 +8203,25 @@ msgstr ""
 "Fehlersuche in Git, erzeugen"
 
 #: builtin/hash-object.c:101
 msgid "process file as it were from this path"
 msgstr "Datei verarbeiten, als ob sie von diesem Pfad wäre"
 
 #: builtin/help.c:42
 msgid "print all available commands"
 msgstr "alle vorhandenen Befehle anzeigen"
 
 #: builtin/help.c:43
 msgid "exclude guides"
-msgstr ""
+msgstr "Anleitungen ausschließen"
 
 #: builtin/help.c:44
 msgid "print list of useful guides"
 msgstr "Liste von allgemein verwendeten Anleitungen anzeigen"
 
 #: builtin/help.c:45
 msgid "show man page"
 msgstr "Handbuch anzeigen"
 
 #: builtin/help.c:46
 msgid "show manual in web browser"
 msgstr "Handbuch in einem Webbrowser anzeigen"
@@ -8375,25 +8370,25 @@ msgid "read error on input"
 msgstr "Fehler beim Lesen der Eingabe"
 
 #: builtin/index-pack.c:292
 msgid "used more bytes than were available"
 msgstr "verwendete mehr Bytes als verfügbar waren"
 
 #: builtin/index-pack.c:299
 msgid "pack too large for current definition of off_t"
 msgstr "Paket ist zu groß für die aktuelle Definition von off_t"
 
 #: builtin/index-pack.c:302 builtin/unpack-objects.c:92
 msgid "pack exceeds maximum allowed size"
-msgstr ""
+msgstr "Paket überschreitet die maximal erlaubte Größe"
 
 #: builtin/index-pack.c:317
 #, c-format
 msgid "unable to create '%s'"
 msgstr "konnte '%s' nicht erstellen"
 
 #: builtin/index-pack.c:322
 #, c-format
 msgid "cannot open packfile '%s'"
 msgstr "Kann Paketdatei '%s' nicht öffnen"
 
 #: builtin/index-pack.c:336
@@ -8933,27 +8928,26 @@ msgstr "Dateiendung"
 msgid "use <sfx> instead of '.patch'"
 msgstr "<Dateiendung> anstatt '.patch' verwenden"
 
 #: builtin/log.c:1423
 msgid "start numbering patches at <n> instead of 1"
 msgstr "die Nummerierung der Patches bei <n> anstatt bei 1 beginnen"
 
 #: builtin/log.c:1425
 msgid "mark the series as Nth re-roll"
 msgstr "die Serie als n-te Fassung kennzeichnen"
 
 #: builtin/log.c:1427
-#, fuzzy
 msgid "Use [RFC PATCH] instead of [PATCH]"
-msgstr "[<Präfix>] anstatt [PATCH] verwenden"
+msgstr "[RFC PATCH] anstatt [PATCH] verwenden"
 
 #: builtin/log.c:1430
 msgid "Use [<prefix>] instead of [PATCH]"
 msgstr "[<Präfix>] anstatt [PATCH] verwenden"
 
 #: builtin/log.c:1433
 msgid "store resulting files in <dir>"
 msgstr "erzeugte Dateien in <Verzeichnis> speichern"
 
 #: builtin/log.c:1436
 msgid "don't strip/add [PATCH]"
 msgstr "[PATCH] nicht entfernen/hinzufügen"
@@ -9053,27 +9047,26 @@ msgstr "erforderliche Revisions-Informationen der Patch-Serie hinzufügen"
 msgid "add a signature from a file"
 msgstr "eine Signatur aus einer Datei hinzufügen"
 
 #: builtin/log.c:1475
 msgid "don't print the patch filenames"
 msgstr "keine Dateinamen der Patches anzeigen"
 
 #: builtin/log.c:1565
 msgid "-n and -k are mutually exclusive."
 msgstr "Die Optionen -n und -k schließen sich gegenseitig aus."
 
 #: builtin/log.c:1567
-#, fuzzy
 msgid "--subject-prefix/--rfc and -k are mutually exclusive."
-msgstr "Die Optionen --subject-prefix und -k schließen sich gegenseitig aus."
+msgstr "--subject-prefix/--rfc und -k schließen sich gegenseitig aus."
 
 #: builtin/log.c:1575
 msgid "--name-only does not make sense"
 msgstr "Die Option --name-only kann nicht verwendet werden."
 
 #: builtin/log.c:1577
 msgid "--name-status does not make sense"
 msgstr "Die Option --name-status kann nicht verwendet werden."
 
 #: builtin/log.c:1579
 msgid "--check does not make sense"
 msgstr "Die Option --check kann nicht verwendet werden."
@@ -9183,27 +9176,26 @@ msgstr "Muster, gelesen von <Datei>, ausschließen"
 msgid "read additional per-directory exclude patterns in <file>"
 msgstr "zusätzliche pro-Verzeichnis Auschlussmuster aus <Datei> auslesen"
 
 #: builtin/ls-files.c:545
 msgid "add the standard git exclusions"
 msgstr "die standardmäßigen Git-Ausschlüsse hinzufügen"
 
 #: builtin/ls-files.c:548
 msgid "make the output relative to the project top directory"
 msgstr "Ausgabe relativ zum Projektverzeichnis"
 
 #: builtin/ls-files.c:551
-#, fuzzy
 msgid "recurse through submodules"
-msgstr "Rekursion in Unterverzeichnissen durchführen"
+msgstr "Rekursion in Submodulen durchführen"
 
 #: builtin/ls-files.c:553
 msgid "if any <file> is not in the index, treat this as an error"
 msgstr "als Fehler behandeln, wenn sich eine <Datei> nicht im Index befindet"
 
 #: builtin/ls-files.c:554
 msgid "tree-ish"
 msgstr "Commit-Referenz"
 
 #: builtin/ls-files.c:555
 msgid "pretend that paths removed since <tree-ish> are still present"
 msgstr ""
@@ -9752,54 +9744,53 @@ msgstr "bei Konflikten eine gemeinsame Variante verwenden"
 msgid "for conflicts, use this marker size"
 msgstr "bei Konflikten diese Kennzeichnungslänge verwenden"
 
 #: builtin/merge-file.c:43
 msgid "do not warn about conflicts"
 msgstr "keine Warnung bei Konflikten"
 
 #: builtin/merge-file.c:45
 msgid "set labels for file1/orig-file/file2"
 msgstr "Beschriftung für Datei1/orig-Datei/Datei2 setzen"
 
 #: builtin/merge-recursive.c:45
-#, fuzzy, c-format
+#, c-format
 msgid "unknown option %s"
-msgstr "unbekannte Option: $opt"
+msgstr "unbekannte Option: %s"
 
 #: builtin/merge-recursive.c:51
-#, fuzzy, c-format
+#, c-format
 msgid "could not parse object '%s'"
 msgstr "Konnte Objekt '%s' nicht parsen."
 
 #: builtin/merge-recursive.c:55
 #, c-format
 msgid "cannot handle more than %d base. Ignoring %s."
 msgid_plural "cannot handle more than %d bases. Ignoring %s."
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "kann nicht mit mehr als %d Merge-Basis umgehen. Ignoriere %s."
+msgstr[1] "kann nicht mit mehr als %d Merge-Basen umgehen. Ignoriere %s."
 
 #: builtin/merge-recursive.c:63
-#, fuzzy
 msgid "not handling anything other than two heads merge."
 msgstr "Es wird nur der Merge von zwei Branches behandelt."
 
 #: builtin/merge-recursive.c:69 builtin/merge-recursive.c:71
-#, fuzzy, c-format
+#, c-format
 msgid "could not resolve ref '%s'"
-msgstr "Konnte Referenz %s nicht löschen"
+msgstr "Konnte Referenz '%s' nicht auflösen"
 
 #: builtin/merge-recursive.c:77
-#, fuzzy, c-format
+#, c-format
 msgid "Merging %s with %s\n"
-msgstr "Benenne %s nach %s um\n"
+msgstr "Führe %s mit %s zusammen\n"
 
 #: builtin/mktree.c:65
 msgid "git mktree [-z] [--missing] [--batch]"
 msgstr "git mktree [-z] [--missing] [--batch]"
 
 #: builtin/mktree.c:152
 msgid "input is NUL terminated"
 msgstr "Eingabe ist durch NUL-Zeichen abgeschlossen"
 
 #: builtin/mktree.c:153 builtin/write-tree.c:24
 msgid "allow missing objects"
 msgstr "fehlende Objekte erlauben"
@@ -10065,91 +10056,88 @@ msgid "unable to start 'show' for object '%s'"
 msgstr "konnte 'show' für Objekt '%s' nicht starten"
 
 #: builtin/notes.c:151
 msgid "could not read 'show' output"
 msgstr "Konnte Ausgabe von 'show' nicht lesen."
 
 #: builtin/notes.c:159
 #, c-format
 msgid "failed to finish 'show' for object '%s'"
 msgstr "konnte 'show' für Objekt '%s' nicht abschließen"
 
 #: builtin/notes.c:194
-#, fuzzy
 msgid "please supply the note contents using either -m or -F option"
-msgstr ""
-"Bitte liefern Sie den Notiz-Inhalt unter Verwendung der Option -m oder -F."
+msgstr "Bitte liefern Sie die Notiz-Inhalte unter Verwendung der Option -m oder -F."
 
 #: builtin/notes.c:203
 msgid "unable to write note object"
 msgstr "Konnte Notiz-Objekt nicht schreiben"
 
 #: builtin/notes.c:205
-#, fuzzy, c-format
+#, c-format
 msgid "the note contents have been left in %s"
-msgstr "Die Notiz-Inhalte wurden in %s belassen"
+msgstr "Die Notiz-Inhalte wurden in %s belassen."
 
 #: builtin/notes.c:233 builtin/tag.c:439
 #, c-format
 msgid "cannot read '%s'"
 msgstr "kann '%s' nicht lesen"
 
 #: builtin/notes.c:235 builtin/tag.c:442
 #, c-format
 msgid "could not open or read '%s'"
 msgstr "konnte '%s' nicht öffnen oder lesen"
 
 #: builtin/notes.c:254 builtin/notes.c:305 builtin/notes.c:307
 #: builtin/notes.c:372 builtin/notes.c:427 builtin/notes.c:513
 #: builtin/notes.c:518 builtin/notes.c:596 builtin/notes.c:659
-#, fuzzy, c-format
+#, c-format
 msgid "failed to resolve '%s' as a valid ref."
 msgstr "Konnte '%s' nicht als gültige Referenz auflösen."
 
 #: builtin/notes.c:257
-#, fuzzy, c-format
+#, c-format
 msgid "failed to read object '%s'."
 msgstr "Fehler beim Lesen des Objektes '%s'."
 
 #: builtin/notes.c:261
-#, fuzzy, c-format
+#, c-format
 msgid "cannot read note data from non-blob object '%s'."
 msgstr "Kann Notiz-Daten nicht von Nicht-Blob Objekt '%s' lesen."
 
 #: builtin/notes.c:301
-#, fuzzy, c-format
+#, c-format
 msgid "malformed input line: '%s'."
 msgstr "Fehlerhafte Eingabezeile: '%s'."
 
 #: builtin/notes.c:316
-#, fuzzy, c-format
+#, c-format
 msgid "failed to copy notes from '%s' to '%s'"
 msgstr "Fehler beim Kopieren der Notizen von '%s' nach '%s'"
 
 #. TRANSLATORS: the first %s will be replaced by a
 #. git notes command: 'add', 'merge', 'remove', etc.
 #: builtin/notes.c:345
-#, fuzzy, c-format
+#, c-format
 msgid "refusing to %s notes in %s (outside of refs/notes/)"
-msgstr ""
-"Umschreiben der Notizen in %s zurückgewiesen (außerhalb von refs/notes/)"
+msgstr "Ausführung von %s auf Notizen in %s (außerhalb von refs/notes/) zurückgewiesen"
 
 #: builtin/notes.c:365 builtin/notes.c:420 builtin/notes.c:496
 #: builtin/notes.c:508 builtin/notes.c:584 builtin/notes.c:652
 #: builtin/notes.c:802 builtin/notes.c:949 builtin/notes.c:970
 msgid "too many parameters"
 msgstr "zu viele Parameter"
 
 #: builtin/notes.c:378 builtin/notes.c:665
-#, fuzzy, c-format
+#, c-format
 msgid "no note found for object %s."
 msgstr "Keine Notiz für Objekt %s gefunden."
 
 #: builtin/notes.c:399 builtin/notes.c:562
 msgid "note contents as a string"
 msgstr "Notizinhalte als Zeichenkette"
 
 #: builtin/notes.c:402 builtin/notes.c:565
 msgid "note contents in a file"
 msgstr "Notizinhalte in einer Datei"
 
 #: builtin/notes.c:405 builtin/notes.c:568
@@ -10202,72 +10190,68 @@ msgid "too few parameters"
 msgstr "zu wenig Parameter"
 
 #: builtin/notes.c:525
 #, c-format
 msgid ""
 "Cannot copy notes. Found existing notes for object %s. Use '-f' to overwrite "
 "existing notes"
 msgstr ""
 "Kann Notizen nicht kopieren. Existierende Notizen für Objekt %s gefunden. "
 "Verwenden Sie '-f', um die existierenden Notizen zu überschreiben."
 
 #: builtin/notes.c:537
-#, fuzzy, c-format
+#, c-format
 msgid "missing notes on source object %s. Cannot copy."
 msgstr "Keine Notizen für Quell-Objekt %s. Kopie nicht möglich."
 
 #: builtin/notes.c:589
 #, c-format
 msgid ""
 "The -m/-F/-c/-C options have been deprecated for the 'edit' subcommand.\n"
 "Please use 'git notes add -f -m/-F/-c/-C' instead.\n"
 msgstr ""
 "Die Optionen -m/-F/-c/-C sind für den Unterbefehl 'edit' veraltet.\n"
 "Bitte benutzen Sie stattdessen 'git notes add -f -m/-F/-c/-C'.\n"
 
 #: builtin/notes.c:685
 msgid "failed to delete ref NOTES_MERGE_PARTIAL"
-msgstr ""
+msgstr "Fehler beim Löschen der Referenz NOTES_MERGE_PARTIAL"
 
 #: builtin/notes.c:687
-#, fuzzy
 msgid "failed to delete ref NOTES_MERGE_REF"
-msgstr "Konnte Datei '%s' nicht löschen"
+msgstr "Fehler beim Löschen der Referenz NOTES_MERGE_REF"
 
 #: builtin/notes.c:689
-#, fuzzy
 msgid "failed to remove 'git notes merge' worktree"
-msgstr "Fehler beim Löschen von '%s'"
+msgstr "Fehler beim Löschen des Arbeitsverzeichnisses von 'git notes merge'."
 
 #: builtin/notes.c:709
 msgid "failed to read ref NOTES_MERGE_PARTIAL"
-msgstr ""
+msgstr "Fehler beim Lesen der Referenz NOTES_MERGE_PARTIAL"
 
 #: builtin/notes.c:711
 msgid "could not find commit from NOTES_MERGE_PARTIAL."
-msgstr ""
+msgstr "Konnte Commit von NOTES_MERGE_PARTIAL nicht finden."
 
 #: builtin/notes.c:713
 msgid "could not parse commit from NOTES_MERGE_PARTIAL."
-msgstr ""
+msgstr "Konnte Commit von NOTES_MERGE_PARTIAL nicht parsen."
 
 #: builtin/notes.c:726
-#, fuzzy
 msgid "failed to resolve NOTES_MERGE_REF"
-msgstr "Fehler beim Löschen von %s"
+msgstr "Fehler beim Auflösen von NOTES_MERGE_REF"
 
 #: builtin/notes.c:729
-#, fuzzy
 msgid "failed to finalize notes merge"
-msgstr "Fehler beim Finden einer exakten Merge-Basis."
+msgstr "Fehler beim Abschließen der Zusammenführung der Notizen."
 
 #: builtin/notes.c:755
 #, c-format
 msgid "unknown notes merge strategy %s"
 msgstr "unbekannte Merge-Strategie '%s' für Notizen"
 
 #: builtin/notes.c:771
 msgid "General options"
 msgstr "Allgemeine Optionen"
 
 #: builtin/notes.c:773
 msgid "Merge options"
@@ -10295,40 +10279,39 @@ msgstr ""
 msgid "Aborting notes merge resolution"
 msgstr "Konfliktauflösung beim Merge von Notizen abbrechen"
 
 #: builtin/notes.c:783
 msgid "abort notes merge"
 msgstr "Merge von Notizen abbrechen"
 
 #: builtin/notes.c:794
 msgid "cannot mix --commit, --abort or -s/--strategy"
 msgstr "Kann --commit, --abort oder -s/--strategy nicht kombinieren."
 
 #: builtin/notes.c:799
-#, fuzzy
 msgid "must specify a notes ref to merge"
 msgstr "Sie müssen eine Notiz-Referenz zum Mergen angeben."
 
 #: builtin/notes.c:823
-#, fuzzy, c-format
+#, c-format
 msgid "unknown -s/--strategy: %s"
 msgstr "Unbekannter Wert für -s/--strategy: %s"
 
 #: builtin/notes.c:860
-#, fuzzy, c-format
+#, c-format
 msgid "a notes merge into %s is already in-progress at %s"
 msgstr "Ein Merge von Notizen nach %s ist bereits im Gange bei %s"
 
 #: builtin/notes.c:863
-#, fuzzy, c-format
+#, c-format
 msgid "failed to store link to current notes ref (%s)"
 msgstr ""
 "Fehler beim Speichern der Verknüpfung zur aktuellen Notes-Referenz (%s)"
 
 #: builtin/notes.c:865
 #, c-format
 msgid ""
 "Automatic notes merge failed. Fix conflicts in %s and commit the result with "
 "'git notes merge --commit', or abort the merge with 'git notes merge --"
 "abort'.\n"
 msgstr ""
 "Automatisches Zusammenführen der Notizen fehlgeschlagen. Beheben Sie die\n"
@@ -10357,25 +10340,25 @@ msgstr "nicht löschen, nur anzeigen"
 msgid "report pruned notes"
 msgstr "gelöschte Notizen melden"
 
 #: builtin/notes.c:983
 msgid "notes-ref"
 msgstr "Notiz-Referenz"
 
 #: builtin/notes.c:984
 msgid "use notes from <notes-ref>"
 msgstr "Notizen von <Notiz-Referenz> verwenden"
 
 #: builtin/notes.c:1019
-#, fuzzy, c-format
+#, c-format
 msgid "unknown subcommand: %s"
 msgstr "Unbekannter Unterbefehl: %s"
 
 #: builtin/pack-objects.c:29
 msgid ""
 "git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"
 msgstr ""
 "git pack-objects --stdout [<Optionen>...] [< <Referenzliste> | < "
 "<Objektliste>]"
 
 #: builtin/pack-objects.c:30
 msgid ""
@@ -10735,28 +10718,27 @@ msgstr "Ignoriere --verify-signatures für Rebase"
 #: builtin/pull.c:801
 msgid "--[no-]autostash option is only valid with --rebase."
 msgstr "--[no-]autostash ist nur mit --rebase zulässig."
 
 #: builtin/pull.c:809
 msgid "Updating an unborn branch with changes added to the index."
 msgstr ""
 "Aktualisiere einen ungeborenen Branch mit Änderungen, die zum Commit "
 "vorgemerkt sind."
 
 #: builtin/pull.c:812
 msgid "pull with rebase"
-msgstr ""
+msgstr "Pull mit Rebase"
 
 #: builtin/pull.c:813
-#, fuzzy
 msgid "please commit or stash them."
 msgstr "Bitte committen Sie die Änderungen oder benutzen Sie \"stash\"."
 
 #: builtin/pull.c:838
 #, c-format
 msgid ""
 "fetch updated the current branch head.\n"
 "fast-forwarding your working tree from\n"
 "commit %s."
 msgstr ""
 "\"fetch\" aktualisierte die Spitze des aktuellen Branches.\n"
 "Spule Ihr Arbeitsverzeichnis von Commit %s vor."
@@ -11159,58 +11141,82 @@ msgid "don't check the working tree after merging"
 msgstr "das Arbeitsverzeichnis nach dem Merge nicht prüfen"
 
 #: builtin/read-tree.c:135
 msgid "don't update the index or the work tree"
 msgstr "weder den Index, noch das Arbeitsverzeichnis aktualisieren"
 
 #: builtin/read-tree.c:137
 msgid "skip applying sparse checkout filter"
 msgstr "Anwendung des Filters für partielles Auschecken überspringen"
 
 #: builtin/read-tree.c:139
 msgid "debug unpack-trees"
-msgstr "Entpacken der Bäume protokollieren"
+msgstr "unpack-trees protokollieren"
 
 #: builtin/receive-pack.c:26
 msgid "git receive-pack <git-dir>"
 msgstr "git receive-pack <Git-Verzeichnis>"
 
 #: builtin/receive-pack.c:793
 msgid ""
 "By default, updating the current branch in a non-bare repository\n"
 "is denied, because it will make the index and work tree inconsistent\n"
 "with what you pushed, and will require 'git reset --hard' to match\n"
 "the work tree to HEAD.\n"
 "\n"
 "You can set 'receive.denyCurrentBranch' configuration variable to\n"
 "'ignore' or 'warn' in the remote repository to allow pushing into\n"
 "its current branch; however, this is not recommended unless you\n"
 "arranged to update its work tree to match what you pushed in some\n"
 "other way.\n"
 "\n"
 "To squelch this message and still keep the default behaviour, set\n"
 "'receive.denyCurrentBranch' configuration variable to 'refuse'."
 msgstr ""
+"Standardmäßig wird die Aktualisierung des aktuellen Branches in einem\n"
+"nicht-Bare-Repository zurückgewiesen, da dies den Index und das Arbeits-\n"
+"verzeichnis inkonsistent zu dem machen würde, was Sie gepushed haben, und\n"
+"'git reset --hard' erforderlich wäre, damit das Arbeitsverzeichnis HEAD\n"
+"entspricht.\n"
+"\n"
+"Sie könnten die Konfigurationsvariable 'receive.denyCurrentBranch' im\n"
+"Remote-Repository zu 'ignore' oder 'warn' setzen, um den Push in den\n"
+"aktuellen Branch zu erlauben; dies wird jedoch nicht empfohlen außer\n"
+"Sie stellen durch andere Wege die Aktualität des Arbeitsverzeichnisses\n"
+"gegenüber dem gepushten Stand sicher.\n"
+"\n"
+"Um diese Meldung zu unterdrücken und das Standardverhalten zu behalten,\n"
+"setzen Sie die Konfigurationsvariable 'receive.denyCurrentBranch' auf\n"
+"'refuse'."
 
 #: builtin/receive-pack.c:813
 msgid ""
 "By default, deleting the current branch is denied, because the next\n"
 "'git clone' won't result in any file checked out, causing confusion.\n"
 "\n"
 "You can set 'receive.denyDeleteCurrent' configuration variable to\n"
 "'warn' or 'ignore' in the remote repository to allow deleting the\n"
 "current branch, with or without a warning message.\n"
 "\n"
 "To squelch this message, you can set it to 'refuse'."
 msgstr ""
+"Standardmäßig wird das Löschen des aktuellen Branches zurückgewiesen,\n"
+"da beim nächsten 'git clone' keine Dateien ausgecheckt werden würden,\n"
+"was zu Verwunderung führt.\n"
+"\n"
+"Sie können die Konfigurationsvariable 'receive.denyDeleteCurrent' im\n"
+"Remote-Repository auf 'warn' oder 'ignore' setzen, um das Löschen des\n"
+"aktuellen Branch mit oder ohne Warnung zu erlauben.\n"
+"\n"
+"Um diese Meldung zu unterdrücken, setzen Sie die Variable auf 'refuse'."
 
 #: builtin/receive-pack.c:1883
 msgid "quiet"
 msgstr "weniger Ausgaben"
 
 #: builtin/receive-pack.c:1897
 msgid "You must specify a directory."
 msgstr "Sie müssen ein Repository angeben."
 
 #: builtin/reflog.c:423
 #, c-format
 msgid "'%s' for '%s' is not a valid timestamp"
@@ -11917,27 +11923,26 @@ msgstr "git rerere [clean | forget <Pfad>... | status | remaining | diff | gc]"
 
 #: builtin/rerere.c:58
 msgid "register clean resolutions in index"
 msgstr "saubere Auflösungen im Index registrieren"
 
 #: builtin/reset.c:26
 msgid ""
 "git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"
 msgstr ""
 "git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<Commit>]"
 
 #: builtin/reset.c:27
-#, fuzzy
 msgid "git reset [-q] [<tree-ish>] [--] <paths>..."
-msgstr "git reset [-q] <Commit-Referenz> [--] <Pfade>..."
+msgstr "git reset [-q] [<Commit-Referenz>] [--] <Pfade>..."
 
 #: builtin/reset.c:28
 msgid "git reset --patch [<tree-ish>] [--] [<paths>...]"
 msgstr "git reset --patch [<Commit-Referenz>] [--] [<Pfade>...]"
 
 #: builtin/reset.c:34
 msgid "mixed"
 msgstr "mixed"
 
 #: builtin/reset.c:34
 msgid "soft"
 msgstr "soft"
@@ -12330,31 +12335,31 @@ msgstr ""
 "\t\t[--current] [--color[=<Wann>] | --no-color] [--sparse]\n"
 "\t\t[--more=<n> | --list | --independent | --merge-base]\n"
 "\t\t[--no-name | --sha1-name] [--topics] [(<Commit> | <glob>)...]"
 
 #: builtin/show-branch.c:14
 msgid "git show-branch (-g | --reflog)[=<n>[,<base>]] [--list] [<ref>]"
 msgstr "git show-branch (-g | --reflog)[=<n>[,<Basis>]] [--list] [<Referenz>]"
 
 #: builtin/show-branch.c:375
 #, c-format
 msgid "ignoring %s; cannot handle more than %d ref"
 msgid_plural "ignoring %s; cannot handle more than %d refs"
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "ignoriere %s; kann nicht mehr als %d Referenz behandeln"
+msgstr[1] "ignoriere %s; kann nicht mehr als %d Referenzen behandeln"
 
 #: builtin/show-branch.c:541
-#, fuzzy, c-format
+#, c-format
 msgid "no matching refs with %s"
-msgstr "Dateien mit Übereinstimmungen im Anzeigeprogramm anzeigen"
+msgstr "keine übereinstimmenden Referenzen mit %s"
 
 #: builtin/show-branch.c:639
 msgid "show remote-tracking and local branches"
 msgstr "Remote-Tracking und lokale Branches anzeigen"
 
 #: builtin/show-branch.c:641
 msgid "show remote-tracking branches"
 msgstr "Remote-Tracking-Branches anzeigen"
 
 #: builtin/show-branch.c:643
 msgid "color '*!+-' corresponding to the branch"
 msgstr "'*!+-' entsprechend des Branches einfärben"
@@ -12404,66 +12409,64 @@ msgstr "Merges anzeigen, die nur von einem Branch aus erreichbar sind"
 msgid "topologically sort, maintaining date order where possible"
 msgstr "topologische Sortierung, Beibehaltung Datumsordnung wo möglich"
 
 #: builtin/show-branch.c:668
 msgid "<n>[,<base>]"
 msgstr "<n>[,<Basis>]"
 
 #: builtin/show-branch.c:669
 msgid "show <n> most recent ref-log entries starting at base"
 msgstr "die <n> jüngsten Einträge im Reflog, beginnend an der Basis, anzeigen"
 
 #: builtin/show-branch.c:703
-#, fuzzy
 msgid ""
 "--reflog is incompatible with --all, --remotes, --independent or --merge-base"
-msgstr "Die Option --delete ist inkompatibel mit --all, --mirror und --tags."
+msgstr "--reflog ist inkompatibel mit --all, --remotes, --independent oder --merge-base"
 
 #: builtin/show-branch.c:727
 msgid "no branches given, and HEAD is not valid"
-msgstr ""
+msgstr "keine Branches angegeben, und HEAD ist ungültig"
 
 #: builtin/show-branch.c:730
-#, fuzzy
 msgid "--reflog option needs one branch name"
-msgstr "Bei der Option --track muss ein Branchname angegeben werden."
+msgstr "Die Option --reflog benötigt einen Branchnamen."
 
 #: builtin/show-branch.c:733
 #, c-format
 msgid "only %d entry can be shown at one time."
 msgid_plural "only %d entries can be shown at one time."
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "nur %d Eintrag kann zur selben Zeit angezeigt werden"
+msgstr[1] "nur %d Einträge können zur selben Zeit angezeigt werden"
 
 #: builtin/show-branch.c:737
-#, fuzzy, c-format
+#, c-format
 msgid "no such ref %s"
 msgstr "Referenz nicht gefunden: %s"
 
 #: builtin/show-branch.c:829
 #, c-format
 msgid "cannot handle more than %d rev."
 msgid_plural "cannot handle more than %d revs."
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "Kann nicht mehr als %d Commit behandeln."
+msgstr[1] "Kann nicht mehr als %d Commits behandeln."
 
 #: builtin/show-branch.c:833
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' is not a valid ref."
-msgstr "'%s' ist kein gültiger Tagname."
+msgstr "'%s' ist keine gültige Referenz."
 
 #: builtin/show-branch.c:836
-#, fuzzy, c-format
+#, c-format
 msgid "cannot find commit %s (%s)"
-msgstr "kann Objekt %s '%s' nicht lesen"
+msgstr "kann Commit %s (%s) nicht finden"
 
 #: builtin/show-ref.c:10
 msgid ""
 "git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference] [-s | --"
 "hash[=<n>]] [--abbrev[=<n>]] [--tags] [--heads] [--] [<pattern>...]"
 msgstr ""
 "git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference] [-s | --"
 "hash[=<n>]] [--abbrev[=<n>]] [--tags] [--heads] [--] [<Muster>...] "
 
 #: builtin/show-ref.c:11
 msgid "git show-ref --exclude-existing[=<pattern>]"
 msgstr "git show-ref --exclude-existing[=<Muster>]"
@@ -12585,56 +12588,55 @@ msgstr "git submodule--helper init [<Pfad>]"
 #: builtin/submodule--helper.c:435
 msgid "git submodule--helper name <path>"
 msgstr "git submodule--helper name <Pfad>"
 
 #: builtin/submodule--helper.c:441
 #, c-format
 msgid "no submodule mapping found in .gitmodules for path '%s'"
 msgstr "Keine Submodul-Zuordnung in .gitmodules für Pfad '%s' gefunden"
 
 #: builtin/submodule--helper.c:524 builtin/submodule--helper.c:527
 #, c-format
 msgid "submodule '%s' cannot add alternate: %s"
-msgstr ""
+msgstr "Submodul '%s' kann Alternative nicht hinzufügen: %s"
 
 #: builtin/submodule--helper.c:563
 #, c-format
 msgid "Value '%s' for submodule.alternateErrorStrategy is not recognized"
-msgstr ""
+msgstr "Wert '%s' für submodule.alternateErrorStrategy wird nicht erkannt"
 
 #: builtin/submodule--helper.c:570
 #, c-format
 msgid "Value '%s' for submodule.alternateLocation is not recognized"
-msgstr ""
+msgstr "Wert '%s' für submodule.alternateLocation wird nicht erkannt."
 
 #: builtin/submodule--helper.c:593
 msgid "where the new submodule will be cloned to"
 msgstr "Pfad für neues Submodul"
 
 #: builtin/submodule--helper.c:596
 msgid "name of the new submodule"
 msgstr "Name des neuen Submoduls"
 
 #: builtin/submodule--helper.c:599
 msgid "url where to clone the submodule from"
 msgstr "URL von der das Submodul geklont wird"
 
 #: builtin/submodule--helper.c:605
 msgid "depth for shallow clones"
 msgstr "Tiefe des Klons mit unvollständiger Historie (shallow)"
 
 #: builtin/submodule--helper.c:608 builtin/submodule--helper.c:964
-#, fuzzy
 msgid "force cloning progress"
-msgstr "keine Fortschrittsanzeige beim Klonen"
+msgstr "Fortschrittsanzeige beim Klonen erzwingen"
 
 #: builtin/submodule--helper.c:613
 msgid ""
 "git submodule--helper clone [--prefix=<path>] [--quiet] [--reference "
 "<repository>] [--name <name>] [--depth <depth>] --url <url> --path <path>"
 msgstr ""
 "git submodule--helper clone [--prefix=<Pfad>] [--quiet] [--reference "
 "<Repository>] [--name <Name>] [--url <URL>] [--name <Name>] [--depth "
 "<Tiefe>] --url <URL> --path <Pfad>"
 
 #: builtin/submodule--helper.c:638 builtin/submodule--helper.c:648
 #, c-format
@@ -13179,34 +13181,38 @@ msgstr ""
 "prüfen ob das Dateisystem einen Cache für unversionierte Dateien unterstützt"
 
 #: builtin/update-index.c:1003
 msgid "enable untracked cache without testing the filesystem"
 msgstr ""
 "Cache für unversionierte Dateien ohne Prüfung des Dateisystems aktivieren"
 
 #: builtin/update-index.c:1119
 msgid ""
 "core.untrackedCache is set to true; remove or change it, if you really want "
 "to disable the untracked cache"
 msgstr ""
+"core.untrackedCache ist auf 'true' gesetzt. Entfernen oder ändern Sie dies,\n"
+"wenn Sie wirklich den Cache für unversionierte Dateien deaktivieren möchten."
 
 #: builtin/update-index.c:1123
 msgid "Untracked cache disabled"
 msgstr "Cache für unversionierte Dateien deaktiviert"
 
 #: builtin/update-index.c:1131
 msgid ""
 "core.untrackedCache is set to false; remove or change it, if you really want "
 "to enable the untracked cache"
 msgstr ""
+"core.untrackedCache ist auf 'false' gesetzt. Entfernen oder ändern Sie dies,\n"
+"wenn sie wirklich den Cache für unversionierte Dateien aktivieren möchten."
 
 #: builtin/update-index.c:1135
 #, c-format
 msgid "Untracked cache enabled for '%s'"
 msgstr "Cache für unversionierte Dateien für '%s' aktiviert"
 
 #: builtin/update-ref.c:9
 msgid "git update-ref [<options>] -d <refname> [<old-val>]"
 msgstr "git update-ref [<Optionen>] -d <Referenzname> [<alter-Wert>]"
 
 #: builtin/update-ref.c:10
 msgid "git update-ref [<options>]    <refname> <new-val> [<old-val>]"
@@ -13420,46 +13426,50 @@ msgstr ""
 #: upload-pack.c:1034
 msgid "interrupt transfer after <n> seconds of inactivity"
 msgstr "Übertragung nach <n> Sekunden Inaktivität unterbrechen"
 
 #: credential-cache--daemon.c:223
 #, c-format
 msgid ""
 "The permissions on your socket directory are too loose; other\n"
 "users may be able to read your cached credentials. Consider running:\n"
 "\n"
 "\tchmod 0700 %s"
 msgstr ""
+"Die Berechtigungen auf Ihr Socket-Verzeichnis sind zu schwach; andere\n"
+"Nutzer könnten Ihre zwischengespeicherten Anmeldeinformationen lesen.\n"
+"Ziehen Sie in Betracht\n"
+"\n"
+"\tchmod 0700 %s\n"
+"\n"
+"auszuführen."
 
 #: credential-cache--daemon.c:271
 msgid "print debugging messages to stderr"
 msgstr "Meldungen zur Fehlersuche in Standard-Fehlerausgabe ausgeben"
 
 #: git.c:14
 msgid ""
 "'git help -a' and 'git help -g' list available subcommands and some\n"
 "concept guides. See 'git help <command>' or 'git help <concept>'\n"
 "to read about a specific subcommand or concept."
 msgstr ""
 "'git help -a' und 'git help -g' listet verfügbare Unterbefehle und\n"
 "einige Anleitungen zu Git-Konzepten auf. Benutzen Sie 'git help <Befehl>'\n"
 "oder 'git help <Konzept>', um mehr über einen spezifischen Befehl oder\n"
 "Konzept zu erfahren."
 
 #: http.c:342
-#, fuzzy
 msgid "Delegation control is not supported with cURL < 7.22.0"
-msgstr ""
-"Das Anheften des öffentlichen Schlüssels wird mit cURL < 7.44.0\n"
-"nicht unterstützt."
+msgstr "Kontrolle über Delegation wird mit cURL < 7.22.0 nicht unterstützt"
 
 #: http.c:351
 msgid "Public key pinning not supported with cURL < 7.44.0"
 msgstr ""
 "Das Anheften des öffentlichen Schlüssels wird mit cURL < 7.44.0\n"
 "nicht unterstützt."
 
 #: common-cmds.h:9
 msgid "start a working area (see also: git help tutorial)"
 msgstr "Arbeitsverzeichnis anlegen (siehe auch: git help tutorial)"
 
 #: common-cmds.h:10
@@ -13806,25 +13816,24 @@ msgid ""
 "Error: Your local changes to the following files would be overwritten by "
 "merge"
 msgstr ""
 "Fehler Ihre lokalen Änderungen in den folgenden Dateien würden durch den "
 "Merge\n"
 "überschrieben werden"
 
 #: git-merge-octopus.sh:61
 msgid "Automated merge did not work."
 msgstr "Automatischer Merge hat nicht funktioniert."
 
 #: git-merge-octopus.sh:62
-#, fuzzy
 msgid "Should not be doing an octopus."
 msgstr "Sollte keinen Octopus-Merge ausführen."
 
 #: git-merge-octopus.sh:73
 #, sh-format
 msgid "Unable to find common commit with $pretty_name"
 msgstr "Konnte keinen gemeinsamen Commit mit $pretty_name finden."
 
 #: git-merge-octopus.sh:77
 #, sh-format
 msgid "Already up-to-date with $pretty_name"
 msgstr "Bereits aktuell mit $pretty_name"
@@ -14001,27 +14010,26 @@ msgstr "$branch_name zu $onto_name vorgespult."
 msgid "git stash clear with parameters is unimplemented"
 msgstr "git stash clear mit Parametern ist nicht implementiert"
 
 #: git-stash.sh:73
 msgid "You do not have the initial commit yet"
 msgstr "Sie haben bisher noch keinen initialen Commit"
 
 #: git-stash.sh:88
 msgid "Cannot save the current index state"
 msgstr "Kann den aktuellen Zustand des Index nicht speichern"
 
 #: git-stash.sh:103
-#, fuzzy
 msgid "Cannot save the untracked files"
-msgstr "Kann den aktuellen Zustand des Index nicht speichern"
+msgstr "Kann die unversionierten Dateien nicht speichern"
 
 #: git-stash.sh:123 git-stash.sh:136
 msgid "Cannot save the current worktree state"
 msgstr "Kann den aktuellen Zustand des Arbeitsverzeichnisses nicht speichern"
 
 #: git-stash.sh:140
 msgid "No changes selected"
 msgstr "Keine Änderungen ausgewählt"
 
 #: git-stash.sh:143
 msgid "Cannot remove temporary index (can't happen)"
 msgstr "Kann temporären Index nicht löschen (kann nicht passieren)"
@@ -14047,28 +14055,26 @@ msgstr "Kann $ref_stash nicht mit $w_commit aktualisieren."
 #. To provide a message, use git stash save -- '--blah-blah'
 #: git-stash.sh:238
 #, sh-format
 msgid ""
 "error: unknown option for 'stash save': $option\n"
 "       To provide a message, use git stash save -- '$option'"
 msgstr ""
 "Fehler: unbekannte Option für 'stash save': $option\n"
 "        Um eine Beschreibung anzugeben, benutzen Sie \"git stash save -- "
 "'$option'\""
 
 #: git-stash.sh:251
-#, fuzzy
 msgid "Can't use --patch and --include-untracked or --all at the same time"
-msgstr ""
-"Kann nicht gleichzeitig Pfade aktualisieren und zu Branch '%s' wechseln"
+msgstr "Kann nicht gleichzeitig --patch und --include-untracked oder --all verwenden"
 
 #: git-stash.sh:259
 msgid "No local changes to save"
 msgstr "Keine lokalen Änderungen zum Speichern"
 
 #: git-stash.sh:263
 msgid "Cannot initialize stash"
 msgstr "Kann \"stash\" nicht initialisieren"
 
 #: git-stash.sh:267
 msgid "Cannot save the current status"
 msgstr "Kann den aktuellen Status nicht speichern"
@@ -14119,27 +14125,26 @@ msgstr "Konnte den Index nicht aktualisieren."
 msgid "Cannot apply a stash in the middle of a merge"
 msgstr "Kann \"stash\" nicht anwenden, solang ein Merge im Gange ist"
 
 #: git-stash.sh:497
 msgid "Conflicts in index. Try without --index."
 msgstr "Konflikte im Index. Versuchen Sie es ohne --index."
 
 #: git-stash.sh:499
 msgid "Could not save index tree"
 msgstr "Konnte Index-Verzeichnis nicht speichern"
 
 #: git-stash.sh:508
-#, fuzzy
 msgid "Could not restore untracked files from stash"
-msgstr "konnte nicht von '%s' lesen"
+msgstr "Konnte unversionierte Dateien vom Stash nicht wiederherstellen"
 
 #: git-stash.sh:533
 msgid "Cannot unstage modified files"
 msgstr "Kann geänderte Dateien nicht aus dem Index entfernen"
 
 #: git-stash.sh:548
 msgid "Index was not unstashed."
 msgstr "Index wurde nicht aus dem Stash zurückgeladen."
 
 #: git-stash.sh:562
 msgid "The stash is kept in case you need it again."
 msgstr "Der Stash wird behalten, im Falle Sie benötigen diesen nochmal."
@@ -14716,57 +14721,57 @@ msgstr ""
 
 #: git-rebase--interactive.sh:1027
 #, sh-format
 msgid ""
 "Unrecognized setting $check_level for option rebase.missingCommitsCheck. "
 "Ignoring."
 msgstr ""
 "Nicht erkannte Einstellung $check_level für Option rebase."
 "missingCommitsCheck.\n"
 "Ignoriere."
 
 #: git-rebase--interactive.sh:1044
-#, fuzzy
 msgid ""
 "You can fix this with 'git rebase --edit-todo' and then run 'git rebase --"
 "continue'."
-msgstr "Sie können das mit 'git rebase --edit-todo' beheben."
+msgstr ""
+"Sie können das mit 'git rebase --edit-todo' beheben. Führen Sie danach\n"
+"'git rebase --continue' aus."
 
 #: git-rebase--interactive.sh:1045
 msgid "Or you can abort the rebase with 'git rebase --abort'."
 msgstr "Oder Sie können den Rebase mit 'git rebase --abort' abbrechen."
 
 #: git-rebase--interactive.sh:1069
 msgid "Could not remove CHERRY_PICK_HEAD"
 msgstr "Konnte CHERRY_PICK_HEAD nicht löschen"
 
 #: git-rebase--interactive.sh:1074
-#, fuzzy, sh-format
+#, sh-format
 msgid ""
 "You have staged changes in your working tree.\n"
 "If these changes are meant to be\n"
 "squashed into the previous commit, run:\n"
 "\n"
 "  git commit --amend $gpg_sign_opt_quoted\n"
 "\n"
 "If they are meant to go into a new commit, run:\n"
 "\n"
 "  git commit $gpg_sign_opt_quoted\n"
 "\n"
 "In both cases, once you're done, continue with:\n"
 "\n"
 "  git rebase --continue\n"
 msgstr ""
-"Es befinden sich zum Commit vorgemerkte Änderungen in Ihrem "
-"Arbeitsverzeichnis.\n"
+"Es befinden sich zum Commit vorgemerkte Änderungen in Ihrem Arbeitsverzeichnis.\n"
 "Wenn diese Änderungen in den vorherigen Commit aufgenommen werden sollen,\n"
 "führen Sie aus:\n"
 "\n"
 "  git commit --amend $gpg_sign_opt_quoted\n"
 "\n"
 "Wenn daraus ein neuer Commit erzeugt werden soll, führen Sie aus:\n"
 "\n"
 "  git commit $gpg_sign_opt_quoted\n"
 "\n"
 "Im Anschluss führen Sie zum Fortfahren aus:\n"
 "\n"
 "  git rebase --continue\n"
-- 
2.11.0.rc2.160.gf034b25


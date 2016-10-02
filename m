Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87BA720987
	for <e@80x24.org>; Sun,  2 Oct 2016 17:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbcJBRAB (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Oct 2016 13:00:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35462 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750845AbcJBQ7z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Oct 2016 12:59:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id f193so6526813wmg.2
        for <git@vger.kernel.org>; Sun, 02 Oct 2016 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5LARNFWLrRtZa2Vw2d/pNLVeoxUWeUBv2sGjEKW5meY=;
        b=R+3in2bMs/BX1rp9j8o3ay3q4yL44vfgIK0E83O917Ynct/RNyO0FNedRNjhcQ4A7Y
         soAuvFYyp6eMaKbCNy1gDC8WpHaaX/KJa1goJNVJpe5JOz3qCaxFya5QvwxvkNVh+k4W
         //871GQa2SQdcssDWH7IQwgBPMSzYhHpfSKa15XXaQQY6ssp9tbRItGKbN0oimjyBqyi
         jBA99l6btYZ9d2byn9zyw1wmg79EhXeLJ4Xw4szEaUamAi8QwBo2cNb+UA+ZwpcUaRih
         G7DqUQEFUHtuPL/Tuebn6Gg2qqDaxwFRJcE+WNk+EscmmIBogIj7bTpQyoEFLmf8wD0Z
         nTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5LARNFWLrRtZa2Vw2d/pNLVeoxUWeUBv2sGjEKW5meY=;
        b=QgC3Qn5L4HoLpaXyUhjwFM2/D0uP7TX+43SzmmxAvWYhXx3QWjFJSUrGTmyxzsKQQf
         UO/7udO8766k7JOpVAPOeyKhm0/b6NZuoHslfeuFMEXhu/UkiFjtZolY6N3e5DRp/5gw
         94X9yE8HnMHbnPUBMh4VEksTjP9Q72zR8sgo5HNfvDcwXAuuYW01TJfFMNFHmqLR1muc
         WpjtAdCVKq6D2/5PXE936vimS++kvT+49QiImcdihyVHFA4jb2p0EePeK1/uhfX/Mr02
         M52jdihv7HwiSRYfGe/8yF43vz7zP2RsE/1mSqNyJPUGehQAKzDJcbTMjb3nfr/3w6+1
         favw==
X-Gm-Message-State: AA6/9RkHSKHMcooPG+x5/7IqNx50GfTgq/2xzoS6MeYZRcO4raw3WYK4k9TV8wNjPGSZkw==
X-Received: by 10.194.188.113 with SMTP id fz17mr17536029wjc.179.1475427592821;
        Sun, 02 Oct 2016 09:59:52 -0700 (PDT)
Received: from localhost (cable-94-139-18-209.cust.telecolumbus.net. [94.139.18.209])
        by smtp.gmail.com with ESMTPSA id w9sm30029855wjf.47.2016.10.02.09.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Oct 2016 09:59:51 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
        phillip.szelat@gmail.com, matthias.ruester@gmail.com,
        magnus.goerlitz@googlemail.com,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 260 new messages
Date:   Sun,  2 Oct 2016 18:59:46 +0200
Message-Id: <20161002165946.19656-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.10.0.379.g97b919b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Translate 260 new message came from git.pot updates in 9fa976f (l10n:
git.pot: v2.10.0 round 1 (248 new, 56 removed)) and 5bd166d (l10n:
git.pot: v2.10.0 round 2 (12 new, 44 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 783 ++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 421 insertions(+), 362 deletions(-)

diff --git a/po/de.po b/po/de.po
index e1865c6..4415c0d 100644
--- a/po/de.po
+++ b/po/de.po
@@ -14,72 +14,60 @@ msgstr ""
 "Language: de\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
 "Plural-Forms: nplurals=2; plural=(n!=1);\n"
 
 #: advice.c:55
 #, c-format
 msgid "hint: %.*s\n"
 msgstr "Hinweis: %.*s\n"
 
 #: advice.c:83
-#, fuzzy
 msgid "Cherry-picking is not possible because you have unmerged files."
-msgstr ""
-"\"pull\" ist nicht möglich, weil Sie nicht zusammengeführte Dateien haben."
+msgstr "Cherry-Picken ist nicht möglich, weil Sie nicht zusammengeführte Dateien haben."
 
 #: advice.c:85
-#, fuzzy
 msgid "Committing is not possible because you have unmerged files."
-msgstr ""
-"\"pull\" ist nicht möglich, weil Sie nicht zusammengeführte Dateien haben."
+msgstr "Committen ist nicht möglich, weil Sie nicht zusammengeführte Dateien haben."
 
 #: advice.c:87
-#, fuzzy
 msgid "Merging is not possible because you have unmerged files."
-msgstr ""
-"\"pull\" ist nicht möglich, weil Sie nicht zusammengeführte Dateien haben."
+msgstr "Mergen ist nicht möglich, weil Sie nicht zusammengeführte Dateien haben."
 
 #: advice.c:89
-#, fuzzy
 msgid "Pulling is not possible because you have unmerged files."
-msgstr ""
-"\"pull\" ist nicht möglich, weil Sie nicht zusammengeführte Dateien haben."
+msgstr "Pullen ist nicht möglich, weil Sie nicht zusammengeführte Dateien haben."
 
 #: advice.c:91
-#, fuzzy
 msgid "Reverting is not possible because you have unmerged files."
-msgstr ""
-"\"pull\" ist nicht möglich, weil Sie nicht zusammengeführte Dateien haben."
+msgstr "Reverten ist nicht möglich, weil Sie nicht zusammengeführte Dateien haben."
 
 #: advice.c:93
-#, fuzzy, c-format
+#, c-format
 msgid "It is not possible to %s because you have unmerged files."
-msgstr ""
-"\"pull\" ist nicht möglich, weil Sie nicht zusammengeführte Dateien haben."
+msgstr "%s ist nicht möglich, weil Sie nicht zusammengeführte Dateien haben."
 
 #: advice.c:101
 msgid ""
 "Fix them up in the work tree, and then use 'git add/rm <file>'\n"
 "as appropriate to mark resolution and make a commit."
 msgstr ""
 "Korrigieren Sie dies im Arbeitsverzeichnis, und benutzen Sie\n"
 "dann 'git add/rm <Datei>', um die Auflösung entsprechend zu markieren\n"
 "und zu committen."
 
 #: advice.c:109
-#, fuzzy
 msgid "Exiting because of an unresolved conflict."
-msgstr "Beende wegen nicht abgeschlossenem Merge."
+msgstr "Beende wegen unaufgelöstem Konflikt."
 
 #: advice.c:114 builtin/merge.c:1181
 msgid "You have not concluded your merge (MERGE_HEAD exists)."
 msgstr "Sie haben Ihren Merge nicht abgeschlossen (MERGE_HEAD existiert)."
 
 #: advice.c:116
 msgid "Please, commit your changes before merging."
 msgstr "Bitte committen Sie Ihre Änderungen, bevor Sie mergen."
 
 #: advice.c:117
 msgid "Exiting because of unfinished merge."
 msgstr "Beende wegen nicht abgeschlossenem Merge."
@@ -90,24 +78,38 @@ msgid ""
 "Note: checking out '%s'.\n"
 "\n"
 "You are in 'detached HEAD' state. You can look around, make experimental\n"
 "changes and commit them, and you can discard any commits you make in this\n"
 "state without impacting any branches by performing another checkout.\n"
 "\n"
 "If you want to create a new branch to retain commits you create, you may\n"
 "do so (now or later) by using -b with the checkout command again. Example:\n"
 "\n"
 "  git checkout -b <new-branch-name>\n"
 "\n"
 msgstr ""
+"Hinweis: Checke '%s' aus.\n"
+"\n"
+"Sie befinden sich im Zustand eines 'lösgelösten HEAD'. Sie können sich\n"
+"umschauen, experimentelle Änderungen vornehmen und diese committen, und\n"
+"Sie können alle möglichen Commits, die Sie in diesem Zustand machen,\n"
+"ohne Auswirkungen auf irgendeinen Branch verwerfen, indem Sie einen\n"
+"weiteren Checkout durchführen.\n"
+"\n"
+"Wenn Sie einen neuen Branch erstellen möchten, um Ihre erstellten Commits\n"
+"zu behalten, können Sie das (jetzt oder später) durch einen weiteren Checkout\n"
+"mit der Option -b tun. Beispiel:\n"
+"\n"
+"  git checkout -b <neuer-Branchname>\n"
+"\n"
 
 #: archive.c:12
 msgid "git archive [<options>] <tree-ish> [<path>...]"
 msgstr "git archive [<Optionen>] <Commit-Referenz> [<Pfad>...]"
 
 #: archive.c:13
 msgid "git archive --list"
 msgstr "git archive --list"
 
 #: archive.c:14
 msgid ""
 "git archive --remote <repo> [--exec <cmd>] [<options>] <tree-ish> [<path>...]"
@@ -185,165 +187,176 @@ msgstr "Repository"
 msgid "retrieve the archive from remote repository <repo>"
 msgstr "Archiv vom Remote-Repository <Repository> abrufen"
 
 #: archive.c:453 builtin/archive.c:92 builtin/notes.c:483
 msgid "command"
 msgstr "Programm"
 
 #: archive.c:454 builtin/archive.c:93
 msgid "path to the remote git-upload-archive command"
 msgstr "Pfad zum externen \"git-upload-archive\"-Programm"
 
 #: archive.c:461
-#, fuzzy
 msgid "Unexpected option --remote"
-msgstr "unerwarteter Modus $mod_dst"
+msgstr "Unerwartete Option --remote"
 
 #: archive.c:463
-#, fuzzy
 msgid "Option --exec can only be used together with --remote"
-msgstr ""
-"Die Option --ignore-missing kann nur zusammen mit --dry-run verwendet werden."
+msgstr "Die Option --exec kann nur zusammen mit --remote verwendet werden."
 
 #: archive.c:465
 msgid "Unexpected option --output"
-msgstr ""
+msgstr "Unerwartete Option --output"
 
 #: archive.c:487
-#, fuzzy, c-format
+#, c-format
 msgid "Unknown archive format '%s'"
-msgstr "Unbekanntes %.*s Format %s"
+msgstr "Unbekanntes Archivformat '%s'"
 
 #: archive.c:494
-#, fuzzy, c-format
+#, c-format
 msgid "Argument not supported for format '%s': -%d"
-msgstr "Kann \"reflog\" für '%s' nicht durchführen: %s\n"
+msgstr "Argument für Format '%s' nicht unterstützt: -%d"
 
 #: attr.c:263
 msgid ""
 "Negative patterns are ignored in git attributes\n"
 "Use '\\!' for literal leading exclamation."
 msgstr ""
 "Verneinende Muster werden in Git-Attributen ignoriert.\n"
 "Benutzen Sie '\\!' für führende Ausrufezeichen."
 
 #: bisect.c:441
-#, fuzzy, c-format
+#, c-format
 msgid "Could not open file '%s'"
-msgstr "Konnte '%s' nicht öffnen"
+msgstr "Konnte Datei '%s' nicht öffnen"
 
 #: bisect.c:446
-#, fuzzy, c-format
+#, c-format
 msgid "Badly quoted content in file '%s': %s"
-msgstr "Notizinhalte in einer Datei"
+msgstr "Ungültiger Inhalt bzgl. Anführungsstriche in Datei '%s': %s"
 
 #: bisect.c:655
-#, fuzzy, c-format
+#, c-format
 msgid "We cannot bisect more!\n"
-msgstr "keine binäre Suche im Gange"
+msgstr "Keine binäre Suche mehr möglich!\n"
 
 #: bisect.c:708
-#, fuzzy, c-format
+#, c-format
 msgid "Not a valid commit name %s"
-msgstr "%s ist kein gültiger Objekt-Name"
+msgstr "%s ist kein gültiger Commit-Name"
 
 #: bisect.c:732
 #, c-format
 msgid ""
 "The merge base %s is bad.\n"
 "This means the bug has been fixed between %s and [%s].\n"
 msgstr ""
+"Die Merge-Basis %s ist fehlerhaft.\n"
+"Das bedeutet, der Fehler wurde zwischen %s und [%s] behoben.\n"
 
 #: bisect.c:737
 #, c-format
 msgid ""
 "The merge base %s is new.\n"
 "The property has changed between %s and [%s].\n"
 msgstr ""
+"Die Merge-Basis %s ist neu.\n"
+"Das bedeutet, die Eigenschaft hat sich zwischen %s und [%s] geändert.\n"
 
 #: bisect.c:742
 #, c-format
 msgid ""
 "The merge base %s is %s.\n"
 "This means the first '%s' commit is between %s and [%s].\n"
 msgstr ""
+"Die Merge-Basis %s ist %s.\n"
+"Das bedeutet, der erste '%s' Commit befindet sich zwischen %s und [%s]\n"
 
 #: bisect.c:750
 #, c-format
 msgid ""
 "Some %s revs are not ancestor of the %s rev.\n"
 "git bisect cannot work properly in this case.\n"
 "Maybe you mistook %s and %s revs?\n"
 msgstr ""
+"Manche %s Commits sind keine Vorgänger des %s Commits.\n"
+"git bisect kann in diesem Fall nicht richtig arbeiten.\n"
+"Vielleicht verwechselten Sie %s und %s Commits?\n"
 
 #: bisect.c:763
 #, c-format
 msgid ""
 "the merge base between %s and [%s] must be skipped.\n"
 "So we cannot be sure the first %s commit is between %s and %s.\n"
 "We continue anyway."
 msgstr ""
+"Die Merge-Basis zwischen %s und [%s] muss ausgelassen werden.\n"
+"Es kann daher nicht sichergestellt werden, dass sich der\n"
+"erste %s Commit zwischen %s und %s befindet.\n"
+"Es wird dennoch fortgesetzt."
 
 #: bisect.c:798
 #, c-format
 msgid "Bisecting: a merge base must be tested\n"
-msgstr ""
+msgstr "binäre Suche: eine Merge-Basis muss geprüft werden\n"
 
 #: bisect.c:849
-#, fuzzy, c-format
+#, c-format
 msgid "a %s revision is needed"
-msgstr "%.*s ist zum Commit vorgemerkt"
+msgstr "ein %s Commit wird benötigt"
 
 #: bisect.c:866 builtin/notes.c:174 builtin/tag.c:248
 #, c-format
 msgid "could not create file '%s'"
 msgstr "konnte Datei '%s' nicht erstellen"
 
 #: bisect.c:917
-#, fuzzy, c-format
+#, c-format
 msgid "could not read file '%s'"
-msgstr "Konnte Log-Datei '%s' nicht lesen"
+msgstr "Konnte Datei '%s' nicht lesen"
 
 #: bisect.c:947
-#, fuzzy
 msgid "reading bisect refs failed"
-msgstr "Hinzufügen von Dateien fehlgeschlagen"
+msgstr "Lesen von Referenzen für binäre Suche fehlgeschlagen"
 
 #: bisect.c:967
-#, fuzzy, c-format
+#, c-format
 msgid "%s was both %s and %s\n"
-msgstr "%s folgt sowohl %s als auch %s"
+msgstr "%s war %s als auch %s\n"
 
 #: bisect.c:975
 #, c-format
 msgid ""
 "No testable commit found.\n"
 "Maybe you started with bad path parameters?\n"
 msgstr ""
+"Kein testbarer Commit gefunden.\n"
+"Vielleicht starteten Sie mit falschen Pfad-Parametern?\n"
 
 #: bisect.c:994
 #, c-format
 msgid "(roughly %d step)"
 msgid_plural "(roughly %d steps)"
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "(ungefähr %d Schritt)"
+msgstr[1] "(ungefähr %d Schritte)"
 
 #. TRANSLATORS: the last %s will be replaced with
 #. "(roughly %d steps)" translation
 #: bisect.c:998
 #, c-format
 msgid "Bisecting: %d revision left to test after this %s\n"
 msgid_plural "Bisecting: %d revisions left to test after this %s\n"
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "binäre Suche: danach noch %d Commit zum Testen übrig %s\n"
+msgstr[1] "binäre Suche: danach noch %d Commits zum Testen übrig %s\n"
 
 #: branch.c:53
 #, c-format
 msgid ""
 "\n"
 "After fixing the error cause you may try to fix up\n"
 "the remote tracking information by invoking\n"
 "\"git branch --set-upstream-to=%s%s%s\"."
 msgstr ""
 "\n"
 "Nachdem Sie die Fehlerursache behoben haben, können Sie\n"
 "die Tracking-Informationen mit\n"
@@ -571,120 +584,117 @@ msgid "could not parse %s"
 msgstr "konnte %s nicht parsen"
 
 #: commit.c:42
 #, c-format
 msgid "%s %s is not a commit!"
 msgstr "%s %s ist kein Commit!"
 
 #: compat/obstack.c:406 compat/obstack.c:408
 msgid "memory exhausted"
 msgstr "Speicher verbraucht"
 
 #: config.c:516
-#, fuzzy, c-format
+#, c-format
 msgid "bad config line %d in blob %s"
-msgstr "Zeile %d in Konfiguration %s %s ist ungültig."
+msgstr "Ungültige Konfigurationszeile %d in Blob %s"
 
 #: config.c:520
-#, fuzzy, c-format
+#, c-format
 msgid "bad config line %d in file %s"
-msgstr "Zeile %d in Konfiguration %s %s ist ungültig."
+msgstr "Ungültige Konfigurationszeile %d in Datei %s"
 
 #: config.c:524
-#, fuzzy, c-format
+#, c-format
 msgid "bad config line %d in standard input"
-msgstr "Zeile %d in Konfiguration %s %s ist ungültig."
+msgstr "Ungültige Konfigurationszeile %d in Standard-Eingabe"
 
 #: config.c:528
-#, fuzzy, c-format
+#, c-format
 msgid "bad config line %d in submodule-blob %s"
-msgstr "Zeile %d in Konfiguration %s %s ist ungültig."
+msgstr "Ungültige Konfigurationszeile %d in Submodul-Blob %s"
 
 #: config.c:532
-#, fuzzy, c-format
+#, c-format
 msgid "bad config line %d in command line %s"
-msgstr "Zeile %d in Konfiguration %s %s ist ungültig."
+msgstr "Ungültige Konfigurationszeile %d in Kommandozeile %s"
 
 #: config.c:536
-#, fuzzy, c-format
+#, c-format
 msgid "bad config line %d in %s"
-msgstr "Zeile %d in Konfiguration %s %s ist ungültig."
+msgstr "Ungültige Konfigurationszeile %d in %s"
 
 #: config.c:655
-#, fuzzy
 msgid "out of range"
-msgstr "Kein Commit-Bereich."
+msgstr "Außerhalb des Bereichs"
 
 #: config.c:655
-#, fuzzy
 msgid "invalid unit"
-msgstr "Ungültiger Objekt-Typ %s"
+msgstr "Ungültige Einheit"
 
 #: config.c:661
-#, fuzzy, c-format
+#, c-format
 msgid "bad numeric config value '%s' for '%s': %s"
 msgstr "Ungültiger numerischer Wert '%s' für Konfiguration '%s': %s"
 
 #: config.c:666
-#, fuzzy, c-format
+#, c-format
 msgid "bad numeric config value '%s' for '%s' in blob %s: %s"
-msgstr "Ungültiger numerischer Wert '%s' für Konfiguration '%s' in %s %s: %s"
+msgstr "Ungültiger numerischer Wert '%s' für Konfiguration '%s' in Blob %s: %s"
 
 #: config.c:669
-#, fuzzy, c-format
+#, c-format
 msgid "bad numeric config value '%s' for '%s' in file %s: %s"
-msgstr "Ungültiger numerischer Wert '%s' für Konfiguration '%s' in %s %s: %s"
+msgstr "Ungültiger numerischer Wert '%s' für Konfiguration '%s' in Datei %s: %s"
 
 #: config.c:672
-#, fuzzy, c-format
+#, c-format
 msgid "bad numeric config value '%s' for '%s' in standard input: %s"
-msgstr "Ungültiger numerischer Wert '%s' für Konfiguration '%s' in %s %s: %s"
+msgstr "Ungültiger numerischer Wert '%s' für Konfiguration '%s' in Standard-Eingabe: %s"
 
 #: config.c:675
-#, fuzzy, c-format
+#, c-format
 msgid "bad numeric config value '%s' for '%s' in submodule-blob %s: %s"
-msgstr "Ungültiger numerischer Wert '%s' für Konfiguration '%s' in %s %s: %s"
+msgstr "Ungültiger numerischer Wert '%s' für Konfiguration '%s' in Submodul-Blob %s: %s"
 
 #: config.c:678
-#, fuzzy, c-format
+#, c-format
 msgid "bad numeric config value '%s' for '%s' in command line %s: %s"
-msgstr "Ungültiger numerischer Wert '%s' für Konfiguration '%s' in %s %s: %s"
+msgstr "Ungültiger numerischer Wert '%s' für Konfiguration '%s' in Befehlszeile %s: %s"
 
 #: config.c:681
-#, fuzzy, c-format
+#, c-format
 msgid "bad numeric config value '%s' for '%s' in %s: %s"
-msgstr "Ungültiger numerischer Wert '%s' für Konfiguration '%s' in %s %s: %s"
+msgstr "Ungültiger numerischer Wert '%s' für Konfiguration '%s' in %s: %s"
 
 #: config.c:768
 #, c-format
 msgid "failed to expand user dir in: '%s'"
 msgstr "Fehler beim Erweitern des Nutzerverzeichnisses in: '%s'"
 
 #: config.c:849 config.c:860
 #, c-format
 msgid "bad zlib compression level %d"
 msgstr "ungültiger zlib Komprimierungsgrad %d"
 
 #: config.c:978
 #, c-format
 msgid "invalid mode for object creation: %s"
 msgstr "Ungültiger Modus für Objekterstellung: %s"
 
 #: config.c:1312
 msgid "unable to parse command-line config"
 msgstr ""
 "Konnte die über die Befehlszeile angegebene Konfiguration nicht parsen."
 
 #: config.c:1362
-#, fuzzy
 msgid "unknown error occurred while reading the configuration files"
 msgstr ""
 "Es trat ein unbekannter Fehler beim Lesen der Konfigurationsdateien auf."
 
 #: config.c:1716
 #, c-format
 msgid "unable to parse '%s' from command-line config"
 msgstr ""
 "Konnte Wert '%s' aus der über die Befehlszeile angegebenen Konfiguration\n"
 "nicht parsen."
 
 #: config.c:1718
@@ -854,27 +864,26 @@ msgstr "Fehler beim Sammeln von Namen und Informationen zum Kernel"
 
 #: dir.c:1942
 msgid "Untracked cache is disabled on this system or location."
 msgstr ""
 "Cache für unversionierte Dateien ist auf diesem System oder\n"
 "für dieses Verzeichnis deaktiviert."
 
 #: gpg-interface.c:178
 msgid "gpg failed to sign the data"
 msgstr "gpg beim Signieren der Daten fehlgeschlagen"
 
 #: gpg-interface.c:208
-#, fuzzy
 msgid "could not create temporary file"
-msgstr "konnte temporäre Datei '%s' nicht erstellen"
+msgstr "konnte temporäre Datei nicht erstellen"
 
 #: gpg-interface.c:210
 #, c-format
 msgid "failed writing detached signature to '%s'"
 msgstr "Fehler beim Schreiben der losgelösten Signatur nach '%s'"
 
 #: grep.c:1792
 #, c-format
 msgid "'%s': unable to read %s"
 msgstr "'%s': konnte %s nicht lesen"
 
 #: grep.c:1809 builtin/clone.c:382 builtin/diff.c:84 builtin/rm.c:155
@@ -1019,32 +1028,32 @@ msgstr "verweigere, da unversionierte Dateien in '%s' verloren gehen würden"
 
 #: merge-recursive.c:796
 #, c-format
 msgid "cannot read object %s '%s'"
 msgstr "kann Objekt %s '%s' nicht lesen"
 
 #: merge-recursive.c:798
 #, c-format
 msgid "blob expected for %s '%s'"
 msgstr "Blob erwartet für %s '%s'"
 
 #: merge-recursive.c:822
-#, fuzzy, c-format
+#, c-format
 msgid "failed to open '%s': %s"
-msgstr "Fehler beim Öffnen von '%s'"
+msgstr "Fehler beim Öffnen von '%s': %s"
 
 #: merge-recursive.c:833
-#, fuzzy, c-format
+#, c-format
 msgid "failed to symlink '%s': %s"
-msgstr "Fehler beim Erstellen einer symbolischen Verknüpfung für '%s'"
+msgstr "Fehler beim Erstellen einer symbolischen Verknüpfung für '%s': %s"
 
 #: merge-recursive.c:838
 #, c-format
 msgid "do not know what to do with %06o %s '%s'"
 msgstr "weiß nicht was mit %06o %s '%s' zu machen ist"
 
 #: merge-recursive.c:978
 msgid "Failed to execute internal merge"
 msgstr "Fehler bei Ausführung des internen Merges"
 
 #: merge-recursive.c:982
 #, c-format
@@ -1697,28 +1706,26 @@ msgstr ""
 msgid ""
 "not sending a push certificate since the receiving end does not support --"
 "signed push"
 msgstr ""
 "kein Versand des \"push\"-Zertifikates, da die Gegenseite keinen signierten\n"
 "Versand (\"--signed push\") unterstützt"
 
 #: send-pack.c:425
 msgid "the receiving end does not support --atomic push"
 msgstr "die Gegenseite unterstützt keinen atomaren Versand (\"--atomic push\")"
 
 #: send-pack.c:430
-#, fuzzy
 msgid "the receiving end does not support push options"
-msgstr ""
-"die Gegenseite unterstützt keinen signierten Versand (\"--signed push\")"
+msgstr "die Gegenseite unterstützt keine Push-Optionen"
 
 #: sequencer.c:174
 msgid ""
 "after resolving the conflicts, mark the corrected paths\n"
 "with 'git add <paths>' or 'git rm <paths>'"
 msgstr ""
 "nach Auflösung der Konflikte, markieren Sie die korrigierten Pfade\n"
 "mit 'git add <Pfade>' oder 'git rm <Pfade>'"
 
 #: sequencer.c:177
 msgid ""
 "after resolving the conflicts, mark the corrected paths\n"
@@ -1745,27 +1752,27 @@ msgstr ""
 "Ihre lokalen Änderungen würden durch den Cherry-Pick überschrieben werden."
 
 #: sequencer.c:210
 msgid "Your local changes would be overwritten by revert."
 msgstr "Ihre lokalen Änderungen würden durch den Revert überschrieben werden."
 
 #: sequencer.c:213
 msgid "Commit your changes or stash them to proceed."
 msgstr ""
 "Committen Sie Ihre Änderungen oder benutzen Sie \"stash\", um fortzufahren."
 
 #: sequencer.c:228
-#, fuzzy, c-format
+#, c-format
 msgid "%s: fast-forward"
-msgstr "Vorspulen erlauben"
+msgstr "%s: Vorspulen"
 
 #. TRANSLATORS: %s will be "revert" or "cherry-pick"
 #: sequencer.c:303
 #, c-format
 msgid "%s: Unable to write new index file"
 msgstr "%s: Konnte neue Index-Datei nicht schreiben"
 
 #: sequencer.c:321
 msgid "Could not resolve HEAD commit\n"
 msgstr "Konnte Commit von HEAD nicht auflösen\n"
 
 #: sequencer.c:341
@@ -1829,44 +1836,38 @@ msgstr "leere Menge von Commits übergeben"
 
 #: sequencer.c:641
 #, c-format
 msgid "git %s: failed to read the index"
 msgstr "git %s: Fehler beim Lesen des Index"
 
 #: sequencer.c:645
 #, c-format
 msgid "git %s: failed to refresh the index"
 msgstr "git %s: Fehler beim Aktualisieren des Index"
 
 #: sequencer.c:705
-#, fuzzy
 msgid "Cannot revert during another revert."
-msgstr "Kann Zustand des Arbeitsverzeichnisses nicht aufzeichnen"
+msgstr "Kann Revert nicht während eines anderen Reverts ausführen."
 
 #: sequencer.c:706
-#, fuzzy
 msgid "Cannot revert during a cherry-pick."
-msgstr ""
-"Kann keinen Teil-Commit durchführen, während \"cherry-pick\" im Gange ist."
+msgstr "Kann Revert nicht während eines Cherry-Picks ausführen."
 
 #: sequencer.c:709
-#, fuzzy
 msgid "Cannot cherry-pick during a revert."
-msgstr "kein \"cherry-pick\" oder \"revert\" im Gang"
+msgstr "Kann Cherry-Pick nicht während eines Reverts ausführen."
 
 #: sequencer.c:710
-#, fuzzy
 msgid "Cannot cherry-pick during another cherry-pick."
-msgstr ""
-"Kann keinen Teil-Commit durchführen, während \"cherry-pick\" im Gange ist."
+msgstr "Kann Cherry-Pick nicht während eines anderen Cherry-Picks ausführen."
 
 #: sequencer.c:732
 #, c-format
 msgid "Could not parse line %d."
 msgstr "Konnte Zeile %d nicht parsen."
 
 #: sequencer.c:737
 msgid "No commits parsed."
 msgstr "Keine Commits geparst."
 
 #: sequencer.c:749
 #, c-format
@@ -1958,87 +1959,100 @@ msgid "%s: bad revision"
 msgstr "%s: ungültiger Commit"
 
 #: sequencer.c:1102
 msgid "Can't revert as initial commit"
 msgstr "Kann nicht als allerersten Commit einen Revert ausführen."
 
 #: setup.c:160
 #, c-format
 msgid ""
 "%s: no such path in the working tree.\n"
 "Use 'git <command> -- <path>...' to specify paths that do not exist locally."
 msgstr ""
+"%s: kein solcher Pfad im Arbeitsverzeichnis.\n"
+"Benutzen Sie 'git <Befehl> -- <Pfad>...' zur Angabe von Pfaden, die lokal\n"
+"nicht existieren."
 
 #: setup.c:173
 #, c-format
 msgid ""
 "ambiguous argument '%s': unknown revision or path not in the working tree.\n"
 "Use '--' to separate paths from revisions, like this:\n"
 "'git <command> [<revision>...] -- [<file>...]'"
 msgstr ""
+"mehrdeutiges Argument '%s': unbekannter Commit oder Pfad existiert nicht\n"
+"im Arbeitsverzeichnis\n"
+"Benutzen Sie '--', um Pfade und Commits zu trennen, ähnlich wie:\n"
+"'git <Befehl> [<Commit>...] -- [<Datei>...]'"
 
 #: setup.c:223
 #, c-format
 msgid ""
 "ambiguous argument '%s': both revision and filename\n"
 "Use '--' to separate paths from revisions, like this:\n"
 "'git <command> [<revision>...] -- [<file>...]'"
 msgstr ""
+"mehrdeutiges Argument '%s': sowohl Commit als auch Dateiname\n"
+"Benutzen Sie '--', um Pfade und Commits zu trennen, ähnlich wie:\n"
+"'git <Befehl> [<Commit>...] -- [<Datei>...]'"
 
 #: setup.c:248 builtin/apply.c:3362 builtin/apply.c:3373 builtin/apply.c:3419
 #, c-format
 msgid "failed to read %s"
 msgstr "Fehler beim Lesen von %s"
 
 #: setup.c:468
 #, c-format
 msgid "Expected git repo version <= %d, found %d"
 msgstr "Erwartete Git-Repository-Version <= %d, %d gefunden"
 
 #: setup.c:476
 msgid "unknown repository extensions found:"
 msgstr "Unbekannte Repository-Erweiterungen gefunden:"
 
 #: setup.c:762
 #, c-format
 msgid "Not a git repository (or any of the parent directories): %s"
-msgstr ""
+msgstr "Kein Git-Repository (oder irgendein Elternverzeichnis): %s"
 
 #: setup.c:764 setup.c:915 builtin/index-pack.c:1641
 msgid "Cannot come back to cwd"
 msgstr "Kann nicht zurück zu Arbeitsverzeichnis wechseln"
 
 #: setup.c:845
-#, fuzzy
 msgid "Unable to read current working directory"
-msgstr "Konnte aktuelles Arbeitsverzeichnis nicht bekommen."
+msgstr "Konnte aktuelles Arbeitsverzeichnis nicht lesen."
 
 #: setup.c:920
 #, c-format
 msgid ""
 "Not a git repository (or any parent up to mount point %s)\n"
 "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."
 msgstr ""
+"Kein Git-Repository (oder irgendein Elternverzeichnis bis zum Einhängepunkt %s)\n"
+"Stoppe bei Dateisystemgrenze (GIT_DISCOVERY_ACROSS_FILESYSTEM nicht gesetzt)."
 
 #: setup.c:927
-#, fuzzy, c-format
+#, c-format
 msgid "Cannot change to '%s/..'"
-msgstr "kann nicht in Verzeichnis %s wechseln"
+msgstr "Kann nicht in Verzeichnis '%s/..' wechseln"
 
 #: setup.c:989
 #, c-format
 msgid ""
 "Problem with core.sharedRepository filemode value (0%.3o).\n"
 "The owner of files must always have read and write permissions."
 msgstr ""
+"Problem mit Wert für Dateimodus (0%.3o) von core.sharedRepository.\n"
+"Der Besitzer der Dateien muss immer Lese- und Schreibberechtigung haben."
 
 #: sha1_file.c:1046
 msgid "offset before end of packfile (broken .idx?)"
 msgstr "Offset vor Ende der Packdatei (fehlerhafte Indexdatei?)"
 
 #: sha1_file.c:2434
 #, c-format
 msgid "offset before start of pack index for %s (corrupt index?)"
 msgstr "Offset vor Beginn des Pack-Index für %s (beschädigter Index?)"
 
 #: sha1_file.c:2438
 #, c-format
@@ -2150,109 +2164,121 @@ msgid "file %s is not writable by user"
 msgstr "Datei %s ist vom Benutzer nicht beschreibbar."
 
 #: trailer.c:873
 msgid "could not open temporary file"
 msgstr "konnte temporäre Datei '%s' nicht öffnen"
 
 #: trailer.c:912
 #, c-format
 msgid "could not rename temporary file to %s"
 msgstr "konnte temporäre Datei nicht zu %s umbenennen"
 
 #: transport.c:62
-#, fuzzy, c-format
+#, c-format
 msgid "Would set upstream of '%s' to '%s' of '%s'\n"
-msgstr "Konnte Sektion '%s' in Konfiguration nicht nach '%s' umbenennen"
+msgstr "Würde Upstream-Branch von '%s' zu '%s' von '%s' setzen\n"
 
 #: transport.c:151
-#, fuzzy, c-format
+#, c-format
 msgid "transport: invalid depth option '%s'"
-msgstr "Ungültige Option für --decorate: %s"
+msgstr "transport: ungültige --depth Option '%s'"
 
 #: transport.c:771
 #, c-format
 msgid ""
 "The following submodule paths contain changes that can\n"
 "not be found on any remote:\n"
 msgstr ""
+"Die folgenden Submodul-Pfade enthalten Änderungen, die in keinem\n"
+"Remote-Repository gefunden wurden:\n"
 
 #: transport.c:775
 #, c-format
 msgid ""
 "\n"
 "Please try\n"
 "\n"
 "\tgit push --recurse-submodules=on-demand\n"
 "\n"
 "or cd to the path and use\n"
 "\n"
 "\tgit push\n"
 "\n"
 "to push them to a remote.\n"
 "\n"
 msgstr ""
+"\n"
+"Bitte versuchen Sie\n"
+"\n"
+"\tgit push --recurse-submodules=on-demand\n"
+"\n"
+"oder wechseln Sie in das Verzeichnis und benutzen Sie\n"
+"\n"
+"\tgit push\n"
+"\n"
+"zum Versenden zu einem Remote-Repository.\n"
+"\n"
 
 #: transport.c:783
-#, fuzzy
 msgid "Aborting."
-msgstr "Abbruch\n"
+msgstr "Abbruch."
 
 #: transport-helper.c:1041
 #, c-format
 msgid "Could not read ref %s"
 msgstr "Konnte Referenz %s nicht lesen."
 
 #: unpack-trees.c:64
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Your local changes to the following files would be overwritten by checkout:\n"
 "%%sPlease commit your changes or stash them before you switch branches."
 msgstr ""
 "Ihre lokalen Änderungen in den folgenden Dateien würden beim Auschecken\n"
 "überschrieben werden:\n"
-"%%sBitte committen oder stashen Sie Ihre Änderungen, bevor Sie Branches "
+"%%sBitte committen oder stashen Sie Ihre Änderungen, bevor Sie Branches\n"
 "wechseln."
 
 #: unpack-trees.c:66
 #, c-format
 msgid ""
 "Your local changes to the following files would be overwritten by checkout:\n"
 "%%s"
 msgstr ""
 "Ihre lokalen Änderungen in den folgenden Dateien würden beim Auschecken\n"
 "überschrieben werden:\n"
 "%%s"
 
 #: unpack-trees.c:69
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Your local changes to the following files would be overwritten by merge:\n"
 "%%sPlease commit your changes or stash them before you merge."
 msgstr ""
 "Ihre lokalen Änderungen in den folgenden Dateien würden durch den Merge\n"
 "überschrieben werden:\n"
 "%%sBitte committen oder stashen Sie Ihre Änderungen, bevor sie mergen."
 
 #: unpack-trees.c:71
 #, c-format
 msgid ""
 "Your local changes to the following files would be overwritten by merge:\n"
 "%%s"
 msgstr ""
 "Ihre lokalen Änderungen in den folgenden Dateien würden durch den Merge\n"
 "überschrieben werden:\n"
 "%%s"
 
 #: unpack-trees.c:74
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Your local changes to the following files would be overwritten by %s:\n"
 "%%sPlease commit your changes or stash them before you %s."
 msgstr ""
 "Ihre lokalen Änderungen in den folgenden Dateien würden durch %s\n"
 "überschrieben werden:\n"
 "%%sBitte committen oder stashen Sie Ihre Änderungen, bevor Sie %s ausführen."
 
 #: unpack-trees.c:76
 #, c-format
 msgid ""
 "Your local changes to the following files would be overwritten by %s:\n"
@@ -2263,143 +2289,136 @@ msgstr ""
 
 #: unpack-trees.c:81
 #, c-format
 msgid ""
 "Updating the following directories would lose untracked files in it:\n"
 "%s"
 msgstr ""
 "Durch die Aktualisierung der folgenden Verzeichnisse würden unversionierte\n"
 "Dateien in diesen Verzeichnissen verloren gehen:\n"
 "%s"
 
 #: unpack-trees.c:85
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following untracked working tree files would be removed by checkout:\n"
 "%%sPlease move or remove them before you switch branches."
 msgstr ""
 "Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch\n"
 "den Checkout entfernt werden:\n"
 "%%sBitte verschieben oder entfernen Sie diese, bevor Sie Branches wechseln."
 
 #: unpack-trees.c:87
 #, c-format
 msgid ""
 "The following untracked working tree files would be removed by checkout:\n"
 "%%s"
 msgstr ""
 "Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch "
 "den\n"
 "Checkout entfernt werden:\n"
 "%%s"
 
 #: unpack-trees.c:90
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following untracked working tree files would be removed by merge:\n"
 "%%sPlease move or remove them before you merge."
 msgstr ""
-"Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch "
-"den\n"
-"Merge entfernt werden:\n"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch\n"
+"den Merge entfernt werden:\n"
 "%%sBitte verschieben oder entfernen Sie diese, bevor sie mergen."
 
 #: unpack-trees.c:92
 #, c-format
 msgid ""
 "The following untracked working tree files would be removed by merge:\n"
 "%%s"
 msgstr ""
 "Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch "
 "den\n"
 "Merge entfernt werden:\n"
 "%%s"
 
 #: unpack-trees.c:95
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following untracked working tree files would be removed by %s:\n"
 "%%sPlease move or remove them before you %s."
 msgstr ""
-"Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch "
-"den\n"
-"%s entfernt werden:\n"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch\n"
+"den %s entfernt werden:\n"
 "%%sBitte verschieben oder entfernen Sie diese, bevor sie %s ausführen."
 
 #: unpack-trees.c:97
 #, c-format
 msgid ""
 "The following untracked working tree files would be removed by %s:\n"
 "%%s"
 msgstr ""
-"Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch "
-"den\n"
-"%s entfernt werden:\n"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch\n"
+"den %s entfernt werden:\n"
 "%%s"
 
 #: unpack-trees.c:102
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following untracked working tree files would be overwritten by "
 "checkout:\n"
 "%%sPlease move or remove them before you switch branches."
 msgstr ""
-"Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch "
-"den\n"
-"Checkout überschrieben werden:\n"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch\n"
+"den Checkout überschrieben werden:\n"
 "%%sBitte verschieben oder entfernen Sie diese, bevor Sie Branches wechseln."
 
 #: unpack-trees.c:104
 #, c-format
 msgid ""
 "The following untracked working tree files would be overwritten by "
 "checkout:\n"
 "%%s"
 msgstr ""
 "Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch "
 "den\n"
 "Checkout überschrieben werden:\n"
 "%%s"
 
 #: unpack-trees.c:107
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following untracked working tree files would be overwritten by merge:\n"
 "%%sPlease move or remove them before you merge."
 msgstr ""
-"Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch "
-"den\n"
-"Merge überschrieben werden:\n"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch\n"
+"den Merge überschrieben werden:\n"
 "%%sBitte verschieben oder entfernen Sie diese, bevor Sie mergen."
 
 #: unpack-trees.c:109
 #, c-format
 msgid ""
 "The following untracked working tree files would be overwritten by merge:\n"
 "%%s"
 msgstr ""
-"Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch "
-"den\n"
-"Merge überschrieben werden:\n"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch\n"
+"den Merge überschrieben werden:\n"
 "%%s"
 
 #: unpack-trees.c:112
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following untracked working tree files would be overwritten by %s:\n"
 "%%sPlease move or remove them before you %s."
 msgstr ""
-"Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch "
-"den\n"
-"%s überschrieben werden:\n"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch\n"
+"den %s überschrieben werden:\n"
 "%%sBitte verschieben oder entfernen Sie diese, bevor sie %s ausführen."
 
 #: unpack-trees.c:114
 #, c-format
 msgid ""
 "The following untracked working tree files would be overwritten by %s:\n"
 "%%s"
 msgstr ""
 "Die folgenden unversionierten Dateien im Arbeitsverzeichnis würden durch "
 "den\n"
 "%s überschrieben werden:\n"
 "%%s"
@@ -2472,27 +2491,27 @@ msgstr "eine 'file:' URL darf keine Portnummer enthalten"
 msgid "invalid characters in host name"
 msgstr "Hostname enthält ungültige Zeichen"
 
 #: urlmatch.c:244 urlmatch.c:255
 msgid "invalid port number"
 msgstr "ungültige Portnummer"
 
 #: urlmatch.c:322
 msgid "invalid '..' path segment"
 msgstr "ungültiges '..' Pfadsegment"
 
 #: worktree.c:282
-#, fuzzy, c-format
+#, c-format
 msgid "failed to read '%s'"
-msgstr "Fehler beim Lesen von %s"
+msgstr "Fehler beim Lesen von '%s'"
 
 #: wrapper.c:222 wrapper.c:392
 #, c-format
 msgid "could not open '%s' for reading and writing"
 msgstr "Konnte '%s' nicht zum Lesen und Schreiben öffnen."
 
 #: wrapper.c:224 wrapper.c:394 builtin/am.c:778
 #, c-format
 msgid "could not open '%s' for writing"
 msgstr "Konnte '%s' nicht zum Schreiben öffnen."
 
 #: wrapper.c:226 wrapper.c:396 builtin/am.c:324 builtin/am.c:771
@@ -2682,29 +2701,26 @@ msgstr ""
 "Ändern Sie nicht die obige Zeile.\n"
 "Alles unterhalb von ihr wird entfernt."
 
 #: wt-status.c:950
 msgid "You have unmerged paths."
 msgstr "Sie haben nicht zusammengeführte Pfade."
 
 #: wt-status.c:953
 msgid "  (fix conflicts and run \"git commit\")"
 msgstr " (beheben Sie die Konflikte und führen Sie \"git commit\" aus)"
 
 #: wt-status.c:955
-#, fuzzy
 msgid "  (use \"git merge --abort\" to abort the merge)"
-msgstr ""
-"  (benutzen Sie \"git am --abort\", um den ursprünglichen Branch "
-"wiederherzustellen)"
+msgstr "  (benutzen Sie \"git merge --abort\", um den Merge abzubrechen)"
 
 #: wt-status.c:960
 msgid "All conflicts fixed but you are still merging."
 msgstr "Alle Konflikte sind behoben, aber Sie sind immer noch beim Merge."
 
 #: wt-status.c:963
 msgid "  (use \"git commit\" to conclude merge)"
 msgstr "  (benutzen Sie \"git commit\", um den Merge abzuschließen)"
 
 #: wt-status.c:973
 msgid "You are in the middle of an am session."
 msgstr "Eine \"am\"-Sitzung ist im Gange."
@@ -2984,25 +3000,25 @@ msgstr ""
 #, c-format
 msgid "nothing to commit\n"
 msgstr "nichts zu committen\n"
 
 #: wt-status.c:1557
 #, c-format
 msgid "nothing to commit (use -u to show untracked files)\n"
 msgstr ""
 "nichts zu committen (benutzen Sie die Option -u, um unversionierte Dateien "
 "anzuzeigen)\n"
 
 #: wt-status.c:1561
-#, fuzzy, c-format
+#, c-format
 msgid "nothing to commit, working tree clean\n"
 msgstr "nichts zu committen, Arbeitsverzeichnis unverändert\n"
 
 #: wt-status.c:1668
 msgid "Initial commit on "
 msgstr "Initialer Commit auf "
 
 #: wt-status.c:1672
 msgid "HEAD (no branch)"
 msgstr "HEAD (kein Branch)"
 
 #: wt-status.c:1701
@@ -3161,25 +3177,25 @@ msgstr "Hinzufügen von Dateien fehlgeschlagen"
 #: builtin/add.c:336
 msgid "-A and -u are mutually incompatible"
 msgstr "Die Optionen -A und -u sind zueinander inkompatibel."
 
 #: builtin/add.c:343
 msgid "Option --ignore-missing can only be used together with --dry-run"
 msgstr ""
 "Die Option --ignore-missing kann nur zusammen mit --dry-run verwendet werden."
 
 #: builtin/add.c:352
 #, c-format
 msgid "--chmod param '%s' must be either -x or +x"
-msgstr ""
+msgstr "--chmod Parameter '%s' muss entweder -x oder +x sein"
 
 #: builtin/add.c:367
 #, c-format
 msgid "Nothing specified, nothing added.\n"
 msgstr "Nichts spezifiziert, nichts hinzugefügt.\n"
 
 #: builtin/add.c:368
 #, c-format
 msgid "Maybe you wanted to say 'git add .'?\n"
 msgstr "Meinten Sie vielleicht 'git add .'?\n"
 
 #: builtin/add.c:373 builtin/check-ignore.c:172 builtin/checkout.c:279
@@ -4468,34 +4484,33 @@ msgstr "falsch benannten Branch '%s' umbenannt"
 #: builtin/branch.c:597
 #, c-format
 msgid "Branch renamed to %s, but HEAD is not updated!"
 msgstr "Branch umbenannt zu %s, aber HEAD ist nicht aktualisiert!"
 
 #: builtin/branch.c:604
 msgid "Branch is renamed, but update of config-file failed"
 msgstr ""
 "Branch ist umbenannt, aber die Aktualisierung der Konfigurationsdatei ist "
 "fehlgeschlagen."
 
 #: builtin/branch.c:620
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Please edit the description for the branch\n"
 "  %s\n"
 "Lines starting with '%c' will be stripped.\n"
 msgstr ""
-"\n"
-"Geben Sie eine Beschreibung für Tag\n"
+"Bitte ändern Sie die Beschreibung für den Branch\n"
 "  %s\n"
-"ein. Zeilen, die mit '%c' beginnen, werden ignoriert.\n"
+"Zeilen, die mit '%c' beginnen, werden entfernt.\n"
 
 #: builtin/branch.c:651
 msgid "Generic options"
 msgstr "Allgemeine Optionen"
 
 #: builtin/branch.c:653
 msgid "show hash and subject, give twice for upstream branch"
 msgstr "Hash und Betreff anzeigen; -vv: zusätzlich Upstream-Branch"
 
 #: builtin/branch.c:654
 msgid "suppress informational messages"
 msgstr "Informationsmeldungen unterdrücken"
@@ -6313,27 +6328,26 @@ msgstr "die angegebenen Dateien zusätzlich zum Commit vormerken"
 msgid "interactively add files"
 msgstr "interaktives Hinzufügen von Dateien"
 
 #: builtin/commit.c:1618
 msgid "interactively add changes"
 msgstr "interaktives Hinzufügen von Änderungen"
 
 #: builtin/commit.c:1619
 msgid "commit only specified files"
 msgstr "nur die angegebenen Dateien committen"
 
 #: builtin/commit.c:1620
-#, fuzzy
 msgid "bypass pre-commit and commit-msg hooks"
-msgstr "\"pre-commit hook\" umgehen"
+msgstr "Hooks pre-commit und commit-msg umgehen"
 
 #: builtin/commit.c:1621
 msgid "show what would be committed"
 msgstr "anzeigen, was committet werden würde"
 
 #: builtin/commit.c:1632
 msgid "amend previous commit"
 msgstr "vorherigen Commit ändern"
 
 #: builtin/commit.c:1633
 msgid "bypass post-rewrite hook"
 msgstr "\"post-rewrite hook\" umgehen"
@@ -6875,44 +6889,42 @@ msgstr "Refmap"
 
 #: builtin/fetch.c:131 builtin/pull.c:211
 msgid "specify fetch refmap"
 msgstr "Refmap für 'fetch' angeben"
 
 #: builtin/fetch.c:387
 msgid "Couldn't find remote ref HEAD"
 msgstr "Konnte Remote-Referenz von HEAD nicht finden."
 
 #: builtin/fetch.c:503
 #, c-format
 msgid "configuration fetch.output contains invalid value %s"
-msgstr ""
+msgstr "Konfiguration fetch.output enthält ungültigen Wert %s"
 
 #: builtin/fetch.c:592
 #, c-format
 msgid "object %s not found"
 msgstr "Objekt %s nicht gefunden"
 
 #: builtin/fetch.c:596
 msgid "[up to date]"
 msgstr "[aktuell]"
 
 #: builtin/fetch.c:609 builtin/fetch.c:689
 msgid "[rejected]"
 msgstr "[zurückgewiesen]"
 
 #: builtin/fetch.c:610
-#, fuzzy
 msgid "can't fetch in current branch"
-msgstr ""
-"! %-*s %-*s -> %s  (kann \"fetch\" im aktuellen Branch nicht ausführen)"
+msgstr "kann \"fetch\" im aktuellen Branch nicht ausführen"
 
 #: builtin/fetch.c:619
 msgid "[tag update]"
 msgstr "[Tag Aktualisierung]"
 
 #: builtin/fetch.c:620 builtin/fetch.c:653 builtin/fetch.c:669
 #: builtin/fetch.c:684
 msgid "unable to update local ref"
 msgstr "kann lokale Referenz nicht aktualisieren"
 
 #: builtin/fetch.c:639
 msgid "[new tag]"
@@ -6922,27 +6934,26 @@ msgstr "[neues Tag]"
 msgid "[new branch]"
 msgstr "[neuer Branch]"
 
 #: builtin/fetch.c:645
 msgid "[new ref]"
 msgstr "[neue Referenz]"
 
 #: builtin/fetch.c:684
 msgid "forced update"
 msgstr "Aktualisierung erzwungen"
 
 #: builtin/fetch.c:689
-#, fuzzy
 msgid "non-fast-forward"
-msgstr "(kein Vorspulen)"
+msgstr "kein Vorspulen"
 
 #: builtin/fetch.c:733
 #, c-format
 msgid "%s did not send all necessary objects\n"
 msgstr "%s hat nicht alle erforderlichen Objekte gesendet\n"
 
 #: builtin/fetch.c:753
 #, c-format
 msgid "reject %s because shallow roots are not allowed to be updated"
 msgstr ""
 "%s wurde zurückgewiesen, da Ursprungs-Commits von Repositoriesmit "
 "unvollständiger Historie (shallow) nicht aktualisiert werden dürfen."
@@ -7181,27 +7192,26 @@ msgstr "nur Konnektivität prüfen"
 msgid "enable more strict checking"
 msgstr "genauere Prüfung aktivieren"
 
 #: builtin/fsck.c:604
 msgid "write dangling objects in .git/lost-found"
 msgstr "unreferenzierte Objekte nach .git/lost-found schreiben"
 
 #: builtin/fsck.c:605 builtin/prune.c:107
 msgid "show progress"
 msgstr "Fortschrittsanzeige anzeigen"
 
 #: builtin/fsck.c:606
-#, fuzzy
 msgid "show verbose names for reachable objects"
-msgstr "unerreichbare Objekte anzeigen"
+msgstr "erweiterten Namen für erreichbare Objekte anzeigen"
 
 #: builtin/fsck.c:671
 msgid "Checking objects"
 msgstr "Prüfe Objekte"
 
 #: builtin/gc.c:25
 msgid "git gc [<options>]"
 msgstr "git gc [<Optionen>]"
 
 #: builtin/gc.c:72
 #, c-format
 msgid "Invalid %s: '%s'"
@@ -7748,27 +7758,27 @@ msgid "cannot open packfile '%s'"
 msgstr "Kann Paketdatei '%s' nicht öffnen"
 
 #: builtin/index-pack.c:333
 msgid "pack signature mismatch"
 msgstr "Paketsignatur stimmt nicht überein"
 
 #: builtin/index-pack.c:335
 #, c-format
 msgid "pack version %<PRIu32> unsupported"
 msgstr "Paketversion %<PRIu32> nicht unterstützt"
 
 #: builtin/index-pack.c:353
-#, fuzzy, c-format
+#, c-format
 msgid "pack has bad object at offset %<PRIuMAX>: %s"
-msgstr "Paket hat ein ungültiges Objekt bei Versatz %lu: %s"
+msgstr "Paket hat ein ungültiges Objekt bei Versatz %<PRIuMAX>: %s"
 
 #: builtin/index-pack.c:475
 #, c-format
 msgid "inflate returned %d"
 msgstr "Dekomprimierung gab %d zurück"
 
 #: builtin/index-pack.c:524
 msgid "offset value overflow for delta base object"
 msgstr "Wert für Versatz bei Differenzobjekt übergelaufen"
 
 #: builtin/index-pack.c:532
 msgid "delta base offset is out of bound"
@@ -7776,29 +7786,29 @@ msgstr ""
 "Wert für Versatz bei Differenzobjekt liegt außerhalb des gültigen Bereichs"
 
 #: builtin/index-pack.c:540
 #, c-format
 msgid "unknown object type %d"
 msgstr "Unbekannter Objekt-Typ %d"
 
 #: builtin/index-pack.c:571
 msgid "cannot pread pack file"
 msgstr "Kann Paketdatei %s nicht lesen"
 
 #: builtin/index-pack.c:573
-#, fuzzy, c-format
+#, c-format
 msgid "premature end of pack file, %<PRIuMAX> byte missing"
 msgid_plural "premature end of pack file, %<PRIuMAX> bytes missing"
-msgstr[0] "frühzeitiges Ende der Paketdatei, vermisse %lu Byte"
-msgstr[1] "frühzeitiges Ende der Paketdatei, vermisse %lu Bytes"
+msgstr[0] "frühzeitiges Ende der Paketdatei, vermisse %<PRIuMAX> Byte"
+msgstr[1] "frühzeitiges Ende der Paketdatei, vermisse %<PRIuMAX> Bytes"
 
 #: builtin/index-pack.c:599
 msgid "serious inflate inconsistency"
 msgstr "ernsthafte Inkonsistenz nach Dekomprimierung"
 
 #: builtin/index-pack.c:745 builtin/index-pack.c:751 builtin/index-pack.c:774
 #: builtin/index-pack.c:808 builtin/index-pack.c:817
 #, c-format
 msgid "SHA1 COLLISION FOUND WITH %s !"
 msgstr "SHA1 KOLLISION MIT %s GEFUNDEN !"
 
 #: builtin/index-pack.c:748 builtin/pack-objects.c:164
@@ -8028,42 +8038,42 @@ msgstr "%s existiert bereits"
 
 #: builtin/init-db.c:344
 #, c-format
 msgid "unable to handle file type %d"
 msgstr "kann nicht mit Dateityp %d umgehen"
 
 #: builtin/init-db.c:347
 #, c-format
 msgid "unable to move %s to %s"
 msgstr "Konnte %s nicht nach %s verschieben"
 
 #: builtin/init-db.c:402
-#, fuzzy, c-format
+#, c-format
 msgid "Reinitialized existing shared Git repository in %s%s\n"
-msgstr "%s%s Git-Repository in %s%s\n"
+msgstr "Bestehendes verteiltes Git-Repository in %s%s neuinitialisiert\n"
 
 #: builtin/init-db.c:403
-#, fuzzy, c-format
+#, c-format
 msgid "Reinitialized existing Git repository in %s%s\n"
-msgstr "%s%s Git-Repository in %s%s\n"
+msgstr "Bestehendes Git-Repository in %s%s neuinitialisiert\n"
 
 #: builtin/init-db.c:407
-#, fuzzy, c-format
+#, c-format
 msgid "Initialized empty shared Git repository in %s%s\n"
-msgstr "%s%s Git-Repository in %s%s\n"
+msgstr "Leeres verteiltes Git-Repository in %s%s initialisiert\n"
 
 #: builtin/init-db.c:408
-#, fuzzy, c-format
+#, c-format
 msgid "Initialized empty Git repository in %s%s\n"
-msgstr "%s%s Git-Repository in %s%s\n"
+msgstr "Leeres Git-Repository in %s%s initialisiert\n"
 
 #: builtin/init-db.c:455
 msgid ""
 "git init [-q | --quiet] [--bare] [--template=<template-directory>] [--"
 "shared[=<permissions>]] [<directory>]"
 msgstr ""
 "git init [-q | --quiet] [--bare] [--template=<Vorlagenverzeichnis>] [--"
 "shared[=<Berechtigungen>]] [<Verzeichnis>]"
 
 #: builtin/init-db.c:478
 msgid "permissions"
 msgstr "Berechtigungen"
@@ -8862,40 +8872,39 @@ msgstr "Kein Remote-Repository für den aktuellen Branch."
 msgid "No default upstream defined for the current branch."
 msgstr ""
 "Es ist kein Standard-Upstream-Branch für den aktuellen Branch definiert."
 
 #: builtin/merge.c:913
 #, c-format
 msgid "No remote-tracking branch for %s from %s"
 msgstr "Kein Remote-Tracking-Branch für %s von %s"
 
 #: builtin/merge.c:960
 #, c-format
 msgid "Bad value '%s' in environment '%s'"
-msgstr ""
+msgstr "Fehlerhafter Wert '%s' in Umgebungsvariable '%s'"
 
 #: builtin/merge.c:1034
 #, c-format
 msgid "could not close '%s'"
 msgstr "Konnte '%s' nicht schließen"
 
 #: builtin/merge.c:1061
-#, fuzzy, c-format
+#, c-format
 msgid "not something we can merge in %s: %s"
-msgstr "%s - nichts was wir zusammenführen können"
+msgstr "nichts was wir in %s zusammenführen können: %s"
 
 #: builtin/merge.c:1095
-#, fuzzy
 msgid "not something we can merge"
-msgstr "%s - nichts was wir zusammenführen können"
+msgstr "nichts was wir zusammenführen können"
 
 #: builtin/merge.c:1162
 msgid "There is no merge to abort (MERGE_HEAD missing)."
 msgstr "Es gibt keinen Merge zum Abbrechen (MERGE_HEAD fehlt)"
 
 #: builtin/merge.c:1178
 msgid ""
 "You have not concluded your merge (MERGE_HEAD exists).\n"
 "Please, commit your changes before you merge."
 msgstr ""
 "Sie haben Ihren Merge nicht abgeschlossen (MERGE_HEAD existiert).\n"
 "Bitte committen Sie Ihre Änderungen, bevor Sie den Merge ausführen."
@@ -8958,47 +8967,45 @@ msgid "Commit %s does not have a GPG signature."
 msgstr "Commit %s hat keine GPG-Signatur."
 
 #: builtin/merge.c:1296
 #, c-format
 msgid "Commit %s has a good GPG signature by %s\n"
 msgstr "Commit %s hat eine gültige GPG-Signatur von %s\n"
 
 #: builtin/merge.c:1358
 msgid "refusing to merge unrelated histories"
 msgstr "Verweigere den Merge von nicht zusammenhängenden Historien."
 
 #: builtin/merge.c:1367
-#, fuzzy
 msgid "Already up-to-date."
-msgstr "Bereits aktuell!"
+msgstr "Bereits aktuell."
 
 #: builtin/merge.c:1382
 #, c-format
 msgid "Updating %s..%s\n"
 msgstr "Aktualisiere %s..%s\n"
 
 #: builtin/merge.c:1419
 #, c-format
 msgid "Trying really trivial in-index merge...\n"
 msgstr "Probiere wirklich trivialen \"in-index\"-Merge ...\n"
 
 #: builtin/merge.c:1426
 #, c-format
 msgid "Nope.\n"
 msgstr "Nein.\n"
 
 #: builtin/merge.c:1451
-#, fuzzy
 msgid "Already up-to-date. Yeeah!"
-msgstr "Bereits aktuell!"
+msgstr "Bereits aktuell."
 
 #: builtin/merge.c:1457
 msgid "Not possible to fast-forward, aborting."
 msgstr "Vorspulen nicht möglich, breche ab."
 
 #: builtin/merge.c:1480 builtin/merge.c:1559
 #, c-format
 msgid "Rewinding the tree to pristine...\n"
 msgstr "Rücklauf des Verzeichnisses bis zum Ursprung ...\n"
 
 #: builtin/merge.c:1484
 #, c-format
@@ -9362,25 +9369,25 @@ msgid "git notes remove [<object>]"
 msgstr "git notes remove [<Objekt>]"
 
 #: builtin/notes.c:84
 msgid "git notes prune [<options>]"
 msgstr "git notes prune [<Optionen>]"
 
 #: builtin/notes.c:89
 msgid "git notes get-ref"
 msgstr "git notes get-ref"
 
 #: builtin/notes.c:94
 msgid "Write/edit the notes for the following object:"
-msgstr ""
+msgstr "Schreiben/Bearbeiten der Notizen für das folgende Objekt:"
 
 #: builtin/notes.c:147
 #, c-format
 msgid "unable to start 'show' for object '%s'"
 msgstr "konnte 'show' für Objekt '%s' nicht starten"
 
 #: builtin/notes.c:151
 msgid "could not read 'show' output"
 msgstr "Konnte Ausgabe von 'show' nicht lesen."
 
 #: builtin/notes.c:159
 #, c-format
@@ -9504,27 +9511,27 @@ msgid "Missing notes on source object %s. Cannot copy."
 msgstr "Keine Notizen für Quell-Objekt %s. Kopie nicht möglich."
 
 #: builtin/notes.c:587
 #, c-format
 msgid ""
 "The -m/-F/-c/-C options have been deprecated for the 'edit' subcommand.\n"
 "Please use 'git notes add -f -m/-F/-c/-C' instead.\n"
 msgstr ""
 "Die Optionen -m/-F/-c/-C sind für den Unterbefehl 'edit' veraltet.\n"
 "Bitte benutzen Sie stattdessen 'git notes add -f -m/-F/-c/-C'.\n"
 
 #: builtin/notes.c:753
-#, fuzzy, c-format
+#, c-format
 msgid "unknown notes merge strategy %s"
-msgstr "Konnte Merge-Strategie '%s' nicht finden.\n"
+msgstr "unbekannte Merge-Strategie '%s' für Notizen"
 
 #: builtin/notes.c:769
 msgid "General options"
 msgstr "Allgemeine Optionen"
 
 #: builtin/notes.c:771
 msgid "Merge options"
 msgstr "Merge-Optionen"
 
 #: builtin/notes.c:773
 msgid ""
 "resolve notes conflicts using the given strategy (manual/ours/theirs/union/"
@@ -9544,75 +9551,76 @@ msgstr ""
 "committet werden"
 
 #: builtin/notes.c:779
 msgid "Aborting notes merge resolution"
 msgstr "Konfliktauflösung beim Merge von Notizen abbrechen"
 
 #: builtin/notes.c:781
 msgid "abort notes merge"
 msgstr "Merge von Notizen abbrechen"
 
 #: builtin/notes.c:792
 msgid "cannot mix --commit, --abort or -s/--strategy"
-msgstr ""
+msgstr "Kann --commit, --abort oder -s/--strategy nicht kombinieren."
 
 #: builtin/notes.c:797
-#, fuzzy
 msgid "Must specify a notes ref to merge"
-msgstr "Sie müssen ein Repository angeben."
+msgstr "Sie müssen eine Notiz-Referenz zum Mergen angeben."
 
 #: builtin/notes.c:821
-#, fuzzy, c-format
+#, c-format
 msgid "Unknown -s/--strategy: %s"
-msgstr "Unbekannter Typ: %d"
+msgstr "Unbekannter Wert für -s/--strategy: %s"
 
 #: builtin/notes.c:858
 #, c-format
 msgid "A notes merge into %s is already in-progress at %s"
 msgstr "Ein Merge von Notizen nach %s ist bereits im Gange bei %s"
 
 #: builtin/notes.c:861
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to store link to current notes ref (%s)"
-msgstr "Fehler beim Finden des \"Tree\"-Objektes von %s."
+msgstr "Fehler beim Speichern der Verknüpfung zur aktuellen Notes-Referenz (%s)"
 
 #: builtin/notes.c:863
 #, c-format
 msgid ""
 "Automatic notes merge failed. Fix conflicts in %s and commit the result with "
 "'git notes merge --commit', or abort the merge with 'git notes merge --"
 "abort'.\n"
 msgstr ""
+"Automatisches Zusammenführen der Notizen fehlgeschlagen. Beheben Sie die\n"
+"Konflikte in %s und committen Sie das Ergebnis mit 'git notes merge --commit',\n"
+"oder brechen Sie den Merge mit 'git notes merge --abort' ab.\n"
 
 #: builtin/notes.c:885
 #, c-format
 msgid "Object %s has no note\n"
 msgstr "Objekt %s hat keine Notiz\n"
 
 #: builtin/notes.c:897
 msgid "attempt to remove non-existent note is not an error"
 msgstr "der Versuch, eine nicht existierende Notiz zu löschen, ist kein Fehler"
 
 #: builtin/notes.c:900
 msgid "read object names from the standard input"
 msgstr "Objektnamen von der Standard-Eingabe lesen"
 
 #: builtin/notes.c:938 builtin/prune.c:105 builtin/worktree.c:127
 msgid "do not remove, show only"
 msgstr "nicht löschen, nur anzeigen"
 
 #: builtin/notes.c:939
-#, fuzzy
 msgid "report pruned notes"
-msgstr "gelöschte Objekte melden"
+msgstr "gelöschte Notizen melden"
 
 #: builtin/notes.c:981
 msgid "notes-ref"
 msgstr "Notiz-Referenz"
 
 #: builtin/notes.c:982
 msgid "use notes from <notes-ref>"
 msgstr "Notizen von <Notiz-Referenz> verwenden"
 
 #: builtin/notes.c:1017 builtin/remote.c:1623
 #, c-format
 msgid "Unknown subcommand: %s"
@@ -9767,27 +9775,26 @@ msgstr "Objekte einschließen, die vom Index referenziert werden"
 msgid "output pack to stdout"
 msgstr "Paket in die Standard-Ausgabe schreiben"
 
 #: builtin/pack-objects.c:2695
 msgid "include tag objects that refer to objects to be packed"
 msgstr "Tag-Objekte einschließen, die auf gepackte Objekte referenzieren"
 
 #: builtin/pack-objects.c:2697
 msgid "keep unreachable objects"
 msgstr "nicht erreichbare Objekte behalten"
 
 #: builtin/pack-objects.c:2699
-#, fuzzy
 msgid "pack loose unreachable objects"
-msgstr "nicht erreichbare Objekte behalten"
+msgstr "nicht erreichbare lose Objekte packen"
 
 #: builtin/pack-objects.c:2700 parse-options.h:142
 msgid "time"
 msgstr "Zeit"
 
 #: builtin/pack-objects.c:2701
 msgid "unpack unreachable objects newer than <time>"
 msgstr "nicht erreichbare Objekte entpacken, die neuer als <Zeit> sind"
 
 #: builtin/pack-objects.c:2704
 msgid "create thin packs"
 msgstr "dünnere Pakete erzeugen"
@@ -9985,25 +9992,25 @@ msgstr ""
 #: builtin/pull.c:503
 #, c-format
 msgid ""
 "Your configuration specifies to merge with the ref '%s'\n"
 "from the remote, but no such ref was fetched."
 msgstr ""
 "Ihre Konfiguration gibt an, den Merge mit Referenz '%s'\n"
 "des Remote-Repositories durchzuführen, aber diese Referenz\n"
 "wurde nicht angefordert."
 
 #: builtin/pull.c:820
 msgid "ignoring --verify-signatures for rebase"
-msgstr ""
+msgstr "Ignoriere --verify-signatures für Rebase"
 
 #: builtin/pull.c:867
 msgid "--[no-]autostash option is only valid with --rebase."
 msgstr "--[no-]autostash ist nur mit --rebase zulässig."
 
 #: builtin/pull.c:875
 msgid "Updating an unborn branch with changes added to the index."
 msgstr ""
 "Aktualisiere einen ungeborenen Branch mit Änderungen, die zum Commit "
 "vorgemerkt sind."
 
 #: builtin/pull.c:903
@@ -10323,42 +10330,41 @@ msgid "push missing but relevant tags"
 msgstr "fehlende, aber relevante Tags versenden"
 
 #: builtin/push.c:543 builtin/send-pack.c:166
 msgid "GPG sign the push"
 msgstr "signiert \"push\" mit GPG"
 
 #: builtin/push.c:545 builtin/send-pack.c:170
 msgid "request atomic transaction on remote side"
 msgstr "Referenzen atomar versenden"
 
 #: builtin/push.c:546
 msgid "server-specific"
-msgstr ""
+msgstr "serverspezifisch"
 
 #: builtin/push.c:546
-#, fuzzy
 msgid "option to transmit"
-msgstr "nichts zu committen\n"
+msgstr "Optionen übertragen"
 
 #: builtin/push.c:560
 msgid "--delete is incompatible with --all, --mirror and --tags"
 msgstr "Die Option --delete ist inkompatibel mit --all, --mirror und --tags."
 
 #: builtin/push.c:562
 msgid "--delete doesn't make sense without any refs"
 msgstr "Die Option --delete kann nur mit Referenzen verwendet werden."
 
 #: builtin/push.c:579
 msgid "push options must not have new line characters"
-msgstr ""
+msgstr "Push-Optionen dürfen keine Zeilenvorschubzeichen haben"
 
 #: builtin/read-tree.c:37
 msgid ""
 "git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>) "
 "[-u [--exclude-per-directory=<gitignore>] | -i]] [--no-sparse-checkout] [--"
 "index-output=<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])"
 msgstr ""
 "git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<Präfix>) "
 "[-u [--exclude-per-directory=<gitignore>] | -i]] [--no-sparse-checkout] [--"
 "index-output=<Datei>] (--empty | <Commit-Referenz1> [<Commit-Referenz2> "
 "[<Commit-Referenz3>]])"
 
@@ -10689,42 +10695,42 @@ msgstr " ???"
 
 #: builtin/remote.c:955
 #, c-format
 msgid "invalid branch.%s.merge; cannot rebase onto > 1 branch"
 msgstr "ungültiges branch.%s.merge; kann Rebase nicht auf > 1 Branch ausführen"
 
 #: builtin/remote.c:963
 #, c-format
 msgid "rebases interactively onto remote %s"
 msgstr "interaktiver Rebase auf Remote-Branch %s"
 
 #: builtin/remote.c:964
-#, fuzzy, c-format
+#, c-format
 msgid "rebases onto remote %s"
-msgstr "interaktiver Rebase auf Remote-Branch %s"
+msgstr "Rebase auf Remote-Branch %s"
 
 #: builtin/remote.c:967
 #, c-format
 msgid " merges with remote %s"
 msgstr " führt mit Remote-Branch %s zusammen"
 
 #: builtin/remote.c:970
 #, c-format
 msgid "merges with remote %s"
 msgstr "führt mit Remote-Branch %s zusammen"
 
 #: builtin/remote.c:973
-#, fuzzy, c-format
+#, c-format
 msgid "%-*s    and with remote %s\n"
-msgstr "    und mit Remote-Branch"
+msgstr "%-*s    und mit Remote-Branch %s\n"
 
 #: builtin/remote.c:1016
 msgid "create"
 msgstr "erstellt"
 
 #: builtin/remote.c:1019
 msgid "delete"
 msgstr "gelöscht"
 
 #: builtin/remote.c:1023
 msgid "up to date"
 msgstr "aktuell"
@@ -10779,32 +10785,30 @@ msgstr "(keine URL)"
 #. the one in "  Fetch URL: %s" translation
 #: builtin/remote.c:1154 builtin/remote.c:1156
 #, c-format
 msgid "  Push  URL: %s"
 msgstr "  URL zum Versenden: %s"
 
 #: builtin/remote.c:1158 builtin/remote.c:1160 builtin/remote.c:1162
 #, c-format
 msgid "  HEAD branch: %s"
 msgstr "  Hauptbranch: %s"
 
 #: builtin/remote.c:1158
-#, fuzzy
 msgid "(not queried)"
-msgstr " (Zustand nicht abgefragt)"
+msgstr "(nicht abgefragt)"
 
 #: builtin/remote.c:1160
-#, fuzzy
 msgid "(unknown)"
-msgstr "unbekannt:"
+msgstr "(unbekannt)"
 
 #: builtin/remote.c:1164
 #, c-format
 msgid ""
 "  HEAD branch (remote HEAD is ambiguous, may be one of the following):\n"
 msgstr ""
 "  Hauptbranch (externer HEAD ist mehrdeutig, könnte einer der folgenden "
 "sein):\n"
 
 #: builtin/remote.c:1176
 #, c-format
 msgid "  Remote branch:%s"
@@ -10997,27 +11001,26 @@ msgstr "--local an git-pack-objects übergeben"
 msgid "write bitmap index"
 msgstr "Bitmap-Index schreiben"
 
 #: builtin/repack.c:177
 msgid "approxidate"
 msgstr "Datumsangabe"
 
 #: builtin/repack.c:178
 msgid "with -A, do not loosen objects older than this"
 msgstr "mit -A, keine Objekte älter als dieses Datum löschen"
 
 #: builtin/repack.c:180
-#, fuzzy
 msgid "with -a, repack unreachable objects"
-msgstr "nicht erreichbare Objekte behalten"
+msgstr "mit -a, nicht erreichbare Objekte neu packen"
 
 #: builtin/repack.c:182
 msgid "size of the window used for delta compression"
 msgstr "Größe des Fensters für die Delta-Kompression"
 
 #: builtin/repack.c:183 builtin/repack.c:187
 msgid "bytes"
 msgstr "Bytes"
 
 #: builtin/repack.c:184
 msgid "same as the above, but limit memory size instead of entries count"
 msgstr ""
@@ -11033,27 +11036,26 @@ msgid "maximum size of each packfile"
 msgstr "maximale Größe für jede Paketdatei"
 
 #: builtin/repack.c:190
 msgid "repack objects in packs marked with .keep"
 msgstr ""
 "Objekte umpacken, die sich in mit .keep markierten Pack-Dateien befinden"
 
 #: builtin/repack.c:200
 msgid "cannot delete packs in a precious-objects repo"
 msgstr "kann Pack-Dateien in precious-objects Repository nicht löschen"
 
 #: builtin/repack.c:204
-#, fuzzy
 msgid "--keep-unreachable and -A are incompatible"
-msgstr "--column und -n sind inkompatibel"
+msgstr "--keep-unreachable und -A sind inkompatibel"
 
 #: builtin/repack.c:391 builtin/worktree.c:115
 #, c-format
 msgid "failed to remove '%s'"
 msgstr "Fehler beim Löschen von '%s'"
 
 #: builtin/replace.c:19
 msgid "git replace [-f] <object> <replacement>"
 msgstr "git replace [-f] <Objekt> <Ersetzung>"
 
 #: builtin/replace.c:20
 msgid "git replace [-f] --edit <object>"
@@ -11821,32 +11823,32 @@ msgstr "Meinten Sie vielleicht 'update --init'?"
 
 #: builtin/submodule--helper.c:641
 #, c-format
 msgid "Skipping unmerged submodule %s"
 msgstr "Überspringe nicht zusammengeführtes Submodul %s"
 
 #: builtin/submodule--helper.c:662
 #, c-format
 msgid "Skipping submodule '%s'"
 msgstr "Überspringe Submodul '%s'"
 
 #: builtin/submodule--helper.c:792
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to clone '%s'. Retry scheduled"
-msgstr "Fehler beim Kopieren der Notizen von '%s' nach '%s'"
+msgstr "Fehler beim Klonen von '%s'. Weiterer Versuch geplant"
 
 #: builtin/submodule--helper.c:803
 #, c-format
 msgid "Failed to clone '%s' a second time, aborting"
-msgstr ""
+msgstr "Zweiter Versuch '%s' zu klonen fehlgeschlagen, breche ab."
 
 #: builtin/submodule--helper.c:824
 msgid "path into the working tree"
 msgstr "Pfad zum Arbeitsverzeichnis"
 
 #: builtin/submodule--helper.c:827
 msgid "path into the working tree, across nested submodule boundaries"
 msgstr ""
 "Pfad zum Arbeitsverzeichnis, über verschachtelte Submodul-Grenzen hinweg"
 
 #: builtin/submodule--helper.c:831
 msgid "rebase, merge, checkout or none"
@@ -11857,43 +11859,47 @@ msgid "Create a shallow clone truncated to the specified number of revisions"
 msgstr ""
 "Erstellung eines Klons mit unvollständiger Historie (shallow), abgeschnitten "
 "bei\n"
 "der angegebenen Anzahl von Commits."
 
 #: builtin/submodule--helper.c:838
 msgid "parallel jobs"
 msgstr "Parallele Ausführungen"
 
 #: builtin/submodule--helper.c:840
 msgid "whether the initial clone should follow the shallow recommendation"
 msgstr ""
+"ob das initiale Klonen den Empfehlungen für eine unvollständige\n"
+"Historie (shallow) folgen soll"
 
 #: builtin/submodule--helper.c:841
 msgid "don't print cloning progress"
 msgstr "keine Fortschrittsanzeige beim Klonen"
 
 #: builtin/submodule--helper.c:846
 msgid "git submodule--helper update_clone [--prefix=<path>] [<path>...]"
 msgstr "git submodule--helper update_clone [--prefix=<Pfad>] [<Pfad>...]"
 
 #: builtin/submodule--helper.c:856
 msgid "bad value for update parameter"
 msgstr "Fehlerhafter Wert für --update Parameter"
 
 #: builtin/submodule--helper.c:927
 #, c-format
 msgid ""
 "Submodule (%s) branch configured to inherit branch from superproject, but "
 "the superproject is not on any branch"
 msgstr ""
+"Branch von Submodul (%s) ist konfiguriert, den Branch des Hauptprojektes\n"
+"zu erben, aber das Hauptprojekt befindet sich auf keinem Branch."
 
 #: builtin/submodule--helper.c:977
 msgid "submodule--helper subcommand must be called with a subcommand"
 msgstr "submodule--helper muss mit einem Unterbefehl aufgerufen werden"
 
 #: builtin/submodule--helper.c:984
 #, c-format
 msgid "'%s' is not a valid submodule--helper subcommand"
 msgstr "'%s' ist kein gültiger Unterbefehl von submodule--helper"
 
 #: builtin/symbolic-ref.c:7
 msgid "git symbolic-ref [<options>] <name> [<ref>]"
@@ -12406,36 +12412,34 @@ msgstr "git verify-tag [-v | --verbose] <Tag>..."
 msgid "print tag contents"
 msgstr "Tag-Inhalte ausgeben"
 
 #: builtin/worktree.c:15
 msgid "git worktree add [<options>] <path> [<branch>]"
 msgstr "git worktree add [<Optionen>] <Pfad> [<Branch>]"
 
 #: builtin/worktree.c:16
 msgid "git worktree list [<options>]"
 msgstr "git worktree list [<Optionen>]"
 
 #: builtin/worktree.c:17
-#, fuzzy
 msgid "git worktree lock [<options>] <path>"
-msgstr "git worktree list [<Optionen>]"
+msgstr "git worktree lock [<Optionen>] <Pfad>"
 
 #: builtin/worktree.c:18
 msgid "git worktree prune [<options>]"
 msgstr "git worktree prune [<Optionen>]"
 
 #: builtin/worktree.c:19
-#, fuzzy
 msgid "git worktree unlock <path>"
-msgstr "git worktree prune [<Optionen>]"
+msgstr "git worktree unlock <Pfad>"
 
 #: builtin/worktree.c:42
 #, c-format
 msgid "Removing worktrees/%s: not a valid directory"
 msgstr "Lösche worktrees/%s: kein gültiges Verzeichnis"
 
 #: builtin/worktree.c:48
 #, c-format
 msgid "Removing worktrees/%s: gitdir file does not exist"
 msgstr "Lösche worktrees/%s: gitdir-Datei existiert nicht"
 
 #: builtin/worktree.c:53
@@ -12483,86 +12487,85 @@ msgid "create or reset a branch"
 msgstr "Branch erstellen oder umsetzen"
 
 #: builtin/worktree.c:329
 msgid "populate the new working tree"
 msgstr "das neue Arbeitsverzeichnis auschecken"
 
 #: builtin/worktree.c:337
 msgid "-b, -B, and --detach are mutually exclusive"
 msgstr "-b, -B und --detach schließen sich gegenseitig aus"
 
 #: builtin/worktree.c:470
 msgid "reason for locking"
-msgstr ""
+msgstr "Sperrgrund"
 
 #: builtin/worktree.c:482 builtin/worktree.c:515
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' is not a working tree"
-msgstr "'%s' ist kein Commit"
+msgstr "'%s' ist kein Arbeitsverzeichnis"
 
 #: builtin/worktree.c:484 builtin/worktree.c:517
 msgid "The main working tree cannot be locked or unlocked"
-msgstr ""
+msgstr "Das Hauptarbeitsverzeichnis kann nicht gesperrt oder entsperrt werden."
 
 #: builtin/worktree.c:489
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' is already locked, reason: %s"
-msgstr "'%s' ist bereits in '%s' ausgecheckt"
+msgstr "'%s' ist bereits gesperrt, Grund: %s"
 
 #: builtin/worktree.c:491
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' is already locked"
-msgstr "'%s' ist bereits in '%s' ausgecheckt"
+msgstr "'%s' ist bereits gesperrt"
 
 #: builtin/worktree.c:519
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' is not locked"
-msgstr "'%s' ist kein Commit"
+msgstr "'%s' ist nicht gesperrt"
 
 #: builtin/write-tree.c:13
 msgid "git write-tree [--missing-ok] [--prefix=<prefix>/]"
 msgstr "git write-tree [--missing-ok] [--prefix=<Präfix>/]"
 
 #: builtin/write-tree.c:26
 msgid "<prefix>/"
 msgstr "<Präfix>/"
 
 #: builtin/write-tree.c:27
 msgid "write tree object for a subdirectory <prefix>"
 msgstr "das \"Tree\"-Objekt für ein Unterverzeichnis <Präfix> schreiben"
 
 #: builtin/write-tree.c:30
 msgid "only useful for debugging"
 msgstr "nur nützlich für Fehlersuche"
 
 #: upload-pack.c:20
-#, fuzzy
 msgid "git upload-pack [<options>] <dir>"
-msgstr "git repack [<Optionen>]"
+msgstr "git upload-pack [<Optionen>] <Verzeichnis>"
 
 #: upload-pack.c:837
 msgid "quit after a single request/response exchange"
-msgstr ""
+msgstr "nach einem einzigen Request/Response-Austausch beenden"
 
 #: upload-pack.c:839
 msgid "exit immediately after initial ref advertisement"
-msgstr ""
+msgstr "direkt nach der initialen Angabe der Commits beenden"
 
 #: upload-pack.c:841
 msgid "do not try <directory>/.git/ if <directory> is no Git directory"
-msgstr ""
+msgstr "kein Versuch in <Verzeichnis>/.git/ wenn <Verzeichnis> kein Git-Verzeichnis ist"
 
 #: upload-pack.c:843
 msgid "interrupt transfer after <n> seconds of inactivity"
-msgstr ""
+msgstr "Übertragung nach <n> Sekunden Inaktivität unterbrechen"
 
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
@@ -12759,27 +12762,27 @@ msgstr "Ungültiger HEAD - merkwürdige symbolische Referenz"
 
 #: git-bisect.sh:233
 #, sh-format
 msgid "Bad bisect_write argument: $state"
 msgstr "Ungültiges \"bisect_write\" Argument: $state"
 
 #: git-bisect.sh:262
 #, sh-format
 msgid "Bad rev input: $arg"
 msgstr "Ungültige Referenz-Eingabe: $arg"
 
 #: git-bisect.sh:281
-#, fuzzy, sh-format
+#, sh-format
 msgid "Bad rev input: $bisected_head"
-msgstr "Ungültige Referenz-Eingabe: $arg"
+msgstr "Ungültige Referenz-Eingabe: $bisected_head"
 
 #: git-bisect.sh:290
 #, sh-format
 msgid "Bad rev input: $rev"
 msgstr "Ungültige Referenz-Eingabe: $rev"
 
 #: git-bisect.sh:299
 #, sh-format
 msgid "'git bisect $TERM_BAD' can take only one argument."
 msgstr "'git bisect $TERM_BAD' kann nur ein Argument entgegennehmen."
 
 #: git-bisect.sh:322
@@ -12911,65 +12914,62 @@ msgid "no terms defined"
 msgstr "Keine Begriffe definiert."
 
 #: git-bisect.sh:653
 #, sh-format
 msgid ""
 "invalid argument $arg for 'git bisect terms'.\n"
 "Supported options are: --term-good|--term-old and --term-bad|--term-new."
 msgstr ""
 "Ungültiges Argument $arg für 'git bisect terms'.\n"
 "Unterstützte Optionen sind: --term-good|--term-old und --term-bad|--term-new."
 
 #: git-merge-octopus.sh:46
-#, fuzzy
 msgid ""
 "Error: Your local changes to the following files would be overwritten by "
 "merge"
 msgstr ""
-"Ihre lokalen Änderungen in den folgenden Dateien würden durch den Merge\n"
-"überschrieben werden:\n"
-"%%s"
+"Fehler Ihre lokalen Änderungen in den folgenden Dateien würden durch den Merge\n"
+"überschrieben werden"
 
 #: git-merge-octopus.sh:61
 msgid "Automated merge did not work."
-msgstr ""
+msgstr "Automatischer Merge hat nicht funktioniert."
 
 #: git-merge-octopus.sh:62
-#, fuzzy
 msgid "Should not be doing an Octopus."
-msgstr "Konnte Ausgabe nicht umleiten."
+msgstr "Sollte keinen Octopus-Merge ausführen."
 
 #: git-merge-octopus.sh:73
 #, sh-format
 msgid "Unable to find common commit with $pretty_name"
-msgstr ""
+msgstr "Konnte keinen gemeinsamen Commit mit $pretty_name finden."
 
 #: git-merge-octopus.sh:77
-#, fuzzy, sh-format
+#, sh-format
 msgid "Already up-to-date with $pretty_name"
-msgstr "Bereits aktuell!"
+msgstr "Bereits aktuell mit $pretty_name"
 
 #: git-merge-octopus.sh:89
-#, fuzzy, sh-format
+#, sh-format
 msgid "Fast-forwarding to: $pretty_name"
-msgstr "$branch_name zu $onto_name vorgespult."
+msgstr "Spule vor zu: $pretty_name"
 
 #: git-merge-octopus.sh:97
 #, sh-format
 msgid "Trying simple merge with $pretty_name"
-msgstr ""
+msgstr "Versuche einfachen Merge mit $pretty_name"
 
 #: git-merge-octopus.sh:102
 msgid "Simple merge did not work, trying automatic merge."
-msgstr ""
+msgstr "Einfacher Merge hat nicht funktioniert, versuche automatischen Merge."
 
 #: git-rebase.sh:56
 msgid ""
 "When you have resolved this problem, run \"git rebase --continue\".\n"
 "If you prefer to skip this patch, run \"git rebase --skip\" instead.\n"
 "To check out the original branch and stop rebasing, run \"git rebase --abort"
 "\"."
 msgstr ""
 "Wenn Sie das Problem aufgelöst haben, führen Sie \"git rebase --continue\" "
 "aus.\n"
 "Falls Sie diesen Patch auslassen möchten, führen Sie stattdessen \"git "
 "rebase --skip\" aus.\n"
@@ -13175,25 +13175,25 @@ msgstr "Keine lokalen Änderungen zum Speichern"
 
 #: git-stash.sh:263
 msgid "Cannot initialize stash"
 msgstr "Kann \"stash\" nicht initialisieren"
 
 #: git-stash.sh:267
 msgid "Cannot save the current status"
 msgstr "Kann den aktuellen Status nicht speichern"
 
 #: git-stash.sh:268
 #, sh-format
 msgid "Saved working directory and index state $stash_msg"
-msgstr ""
+msgstr "Speicherte Arbeitsverzeichnis und Index-Status $stash_msg"
 
 #: git-stash.sh:285
 msgid "Cannot remove worktree changes"
 msgstr "Kann Änderungen im Arbeitsverzeichnis nicht löschen"
 
 #: git-stash.sh:404
 #, sh-format
 msgid "unknown option: $opt"
 msgstr "unbekannte Option: $opt"
 
 #: git-stash.sh:414
 msgid "No stash found."
@@ -13236,25 +13236,25 @@ msgid "Could not save index tree"
 msgstr "Konnte Index-Verzeichnis nicht speichern"
 
 #: git-stash.sh:522
 msgid "Cannot unstage modified files"
 msgstr "Kann geänderte Dateien nicht aus dem Index entfernen"
 
 #: git-stash.sh:537
 msgid "Index was not unstashed."
 msgstr "Index wurde nicht aus dem Stash zurückgeladen."
 
 #: git-stash.sh:551
 msgid "The stash is kept in case you need it again."
-msgstr ""
+msgstr "Der Stash wird behalten, im Falle Sie benötigen diesen nochmal."
 
 #: git-stash.sh:560
 #, sh-format
 msgid "Dropped ${REV} ($s)"
 msgstr "Gelöscht ${REV} ($s)"
 
 #: git-stash.sh:561
 #, sh-format
 msgid "${REV}: Could not drop stash entry"
 msgstr "${REV}: Konnte \"stash\"-Eintrag nicht löschen"
 
 #: git-stash.sh:569
@@ -13310,24 +13310,29 @@ msgstr ""
 "Repositories:"
 
 #: git-submodule.sh:244
 #, sh-format
 msgid ""
 "If you want to reuse this local git directory instead of cloning again from\n"
 "  $realrepo\n"
 "use the '--force' option. If the local git directory is not the correct "
 "repo\n"
 "or you are unsure what this means choose another name with the '--name' "
 "option."
 msgstr ""
+"Wenn Sie das lokale Git-Verzeichnis wiederverwenden wollen, anstatt erneut von\n"
+"  $realrepo\n"
+"zu klonen, benutzen Sie die Option '--force'. Wenn das lokale Git-Verzeichnis\n"
+"nicht das korrekte Repository ist oder Sie unsicher sind, was das bedeutet,\n"
+"wählen Sie einen anderen Namen mit der Option '--name'."
 
 #: git-submodule.sh:250
 #, sh-format
 msgid "Reactivating local git directory for submodule '$sm_name'."
 msgstr "Reaktiviere lokales Git-Verzeichnis für Submodul '$sm_name'."
 
 #: git-submodule.sh:262
 #, sh-format
 msgid "Unable to checkout submodule '$sm_path'"
 msgstr "Kann Submodul '$sm_path' nicht auschecken"
 
 #: git-submodule.sh:267
@@ -13354,33 +13359,32 @@ msgstr "Stoppe bei '$displaypath'; Skript gab nicht-Null Status zurück."
 #, sh-format
 msgid "pathspec and --all are incompatible"
 msgstr "Pfadspezifikationen und --all sind inkompatibel."
 
 #: git-submodule.sh:419
 #, sh-format
 msgid "Use '--all' if you really want to deinitialize all submodules"
 msgstr ""
 "Verwenden Sie '--all', wenn Sie wirklich alle Submodule deinitialisieren\n"
 "möchten."
 
 #: git-submodule.sh:439
-#, fuzzy, sh-format
+#, sh-format
 msgid ""
 "Submodule work tree '$displaypath' contains a .git directory\n"
 "(use 'rm -rf' if you really want to remove it including all of its history)"
 msgstr ""
-"Submodul '%s' (oder ein geschachteltes Submodul hiervon) verwendet\n"
-"ein .git-Verzeichnis (benutzen Sie 'rm -rf' wenn Sie dieses wirklich "
-"mitsamt\n"
-"seiner Historie löschen möchten)"
+"Arbeitsverzeichnis von Submodul in '$displaypath' enthält ein .git-Verzeichnis\n"
+"(benutzen Sie 'rm -rf' wenn Sie dieses wirklich mitsamt seiner Historie löschen\n"
+"möchten)"
 
 #: git-submodule.sh:447
 #, sh-format
 msgid ""
 "Submodule work tree '$displaypath' contains local modifications; use '-f' to "
 "discard them"
 msgstr ""
 "Arbeitsverzeichnis von Submodul in '$displaypath' enthält lokale Änderungen; "
 "verwenden Sie '-f', um diese zu verwerfen"
 
 #: git-submodule.sh:450
 #, sh-format
@@ -13408,41 +13412,45 @@ msgstr ""
 
 #: git-submodule.sh:612
 #, sh-format
 msgid "Unable to find current revision in submodule path '$displaypath'"
 msgstr "Konnte aktuellen Commit in Submodul-Pfad '$displaypath' nicht finden."
 
 #: git-submodule.sh:622
 #, sh-format
 msgid "Unable to fetch in submodule path '$sm_path'"
 msgstr "Konnte \"fetch\" in Submodul-Pfad '$sm_path' nicht ausführen"
 
 #: git-submodule.sh:627
-#, fuzzy, sh-format
+#, sh-format
 msgid ""
 "Unable to find current ${remote_name}/${branch} revision in submodule path "
 "'$sm_path'"
-msgstr "Konnte aktuellen Commit in Submodul-Pfad '$displaypath' nicht finden."
+msgstr ""
+"Konnte aktuellen Commit von ${remote_name}/${branch} in Submodul-Pfad\n"
+"'$sm_path' nicht finden."
 
 #: git-submodule.sh:645
 #, sh-format
 msgid "Unable to fetch in submodule path '$displaypath'"
 msgstr "Konnte \"fetch\" in Submodul-Pfad '$displaypath' nicht ausführen"
 
 #: git-submodule.sh:651
 #, sh-format
 msgid ""
 "Fetched in submodule path '$displaypath', but it did not contain $sha1. "
 "Direct fetching of that commit failed."
 msgstr ""
+"\"fetch\" in Submodul-Pfad '$displaypath' ausgeführt, aber $sha1 nicht\n"
+"enthalten. Direktes Anfordern dieses Commits ist fehlgeschlagen."
 
 #: git-submodule.sh:658
 #, sh-format
 msgid "Unable to checkout '$sha1' in submodule path '$displaypath'"
 msgstr "Konnte '$sha1' in Submodul-Pfad '$displaypath' nicht auschecken."
 
 #: git-submodule.sh:659
 #, sh-format
 msgid "Submodule path '$displaypath': checked out '$sha1'"
 msgstr "Submodul-Pfad: '$displaypath': '$sha1' ausgecheckt"
 
 #: git-submodule.sh:663
@@ -13521,420 +13529,471 @@ msgstr "Fehler bei Rekursion in Submodul-Pfad '$sm_path'"
 #, sh-format
 msgid "Synchronizing submodule url for '$displaypath'"
 msgstr "Synchronisiere Submodul-URL für '$displaypath'"
 
 #: git-parse-remote.sh:89
 #, sh-format
 msgid "See git-${cmd}(1) for details."
 msgstr "Siehe git-${cmd}(1) für weitere Details."
 
 #: git-rebase--interactive.sh:131
 #, sh-format
 msgid "Rebasing ($new_count/$total)"
-msgstr ""
+msgstr "Führe Rebase aus ($new_count/$total)"
 
 #: git-rebase--interactive.sh:147
 msgid ""
 "\n"
 "Commands:\n"
 " p, pick = use commit\n"
 " r, reword = use commit, but edit the commit message\n"
 " e, edit = use commit, but stop for amending\n"
 " s, squash = use commit, but meld into previous commit\n"
 " f, fixup = like \"squash\", but discard this commit's log message\n"
 " x, exec = run command (the rest of the line) using shell\n"
 " d, drop = remove commit\n"
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n"
 msgstr ""
+"\n"
+"Befehle:\n"
+" p, pick = Commit verwenden\n"
+" r, reword = Commit verwenden, aber Commit-Beschreibung bearbeiten\n"
+" e, edit = Commit verwenden, aber zum Nachbessern anhalten\n"
+" s, squash = Commit verwenden, aber mit vorherigem Commit vereinen\n"
+" f, fixup = wie \"squash\", aber die Log-Nachricht des Commits verwerden\n"
+" x, exec = Befehl (Rest der Zeile) mittels Shell ausführen\n"
+" d, drop = Commit entfernen\n"
+"\n"
+"Diese Zeilen können umsortiert werden; Sie werden von oben nach unten\n"
+"ausgeführt.\n"
 
 #: git-rebase--interactive.sh:162
 msgid ""
 "\n"
 "Do not remove any line. Use 'drop' explicitly to remove a commit.\n"
 msgstr ""
+"\n"
+"Keine Zeile entfernen. Benutzen Sie 'drop', um explizit einen Commit zu\n"
+"entfernen.\n"
 
 #: git-rebase--interactive.sh:166
 msgid ""
 "\n"
 "If you remove a line here THAT COMMIT WILL BE LOST.\n"
-msgstr ""
+msgstr "\nWenn Sie hier eine Zeile entfernen, wird DIESER COMMIT VERLOREN GEHEN.\n"
 
 #: git-rebase--interactive.sh:202
 #, sh-format
 msgid ""
 "You can amend the commit now, with\n"
 "\n"
 "\tgit commit --amend $gpg_sign_opt_quoted\n"
 "\n"
 "Once you are satisfied with your changes, run\n"
 "\n"
 "\tgit rebase --continue"
 msgstr ""
+"Sie können den Commit nun nachbessern mit:\n"
+"\n"
+"\tgit commit --amend $gpg_sign_opt_quoted\n"
+"\n"
+"Sobald Sie mit Ihren Änderungen zufrieden sind, führen Sie aus:\n"
+"\n"
+"\tgit rebase --continue"
 
 #: git-rebase--interactive.sh:227
 #, sh-format
 msgid "$sha1: not a commit that can be picked"
-msgstr ""
+msgstr "$sha1: kein Commit der gepickt werden kann"
 
 #: git-rebase--interactive.sh:266
-#, fuzzy, sh-format
+#, sh-format
 msgid "Invalid commit name: $sha1"
-msgstr "Ungültiger Commit: %s"
+msgstr "Ungültiger Commit-Name: $sha1"
 
 #: git-rebase--interactive.sh:308
-#, fuzzy
 msgid "Cannot write current commit's replacement sha1"
-msgstr "Kann den aktuellen Zustand des Arbeitsverzeichnisses nicht speichern"
+msgstr "Kann ersetzenden SHA-1 des aktuellen Commits nicht schreiben"
 
 #: git-rebase--interactive.sh:360
-#, fuzzy, sh-format
+#, sh-format
 msgid "Fast-forward to $sha1"
-msgstr "vorspulbar"
+msgstr "Spule vor zu $sha1"
 
 #: git-rebase--interactive.sh:362
-#, fuzzy, sh-format
+#, sh-format
 msgid "Cannot fast-forward to $sha1"
-msgstr "Kann $stash_sha1 nicht speichern."
+msgstr "Kann nicht zu $sha1 vorspulen"
 
 #: git-rebase--interactive.sh:371
 #, sh-format
 msgid "Cannot move HEAD to $first_parent"
-msgstr ""
+msgstr "Kann HEAD nicht auf $first_parent setzen"
 
 #: git-rebase--interactive.sh:376
 #, sh-format
 msgid "Refusing to squash a merge: $sha1"
-msgstr ""
+msgstr "\"squash\" eines Merges ($sha1) zurückgewiesen."
 
 #: git-rebase--interactive.sh:390
-#, fuzzy, sh-format
+#, sh-format
 msgid "Error redoing merge $sha1"
-msgstr "Fehler beim Erzeugen der \"Tree\"-Objekte"
+msgstr "Fehler beim Wiederholen des Merges von $sha1"
 
 #: git-rebase--interactive.sh:398
-#, fuzzy, sh-format
+#, sh-format
 msgid "Could not pick $sha1"
-msgstr "Konnte %s nicht öffnen"
+msgstr "Konnte $sha1 nicht picken"
 
 #: git-rebase--interactive.sh:407
-#, fuzzy, sh-format
+#, sh-format
 msgid "This is the commit message #${n}:"
-msgstr "Commit-Beschreibung bearbeiten"
+msgstr "Das ist Commit-Beschreibung #${n}:"
 
 #: git-rebase--interactive.sh:412
-#, fuzzy, sh-format
+#, sh-format
 msgid "The commit message #${n} will be skipped:"
-msgstr "Commit-Beschreibung bearbeiten"
+msgstr "Commit-Beschreibung #${n} wird ausgelassen:"
 
 #: git-rebase--interactive.sh:423
 #, sh-format
 msgid "This is a combination of $count commit."
 msgid_plural "This is a combination of $count commits."
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "Das ist eine Kombination aus $count Commit."
+msgstr[1] "Das ist eine Kombination aus $count Commits."
 
 #: git-rebase--interactive.sh:431
-#, fuzzy, sh-format
+#, sh-format
 msgid "Cannot write $fixup_msg"
-msgstr "Kann nicht überschreiben"
+msgstr "Kann $fixup_msg nicht schreiben"
 
 #: git-rebase--interactive.sh:434
 msgid "This is a combination of 2 commits."
-msgstr ""
+msgstr "Das ist eine Kombination aus 2 Commits."
 
 #: git-rebase--interactive.sh:435
-#, fuzzy
 msgid "This is the 1st commit message:"
-msgstr "Commit-Beschreibung bearbeiten"
+msgstr "Das ist die erste Commit-Beschreibung:"
 
 #: git-rebase--interactive.sh:475 git-rebase--interactive.sh:518
 #: git-rebase--interactive.sh:521
-#, fuzzy, sh-format
+#, sh-format
 msgid "Could not apply $sha1... $rest"
-msgstr "Konnte %s... (%s) nicht anwenden"
+msgstr "Konnte $sha1... ($rest) nicht anwenden"
 
 #: git-rebase--interactive.sh:549
 #, sh-format
 msgid ""
 "Could not amend commit after successfully picking $sha1... $rest\n"
 "This is most likely due to an empty commit message, or the pre-commit hook\n"
 "failed. If the pre-commit hook failed, you may need to resolve the issue "
 "before\n"
 "you are able to reword the commit."
 msgstr ""
+"Konnte Commit nicht nachbessern, nachdem dieser verwendet wurde: $sha1... $rest\n"
+"Das passierte sehr wahrscheinlich wegen einer leeren Commit-Beschreibung, oder\n"
+"weil der pre-commit Hook fehlschlug. Falls der pre-commit Hook fehlschlug,\n"
+"sollten Sie das Problem beheben, bevor Sie die Commit-Beschreibung ändern können."
 
 #: git-rebase--interactive.sh:564
 #, sh-format
 msgid "Stopped at $sha1_abbrev... $rest"
-msgstr ""
+msgstr "Angehalten bei $sha1_abbrev... $rest"
 
 #: git-rebase--interactive.sh:579
 #, sh-format
 msgid "Cannot '$squash_style' without a previous commit"
-msgstr ""
+msgstr "Kann nicht '$squash_style' ohne vorherigen Commit"
 
 #: git-rebase--interactive.sh:621
 #, sh-format
 msgid "Executing: $rest"
-msgstr ""
+msgstr "Führe aus: $rest"
 
 #: git-rebase--interactive.sh:629
 #, sh-format
 msgid "Execution failed: $rest"
-msgstr ""
+msgstr "Ausführung fehlgeschlagen: $rest"
 
 #: git-rebase--interactive.sh:631
-#, fuzzy
 msgid "and made changes to the index and/or the working tree"
-msgstr "weder den Index, noch das Arbeitsverzeichnis aktualisieren"
+msgstr "Der Index und/oder das Arbeitsverzeichnis wurde geändert."
 
 #: git-rebase--interactive.sh:633
-#, fuzzy
 msgid ""
 "You can fix the problem, and then run\n"
 "\n"
 "\tgit rebase --continue"
 msgstr ""
-"  (beheben Sie die Konflikte und führen Sie dann \"git rebase --continue\" "
-"aus)"
+"Sie können das Problem beheben, und dann\n"
+"\n"
+"\tgit rebase --continue\n"
+"\n"
+"ausführen."
 
 #. TRANSLATORS: after these lines is a command to be issued by the user
 #: git-rebase--interactive.sh:646
 #, sh-format
 msgid ""
 "Execution succeeded: $rest\n"
 "but left changes to the index and/or the working tree\n"
 "Commit or stash your changes, and then run\n"
 "\n"
 "\tgit rebase --continue"
 msgstr ""
+"Ausführung erfolgreich: $rest\n"
+"Aber Änderungen in Index oder Arbeitsverzeichnis verblieben.\n"
+"Committen Sie Ihre Änderungen oder benutzen Sie \"stash\".\n"
+"Führen Sie dann aus:\n"
+"\n"
+"\tgit rebase --continue"
 
 #: git-rebase--interactive.sh:657
-#, fuzzy, sh-format
+#, sh-format
 msgid "Unknown command: $command $sha1 $rest"
-msgstr "Unbekannter Unterbefehl: %s"
+msgstr "Unbekannter Befehl: $command $sha1 $rest"
 
 #: git-rebase--interactive.sh:658
 msgid "Please fix this using 'git rebase --edit-todo'."
-msgstr ""
+msgstr "Bitte beheben Sie das, indem Sie 'git rebase --edit-todo' ausführen."
 
 #: git-rebase--interactive.sh:693
 #, sh-format
 msgid "Successfully rebased and updated $head_name."
-msgstr ""
+msgstr "Erfolgreich Rebase ausgeführt und $head_name aktualisiert."
 
 #: git-rebase--interactive.sh:740
 msgid "Could not skip unnecessary pick commands"
-msgstr ""
+msgstr "Fehler beim Auslassen von nicht erforderlichen \"pick\"-Befehlen."
 
 #: git-rebase--interactive.sh:898
 #, sh-format
 msgid ""
 "Warning: the SHA-1 is missing or isn't a commit in the following line:\n"
 " - $line"
 msgstr ""
+"Warnung: Der SHA-1 in der folgenden Zeile fehlt oder ist kein Commit:\n"
+" - $line"
 
 #: git-rebase--interactive.sh:931
 #, sh-format
 msgid ""
 "Warning: the command isn't recognized in the following line:\n"
 " - $line"
 msgstr ""
+"Warnung: Das Kommando in der folgenden Zeile wurde nicht erkannt:\n"
+" - $line"
 
 #: git-rebase--interactive.sh:970
-#, fuzzy
 msgid "could not detach HEAD"
-msgstr "Konnte nicht von %s anfordern"
+msgstr "Konnte HEAD nicht loslösen"
 
 #: git-rebase--interactive.sh:1008
 msgid ""
 "Warning: some commits may have been dropped accidentally.\n"
 "Dropped commits (newer to older):"
 msgstr ""
+"Warnung: Einige Commits könnten aus Versehen entfernt worden sein.\n"
+"Entfernte Commits (neu zu alt):"
 
 #: git-rebase--interactive.sh:1016
 msgid ""
 "To avoid this message, use \"drop\" to explicitly remove a commit.\n"
 "\n"
 "Use 'git config rebase.missingCommitsCheck' to change the level of "
 "warnings.\n"
 "The possible behaviours are: ignore, warn, error."
 msgstr ""
+"Um diese Meldung zu vermeiden, benutzen Sie \"drop\", um exlizit Commits zu\n"
+"entfernen.\n"
+"\n"
+"Benutzen Sie 'git config rebase.missingCommitsCheck', um die Stufe der Warnungen\n"
+"zu ändern.\n"
+"Die möglichen Verhaltensweisen sind: ignore, warn, error."
 
 #: git-rebase--interactive.sh:1027
 #, sh-format
 msgid ""
 "Unrecognized setting $check_level for option rebase.missingCommitsCheck. "
 "Ignoring."
 msgstr ""
+"Nicht erkannte Einstellung $check_level für Option rebase.missingCommitsCheck.\n"
+"Ignoriere."
 
 #: git-rebase--interactive.sh:1044
 msgid "You can fix this with 'git rebase --edit-todo'."
-msgstr ""
+msgstr "Sie können das mit 'git rebase --edit-todo' beheben."
 
 #: git-rebase--interactive.sh:1045
 msgid "Or you can abort the rebase with 'git rebase --abort'."
-msgstr ""
+msgstr "Oder Sie können den Rebase mit 'git rebase --abort' abbrechen."
 
 #: git-rebase--interactive.sh:1069
-#, fuzzy
 msgid "Could not remove CHERRY_PICK_HEAD"
-msgstr "Konnte Commit von HEAD nicht auflösen\n"
+msgstr "Konnte CHERRY_PICK_HEAD nicht löschen"
 
 #: git-rebase--interactive.sh:1074
 #, sh-format
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
 "In both case, once you're done, continue with:\n"
 "\n"
 "  git rebase --continue\n"
 msgstr ""
+"Es befinden sich zum Commit vorgemerkte Änderungen in Ihrem Arbeitsverzeichnis.\n"
+"Wenn diese Änderungen in den vorherigen Commit aufgenommen werden sollen,\n"
+"führen Sie aus:\n"
+"\n"
+"  git commit --amend $gpg_sign_opt_quoted\n"
+"\n"
+"Wenn daraus ein neuer Commit erzeugt werden soll, führen Sie aus:\n"
+"\n"
+"  git commit $gpg_sign_opt_quoted\n"
+"\n"
+"Im Anschluss führen Sie zum Fortfahren aus:\n"
+"\n"
+"  git rebase --continue\n"
 
 #: git-rebase--interactive.sh:1091
 msgid "Error trying to find the author identity to amend commit"
 msgstr ""
+"Fehler beim Versuch die Identität des Authors zum Verbessern des Commits zu\n"
+"finden"
 
 #: git-rebase--interactive.sh:1096
 msgid ""
 "You have uncommitted changes in your working tree. Please commit them\n"
 "first and then run 'git rebase --continue' again."
 msgstr ""
+"Sie haben nicht committete Änderungen in Ihrem Arbeitsverzeichnis. Bitte\n"
+"committen Sie diese zuerst und führen Sie dann 'git rebase --continue' erneut\n"
+"aus."
 
 #: git-rebase--interactive.sh:1101 git-rebase--interactive.sh:1105
-#, fuzzy
 msgid "Could not commit staged changes."
-msgstr "Konnte Commit-Beschreibung nicht lesen: %s"
+msgstr "Konnte Änderungen aus der Staging-Area nicht committen."
 
 #: git-rebase--interactive.sh:1129
 msgid ""
 "\n"
 "You are editing the todo file of an ongoing interactive rebase.\n"
 "To continue rebase after editing, run:\n"
 "    git rebase --continue\n"
 "\n"
 msgstr ""
+"\n"
+"Sie bearbeiten gerade die TODO-Datei eines laufenden interaktiven Rebase.\n"
+"Um den Rebase nach dem Editieren fortzusetzen, führen Sie aus:\n"
+"    git rebase --continue\n"
+"\n"
 
 #: git-rebase--interactive.sh:1137 git-rebase--interactive.sh:1298
-#, fuzzy
 msgid "Could not execute editor"
-msgstr "Konnte %s nicht entfernen"
+msgstr "Konnte Editor nicht ausführen."
 
 #: git-rebase--interactive.sh:1145
 msgid "You need to set your committer info first"
 msgstr "Sie müssen zuerst die Informationen zum Commit-Ersteller setzen."
 
 #: git-rebase--interactive.sh:1153
-#, fuzzy, sh-format
+#, sh-format
 msgid "Could not checkout $switch_to"
-msgstr "Konnte Verzeichnis '%s' nicht erstellen."
+msgstr "Konnte $switch_to nicht auschecken."
 
 #: git-rebase--interactive.sh:1158
 msgid "No HEAD?"
-msgstr ""
+msgstr "Kein HEAD?"
 
 #: git-rebase--interactive.sh:1159
-#, fuzzy, sh-format
+#, sh-format
 msgid "Could not create temporary $state_dir"
-msgstr "konnte temporäre Datei '%s' nicht erstellen"
+msgstr "Konnte temporäres Verzeichnis $state_dir nicht erstellen."
 
 #: git-rebase--interactive.sh:1161
-#, fuzzy
 msgid "Could not mark as interactive"
-msgstr "Konnte Bereitstellung nicht lesen"
+msgstr "Konnte nicht als interaktiven Rebase markieren."
 
 #: git-rebase--interactive.sh:1171 git-rebase--interactive.sh:1176
-#, fuzzy
 msgid "Could not init rewritten commits"
-msgstr "Konnte Eltern-Commit %s nicht parsen\n"
+msgstr "Konnte neu geschriebene Commits nicht initialisieren."
 
 #: git-rebase--interactive.sh:1276
 #, sh-format
 msgid "Rebase $shortrevisions onto $shortonto ($todocount command)"
 msgid_plural "Rebase $shortrevisions onto $shortonto ($todocount commands)"
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "Rebase von $shortrevisions auf $shortonto ($todocount Kommando)"
+msgstr[1] "Rebase von $shortrevisions auf $shortonto ($todocount Kommandos)"
 
 #: git-rebase--interactive.sh:1281
 msgid ""
 "\n"
 "However, if you remove everything, the rebase will be aborted.\n"
 "\n"
-msgstr ""
+msgstr "\nWenn Sie jedoch alles löschen, wird der Rebase abgebrochen.\n\n"
 
 #: git-rebase--interactive.sh:1288
 msgid "Note that empty commits are commented out"
-msgstr ""
+msgstr "Leere Commits sind auskommentiert."
 
 #: git-sh-setup.sh:89 git-sh-setup.sh:94
 #, sh-format
 msgid "usage: $dashless $USAGE"
-msgstr ""
+msgstr "Verwendung: $dashless $USAGE"
 
 #: git-sh-setup.sh:190
-#, fuzzy, sh-format
+#, sh-format
 msgid "Cannot chdir to $cdup, the toplevel of the working tree"
 msgstr ""
-"Relative Pfade können nur von der obersten Ebene des Arbeitsverzeichnisses "
-"benutzt werden."
+"Konnte nicht in Verzeichnis $cdup wechseln, der obersten Ebene des\n"
+"Arbeitsverzeichnisses."
 
 #: git-sh-setup.sh:199 git-sh-setup.sh:206
 #, sh-format
 msgid "fatal: $program_name cannot be used without a working tree."
-msgstr ""
+msgstr "fatal: $program_name kann ohne ein Arbeitsverzeichnis nicht verwendet werden."
 
 #: git-sh-setup.sh:220
-#, fuzzy
 msgid "Cannot rebase: You have unstaged changes."
-msgstr ""
-"Kann \"pull\" mit \"rebase\" nicht ausführen: Sie haben Änderungen, die "
-"nicht zum Commit vorgemerkt sind."
+msgstr "Rebase nicht möglich: Sie haben Änderungen, die nicht zum Commit vorgemerkt sind."
 
 #: git-sh-setup.sh:223
-#, fuzzy
 msgid "Cannot rewrite branches: You have unstaged changes."
 msgstr ""
-"Kann \"pull\" mit \"rebase\" nicht ausführen: Sie haben Änderungen, die "
-"nicht zum Commit vorgemerkt sind."
+"Kann Branches nicht neu schreiben: Sie haben Änderungen, die nicht zum Commit\n"
+"vorgemerkt sind."
 
 #: git-sh-setup.sh:229
-#, fuzzy, sh-format
+#, sh-format
 msgid "Cannot $action: You have unstaged changes."
 msgstr ""
-"Kann \"pull\" mit \"rebase\" nicht ausführen: Sie haben Änderungen, die "
-"nicht zum Commit vorgemerkt sind."
+"Kann $action nicht ausführen: Sie haben Änderungen, die nicht zum Commit\n"
+"vorgemerkt sind."
 
 #: git-sh-setup.sh:242
-#, fuzzy
 msgid "Cannot rebase: Your index contains uncommitted changes."
-msgstr ""
-"Kann \"pull\" mit \"rebase\" nicht ausführen: Die Staging-Area beinhaltet "
-"nicht committete Änderungen."
+msgstr "Rebase nicht möglich: Die Staging-Area beinhaltet nicht committete Änderungen."
 
 #: git-sh-setup.sh:248
-#, fuzzy, sh-format
+#, sh-format
 msgid "Cannot $action: Your index contains uncommitted changes."
 msgstr ""
-"Kann \"pull\" mit \"rebase\" nicht ausführen: Die Staging-Area beinhaltet "
-"nicht committete Änderungen."
+"Kann $action nicht ausführen: Die Staging-Area beinhaltet nicht committete\n"
+"Änderungen."
 
 #: git-sh-setup.sh:372
-#, fuzzy
 msgid "You need to run this command from the toplevel of the working tree."
-msgstr ""
-"Relative Pfade können nur von der obersten Ebene des Arbeitsverzeichnisses "
-"benutzt werden."
+msgstr "Sie müssen den Befehl von der obersten Ebene des Arbeitsverzeichnisses ausführen."
 
 #: git-sh-setup.sh:377
-#, fuzzy
 msgid "Unable to determine absolute path of git directory"
-msgstr "Konnte aktuelles Arbeitsverzeichnis nicht bekommen."
+msgstr "Konnte absoluten Pfad des Git-Verzeichnisses nicht bestimmen."
 
-- 
2.10.0.379.g97b919b


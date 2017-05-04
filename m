Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A18CA207D6
	for <e@80x24.org>; Thu,  4 May 2017 17:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754415AbdEDRJB (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 13:09:01 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35036 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754063AbdEDRI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 13:08:58 -0400
Received: by mail-wm0-f49.google.com with SMTP id w64so2738108wma.0
        for <git@vger.kernel.org>; Thu, 04 May 2017 10:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :references:content-transfer-encoding;
        bh=8ZInnJK50g+qIsrWTkHPyMbeU76otlOUeZSXvu3YHMI=;
        b=pJt2E3MmoyoiKIBMWVkcVjJhZ1WMGbLhrZnl2qjIdFUFozZqP52Dghw4xQ6ud9dVhH
         Fjxs5LbOjtvM8tD2y+U9UqE6WL0CgyMJhA6IP6GdPnFOx4VmdblOZglS4y8qKo7P1Hcz
         29fMwbxCaeyzxWzrdefgXk0XOZqEeIW73bhel3+szr9L7a0rOSEcv1GC7tuN2qUb3LYw
         aO2HV1OPRWc0zzvlEa1cfUvAShgPnWQ0VxUNBUmarhlNaEmQzdB5ZBuhpuK8XTyXnqoT
         dkUuHFv7W9t7fTd5R7YHA4Ut1TmqQphF/f2YbVuJyPgrmlQUQTCakp2CNWjaTSpMu5jM
         PZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:references:content-transfer-encoding;
        bh=8ZInnJK50g+qIsrWTkHPyMbeU76otlOUeZSXvu3YHMI=;
        b=erisrH8cfDzFNCYsdMXxRddHgtRd0ZmUWh/rPAkDsqfgFniOHtAKlt7MeyNCvEc9Y3
         rWSUNGwv0QiaKbnmhKo8nFO9c8iGLeAo1gsAsi6uf5ayRKJEyuuvMBlg+I4xue+ogC0O
         SRwHMPz9JTHweh3Acs469F1dpwVNLiHOcqZH4igInH460jLEbHPiFWUWN/2cvIj3I4/Q
         /ZaXBoArFi5dOSpp8VpxULThHJ4HFafkB9xHjHy++JvK0Ig0XY6SPcDUFKP5bxQuig33
         QdDGMa33V2ST0J8zwKuFfIjYm8KIKW6v1k/JNf0wA4esZTjiha323NMbUN8pWbCeisbn
         s1mQ==
X-Gm-Message-State: AN3rC/4Q6cNIHi2Ln36Z6EyuDAQ2i359aWzs65rtXv76GYt+VoyOSQ9k
        aPdV+RBXpsEubQ==
X-Received: by 10.80.140.203 with SMTP id r11mr8388586edr.18.1493917736480;
        Thu, 04 May 2017 10:08:56 -0700 (PDT)
Received: from localhost (cable-94-139-21-113.cust.telecolumbus.net. [94.139.21.113])
        by smtp.gmail.com with ESMTPSA id l25sm989267eda.52.2017.05.04.10.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 10:08:55 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?q?Magnus=20G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Simon Ruderich <simon@ruderich.org>,
        Christian Brabandt <cb@256bit.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v5] l10n: de.po: update German translation
Date:   Thu,  4 May 2017 19:08:53 +0200
Message-Id: <20170504170853.7221-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.13.0.rc0.207.gb44265493
MIME-Version: 1.0
In-Reply-To: <20170503164009.5366-1-ralf.thielow@gmail.com>
References: <20170503164009.5366-1-ralf.thielow@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Translate 96 new messages came from git.pot update in dfc182b (l10n:
git.pot: v2.13.0 round 1 (96 new, 37 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 325 ++++++++++++++++++++++++++++-----------------------------------
 1 file changed, 143 insertions(+), 182 deletions(-)

diff --git a/po/de.po b/po/de.po
index b92c4fe11..cfefa436e 100644
--- a/po/de.po
+++ b/po/de.po
@@ -866,9 +866,9 @@ msgid "Argument not supported for format '%s': -%d"
 msgstr "Argument für Format '%s' nicht unterstützt: -%d"
 
 #: attr.c:212
-#, fuzzy, c-format
+#, c-format
 msgid "%.*s is not a valid attribute name"
-msgstr "'%s' ist kein gültiger Name für ein Remote-Repository"
+msgstr "%.*s ist kein gültiger Attributname"
 
 #: attr.c:408
 msgid ""
@@ -1260,6 +1260,8 @@ msgstr "Speicher verbraucht"
 #: config.c:191
 msgid "relative config include conditionals must come from files"
 msgstr ""
+"Bedingungen für das Einbinden von Konfigurationen aus relativen Pfaden müssen\n"
+"aus Dateien kommen."
 
 #: config.c:701
 #, c-format
@@ -1379,12 +1381,12 @@ msgstr "Ungültiger %s: '%s'"
 #: config.c:1952
 #, c-format
 msgid "unknown core.untrackedCache value '%s'; using 'keep' default value"
-msgstr ""
+msgstr "Unbekannter Wert '%s' in core.untrackedCache; benutze Standardwert 'keep'"
 
 #: config.c:1978
 #, c-format
 msgid "splitIndex.maxPercentChange value '%d' should be between 0 and 100"
-msgstr ""
+msgstr "Der Wert '%d' von splitIndex.maxPercentChange sollte zwischen 0 und 100 liegen."
 
 #: config.c:1989
 #, c-format
@@ -1645,9 +1647,9 @@ msgstr ""
 "für dieses Verzeichnis deaktiviert."
 
 #: dir.c:2776 dir.c:2781
-#, fuzzy, c-format
+#, c-format
 msgid "could not create directories for %s"
-msgstr "Konnte Verzeichnis '%s' nicht erstellen."
+msgstr "Konnte Verzeichnisse für '%s' nicht erstellen."
 
 #: dir.c:2806
 #, c-format
@@ -1655,9 +1657,9 @@ msgid "could not migrate git directory from '%s' to '%s'"
 msgstr "Konnte Git-Verzeichnis nicht von '%s' nach '%s' migrieren."
 
 #: entry.c:280
-#, fuzzy, c-format
+#, c-format
 msgid "could not stat file '%s'"
-msgstr "konnte Datei '%s' nicht erstellen"
+msgstr "konnte Datei '%s' nicht lesen"
 
 #: fetch-pack.c:249
 msgid "git fetch-pack: expected shallow list"
@@ -1827,14 +1829,14 @@ msgid "no matching remote head"
 msgstr "kein übereinstimmender Remote-Branch"
 
 #: fetch-pack.c:1147
-#, fuzzy, c-format
+#, c-format
 msgid "no such remote ref %s"
-msgstr "Kein solches Remote-Repository: %s"
+msgstr "keine solche Remote-Referenz %s"
 
 #: fetch-pack.c:1150
 #, c-format
 msgid "Server does not allow request for unadvertised object %s"
-msgstr ""
+msgstr "Der Server lehnt Anfrage nach nicht angebotenem Objekt %s ab."
 
 #: gpg-interface.c:185
 msgid "gpg failed to sign the data"
@@ -1961,31 +1963,31 @@ msgstr ""
 
 #: ident.c:367
 msgid "no email was given and auto-detection is disabled"
-msgstr ""
+msgstr "keine E-Mail angegeben und automatische Erkennung ist deaktiviert"
 
 #: ident.c:372
-#, fuzzy, c-format
+#, c-format
 msgid "unable to auto-detect email address (got '%s')"
-msgstr "Fehler: konnte keine gültige Adresse aus %s extrahieren\n"
+msgstr "Konnte die E-Mail-Adresse nicht automatisch erkennen ('%s' erhalten)"
 
 #: ident.c:382
 msgid "no name was given and auto-detection is disabled"
-msgstr ""
+msgstr "kein Name angegeben und automatische Erkennung ist deaktiviert"
 
 #: ident.c:388
-#, fuzzy, c-format
+#, c-format
 msgid "unable to auto-detect name (got '%s')"
-msgstr "konnte \"Tree\"-Objekt (%s) nicht lesen"
+msgstr "konnte Namen nicht automatisch erkennen ('%s' erhalten)"
 
 #: ident.c:396
 #, c-format
 msgid "empty ident name (for <%s>) not allowed"
-msgstr ""
+msgstr "Leerer Name in Identifikation (für <%s>) nicht erlaubt."
 
 #: ident.c:402
 #, c-format
 msgid "name consists only of disallowed characters: %s"
-msgstr ""
+msgstr "Name besteht nur aus nicht erlaubten Zeichen: %s"
 
 #: ident.c:417 builtin/commit.c:611
 #, c-format
@@ -2102,13 +2104,11 @@ msgstr ""
 "im Arbeitsbereich gelassen."
 
 #: merge-recursive.c:1097
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "CONFLICT (%s/delete): %s deleted in %s and %s to %s in %s. Version %s of %s "
 "left in tree."
-msgstr ""
-"KONFLIKT (%s/löschen): %s gelöscht in %s und %s in %s. Stand %s von %s wurde "
-"im Arbeitsbereich gelassen."
+msgstr "KONFLIKT (%s/löschen): %s gelöscht in %s und %s nach %s in %s. Stand %s von %s wurde im Arbeitsbereich gelassen."
 
 #: merge-recursive.c:1104
 #, c-format
@@ -2120,13 +2120,11 @@ msgstr ""
 "im Arbeitsbereich bei %s gelassen."
 
 #: merge-recursive.c:1109
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "CONFLICT (%s/delete): %s deleted in %s and %s to %s in %s. Version %s of %s "
 "left in tree at %s."
-msgstr ""
-"KONFLIKT (%s/löschen): %s gelöscht in %s und %s in %s. Stand %s von %s wurde "
-"im Arbeitsbereich bei %s gelassen."
+msgstr "KONFLIKT (%s/löschen): %s gelöscht in %s und %s nach %s in %s. Stand %s von %s wurde im Arbeitsbereich bei %s gelassen."
 
 #: merge-recursive.c:1143
 msgid "rename"
@@ -2371,21 +2369,20 @@ msgstr "Konnte Gruppenschreibrecht für %s nicht setzen."
 
 #: pathspec.c:125
 msgid "Escape character '\\' not allowed as last character in attr value"
-msgstr ""
+msgstr "Escape-Zeichen '\\' als letztes Zeichen in Attributwert nicht erlaubt"
 
 #: pathspec.c:143
-#, fuzzy
 msgid "Only one 'attr:' specification is allowed."
-msgstr "nur eine -F oder -m Option ist erlaubt."
+msgstr "Es ist nur eine Angabe von 'attr:' erlaubt."
 
 #: pathspec.c:146
 msgid "attr spec must not be empty"
-msgstr ""
+msgstr "Angabe von 'attr:' darf nicht leer sein"
 
 #: pathspec.c:189
-#, fuzzy, c-format
+#, c-format
 msgid "invalid attribute name %s"
-msgstr "Ungültige Identifikationszeile: %s"
+msgstr "Ungültiger Attributname %s"
 
 #: pathspec.c:254
 msgid "global 'glob' and 'noglob' pathspec settings are incompatible"
@@ -2483,17 +2480,17 @@ msgstr ""
 "Verwende Version %i"
 
 #: read-cache.c:2232
-#, fuzzy, c-format
+#, c-format
 msgid "could not stat '%s"
-msgstr "Konnte '%s' nicht lesen"
+msgstr "Konnte '%s' nicht lesen."
 
 #: read-cache.c:2245
-#, fuzzy, c-format
+#, c-format
 msgid "unable to open git dir: %s"
-msgstr "konnte %s nicht öffnen: %s\n"
+msgstr "konnte Git-Verzeichnis nicht öffnen: %s"
 
 #: read-cache.c:2257
-#, fuzzy, c-format
+#, c-format
 msgid "unable to unlink: %s"
 msgstr "Konnte '%s' nicht entfernen."
 
@@ -2522,19 +2519,19 @@ msgid "gone"
 msgstr "entfernt"
 
 #: ref-filter.c:36
-#, fuzzy, c-format
+#, c-format
 msgid "ahead %d"
-msgstr "[%d voraus]"
+msgstr "%d voraus"
 
 #: ref-filter.c:37
-#, fuzzy, c-format
+#, c-format
 msgid "behind %d"
-msgstr "[%d hinterher]"
+msgstr "%d hinterher"
 
 #: ref-filter.c:38
-#, fuzzy, c-format
+#, c-format
 msgid "ahead %d, behind %d"
-msgstr "[%d voraus, %d hinterher]"
+msgstr "%d voraus, %d hinterher"
 
 #: ref-filter.c:104
 #, c-format
@@ -2547,19 +2544,19 @@ msgid "unrecognized color: %%(color:%s)"
 msgstr "nicht erkannte Farbe: %%(color:%s)"
 
 #: ref-filter.c:120
-#, fuzzy, c-format
+#, c-format
 msgid "Integer value expected refname:lstrip=%s"
-msgstr "Positiver Wert erwartet contents:lines=%s"
+msgstr "Positiver Wert erwartet refname:lstrip=%s"
 
 #: ref-filter.c:124
-#, fuzzy, c-format
+#, c-format
 msgid "Integer value expected refname:rstrip=%s"
-msgstr "Positiver Wert erwartet contents:lines=%s"
+msgstr "Positiver Wert erwartet refname:rstrip=%s"
 
 #: ref-filter.c:126
-#, fuzzy, c-format
+#, c-format
 msgid "unrecognized %%(%s) argument: %s"
-msgstr "nicht erkanntes %%(align) Argument: %s"
+msgstr "nicht erkanntes %%(%s) Argument: %s"
 
 #: ref-filter.c:166
 #, c-format
@@ -2587,9 +2584,9 @@ msgid "unrecognized %%(contents) argument: %s"
 msgstr "nicht erkanntes %%(contents) Argument: %s"
 
 #: ref-filter.c:214
-#, fuzzy, c-format
+#, c-format
 msgid "positive value expected objectname:short=%s"
-msgstr "Positiver Wert erwartet contents:lines=%s"
+msgstr "Positiver Wert erwartet objectname:short=%s"
 
 #: ref-filter.c:218
 #, c-format
@@ -2622,9 +2619,9 @@ msgid "positive width expected with the %%(align) atom"
 msgstr "Positive Breitenangabe für %%(align) erwartet"
 
 #: ref-filter.c:286
-#, fuzzy, c-format
+#, c-format
 msgid "unrecognized %%(if) argument: %s"
-msgstr "nicht erkanntes %%(align) Argument: %s"
+msgstr "nicht erkanntes %%(if) Argument: %s"
 
 #: ref-filter.c:371
 #, c-format
@@ -2637,39 +2634,39 @@ msgid "unknown field name: %.*s"
 msgstr "Unbekannter Feldname: %.*s"
 
 #: ref-filter.c:501
-#, fuzzy, c-format
+#, c-format
 msgid "format: %%(if) atom used without a %%(then) atom"
-msgstr "Format: %%(end) Atom ohne zugehöriges Atom verwendet"
+msgstr "format: %%(if) Atom ohne ein %%(then) Atom verwendet"
 
 #: ref-filter.c:561
-#, fuzzy, c-format
+#, c-format
 msgid "format: %%(then) atom used without an %%(if) atom"
-msgstr "Format: %%(end) Atom ohne zugehöriges Atom verwendet"
+msgstr "format: %%(then) Atom ohne ein %%(if) Atom verwendet"
 
 #: ref-filter.c:563
-#, fuzzy, c-format
+#, c-format
 msgid "format: %%(then) atom used more than once"
-msgstr "Format: %%(end) Atom ohne zugehöriges Atom verwendet"
+msgstr "format: %%(then) Atom mehr als einmal verwendet"
 
 #: ref-filter.c:565
-#, fuzzy, c-format
+#, c-format
 msgid "format: %%(then) atom used after %%(else)"
-msgstr "Format: %%(end) Atom fehlt"
+msgstr "format: %%(then) Atom nach %%(else) verwendet"
 
 #: ref-filter.c:591
-#, fuzzy, c-format
+#, c-format
 msgid "format: %%(else) atom used without an %%(if) atom"
-msgstr "Format: %%(end) Atom ohne zugehöriges Atom verwendet"
+msgstr "format: %%(else) Atom ohne ein %%(if) Atom verwendet"
 
 #: ref-filter.c:593
-#, fuzzy, c-format
+#, c-format
 msgid "format: %%(else) atom used without a %%(then) atom"
-msgstr "Format: %%(end) Atom ohne zugehöriges Atom verwendet"
+msgstr "Format: %%(else) Atom ohne ein %%(then) Atom verwendet"
 
 #: ref-filter.c:595
-#, fuzzy, c-format
+#, c-format
 msgid "format: %%(else) atom used more than once"
-msgstr "Format: %%(end) Atom ohne zugehöriges Atom verwendet"
+msgstr "Format: %%(end) Atom mehr als einmal verwendet"
 
 #: ref-filter.c:608
 #, c-format
@@ -2892,14 +2889,14 @@ msgid "dup2(%d,%d) failed"
 msgstr "dup2(%d,%d) fehlgeschlagen"
 
 #: send-pack.c:150
-#, fuzzy, c-format
+#, c-format
 msgid "unable to parse remote unpack status: %s"
-msgstr "Konnte Kontakt '%s' nicht parsen."
+msgstr "Konnte Status des Entpackens der Gegenseite nicht parsen: %s"
 
 #: send-pack.c:152
-#, fuzzy, c-format
+#, c-format
 msgid "remote unpack failed: %s"
-msgstr "Anwendung des Patches fehlgeschlagen: %s:%ld"
+msgstr "Entpacken auf der Gegenseite fehlgeschlagen: %s"
 
 #: send-pack.c:315
 msgid "failed to sign the push certificate"
@@ -3365,9 +3362,9 @@ msgstr ""
 "Sie können jederzeit \"git stash pop\" oder \"git stash drop\" ausführen.\n"
 
 #: sequencer.c:2009
-#, fuzzy, c-format
+#, c-format
 msgid "Stopped at %s...  %.*s\n"
-msgstr "Angehalten bei %s... %.*s"
+msgstr "Angehalten bei %s... %.*s\n"
 
 #: sequencer.c:2036
 #, c-format
@@ -3501,9 +3498,9 @@ msgid "Unable to read current working directory"
 msgstr "Konnte aktuelles Arbeitsverzeichnis nicht lesen."
 
 #: setup.c:1022 setup.c:1028
-#, fuzzy, c-format
+#, c-format
 msgid "Cannot change to '%s'"
-msgstr "Kann nicht in Verzeichnis '%s/..' wechseln"
+msgstr "Kann nicht nach '%s' wechseln."
 
 #: setup.c:1041
 #, c-format
@@ -3632,24 +3629,24 @@ msgid "negative values not allowed for submodule.fetchJobs"
 msgstr "Negative Werte für submodule.fetchJobs nicht erlaubt"
 
 #: submodule.c:1194
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' not recognized as a git repository"
-msgstr "--stdin erfordert ein Git-Repository"
+msgstr "'%s' nicht als Git-Repository erkannt"
 
 #: submodule.c:1332
-#, fuzzy, c-format
+#, c-format
 msgid "could not start 'git status' in submodule '%s'"
 msgstr "Konnte 'git status' in Submodul '%s' nicht starten."
 
 #: submodule.c:1345
-#, fuzzy, c-format
+#, c-format
 msgid "could not run 'git status' in submodule '%s'"
-msgstr "konnte 'git status' in Submodul '%s' nicht ausführen"
+msgstr "Konnte 'git status' in Submodul '%s' nicht ausführen."
 
 #: submodule.c:1421
-#, fuzzy, c-format
+#, c-format
 msgid "submodule '%s' has dirty index"
-msgstr "Submodul '%s' kann Alternative nicht hinzufügen: %s"
+msgstr "Submodul '%s' hat einen geänderten Index."
 
 #: submodule.c:1679
 #, c-format
@@ -3687,18 +3684,17 @@ msgid "could not recurse into submodule '%s'"
 msgstr "Fehler bei Rekursion in Submodul-Pfad '%s'"
 
 #: submodule.c:1826
-#, fuzzy
 msgid "could not start ls-files in .."
-msgstr "Konnte '%s' nicht lesen"
+msgstr "Konnte 'ls-files' nicht in .. starten"
 
 #: submodule.c:1846
 msgid "BUG: returned path string doesn't match cwd?"
-msgstr ""
+msgstr "FEHLER: zurückgegebene Zeichenkette für Pfad entspricht nicht cwd?"
 
 #: submodule.c:1865
 #, c-format
 msgid "ls-tree returned unexpected return code %d"
-msgstr ""
+msgstr "ls-tree mit unerwartetem Rückgabewert %d beendet"
 
 #: submodule-config.c:380
 #, c-format
@@ -4065,11 +4061,13 @@ msgstr ""
 "%s"
 
 #: unpack-trees.c:170
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Cannot update submodule:\n"
 "%s"
-msgstr "fehlerhafter Patch für Submodul %s"
+msgstr ""
+"Kann Submodul nicht aktualisieren:\n"
+"%s"
 
 #: unpack-trees.c:247
 #, c-format
@@ -4077,9 +4075,9 @@ msgid "Aborting\n"
 msgstr "Abbruch\n"
 
 #: unpack-trees.c:272
-#, fuzzy, c-format
+#, c-format
 msgid "submodule update strategy not supported for submodule '%s'"
-msgstr "konnte Name für Submodul '%s' nicht nachschlagen"
+msgstr "Strategie zur Aktualisierung von Submodulen für Submodul '%s' nicht unterstützt."
 
 #: unpack-trees.c:340
 msgid "Checking out files"
@@ -5453,9 +5451,8 @@ msgid "git branch [<options>] [-r | -a] [--points-at]"
 msgstr "git branch [<Optionen>] [-r | -a] [--points-at]"
 
 #: builtin/branch.c:31
-#, fuzzy
 msgid "git branch [<options>] [-r | -a] [--format]"
-msgstr "git branch [<Optionen>] [-r | -a] [--points-at]"
+msgstr "git branch [<Optionen>] [-r | -a] [--format]"
 
 #: builtin/branch.c:144
 #, c-format
@@ -5630,12 +5627,11 @@ msgstr "auf Remote-Tracking-Branches wirken"
 
 #: builtin/branch.c:564 builtin/branch.c:566
 msgid "print only branches that contain the commit"
-msgstr "nur Branches ausgeben, welche diesen Commit beinhalten"
+msgstr "nur Branches ausgeben, die diesen Commit enthalten"
 
 #: builtin/branch.c:565 builtin/branch.c:567
-#, fuzzy
 msgid "print only branches that don't contain the commit"
-msgstr "nur Branches ausgeben, welche diesen Commit beinhalten"
+msgstr "nur Branches ausgeben, die diesen Commit nicht enthalten"
 
 #: builtin/branch.c:570
 msgid "Specific git-branch actions:"
@@ -6589,9 +6585,8 @@ msgid "setup as shared repository"
 msgstr "als verteiltes Repository einrichten"
 
 #: builtin/clone.c:93 builtin/clone.c:97
-#, fuzzy
 msgid "pathspec"
-msgstr "Pfad"
+msgstr "Pfadspezifikation"
 
 #: builtin/clone.c:93 builtin/clone.c:97
 msgid "initialize submodules in the clone"
@@ -7851,9 +7846,8 @@ msgid "only consider tags matching <pattern>"
 msgstr "nur Tags, die <Muster> entsprechen, betrachten"
 
 #: builtin/describe.c:452
-#, fuzzy
 msgid "do not consider tags matching <pattern>"
-msgstr "nur Tags, die <Muster> entsprechen, betrachten"
+msgstr "keine Tags betrachten, die <Muster> entsprechen"
 
 #: builtin/describe.c:454 builtin/name-rev.c:357
 msgid "show abbreviated commit object as fallback"
@@ -7865,16 +7859,11 @@ msgstr "Kennzeichen"
 
 #: builtin/describe.c:456
 msgid "append <mark> on dirty working tree (default: \"-dirty\")"
-msgstr ""
-"<Kennzeichen> bei geändertem Arbeitsverzeichnis hinzufügen (Standard: \"-"
-"dirty\")"
+msgstr "<Kennzeichen> bei geändertem Arbeitsverzeichnis anhängen (Standard: \"-dirty\")"
 
 #: builtin/describe.c:459
-#, fuzzy
 msgid "append <mark> on broken working tree (default: \"-broken\")"
-msgstr ""
-"<Kennzeichen> bei geändertem Arbeitsverzeichnis hinzufügen (Standard: \"-"
-"dirty\")"
+msgstr "<Kennzeichen> bei defektem Arbeitsverzeichnis anhängen (Standard: \"-broken\")"
 
 #: builtin/describe.c:477
 msgid "--long is incompatible with --abbrev=0"
@@ -7889,9 +7878,8 @@ msgid "--dirty is incompatible with commit-ishes"
 msgstr "Die Option --dirty kann nicht mit Commits verwendet werden."
 
 #: builtin/describe.c:551
-#, fuzzy
 msgid "--broken is incompatible with commit-ishes"
-msgstr "Die Option --dirty kann nicht mit Commits verwendet werden."
+msgstr "Die Option --broken kann nicht mit Commits verwendet werden."
 
 #: builtin/diff.c:83
 #, c-format
@@ -7932,19 +7920,19 @@ msgid "failed: %d"
 msgstr "fehlgeschlagen: %d"
 
 #: builtin/difftool.c:283
-#, fuzzy, c-format
+#, c-format
 msgid "could not read symlink %s"
 msgstr "konnte symbolische Verknüpfung %s nicht lesen"
 
 #: builtin/difftool.c:285
-#, fuzzy, c-format
+#, c-format
 msgid "could not read symlink file %s"
-msgstr "Konnte Eingabe-Datei '%s' nicht lesen"
+msgstr "Konnte Datei von symbolischer Verknüpfung '%s' nicht lesen."
 
 #: builtin/difftool.c:293
-#, fuzzy, c-format
+#, c-format
 msgid "could not read object %s for symlink %s"
-msgstr "Kann Objekt %s nicht lesen."
+msgstr "Konnte Objekt '%s' für symbolische Verknüpfung '%s' nicht lesen."
 
 #: builtin/difftool.c:395
 msgid ""
@@ -8406,14 +8394,12 @@ msgid "git for-each-ref [--points-at <object>]"
 msgstr "git for-each-ref [--points-at <Objekt>]"
 
 #: builtin/for-each-ref.c:11
-#, fuzzy
 msgid "git for-each-ref [(--merged | --no-merged) [<commit>]]"
-msgstr "git for-each-ref [(--merged | --no-merged) [<Objekt>]]"
+msgstr "git for-each-ref [(--merged | --no-merged) [<Commit>]]"
 
 #: builtin/for-each-ref.c:12
-#, fuzzy
 msgid "git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"
-msgstr "git for-each-ref [--contains [<Objekt>]]"
+msgstr "git for-each-ref [--contains [<Objekt>]] [--no-contains [<Commit>]]"
 
 #: builtin/for-each-ref.c:27
 msgid "quote placeholders suitably for shells"
@@ -8452,9 +8438,8 @@ msgid "print only refs which contain the commit"
 msgstr "nur Referenzen ausgeben, die diesen Commit enthalten"
 
 #: builtin/for-each-ref.c:46
-#, fuzzy
 msgid "print only refs which don't contain the commit"
-msgstr "nur Referenzen ausgeben, die diesen Commit enthalten"
+msgstr "nur Referenzen ausgeben, die diesen Commit nicht enthalten"
 
 #: builtin/fsck.c:554
 msgid "Checking object directories"
@@ -8521,14 +8506,14 @@ msgid "git gc [<options>]"
 msgstr "git gc [<Optionen>]"
 
 #: builtin/gc.c:78
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to fstat %s: %s"
-msgstr "Konnte '%s' nicht lesen"
+msgstr "Konnte '%s' nicht lesen: %s"
 
 #: builtin/gc.c:306
-#, fuzzy, c-format
+#, c-format
 msgid "Can't stat %s"
-msgstr "Kann '%s' nicht lesen"
+msgstr "Kann '%s' nicht lesen."
 
 #: builtin/gc.c:315
 #, c-format
@@ -8565,9 +8550,9 @@ msgstr ""
 "\"git gc\" bereits ausgeführt wird"
 
 #: builtin/gc.c:375
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to parse gc.logexpiry value %s"
-msgstr "konnte Standard-Farbwert nicht parsen"
+msgstr "Fehler beim Parsen des Wertes '%s' von gc.logexpiry"
 
 #: builtin/gc.c:403
 #, c-format
@@ -8649,7 +8634,6 @@ msgid "ignore files specified via '.gitignore'"
 msgstr "Dateien, die über '.gitignore' angegeben sind, ignorieren"
 
 #: builtin/grep.c:988
-#, fuzzy
 msgid "recursively search in each submodule"
 msgstr "rekursive Suche in jedem Submodul"
 
@@ -8826,16 +8810,13 @@ msgid "no pattern given."
 msgstr "keine Muster angegeben"
 
 #: builtin/grep.c:1189
-#, fuzzy
 msgid "--no-index or --untracked cannot be used with revs"
-msgstr ""
-"Die Optionen --no-index und --untracked können nicht mit Commits verwendet "
-"werden."
+msgstr "--no-index oder --untracked können nicht mit Commits verwendet werden"
 
 #: builtin/grep.c:1195
-#, fuzzy, c-format
+#, c-format
 msgid "unable to resolve revision: %s"
-msgstr "Konnte %s nicht nach %s verschieben"
+msgstr "Konnte Commit nicht auflösen: %s"
 
 #: builtin/grep.c:1228 builtin/index-pack.c:1485
 #, c-format
@@ -9157,9 +9138,9 @@ msgid "unable to read %s"
 msgstr "kann %s nicht lesen"
 
 #: builtin/index-pack.c:814
-#, fuzzy, c-format
+#, c-format
 msgid "cannot read existing object info %s"
-msgstr "Kann existierendes Objekt %s nicht lesen."
+msgstr "Kann existierende Informationen zu Objekt %s nicht lesen."
 
 #: builtin/index-pack.c:822
 #, c-format
@@ -10644,9 +10625,8 @@ msgid "only use refs matching <pattern>"
 msgstr "nur Referenzen verwenden die <Muster> entsprechen"
 
 #: builtin/name-rev.c:351
-#, fuzzy
 msgid "ignore refs matching <pattern>"
-msgstr "nur Referenzen verwenden die <Muster> entsprechen"
+msgstr "ignoriere Referenzen die <Muster> entsprechen"
 
 #: builtin/name-rev.c:353
 msgid "list all commits reachable from all refs"
@@ -11886,18 +11866,16 @@ msgid "debug unpack-trees"
 msgstr "unpack-trees protokollieren"
 
 #: builtin/rebase--helper.c:7
-#, fuzzy
 msgid "git rebase--helper [<options>]"
-msgstr "git repack [<Optionen>]"
+msgstr "git rebase--helper [<Optionen>]"
 
 #: builtin/rebase--helper.c:19
 msgid "continue rebase"
-msgstr ""
+msgstr "Rebase fortsetzen"
 
 #: builtin/rebase--helper.c:21
-#, fuzzy
 msgid "abort rebase"
-msgstr "Merge von Notizen abbrechen"
+msgstr "Rebase abbrechen"
 
 #: builtin/receive-pack.c:27
 msgid "git receive-pack <git-dir>"
@@ -12887,13 +12865,12 @@ msgid "edit the commit message"
 msgstr "Commit-Beschreibung bearbeiten"
 
 #: builtin/revert.c:105
-#, fuzzy
 msgid "parent-number"
 msgstr "Nummer des Elternteils"
 
 #: builtin/revert.c:106
 msgid "select mainline parent"
-msgstr ""
+msgstr "Elternteil der Hauptlinie auswählen"
 
 #: builtin/revert.c:108
 msgid "merge strategy"
@@ -13308,6 +13285,8 @@ msgid ""
 "could not lookup configuration '%s'. Assuming this repository is its own "
 "authoritative upstream."
 msgstr ""
+"Konnte Konfiguration '%s' nicht nachschlagen. Nehme an, dass dieses Repository\n"
+"sein eigenes verbindliches Upstream-Repository ist."
 
 #: builtin/submodule--helper.c:406
 #, c-format
@@ -13547,13 +13526,12 @@ msgid "git tag -d <tagname>..."
 msgstr "git tag -d <Tagname>..."
 
 #: builtin/tag.c:25
-#, fuzzy
 msgid ""
 "git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--"
 "points-at <object>]\n"
 "\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"
 msgstr ""
-"git tag -l [-n[<Nummer>]] [--contains <Commit>] [--points-at <Objekt>]\n"
+"git tag -l [-n[<Nummer>]] [--contains <Commit>] [--no-contains <Commit>] [--points-at <Objekt>]\n"
 "\t\t[--format=<Muster>] [--[no-]merged [<Commit>]] [<Muster>...]"
 
 #: builtin/tag.c:27
@@ -13621,32 +13599,27 @@ msgstr "Die Tag-Beschreibung wurde gelassen in %s\n"
 
 #: builtin/tag.c:312
 msgid "tag: tagging "
-msgstr ""
+msgstr "tag: tagge "
 
 #: builtin/tag.c:320
-#, fuzzy
 msgid "object of unknown type"
-msgstr "Art des Objektes"
+msgstr "Art des Objektes unbekannt"
 
 #: builtin/tag.c:327
-#, fuzzy
 msgid "commit object"
-msgstr "Fehler in Objekt"
+msgstr "Commit-Objekt"
 
 #: builtin/tag.c:335
-#, fuzzy
 msgid "tree object"
-msgstr "Objekt"
+msgstr "Tree-Objekt"
 
 #: builtin/tag.c:338
-#, fuzzy
 msgid "blob object"
-msgstr "Objekt"
+msgstr "Blob-Objekt"
 
 #: builtin/tag.c:341
-#, fuzzy
 msgid "other tag object"
-msgstr "zu kurzes Tree-Objekt"
+msgstr "anderes Tag-Objekt"
 
 #: builtin/tag.c:397
 msgid "list tag names"
@@ -13705,9 +13678,8 @@ msgid "print only tags that contain the commit"
 msgstr "nur Tags ausgeben, die diesen Commit beinhalten"
 
 #: builtin/tag.c:421 builtin/tag.c:423
-#, fuzzy
 msgid "print only tags that don't contain the commit"
-msgstr "nur Tags ausgeben, die diesen Commit beinhalten"
+msgstr "nur Tags ausgeben, die diesen Commit nicht enthalten"
 
 #: builtin/tag.c:424
 msgid "print only tags that are merged"
@@ -13726,29 +13698,24 @@ msgid "--column and -n are incompatible"
 msgstr "--column und -n sind inkompatibel"
 
 #: builtin/tag.c:491
-#, fuzzy
 msgid "-n option is only allowed in list mode"
-msgstr "-n Option ist nur erlaubt mit -l."
+msgstr "Die Option -n ist nur im Listenmodus erlaubt."
 
 #: builtin/tag.c:493
-#, fuzzy
 msgid "--contains option is only allowed in list mode"
-msgstr "--contains Option ist nur erlaubt mit -l."
+msgstr "Die Option --contains ist nur im Listenmodus erlaubt."
 
 #: builtin/tag.c:495
-#, fuzzy
 msgid "--no-contains option is only allowed in list mode"
-msgstr "--contains Option ist nur erlaubt mit -l."
+msgstr "Die Option --no-contains ist nur im Listenmodus erlaubt."
 
 #: builtin/tag.c:497
-#, fuzzy
 msgid "--points-at option is only allowed in list mode"
-msgstr "--points-at Option ist nur erlaubt mit -l."
+msgstr "Die Option --points-at ist nur im Listenmodus erlaubt."
 
 #: builtin/tag.c:499
-#, fuzzy
 msgid "--merged and --no-merged options are only allowed in list mode"
-msgstr "Die Optionen --merged und --no-merged sind nur mit -l erlaubt."
+msgstr "Die Optionen --merged und --no-merged sind nur im Listenmodus erlaubt."
 
 #: builtin/tag.c:510
 msgid "only one -F or -m option is allowed."
@@ -13975,23 +13942,20 @@ msgstr ""
 "Cache für unversionierte Dateien ohne Prüfung des Dateisystems aktivieren"
 
 #: builtin/update-index.c:1107
-#, fuzzy
 msgid ""
 "core.splitIndex is set to false; remove or change it, if you really want to "
 "enable split index"
 msgstr ""
-"core.untrackedCache ist auf 'false' gesetzt. Entfernen oder ändern Sie "
-"dies,\n"
-"wenn sie wirklich den Cache für unversionierte Dateien aktivieren möchten."
+"core.splitIndex ist auf 'false' gesetzt. Entfernen oder ändern Sie dies,\n"
+"wenn sie wirklich das Splitting des Index aktivieren möchten."
 
 #: builtin/update-index.c:1116
-#, fuzzy
 msgid ""
 "core.splitIndex is set to true; remove or change it, if you really want to "
 "disable split index"
 msgstr ""
-"core.untrackedCache ist auf 'true' gesetzt. Entfernen oder ändern Sie dies,\n"
-"wenn Sie wirklich den Cache für unversionierte Dateien deaktivieren möchten."
+"core.splitIndex ist auf 'true' gesetzt. Entfernen oder ändern Sie dies,\n"
+"wenn Sie wirklich das Splitting des Index deaktivieren möchten."
 
 #: builtin/update-index.c:1127
 msgid ""
@@ -16259,7 +16223,6 @@ msgstr "Diff überprüfen"
 #. TRANSLATORS: please do not translate the command names
 #. 'status', 'update', 'revert', etc.
 #: git-add--interactive.perl:1668
-#, fuzzy
 msgid ""
 "status        - show paths with changes\n"
 "update        - add working tree state to the staged set of changes\n"
@@ -16270,12 +16233,10 @@ msgid ""
 "changes\n"
 msgstr ""
 "status        - Pfade mit Änderungen anzeigen\n"
-"update        - Zustand des Arbeitsverzeichnisses den zum Commit "
-"vorgemerkten Änderungen hinzufügen\n"
-"revert        - zum Commit vorgemerkten Änderungen auf HEAD Version "
-"zurücksetzen\n"
+"update        - Zustand des Arbeitsverzeichnisses den zum Commit vorgemerkten Änderungen hinzufügen\n"
+"revert        - zum Commit vorgemerkte Änderungen auf HEAD Version zurücksetzen\n"
 "patch         - Patch-Blöcke auswählen und selektiv aktualisieren\n"
-"diff\t      - Unterschiede zwischen HEAD und Index anzeigen\n"
+"diff          - Unterschiede zwischen HEAD und Index anzeigen\n"
 "add untracked - Inhalte von unversionierten Dateien zum Commit vormerken\n"
 
 #: git-add--interactive.perl:1685 git-add--interactive.perl:1690
-- 
2.13.0.rc0.207.gb44265493


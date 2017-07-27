Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C1120899
	for <e@80x24.org>; Thu, 27 Jul 2017 18:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbdG0SX0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 14:23:26 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35375 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbdG0SXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 14:23:25 -0400
Received: by mail-wm0-f52.google.com with SMTP id m85so2951360wma.0
        for <git@vger.kernel.org>; Thu, 27 Jul 2017 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :references:content-transfer-encoding;
        bh=BTiPHGFdbYINuLXlvNRSKaRAHrNS1F+F936dHfYNCGs=;
        b=eyqc0y4uAv+Eto13pVuap9C0Oqxt7Nkm8kvvgfdKgVo1y2s0FERQCIH5kD5MUNb74k
         e8wf3kIxKDSpt8SUPANn5mEt2nVSBZPSAFJHsYkI/JkSytNIYk2It2XWXkWwM4zHEt8t
         /UH9n9Q85/tLi7iT3vC+pc2wgmbnXLbgQmQYv63/2vtu8oWyfBNQxJ8clbs8+hG09HC6
         pN4Y5VY2UVsUTZUn0ecCXhXJ5hELdtd2VSiKAAZz65nwnYrZzc+mn9y4//IQtQHsJB3l
         mxaIwm4DYgkfFUHZicsBL3akFR7sb4ziIGxEo3PzyNQDqaxES36Q/qBfMPBHUktVokvb
         RFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:references:content-transfer-encoding;
        bh=BTiPHGFdbYINuLXlvNRSKaRAHrNS1F+F936dHfYNCGs=;
        b=rMew+rkt7WpJVF5Nt08EgHwCZIgv92pobYN15cy14sbO9PYuzxStFWzoXXyNReCzUQ
         gFsT9qHCJ5pc201UxCVG54COgMbUfw6RKVkad2cypoEaVeXPILWkTeKjKE7XhullQTYL
         5+KjbKRrWYvCpa04slqjLDS4aDnTZQ2EAh2zUn1Wr4HSQ/mv49KsYUWXQ1A7+h2PboSU
         fyANXKCoFNTavcCITO14csudhd0yFSNcME56VGdUEYQ8isCAPBUmA8uynZYjzt1SGIJw
         VAdvtmijWldbNPC/foKm9ydZFhl6VmUsnhsVG4nvFdfm68HQ+O2DN1bMJA+bJgZ5zcXQ
         smOA==
X-Gm-Message-State: AIVw113JFvCvN/cGr4FmMWbFKC2wLZa3nNCOUla4Sgy5MtMw7HqtDGVp
        iua51yJbHikWY5RCtD0=
X-Received: by 10.28.27.205 with SMTP id b196mr4012088wmb.33.1501179803456;
        Thu, 27 Jul 2017 11:23:23 -0700 (PDT)
Received: from localhost (cable-62-117-29-180.cust.telecolumbus.net. [62.117.29.180])
        by smtp.gmail.com with ESMTPSA id 35sm21469025wrp.63.2017.07.27.11.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jul 2017 11:23:22 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Hartmut Henkel <henkel@vh-s.de>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?q?Magnus=20G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] l10n: de.po: various fixes in German translation
Date:   Thu, 27 Jul 2017 20:23:20 +0200
Message-Id: <20170727182320.10267-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432df
MIME-Version: 1.0
In-Reply-To: <20170727173028.8863-1-ralf.thielow@gmail.com>
References: <20170727173028.8863-1-ralf.thielow@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hartmut Henkel <henkel@vh-s.de>

Signed-off-by: Hartmut Henkel <henkel@vh-s.de>
Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 52 +++++++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/po/de.po b/po/de.po
index c5b7ed501..362ebb6bb 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1287,7 +1287,7 @@ msgid ""
 "variable i18n.commitencoding to the encoding your project uses.\n"
 msgstr ""
 "Warnung: Die Commit-Beschreibung ist nicht UTF-8 konform.\n"
-"Sie können das Nachbessern, nachdem Sie die Beschreibung korrigiert haben,\n"
+"Sie können das nachbessern, nachdem Sie die Beschreibung korrigiert haben,\n"
 "oder Sie setzen die Konfigurationsvariable i18n.commitencoding auf das "
 "Encoding,\n"
 "welches von ihrem Projekt verwendet wird.\n"
@@ -1465,7 +1465,7 @@ msgstr "Konnte '%s' nicht aufheben."
 
 #: connect.c:50
 msgid "The remote end hung up upon initial contact"
-msgstr "Die Gegenseite hat sich nach dem erstmaligen Kontakt aufgehangen."
+msgstr "Die Gegenseite hat nach dem ersten Kontakt abgebrochen."
 
 #: connect.c:52
 msgid ""
@@ -3018,7 +3018,7 @@ msgid ""
 "after resolving the conflicts, mark the corrected paths\n"
 "with 'git add <paths>' or 'git rm <paths>'"
 msgstr ""
-"nach Auflösung der Konflikte, markieren Sie die korrigierten Pfade\n"
+"nach Auflösung der Konflikte markieren Sie die korrigierten Pfade\n"
 "mit 'git add <Pfade>' oder 'git rm <Pfade>'"
 
 #: sequencer.c:282
@@ -3027,8 +3027,8 @@ msgid ""
 "with 'git add <paths>' or 'git rm <paths>'\n"
 "and commit the result with 'git commit'"
 msgstr ""
-"nach Auflösung der Konflikte, markieren Sie die korrigierten Pfade\n"
-"mit 'git add <Pfade>' oder 'git rm <Pfade>'und tragen Sie das Ergebnis mit\n"
+"nach Auflösung der Konflikte markieren Sie die korrigierten Pfade\n"
+"mit 'git add <Pfade>' oder 'git rm <Pfade>' und tragen Sie das Ergebnis mit\n"
 "'git commit' ein"
 
 #: sequencer.c:295 sequencer.c:1685
@@ -3336,7 +3336,7 @@ msgstr "kann HEAD nicht auflösen"
 
 #: sequencer.c:1618 sequencer.c:1652
 msgid "cannot abort from a branch yet to be born"
-msgstr "kann nicht abbrechen: bin auf einem Branch, der noch geboren wird"
+msgstr "kann nicht abbrechen: bin auf einem Branch, der noch nicht geboren ist"
 
 #: sequencer.c:1638 builtin/grep.c:929
 #, c-format
@@ -3359,8 +3359,7 @@ msgstr "gespeicherte \"pre-cherry-pick\" HEAD Datei '%s' ist beschädigt"
 
 #: sequencer.c:1658
 msgid "You seem to have moved HEAD. Not rewinding, check your HEAD!"
-msgstr ""
-"Sie scheinen HEAD verschoben zu haben. Keine Zurücksetzung, prüfen Sie HEAD."
+msgstr "Sie scheinen HEAD verändert zu haben. Keine Rückspulung, prüfen Sie HEAD."
 
 #: sequencer.c:1795 sequencer.c:2086
 msgid "cannot read HEAD"
@@ -3564,7 +3563,7 @@ msgstr "Kein Git-Repository (oder irgendein Elternverzeichnis): %s"
 
 #: setup.c:812 builtin/index-pack.c:1652
 msgid "Cannot come back to cwd"
-msgstr "Kann nicht zurück zu Arbeitsverzeichnis wechseln"
+msgstr "Kann nicht zurück zum Arbeitsverzeichnis wechseln"
 
 #: setup.c:1050
 msgid "Unable to read current working directory"
@@ -3938,7 +3937,7 @@ msgid ""
 msgstr ""
 "Ihre lokalen Änderungen in den folgenden Dateien würden durch den Merge\n"
 "überschrieben werden:\n"
-"%%sBitte committen oder stashen Sie Ihre Änderungen, bevor sie mergen."
+"%%sBitte committen oder stashen Sie Ihre Änderungen, bevor Sie mergen."
 
 #: unpack-trees.c:112
 #, c-format
@@ -5412,7 +5411,7 @@ msgstr "leere SHA-1 für Grenz-Commits anzeigen (Standard: aus)"
 
 #: builtin/blame.c:670
 msgid "Do not treat root commits as boundaries (Default: off)"
-msgstr "Ursprungs-Commit nicht als Grenzen behandeln (Standard: aus)"
+msgstr "Ursprungs-Commits nicht als Grenzen behandeln (Standard: aus)"
 
 #: builtin/blame.c:671
 msgid "Show work cost statistics"
@@ -5523,7 +5522,7 @@ msgstr ""
 #.
 #: builtin/blame.c:795
 msgid "4 years, 11 months ago"
-msgstr "vor 4 Jahren, und 11 Monaten"
+msgstr "vor 4 Jahren und 11 Monaten"
 
 #: builtin/blame.c:882
 #, c-format
@@ -6297,13 +6296,13 @@ msgid_plural ""
 "\n"
 msgstr[0] ""
 "Wenn Sie diese durch einen neuen Branch behalten möchten, dann könnte jetzt\n"
-"ein guter Zeitpunkt sein dies zu tun mit:\n"
+"ein guter Zeitpunkt sein, dies zu tun mit:\n"
 "\n"
 " git branch <neuer-Branchname> %s\n"
 "\n"
 msgstr[1] ""
 "Wenn Sie diese durch einen neuen Branch behalten möchten, dann könnte jetzt\n"
-"ein guter Zeitpunkt sein dies zu tun mit:\n"
+"ein guter Zeitpunkt sein, dies zu tun mit:\n"
 "\n"
 " git branch <neuer-Branchname> %s\n"
 "\n"
@@ -6318,7 +6317,7 @@ msgstr "Vorherige Position von HEAD war"
 
 #: builtin/checkout.c:832 builtin/checkout.c:1070
 msgid "You are on a branch yet to be born"
-msgstr "Sie sind auf einem Branch, der noch geboren wird"
+msgstr "Sie sind auf einem Branch, der noch nicht geboren ist"
 
 #: builtin/checkout.c:976
 #, c-format
@@ -6975,7 +6974,7 @@ msgstr ""
 msgid "source repository is shallow, ignoring --local"
 msgstr ""
 "Quelle ist ein Repository mit unvollständiger Historie (shallow),\n"
-"--local wird ignoriert"
+"ignoriere --local"
 
 #: builtin/clone.c:1079
 msgid "--local is ignored"
@@ -7793,7 +7792,7 @@ msgid ""
 "#\tname = %s\n"
 "#\temail = %s\n"
 msgstr ""
-"# Das ist Git's benutzerspezifische Konfiguraionsdatei.\n"
+"# Das ist Git's benutzerspezifische Konfigurationsdatei.\n"
 "[user]\n"
 "# Bitte passen Sie die folgenden Zeilen an und kommentieren Sie diese aus:\n"
 "#\tname = %s\n"
@@ -8396,7 +8395,7 @@ msgstr "(nichts)"
 #, c-format
 msgid "Refusing to fetch into current branch %s of non-bare repository"
 msgstr ""
-"Der \"fetch\" in den aktuellen Branch %s von einem nicht-Bare-Repository "
+"Der \"fetch\" in den aktuellen Branch %s von einem Nicht-Bare-Repository "
 "wurde verweigert."
 
 #: builtin/fetch.c:997
@@ -10077,7 +10076,7 @@ msgstr ""
 
 #: builtin/ls-remote.c:66
 msgid "show underlying ref in addition to the object pointed by it"
-msgstr "zusätzlich die auf durch dieses Objekt verwiesene Referenzen anzeigen"
+msgstr "zusätzlich zum Objekt die darauf verweisenden Referenzen anzeigen"
 
 #: builtin/ls-tree.c:29
 msgid "git ls-tree [<options>] <tree-ish> [<path>...]"
@@ -10366,7 +10365,7 @@ msgstr "--abort akzeptiert keine Argumente"
 
 #: builtin/merge.c:1149
 msgid "There is no merge to abort (MERGE_HEAD missing)."
-msgstr "Es gibt keinen Merge zum Abbrechen (MERGE_HEAD fehlt)"
+msgstr "Es gibt keinen Merge abzubrechen (MERGE_HEAD fehlt)"
 
 #: builtin/merge.c:1161
 msgid "--continue expects no arguments"
@@ -10542,7 +10541,7 @@ msgstr "Commits auflisten, die nicht durch Andere erreichbar sind"
 
 #: builtin/merge-base.c:224
 msgid "is the first one ancestor of the other?"
-msgstr "ist der Erste ein Vorgänger-Commit von dem Anderen?"
+msgstr "ist der Erste ein Vorgänger-Commit des Anderen?"
 
 #: builtin/merge-base.c:226
 msgid "find where <commit> forked from reflog of <ref>"
@@ -11257,8 +11256,7 @@ msgstr "Fortschrittsanzeige anzeigen"
 
 #: builtin/pack-objects.c:2881
 msgid "show progress meter during object writing phase"
-msgstr ""
-"Forschrittsanzeige während der Phase des Schreibens der Objekte anzeigen"
+msgstr "Forschrittsanzeige während des Schreibens von Objekten anzeigen"
 
 #: builtin/pack-objects.c:2884
 msgid "similar to --all-progress when progress meter is shown"
@@ -12037,7 +12035,7 @@ msgid ""
 "'receive.denyCurrentBranch' configuration variable to 'refuse'."
 msgstr ""
 "Standardmäßig wird die Aktualisierung des aktuellen Branches in einem\n"
-"nicht-Bare-Repository zurückgewiesen, da dies den Index und das Arbeits-\n"
+"Nicht-Bare-Repository zurückgewiesen, da dies den Index und das Arbeits-\n"
 "verzeichnis inkonsistent zu dem machen würde, was Sie gepushed haben, und\n"
 "'git reset --hard' erforderlich wäre, damit das Arbeitsverzeichnis HEAD\n"
 "entspricht.\n"
@@ -13092,7 +13090,7 @@ msgid ""
 "(use --cached to keep the file, or -f to force removal)"
 msgstr ""
 "\n"
-"(benutzen Sie --cached, um die Datei zu behalten, oder -f, um die Entfernung "
+"(benutzen Sie --cached, um die Datei zu behalten, oder -f, um das Entfernen "
 "zu erzwingen)"
 
 #: builtin/rm.c:225
@@ -13115,7 +13113,7 @@ msgstr "die \"up-to-date\" Prüfung überschreiben"
 
 #: builtin/rm.c:246
 msgid "allow recursive removal"
-msgstr "rekursive Entfernung erlauben"
+msgstr "rekursives Entfernen erlauben"
 
 #: builtin/rm.c:248
 msgid "exit with a zero status even if nothing matched"
@@ -16392,7 +16390,7 @@ msgstr "ungültiges Argument %s, erwarte --"
 #: git-send-email.perl:126
 msgid "local zone differs from GMT by a non-minute interval\n"
 msgstr ""
-"lokale Zeitzone unterscheidet sich von GMT nicht um einen Minutenintervall\n"
+"lokale Zeitzone unterscheidet sich von GMT nicht um ein Minutenintervall\n"
 
 #: git-send-email.perl:133 git-send-email.perl:139
 msgid "local time offset greater than or equal to 24 hours\n"
-- 
2.14.0.rc0.400.g1c36432df


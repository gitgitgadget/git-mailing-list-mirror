From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 99 new messages
Date: Mon, 29 Jul 2013 06:26:58 +0200
Message-ID: <1375072018-3266-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Mon Jul 29 06:27:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3f39-0001we-Sm
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 06:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab3G2E1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jul 2013 00:27:07 -0400
Received: from mail-ea0-f170.google.com ([209.85.215.170]:54913 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab3G2E1E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 00:27:04 -0400
Received: by mail-ea0-f170.google.com with SMTP id h14so387088eak.29
        for <git@vger.kernel.org>; Sun, 28 Jul 2013 21:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=PCzR9FeM9HX/yFF5i8HoQ1C2r76gXRP9tkVFcGAHTtM=;
        b=kPX6IQ28iNdxhEdbCPGcgWHMj8hC0xCh5h4QeIz5zOvZMaML9psZYDQNHtgP0xqVIW
         tnRjWyYISDq0hize/fovV831RfR8IFcbDqnRYOxm8bgvqZfrfq56TQ8MEtTWbHv+nM+S
         JiF5KdlpQrqcH+0mruGhPziNarUwojcPMH62CKJ7UpTSdppeCwUphcHySyj8UD89e1Nc
         kWfdONwV/t/W+N4G0mkoZUqDi09G2DHT0ulTwxxnx2hA/6N0fI46O0YHq/nBqB/Pw/mQ
         E4P9lKLgF4xpcrGMUHvqiZZkQRi5FWAqHZbApoEu0FXUskXKcxMgzsBEuPF81R7FeeIj
         Sijw==
X-Received: by 10.14.173.130 with SMTP id v2mr57997821eel.29.1375072022405;
        Sun, 28 Jul 2013 21:27:02 -0700 (PDT)
Received: from localhost (dslb-088-073-170-058.pools.arcor-ip.net. [88.73.170.58])
        by mx.google.com with ESMTPSA id n42sm99294402eeh.15.2013.07.28.21.27.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 28 Jul 2013 21:27:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1873.gfc589a4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231274>

Translate 99 new messages came from git.pot update in
28b3cff (l10n: git.pot: v1.8.4 round 1 (99 new, 46 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 366 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 180 insertions(+), 186 deletions(-)

diff --git a/po/de.po b/po/de.po
index ee5e786..ce6287f 100644
--- a/po/de.po
+++ b/po/de.po
@@ -6,11 +6,11 @@
 msgid ""
 msgstr ""
 "Project-Id-Version: git 1.8.4\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
 "POT-Creation-Date: 2013-07-26 14:19+0800\n"
-"PO-Revision-Date: 2012-10-02 19:35+0200\n"
+"PO-Revision-Date: 2013-07-28 18:42+0200\n"
 "Last-Translator: Ralf Thielow <ralf.thielow@gmail.com>\n"
 "Language-Team: German <>\n"
 "Language: de\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
@@ -570,13 +570,13 @@ msgstr[0] ""
 msgstr[1] ""
 "\n"
 "Haben Sie eines von diesen gemeint?"
=20
 #: help.c:443
-#, fuzzy, c-format
+#, c-format
 msgid "%s: %s - %s"
-msgstr "%s: %s"
+msgstr "%s: %s - %s"
=20
 #: merge.c:56
 msgid "failed to read the cache"
 msgstr "Lesen des Zwischenspeichers fehlgeschlagen"
=20
@@ -953,16 +953,16 @@ msgstr ""
 "  (benutzen Sie \"git pull\" um Ihren Branch mit dem Remote-Branch "
 "zusammenzuf=C3=BChren)\n"
=20
 #: run-command.c:80
 msgid "open /dev/null failed"
-msgstr ""
+msgstr "=C3=96ffnen von /dev/null fehlgeschlagen"
=20
 #: run-command.c:82
 #, c-format
 msgid "dup2(%d,%d) failed"
-msgstr ""
+msgstr "dup2(%d,%d) fehlgeschlagen"
=20
 #: sequencer.c:206 builtin/merge.c:790 builtin/merge.c:903
 #: builtin/merge.c:1013 builtin/merge.c:1023
 #, c-format
 msgid "Could not open '%s' for writing"
@@ -1221,10 +1221,22 @@ msgid ""
 "\n"
 "where \"$br\" is somehow empty and a 40-hex ref is created. Please\n"
 "examine these refs and maybe delete them. Turn this message off by\n"
 "running \"git config advice.object_name_warning false\""
 msgstr ""
+"Git erzeugt normalerweise keine Referenzen die mit\n"
+"40 Hex-Zeichen enden, da diese ignoriert werden wenn\n"
+"Sie diese angeben. Diese Referenzen k=C3=B6nnten ausversehen\n"
+"erzeugt worden sein. Zum Beispiel,\n"
+"\n"
+"  git checkout -b $br $(git rev-parse ...)\n"
+"\n"
+"wobei \"$br\" leer ist und eine 40-Hex-Referenz erzeugt\n"
+"wurde. Bitte pr=C3=BCfen Sie diese Referenzen und l=C3=B6schen\n"
+"Sie sie gegebenenfalls. Unterdr=C3=BCcken Sie diese Meldung\n"
+"indem Sie \"git config advice.object_name_warning false\"\n"
+"ausf=C3=BChren."
=20
 #: sha1_name.c:1097
 msgid "HEAD does not point to a branch"
 msgstr "HEAD zeigt auf keinen Branch"
=20
@@ -1447,15 +1459,12 @@ msgstr "Eine \"am\"-Sitzung ist im Gange."
 #: wt-status.c:825
 msgid "The current patch is empty."
 msgstr "Der aktuelle Patch ist leer."
=20
 #: wt-status.c:829
-#, fuzzy
 msgid "  (fix conflicts and then run \"git am --continue\")"
-msgstr ""
-"  (beheben Sie die Konflikte und f=C3=BChren Sie dann \"git rebase --=
continue\" "
-"aus)"
+msgstr "  (beheben Sie die Konflikte und f=C3=BChren Sie dann \"git am=
 --continue\" aus)"
=20
 #: wt-status.c:831
 msgid "  (use \"git am --skip\" to skip this patch)"
 msgstr "  (benutzen Sie \"git am --skip\" um diesen Patch auszulassen)=
"
=20
@@ -1538,26 +1547,20 @@ msgstr ""
 #: wt-status.c:954
 msgid "You are currently cherry-picking."
 msgstr "Sie f=C3=BChren gerade \"cherry-pick\" aus."
=20
 #: wt-status.c:958
-#, fuzzy
 msgid "  (fix conflicts and run \"git cherry-pick --continue\")"
-msgstr ""
-"  (beheben Sie die Konflikte und f=C3=BChren Sie dann \"git revert --=
continue\" "
-"aus)"
+msgstr "  (beheben Sie die Konflikte und f=C3=BChren Sie dann \"git ch=
erry-pick --continue\" aus)"
=20
 #: wt-status.c:961
-#, fuzzy
 msgid "  (all conflicts fixed: run \"git cherry-pick --continue\")"
-msgstr "  (alle Konflikte behoben: f=C3=BChren Sie \"git revert --cont=
inue\" aus)"
+msgstr "  (alle Konflikte behoben: f=C3=BChren Sie \"git cherry-pick -=
-continue\" aus)"
=20
 #: wt-status.c:963
-#, fuzzy
 msgid "  (use \"git cherry-pick --abort\" to cancel the cherry-pick op=
eration)"
-msgstr ""
-"  (benutzen Sie \"git revert --abort\" um die Revert-Operation abzubr=
echen)"
+msgstr "  (benutzen Sie \"git cherry-pick --abort\" um die Cherry-Pick=
-Operation abzubrechen)"
=20
 #: wt-status.c:972
 #, c-format
 msgid "You are currently reverting commit %s."
 msgstr "Sie sind gerade an einem Revert von Commit '%s'."
@@ -1595,13 +1598,12 @@ msgstr ""
 #: wt-status.c:1173
 msgid "On branch "
 msgstr "Auf Branch "
=20
 #: wt-status.c:1180
-#, fuzzy
 msgid "rebase in progress; onto "
-msgstr "Kein Rebase im Gange?"
+msgstr "Rebase im Gange; auf "
=20
 #: wt-status.c:1187
 msgid "HEAD detached at "
 msgstr "HEAD losgel=C3=B6st bei "
=20
@@ -2221,11 +2223,11 @@ msgstr "make_cache_entry f=C3=BCr Pfad '%s' feh=
lgeschlagen"
 #, c-format
 msgid "unable to remove %s from index"
 msgstr "konnte %s nicht aus der Staging-Area entfernen"
=20
 #: builtin/apply.c:3851
-#, fuzzy, c-format
+#, c-format
 msgid "corrupt patch for submodule %s"
 msgstr "fehlerhafter Patch f=C3=BCr Submodul %s"
=20
 #: builtin/apply.c:3855
 #, c-format
@@ -3096,13 +3098,12 @@ msgstr "Eingabepfade sind durch ein NUL Zeichen=
 abgeschlossen"
 #: builtin/check-ignore.c:18 builtin/checkout.c:1054 builtin/gc.c:177
 msgid "suppress progress reporting"
 msgstr "unterdr=C3=BCckt Fortschrittsanzeige"
=20
 #: builtin/check-ignore.c:26
-#, fuzzy
 msgid "show non-matching input paths"
-msgstr "zeigt Zeilen ohne =C3=9Cbereinstimmungen"
+msgstr "zeigt Eingabe-Pfade ohne =C3=9Cbereinstimmungen"
=20
 #: builtin/check-ignore.c:143
 msgid "cannot specify pathnames with --stdin"
 msgstr "Angabe von Pfadnamen kann nicht gemeinsam mit --stdin verwende=
t werden"
=20
@@ -3122,33 +3123,29 @@ msgstr "Die Option --quiet ist nur mit einem ei=
nzelnen Pfadnamen g=C3=BCltig."
 msgid "cannot have both --quiet and --verbose"
 msgstr ""
 "Die Optionen --quiet und --verbose k=C3=B6nnen nicht gemeinsam verwen=
det werden."
=20
 #: builtin/check-ignore.c:157
-#, fuzzy
 msgid "--non-matching is only valid with --verbose"
-msgstr "--points-at Option ist nur erlaubt mit -l."
+msgstr "--non-matching ist nur mit --verbose zul=C3=A4ssig"
=20
 #: builtin/check-mailmap.c:8
-#, fuzzy
 msgid "git check-mailmap [options] <contact>..."
-msgstr "git fsck [Optionen] [<Objekt>...]"
+msgstr "git check-mailmap [Optionen] <Kontakt>..."
=20
 #: builtin/check-mailmap.c:13
-#, fuzzy
 msgid "also read contacts from stdin"
-msgstr "liest Objekte von der Standard-Eingabe"
+msgstr "liest ebenfalls Kontakte von der Standard-Eingabe"
=20
 #: builtin/check-mailmap.c:24
-#, fuzzy, c-format
+#, c-format
 msgid "unable to parse contact: %s"
-msgstr "Konnte Objekt '%s' nicht parsen."
+msgstr "Konnte Kontakt '%s' nicht parsen."
=20
 #: builtin/check-mailmap.c:47
-#, fuzzy
 msgid "no contacts specified"
-msgstr "kein Pfad angegeben"
+msgstr "keine Kontakte angegeben"
=20
 #: builtin/checkout-index.c:126
 msgid "git checkout-index [options] [--] [<file>...]"
 msgstr "git checkout-index [Optionen] [--] [<Datei>...]"
=20
@@ -3492,14 +3489,13 @@ msgid ""
 msgstr ""
 "git checkout: --ours/--theirs, --force und --merge sind inkompatibel =
wenn\n"
 "Sie aus der Staging-Area auschecken."
=20
 #: builtin/clean.c:25
-#, fuzzy
 msgid ""
 "git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <pat=
hs>..."
-msgstr "git clean [-d] [-f] [-n] [-q] [-e <Muster>] [-x | -X] [--] <Pf=
ade>..."
+msgstr "git clean [-d] [-f] [-i] [-n] [-q] [-e <Muster>] [-x | -X] [--=
] <Pfade>..."
=20
 #: builtin/clean.c:29
 #, c-format
 msgid "Removing %s\n"
 msgstr "L=C3=B6sche %s\n"
@@ -3529,10 +3525,14 @@ msgid ""
 "Prompt help:\n"
 "1          - select a numbered item\n"
 "foo        - select item based on unique prefix\n"
 "           - (empty) select nothing"
 msgstr ""
+"Eingabehilfe:\n"
+"1          - numeriertes Element ausw=C3=A4hlen\n"
+"foo        - Element anhand eines eindeutigen Prefix ausw=C3=A4hlen\n=
"
+"           - (leer) nichts ausw=C3=A4hlen"
=20
 #: builtin/clean.c:297
 msgid ""
 "Prompt help:\n"
 "1          - select a single item\n"
@@ -3541,38 +3541,46 @@ msgid ""
 "foo        - select item based on unique prefix\n"
 "-...       - unselect specified items\n"
 "*          - choose all items\n"
 "           - (empty) finish selecting"
 msgstr ""
+"Eingabehilfe:\n"
+"1          - einzelnes Element ausw=C3=A4hlen\n"
+"3-5        - Bereich von Elementen ausw=C3=A4hlen\n"
+"2-3,6-9    - mehrere Bereiche ausw=C3=A4hlen\n"
+"foo        - Element anhand eines eindeutigen Prefix ausw=C3=A4hlen\n=
"
+"-...       - angegebenes Element abw=C3=A4hlen\n"
+"*          - alle Elemente ausw=C3=A4hlen\n"
+"           - (leer) Auswahl beenden"
=20
 #: builtin/clean.c:491
 #, c-format
 msgid "Huh (%s)?"
-msgstr ""
+msgstr "Wie bitte (%s)?"
=20
 #: builtin/clean.c:634
 #, c-format
 msgid "Input ignore patterns>> "
-msgstr ""
+msgstr "Eingabe Ignorier-Muster>> "
=20
 #: builtin/clean.c:671
 #, c-format
 msgid "WARNING: Cannot find items matched by: %s"
-msgstr ""
+msgstr "WARNUNG: Kann keine Eintr=C3=A4ge finden die Muster entspreche=
n: %s"
=20
 #: builtin/clean.c:692
 msgid "Select items to delete"
-msgstr ""
+msgstr "W=C3=A4hlen Sie Eintr=C3=A4ge zum L=C3=B6schen"
=20
 #: builtin/clean.c:732
-#, fuzzy, c-format
+#, c-format
 msgid "remove %s? "
-msgstr "l=C3=B6sche '%s'\n"
+msgstr "'%s' l=C3=B6schen? "
=20
 #: builtin/clean.c:757
 msgid "Bye."
-msgstr ""
+msgstr "Tsch=C3=BCss."
=20
 #: builtin/clean.c:765
 msgid ""
 "clean               - start cleaning\n"
 "filter by pattern   - exclude items from deletion\n"
@@ -3580,41 +3588,47 @@ msgid ""
 "ask each            - confirm each deletion (like \"rm -i\")\n"
 "quit                - stop cleaning\n"
 "help                - this screen\n"
 "?                   - help for prompt selection"
 msgstr ""
+"clean               - Clean starten\n"
+"filter by pattern   - Eintr=C3=A4ge von L=C3=B6schung ausschlie=C3=9F=
en\n"
+"select by numbers   - Auswahl von Eintr=C3=A4gen =C3=BCber Nummern\n"
+"ask each            - jede L=C3=B6schung best=C3=A4tigen (wie \"rm -i=
\")\n"
+"quit                - Clean beenden\n"
+"help                - diese Meldung anzeigen\n"
+"?                   - Hilfe zur Auswahl mittels Eingabe anzeigen"
=20
 #: builtin/clean.c:792
 msgid "*** Commands ***"
-msgstr ""
+msgstr "*** Kommandos ***"
=20
 #: builtin/clean.c:793
 msgid "What now"
-msgstr ""
+msgstr "Was nun"
=20
 #: builtin/clean.c:801
 msgid "Would remove the following item:"
 msgid_plural "Would remove the following items:"
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "W=C3=BCrde das folgende Element entfernen:"
+msgstr[1] "W=C3=BCrde die folgenden Elemente entfernen:"
=20
 #: builtin/clean.c:818
 msgid "No more files to clean, exiting."
-msgstr ""
+msgstr "Keine Dateien mehr zum L=C3=B6schen, beende."
=20
 #: builtin/clean.c:850
 msgid "do not print names of files removed"
 msgstr "gibt keine Namen von gel=C3=B6schten Dateien aus"
=20
 #: builtin/clean.c:852
 msgid "force"
 msgstr "erzwingt Aktion"
=20
 #: builtin/clean.c:853
-#, fuzzy
 msgid "interactive cleaning"
-msgstr "interaktives Ausw=C3=A4hlen"
+msgstr "interaktives Clean"
=20
 #: builtin/clean.c:855
 msgid "remove whole directories"
 msgstr "l=C3=B6scht ganze Verzeichnisse"
=20
@@ -3638,26 +3652,20 @@ msgstr "l=C3=B6scht nur ignorierte Dateien"
 #: builtin/clean.c:878
 msgid "-x and -X cannot be used together"
 msgstr "Die Optionen -x und -X k=C3=B6nnen nicht gemeinsam verwendet w=
erden."
=20
 #: builtin/clean.c:882
-#, fuzzy
 msgid ""
 "clean.requireForce set to true and neither -i, -n nor -f given; refus=
ing to "
 "clean"
-msgstr ""
-"clean.requireForce auf \"true\" gesetzt und weder -n noch -f gegeben;=
 \"clean"
-"\" verweigert"
+msgstr "clean.requireForce auf \"true\" gesetzt und weder -i, -n noch =
-f gegeben; \"clean\" verweigert"
=20
 #: builtin/clean.c:885
-#, fuzzy
 msgid ""
 "clean.requireForce defaults to true and neither -i, -n nor -f given; =
"
 "refusing to clean"
-msgstr ""
-"clean.requireForce standardm=C3=A4=C3=9Fig auf \"true\" gesetzt und w=
eder -n noch -f "
-"gegeben; \"clean\" verweigert"
+msgstr "clean.requireForce standardm=C3=A4=C3=9Fig auf \"true\" gesetz=
t und weder -i, -n noch -f gegeben; \"clean\" verweigert"
=20
 #: builtin/clone.c:36
 msgid "git clone [options] [--] <repo> [<dir>]"
 msgstr "git clone [Optionen] [--] <Repository> [<Verzeichnis>]"
=20
@@ -3806,20 +3814,20 @@ msgid "Could not find remote branch %s to clone=
=2E"
 msgstr "Konnte zu klonenden Remote-Branch %s nicht finden."
=20
 #: builtin/clone.c:555
 #, c-format
 msgid "Checking connectivity... "
-msgstr ""
+msgstr "Pr=C3=BCfe Konnektivit=C3=A4t... "
=20
 #: builtin/clone.c:558
 msgid "remote did not send all necessary objects"
 msgstr "Remote-Repository hat nicht alle erforderlichen Objekte gesend=
et."
=20
 #: builtin/clone.c:560
-#, fuzzy, c-format
+#, c-format
 msgid "done\n"
-msgstr "Fertig.\n"
+msgstr "Fertig\n"
=20
 #: builtin/clone.c:621
 msgid "remote HEAD refers to nonexistent ref, unable to checkout.\n"
 msgstr ""
 "Externer HEAD bezieht sich auf eine nicht existierende Referenz und k=
ann "
@@ -3857,11 +3865,11 @@ msgstr ""
 "Die Option --depth wird in lokalen Klonen ignoriert; benutzen Sie "
 "stattdessen file://"
=20
 #: builtin/clone.c:798
 msgid "--local is ignored"
-msgstr ""
+msgstr "--local wird ignoriert"
=20
 #: builtin/clone.c:808
 #, c-format
 msgid "destination path '%s' already exists and is not an empty direct=
ory."
 msgstr "Zielpfad '%s' existiert bereits und ist kein leeres Verzeichni=
s."
@@ -4537,17 +4545,16 @@ msgstr "verwendet Konfigurationsdatei des Repos=
itories"
 #: builtin/config.c:56
 msgid "use given config file"
 msgstr "verwendet die angegebene Konfigurationsdatei"
=20
 #: builtin/config.c:57
-#, fuzzy
 msgid "blob-id"
-msgstr "Blob"
+msgstr "Blob-Id"
=20
 #: builtin/config.c:57
 msgid "read config from given blob object"
-msgstr ""
+msgstr "liest Konfiguration von angegebenem Blob-Objekt"
=20
 #: builtin/config.c:58
 msgid "Action"
 msgstr "Aktion"
=20
@@ -4747,11 +4754,11 @@ msgstr "verwendet jeden Tag, auch nicht-annotie=
rte"
 msgid "always use long format"
 msgstr "verwendet immer langes Format"
=20
 #: builtin/describe.c:414
 msgid "only follow first parent"
-msgstr ""
+msgstr "folgt nur erstem Elternteil"
=20
 #: builtin/describe.c:417
 msgid "only output exact matches"
 msgstr "gibt nur exakte =C3=9Cbereinstimmungen aus"
=20
@@ -6271,15 +6278,17 @@ msgstr "f=C3=BCgt  \"To:\"-Header hinzu"
 msgid "add Cc: header"
 msgstr "f=C3=BCgt \"Cc:\"-Header hinzu"
=20
 #: builtin/log.c:1196
 msgid "ident"
-msgstr ""
+msgstr "Identifikation"
=20
 #: builtin/log.c:1197
 msgid "set From address to <ident> (or committer ident if absent)"
 msgstr ""
+"setzt \"From\"-Adresse zu <Identifikation> (oder Identifikation\n"
+"des Commit-Erstellers, wenn fehlend)"
=20
 #: builtin/log.c:1199
 msgid "message-id"
 msgstr "message-id"
=20
@@ -6314,13 +6323,13 @@ msgstr "f=C3=BCgt eine Signatur hinzu"
 #: builtin/log.c:1214
 msgid "don't print the patch filenames"
 msgstr "zeigt keine Dateinamen der Patches"
=20
 #: builtin/log.c:1288
-#, fuzzy, c-format
+#, c-format
 msgid "invalid ident line: %s"
-msgstr "Ung=C3=BCltige Option: %s"
+msgstr "Ung=C3=BCltige Identifikationszeile: %s"
=20
 #: builtin/log.c:1303
 msgid "-n and -k are mutually exclusive."
 msgstr "Die Optionen -n und -k schlie=C3=9Fen sich gegenseitig aus."
=20
@@ -6733,11 +6742,11 @@ msgstr "Kein Remote-Repository f=C3=BCr den akt=
uellen Branch."
 msgid "No default upstream defined for the current branch."
 msgstr ""
 "Es ist kein Standard-Upstream-Branch f=C3=BCr den aktuellen Branch de=
finiert."
=20
 #: builtin/merge.c:984
-#, fuzzy, c-format
+#, c-format
 msgid "No remote-tracking branch for %s from %s"
 msgstr "Kein Remote-Tracking-Branch f=C3=BCr %s von %s"
=20
 #: builtin/merge.c:1140
 msgid "There is no merge to abort (MERGE_HEAD missing)."
@@ -7065,13 +7074,12 @@ msgstr "liest von der Standard-Eingabe"
 #: builtin/name-rev.c:320
 msgid "allow to print `undefined` names"
 msgstr "erlaubt Ausgabe von `undefinierten` Namen"
=20
 #: builtin/name-rev.c:326
-#, fuzzy
 msgid "dereference tags in the input (internal use)"
-msgstr "dereferenziert Tags in Objekt-Identifikationen"
+msgstr "dereferenziert Tags in der Eingabe (interne Verwendung)"
=20
 #: builtin/notes.c:24
 msgid "git notes [--ref <notes_ref>] [list [<object>]]"
 msgstr "git notes [--ref <Notiz-Referenz>] [list [<Objekt>]]"
=20
@@ -7727,20 +7735,19 @@ msgid ""
 msgstr ""
 "Sie haben keine Refspec f=C3=BCr \"push\" angegeben, und push.default=
 ist "
 "\"nothing\"."
=20
 #: builtin/push.c:232
-#, fuzzy
 msgid ""
 "Updates were rejected because the tip of your current branch is behin=
d\n"
 "its remote counterpart. Integrate the remote changes (e.g.\n"
 "'git pull ...') before pushing again.\n"
 "See the 'Note about fast-forwards' in 'git push --help' for details."
 msgstr ""
 "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze Ihres ak=
tuellen\n"
 "Branches hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen i=
st. F=C3=BChren Sie\n"
-"die externen =C3=84nderungen zusammen (z.B. 'git pull') bevor Sie \"p=
ush\"\n"
+"die externen =C3=84nderungen zusammen (z.B. 'git pull ...') bevor Sie=
 \"push\"\n"
 "erneut ausf=C3=BChren.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
 "f=C3=BCr weitere Details."
=20
 #: builtin/push.c:238
@@ -7758,40 +7765,35 @@ msgstr ""
 "Branch spezifizieren oder die Konfigurationsvariable 'push.default' z=
u "
 "'simple', 'current'\n"
 "oder 'upstream' setzen, um nur den aktuellen Branch zu versenden."
=20
 #: builtin/push.c:244
-#, fuzzy
 msgid ""
 "Updates were rejected because a pushed branch tip is behind its remot=
e\n"
 "counterpart. Check out this branch and integrate the remote changes\n=
"
 "(e.g. 'git pull ...') before pushing again.\n"
 "See the 'Note about fast-forwards' in 'git push --help' for details."
 msgstr ""
 "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze eines ve=
rsendeten\n"
 "Branches hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen i=
st. Checken Sie\n"
 "diesen Branch aus und f=C3=BChren Sie die externen =C3=84nderungen zu=
sammen\n"
-"(z.B. 'git pull') bevor Sie erneut \"push\" ausf=C3=BChren.\n"
+"(z.B. 'git pull ...') bevor Sie erneut \"push\" ausf=C3=BChren.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
 "f=C3=BCr weitere Details."
=20
 #: builtin/push.c:250
-#, fuzzy
 msgid ""
 "Updates were rejected because the remote contains work that you do\n"
 "not have locally. This is usually caused by another repository pushin=
g\n"
 "to the same ref. You may want to first integrate the remote changes\n=
"
 "(e.g., 'git pull ...') before pushing again.\n"
 "See the 'Note about fast-forwards' in 'git push --help' for details."
 msgstr ""
-"Aktualisierungen wurden zur=C3=BCckgewiesen, weil das Remote-Reposito=
ry Commits "
-"enth=C3=A4lt,\n"
-"die lokal nicht vorhanden sind. Das wird =C3=BCblicherweise durch ein=
en \"push\" "
-"von\n"
+"Aktualisierungen wurden zur=C3=BCckgewiesen, weil das Remote-Reposito=
ry Commits enth=C3=A4lt,\n"
+"die lokal nicht vorhanden sind. Das wird =C3=BCblicherweise durch ein=
en \"push\" von\n"
 "Commits auf dieselbe Referenz von einem anderen Repository aus verurs=
acht.\n"
-"Vielleicht m=C3=BCssen Sie die externen =C3=84nderungen zusammenzuf=C3=
=BChren (z.B. 'git "
-"pull')\n"
+"Vielleicht m=C3=BCssen Sie die externen =C3=84nderungen zusammenzuf=C3=
=BChren (z.B. 'git pull ...')\n"
 "bevor Sie erneut \"push\" ausf=C3=BChren.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
 "f=C3=BCr weitere Details."
=20
 #: builtin/push.c:257
@@ -8005,18 +8007,18 @@ msgstr "=C3=BCberspringt Anwendung des Filters =
f=C3=BCr sp=C3=A4rliches Auschecken"
 #: builtin/read-tree.c:138
 msgid "debug unpack-trees"
 msgstr "protokolliert Entpacken der B=C3=A4ume"
=20
 #: builtin/reflog.c:500
-#, fuzzy, c-format
+#, c-format
 msgid "%s' for '%s' is not a valid timestamp"
-msgstr "'%s' ist kein g=C3=BCltiger Name f=C3=BCr ein Remote-Repositor=
y"
+msgstr "'%s' f=C3=BCr '%s' ist kein g=C3=BCltiger Zeitstempel"
=20
 #: builtin/reflog.c:616 builtin/reflog.c:621
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' is not a valid timestamp"
-msgstr "'%s' ist kein g=C3=BCltiger Name f=C3=BCr ein Remote-Repositor=
y"
+msgstr "'%s' ist kein g=C3=BCltiger Zeitstempel"
=20
 #: builtin/remote.c:11
 msgid "git remote [-v | --verbose]"
 msgstr "git remote [-v | --verbose]"
=20
@@ -8806,65 +8808,64 @@ msgid ""
 "uses a .git directory:"
 msgid_plural ""
 "the following submodules (or one of its nested submodules)\n"
 "use a .git directory:"
 msgstr[0] ""
+"das folgende Submodul (oder ein geschachteltes Submodul hiervon)\n"
+"benutzt ein .git-Verzeichnis:"
 msgstr[1] ""
+"die folgenden Submodule (oder ein geschachteltes Submodul hiervon)\n"
+"benutzt ein .git-Verzeichnis:"
=20
 #: builtin/rm.c:70
-#, fuzzy
 msgid ""
 "\n"
 "(use 'rm -rf' if you really want to remove it including all of its hi=
story)"
 msgstr ""
+"\n"
 "(benutzen Sie 'rm -rf' wenn Sie dieses Submodul wirklich mitsamt\n"
 "seiner Historie l=C3=B6schen m=C3=B6chten)"
=20
 #: builtin/rm.c:230
-#, fuzzy
 msgid ""
 "the following file has staged content different from both the\n"
 "file and the HEAD:"
 msgid_plural ""
 "the following files have staged content different from both the\n"
 "file and the HEAD:"
 msgstr[0] ""
-"'%s' hat bereitgestellten Inhalt unterschiedlich zu der Datei und\n"
-"HEAD (benutzen Sie -f um die Entfernung zu erzwingen)"
+"die folgende Datei hat zum Commit vorgemerkte =C3=84nderungen untersc=
hiedlich\n"
+"zu der Datei und HEAD:"
 msgstr[1] ""
-"'%s' hat bereitgestellten Inhalt unterschiedlich zu der Datei und\n"
-"HEAD (benutzen Sie -f um die Entfernung zu erzwingen)"
+"die folgenden Dateien haben zum Commit vorgemerkte =C3=84nderungen un=
terschiedlich\n"
+"zu der Datei und HEAD:"
=20
 #: builtin/rm.c:235
 msgid ""
 "\n"
 "(use -f to force removal)"
 msgstr ""
+"\n"
+"(benutzen Sie -f um die L=C3=B6schung zu erzwingen)"
=20
 #: builtin/rm.c:239
-#, fuzzy
 msgid "the following file has changes staged in the index:"
 msgid_plural "the following files have changes staged in the index:"
-msgstr[0] "checkt alle Dateien in der Staging-Area aus"
-msgstr[1] "checkt alle Dateien in der Staging-Area aus"
+msgstr[0] "die folgende Datei hat zum Commit vorgemerkte =C3=84nderung=
en:"
+msgstr[1] "die folgenden Dateien haben zum Commit vorgemerkte =C3=84nd=
erungen:"
=20
 #: builtin/rm.c:243 builtin/rm.c:254
-#, fuzzy
 msgid ""
 "\n"
 "(use --cached to keep the file, or -f to force removal)"
-msgstr ""
-"'%s' hat lokale Modifikationen\n"
-"(benutzen Sie --cached um die Datei zu behalten, oder -f um die Entfe=
rnung "
-"zu erzwingen)"
+msgstr "\n(benutzen Sie --cached um die Datei zu behalten, oder -f um =
die Entfernung zu erzwingen)"
=20
 #: builtin/rm.c:251
-#, fuzzy
 msgid "the following file has local modifications:"
 msgid_plural "the following files have local modifications:"
-msgstr[0] "erzwingt Auschecken (verwirft lokale =C3=84nderungen)"
-msgstr[1] "erzwingt Auschecken (verwirft lokale =C3=84nderungen)"
+msgstr[0] "die folgende Datei hat lokale =C3=84nderungen:"
+msgstr[1] "die folgenden Dateien haben lokale =C3=84nderungen:"
=20
 #: builtin/rm.c:269
 msgid "do not list removed files"
 msgstr "listet keine gel=C3=B6schten Dateien auf"
=20
@@ -8991,11 +8992,11 @@ msgstr "zeigt nur Commits, die sich nicht im er=
sten Branch befinden"
 msgid "show merges reachable from only one tip"
 msgstr "zeigt Merges, die nur von einem Branch aus erreichbar sind"
=20
 #: builtin/show-branch.c:676
 msgid "topologically sort, maintaining date order where possible"
-msgstr ""
+msgstr "topologische Sortierung, Beibehaltung Datumsordnung wo m=C3=B6=
glich"
=20
 #: builtin/show-branch.c:679
 msgid "<n>[,<base>]"
 msgstr "<n>[,<Basis>]"
=20
@@ -9027,11 +9028,11 @@ msgstr "zeigt nur Branches (kann mit \"tags\" k=
ombiniert werden)"
 msgid "stricter reference checking, requires exact ref path"
 msgstr "strengere Referenzpr=C3=BCfung, erfordert exakten Referenzpfad=
"
=20
 #: builtin/show-ref.c:173 builtin/show-ref.c:176
 msgid "show the HEAD reference, even if it would be filtered out"
-msgstr ""
+msgstr "zeigt die HEAD-Referenz, selbst wenn diese ausgefiltert werden=
 w=C3=BCrde"
=20
 #: builtin/show-ref.c:178
 msgid "dereference tags into object IDs"
 msgstr "dereferenziert Tags in Objekt-Identifikationen"
=20
@@ -9481,11 +9482,11 @@ msgstr ""
 "oder 'git help <Konzept>' um mehr =C3=BCber ein spezifisches Kommando=
 oder\n"
 "Konzept zu erfahren."
=20
 #: parse-options.h:144
 msgid "expiry date"
-msgstr ""
+msgstr "Verfallsdatum"
=20
 #: parse-options.h:159
 msgid "no-op (backward compatibility)"
 msgstr "Kein Effekt (R=C3=BCckw=C3=A4rtskompatibilit=C3=A4t)"
=20
@@ -9557,11 +9558,10 @@ msgid "Move or rename a file, a directory, or a=
 symlink"
 msgstr ""
 "Verschiebt oder benennt eine Datei, ein Verzeichnis, oder einen symbo=
lischen "
 "Verweis um"
=20
 #: common-cmds.h:21
-#, fuzzy
 msgid "Fetch from and integrate with another repository or a local bra=
nch"
 msgstr ""
 "Fordert Objekte von einem externen Repository an und f=C3=BChrt sie m=
it einem "
 "anderen Repository oder einem lokalen Branch zusammen"
=20
@@ -9606,17 +9606,17 @@ msgid ""
 msgstr ""
 "Sie scheinen seit dem letzten gescheiterten 'am' HEAD ge=C3=A4ndert z=
u haben.\n"
 "Keine Zur=C3=BCcksetzung zu ORIG_HEAD."
=20
 #: git-am.sh:105
-#, fuzzy, sh-format
+#, sh-format
 msgid ""
 "When you have resolved this problem, run \"$cmdline --continue\".\n"
 "If you prefer to skip this patch, run \"$cmdline --skip\" instead.\n"
 "To restore the original branch and stop patching, run \"$cmdline --ab=
ort\"."
 msgstr ""
-"Wenn Sie das Problem gel=C3=B6st haben, f=C3=BChren Sie \"$cmdline --=
resolved\" aus.\n"
+"Wenn Sie das Problem gel=C3=B6st haben, f=C3=BChren Sie \"$cmdline --=
continue\" aus.\n"
 "Falls Sie diesen Patch auslassen m=C3=B6chten, f=C3=BChren Sie stattd=
essen\n"
 "\"$cmdline --skip\" aus.\n"
 "Um den urspr=C3=BCnglichen Branch wiederherzustellen und die Anwendun=
g der\n"
 "Patches abzubrechen, f=C3=BChren Sie \"$cmdline --abort\" aus."
=20
@@ -9687,10 +9687,12 @@ msgstr "Bitte werden Sie sich klar. --skip oder=
 --abort?"
 #, sh-format
 msgid ""
 "Stray $dotest directory found.\n"
 "Use \"git am --abort\" to remove it."
 msgstr ""
+"Stray $dotest Verzeichnis gefunden.\n"
+"Benutzen Sie \"git am --abort\" um es zu entfernen."
=20
 #: git-am.sh:528
 msgid "Resolve operation not in progress, we are not resuming."
 msgstr "Es ist keine Aufl=C3=B6sung im Gange, es wird nicht fortgesetz=
t."
=20
@@ -9996,25 +9998,27 @@ msgstr ""
 "rebase --skip\" aus.\n"
 "Um den urspr=C3=BCnglichen Branch wiederherzustellen und den Rebase a=
bzubrechen,\n"
 "f=C3=BChren Sie \"git rebase --abort\" aus."
=20
 #: git-rebase.sh:156
-#, fuzzy
 msgid "Applied autostash."
-msgstr "Patch %s sauber angewendet"
+msgstr "\"autostash\" angewendet."
=20
 #: git-rebase.sh:159
-#, fuzzy, sh-format
+#, sh-format
 msgid "Cannot store $stash_sha1"
-msgstr "Kann \"stash\" nicht initialisieren"
+msgstr "Kann $stash_sha1 nicht speichern."
=20
 #: git-rebase.sh:160
 msgid ""
 "Applying autostash resulted in conflicts.\n"
 "Your changes are safe in the stash.\n"
 "You can run \"git stash pop\" or \"git stash drop\" it at any time.\n=
"
 msgstr ""
+"Anwendung von \"autostash\" resultierte in Konflikten.\n"
+"Ihre =C3=84nderungen sind sicher im Stash.\n"
+"Sie k=C3=B6nnen jederzeit \"git stash pop\" oder \"git stash drop\" a=
usf=C3=BChren.\n"
=20
 #: git-rebase.sh:190
 msgid "The pre-rebase hook refused to rebase."
 msgstr "Der \"pre-rebase hook\" hat den Rebase zur=C3=BCckgewiesen."
=20
@@ -10098,18 +10102,17 @@ msgstr "$onto_name zeigt auf keinen g=C3=BClt=
igen Commit"
 #, sh-format
 msgid "fatal: no such branch: $branch_name"
 msgstr "fatal: Branch $branch_name nicht gefunden"
=20
 #: git-rebase.sh:519
-#, fuzzy
 msgid "Cannot autostash"
-msgstr "Kann \"stash\" nicht initialisieren"
+msgstr "Kann \"autostash\" nicht ausf=C3=BChren."
=20
 #: git-rebase.sh:524
 #, sh-format
 msgid "Created autostash: $stash_abbrev"
-msgstr ""
+msgstr "\"autostash\" erzeugt: $stash_abbrev"
=20
 #: git-rebase.sh:528
 msgid "Please commit or stash them."
 msgstr "Bitte committen Sie die =C3=84nderungen oder benutzen Sie \"st=
ash\"."
=20
@@ -10170,11 +10173,11 @@ msgid "Cannot record working tree state"
 msgstr "Kann Zustand des Arbeitsverzeichnisses nicht aufzeichnen"
=20
 #: git-stash.sh:190
 #, sh-format
 msgid "Cannot update $ref_stash with $w_commit"
-msgstr ""
+msgstr "Kann $ref_stash nicht mit $w_commit aktualisieren."
=20
 #. TRANSLATORS: $option is an invalid option, like
 #. `--blah-blah'. The 7 spaces at the beginning of the
 #. second line correspond to "error: ". So you should line
 #. up the second line with however many characters the
@@ -10201,15 +10204,17 @@ msgstr "Keine lokalen =C3=84nderungen zum Spe=
ichern"
 #: git-stash.sh:268
 msgid ""
 "The following untracked files would NOT be saved but need to be remov=
ed by "
 "stash save:"
 msgstr ""
+"Die folgenden unbeobachteten Dateien w=C3=BCrden NICHT gespeichert we=
rden,\n"
+"m=C3=BCssen aber durch \"stash save\" entfernt werden:"
=20
 #: git-stash.sh:270
 msgid ""
 "Aborting. Consider using either the --force or --include-untracked op=
tion."
-msgstr ""
+msgstr "Abgebrochen. Benutzen Sie entweder die Option --force oder --i=
nclude-untracked."
=20
 #: git-stash.sh:274
 msgid "Cannot initialize stash"
 msgstr "Kann \"stash\" nicht initialisieren"
=20
@@ -10307,11 +10312,11 @@ msgstr "Klonen von '$url' in Submodul-Pfad '$=
sm_path' fehlgeschlagen"
 msgid "Gitdir '$a' is part of the submodule path '$b' or vice versa"
 msgstr "Git-Verzeichnis '$a' ist Teil des Submodul-Pfades '$b', oder u=
mgekehrt"
=20
 #: git-submodule.sh:403
 msgid "Relative path can only be used from the toplevel of the working=
 tree"
-msgstr ""
+msgstr "Relative Pfade k=C3=B6nnen nur von der obersten Ebene des Arbe=
itsverzeichnisses benutzt werden."
=20
 #: git-submodule.sh:413
 #, sh-format
 msgid "repo URL: '$repo' must be absolute or begin with ./|../"
 msgstr "repo URL: '$repo' muss absolut sein oder mit ./|../ beginnen"
@@ -10393,166 +10398,155 @@ msgstr "Hinzuf=C3=BCgen von Submodul '$sm_p=
ath' fehlgeschlagen"
 #, sh-format
 msgid "Failed to register submodule '$sm_path'"
 msgstr "Fehler beim Eintragen von Submodul '$sm_path' in die Konfigura=
tion."
=20
 #: git-submodule.sh:539
-#, fuzzy, sh-format
+#, sh-format
 msgid "Entering '$prefix$displaypath'"
-msgstr "Betrete '$prefix$sm_path'"
+msgstr "Betrete '$prefix$displaypath'"
=20
 #: git-submodule.sh:554
-#, fuzzy, sh-format
+#, sh-format
 msgid "Stopping at '$prefix$displaypath'; script returned non-zero sta=
tus."
-msgstr "Stoppe bei '$sm_path'; Skript gab nicht-Null Status zur=C3=BCc=
k."
+msgstr "Stoppe bei '$prefix$displaypath'; Skript gab nicht-Null Status=
 zur=C3=BCck."
=20
 #: git-submodule.sh:600
-#, fuzzy, sh-format
+#, sh-format
 msgid "No url found for submodule path '$displaypath' in .gitmodules"
-msgstr "Keine URL f=C3=BCr Submodul-Pfad '$sm_path' in .gitmodules gef=
unden"
+msgstr "Keine URL f=C3=BCr Submodul-Pfad '$displaypath' in .gitmodules=
 gefunden"
=20
 #: git-submodule.sh:609
-#, fuzzy, sh-format
+#, sh-format
 msgid "Failed to register url for submodule path '$displaypath'"
-msgstr ""
-"Fehler beim Eintragen der URL f=C3=BCr Submodul-Pfad '$sm_path' in di=
e "
-"Konfiguration."
+msgstr "Fehler beim Eintragen der URL f=C3=BCr Submodul-Pfad '$display=
path' in die Konfiguration."
=20
 #: git-submodule.sh:611
-#, fuzzy, sh-format
+#, sh-format
 msgid "Submodule '$name' ($url) registered for path '$displaypath'"
-msgstr ""
-"Submodul '$name' ($url) f=C3=BCr Pfad '$sm_path' in die Konfiguration=
 eingetragen"
+msgstr "Submodul '$name' ($url) f=C3=BCr Pfad '$displaypath' in die Ko=
nfiguration eingetragen."
=20
 #: git-submodule.sh:619
-#, fuzzy, sh-format
+#, sh-format
 msgid "Failed to register update mode for submodule path '$displaypath=
'"
-msgstr ""
-"Fehler bei =C3=84nderung des Aktualisierungsmodus f=C3=BCr Submodul-P=
fad '$sm_path' in "
-"der Konfiguration."
+msgstr "Fehler bei =C3=84nderung des Aktualisierungsmodus f=C3=BCr Sub=
modul-Pfad '$displaypath' in der Konfiguration."
=20
 #: git-submodule.sh:656
 #, sh-format
 msgid "Use '.' if you really want to deinitialize all submodules"
 msgstr ""
 "Verwenden Sie '.' wenn Sie wirklich alle Submodule\n"
 "deinitialisieren m=C3=B6chten."
=20
 #: git-submodule.sh:673
-#, fuzzy, sh-format
+#, sh-format
 msgid "Submodule work tree '$displaypath' contains a .git directory"
-msgstr ""
-"Arbeitsverzeichnis des Submoduls in '$sm_path' enth=C3=A4lt ein .git-=
Verzeichnis"
+msgstr "Arbeitsverzeichnis des Submoduls in '$displaypath' enth=C3=A4l=
t ein .git-Verzeichnis"
=20
 #: git-submodule.sh:674
 #, sh-format
 msgid ""
 "(use 'rm -rf' if you really want to remove it including all of its hi=
story)"
 msgstr ""
 "(benutzen Sie 'rm -rf' wenn Sie dieses Submodul wirklich mitsamt\n"
 "seiner Historie l=C3=B6schen m=C3=B6chten)"
=20
 #: git-submodule.sh:680
-#, fuzzy, sh-format
+#, sh-format
 msgid ""
 "Submodule work tree '$displaypath' contains local modifications; use =
'-f' to "
 "discard them"
-msgstr ""
-"Arbeitsverzeichnis von Submodul in '$sm_path' enth=C3=A4lt lokale =C3=
=84nderungen; "
-"verwenden Sie '-f' um diese zu verwerfen"
+msgstr "Arbeitsverzeichnis von Submodul in '$displaypath' enth=C3=A4lt=
 lokale =C3=84nderungen; verwenden Sie '-f' um diese zu verwerfen"
=20
 #: git-submodule.sh:683
-#, fuzzy, sh-format
+#, sh-format
 msgid "Cleared directory '$displaypath'"
-msgstr "Verzeichnis '$sm_path' bereinigt."
+msgstr "Verzeichnis '$displaypath' bereinigt."
=20
 #: git-submodule.sh:684
-#, fuzzy, sh-format
+#, sh-format
 msgid "Could not remove submodule work tree '$displaypath'"
-msgstr "Konnte Arbeitsverzeichnis des Submoduls in '$sm_path' nicht l=C3=
=B6schen."
+msgstr "Konnte Arbeitsverzeichnis des Submoduls in '$displaypath' nich=
t l=C3=B6schen."
=20
 #: git-submodule.sh:687
-#, fuzzy, sh-format
+#, sh-format
 msgid "Could not create empty submodule directory '$displaypath'"
-msgstr "Konnte kein leeres Verzeichnis f=C3=BCr Submodul in '$sm_path'=
 erstellen."
+msgstr "Konnte kein leeres Verzeichnis f=C3=BCr Submodul in '$displayp=
ath' erstellen."
=20
 #: git-submodule.sh:696
-#, fuzzy, sh-format
+#, sh-format
 msgid "Submodule '$name' ($url) unregistered for path '$displaypath'"
-msgstr ""
-"Submodul '$name' ($url) f=C3=BCr Pfad '$sm_path' wurde aus der Konfig=
uration "
-"entfernt."
+msgstr "Submodul '$name' ($url) f=C3=BCr Pfad '$displaypath' wurde aus=
 der Konfiguration entfernt."
=20
 #: git-submodule.sh:811
-#, fuzzy, sh-format
+#, sh-format
 msgid ""
 "Submodule path '$displaypath' not initialized\n"
 "Maybe you want to use 'update --init'?"
 msgstr ""
-"Submodul-Pfad '$prefix$sm_path' ist nicht initialisiert.\n"
+"Submodul-Pfad '$displaypath' ist nicht initialisiert.\n"
 "Vielleicht m=C3=B6chten Sie 'update --init' benutzen?"
=20
 #: git-submodule.sh:824
-#, fuzzy, sh-format
+#, sh-format
 msgid "Unable to find current revision in submodule path '$displaypath=
'"
-msgstr ""
-"Konnte aktuellen Commit in Submodul-Pfad '$prefix$sm_path' nicht find=
en."
+msgstr "Konnte aktuellen Commit in Submodul-Pfad '$displaypath' nicht =
finden."
=20
 #: git-submodule.sh:833
 #, sh-format
 msgid "Unable to fetch in submodule path '$sm_path'"
 msgstr "Konnte \"fetch\" in Submodul-Pfad '$sm_path' nicht ausf=C3=BCh=
ren"
=20
 #: git-submodule.sh:857
-#, fuzzy, sh-format
+#, sh-format
 msgid "Unable to fetch in submodule path '$displaypath'"
-msgstr "Konnte \"fetch\" in Submodul-Pfad '$sm_path' nicht ausf=C3=BCh=
ren"
+msgstr "Konnte \"fetch\" in Submodul-Pfad '$displaypath' nicht ausf=C3=
=BChren"
=20
 #: git-submodule.sh:871
-#, fuzzy, sh-format
+#, sh-format
 msgid "Unable to rebase '$sha1' in submodule path '$displaypath'"
-msgstr "Rebase auf '$sha1' in Submodul-Pfad '$prefix$sm_path' nicht m=C3=
=B6glich"
+msgstr "Rebase auf '$sha1' in Submodul-Pfad '$displaypath' nicht m=C3=B6=
glich"
=20
 #: git-submodule.sh:872
-#, fuzzy, sh-format
+#, sh-format
 msgid "Submodule path '$displaypath': rebased into '$sha1'"
-msgstr "Submodul-Pfad '$prefix$sm_path': Rebase auf '$sha1'"
+msgstr "Submodul-Pfad '$displaypath': Rebase auf '$sha1'"
=20
 #: git-submodule.sh:877
-#, fuzzy, sh-format
+#, sh-format
 msgid "Unable to merge '$sha1' in submodule path '$displaypath'"
-msgstr "Merge von '$sha1' in Submodul-Pfad '$prefix$sm_path' fehlgesch=
lagen"
+msgstr "Merge von '$sha1' in Submodul-Pfad '$displaypath' fehlgeschlag=
en"
=20
 #: git-submodule.sh:878
-#, fuzzy, sh-format
+#, sh-format
 msgid "Submodule path '$displaypath': merged in '$sha1'"
-msgstr "Submodul-Pfad '$prefix$sm_path': zusammengef=C3=BChrt in '$sha=
1'"
+msgstr "Submodul-Pfad '$displaypath': zusammengef=C3=BChrt in '$sha1'"
=20
 #: git-submodule.sh:883
-#, fuzzy, sh-format
+#, sh-format
 msgid ""
 "Execution of '$command $sha1' failed in submodule  path '$prefix$sm_p=
ath'"
-msgstr "Merge von '$sha1' in Submodul-Pfad '$prefix$sm_path' fehlgesch=
lagen"
+msgstr "Ausf=C3=BChrung von '$command $sha1' in Submodul-Pfad '$prefix=
$sm_path' fehlgeschlagen"
=20
 #: git-submodule.sh:884
-#, fuzzy, sh-format
+#, sh-format
 msgid "Submodule path '$prefix$sm_path': '$command $sha1'"
-msgstr "Submodul-Pfad '$prefix$sm_path': zusammengef=C3=BChrt in '$sha=
1'"
+msgstr "Submodul-Pfad '$prefix$sm_path': '$command $sha1'"
=20
 #: git-submodule.sh:889
-#, fuzzy, sh-format
+#, sh-format
 msgid "Unable to checkout '$sha1' in submodule path '$displaypath'"
-msgstr "Konnte '$sha1' in Submodul-Pfad '$prefix$sm_path' nicht ausche=
cken."
+msgstr "Konnte '$sha1' in Submodul-Pfad '$displaypath' nicht auschecke=
n."
=20
 #: git-submodule.sh:890
-#, fuzzy, sh-format
+#, sh-format
 msgid "Submodule path '$displaypath': checked out '$sha1'"
-msgstr "Submodul-Pfad: '$prefix$sm_path': '$sha1' ausgecheckt"
+msgstr "Submodul-Pfad: '$displaypath': '$sha1' ausgecheckt"
=20
 #: git-submodule.sh:917
-#, fuzzy, sh-format
+#, sh-format
 msgid "Failed to recurse into submodule path '$displaypath'"
-msgstr "Fehler bei Rekursion in Submodul-Pfad '$sm_path'"
+msgstr "Fehler bei Rekursion in Submodul-Pfad '$displaypath'"
=20
 #: git-submodule.sh:1025
 msgid "The --cached option cannot be used with the --files option"
 msgstr ""
 "Die Optionen --cached und --files k=C3=B6nnen nicht gemeinsam verwend=
et werden."
@@ -10562,23 +10556,23 @@ msgstr ""
 #, sh-format
 msgid "unexpected mode $mod_dst"
 msgstr "unerwarteter Modus $mod_dst"
=20
 #: git-submodule.sh:1086
-#, fuzzy, sh-format
+#, sh-format
 msgid "  Warn: $display_name doesn't contain commit $sha1_src"
-msgstr "  Warnung: $name beinhaltet nicht Commit $sha1_src"
+msgstr "  Warnung: $display_name beinhaltet nicht Commit $sha1_src"
=20
 #: git-submodule.sh:1089
-#, fuzzy, sh-format
+#, sh-format
 msgid "  Warn: $display_name doesn't contain commit $sha1_dst"
-msgstr "  Warnung: $name beinhaltet nicht Commit $sha1_dst"
+msgstr "  Warnung: $display_name beinhaltet nicht Commit $sha1_dst"
=20
 #: git-submodule.sh:1092
-#, fuzzy, sh-format
+#, sh-format
 msgid "  Warn: $display_name doesn't contain commits $sha1_src and $sh=
a1_dst"
-msgstr "  Warnung: $name beinhaltet nicht die Commits $sha1_src und $s=
ha1_dst"
+msgstr "  Warnung: $display_name beinhaltet nicht die Commits $sha1_sr=
c und $sha1_dst"
=20
 #: git-submodule.sh:1117
 msgid "blob"
 msgstr "Blob"
=20
@@ -10594,13 +10588,13 @@ msgstr "=C3=84nderungen in Submodul zum Commi=
tten:"
 #, sh-format
 msgid "Failed to recurse into submodule path '$sm_path'"
 msgstr "Fehler bei Rekursion in Submodul-Pfad '$sm_path'"
=20
 #: git-submodule.sh:1306
-#, fuzzy, sh-format
+#, sh-format
 msgid "Synchronizing submodule url for '$displaypath'"
-msgstr "Synchronisiere Submodul-URL f=C3=BCr '$prefix$sm_path'"
+msgstr "Synchronisiere Submodul-URL f=C3=BCr '$displaypath'"
=20
 #~ msgid "  (fix conflicts and then run \"git am --resolved\")"
 #~ msgstr ""
 #~ "  (beheben Sie die Konflikte und f=C3=BChren Sie dann \"git am --r=
esolved\" "
 #~ "aus)"
--=20
1.8.2.1873.gfc589a4

From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=2008/10=5D=20l10n=3A=20de=2Epo=3A=20collection=20of=20improvements?=
Date: Tue,  8 May 2012 19:33:43 +0200
Message-ID: <1336498425-17890-9-git-send-email-ralf.thielow@googlemail.com>
References: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worldhello.net@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue May 08 19:35:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRoJU-0002G2-Rc
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432Ab2EHRes convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 13:34:48 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41121 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab2EHReh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:34:37 -0400
Received: by mail-wi0-f178.google.com with SMTP id hn19so437464wib.1
        for <git@vger.kernel.org>; Tue, 08 May 2012 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tcC09Z5XIX3RK9h92P2cYvtpyJZPWFAt+0rfA5vQqwc=;
        b=OYto3LSwrdacs89aKnRA9UD9LyY2/AolqfwhU/348Q4Na9vXrnLiKouZNQVOGZZNqA
         YwWzM5Peg5Ri1FpnnZWceg9T+aOoCRNrnTyI4kGr8fCaWcKB0dcto0+f6MZgSpCvIwCb
         txrP2bjvZMpySr4HmsxbXmGzA1LDuosBsOp/lxbbwQ9hg1PVFaDYMAyOrQy2iWgpr24s
         7iY/SM1U5ic6/IaACcRt27yHRt5FuGT/q+GfTbx0xMMtP/G/lF2FX2a/8N7VtN1NEM42
         egPc3pEj1dkk0iApbKyHoQOv9IGm4dIoPRCh88QQQnDS9lhi4MiNm3CiMi2mN+b1YkWl
         nz4A==
Received: by 10.180.85.69 with SMTP id f5mr46761519wiz.18.1336498476832;
        Tue, 08 May 2012 10:34:36 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id ff2sm47784452wib.9.2012.05.08.10.34.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 10:34:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.129.g1ec31a3
In-Reply-To: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197410>

A list of improvements for German translation
which contains a couple of spellings and grammar.

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po |  254 +++++++++++++++++++++++++++++++-----------------------=
--------
 1 Datei ge=C3=A4ndert, 129 Zeilen hinzugef=C3=BCgt(+), 125 Zeilen entf=
ernt(-)

diff --git a/po/de.po b/po/de.po
index 8db663d..961e88a 100644
--- a/po/de.po
+++ b/po/de.po
@@ -54,7 +54,7 @@ msgstr "Speicher verbraucht"
=20
 #: connected.c:39
 msgid "Could not run 'git rev-list'"
-msgstr "'git rev-list' konnte nicht ausgef=C3=BChrt werden"
+msgstr "Konnte 'git rev-list' nicht ausf=C3=BChren"
=20
 #: connected.c:48
 #, c-format
@@ -122,7 +122,7 @@ msgstr ""
=20
 #: gpg-interface.c:59
 msgid "could not run gpg."
-msgstr "gpg konnte nicht ausgef=C3=BChrt werden"
+msgstr "konnte gpg nicht ausf=C3=BChren"
=20
 #: gpg-interface.c:71
 msgid "gpg did not accept the data"
@@ -259,7 +259,7 @@ msgstr "Du hast keine g=C3=BCltige Zweigspitze (HEA=
D)"
 #, c-format
 msgid "Commit %s is a merge but no -m option was given."
 msgstr ""
-"Version %s ist eine Zusammenf=C3=BChrung, aber es wurde keine Option =
-m angegeben."
+"Version %s ist eine Zusammenf=C3=BChrung, aber die Option -m wurde ni=
cht angegeben."
=20
 #: sequencer.c:324
 #, c-format
@@ -331,12 +331,12 @@ msgstr "Keine Versionen geparst."
 #: sequencer.c:591
 #, c-format
 msgid "Could not open %s"
-msgstr "%s konnte nicht ge=C3=B6ffnet werden."
+msgstr "Konnte %s nicht =C3=B6ffnen"
=20
 #: sequencer.c:595
 #, c-format
 msgid "Could not read %s."
-msgstr "%s konnte nicht gelesen werden."
+msgstr "Konnte %s nicht lesen."
=20
 #: sequencer.c:602
 #, c-format
@@ -634,7 +634,7 @@ msgstr " (Erstelle/Kopiere Dateien und benutze \"gi=
t add\" zum Beobachten)"
=20
 #: wt-status.c:773
 msgid " (use -u to show untracked files)"
-msgstr " (benutze -u um unbeobachtete Dateien anzuzeigen)"
+msgstr " (benutze die Option -u um unbeobachtete Dateien anzuzeigen)"
=20
 #: wt-status.c:776
 msgid " (working directory clean)"
@@ -667,7 +667,7 @@ msgstr "unerwarteter Differenz-Status %c"
=20
 #: builtin/add.c:67 builtin/commit.c:298
 msgid "updating files failed"
-msgstr "Aktualisierung von Dateien fehlgeschlagen"
+msgstr "Aktualisierung der Dateien fehlgeschlagen"
=20
 #: builtin/add.c:77
 #, c-format
@@ -710,7 +710,7 @@ msgstr "Konnte Patch nicht schreiben"
 #: builtin/add.c:295
 #, c-format
 msgid "Could not stat '%s'"
-msgstr "Verzeichnis '%s' konnte nicht gelesen werden"
+msgstr "Konnte Verzeichnis '%s' nicht lesen"
=20
 #: builtin/add.c:297
 msgid "Empty patch. Aborted."
@@ -809,7 +809,7 @@ msgid ""
 "deleting branch '%s' that has been merged to\n"
 "         '%s', but not yet merged to HEAD."
 msgstr ""
-"entferne Zweig '%s' der zusammengef=C3=BChrt wurde mit\n"
+"entferne Zweig '%s', der zusammengef=C3=BChrt wurde mit\n"
 "         '%s', aber noch nicht mit der Zweigspitze (HEAD) zusammengef=
=C3=BChrt "
 "wurde."
=20
@@ -819,7 +819,7 @@ msgid ""
 "not deleting branch '%s' that is not yet merged to\n"
 "         '%s', even though it is merged to HEAD."
 msgstr ""
-"entferne nicht Zweig '%s' der noch nicht zusammengef=C3=BChrt wurde m=
it\n"
+"entferne Zweig '%s' nicht, der noch nicht zusammengef=C3=BChrt wurde =
mit\n"
 "         '%s', obwohl er mit der Zweigspitze (HEAD) zusammengef=C3=BC=
hrt wurde."
=20
 #. TRANSLATORS: This is "remote " in "remote branch '%s' not found"
@@ -838,7 +838,7 @@ msgstr "Konnte Versionsobjekt f=C3=BCr Zweigspitze =
(HEAD) nicht nachschlagen."
 #: builtin/branch.c:182
 #, c-format
 msgid "Cannot delete the branch '%s' which you are currently on."
-msgstr "Kann Zweig '%s' nicht entfernen auf dem du dich gerade befinde=
st."
+msgstr "Kann Zweig '%s' nicht entfernen, da du dich gerade auf diesem =
befindest."
=20
 #: builtin/branch.c:192
 #, c-format
@@ -899,7 +899,7 @@ msgstr "(kein Zweig)"
=20
 #: builtin/branch.c:566
 msgid "some refs could not be read"
-msgstr "einige Referenzen konnten nicht gelesen werden"
+msgstr "Konnte einige Referenzen nicht lesen"
=20
 #: builtin/branch.c:579
 msgid "cannot rename the current branch while not on any."
@@ -943,7 +943,7 @@ msgstr "Konnte Beschreibungsvorlage f=C3=BCr Zweig =
nicht schreiben: %s\n"
=20
 #: builtin/branch.c:746
 msgid "Failed to resolve HEAD as a valid ref."
-msgstr "Zweigspitze (HEAD) konnte nicht als g=C3=BCltige Referenz aufg=
el=C3=B6st werden."
+msgstr "Konnte Zweigspitze (HEAD) nicht als g=C3=BCltige Referenz aufl=
=C3=B6sen."
=20
 #: builtin/branch.c:751 builtin/clone.c:558
 msgid "HEAD not found below refs/heads!"
@@ -966,7 +966,7 @@ msgstr "Um ein Paket zu erstellen wird ein Projekta=
rchiv ben=C3=B6tigt."
=20
 #: builtin/bundle.c:60
 msgid "Need a repository to unbundle."
-msgstr "Zum Zerlegen wird ein Projektarchiv ben=C3=B6tigt."
+msgstr "Zum Entpacken wird ein Projektarchiv ben=C3=B6tigt."
=20
 #: builtin/checkout.c:113 builtin/checkout.c:146
 #, c-format
@@ -1113,7 +1113,7 @@ msgstr "Vorherige Position der Zweigspitze (HEAD)=
 war"
=20
 #: builtin/checkout.c:722
 msgid "You are on a branch yet to be born"
-msgstr "Du bist auf einem Zweig, der noch nicht geboren wurde."
+msgstr "du bist auf einem Zweig, der noch geboren wird"
=20
 #. case (1)
 #: builtin/checkout.c:853
@@ -1173,16 +1173,16 @@ msgid ""
 "git checkout: updating paths is incompatible with switching branches.=
\n"
 "Did you intend to checkout '%s' which can not be resolved as commit?"
 msgstr ""
-"git checkout: Aktualisierung der Pfade ist inkompatibel mit dem Wechs=
el von "
-"Zweigen.\n"
+"git checkout: Die Aktualisierung von Pfaden ist inkompatibel mit dem =
Wechsel "
+"von Zweigen.\n"
 "Hast du beabsichtigt '%s' auszuchecken, welcher nicht als Version auf=
gel=C3=B6st "
 "werden kann?"
=20
 #: builtin/checkout.c:1061
 msgid "git checkout: updating paths is incompatible with switching bra=
nches."
 msgstr ""
-"git checkout: Aktualisierung von Pfaden ist inkompatibel mit dem Wech=
sel von "
-"Zweigen."
+"git checkout: Die Aktualisierung von Pfaden ist inkompatibel mit dem =
Wechsel "
+"von Zweigen."
=20
 #: builtin/checkout.c:1066
 msgid "git checkout: --detach does not take a path argument"
@@ -1194,7 +1194,7 @@ msgid ""
 "checking out of the index."
 msgstr ""
 "git checkout: --ours/--theirs, --force and --merge sind inkompatibel =
wenn\n"
-"du au=C3=9Ferhalb der Bereitstellung auscheckst."
+"du aus der Bereitstellung auscheckst."
=20
 #: builtin/checkout.c:1088
 msgid "Cannot switch branch to a non-commit."
@@ -1213,7 +1213,7 @@ msgid ""
 "clean.requireForce set to true and neither -n nor -f given; refusing =
to clean"
 msgstr ""
 "clean.requireForce auf \"true\" gesetzt und weder -n noch -f gegeben;=
 "
-"Ablehnung der Reinigung"
+"S=C3=A4uberung verweigert"
=20
 #: builtin/clean.c:85
 msgid ""
@@ -1221,12 +1221,12 @@ msgid ""
 "clean"
 msgstr ""
 "clean.requireForce standardm=C3=A4=C3=9Fig auf \"true\" gesetzt und w=
eder -n noch -f "
-"gegeben; Ablehnung der Reinigung"
+"gegeben; S=C3=A4uberung verweigert"
=20
 #: builtin/clean.c:155 builtin/clean.c:176
 #, c-format
 msgid "Would remove %s\n"
-msgstr "W=C3=BCrde entfernen %s\n"
+msgstr "W=C3=BCrde %s entfernen\n"
=20
 #: builtin/clean.c:159 builtin/clean.c:179
 #, c-format
@@ -1266,7 +1266,7 @@ msgstr "Fehler beim Erstellen von Verzeichnis '%s=
'"
 #: builtin/clone.c:308 builtin/diff.c:75
 #, c-format
 msgid "failed to stat '%s'"
-msgstr "'%s' konnte nicht gelesen werden"
+msgstr "Konnte '%s' nicht lesen"
=20
 #: builtin/clone.c:310
 #, c-format
@@ -1276,22 +1276,22 @@ msgstr "%s existiert und ist kein Verzeichnis"
 #: builtin/clone.c:324
 #, c-format
 msgid "failed to stat %s\n"
-msgstr "%s konnte nicht gelesen werden\n"
+msgstr "Konnte %s nicht lesen\n"
=20
 #: builtin/clone.c:341
 #, c-format
 msgid "failed to unlink '%s'"
-msgstr "Verkn=C3=BCpfung von '%s' konnte nicht aufgehoben werden."
+msgstr "Konnte '%s' nicht entfernen"
=20
 #: builtin/clone.c:346
 #, c-format
 msgid "failed to create link '%s'"
-msgstr "Verkn=C3=BCpfung '%s' konnte nicht erstellt werden."
+msgstr "Konnte Verkn=C3=BCpfung '%s' nicht erstellen"
=20
 #: builtin/clone.c:350
 #, c-format
 msgid "failed to copy file to '%s'"
-msgstr "Datei konnte nicht nach '%s' kopiert werden."
+msgstr "Konnte Datei nicht nach '%s' kopieren"
=20
 #: builtin/clone.c:373
 #, c-format
@@ -1301,7 +1301,7 @@ msgstr "Fertig.\n"
 #: builtin/clone.c:440
 #, c-format
 msgid "Could not find remote branch %s to clone."
-msgstr "Externer Zweig %s konnte nicht zum Klonen gefunden werden."
+msgstr "Konnte zu klonenden externer Zweig %s nicht finden."
=20
 #: builtin/clone.c:549
 msgid "remote HEAD refers to nonexistent ref, unable to checkout.\n"
@@ -1315,7 +1315,7 @@ msgstr "Zu viele Argumente."
=20
 #: builtin/clone.c:643
 msgid "You must specify a repository to clone."
-msgstr "Du musst ein Projektarchiv zum Klonen spezifizieren."
+msgstr "Du musst ein Projektarchiv zum Klonen angeben."
=20
 #: builtin/clone.c:654
 #, c-format
@@ -1455,7 +1455,7 @@ msgstr "Konnte new_index Datei nicht schreiben"
 #: builtin/commit.c:457
 #, c-format
 msgid "cannot do a partial commit during a %s."
-msgstr "Kann keine partielle Eintragung w=C3=A4hrend eines %s durchf=C3=
=BChren."
+msgstr "Kann keine partielle Eintragung durchf=C3=BChren, w=C3=A4hrend=
 %s im Gange ist."
=20
 #: builtin/commit.c:466
 msgid "cannot read the index"
@@ -1577,7 +1577,7 @@ msgstr "Kann Bereitstellung nicht lesen"
=20
 #: builtin/commit.c:896
 msgid "Error building trees"
-msgstr "Fehler beim Erzeugen der B=C3=A4ume"
+msgstr "Fehler beim Erzeugen der Zweige"
=20
 #: builtin/commit.c:911 builtin/tag.c:357
 #, c-format
@@ -1605,7 +1605,7 @@ msgstr "Du hast nichts zum nachbessern."
 #: builtin/commit.c:1076
 #, c-format
 msgid "You are in the middle of a %s -- cannot amend."
-msgstr "Du bist in der Mitte eines %s -- kann nicht nachbessern."
+msgstr "%s ist im Gange -- kann nicht nachbessern."
=20
 #: builtin/commit.c:1078
 msgid "Options --squash and --fixup cannot be used together"
@@ -1637,12 +1637,12 @@ msgstr "--include/--only machen ohne Pfade kein=
en Sinn."
 #: builtin/commit.c:1119
 msgid "Clever... amending the last one with dirty index."
 msgstr ""
-"Klug... nachbessern der letzten Version mit einer unsauberen Bereitst=
ellung."
+"Klug... die letzte Version mit einer unsauberen Bereitstellung nachbe=
ssern."
=20
 #: builtin/commit.c:1121
 msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
 msgstr ""
-"Explizite Pfade ohne -i oder -o spezifiziert; unter der Annahme von -=
-only "
+"Explizite Pfade ohne -i oder -o angegeben; unter der Annahme von --on=
ly "
 "Pfaden..."
=20
 #: builtin/commit.c:1131 builtin/tag.c:556
@@ -1744,7 +1744,7 @@ msgstr "Markierung '%s' ist eigentlich '%s' hier"
 #: builtin/describe.c:267
 #, c-format
 msgid "Not a valid object name %s"
-msgstr "kein g=C3=BCltiger Objekt-Name %s"
+msgstr "%s ist kein g=C3=BCltiger Objekt-Name"
=20
 #: builtin/describe.c:270
 #, c-format
@@ -1759,7 +1759,7 @@ msgstr "kein Markierung entspricht exakt '%s'"
 #: builtin/describe.c:289
 #, c-format
 msgid "searching to describe %s\n"
-msgstr "suche um zu beschreiben %s\n"
+msgstr "suche zur Beschreibung von %s\n"
=20
 #: builtin/describe.c:329
 #, c-format
@@ -1787,7 +1787,7 @@ msgstr ""
 #: builtin/describe.c:378
 #, c-format
 msgid "traversed %lu commits\n"
-msgstr "verarbeitete %lu Versionen\n"
+msgstr "%lu Versionen durchlaufen\n"
=20
 #: builtin/describe.c:381
 #, c-format
@@ -1795,7 +1795,7 @@ msgid ""
 "more than %i tags found; listed %i most recent\n"
 "gave up search at %s\n"
 msgstr ""
-"mehr als %i Markierungen gefunden; F=C3=BChre die %i j=C3=BCngsten au=
f\n"
+"mehr als %i Markierungen gefunden; F=C3=BChre die ersten %i auf\n"
 "Suche bei %s aufgegeben\n"
=20
 #: builtin/describe.c:436
@@ -1827,22 +1827,22 @@ msgstr "Kein Git-Projektarchiv"
 #: builtin/diff.c:347
 #, c-format
 msgid "invalid object '%s' given."
-msgstr "Ung=C3=BCltiges Objekt '%s' gegeben."
+msgstr "Objekt '%s' ist ung=C3=BCltig."
=20
 #: builtin/diff.c:352
 #, c-format
 msgid "more than %d trees given: '%s'"
-msgstr "Mehr als %d B=C3=A4ume gegeben: '%s'"
+msgstr "Mehr als %d Zweige angegeben: '%s'"
=20
 #: builtin/diff.c:362
 #, c-format
 msgid "more than two blobs given: '%s'"
-msgstr "Mehr als zwei Blobs gegeben: '%s'"
+msgstr "Mehr als zwei Blobs angegeben: '%s'"
=20
 #: builtin/diff.c:370
 #, c-format
 msgid "unhandled object '%s' given."
-msgstr "unbehandeltes Objekt '%s' gegeben"
+msgstr "unbehandeltes Objekt '%s' angegeben"
=20
 #: builtin/fetch.c:200
 msgid "Couldn't find remote ref HEAD"
@@ -1921,7 +1921,7 @@ msgstr ""
 #: builtin/fetch.c:540
 #, c-format
 msgid "   (%s will become dangling)\n"
-msgstr "   (%s wird unreferenziert werden)\n"
+msgstr "   (%s wird unreferenziert)\n"
=20
 #: builtin/fetch.c:541
 #, c-format
@@ -1934,14 +1934,14 @@ msgstr "[gel=C3=B6scht]"
=20
 #: builtin/fetch.c:549
 msgid "(none)"
-msgstr "(keine)"
+msgstr "(nichts)"
=20
 #: builtin/fetch.c:666
 #, c-format
 msgid "Refusing to fetch into current branch %s of non-bare repository=
"
 msgstr ""
-"Ablehnung des Anforderns in aktuellen Zweig %s von einem nicht-leeren=
 "
-"Projektarchiv"
+"Das Anfordern in den aktuellen Zweig %s von einem nicht-blo=C3=9Fen\"=
"
+"Projektarchiv wurde verweigert."
=20
 #: builtin/fetch.c:700
 #, c-format
@@ -1961,29 +1961,29 @@ msgstr "Option \"%s\" wird ignoriert f=C3=BCr %=
s\n"
 #: builtin/fetch.c:879
 #, c-format
 msgid "Fetching %s\n"
-msgstr "Hole %s ab\n"
+msgstr "Fordere an von %s\n"
=20
 #: builtin/fetch.c:881
 #, c-format
 msgid "Could not fetch %s"
-msgstr "Konnte %s nicht anfordern"
+msgstr "Konnte nicht von %s anfordern"
=20
 #: builtin/fetch.c:898
 msgid ""
 "No remote repository specified.  Please, specify either a URL or a\n"
 "remote name from which new revisions should be fetched."
 msgstr ""
-"Kein externes Projektarchiv spezifiziert. Bitte spezifiziere entweder=
\n"
-"eine URL oder den Namen eines externen Archivs, von welchem neue\n"
-"Revisionen angefordert werden sollen."
+"Kein externes Projektarchiv angegeben. Bitte gebe entweder eine URL\n=
"
+"oder den Namen des externen Archivs an, von welchem neue\n"
+"Versionen angefordert werden sollen."
=20
 #: builtin/fetch.c:918
 msgid "You need to specify a tag name."
-msgstr "Du musst den Namen der Markierung spezifizieren."
+msgstr "Du musst den Namen der Markierung angeben."
=20
 #: builtin/fetch.c:970
 msgid "fetch --all does not take a repository argument"
-msgstr "fetch -all nimmt kein Projektarchiv als Argument"
+msgstr "fetch --all akzeptiert kein Projektarchiv als Argument"
=20
 #: builtin/fetch.c:972
 msgid "fetch --all does not make sense with refspecs"
@@ -2012,12 +2012,13 @@ msgstr "Zu viele Optionen angegeben"
 #: builtin/gc.c:103
 #, c-format
 msgid "insanely long object directory %.*s"
-msgstr "wahnsinnig langes Objekt-Verzeichnis %.*s"
+msgstr "zu langes Objekt-Verzeichnis %.*s"
=20
 #: builtin/gc.c:223
 #, c-format
 msgid "Auto packing the repository for optimum performance.\n"
-msgstr "Automatisches Packen des Projektarchivs f=C3=BCr optimale Leis=
tung.\n"
+msgstr "Die Datenbank des Projektarchivs wird f=C3=BCr eine optimale P=
erformance "
+"komprimiert.\n"
=20
 #: builtin/gc.c:226
 #, c-format
@@ -2025,13 +2026,15 @@ msgid ""
 "Auto packing the repository for optimum performance. You may also\n"
 "run \"git gc\" manually. See \"git help gc\" for more information.\n"
 msgstr ""
-"Automatisches Packen des Projektarchivs f=C3=BCr optimale Leistung. D=
u kannst auch\n"
-"\"git gc\" manuell ausf=C3=BChren. Siehe \"git help gc\" f=C3=BCr wei=
tere Informationen.\n"
+"Die Datenbank des Projektarchivs wird f=C3=BCr eine optimale Performa=
nce\n"
+"komprimiert. Du kannst auch \"git gc\" manuell ausf=C3=BChren. "
+"Siehe \"git help gc\" f=C3=BCr weitere Informationen.\n"
=20
 #: builtin/gc.c:256
 msgid ""
 "There are too many unreachable loose objects; run 'git prune' to remo=
ve them."
-msgstr "Es gibt zu viele unerreichbare lose Objekte; f=C3=BChre 'git p=
rune' aus um diese zu entfernen."
+msgstr "Es gibt zu viele unerreichbare lose Objekte; f=C3=BChre 'git p=
rune' aus, "
+"um diese zu entfernen."
=20
 #: builtin/grep.c:216
 #, c-format
@@ -2046,12 +2049,12 @@ msgstr "Fehler beim Verzeichniswechsel: %s"
 #: builtin/grep.c:478 builtin/grep.c:512
 #, c-format
 msgid "unable to read tree (%s)"
-msgstr "konnte Baum (%s) nicht lesen"
+msgstr "konnte Zweig (%s) nicht lesen"
=20
 #: builtin/grep.c:526
 #, c-format
 msgid "unable to grep from object of type %s"
-msgstr "kann \"grep\" nicht mit Objekt des Typs \"%s\" durchf=C3=BChre=
n"
+msgstr "kann \"grep\" nicht mit Objekten des Typs \"%s\" durchf=C3=BCh=
ren"
=20
 #: builtin/grep.c:584
 #, c-format
@@ -2091,7 +2094,7 @@ msgstr ""
=20
 #: builtin/grep.c:982
 msgid "both --cached and trees are given."
-msgstr "sowohl --cached als auch B=C3=A4ume gegeben"
+msgstr "sowohl --cached als auch Zweige gegeben"
=20
 #: builtin/init-db.c:35
 #, c-format
@@ -2101,12 +2104,12 @@ msgstr "Konnte %s nicht schreibbar f=C3=BCr Gru=
ppen machen"
 #: builtin/init-db.c:62
 #, c-format
 msgid "insanely long template name %s"
-msgstr "verr=C3=BCckt langer Vorlagen-Name %s"
+msgstr "zu langer Vorlagen-Name %s"
=20
 #: builtin/init-db.c:67
 #, c-format
 msgid "cannot stat '%s'"
-msgstr "'%s' kann nicht gelesen werden"
+msgstr "Kann '%s' nicht lesen"
=20
 #: builtin/init-db.c:73
 #, c-format
@@ -2126,12 +2129,12 @@ msgstr "kann Verkn=C3=BCfpung '%s' nicht lesen"
 #: builtin/init-db.c:99
 #, c-format
 msgid "insanely long symlink %s"
-msgstr "verr=C3=BCckt lange symbolische Verkn=C3=BCpfung %s"
+msgstr "zu lange symbolische Verkn=C3=BCpfung %s"
=20
 #: builtin/init-db.c:102
 #, c-format
 msgid "cannot symlink '%s' '%s'"
-msgstr "kann '%s' '%s' nicht symbolisch verkn=C3=BCpfen"
+msgstr "kann '%s' nicht mit '%s' symbolisch verkn=C3=BCpfen"
=20
 #: builtin/init-db.c:106
 #, c-format
@@ -2146,12 +2149,12 @@ msgstr "ignoriere Vorlage %s"
 #: builtin/init-db.c:133
 #, c-format
 msgid "insanely long template path %s"
-msgstr "verr=C3=BCckt langer Vorlagen-Pfad %s"
+msgstr "zu langer Vorlagen-Pfad %s"
=20
 #: builtin/init-db.c:141
 #, c-format
 msgid "templates not found %s"
-msgstr "Vorlagen nicht gefunden %s"
+msgstr "keine Vorlagen in '%s' gefunden"
=20
 #: builtin/init-db.c:154
 #, c-format
@@ -2161,7 +2164,7 @@ msgstr "kopiere keine Vorlagen mit einer falschen=
 Formatversion %d von '%s'"
 #: builtin/init-db.c:192
 #, c-format
 msgid "insane git directory %s"
-msgstr "verr=C3=BCcktes git Verzeichnis %s"
+msgstr "ung=C3=BCltiges git Verzeichnis %s"
=20
 #: builtin/init-db.c:322 builtin/init-db.c:325
 #, c-format
@@ -2171,12 +2174,12 @@ msgstr "%s existiert bereits"
 #: builtin/init-db.c:354
 #, c-format
 msgid "unable to handle file type %d"
-msgstr "kann Dateityp %d nicht behandeln"
+msgstr "kann nicht mit Dateityp %d umgehen"
=20
 #: builtin/init-db.c:357
 #, c-format
 msgid "unable to move %s to %s"
-msgstr "konnte %s nicht nach %s verschieben"
+msgstr "Konnte %s nicht nach %s verschieben"
=20
 #: builtin/init-db.c:362
 #, c-format
@@ -2217,7 +2220,7 @@ msgstr "kann Verzeichnis %s nicht erstellen"
 #: builtin/init-db.c:532
 #, c-format
 msgid "cannot chdir to %s"
-msgstr "kann nicht zu Verzeichnis %s wechseln"
+msgstr "kann nicht in Verzeichnis %s wechseln"
=20
 #: builtin/init-db.c:554
 #, c-format
@@ -2267,15 +2270,15 @@ msgstr "Kann Patch-Datei %s nicht =C3=B6ffnen"
=20
 #: builtin/log.c:694
 msgid "Need exactly one range."
-msgstr "Brauche genau einen Bereich."
+msgstr "Brauche genau einen Versionsbereich."
=20
 #: builtin/log.c:702
 msgid "Not a range."
-msgstr "Kein Bereich."
+msgstr "Kein Versionsbereich."
=20
 #: builtin/log.c:739
 msgid "Could not extract email from committer identity."
-msgstr "Konnte E-Mail von der Intentit=C3=A4t des Einreichers nicht ex=
trahieren."
+msgstr "Konnte E-Mail-Adresse des Einreichers nicht extrahieren."
=20
 #: builtin/log.c:785
 msgid "Cover letter needs email format"
@@ -2284,7 +2287,7 @@ msgstr "Deckblatt ben=C3=B6tigt E-Mail-Format"
 #: builtin/log.c:879
 #, c-format
 msgid "insane in-reply-to: %s"
-msgstr "verr=C3=BCcktes in-reply-to: %s"
+msgstr "ung=C3=BCltiges in-reply-to: %s"
=20
 #: builtin/log.c:952
 msgid "Two output directories?"
@@ -2338,8 +2341,8 @@ msgstr "Fehler beim Erstellen der Ausgabedateien.=
"
 msgid ""
 "Could not find a tracked remote branch, please specify <upstream> man=
ually.\n"
 msgstr ""
-"Konnte gefolgten externen Zweig nicht finden, bitte spezifiziere "
-"<upstream> manuell.\n"
+"Konnte gefolgten, externen Zweig nicht finden, bitte gebe "
+"<upstream> manuell an.\n"
=20
 #: builtin/log.c:1530 builtin/log.c:1532 builtin/log.c:1544
 #, c-format
@@ -2389,7 +2392,7 @@ msgstr " (nichts zu quetschen)"
 #: builtin/merge.c:330
 #, c-format
 msgid "Squash commit -- not updating HEAD\n"
-msgstr "Quetsche Version -- aktualisiere Zweigspitze (HEAD) nicht\n"
+msgstr "Quetsche Version -- Zweigspitze (HEAD) wird nicht aktualisiert=
\n"
=20
 #: builtin/merge.c:362
 msgid "Writing SQUASH_MSG"
@@ -2402,8 +2405,8 @@ msgstr "Schlie=C3=9Fe SQUASH_MSG ab"
 #: builtin/merge.c:386
 #, c-format
 msgid "No merge message -- not updating HEAD\n"
-msgstr "Keine Zusammenf=C3=BChrungsbeschreibung -- aktualisiere Zweigs=
pitze (HEAD) "
-"nicht\n"
+msgstr "Keine Zusammenf=C3=BChrungsbeschreibung -- Zweigspitze (HEAD) =
wird nicht "
+"aktualisiert\n"
=20
 #: builtin/merge.c:437
 #, c-format
@@ -2429,7 +2432,7 @@ msgstr "Konnte Bereitstellung nicht schreiben."
=20
 #: builtin/merge.c:709
 msgid "Not handling anything other than two heads merge."
-msgstr "Behandle nichts anderes als die Zusammenf=C3=BChrung von zwei =
K=C3=B6pfen."
+msgstr "Es wird nur die Zusammenf=C3=BChrung von zwei Zweigen behandel=
t."
=20
 #: builtin/merge.c:723
 #, c-format
@@ -2450,7 +2453,7 @@ msgstr "konnte nicht von '%s' lesen"
 #, c-format
 msgid "Not committing merge; use 'git commit' to complete the merge.\n=
"
 msgstr ""
-"Zusammenf=C3=BChrung nicht eingetragen; benutze 'git commit' um die "
+"Zusammenf=C3=BChrung wurde nicht eingetragen; benutze 'git commit' um=
 die "
 "Zusammenf=C3=BChrung abzuschlie=C3=9Fen.\n"
=20
 #: builtin/merge.c:891
@@ -2492,7 +2495,7 @@ msgstr "'%s' ist keine Version"
=20
 #: builtin/merge.c:1057
 msgid "No current branch."
-msgstr "Kein aktueller Zweig."
+msgstr "Du befindest dich auf keinem Zweig."
=20
 #: builtin/merge.c:1059
 msgid "No remote for the current branch."
@@ -2500,7 +2503,7 @@ msgstr "Kein externes Archiv f=C3=BCr den aktuell=
en Zweig."
=20
 #: builtin/merge.c:1061
 msgid "No default upstream defined for the current branch."
-msgstr "Kein externes Standard-Projektarchiv f=C3=BCr den aktuellen Zw=
eig "
+msgstr "Es ist kein externes Standard-Projektarchiv f=C3=BCr den aktue=
llen Zweig "
 "definiert."
=20
 #: builtin/merge.c:1066
@@ -2530,15 +2533,13 @@ msgid ""
 "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 "Please, commit your changes before you can merge."
 msgstr ""
-"Du hast deinen \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD =
"
-"existiert).\n"
+"Du hast \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD existie=
rt).\n"
 "Bitte trage deine =C3=84nderungen ein, bevor du zusammenf=C3=BChren k=
annst."
=20
 #: builtin/merge.c:1214
 msgid "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exist=
s)."
 msgstr ""
-"Du hast deinen \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD =
"
-"existiert)."
+"Du hast \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD existie=
rt)."
=20
 #: builtin/merge.c:1223
 msgid "You cannot combine --squash with --no-ff."
@@ -2550,11 +2551,11 @@ msgstr "Du kannst --no-ff nicht mit --ff--only =
kombinieren."
=20
 #: builtin/merge.c:1235
 msgid "No commit specified and merge.defaultToUpstream not set."
-msgstr "Keine Version spezifiziert und merge.defaultToUpstream nicht g=
esetzt."
+msgstr "Keine Version angegeben und merge.defaultToUpstream ist nicht =
gesetzt."
=20
 #: builtin/merge.c:1266
 msgid "Can merge only exactly one commit into empty head"
-msgstr "Kann nur exakt eine Version in einem leeren Kopf zusammenf=C3=BC=
hren."
+msgstr "Kann nur exakt eine Version in einem leeren Zweig zusammenf=C3=
=BChren."
=20
 #: builtin/merge.c:1269
 msgid "Squash commit into empty head not supported yet"
@@ -2591,7 +2592,7 @@ msgstr "Vorspulen nicht m=C3=B6glich, breche ab."
 #: builtin/merge.c:1482 builtin/merge.c:1559
 #, c-format
 msgid "Rewinding the tree to pristine...\n"
-msgstr "R=C3=BCcklauf des Baumes bis zum Ursprung...\n"
+msgstr "R=C3=BCcklauf des Zweiges bis zum Ursprung...\n"
=20
 #: builtin/merge.c:1486
 #, c-format
@@ -2601,7 +2602,7 @@ msgstr "Probiere Zusammenf=C3=BChrungsstrategie %=
s...\n"
 #: builtin/merge.c:1550
 #, c-format
 msgid "No merge strategy handled the merge.\n"
-msgstr "Keine Zusammenf=C3=BChrungsstrategie behandelt die Zusammenf=C3=
=BChrung.\n"
+msgstr "Keine Zusammenf=C3=BChrungsstrategie behandelt diese Zusammenf=
=C3=BChrung.\n"
=20
 #: builtin/merge.c:1552
 #, c-format
@@ -2617,13 +2618,13 @@ msgstr "Benutze \"%s\" um die Aufl=C3=B6sung pe=
r Hand vorzubereiten.\n"
 #, c-format
 msgid "Automatic merge went well; stopped before committing as request=
ed\n"
 msgstr ""
-"Automatische Zusammenf=C3=BChrung gut gegangen; stoppe, wie angefragt=
, vor der "
-"Eintragung\n"
+"Automatische Zusammenf=C3=BChrung abgeschlossen; halte, wie gew=C3=BC=
nscht, vor der "
+"Eintragung an\n"
=20
 #: builtin/mv.c:108
 #, c-format
 msgid "Checking rename of '%s' to '%s'\n"
-msgstr "Pr=C3=BCfe Umbenennen von '%s' nach '%s'\n"
+msgstr "Pr=C3=BCfe Umbenennung von '%s' nach '%s'\n"
=20
 #: builtin/mv.c:112
 msgid "bad source"
@@ -2652,7 +2653,7 @@ msgstr "nicht unter Versionskontrolle"
=20
 #: builtin/mv.c:173
 msgid "destination exists"
-msgstr "Ziel existiert"
+msgstr "Ziel existiert bereits"
=20
 #: builtin/mv.c:181
 #, c-format
@@ -2680,7 +2681,7 @@ msgstr "Benenne %s nach %s um\n"
 #: builtin/mv.c:215
 #, c-format
 msgid "renaming '%s' failed"
-msgstr "Umbenennen von '%s' fehlgeschlagen"
+msgstr "Umbenennung von '%s' fehlgeschlagen"
=20
 #: builtin/notes.c:139
 #, c-format
@@ -2694,12 +2695,13 @@ msgstr "konnte Datei-Deskriptor f=C3=BCr Ausgab=
e von 'show' nicht =C3=B6ffnen"
 #: builtin/notes.c:155
 #, c-format
 msgid "failed to close pipe to 'show' for object '%s'"
-msgstr "Schlie=C3=9Fen der Pipe zu 'show' f=C3=BCr Objekt '%s' fehlges=
chlagen."
+msgstr "Schlie=C3=9Fen der Verbindung zu 'show' ist f=C3=BCr Objekt '%=
s' "
+"fehlgeschlagen."
=20
 #: builtin/notes.c:158
 #, c-format
 msgid "failed to finish 'show' for object '%s'"
-msgstr "'show' konnte f=C3=BCr Objekt '%s' nicht abgeschlossen werden"
+msgstr "konnte 'show' f=C3=BCr Objekt '%s' nicht abschlie=C3=9Fen"
=20
 #: builtin/notes.c:175 builtin/tag.c:343
 #, c-format
@@ -2740,7 +2742,7 @@ msgstr "konnte '%s' nicht =C3=B6ffnen oder lesen"
 #: builtin/notes.c:968 builtin/reset.c:293 builtin/tag.c:537
 #, c-format
 msgid "Failed to resolve '%s' as a valid ref."
-msgstr "'%s' konnte nicht als g=C3=BCltige Referenz aufgel=C3=B6st wer=
den."
+msgstr "Konnte '%s' nicht als g=C3=BCltige Referenz aufl=C3=B6sen."
=20
 #: builtin/notes.c:275
 #, c-format
@@ -2820,7 +2822,7 @@ msgstr ""
 #: builtin/notes.c:668
 #, c-format
 msgid "Missing notes on source object %s. Cannot copy."
-msgstr "Vermisse Notizen f=C3=BCr Quell-Objekt %s. Kann nicht kopieren=
=2E"
+msgstr "Keine Notizen f=C3=BCr Quell-Objekt %s. Kopie nicht m=C3=B6gli=
ch."
=20
 #: builtin/notes.c:717
 #, c-format
@@ -2828,7 +2830,7 @@ msgid ""
 "The -m/-F/-c/-C options have been deprecated for the 'edit' subcomman=
d.\n"
 "Please use 'git notes add -f -m/-F/-c/-C' instead.\n"
 msgstr ""
-"Die Optionen -m/-F/-c/-C sind veraltet f=C3=BCr das 'edit' Unterkomma=
ndo.\n"
+"Die Optionen -m/-F/-c/-C sind f=C3=BCr das Unterkommando 'edit' veral=
tet.\n"
 "Bitte benutze stattdessen 'git notes add -f -m/-F/-c/-C'.\n"
=20
 #: builtin/notes.c:971
@@ -2859,7 +2861,7 @@ msgstr "Option %s akzeptiert keine negative Form"
 #: builtin/pack-objects.c:2326
 #, c-format
 msgid "unable to parse value '%s' for option %s"
-msgstr "konnte Wert '%s' f=C3=BCr Option %s nicht analysieren"
+msgstr "konnte Wert '%s' f=C3=BCr Option %s nicht parsen"
=20
 #: builtin/push.c:44
 msgid "tag shorthand without <tag>"
@@ -2919,7 +2921,7 @@ msgstr ""
 msgid ""
 "You didn't specify any refspecs to push, and push.default is \"nothin=
g\"."
 msgstr ""
-"Du hast keine Referenzspezifikationen zum Versenden spezifiziert, und=
 "
+"Du hast keine Referenzspezifikationen zum Versenden angegeben, und "
 "push.default ist \"nothing\"."
=20
 #: builtin/push.c:147
@@ -3049,7 +3051,8 @@ msgstr "Nicht bereitgestellte =C3=84nderungen nac=
h Zur=C3=BCcksetzung:"
 #: builtin/reset.c:223
 #, c-format
 msgid "Cannot do a %s reset in the middle of a merge."
-msgstr "Kann keine '%s' Zur=C3=BCcksetzung innerhalb einer Zusammenf=C3=
=BChrung durchf=C3=BChren."
+msgstr "Kann keine '%s' Zur=C3=BCcksetzung durchf=C3=BChren, w=C3=A4hr=
end eine "
+"Zusammenf=C3=BChrung im Gange ist."
=20
 #: builtin/reset.c:297
 #, c-format
@@ -3068,7 +3071,7 @@ msgstr ""
 #: builtin/reset.c:313
 #, c-format
 msgid "Cannot do %s reset with paths."
-msgstr "Kann keine '%s' Zur=C3=BCcksetzung mit Pfaden machen."
+msgstr "Eine '%s' Zur=C3=BCcksetzung mit Pfaden ist nicht m=C3=B6glich=
=2E"
=20
 #: builtin/reset.c:325
 #, c-format
@@ -3078,7 +3081,7 @@ msgstr "'%s' Zur=C3=BCcksetzung ist in einem blo=C3=
=9Fen Projektarchiv nicht erlaubt"
 #: builtin/reset.c:341
 #, c-format
 msgid "Could not reset index file to revision '%s'."
-msgstr "Konnte Bereitstellungsdatei nicht zu Revision '%s' zur=C3=BCck=
setzen."
+msgstr "Konnte Bereitstellungsdatei nicht zu Version '%s' zur=C3=BCcks=
etzen."
=20
 #: builtin/revert.c:70 builtin/revert.c:91
 #, c-format
@@ -3129,7 +3132,7 @@ msgstr ""
 #: builtin/rm.c:194
 #, c-format
 msgid "not removing '%s' recursively without -r"
-msgstr "entferne '%s' nicht rekursiv ohne -r"
+msgstr "'%s' wird nicht ohne -r rekursiv entfernt"
=20
 #: builtin/rm.c:230
 #, c-format
@@ -3327,7 +3330,7 @@ msgstr "Bitte werde dir klar. --skip oder --abort=
?"
=20
 #: git-am.sh:506
 msgid "Resolve operation not in progress, we are not resuming."
-msgstr "keine Aufl=C3=B6sung in Durchf=C3=BChrung, wir setzen nicht fo=
rt."
+msgstr "Es ist keine Aufl=C3=B6sung im Gange, es wird nicht fortgesetz=
t."
=20
 #: git-am.sh:572
 #, sh-format
@@ -3378,7 +3381,7 @@ msgstr "'$arg' scheint keine g=C3=BCltige Version=
 zu sein"
=20
 #: git-bisect.sh:117
 msgid "Bad HEAD - I need a HEAD"
-msgstr "Ung=C3=BCltige Zweigspitze (HEAD) - Ich brauche eine Zweigspit=
ze (HEAD)"
+msgstr "Ung=C3=BCltige Zweigspitze (HEAD) - Zweigspitze (HEAD) wird be=
n=C3=B6tigt"
=20
 #: git-bisect.sh:130
 #, sh-format
@@ -3390,7 +3393,7 @@ msgstr ""
=20
 #: git-bisect.sh:140
 msgid "won't bisect on seeked tree"
-msgstr "werde nicht auf gesuchtem Baum halbieren"
+msgstr "\"bisect\" auf gesuchtem Zweig nicht m=C3=B6glich"
=20
 #: git-bisect.sh:144
 msgid "Bad HEAD - strange symbolic ref"
@@ -3463,7 +3466,7 @@ msgid ""
 "Please, fix them up in the work tree, and then use 'git add/rm <file>=
'\n"
 "as appropriate to mark resolution, or use 'git commit -a'."
 msgstr ""
-"\"pull\" ist nicht m=C3=B6glich weil du nicht zusammengef=C3=BChrte D=
ateien hast.\n"
+"\"pull\" ist nicht m=C3=B6glich, weil du nicht zusammengef=C3=BChrte =
Dateien hast.\n"
 "Bitte korrigiere dies im Arbeitsbaum und benutze dann 'git add/rm <Da=
tei>'\n"
 "um die Aufl=C3=B6sung entsprechend zu markieren, oder benutze 'git co=
mmit -a'."
=20
@@ -3537,7 +3540,7 @@ msgstr "Kein \"stash\" gefunden."
 #: git-stash.sh:359
 #, sh-format
 msgid "Too many revisions specified: $REV"
-msgstr "Zu viele Revisionen spezifiziert: $REV"
+msgstr "Zu viele Revisionen angegeben: $REV"
=20
 #: git-stash.sh:365
 #, sh-format
@@ -3560,7 +3563,8 @@ msgstr "Konnte die Bereitstellung nicht aktualisi=
eren"
=20
 #: git-stash.sh:416
 msgid "Cannot apply a stash in the middle of a merge"
-msgstr "Kann keinen \"stash\" innerhalb einer Zusammenf=C3=BChrung anw=
enden"
+msgstr "Kann \"stash\" nicht anwenden, solang eine Zusammenf=C3=BChrun=
g "
+"im Gange ist"
=20
 #: git-stash.sh:424
 msgid "Conflicts in index. Try without --index."
@@ -3590,12 +3594,12 @@ msgstr "Kein Zweigname spezifiziert"
=20
 #: git-stash.sh:570
 msgid "(To restore them type \"git stash apply\")"
-msgstr "(Um es wiederherzustellen, schreibe \"git stash apply\")"
+msgstr "(Zur Wiederherstellung gebe \"git stash apply\" ein)"
=20
 #: git-submodule.sh:56
 #, sh-format
 msgid "cannot strip one component off url '$remoteurl'"
-msgstr "Kann eine Komponente von URL '$remoteurl' nicht rausziehen"
+msgstr "Kann eine Komponente von URL '$remoteurl' nicht extrahieren"
=20
 #: git-submodule.sh:108
 #, sh-format
@@ -3610,7 +3614,7 @@ msgstr "Klonen von '$url' in Unterprojekt-Pfad '$=
path' fehlgeschlagen"
 #: git-submodule.sh:159
 #, sh-format
 msgid "Gitdir '$a' is part of the submodule path '$b' or vice versa"
-msgstr "Git-Verzeichnis '$a' ist Teil des Unterprojekt-Pfades '$b' ode=
r umgekehrt"
+msgstr "Git-Verzeichnis '$a' ist Teil des Unterprojekt-Pfades '$b', od=
er umgekehrt"
=20
 #: git-submodule.sh:247
 #, sh-format
@@ -3660,18 +3664,18 @@ msgstr "Keine URL f=C3=BCr Unterprojekt-Pfad '$=
path' in .gitmodules gefunden"
 #: git-submodule.sh:410
 #, sh-format
 msgid "Failed to register url for submodule path '$path'"
-msgstr "Fehler beim Registrieren der URL f=C3=BCr Unterprojekt-Pfad '$=
path'"
+msgstr "Registrierung der URL f=C3=BCr Unterprojekt-Pfad '$path' fehlg=
eschlagen"
=20
 #: git-submodule.sh:418
 #, sh-format
 msgid "Failed to register update mode for submodule path '$path'"
-msgstr "Fehler beim Registrieren des Aktualisierungsmodus f=C3=BCr Unt=
erprojekt-Pfad"
-" '$path'"
+msgstr "Registrierung des Aktualisierungsmodus f=C3=BCr Unterprojekt-P=
fad '$path' "
+"fehlgeschlagen"
=20
 #: git-submodule.sh:420
 #, sh-format
 msgid "Submodule '$name' ($url) registered for path '$path'"
-msgstr "Unterprojekt '$name' ($url) registriert f=C3=BCr Pfad '$path'"
+msgstr "Unterprojekt '$name' ($url) ist f=C3=BCr Pfad '$path' registri=
ert"
=20
 #: git-submodule.sh:519
 #, sh-format
@@ -3679,13 +3683,13 @@ msgid ""
 "Submodule path '$path' not initialized\n"
 "Maybe you want to use 'update --init'?"
 msgstr ""
-"Unterprojekt-Pfad '$path' nicht initialisiert\n"
+"Unterprojekt-Pfad '$path' ist nicht initialisiert\n"
 "Vielleicht m=C3=B6chtest du 'update --init' benutzen?"
=20
 #: git-submodule.sh:532
 #, sh-format
 msgid "Unable to find current revision in submodule path '$path'"
-msgstr "Konnte aktuelle Revision in Unterprojekt-Pfad '$path' nicht fi=
nden"
+msgstr "Konnte aktuelle Version in Unterprojekt-Pfad '$path' nicht fin=
den"
=20
 #: git-submodule.sh:551
 #, sh-format
@@ -3705,7 +3709,7 @@ msgstr "Unterprojekt-Pfad '$path': neu aufgebaut =
in '$sha1'"
 #: git-submodule.sh:571
 #, sh-format
 msgid "Unable to merge '$sha1' in submodule path '$path'"
-msgstr "Konnte '$sha1' nicht in Unterprojekt-Pfad '$path' zusammenf=C3=
=BChren"
+msgstr "Zusammenf=C3=BChrung von '$sha1' in Unterprojekt-Pfad '$path' =
fehlgeschlagen"
=20
 #: git-submodule.sh:572
 #, sh-format
--=20
1.7.10.129.g1ec31a3

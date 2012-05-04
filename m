From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=204/5=5D=20l10n=3A=20de=2Epo=3A=20collection=20of=20improvements?=
Date: Fri,  4 May 2012 21:48:25 +0200
Message-ID: <1336160906-20708-5-git-send-email-ralf.thielow@googlemail.com>
References: <1336160906-20708-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Fri May 04 21:49:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQOV0-0007I9-9b
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759564Ab2EDTs6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 15:48:58 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62404 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379Ab2EDTsv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 15:48:51 -0400
Received: by mail-we0-f174.google.com with SMTP id b10so138033wer.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 12:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dcX589P+zIFnzC/e74lJxgKEIVC09x4IUwInG25LsmI=;
        b=ohIZtofD2GhOi/ufqHn6Nkg2EyxjbbTHiV19oJHLd35O/3kwM3SxkPf5IBbzrN+SV8
         NR8rF31ico62XsEfqgmlkSIjl7jd2Wjo5OtgC+BDM3MjYMBTAgzRkQ3M2UIh3WAnJBpe
         pF5sC5S0ibKqTxkJ9sEfdu1yAJk+vKU0uuTX0FmtzXrYGA2TT8RVt2Rblw7B4IBjzuSB
         KfTNMGXcyqUSmbrXRVfNhL9PhqQFavNV2QhdYhAdEswv00kSN/FkBaE4tImiIR6/5AzP
         arCj3Vfc80fzbZyduqRy7l2++0LDyFOYAA7Mz8gqF7EjDHA67ZTQppSmeVox5/NLoRCa
         DXMQ==
Received: by 10.180.99.72 with SMTP id eo8mr15041248wib.10.1336160931147;
        Fri, 04 May 2012 12:48:51 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id 6sm3408902wiz.1.2012.05.04.12.48.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 12:48:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.72.g0dc6d
In-Reply-To: <1336160906-20708-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197068>

A list of improvements for German translation
which contains a couple of spellings and grammar.

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po |  214 +++++++++++++++++++++++++++++++-----------------------=
--------
 1 Datei ge=C3=A4ndert, 108 Zeilen hinzugef=C3=BCgt(+), 106 Zeilen entf=
ernt(-)

diff --git a/po/de.po b/po/de.po
index 6fb7b17..ade6d25 100644
--- a/po/de.po
+++ b/po/de.po
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
@@ -634,7 +634,7 @@ msgstr " (Erstelle/Kopiere Dateien und benutze \"gi=
t add\" zum Folgen)"
=20
 #: wt-status.c:773
 msgid " (use -u to show untracked files)"
-msgstr " (benutze -u um ungefolgte Dateien anzuzeigen)"
+msgstr " (benutze die Option -u um ungefolgte Dateien anzuzeigen)"
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
@@ -1281,7 +1281,7 @@ msgstr "%s konnte nicht gelesen werden\n"
 #: builtin/clone.c:341
 #, c-format
 msgid "failed to unlink '%s'"
-msgstr "Verkn=C3=BCpfung von '%s' konnte nicht aufgehoben werden."
+msgstr "%s konnte nicht entfernt werden"
=20
 #: builtin/clone.c:346
 #, c-format
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
+"oder den Namen des entfernten Archivsi an, von welchem neue\n"
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
@@ -2017,7 +2017,7 @@ msgstr "wahnsinnig langes Objekt-Verzeichnis %.*s=
"
 #: builtin/gc.c:223
 #, c-format
 msgid "Auto packing the repository for optimum performance.\n"
-msgstr "Automatisches Packen des Projektarchivs f=C3=BCr optimale Leis=
tung.\n"
+msgstr "Das Projektarchiv wird f=C3=BCr die optimale Leistung gepackt.=
\n"
=20
 #: builtin/gc.c:226
 #, c-format
@@ -2025,13 +2025,14 @@ msgid ""
 "Auto packing the repository for optimum performance. You may also\n"
 "run \"git gc\" manually. See \"git help gc\" for more information.\n"
 msgstr ""
-"Automatisches Packen des Projektarchivs f=C3=BCr optimale Leistung. D=
u kannst auch\n"
+"Das Projektarchiv wird f=C3=BCr die optimale Leistung gepackt. Du kan=
nst auch\n"
 "\"git gc\" manuell ausf=C3=BChren. Siehe \"git help gc\" f=C3=BCr wei=
tere Informationen.\n"
=20
 #: builtin/gc.c:256
 msgid ""
 "There are too many unreachable loose objects; run 'git prune' to remo=
ve them."
-msgstr "Es gibt zu viele unerreichbare lose Objekte; f=C3=BChre 'git p=
rune' aus um diese zu entfernen."
+msgstr "Es gibt zu viele unerreichbare lose Objekte; f=C3=BChre 'git p=
rune' "
+"aus um diese zu entfernen."
=20
 #: builtin/grep.c:216
 #, c-format
@@ -2046,12 +2047,12 @@ msgstr "Fehler beim Verzeichniswechsel: %s"
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
@@ -2091,7 +2092,7 @@ msgstr ""
=20
 #: builtin/grep.c:982
 msgid "both --cached and trees are given."
-msgstr "sowohl --cached als auch B=C3=A4ume gegeben"
+msgstr "sowohl --cached als auch Zweige gegeben"
=20
 #: builtin/init-db.c:35
 #, c-format
@@ -2101,7 +2102,7 @@ msgstr "Konnte %s nicht schreibbar f=C3=BCr Grupp=
en machen"
 #: builtin/init-db.c:62
 #, c-format
 msgid "insanely long template name %s"
-msgstr "verr=C3=BCckt langer Vorlagen-Name %s"
+msgstr "zu langer Vorlagen-Name %s"
=20
 #: builtin/init-db.c:67
 #, c-format
@@ -2126,12 +2127,12 @@ msgstr "kann Verkn=C3=BCfpung '%s' nicht lesen"
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
@@ -2146,12 +2147,12 @@ msgstr "ignoriere Vorlage %s"
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
@@ -2161,7 +2162,7 @@ msgstr "kopiere keine Vorlagen mit einer falschen=
 Formatversion %d von '%s'"
 #: builtin/init-db.c:192
 #, c-format
 msgid "insane git directory %s"
-msgstr "verr=C3=BCcktes git Verzeichnis %s"
+msgstr "ung=C3=BCltiges git Verzeichnis %s"
=20
 #: builtin/init-db.c:322 builtin/init-db.c:325
 #, c-format
@@ -2171,7 +2172,7 @@ msgstr "%s existiert bereits"
 #: builtin/init-db.c:354
 #, c-format
 msgid "unable to handle file type %d"
-msgstr "kann Dateityp %d nicht behandeln"
+msgstr "kann nicht mit Dateityp %d umgehen"
=20
 #: builtin/init-db.c:357
 #, c-format
@@ -2217,7 +2218,7 @@ msgstr "kann Verzeichnis %s nicht erstellen"
 #: builtin/init-db.c:532
 #, c-format
 msgid "cannot chdir to %s"
-msgstr "kann nicht zu Verzeichnis %s wechseln"
+msgstr "kann nicht in Verzeichnis %s wechseln"
=20
 #: builtin/init-db.c:554
 #, c-format
@@ -2267,15 +2268,15 @@ msgstr "Kann Patch-Datei %s nicht =C3=B6ffnen"
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
+msgstr "E-Mail-Adresse des Einreichers konnte nicht extrahiert werden.=
"
=20
 #: builtin/log.c:785
 msgid "Cover letter needs email format"
@@ -2284,7 +2285,7 @@ msgstr "Deckblatt ben=C3=B6tigt E-Mail-Format"
 #: builtin/log.c:879
 #, c-format
 msgid "insane in-reply-to: %s"
-msgstr "verr=C3=BCcktes in-reply-to: %s"
+msgstr "ung=C3=BCltiges in-reply-to: %s"
=20
 #: builtin/log.c:952
 msgid "Two output directories?"
@@ -2338,8 +2339,8 @@ msgstr "Fehler beim Erstellen der Ausgabedateien.=
"
 msgid ""
 "Could not find a tracked remote branch, please specify <upstream> man=
ually.\n"
 msgstr ""
-"Konnte gefolgten, externen Zweig nicht finden, bitte spezifiziere "
-"<upstream> manuell.\n"
+"Konnte gefolgten, externen Zweig nicht finden, bitte gebe "
+"<upstream> manuell an.\n"
=20
 #: builtin/log.c:1530 builtin/log.c:1532 builtin/log.c:1544
 #, c-format
@@ -2389,7 +2390,7 @@ msgstr " (nichts zu quetschen)"
 #: builtin/merge.c:330
 #, c-format
 msgid "Squash commit -- not updating HEAD\n"
-msgstr "Quetsche Version -- aktualisiere Zweigspitze (HEAD) nicht\n"
+msgstr "Quetsche Version -- Zweigspitze (HEAD) wird nicht aktualisiert=
\n"
=20
 #: builtin/merge.c:362
 msgid "Writing SQUASH_MSG"
@@ -2402,8 +2403,8 @@ msgstr "Schlie=C3=9Fe SQUASH_MSG ab"
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
@@ -2429,7 +2430,7 @@ msgstr "Konnte Bereitstellung nicht schreiben."
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
@@ -2450,7 +2451,7 @@ msgstr "konnte nicht von '%s' lesen"
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
@@ -2492,7 +2493,7 @@ msgstr "'%s' ist keine Version"
=20
 #: builtin/merge.c:1057
 msgid "No current branch."
-msgstr "Kein aktueller Zweig."
+msgstr "Du befindest dich auf keinem Zweig."
=20
 #: builtin/merge.c:1059
 msgid "No remote for the current branch."
@@ -2500,7 +2501,7 @@ msgstr "Kein externes Archiv f=C3=BCr den aktuell=
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
@@ -2530,15 +2531,13 @@ msgid ""
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
@@ -2550,11 +2549,11 @@ msgstr "Du kannst --no-ff nicht mit --ff--only =
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
@@ -2591,7 +2590,7 @@ msgstr "Vorspulen nicht m=C3=B6glich, breche ab."
 #: builtin/merge.c:1482 builtin/merge.c:1559
 #, c-format
 msgid "Rewinding the tree to pristine...\n"
-msgstr "R=C3=BCcklauf des Baumes bis zum Ursprung...\n"
+msgstr "R=C3=BCcklauf des Zweiges bis zum Ursprung...\n"
=20
 #: builtin/merge.c:1486
 #, c-format
@@ -2601,7 +2600,7 @@ msgstr "Probiere Zusammenf=C3=BChrungsstrategie %=
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
@@ -2617,13 +2616,13 @@ msgstr "Benutze \"%s\" um die Aufl=C3=B6sung pe=
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
@@ -2652,7 +2651,7 @@ msgstr "nicht unter Versionskontrolle"
=20
 #: builtin/mv.c:173
 msgid "destination exists"
-msgstr "Ziel existiert"
+msgstr "Ziel existiert bereits"
=20
 #: builtin/mv.c:181
 #, c-format
@@ -2680,7 +2679,7 @@ msgstr "Benenne %s nach %s um\n"
 #: builtin/mv.c:215
 #, c-format
 msgid "renaming '%s' failed"
-msgstr "Umbenennen von '%s' fehlgeschlagen"
+msgstr "Umbenennung von '%s' fehlgeschlagen"
=20
 #: builtin/notes.c:139
 #, c-format
@@ -2694,7 +2693,8 @@ msgstr "konnte Datei-Deskriptor f=C3=BCr Ausgabe =
von 'show' nicht =C3=B6ffnen"
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
@@ -2820,7 +2820,7 @@ msgstr ""
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
@@ -2828,7 +2828,7 @@ msgid ""
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
@@ -2919,7 +2919,7 @@ msgstr ""
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
@@ -3049,7 +3049,8 @@ msgstr "Nicht bereitgestellte =C3=84nderungen nac=
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
@@ -3068,7 +3069,7 @@ msgstr ""
 #: builtin/reset.c:313
 #, c-format
 msgid "Cannot do %s reset with paths."
-msgstr "Kann keine '%s' Zur=C3=BCcksetzung mit Pfaden machen."
+msgstr "Eine '%s' Zur=C3=BCcksetzung mit Pfaden ist nicht m=C3=B6glich=
=2E"
=20
 #: builtin/reset.c:325
 #, c-format
@@ -3078,7 +3079,7 @@ msgstr "'%s' Zur=C3=BCcksetzung ist in einem blo=C3=
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
@@ -3129,7 +3130,7 @@ msgstr ""
 #: builtin/rm.c:194
 #, c-format
 msgid "not removing '%s' recursively without -r"
-msgstr "entferne '%s' nicht rekursiv ohne -r"
+msgstr "'%s' wird nicht ohne -r rekursiv entfernt"
=20
 #: builtin/rm.c:230
 #, c-format
@@ -3327,7 +3328,7 @@ msgstr "Bitte werde dir klar. --skip oder --abort=
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
@@ -3378,7 +3379,7 @@ msgstr "'$arg' scheint keine g=C3=BCltige Version=
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
@@ -3390,7 +3391,7 @@ msgstr ""
=20
 #: git-bisect.sh:140
 msgid "won't bisect on seeked tree"
-msgstr "werde nicht auf gesuchtem Baum halbieren"
+msgstr "\"bisect\" auf gesuchtem Zweig nicht m=C3=B6glich"
=20
 #: git-bisect.sh:144
 msgid "Bad HEAD - strange symbolic ref"
@@ -3463,7 +3464,7 @@ msgid ""
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
@@ -3537,7 +3538,7 @@ msgstr "Kein \"stash\" gefunden."
 #: git-stash.sh:359
 #, sh-format
 msgid "Too many revisions specified: $REV"
-msgstr "Zu viele Revisionen spezifiziert: $REV"
+msgstr "Zu viele Revisionen angegeben: $REV"
=20
 #: git-stash.sh:365
 #, sh-format
@@ -3560,7 +3561,8 @@ msgstr "Konnte die Bereitstellung nicht aktualisi=
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
@@ -3590,12 +3592,12 @@ msgstr "Kein Zweigname spezifiziert"
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
@@ -3610,7 +3612,7 @@ msgstr "Klonen von '$url' in Unterprojekt-Pfad '$=
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
@@ -3660,18 +3662,18 @@ msgstr "Keine URL f=C3=BCr Unterprojekt-Pfad '$=
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
@@ -3679,13 +3681,13 @@ msgid ""
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
@@ -3705,7 +3707,7 @@ msgstr "Unterprojekt-Pfad '$path': neu aufgebaut =
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
1.7.10.72.g0dc6d

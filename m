From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate "index" as "Index"
Date: Fri, 29 May 2015 20:54:04 +0200
Message-ID: <1432925644-26231-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@drmicha.warpmail.net, sbeller@google.com, tr@thomasrast.ch,
	jk@jk.gs, stimming@tuhh.de, phillip.szelat@gmail.com,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 20:54:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyPQE-0002hJ-4Y
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 20:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061AbbE2SyS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2015 14:54:18 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36424 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756603AbbE2SyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 14:54:09 -0400
Received: by wgbgq6 with SMTP id gq6so70173535wgb.3
        for <git@vger.kernel.org>; Fri, 29 May 2015 11:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=yyJzq/Nbjl1yRATDlQ9XejzXY/yDFX1T0FAh0kmi+aE=;
        b=Fbwf+QWMUiX+SW+Pv/stu0TWEhFQnYqd3BhsHkzyk0QKPVrv9ptBDDPnc/dLsipbcc
         Y1kHInP6QijuU/Jzf4Q4rlcJ4NZYhuXdGkZQTdMNneCkyBoq3LAycncDlpXoR76XcKJq
         1BmezaWIPivfnPkDtdv1c1l3rlQlUnAYdA5X/Ko6mQ/WzzCo9cw75138KoRNCCYE6ifx
         gBn3XhP/HkrCxcukS2tGjK6KU0eiSedLafpg3cxLkd7e1VtZ0xttxGpLVVATL14lJIhe
         ItNTzy7VvflwcVCmyVUaCq3ouV8gRs3ucOpBy0b+SOVDvokn4OHtVKx7P38retCIYWLC
         znfg==
X-Received: by 10.194.179.200 with SMTP id di8mr18011830wjc.56.1432925648059;
        Fri, 29 May 2015 11:54:08 -0700 (PDT)
Received: from localhost (dslb-092-078-236-214.092.078.pools.vodafone-ip.de. [92.78.236.214])
        by mx.google.com with ESMTPSA id a19sm4342881wiv.2.2015.05.29.11.54.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 11:54:07 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.539.g9ca989a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270265>

The term "index" is translated as "Staging-Area" to
not confuse beginners who don't know about Git's index.

Since the term "staging area" doesn't appear in original
Git messages (not even in the glossary) and "index" is a
well known term for experienced users, we should treat
"index" as a Git term and therefore don't translate it.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---

http://thread.gmane.org/gmane.comp.version-control.git/269345/focus=3D2=
69657

 po/de.po | 139 ++++++++++++++++++++++++++++++-------------------------=
--------
 1 file changed, 67 insertions(+), 72 deletions(-)

diff --git a/po/de.po b/po/de.po
index 2feaec1..e0fe667 100644
--- a/po/de.po
+++ b/po/de.po
@@ -657,7 +657,7 @@ msgstr "Lesen des Zwischenspeichers fehlgeschlagen"
 #: merge.c:94 builtin/checkout.c:374 builtin/checkout.c:580
 #: builtin/clone.c:662
 msgid "unable to write new index file"
-msgstr "Konnte neue Staging-Area-Datei nicht schreiben."
+msgstr "Konnte neue Index-Datei nicht schreiben."
=20
 #: merge-recursive.c:189
 #, c-format
@@ -913,7 +913,7 @@ msgstr "Konnte Objekt '%s' nicht parsen."
=20
 #: merge-recursive.c:2019 builtin/merge.c:667
 msgid "Unable to write index."
-msgstr "Konnte Staging-Area nicht schreiben."
+msgstr "Konnte Index nicht schreiben."
=20
 #: notes-utils.c:41
 msgid "Cannot commit uninitialized/unreferenced notes tree"
@@ -1226,7 +1226,7 @@ msgstr ""
 #: sequencer.c:321
 #, c-format
 msgid "%s: Unable to write new index file"
-msgstr "%s: Konnte neue Staging-Area-Datei nicht schreiben"
+msgstr "%s: Konnte neue Index-Datei nicht schreiben"
=20
 #: sequencer.c:339
 msgid "Could not resolve HEAD commit\n"
@@ -1248,7 +1248,7 @@ msgstr "Konnte Eltern-Commit %s nicht parsen\n"
=20
 #: sequencer.c:482
 msgid "Your index file is unmerged."
-msgstr "Ihre Staging-Area-Datei ist nicht zusammengef=C3=BChrt."
+msgstr "Ihre Index-Datei ist nicht zusammengef=C3=BChrt."
=20
 #: sequencer.c:501
 #, c-format
@@ -1294,12 +1294,12 @@ msgstr "leere Menge von Commits =C3=BCbergeben"
 #: sequencer.c:661
 #, c-format
 msgid "git %s: failed to read the index"
-msgstr "git %s: Fehler beim Lesen der Staging-Area"
+msgstr "git %s: Fehler beim Lesen des Indexes"
=20
 #: sequencer.c:665
 #, c-format
 msgid "git %s: failed to refresh the index"
-msgstr "git %s: Fehler beim Aktualisieren der Staging-Area"
+msgstr "git %s: Fehler beim Aktualisieren des Indexes"
=20
 #: sequencer.c:725
 #, c-format
@@ -2063,11 +2063,11 @@ msgstr "l=C3=B6sche '%s'\n"
 #: builtin/add.c:134
 msgid "Unstaged changes after refreshing the index:"
 msgstr ""
-"Nicht zum Commit vorgemerkte =C3=84nderungen nach Aktualisierung der =
Staging-Area:"
+"Nicht zum Commit vorgemerkte =C3=84nderungen nach Aktualisierung des =
Indexes:"
=20
 #: builtin/add.c:194 builtin/rev-parse.c:785
 msgid "Could not read the index"
-msgstr "Konnte die Staging-Area nicht lesen"
+msgstr "Konnte den Index nicht lesen"
=20
 #: builtin/add.c:205
 #, c-format
@@ -2145,7 +2145,7 @@ msgstr "gel=C3=B6schte Pfade im Arbeitsverzeichni=
s ignorieren (genau wie --no-all)"
=20
 #: builtin/add.c:262
 msgid "don't add, only refresh the index"
-msgstr "nichts hinzuf=C3=BCgen, nur die Staging-Area aktualisieren"
+msgstr "nichts hinzuf=C3=BCgen, nur den Index aktualisieren"
=20
 #: builtin/add.c:263
 msgid "just skip files which cannot be added because of errors"
@@ -2188,11 +2188,11 @@ msgstr "Wollten Sie vielleicht 'git add .' sage=
n?\n"
 #: builtin/add.c:363 builtin/check-ignore.c:172 builtin/clean.c:920
 #: builtin/commit.c:335 builtin/mv.c:130 builtin/reset.c:235 builtin/r=
m.c:299
 msgid "index file corrupt"
-msgstr "Staging-Area-Datei besch=C3=A4digt"
+msgstr "Index-Datei besch=C3=A4digt"
=20
 #: builtin/add.c:446 builtin/apply.c:4675 builtin/mv.c:279 builtin/rm.=
c:431
 msgid "Unable to write new index file"
-msgstr "Konnte neue Staging-Area-Datei nicht schreiben."
+msgstr "Konnte neue Index-Datei nicht schreiben."
=20
 #: builtin/apply.c:59
 msgid "git apply [<options>] [<patch>...]"
@@ -2396,7 +2396,7 @@ msgstr "Pfad %s wurde umbenannt/gel=C3=B6scht"
 #: builtin/apply.c:3349 builtin/apply.c:3504
 #, c-format
 msgid "%s: does not exist in index"
-msgstr "%s ist nicht in der Staging-Area"
+msgstr "%s ist nicht im Index"
=20
 #: builtin/apply.c:3353 builtin/apply.c:3496 builtin/apply.c:3518
 #, c-format
@@ -2406,7 +2406,7 @@ msgstr "%s: %s"
 #: builtin/apply.c:3358 builtin/apply.c:3512
 #, c-format
 msgid "%s: does not match index"
-msgstr "%s entspricht nicht der Version in der Staging-Area"
+msgstr "%s entspricht nicht der Version im Index"
=20
 #: builtin/apply.c:3460
 msgid "removal patch leaves file contents"
@@ -2470,7 +2470,7 @@ msgstr "make_cache_entry f=C3=BCr Pfad '%s' fehlg=
eschlagen"
 #: builtin/apply.c:4049
 #, c-format
 msgid "unable to remove %s from index"
-msgstr "konnte %s nicht aus der Staging-Area entfernen"
+msgstr "konnte %s nicht aus dem Index entfernen"
=20
 #: builtin/apply.c:4078
 #, c-format
@@ -2539,7 +2539,7 @@ msgstr "nicht erkannte Eingabe"
=20
 #: builtin/apply.c:4405
 msgid "unable to read index file"
-msgstr "Konnte Staging-Area-Datei nicht lesen"
+msgstr "Konnte Index-Datei nicht lesen"
=20
 #: builtin/apply.c:4522 builtin/apply.c:4525 builtin/clone.c:92
 #: builtin/fetch.c:92
@@ -2593,8 +2593,7 @@ msgstr ""
 #: builtin/apply.c:4544
 msgid "make sure the patch is applicable to the current index"
 msgstr ""
-"sicherstellen, dass der Patch in der aktuellen Staging-Area angewende=
t "
-"werden kann"
+"sicherstellen, dass der Patch mit dem aktuellen Index angewendet werd=
en kann"
=20
 #: builtin/apply.c:4546
 msgid "apply a patch without touching the working tree"
@@ -2616,8 +2615,8 @@ msgstr "versuche 3-Wege-Merge, wenn der Patch nic=
ht angewendet werden konnte"
 #: builtin/apply.c:4554
 msgid "build a temporary index based on embedded index information"
 msgstr ""
-"eine tempor=C3=A4re Staging-Area, basierend auf den integrierten Stag=
ing-Area-"
-"Informationen, erstellen"
+"einen tempor=C3=A4ren Index, basierend auf den integrierten Index-Inf=
ormationen, "
+"erstellen"
=20
 #: builtin/apply.c:4556 builtin/checkout-index.c:198 builtin/ls-files.=
c:412
 msgid "paths are separated with NUL character"
@@ -3365,7 +3364,7 @@ msgstr "alle Attribute einer Datei ausgeben"
=20
 #: builtin/check-attr.c:20
 msgid "use .gitattributes only from the index"
-msgstr ".gitattributes nur von der Staging-Area verwenden"
+msgstr "nur .gitattributes vom Index verwenden"
=20
 #: builtin/check-attr.c:21 builtin/check-ignore.c:22 builtin/hash-obje=
ct.c:98
 msgid "read file names from stdin"
@@ -3385,7 +3384,7 @@ msgstr "Eingabe-Pfade ohne =C3=9Cbereinstimmungen=
 anzeigen"
=20
 #: builtin/check-ignore.c:28
 msgid "ignore index when checking"
-msgstr "Staging-Area bei der Pr=C3=BCfung ignorieren"
+msgstr "Index bei der Pr=C3=BCfung ignorieren"
=20
 #: builtin/check-ignore.c:154
 msgid "cannot specify pathnames with --stdin"
@@ -3435,7 +3434,7 @@ msgstr "git checkout-index [<Optionen>] [--] [<Da=
tei>...]"
=20
 #: builtin/checkout-index.c:188
 msgid "check out all files in the index"
-msgstr "alle Dateien in der Staging-Area auschecken"
+msgstr "alle Dateien im Index auschecken"
=20
 #: builtin/checkout-index.c:189
 msgid "force overwrite of existing files"
@@ -3444,8 +3443,8 @@ msgstr "das =C3=9Cberschreiben bereits existieren=
der Dateien erzwingen"
 #: builtin/checkout-index.c:191
 msgid "no warning for existing files and files not in index"
 msgstr ""
-"keine Warnung f=C3=BCr existierende Dateien, und Dateien, die sich ni=
cht in der "
-"Staging-Area befinden"
+"keine Warnung f=C3=BCr existierende Dateien, und Dateien, die sich ni=
cht im Index "
+"befinden"
=20
 #: builtin/checkout-index.c:193
 msgid "don't checkout new files"
@@ -3453,7 +3452,7 @@ msgstr "keine neuen Dateien auschecken"
=20
 #: builtin/checkout-index.c:195
 msgid "update stat information in the index file"
-msgstr "Dateiinformationen in der Staging-Area-Datei aktualisieren"
+msgstr "Dateiinformationen in der Index-Datei aktualisieren"
=20
 #: builtin/checkout-index.c:201
 msgid "read list of paths from the standard input"
@@ -3533,7 +3532,7 @@ msgstr ""
=20
 #: builtin/checkout.c:278 builtin/checkout.c:467
 msgid "corrupt index file"
-msgstr "besch=C3=A4digte Staging-Area-Datei"
+msgstr "besch=C3=A4digte Index-Datei"
=20
 #: builtin/checkout.c:338 builtin/checkout.c:345
 #, c-format
@@ -3542,7 +3541,7 @@ msgstr "Pfad '%s' ist nicht zusammengef=C3=BChrt.=
"
=20
 #: builtin/checkout.c:489
 msgid "you need to resolve your current index first"
-msgstr "Sie m=C3=BCssen zuerst Ihre aktuelle Staging-Area aufl=C3=B6se=
n."
+msgstr "Sie m=C3=BCssen zuerst die Konflikte in Ihrem aktuellen Index =
aufl=C3=B6sen."
=20
 #: builtin/checkout.c:615
 #, c-format
@@ -3774,7 +3773,7 @@ msgid ""
 "checking out of the index."
 msgstr ""
 "git checkout: --ours/--theirs, --force und --merge sind inkompatibel =
wenn\n"
-"Sie aus der Staging-Area auschecken."
+"Sie aus dem Index auschecken."
=20
 #: builtin/clean.c:26
 msgid ""
@@ -4386,7 +4385,7 @@ msgstr "Fehler beim Entpacken des \"Tree\"-Objekt=
es von HEAD."
=20
 #: builtin/commit.c:344
 msgid "unable to create temporary index"
-msgstr "Konnte tempor=C3=A4re Staging-Area nicht erstellen."
+msgstr "Konnte tempor=C3=A4ren Index nicht erstellen."
=20
 #: builtin/commit.c:350
 msgid "interactive add failed"
@@ -4394,11 +4393,11 @@ msgstr "interaktives Hinzuf=C3=BCgen fehlgeschl=
agen"
=20
 #: builtin/commit.c:361
 msgid "unable to write index file"
-msgstr "Konnte Staging-Area-Datei nicht schreiben."
+msgstr "Konnte Index-Datei nicht schreiben."
=20
 #: builtin/commit.c:363
 msgid "unable to update temporary index"
-msgstr "Konnte tempor=C3=A4re Staging-Area nicht aktualisieren."
+msgstr "Konnte tempor=C3=A4ren Index nicht aktualisieren."
=20
 #: builtin/commit.c:365
 msgid "Failed to update main cache tree"
@@ -4419,11 +4418,11 @@ msgstr ""
=20
 #: builtin/commit.c:456
 msgid "cannot read the index"
-msgstr "Kann Staging-Area nicht lesen"
+msgstr "Kann Index nicht lesen"
=20
 #: builtin/commit.c:475
 msgid "unable to write temporary index file"
-msgstr "Konnte tempor=C3=A4re Staging-Area-Datei nicht schreiben."
+msgstr "Konnte tempor=C3=A4re Index-Datei nicht schreiben."
=20
 #: builtin/commit.c:580
 #, c-format
@@ -4558,7 +4557,7 @@ msgstr "%sCommit-Ersteller: %.*s <%.*s>"
=20
 #: builtin/commit.c:881
 msgid "Cannot read index"
-msgstr "Kann Staging-Area nicht lesen"
+msgstr "Kann Index nicht lesen"
=20
 #: builtin/commit.c:938
 msgid "Error building trees"
@@ -4637,7 +4636,7 @@ msgstr ""
 #: builtin/commit.c:1195
 msgid "Clever... amending the last one with dirty index."
 msgstr ""
-"Klug ... den letzten Commit mit einer ge=C3=A4nderten Staging-Area na=
chbessern."
+"Klug ... den letzten Commit mit einem ge=C3=A4nderten Index nachbesse=
rn."
=20
 #: builtin/commit.c:1197
 msgid "Explicit paths specified without -i or -o; assuming --only path=
s..."
@@ -5679,7 +5678,7 @@ msgstr "Hauptwurzeln melden"
=20
 #: builtin/fsck.c:613
 msgid "make index objects head nodes"
-msgstr "Objekte in der Staging-Area pr=C3=BCfen"
+msgstr "Index-Objekte im Index pr=C3=BCfen"
=20
 #: builtin/fsck.c:614
 msgid "make reflogs head nodes (default)"
@@ -5802,7 +5801,7 @@ msgstr "kann '%s' nicht =C3=B6ffnen"
=20
 #: builtin/grep.c:638
 msgid "search in index instead of in the work tree"
-msgstr "in der Staging-Area anstatt im Arbeitsverzeichnis suchen"
+msgstr "im Index anstatt im Arbeitsverzeichnis suchen"
=20
 #: builtin/grep.c:640
 msgid "find in contents not managed by git"
@@ -7001,8 +7000,7 @@ msgstr "Ausgabe relativ zum Projektverzeichnis"
 #: builtin/ls-files.c:458
 msgid "if any <file> is not in the index, treat this as an error"
 msgstr ""
-"als Fehler behandeln, wenn sich eine <Datei> nicht in der Staging-Are=
a "
-"befindet"
+"als Fehler behandeln, wenn sich eine <Datei> nicht im Index befindet"
=20
 #: builtin/ls-files.c:459
 msgid "tree-ish"
@@ -8018,12 +8016,12 @@ msgstr "Komprimiere Objekte"
 #: builtin/pack-objects.c:2570
 #, c-format
 msgid "unsupported index version %s"
-msgstr "Nicht unterst=C3=BCtzte Staging-Area-Version %s"
+msgstr "Nicht unterst=C3=BCtzte Index-Version %s"
=20
 #: builtin/pack-objects.c:2574
 #, c-format
 msgid "bad index version '%s'"
-msgstr "Ung=C3=BCltige Staging-Area-Version '%s'"
+msgstr "Ung=C3=BCltige Index-Version '%s'"
=20
 #: builtin/pack-objects.c:2597
 #, c-format
@@ -8128,7 +8126,7 @@ msgstr ""
=20
 #: builtin/pack-objects.c:2666
 msgid "include objects referred to by the index"
-msgstr "Objekte einschlie=C3=9Fen, die von der Staging-Area referenzie=
rt werden"
+msgstr "Objekte einschlie=C3=9Fen, die vom Index referenziert werden"
=20
 #: builtin/pack-objects.c:2669
 msgid "output pack to stdout"
@@ -8580,11 +8578,11 @@ msgstr ""
=20
 #: builtin/read-tree.c:110
 msgid "write resulting index to <file>"
-msgstr "resultierende Staging-Area nach <Datei> schreiben"
+msgstr "resultierenden Index nach <Datei> schreiben"
=20
 #: builtin/read-tree.c:113
 msgid "only empty the index"
-msgstr "die Staging-Area leeren"
+msgstr "nur den Index leeren"
=20
 #: builtin/read-tree.c:115
 msgid "Merging"
@@ -8612,7 +8610,7 @@ msgstr "<Unterverzeichnis>/"
=20
 #: builtin/read-tree.c:125
 msgid "read the tree into the index under <subdirectory>/"
-msgstr "das Verzeichnis in die Staging-Area unter <Unterverzeichnis>/ =
lesen"
+msgstr "das Verzeichnis in den Index unter <Unterverzeichnis>/ lesen"
=20
 #: builtin/read-tree.c:128
 msgid "update working tree with merge result"
@@ -8632,7 +8630,7 @@ msgstr "das Arbeitsverzeichnis nach dem Merge nic=
ht pr=C3=BCfen"
=20
 #: builtin/read-tree.c:135
 msgid "don't update the index or the work tree"
-msgstr "weder die Staging-Area, noch das Arbeitsverzeichnis aktualisie=
ren"
+msgstr "weder den Index, noch das Arbeitsverzeichnis aktualisieren"
=20
 #: builtin/read-tree.c:137
 msgid "skip applying sparse checkout filter"
@@ -9322,7 +9320,7 @@ msgstr "git rerere [clean | forget <Pfad>... | st=
atus | remaining | diff | gc]"
=20
 #: builtin/rerere.c:57
 msgid "register clean resolutions in index"
-msgstr "saubere Aufl=C3=B6sungen in der Staging-Area registrieren"
+msgstr "saubere Aufl=C3=B6sungen im Index registrieren"
=20
 #: builtin/reset.c:26
 msgid ""
@@ -9387,7 +9385,7 @@ msgstr "weniger Ausgaben, meldet nur Fehler"
=20
 #: builtin/reset.c:278
 msgid "reset HEAD and index"
-msgstr "HEAD und Staging-Area umsetzen"
+msgstr "HEAD und Index umsetzen"
=20
 #: builtin/reset.c:279
 msgid "reset only HEAD"
@@ -9395,7 +9393,7 @@ msgstr "nur HEAD umsetzen"
=20
 #: builtin/reset.c:281 builtin/reset.c:283
 msgid "reset HEAD, index and working tree"
-msgstr "HEAD, Staging-Area und Arbeitsverzeichnis umsetzen"
+msgstr "HEAD, Index und Arbeitsverzeichnis umsetzen"
=20
 #: builtin/reset.c:285
 msgid "reset HEAD but keep local changes"
@@ -9451,11 +9449,11 @@ msgstr "Nicht zum Commit vorgemerkte =C3=84nder=
ungen nach Zur=C3=BCcksetzung:"
 #: builtin/reset.c:370
 #, c-format
 msgid "Could not reset index file to revision '%s'."
-msgstr "Konnte Staging-Area-Datei nicht zu Commit '%s' setzen."
+msgstr "Konnte Index-Datei nicht zu Commit '%s' setzen."
=20
 #: builtin/reset.c:374
 msgid "Could not write new index file."
-msgstr "Konnte neue Staging-Area-Datei nicht schreiben."
+msgstr "Konnte neue Index-Datei nicht schreiben."
=20
 #: builtin/rev-parse.c:361
 msgid "git rev-parse --parseopt [<options>] -- [<args>...]"
@@ -9655,7 +9653,7 @@ msgstr "keine gel=C3=B6schten Dateien auflisten"
=20
 #: builtin/rm.c:271
 msgid "only remove from the index"
-msgstr "nur aus der Staging-Area entfernen"
+msgstr "nur aus dem Index entfernen"
=20
 #: builtin/rm.c:272
 msgid "override the up-to-date check"
@@ -10108,8 +10106,7 @@ msgstr "git update-index [<Optionen>] [--] [<Da=
tei>...]"
 #: builtin/update-index.c:757
 msgid "continue refresh even when index needs update"
 msgstr ""
-"Aktualisierung fortsetzen, auch wenn die Staging-Area aktualisiert we=
rden "
-"muss"
+"Aktualisierung fortsetzen, auch wenn der Index aktualisiert werden mu=
ss"
=20
 #: builtin/update-index.c:760
 msgid "refresh: ignore submodules"
@@ -10130,7 +10127,7 @@ msgstr "fehlende Dateien im Arbeitsverzeichnis =
beachten"
 #: builtin/update-index.c:769
 msgid "refresh even if index contains unmerged entries"
 msgstr ""
-"aktualisieren, auch wenn die Staging-Area nicht zusammengef=C3=BChrte=
 Eintr=C3=A4ge "
+"aktualisieren, auch wenn der Index nicht zusammengef=C3=BChrte Eintr=C3=
=A4ge "
 "beinhaltet"
=20
 #: builtin/update-index.c:772
@@ -10219,11 +10216,11 @@ msgstr "(f=C3=BCr Fremdprogramme) keine gespe=
icherten, nicht aufgel=C3=B6ste Konflikte"
=20
 #: builtin/update-index.c:833
 msgid "write index in this format"
-msgstr "Staging-Area-Datei in diesem Format schreiben"
+msgstr "Index-Datei in diesem Format schreiben"
=20
 #: builtin/update-index.c:835
 msgid "enable or disable split index"
-msgstr "Aktivierung oder Deaktivierung des Splittings der Staging-Area=
"
+msgstr "Aktivierung oder Deaktivierung des Splittings des Indexes"
=20
 #: builtin/update-ref.c:9
 msgid "git update-ref [<options>] -d <refname> [<old-val>]"
@@ -10398,7 +10395,7 @@ msgstr "aktuellen HEAD zu einem spezifizierten =
Zustand setzen"
=20
 #: common-cmds.h:25
 msgid "Remove files from the working tree and from the index"
-msgstr "Dateien im Arbeitsverzeichnis und von der Staging-Area l=C3=B6=
schen"
+msgstr "Dateien im Arbeitsverzeichnis und vom Index l=C3=B6schen"
=20
 #: common-cmds.h:26
 msgid "Show various types of objects"
@@ -10437,8 +10434,7 @@ msgstr "benutze <n> Ziffern zur Anzeige von SHA=
-1s"
 #: rerere.h:27
 msgid "update the index with reused conflict resolution if possible"
 msgstr ""
-"Staging-Area, wenn m=C3=B6glich, mit wiederverwendeter Konfliktaufl=C3=
=B6sung "
-"aktualisieren"
+"Index, wenn m=C3=B6glich, mit wiederverwendeter Konfliktaufl=C3=B6sun=
g aktualisieren"
=20
 #: git-am.sh:53
 msgid "You need to set your committer info first"
@@ -10478,8 +10474,7 @@ msgstr ""
 #: git-am.sh:142
 msgid "Using index info to reconstruct a base tree..."
 msgstr ""
-"Verwende Informationen aus der Staging-Area, um einen Basisverzeichni=
s "
-"nachzustellen"
+"Verwende Informationen aus dem Index, um einen Basisverzeichnis nachz=
ustellen"
=20
 #: git-am.sh:157
 msgid ""
@@ -10544,7 +10539,7 @@ msgstr "Es ist keine Aufl=C3=B6sung im Gange, e=
s wird nicht fortgesetzt."
 #: git-am.sh:612
 #, sh-format
 msgid "Dirty index: cannot apply patches (dirty: $files)"
-msgstr "Ge=C3=A4nderte Staging-Area: kann Patches nicht anwenden (ge=C3=
=A4ndert: $files)"
+msgstr "Ge=C3=A4nderter Index: kann Patches nicht anwenden (ge=C3=A4nd=
ert: $files)"
=20
 #: git-am.sh:722
 #, sh-format
@@ -10602,7 +10597,7 @@ msgid ""
 "You still have unmerged paths in your index\n"
 "did you forget to use 'git add'?"
 msgstr ""
-"Sie haben immer noch nicht zusammengef=C3=BChrte Pfade in der Staging=
-Area.\n"
+"Sie haben immer noch nicht zusammengef=C3=BChrte Pfade im Index.\n"
 "Haben Sie vergessen 'git add' zu benutzen?"
=20
 #: git-am.sh:888
@@ -11001,7 +10996,7 @@ msgstr "Sie haben bisher noch keinen initialen =
Commit"
=20
 #: git-stash.sh:89
 msgid "Cannot save the current index state"
-msgstr "Kann den aktuellen Zustand der Staging-Area nicht speichern"
+msgstr "Kann den aktuellen Zustand des Indexes nicht speichern"
=20
 #: git-stash.sh:124 git-stash.sh:137
 msgid "Cannot save the current worktree state"
@@ -11013,7 +11008,7 @@ msgstr "Keine =C3=84nderungen ausgew=C3=A4hlt"
=20
 #: git-stash.sh:144
 msgid "Cannot remove temporary index (can't happen)"
-msgstr "Kann tempor=C3=A4re Staging-Area nicht l=C3=B6schen (kann nich=
t passieren)"
+msgstr "Kann tempor=C3=A4ren Index nicht l=C3=B6schen (kann nicht pass=
ieren)"
=20
 #: git-stash.sh:157
 msgid "Cannot record working tree state"
@@ -11086,7 +11081,7 @@ msgstr "'$args' ist keine \"stash\"-Referenz"
=20
 #: git-stash.sh:444
 msgid "unable to refresh index"
-msgstr "unf=C3=A4hig die Staging-Area zu aktualisieren"
+msgstr "unf=C3=A4hig den Index zu aktualisieren"
=20
 #: git-stash.sh:448
 msgid "Cannot apply a stash in the middle of a merge"
@@ -11094,19 +11089,19 @@ msgstr "Kann \"stash\" nicht anwenden, solang=
 ein Merge im Gange ist"
=20
 #: git-stash.sh:456
 msgid "Conflicts in index. Try without --index."
-msgstr "Konflikte in der Staging-Area. Versuchen Sie es ohne --index."
+msgstr "Konflikte im Index. Versuchen Sie es ohne --index."
=20
 #: git-stash.sh:458
 msgid "Could not save index tree"
-msgstr "Konnte Staging-Area-Verzeichnis nicht speichern"
+msgstr "Konnte Index-Verzeichnis nicht speichern"
=20
 #: git-stash.sh:492
 msgid "Cannot unstage modified files"
-msgstr "Kann ge=C3=A4nderte Dateien nicht aus der Staging-Area entfern=
en"
+msgstr "Kann ge=C3=A4nderte Dateien nicht aus dem Index entfernen"
=20
 #: git-stash.sh:507
 msgid "Index was not unstashed."
-msgstr "Staging-Area wurde nicht aus dem Stash zur=C3=BCckgeladen."
+msgstr "Index wurde nicht aus dem Stash zur=C3=BCckgeladen."
=20
 #: git-stash.sh:530
 #, sh-format
@@ -11176,7 +11171,7 @@ msgstr ""
 #: git-submodule.sh:455
 #, sh-format
 msgid "Adding existing repo at '$sm_path' to the index"
-msgstr "F=C3=BCge existierendes Repository in '$sm_path' der Staging-A=
rea hinzu."
+msgstr "F=C3=BCge existierendes Repository in '$sm_path' dem Index hin=
zu."
=20
 #: git-submodule.sh:457
 #, sh-format
--=20
2.4.2.539.g9ca989a

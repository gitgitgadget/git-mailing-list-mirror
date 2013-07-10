From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCHv2 3/3] l10n: de.po: switch from pure German to German+English (part 3)
Date: Wed, 10 Jul 2013 19:54:50 +0200
Message-ID: <1373478890-8480-4-git-send-email-ralf.thielow@gmail.com>
References: <1371057331-3917-1-git-send-email-ralf.thielow@gmail.com>
 <1373478890-8480-1-git-send-email-ralf.thielow@gmail.com>
 <1373478890-8480-2-git-send-email-ralf.thielow@gmail.com>
 <1373478890-8480-3-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Wed Jul 10 19:56:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwycj-000557-J4
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 19:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986Ab3GJRzr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jul 2013 13:55:47 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:40012 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960Ab3GJRzT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 13:55:19 -0400
Received: by mail-ee0-f51.google.com with SMTP id e52so5067001eek.10
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Kfiqkx20WiUetyYpgvCgKxyt9I54DKARdja85344lCU=;
        b=glyipyriBvIq5R1McsHourj8HsIw/3rs5NICobEjhUXGCMuOx12wzM1oVBa4YXcP/Z
         IYYndkB9l0KzA9pzYyP7nRlGru1uppnCDA+VsXxloDxRgwilR0JGwLwqGoCFv665t5gR
         EaFvqobuyGKlKylxGJjCkk/7xZEKYDoPzUd+gPJFybjVB39Kd5YpEgeQlENMSrli8xxC
         qih6JTu9IK/CQ/Nx1qQwD1suOqtzxHerbOXFdOJA7Dr8xHhsBlKRuEQ2/sjNkL8ECci+
         SeLTV+CuZn8hD0NKlhyzLLc0Qb1wNnLnr6TeqzCqYeGdBHZ9/uJlKeXSpiHUmkLDYymz
         0Sug==
X-Received: by 10.14.213.135 with SMTP id a7mr36871547eep.152.1373478917487;
        Wed, 10 Jul 2013 10:55:17 -0700 (PDT)
Received: from localhost (dslb-188-103-254-174.pools.arcor-ip.net. [188.103.254.174])
        by mx.google.com with ESMTPSA id cg12sm61796013eeb.7.2013.07.10.10.55.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jul 2013 10:55:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1230.g519726a
In-Reply-To: <1373478890-8480-3-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230063>

This switches the translation from pure German to German+English.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 658 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 326 insertions(+), 332 deletions(-)

diff --git a/po/de.po b/po/de.po
index da0fbb0..6a9a7b1 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1407,7 +1407,7 @@ msgstr ""
=20
 #: wt-status.c:831
 msgid "  (use \"git am --skip\" to skip this patch)"
-msgstr " (benutzen Sie \"git am --skip\" um diesen Patch auszulassen)"
+msgstr "  (benutzen Sie \"git am --skip\" um diesen Patch auszulassen)=
"
=20
 #: wt-status.c:833
 msgid "  (use \"git am --abort\" to restore the original branch)"
@@ -7477,16 +7477,16 @@ msgid ""
 "\n"
 "    git push --set-upstream %s %s\n"
 msgstr ""
-"Der aktuelle Zweig %s hat keinen Zweig im externen Projektarchiv.\n"
-"Um den aktuellen Zweig zu versenden und das Fernarchiv als externes\n=
"
-"Projektarchiv zu verwenden, benutzen Sie\n"
+"Der aktuelle Branch %s hat keinen Upstream-Branch.\n"
+"Um den aktuellen Branch zu versenden und den Remote-Branch\n"
+"als Upstream-Branch zu setzen, benutzen Sie\n"
 "\n"
 "    git push --set-upstream %s %s\n"
=20
 #: builtin/push.c:136
 #, c-format
 msgid "The current branch %s has multiple upstream branches, refusing =
to push."
-msgstr "Der aktuelle Zweig %s hat mehrere externe Zweige, Versand verw=
eigert."
+msgstr "Der aktuelle Branch %s hat mehrere Upstream-Branches, \"push\"=
 verweigert."
=20
 #: builtin/push.c:139
 #, c-format
@@ -7495,9 +7495,9 @@ msgid ""
 "your current branch '%s', without telling me what to push\n"
 "to update which remote branch."
 msgstr ""
-"Sie versenden nach '%s', welches kein externes Projektarchiv Ihres\n"
-"aktuellen Zweiges '%s' ist, ohne mir mitzuteilen, was ich versenden\n=
"
-"soll, um welchen externen Zweig zu aktualisieren."
+"Sie versenden nach '%s', welches kein Upstream-Repository Ihres aktue=
llen\n"
+"Branches '%s' ist, ohne mir mitzuteilen, was ich versenden soll, um w=
elchen\n"
+"Remote-Branch zu aktualisieren."
=20
 #: builtin/push.c:151
 msgid ""
@@ -7520,6 +7520,7 @@ msgstr ""
 "wird in Git 2.0 von 'matching' nach 'simple' ge=C3=A4ndert. Um diese =
Meldung zu\n"
 "unterdr=C3=BCcken und das aktuelle Verhalten nach =C3=84nderung des S=
tandardwertes\n"
 "beizubehalten, benutzen Sie:\n"
+"\n"
 "  git config --global push.default matching\n"
 "\n"
 "Um diese Meldung zu unterdr=C3=BCcken und das neue Verhalten jetzt zu=
 =C3=BCbernehmen, "
@@ -7537,8 +7538,8 @@ msgstr ""
 msgid ""
 "You didn't specify any refspecs to push, and push.default is \"nothin=
g\"."
 msgstr ""
-"Sie haben keine Referenzspezifikationen zum Versenden angegeben, und =
push."
-"default ist \"nothing\"."
+"Sie haben keine Refspec f=C3=BCr \"push\" angegeben, und push.default=
 ist "
+"\"nothing\"."
=20
 #: builtin/push.c:206
 msgid ""
@@ -7548,9 +7549,9 @@ msgid ""
 "See the 'Note about fast-forwards' in 'git push --help' for details."
 msgstr ""
 "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze Ihres ak=
tuellen\n"
-"Zweiges hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen is=
t. F=C3=BChren Sie\n"
-"die externen =C3=84nderungen zusammen (z.B. 'git pull') bevor Sie ern=
eut\n"
-"versenden.\n"
+"Branches hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen i=
st. F=C3=BChren Sie\n"
+"die externen =C3=84nderungen zusammen (z.B. 'git pull') bevor Sie \"p=
ush\"\n"
+"erneut ausf=C3=BChren.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
 "f=C3=BCr weitere Details."
=20
@@ -7562,13 +7563,13 @@ msgid ""
 "to 'simple', 'current' or 'upstream' to push only the current branch.=
"
 msgstr ""
 "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze eines ve=
rsendeten\n"
-"Zweiges hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen is=
t. Wenn Sie "
+"Branches hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen i=
st. Wenn Sie "
 "nicht\n"
-"beabsichtigt haben, diesen Zweig zu versenden, k=C3=B6nnen Sie auch d=
en zu "
+"beabsichtigt haben, diesen Branch zu versenden, k=C3=B6nnen Sie auch =
den zu "
 "versendenden\n"
-"Zweig spezifizieren oder die Konfigurationsvariable 'push.default' zu=
 "
+"Branch spezifizieren oder die Konfigurationsvariable 'push.default' z=
u "
 "'simple', 'current'\n"
-"oder 'upstream' setzen, um nur den aktuellen Zweig zu versenden."
+"oder 'upstream' setzen, um nur den aktuellen Branch zu versenden."
=20
 #: builtin/push.c:218
 msgid ""
@@ -7578,9 +7579,9 @@ msgid ""
 "See the 'Note about fast-forwards' in 'git push --help' for details."
 msgstr ""
 "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze eines ve=
rsendeten\n"
-"Zweiges hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen is=
t. Checken Sie\n"
-"diesen Zweig aus und f=C3=BChren Sie die externen =C3=84nderungen zus=
ammen\n"
-"(z.B. 'git pull') bevor Sie erneut versenden.\n"
+"Branches hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen i=
st. Checken Sie\n"
+"diesen Branch aus und f=C3=BChren Sie die externen =C3=84nderungen zu=
sammen\n"
+"(z.B. 'git pull') bevor Sie erneut \"push\" ausf=C3=BChren.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
 "f=C3=BCr weitere Details."
=20
@@ -7592,23 +7593,23 @@ msgid ""
 "'git pull') before pushing again.\n"
 "See the 'Note about fast-forwards' in 'git push --help' for details."
 msgstr ""
-"Aktualisierungen wurden zur=C3=BCckgewiesen, weil das Fernarchiv Vers=
ionen "
+"Aktualisierungen wurden zur=C3=BCckgewiesen, weil das Remote-Reposito=
ry Commits "
 "enth=C3=A4lt,\n"
-"die lokal nicht vorhanden sind. Das wird =C3=BCblicherweise durch das=
 Versenden "
+"die lokal nicht vorhanden sind. Das wird =C3=BCblicherweise durch ein=
en \"push\" "
 "von\n"
-"Versionen auf dieselbe Referenz von einem anderen Projektarchiv aus "
+"Commits auf dieselbe Referenz von einem anderen Repository aus "
 "verursacht.\n"
 "Vielleicht m=C3=BCssen Sie die externen =C3=84nderungen zusammenzuf=C3=
=BChren (z.B. 'git "
 "pull')\n"
-"bevor Sie erneut versenden.\n"
+"bevor Sie erneut \"push\" ausf=C3=BChren.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
 "f=C3=BCr weitere Details."
=20
 #: builtin/push.c:231
 msgid "Updates were rejected because the tag already exists in the rem=
ote."
 msgstr ""
-"Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Markierung bere=
its\n"
-"im Fernarchiv existiert."
+"Aktualisierungen wurden zur=C3=BCckgewiesen, weil der Tag bereits\n"
+"im Remote-Repository existiert."
=20
 #: builtin/push.c:234
 msgid ""
@@ -7616,8 +7617,8 @@ msgid ""
 "or update a remote ref to make it point at a non-commit object,\n"
 "without using the '--force' option.\n"
 msgstr ""
-"Sie k=C3=B6nnen keine externe Referenz aktualisieren, die auf ein Obj=
ekt zeigt,\n"
-"das keine Version ist, oder es auf ein solches Objekt zeigen lassen, =
ohne\n"
+"Sie k=C3=B6nnen keine Remote-Referenz aktualisieren, die auf ein Obje=
kt zeigt,\n"
+"das kein Commit ist, oder es auf ein solches Objekt zeigen lassen, oh=
ne\n"
 "die Option '--force' zu verwenden.\n"
=20
 #: builtin/push.c:294
@@ -7633,7 +7634,7 @@ msgstr "Fehler beim Versenden einiger Referenzen =
nach '%s'"
 #: builtin/push.c:331
 #, c-format
 msgid "bad repository '%s'"
-msgstr "ung=C3=BCltiges Projektarchiv '%s'"
+msgstr "ung=C3=BCltiges Repository '%s'"
=20
 #: builtin/push.c:332
 msgid ""
@@ -7647,13 +7648,13 @@ msgid ""
 "\n"
 "    git push <name>\n"
 msgstr ""
-"Kein Ziel zum Versenden konfiguriert.\n"
+"Kein Ziel f=C3=BCr \"push\" konfiguriert.\n"
 "Entweder spezifizieren Sie die URL von der Kommandozeile oder konfigu=
rieren "
-"ein externes Projektarchiv unter Benutzung von\n"
+"ein Remote-Repository unter Benutzung von\n"
 "\n"
 "    git remote add <Name> <URL>\n"
 "\n"
-"und versenden dann unter Benutzung dieses Namens\n"
+"und f=C3=BChren \"push\" dann unter Benutzung dieses Namens aus\n"
 "\n"
 "    git push <Name>\n"
=20
@@ -7664,7 +7665,7 @@ msgstr "Die Optionen --all und --tags sind inkomp=
atibel."
 #: builtin/push.c:348
 msgid "--all can't be combined with refspecs"
 msgstr ""
-"Die Option --all kann nicht mit Referenzspezifikationen kombiniert we=
rden."
+"Die Option --all kann nicht mit Refspecs kombiniert werden."
=20
 #: builtin/push.c:353
 msgid "--mirror and --tags are incompatible"
@@ -7673,7 +7674,7 @@ msgstr "Die Optionen --mirror und --tags sind ink=
ompatibel."
 #: builtin/push.c:354
 msgid "--mirror can't be combined with refspecs"
 msgstr ""
-"Die Option --mirror kann nicht mit Referenzspezifikationen kombiniert=
 werden."
+"Die Option --mirror kann nicht mit Refspecs kombiniert werden."
=20
 #: builtin/push.c:359
 msgid "--all and --mirror are incompatible"
@@ -7681,7 +7682,7 @@ msgstr "Die Optionen --all und --mirror sind inko=
mpatibel."
=20
 #: builtin/push.c:419
 msgid "repository"
-msgstr "Projektarchiv"
+msgstr "Repository"
=20
 #: builtin/push.c:420
 msgid "push all refs"
@@ -7698,7 +7699,7 @@ msgstr "l=C3=B6scht Referenzen"
 #: builtin/push.c:424
 msgid "push tags (can't be used with --all or --mirror)"
 msgstr ""
-"versendet Markierungen (kann nicht mit --all oder --mirror verwendet =
werden)"
+"versendet Tags (kann nicht mit --all oder --mirror verwendet werden)"
=20
 #: builtin/push.c:427
 msgid "force updates"
@@ -7710,7 +7711,7 @@ msgstr ""
=20
 #: builtin/push.c:429
 msgid "control recursive pushing of submodules"
-msgstr "steuert rekursives Versenden von Unterprojekten"
+msgstr "steuert rekursiven \"push\" von Submodulen"
=20
 #: builtin/push.c:431
 msgid "use thin pack"
@@ -7722,7 +7723,7 @@ msgstr "'receive pack' Programm"
=20
 #: builtin/push.c:434
 msgid "set upstream for git pull/status"
-msgstr "setzt externes Projektarchiv f=C3=BCr \"git pull/status\""
+msgstr "setzt Upstream f=C3=BCr \"git pull/status\""
=20
 #: builtin/push.c:437
 msgid "prune locally removed refs"
@@ -7734,7 +7735,7 @@ msgstr "umgeht \"pre-push hook\""
=20
 #: builtin/push.c:440
 msgid "push missing but relevant tags"
-msgstr "versendet fehlende, aber relevante Markierungen"
+msgstr "versendet fehlende, aber relevante Tags"
=20
 #: builtin/push.c:450
 msgid "--delete is incompatible with --all, --mirror and --tags"
@@ -7752,35 +7753,34 @@ msgid ""
 msgstr ""
 "git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<Prefix>] "
 "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-check=
out] [--"
-"index-output=3D<Datei>] (--empty | <Versionsreferenz1> [<Versionsrefe=
renz2> "
-"[<Versionsreferenz3>]])"
+"index-output=3D<Datei>] (--empty | <Commit-Referenz1> [<Commit-Refere=
nz2> "
+"[<Commit-Referenz3>]])"
=20
 #: builtin/read-tree.c:108
 msgid "write resulting index to <file>"
-msgstr "schreibt resultierende Bereitstellung nach <Datei>"
+msgstr "schreibt resultierende Staging-Area nach <Datei>"
=20
 #: builtin/read-tree.c:111
 msgid "only empty the index"
-msgstr "leert die Bereitstellung"
+msgstr "leert die Staging-Area"
=20
 #: builtin/read-tree.c:113
 msgid "Merging"
-msgstr "Zusammenf=C3=BChrung"
+msgstr "Merge"
=20
 #: builtin/read-tree.c:115
 msgid "perform a merge in addition to a read"
-msgstr "f=C3=BChrt eine Zusammenf=C3=BChrung zus=C3=A4tzlich zum Lesen=
 aus"
+msgstr "f=C3=BChrt einen Merge zus=C3=A4tzlich zum Lesen aus"
=20
 #: builtin/read-tree.c:117
 msgid "3-way merge if no file level merging required"
 msgstr ""
-"3-Wege-Zusammenf=C3=BChrung, wenn keine Zusammenf=C3=BChrung auf Date=
iebene "
-"erforderlich ist"
+"3-Wege-Merge, wenn kein Merge auf Dateiebene erforderlich ist"
=20
 #: builtin/read-tree.c:119
 msgid "3-way merge in presence of adds and removes"
 msgstr ""
-"3-Wege-Zusammenf=C3=BChrung bei Vorhandensein von hinzugef=C3=BCgten/=
entfernten Zeilen"
+"3-Wege-Merge bei Vorhandensein von hinzugef=C3=BCgten/entfernten Zeil=
en"
=20
 #: builtin/read-tree.c:121
 msgid "same as -m, but discard unmerged entries"
@@ -7792,11 +7792,11 @@ msgstr "<Unterverzeichnis>/"
=20
 #: builtin/read-tree.c:123
 msgid "read the tree into the index under <subdirectory>/"
-msgstr "liest den Baum in die Bereitstellung unter <Unterverzeichnis>/=
"
+msgstr "liest das Verzeichnis in die Staging-Area unter <Unterverzeich=
nis>/"
=20
 #: builtin/read-tree.c:126
 msgid "update working tree with merge result"
-msgstr "aktualisiert Arbeitsbaum mit Ergebnis der Zusammenf=C3=BChrung=
"
+msgstr "aktualisiert Arbeitsverzeichnis mit dem Ergebnis des Merges"
=20
 #: builtin/read-tree.c:128
 msgid "gitignore"
@@ -7808,11 +7808,11 @@ msgstr "erlaubt explizit ignorierte Dateien zu =
=C3=BCberschreiben"
=20
 #: builtin/read-tree.c:132
 msgid "don't check the working tree after merging"
-msgstr "pr=C3=BCft nicht den Arbeitsbaum nach der Zusammenf=C3=BChrung=
"
+msgstr "pr=C3=BCft nicht das Arbeitsverzeichnis nach dem Merge"
=20
 #: builtin/read-tree.c:133
 msgid "don't update the index or the work tree"
-msgstr "aktualisiert weder die Bereitstellung, noch den Arbeitsbaum"
+msgstr "aktualisiert weder die Staging-Area, noch das Arbeitsverzeichn=
is"
=20
 #: builtin/read-tree.c:135
 msgid "skip applying sparse checkout filter"
@@ -7831,7 +7831,7 @@ msgid ""
 "git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [-=
-"
 "mirror=3D<fetch|push>] <name> <url>"
 msgstr ""
-"git remote add [-t <Zweig>] [-m <master>] [-f] [--tags|--no-tags] [--=
"
+"git remote add [-t <Branch>] [-m <master>] [-f] [--tags|--no-tags] [-=
-"
 "mirror=3D<fetch|push>] <Name> <URL>"
=20
 #: builtin/remote.c:13 builtin/remote.c:32
@@ -7844,7 +7844,7 @@ msgstr "git remote remove <Name>"
=20
 #: builtin/remote.c:15 builtin/remote.c:42
 msgid "git remote set-head <name> (-a | -d | <branch>)"
-msgstr "git remote set-head <Name> (-a | -d | <Zweig>)"
+msgstr "git remote set-head <Name> (-a | -d | <Branch>)"
=20
 #: builtin/remote.c:16
 msgid "git remote [-v | --verbose] show [-n] <name>"
@@ -7858,12 +7858,11 @@ msgstr "git remote prune [-n | --dry-run] <Name=
>"
 msgid ""
 "git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote=
>)...]"
 msgstr ""
-"git remote [-v | --verbose] update [-p | --prune] [(<Gruppe> | "
-"<externesProjektarchiv>)...]"
+"git remote [-v | --verbose] update [-p | --prune] [(<Gruppe> | <Remot=
e>)...]"
=20
 #: builtin/remote.c:19
 msgid "git remote set-branches [--add] <name> <branch>..."
-msgstr "git remote set-branches [--add] <Name> <Zweig>..."
+msgstr "git remote set-branches [--add] <Name> <Branch>..."
=20
 #: builtin/remote.c:20 builtin/remote.c:68
 msgid "git remote set-url [--push] <name> <newurl> [<oldurl>]"
@@ -7883,11 +7882,11 @@ msgstr "git remote add [<Optionen>] <Name> <URL=
>"
=20
 #: builtin/remote.c:47
 msgid "git remote set-branches <name> <branch>..."
-msgstr "git remote set-branches <Name> <Zweig>..."
+msgstr "git remote set-branches <Name> <Branch>..."
=20
 #: builtin/remote.c:48
 msgid "git remote set-branches --add <name> <branch>..."
-msgstr "git remote set-branches --add <Name> <Zweig>..."
+msgstr "git remote set-branches --add <Name> <Branch>..."
=20
 #: builtin/remote.c:53
 msgid "git remote show [<options>] <name>"
@@ -7899,7 +7898,7 @@ msgstr "git remote prune [<Optionen>] <Name>"
=20
 #: builtin/remote.c:63
 msgid "git remote update [<options>] [<group> | <remote>]..."
-msgstr "git remote update [<Optionen>] [<Gruppe> | <externesProjektarc=
hiv>]..."
+msgstr "git remote update [<Optionen>] [<Gruppe> | <externesRepository=
>]..."
=20
 #: builtin/remote.c:98
 #, c-format
@@ -7921,11 +7920,11 @@ msgstr "unbekanntes Argument f=C3=BCr Option --=
mirror: %s"
=20
 #: builtin/remote.c:163
 msgid "fetch the remote branches"
-msgstr "fordert die externen Zweige an"
+msgstr "fordert die Remote-Branches an"
=20
 #: builtin/remote.c:165
 msgid "import all tags and associated objects when fetching"
-msgstr "importiert alle Markierungen und verbundene Objekte beim Anfor=
dern"
+msgstr "importiert alle Tags und verbundene Objekte beim Anfordern"
=20
 #: builtin/remote.c:168
 msgid "or do not fetch any tag at all (--no-tags)"
@@ -7933,11 +7932,11 @@ msgstr "oder fordere gar keine Zweige an (--no-=
tags)"
=20
 #: builtin/remote.c:170
 msgid "branch(es) to track"
-msgstr "Zweige zur =C3=9Cbernahme"
+msgstr "Branch(es) zur =C3=9Cbernahme"
=20
 #: builtin/remote.c:171
 msgid "master branch"
-msgstr "Hauptzweig"
+msgstr "Hauptbranch"
=20
 #: builtin/remote.c:172
 msgid "push|fetch"
@@ -7946,34 +7945,34 @@ msgstr "push|fetch"
 #: builtin/remote.c:173
 msgid "set up remote as a mirror to push to or fetch from"
 msgstr ""
-"Aufsetzen des Fernarchivs als Spiegelarchiv zum Versenden und Anforde=
rn"
+"Aufsetzen des Remote-Repositories als Spiegel-Repository f=C3=BCr \"p=
ush\" und \"fetch\""
=20
 #: builtin/remote.c:185
 msgid "specifying a master branch makes no sense with --mirror"
 msgstr ""
-"Die Option --mirror kann nicht mit der Angabe eines Hauptzweiges verw=
endet "
+"Die Option --mirror kann nicht mit der Angabe eines Hauptbranches ver=
wendet "
 "werden."
=20
 #: builtin/remote.c:187
 msgid "specifying branches to track makes sense only with fetch mirror=
s"
 msgstr ""
-"Die Angabe von zu folgenden Zweigen kann nur mit dem Anfordern von "
+"Die Angabe von zu folgenden Branches kann nur mit dem Anfordern von "
 "Spiegelarchiven verwendet werden."
=20
 #: builtin/remote.c:195 builtin/remote.c:646
 #, c-format
 msgid "remote %s already exists."
-msgstr "externes Projektarchiv %s existiert bereits"
+msgstr "externes Repository %s existiert bereits"
=20
 #: builtin/remote.c:199 builtin/remote.c:650
 #, c-format
 msgid "'%s' is not a valid remote name"
-msgstr "'%s' ist kein g=C3=BCltiger Name f=C3=BCr ein externes Projekt=
archiv"
+msgstr "'%s' ist kein g=C3=BCltiger Name f=C3=BCr ein Remote-Repositor=
y"
=20
 #: builtin/remote.c:243
 #, c-format
 msgid "Could not setup master '%s'"
-msgstr "Konnte symbolische Referenz f=C3=BCr Hauptzweig von '%s' nicht=
 einrichten"
+msgstr "Konnte symbolische Referenz f=C3=BCr Hauptbranch von '%s' nich=
t einrichten"
=20
 #: builtin/remote.c:299
 #, c-format
@@ -7983,7 +7982,7 @@ msgstr "mehr als ein %s"
 #: builtin/remote.c:339
 #, c-format
 msgid "Could not get fetch map for refspec %s"
-msgstr "Konnte Abholungszuordnung f=C3=BCr Referenzspezifikation %s ni=
cht bekommen"
+msgstr "Konnte Fetch-Map f=C3=BCr Refspec %s nicht bekommen"
=20
 #: builtin/remote.c:440 builtin/remote.c:448
 msgid "(matching)"
@@ -8001,7 +8000,7 @@ msgstr "Konnte '%s' nicht an '%s' anh=C3=A4ngen."
 #: builtin/remote.c:639 builtin/remote.c:792 builtin/remote.c:890
 #, c-format
 msgid "No such remote: %s"
-msgstr "Kein solches externes Archiv: %s"
+msgstr "Kein solches Remote-Repository: %s"
=20
 #: builtin/remote.c:656
 #, c-format
@@ -8020,8 +8019,8 @@ msgid ""
 "\t%s\n"
 "\tPlease update the configuration manually if necessary."
 msgstr ""
-"Keine Aktualisierung der nicht standardm=C3=A4=C3=9Figen Referenzspez=
ifikation zum "
-"Abholen\n"
+"Keine Aktualisierung der nicht standardm=C3=A4=C3=9Figen Refspec f=C3=
=BCr "
+"\"fetch\"\n"
 "\t%s\n"
 "\tBitte aktualisieren Sie, falls notwendig, die Konfiguration manuell=
=2E"
=20
@@ -8048,7 +8047,7 @@ msgstr "Konnte '%s' nicht erstellen"
 #: builtin/remote.c:764
 #, c-format
 msgid "Could not remove branch %s"
-msgstr "Konnte Zweig %s nicht l=C3=B6schen"
+msgstr "Konnte Branch %s nicht l=C3=B6schen"
=20
 #: builtin/remote.c:834
 msgid ""
@@ -8058,18 +8057,18 @@ msgid_plural ""
 "Note: Some branches outside the refs/remotes/ hierarchy were not remo=
ved;\n"
 "to delete them, use:"
 msgstr[0] ""
-"Hinweis: Ein Zweig au=C3=9Ferhalb der /refs/remotes/ Hierachie wurde =
nicht "
+"Hinweis: Ein Branch au=C3=9Ferhalb der /refs/remotes/ Hierachie wurde=
 nicht "
 "gel=C3=B6scht;\n"
 "um diesen zu l=C3=B6schen, benutzen Sie:"
 msgstr[1] ""
-"Hinweis: Einige Zweige au=C3=9Fer der /refs/remotes/ Hierarchie wurde=
n nicht "
+"Hinweis: Einige Branches au=C3=9Fer der /refs/remotes/ Hierarchie wur=
den nicht "
 "entfernt;\n"
 "um diese zu entfernen, benutzen Sie:"
=20
 #: builtin/remote.c:943
 #, c-format
 msgid " new (next fetch will store in remotes/%s)"
-msgstr " neu (wird bei n=C3=A4chster Abholung in remotes/%s gespeicher=
t)"
+msgstr " neu (wird bei n=C3=A4chstem \"fetch\" in remotes/%s gespeiche=
rt)"
=20
 #: builtin/remote.c:946
 msgid " tracked"
@@ -8086,30 +8085,31 @@ msgstr " ???"
 #: builtin/remote.c:991
 #, c-format
 msgid "invalid branch.%s.merge; cannot rebase onto > 1 branch"
-msgstr "ung=C3=BCltiges branch.%s.merge; kann nicht auf > 1 Zweig neu =
aufbauen"
+msgstr "ung=C3=BCltiges branch.%s.merge; kann Rebase nicht auf > 1 Bra=
nch "
+"ausf=C3=BChren"
=20
 #: builtin/remote.c:998
 #, c-format
 msgid "rebases onto remote %s"
-msgstr "baut neu auf externen Zweig %s auf"
+msgstr "baut neu auf Remote-Branch %s auf"
=20
 #: builtin/remote.c:1001
 #, c-format
 msgid " merges with remote %s"
-msgstr " f=C3=BChrt mit externem Zweig %s zusammen"
+msgstr " f=C3=BChrt mit Remote-Branch %s zusammen"
=20
 #: builtin/remote.c:1002
 msgid "    and with remote"
-msgstr "    und mit externem Zweig"
+msgstr "    und mit Remote-Branch"
=20
 #: builtin/remote.c:1004
 #, c-format
 msgid "merges with remote %s"
-msgstr "f=C3=BChrt mit externem Zweig %s zusammen"
+msgstr "f=C3=BChrt mit Remote-Branch %s zusammen"
=20
 #: builtin/remote.c:1005
 msgid "   and with remote"
-msgstr "   und mit externem Zweig"
+msgstr "   und mit Remote-Branch"
=20
 #: builtin/remote.c:1051
 msgid "create"
@@ -8153,12 +8153,12 @@ msgstr "    %-*s versendet nach %s"
=20
 #: builtin/remote.c:1091
 msgid "do not query remotes"
-msgstr "keine Abfrage von Fernarchiven"
+msgstr "keine Abfrage von Remote-Repositories"
=20
 #: builtin/remote.c:1118
 #, c-format
 msgid "* remote %s"
-msgstr "* externes Projektarchiv %s"
+msgstr "* Remote-Repository %s"
=20
 #: builtin/remote.c:1119
 #, c-format
@@ -8177,22 +8177,22 @@ msgstr "  URL zum Versenden: %s"
 #: builtin/remote.c:1133 builtin/remote.c:1135 builtin/remote.c:1137
 #, c-format
 msgid "  HEAD branch: %s"
-msgstr "  Hauptzweig: %s"
+msgstr "  Hauptbranch: %s"
=20
 #: builtin/remote.c:1139
 #, c-format
 msgid ""
 "  HEAD branch (remote HEAD is ambiguous, may be one of the following)=
:\n"
 msgstr ""
-"  Hauptzweig (externer Hauptzweig ist mehrdeutig, k=C3=B6nnte einer d=
er folgenden "
+"  Hauptbranch (externer HEAD ist mehrdeutig, k=C3=B6nnte einer der fo=
lgenden "
 "sein):\n"
=20
 #: builtin/remote.c:1151
 #, c-format
 msgid "  Remote branch:%s"
 msgid_plural "  Remote branches:%s"
-msgstr[0] "  externer Zweig:%s"
-msgstr[1] "  externe Zweige:%s"
+msgstr[0] "  Remote-Branch:%s"
+msgstr[1] "  Remote-Branches:%s"
=20
 #: builtin/remote.c:1154 builtin/remote.c:1181
 msgid " (status not queried)"
@@ -8201,8 +8201,8 @@ msgstr " (Zustand nicht abgefragt)"
 #: builtin/remote.c:1163
 msgid "  Local branch configured for 'git pull':"
 msgid_plural "  Local branches configured for 'git pull':"
-msgstr[0] "  Lokaler Zweig konfiguriert f=C3=BCr 'git pull':"
-msgstr[1] "  Lokale Zweige konfiguriert f=C3=BCr 'git pull':"
+msgstr[0] "  Lokaler Branch konfiguriert f=C3=BCr 'git pull':"
+msgstr[1] "  Lokale Branches konfiguriert f=C3=BCr 'git pull':"
=20
 #: builtin/remote.c:1171
 msgid "  Local refs will be mirrored by 'git push'"
@@ -8217,7 +8217,7 @@ msgstr[1] "  Lokale Referenzen konfiguriert f=C3=BC=
r 'git push'%s:"
=20
 #: builtin/remote.c:1199
 msgid "set refs/remotes/<name>/HEAD according to remote"
-msgstr "setzt refs/remotes/<Name>/HEAD gem=C3=A4=C3=9F dem Fernarchiv"
+msgstr "setzt refs/remotes/<Name>/HEAD gem=C3=A4=C3=9F dem Remote-Repo=
sitory"
=20
 #: builtin/remote.c:1201
 msgid "delete refs/remotes/<name>/HEAD"
@@ -8225,13 +8225,12 @@ msgstr "entfernt refs/remotes/<Name>/HEAD"
=20
 #: builtin/remote.c:1216
 msgid "Cannot determine remote HEAD"
-msgstr "Kann Hauptzweig des externen Projektarchivs nicht bestimmen"
+msgstr "Kann HEAD des Remote-Repositories nicht bestimmen"
=20
 #: builtin/remote.c:1218
 msgid "Multiple remote HEAD branches. Please choose one explicitly wit=
h:"
 msgstr ""
-"Mehrere Hauptzweige im externen Projektarchiv. Bitte w=C3=A4hlen Sie =
explizit "
-"einen aus mit:"
+"Mehrere Hauptbranches im Remote-Repository. Bitte w=C3=A4hlen Sie exp=
lizit einen aus mit:"
=20
 #: builtin/remote.c:1228
 #, c-format
@@ -8261,7 +8260,7 @@ msgstr " %s wurde unreferenziert!"
 #: builtin/remote.c:1281
 #, c-format
 msgid "Pruning %s"
-msgstr "entferne veraltete Zweige von %s"
+msgstr "entferne veraltete Branches von %s"
=20
 #: builtin/remote.c:1282
 #, c-format
@@ -8271,33 +8270,33 @@ msgstr "URL: %s"
 #: builtin/remote.c:1295
 #, c-format
 msgid " * [would prune] %s"
-msgstr " * [w=C3=BCrde veralteten Zweig entfernen] %s"
+msgstr " * [w=C3=BCrde veralteten Branch entfernen] %s"
=20
 #: builtin/remote.c:1298
 #, c-format
 msgid " * [pruned] %s"
-msgstr "* [veralteten Zweig entfernt] %s"
+msgstr "* [veralteten Branch entfernt] %s"
=20
 #: builtin/remote.c:1321
 msgid "prune remotes after fetching"
-msgstr "entfernt veraltete Zweige im Fernarchiv nach dem Abholen"
+msgstr "entfernt veraltete Branches im Remote-Repository nach \"fetch\=
""
=20
 #: builtin/remote.c:1387 builtin/remote.c:1461
 #, c-format
 msgid "No such remote '%s'"
-msgstr "Kein solches externes Projektarchiv '%s'"
+msgstr "Kein solches Remote-Repository '%s'"
=20
 #: builtin/remote.c:1407
 msgid "add branch"
-msgstr "f=C3=BCgt Zweig hinzu"
+msgstr "f=C3=BCgt Branch hinzu"
=20
 #: builtin/remote.c:1414
 msgid "no remote specified"
-msgstr "kein externes Projektarchiv angegeben"
+msgstr "kein Remote-Repository angegeben"
=20
 #: builtin/remote.c:1436
 msgid "manipulate push URLs"
-msgstr "manipuliert URLs zum Versenden"
+msgstr "manipuliert URLs f=C3=BCr \"push\""
=20
 #: builtin/remote.c:1438
 msgid "add URL"
@@ -8324,7 +8323,7 @@ msgstr "Keine solche URL gefunden: %s"
=20
 #: builtin/remote.c:1497
 msgid "Will not delete all non-push URLs"
-msgstr "Werde keine URLs entfernen, die nicht f=C3=BCr den Versand bes=
timmt sind"
+msgstr "Werde keine URLs entfernen, die nicht f=C3=BCr \"push\" bestim=
mt sind"
=20
 #: builtin/remote.c:1569
 msgid "be verbose; must be placed before a subcommand"
@@ -8360,21 +8359,21 @@ msgstr "git rerere [clean | forget path... | st=
atus | remaining | diff | gc]"
=20
 #: builtin/rerere.c:56
 msgid "register clean resolutions in index"
-msgstr "registriert saubere Aufl=C3=B6sungen in der Bereitstellung"
+msgstr "registriert saubere Aufl=C3=B6sungen in der Staging-Area"
=20
 #: builtin/reset.c:25
 msgid ""
 "git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commi=
t>]"
 msgstr ""
-"git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<Versi=
on>]"
+"git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<Commi=
t>]"
=20
 #: builtin/reset.c:26
 msgid "git reset [-q] <tree-ish> [--] <paths>..."
-msgstr "git reset [-q] <Versionsreferenz> [--] <Pfade>..."
+msgstr "git reset [-q] <Commit-Referenz> [--] <Pfade>..."
=20
 #: builtin/reset.c:27
 msgid "git reset --patch [<tree-ish>] [--] [<paths>...]"
-msgstr "git reset --patch [<Versionsreferenz>] [--] [<Pfade>...]"
+msgstr "git reset --patch [<Commit-Referenz>] [--] [<Pfade>...]"
=20
 #: builtin/reset.c:33
 msgid "mixed"
@@ -8398,28 +8397,27 @@ msgstr "keep"
=20
 #: builtin/reset.c:73
 msgid "You do not have a valid HEAD."
-msgstr "Sie haben keine g=C3=BCltige Zweigspitze (HEAD)."
+msgstr "Sie haben keinen g=C3=BCltigen HEAD."
=20
 #: builtin/reset.c:75
 msgid "Failed to find tree of HEAD."
-msgstr "Fehler beim Finden des Baumes der Zweigspitze (HEAD)."
+msgstr "Fehler beim Finden des \"Tree\"-Objektes von HEAD."
=20
 #: builtin/reset.c:81
 #, c-format
 msgid "Failed to find tree of %s."
-msgstr "Fehler beim Finden des Baumes von %s."
+msgstr "Fehler beim Finden des \"Tree\"-Objektes von %s."
=20
 #: builtin/reset.c:98
 #, c-format
 msgid "HEAD is now at %s"
-msgstr "Zweigspitze (HEAD) ist jetzt bei %s"
+msgstr "HEAD ist jetzt bei %s"
=20
 #: builtin/reset.c:169
 #, c-format
 msgid "Cannot do a %s reset in the middle of a merge."
 msgstr ""
-"Kann keine '%s' Zur=C3=BCcksetzung durchf=C3=BChren, w=C3=A4hrend ein=
e Zusammenf=C3=BChrung im "
-"Gange ist."
+"Kann keinen '%s'-Reset durchf=C3=BChren, w=C3=A4hrend ein Merge im Ga=
nge ist."
=20
 #: builtin/reset.c:248
 msgid "be quiet, only report errors"
@@ -8427,19 +8425,19 @@ msgstr "weniger Ausgaben, meldet nur Fehler"
=20
 #: builtin/reset.c:250
 msgid "reset HEAD and index"
-msgstr "setzt Zweigspitze (HEAD) und Bereitstellung neu"
+msgstr "setzt HEAD und Staging-Area um"
=20
 #: builtin/reset.c:251
 msgid "reset only HEAD"
-msgstr "setzt nur Zweigspitze (HEAD) neu"
+msgstr "setzt nur HEAD um"
=20
 #: builtin/reset.c:253 builtin/reset.c:255
 msgid "reset HEAD, index and working tree"
-msgstr "setzt Zweigspitze (HEAD), Bereitstellung und Arbeitsbaum neu"
+msgstr "setzt HEAD, Staging-Area und Arbeitsverzeichnis um"
=20
 #: builtin/reset.c:257
 msgid "reset HEAD but keep local changes"
-msgstr "setzt Zweigspitze (HEAD) neu, beh=C3=A4lt aber lokale =C3=84nd=
erungen"
+msgstr "setzt HEAD um, beh=C3=A4lt aber lokale =C3=84nderungen"
=20
 #: builtin/reset.c:275
 #, c-format
@@ -8454,7 +8452,7 @@ msgstr "Konnte Objekt '%s' nicht parsen."
 #: builtin/reset.c:283
 #, c-format
 msgid "Failed to resolve '%s' as a valid tree."
-msgstr "Konnte '%s' nicht als g=C3=BCltigen Baum aufl=C3=B6sen."
+msgstr "Konnte '%s' nicht als g=C3=BCltiges \"Tree\"-Objekt aufl=C3=B6=
sen."
=20
 #: builtin/reset.c:292
 msgid "--patch is incompatible with --{hard,mixed,soft}"
@@ -8469,25 +8467,25 @@ msgstr ""
 #: builtin/reset.c:303
 #, c-format
 msgid "Cannot do %s reset with paths."
-msgstr "Eine '%s' Zur=C3=BCcksetzung mit Pfaden ist nicht m=C3=B6glich=
=2E"
+msgstr "Ein '%s'-Reset mit Pfaden ist nicht m=C3=B6glich."
=20
 #: builtin/reset.c:313
 #, c-format
 msgid "%s reset is not allowed in a bare repository"
-msgstr "'%s' Zur=C3=BCcksetzung ist in einem blo=C3=9Fen Projektarchiv=
 nicht erlaubt"
+msgstr "'%s'-Reset ist in einem Bare-Repository nicht erlaubt"
=20
 #: builtin/reset.c:333
 #, c-format
 msgid "Could not reset index file to revision '%s'."
-msgstr "Konnte Bereitstellungsdatei nicht zu Revision '%s' setzen."
+msgstr "Konnte Staging-Area-Datei nicht zu Commit '%s' setzen."
=20
 #: builtin/reset.c:339
 msgid "Unstaged changes after reset:"
-msgstr "Nicht bereitgestellte =C3=84nderungen nach Zur=C3=BCcksetzung:=
"
+msgstr "Nicht zum Commit vorgemerkte =C3=84nderungen nach Zur=C3=BCcks=
etzung:"
=20
 #: builtin/reset.c:344
 msgid "Could not write new index file."
-msgstr "Konnte neue Bereitstellungsdatei nicht schreiben."
+msgstr "Konnte neue Staging-Area-Datei nicht schreiben."
=20
 #: builtin/rev-parse.c:339
 msgid "git rev-parse --parseopt [options] -- [<args>...]"
@@ -8518,7 +8516,7 @@ msgstr ""
=20
 #: builtin/revert.c:22
 msgid "git revert [options] <commit-ish>..."
-msgstr "git revert [Optionen] <Versionsangabe>..."
+msgstr "git revert [Optionen] <Commit-Angabe>..."
=20
 #: builtin/revert.c:23
 msgid "git revert <subcommand>"
@@ -8526,7 +8524,7 @@ msgstr "git revert <Unterkommando>"
=20
 #: builtin/revert.c:28
 msgid "git cherry-pick [options] <commit-ish>..."
-msgstr "git cherry-pick [Optionen] <Versionsangabe>..."
+msgstr "git cherry-pick [Optionen] <Commit-Angabe>..."
=20
 #: builtin/revert.c:29
 msgid "git cherry-pick <subcommand>"
@@ -8551,11 +8549,11 @@ msgstr "bricht \"revert\" oder \"cherry-pick\" =
Ablauf ab"
=20
 #: builtin/revert.c:106
 msgid "don't automatically commit"
-msgstr "tr=C3=A4gt nicht automatisch ein"
+msgstr "committet nicht automatisch"
=20
 #: builtin/revert.c:107
 msgid "edit the commit message"
-msgstr "Bearbeitung der Versionsbeschreibung"
+msgstr "Bearbeitung der Commit-Beschreibung"
=20
 #: builtin/revert.c:110
 msgid "parent number"
@@ -8563,7 +8561,7 @@ msgstr "Nummer des Elternteils"
=20
 #: builtin/revert.c:112
 msgid "merge strategy"
-msgstr "Zusammenf=C3=BChrungsstrategie"
+msgstr "Merge-Strategie"
=20
 #: builtin/revert.c:113
 msgid "option"
@@ -8571,11 +8569,11 @@ msgstr "Option"
=20
 #: builtin/revert.c:114
 msgid "option for merge strategy"
-msgstr "Option f=C3=BCr Zusammenf=C3=BChrungsstrategie"
+msgstr "Option f=C3=BCr Merge-Strategie"
=20
 #: builtin/revert.c:125
 msgid "append commit name"
-msgstr "h=C3=A4ngt Versionsnamen an"
+msgstr "h=C3=A4ngt Commit-Namen an"
=20
 #: builtin/revert.c:126
 msgid "allow fast-forward"
@@ -8583,15 +8581,15 @@ msgstr "erlaubt Vorspulen"
=20
 #: builtin/revert.c:127
 msgid "preserve initially empty commits"
-msgstr "erh=C3=A4lt urspr=C3=BCngliche, leere Versionen"
+msgstr "erh=C3=A4lt urspr=C3=BCngliche, leere Commits"
=20
 #: builtin/revert.c:128
 msgid "allow commits with empty messages"
-msgstr "erlaubt Version mit leerer Beschreibung"
+msgstr "erlaubt Commits mit leerer Beschreibung"
=20
 #: builtin/revert.c:129
 msgid "keep redundant, empty commits"
-msgstr "beh=C3=A4lt redundante, leere Versionen"
+msgstr "beh=C3=A4lt redundante, leere Commits"
=20
 #: builtin/revert.c:133
 msgid "program error"
@@ -8615,7 +8613,7 @@ msgid ""
 "submodule '%s' (or one of its nested submodules) uses a .git director=
y\n"
 "(use 'rm -rf' if you really want to remove it including all of its hi=
story)"
 msgstr ""
-"Unterprojekt '%s' (oder ein geschachteltes Unterprojekt hiervon) verw=
endet\n"
+"Submodul '%s' (oder ein geschachteltes Submodul hiervon) verwendet\n"
 "ein .git-Verzeichnis (benutzen Sie 'rm -rf' wenn Sie dieses wirklich =
"
 "mitsamt\n"
 "seiner Historie l=C3=B6schen m=C3=B6chten)"
@@ -8626,8 +8624,8 @@ msgid ""
 "'%s' has staged content different from both the file and the HEAD\n"
 "(use -f to force removal)"
 msgstr ""
-"'%s' hat bereitgestellten Inhalt unterschiedlich zu der Datei und der=
\n"
-"Zweigspitze (HEAD) (benutzen Sie -f um die Entfernung zu erzwingen)"
+"'%s' hat bereitgestellten Inhalt unterschiedlich zu der Datei und\n"
+"HEAD (benutzen Sie -f um die Entfernung zu erzwingen)"
=20
 #: builtin/rm.c:180
 #, c-format
@@ -8635,7 +8633,7 @@ msgid ""
 "'%s' has changes staged in the index\n"
 "(use --cached to keep the file, or -f to force removal)"
 msgstr ""
-"'%s' hat =C3=84nderungen in der Bereitstellung\n"
+"'%s' hat zum Commit vorgemerkte =C3=84nderungen\n"
 "(benutzen Sie --cached um die Datei zu behalten, oder -f um die Entfe=
rnung "
 "zu erzwingen)"
=20
@@ -8655,7 +8653,7 @@ msgstr "listet keine gel=C3=B6schten Dateien auf"
=20
 #: builtin/rm.c:208
 msgid "only remove from the index"
-msgstr "entfernt nur aus der Bereitstellung"
+msgstr "entfernt nur aus der Staging-Area"
=20
 #: builtin/rm.c:209
 msgid "override the up-to-date check"
@@ -8690,11 +8688,11 @@ msgstr "fehlender Autor: %s"
=20
 #: builtin/shortlog.c:227
 msgid "sort output according to the number of commits per author"
-msgstr "sortiert die Ausgabe entsprechend der Anzahl von Versionen pro=
 Autor"
+msgstr "sortiert die Ausgabe entsprechend der Anzahl von Commits pro A=
utor"
=20
 #: builtin/shortlog.c:229
 msgid "Suppress commit descriptions, only provides commit count"
-msgstr "Unterdr=C3=BCckt Versionsbeschreibungen, liefert nur Anzahl de=
r Versionen"
+msgstr "Unterdr=C3=BCckt Commit-Beschreibungen, liefert nur Anzahl der=
 Commits"
=20
 #: builtin/shortlog.c:231
 msgid "Show the email address of each author"
@@ -8726,19 +8724,19 @@ msgstr "git show-branch (-g|--reflog)[=3D<n>[,<=
Basis>]] [--list] [<Referenz>]"
=20
 #: builtin/show-branch.c:650
 msgid "show remote-tracking and local branches"
-msgstr "zeigt externe =C3=9Cbernahmezweige und lokale Zweige an"
+msgstr "zeigt Remote-Tracking und lokale Branches an"
=20
 #: builtin/show-branch.c:652
 msgid "show remote-tracking branches"
-msgstr "zeigt externe =C3=9Cbernahmezweige an"
+msgstr "zeigt Remote-Tracking-Branches an"
=20
 #: builtin/show-branch.c:654
 msgid "color '*!+-' corresponding to the branch"
-msgstr "f=C3=A4rbt '*!+-' entsprechend des Zweiges ein"
+msgstr "f=C3=A4rbt '*!+-' entsprechend des Branches ein"
=20
 #: builtin/show-branch.c:656
 msgid "show <n> more commits after the common ancestor"
-msgstr "zeigt <n> weitere Versionen nach dem gemeinsamen Vorfahren"
+msgstr "zeigt <n> weitere Commits nach dem gemeinsamen Vorg=C3=A4nger-=
Commit"
=20
 #: builtin/show-branch.c:658
 msgid "synonym to more=3D-1"
@@ -8750,15 +8748,15 @@ msgstr "unterdr=C3=BCckt Namen"
=20
 #: builtin/show-branch.c:661
 msgid "include the current branch"
-msgstr "bezieht den aktuellen Zweig ein"
+msgstr "bezieht den aktuellen Branch ein"
=20
 #: builtin/show-branch.c:663
 msgid "name commits with their object names"
-msgstr "benennt Versionen nach ihren Objektnamen"
+msgstr "benennt Commits nach ihren Objektnamen"
=20
 #: builtin/show-branch.c:665
 msgid "show possible merge bases"
-msgstr "zeigt m=C3=B6gliche Basen f=C3=BCr Zusammenf=C3=BChrung"
+msgstr "zeigt m=C3=B6gliche Merge-Basen an"
=20
 #: builtin/show-branch.c:667
 msgid "show refs unreachable from any other ref"
@@ -8766,20 +8764,20 @@ msgstr "zeigt Referenzen die unerreichbar von a=
llen anderen Referenzen sind"
=20
 #: builtin/show-branch.c:669
 msgid "show commits in topological order"
-msgstr "zeigt Versionen in topologischer Ordnung"
+msgstr "zeigt Commits in topologischer Ordnung"
=20
 #: builtin/show-branch.c:671
 msgid "show only commits not on the first branch"
-msgstr "zeigt nur Versionen, die sich nicht im ersten Zweig befinden"
+msgstr "zeigt nur Commits, die sich nicht im ersten Branch befinden"
=20
 #: builtin/show-branch.c:673
 msgid "show merges reachable from only one tip"
 msgstr ""
-"zeigt Zusammenf=C3=BChrungen, die nur von einer Zweigspitze aus errei=
chbar sind"
+"zeigt Merges, die nur von einem Branch aus erreichbar sind"
=20
 #: builtin/show-branch.c:675
 msgid "show commits where no parent comes before its children"
-msgstr "zeigt Versionen, wo kein Elternteil vor seinem Kind kommt"
+msgstr "zeigt Commits, wo kein Eltern-Commit vor seinem Kind-Commit ko=
mmt"
=20
 #: builtin/show-branch.c:677
 msgid "<n>[,<base>]"
@@ -8788,7 +8786,7 @@ msgstr "<n>[,<Basis>]"
 #: builtin/show-branch.c:678
 msgid "show <n> most recent ref-log entries starting at base"
 msgstr ""
-"zeigt die <n> j=C3=BCngsten Eintr=C3=A4ge im Referenzprotokoll beginn=
end an der Basis"
+"zeigt die <n> j=C3=BCngsten Eintr=C3=A4ge im Reflog beginnend an der =
Basis"
=20
 #: builtin/show-ref.c:10
 msgid ""
@@ -8804,11 +8802,11 @@ msgstr "git show-ref --exclude-existing[=3DMust=
er] < ref-list"
=20
 #: builtin/show-ref.c:165
 msgid "only show tags (can be combined with heads)"
-msgstr "zeigt nur Markierungen (kann mit \"heads\" kombiniert werden)"
+msgstr "zeigt nur Tags (kann mit \"heads\" kombiniert werden)"
=20
 #: builtin/show-ref.c:166
 msgid "only show heads (can be combined with tags)"
-msgstr "zeigt nur Zweigspitzen (kann mit \"tags\" kombiniert werden)"
+msgstr "zeigt nur Branches (kann mit \"tags\" kombiniert werden)"
=20
 #: builtin/show-ref.c:167
 msgid "stricter reference checking, requires exact ref path"
@@ -8816,11 +8814,11 @@ msgstr "strengere Referenzpr=C3=BCfung, erforde=
rt exakten Referenzpfad"
=20
 #: builtin/show-ref.c:170 builtin/show-ref.c:172
 msgid "show the HEAD reference"
-msgstr "zeigt Referenz der Zweigspitze (HEAD)"
+msgstr "zeigt Referenz von HEAD"
=20
 #: builtin/show-ref.c:174
 msgid "dereference tags into object IDs"
-msgstr "dereferenziert Markierungen in Objekt-Identifikationen"
+msgstr "dereferenziert Tags in Objekt-Identifikationen"
=20
 #: builtin/show-ref.c:176
 msgid "only show SHA1 hash using <n> digits"
@@ -8835,7 +8833,7 @@ msgstr ""
 msgid "show refs from stdin that aren't in local repository"
 msgstr ""
 "zeigt Referenzen von der Standard-Eingabe, die sich nicht im lokalen =
"
-"Projektarchiv befinden, an"
+"Repository befinden, an"
=20
 #: builtin/symbolic-ref.c:7
 msgid "git symbolic-ref [options] name [ref]"
@@ -8871,23 +8869,23 @@ msgid ""
 "git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<hea=
d>]"
 msgstr ""
 "git tag [-a|-s|-u <Schl=C3=BCssel-id>] [-f] [-m <Nachricht>|-F <Datei=
>] "
-"<Markierungsname> [<Zweig>]"
+"<Tagname> [<Branch>]"
=20
 #: builtin/tag.c:23
 msgid "git tag -d <tagname>..."
-msgstr "git tag -d <Markierungsname>..."
+msgstr "git tag -d <Tagname>..."
=20
 #: builtin/tag.c:24
 msgid ""
 "git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>] \=
n"
 "\t\t[<pattern>...]"
 msgstr ""
-"git tag -l [-n[<Nummer>]] [--contains <Version>] [--points-at <Objekt=
>] \n"
+"git tag -l [-n[<Nummer>]] [--contains <Commit>] [--points-at <Objekt>=
] \n"
 "\t\t[<Muster>...]"
=20
 #: builtin/tag.c:26
 msgid "git tag -v <tagname>..."
-msgstr "git tag -v <Markierungsname>..."
+msgstr "git tag -v <Tagname>..."
=20
 #: builtin/tag.c:60
 #, c-format
@@ -8897,22 +8895,22 @@ msgstr "fehlerhaftes Objekt bei '%s'"
 #: builtin/tag.c:207
 #, c-format
 msgid "tag name too long: %.*s..."
-msgstr "Markierungsname zu lang: %.*s..."
+msgstr "Tagname zu lang: %.*s..."
=20
 #: builtin/tag.c:212
 #, c-format
 msgid "tag '%s' not found."
-msgstr "Markierung '%s' nicht gefunden."
+msgstr "Tag '%s' nicht gefunden."
=20
 #: builtin/tag.c:227
 #, c-format
 msgid "Deleted tag '%s' (was %s)\n"
-msgstr "Gel=C3=B6schte Markierung '%s' (war %s)\n"
+msgstr "Tag '%s' gel=C3=B6scht (war %s)\n"
=20
 #: builtin/tag.c:239
 #, c-format
 msgid "could not verify the tag '%s'"
-msgstr "Konnte Markierung '%s' nicht verifizieren"
+msgstr "Konnte Tag '%s' nicht verifizieren"
=20
 #: builtin/tag.c:249
 #, c-format
@@ -8922,7 +8920,7 @@ msgid ""
 "Lines starting with '%c' will be ignored.\n"
 msgstr ""
 "\n"
-"Geben Sie eine Markierungsbeschreibung ein.\n"
+"Geben Sie eine Tag-Beschreibung ein.\n"
 "Zeilen, die mit '%c' beginnen, werden ignoriert.\n"
=20
 #: builtin/tag.c:253
@@ -8934,17 +8932,17 @@ msgid ""
 "want to.\n"
 msgstr ""
 "\n"
-"Geben Sie eine Markierungsbeschreibung ein.\n"
+"Geben Sie eine Tag-Beschreibung ein.\n"
 "Zeilen, die mit '%c' beginnen, werden behalten; Sie d=C3=BCrfen diese=
\n"
 "selbst entfernen wenn Sie m=C3=B6chten.\n"
=20
 #: builtin/tag.c:292
 msgid "unable to sign the tag"
-msgstr "konnte Markierung nicht signieren"
+msgstr "konnte Tag nicht signieren"
=20
 #: builtin/tag.c:294
 msgid "unable to write tag file"
-msgstr "konnte Markierungsdatei nicht schreiben"
+msgstr "konnte Tag-Datei nicht schreiben"
=20
 #: builtin/tag.c:319
 msgid "bad object type."
@@ -8952,16 +8950,16 @@ msgstr "ung=C3=BCltiger Objekt-Typ"
=20
 #: builtin/tag.c:332
 msgid "tag header too big."
-msgstr "Markierungskopf zu gro=C3=9F."
+msgstr "Tag-Kopf zu gro=C3=9F."
=20
 #: builtin/tag.c:368
 msgid "no tag message?"
-msgstr "keine Markierungsbeschreibung?"
+msgstr "keine Tag-Beschreibung?"
=20
 #: builtin/tag.c:374
 #, c-format
 msgid "The tag message has been left in %s\n"
-msgstr "Die Markierungsbeschreibung wurde gelassen in %s\n"
+msgstr "Die Tag-Beschreibung wurde gelassen in %s\n"
=20
 #: builtin/tag.c:423
 msgid "switch 'points-at' requires an object"
@@ -8974,59 +8972,59 @@ msgstr "fehlerhafter Objekt-Name '%s'"
=20
 #: builtin/tag.c:445
 msgid "list tag names"
-msgstr "listet Markierungsnamen auf"
+msgstr "listet Tagnamen auf"
=20
 #: builtin/tag.c:447
 msgid "print <n> lines of each tag message"
-msgstr "zeigt <n> Zeilen jeder Markierungsbeschreibung"
+msgstr "zeigt <n> Zeilen jeder Tag-Beschreibung"
=20
 #: builtin/tag.c:449
 msgid "delete tags"
-msgstr "l=C3=B6scht Markierungen"
+msgstr "l=C3=B6scht Tags"
=20
 #: builtin/tag.c:450
 msgid "verify tags"
-msgstr "=C3=BCberpr=C3=BCft Markierungen"
+msgstr "=C3=BCberpr=C3=BCft Tags"
=20
 #: builtin/tag.c:452
 msgid "Tag creation options"
-msgstr "Optionen f=C3=BCr Erstellung von Markierungen"
+msgstr "Optionen f=C3=BCr Erstellung von Tags"
=20
 #: builtin/tag.c:454
 msgid "annotated tag, needs a message"
-msgstr "annotierte Markierung, ben=C3=B6tigt eine Beschreibung"
+msgstr "annotierter Tag, ben=C3=B6tigt eine Beschreibung"
=20
 #: builtin/tag.c:456
 msgid "tag message"
-msgstr "Markierungsbeschreibung"
+msgstr "Tag-Beschreibung"
=20
 #: builtin/tag.c:458
 msgid "annotated and GPG-signed tag"
-msgstr "annotierte und GPG-signierte Markierung"
+msgstr "annotierter und GPG-signierter Tag"
=20
 #: builtin/tag.c:462
 msgid "use another key to sign the tag"
-msgstr "verwendet einen anderen Schl=C3=BCssel um die Markierung zu si=
gnieren"
+msgstr "verwendet einen anderen Schl=C3=BCssel um den Tag zu signieren=
"
=20
 #: builtin/tag.c:463
 msgid "replace the tag if exists"
-msgstr "ersetzt die Markierung, wenn sie existiert"
+msgstr "ersetzt den Tag, wenn er existiert"
=20
 #: builtin/tag.c:464
 msgid "show tag list in columns"
-msgstr "zeigt Liste der Markierungen in Spalten"
+msgstr "zeigt Liste der Tags in Spalten"
=20
 #: builtin/tag.c:466
 msgid "Tag listing options"
-msgstr "Optionen f=C3=BCr Auflistung der Markierungen"
+msgstr "Optionen f=C3=BCr Auflistung der Tags"
=20
 #: builtin/tag.c:469
 msgid "print only tags that contain the commit"
-msgstr "gibt nur Markierungen aus, die diese Version beinhalten"
+msgstr "gibt nur Tags aus, die diesen Commit beinhalten"
=20
 #: builtin/tag.c:475
 msgid "print only tags of the object"
-msgstr "gibt nur Markierungen von dem Objekt aus"
+msgstr "gibt nur Tags von dem Objekt aus"
=20
 #: builtin/tag.c:504
 msgid "--column and -n are incompatible"
@@ -9055,12 +9053,12 @@ msgstr "zu viele Parameter"
 #: builtin/tag.c:559
 #, c-format
 msgid "'%s' is not a valid tag name."
-msgstr "'%s' ist kein g=C3=BCltiger Markierungsname."
+msgstr "'%s' ist kein g=C3=BCltiger Tagname."
=20
 #: builtin/tag.c:564
 #, c-format
 msgid "tag '%s' already exists"
-msgstr "Markierung '%s' existiert bereits"
+msgstr "Tag '%s' existiert bereits"
=20
 #: builtin/tag.c:582
 #, c-format
@@ -9075,7 +9073,7 @@ msgstr "%s: kann Referenz nicht aktualisieren"
 #: builtin/tag.c:586
 #, c-format
 msgid "Updated tag '%s' (was %s)\n"
-msgstr "Aktualisierte Markierung '%s' (war %s)\n"
+msgstr "Tag '%s' aktualisiert (war %s)\n"
=20
 #: builtin/update-index.c:401
 msgid "git update-index [options] [--] [<file>...]"
@@ -9084,12 +9082,12 @@ msgstr "git update-index [Optionen] [--] [<Date=
i>...]"
 #: builtin/update-index.c:718
 msgid "continue refresh even when index needs update"
 msgstr ""
-"Aktualisierung fortsetzen, auch wenn die Bereitstellung aktualisiert =
werden "
+"Aktualisierung fortsetzen, auch wenn die Staging-Area aktualisiert we=
rden "
 "muss"
=20
 #: builtin/update-index.c:721
 msgid "refresh: ignore submodules"
-msgstr "Aktualisierung: ignoriert Unterprojekte"
+msgstr "Aktualisierung: ignoriert Submodule"
=20
 #: builtin/update-index.c:724
 msgid "do not ignore new files"
@@ -9101,12 +9099,12 @@ msgstr "l=C3=A4sst Dateien Verzeichnisse ersetz=
en, und umgedreht"
=20
 #: builtin/update-index.c:728
 msgid "notice files missing from worktree"
-msgstr "beachtet fehlende Dateien im Arbeitsbaum"
+msgstr "beachtet fehlende Dateien im Arbeitsverzeichnis"
=20
 #: builtin/update-index.c:730
 msgid "refresh even if index contains unmerged entries"
 msgstr ""
-"aktualisiert, auch wenn die Bereitstellung nicht zusammengef=C3=BChrt=
e Eintr=C3=A4ge "
+"aktualisiert, auch wenn die Staging-Area nicht zusammengef=C3=BChrte =
Eintr=C3=A4ge "
 "beinhaltet"
=20
 #: builtin/update-index.c:733
@@ -9123,7 +9121,7 @@ msgstr "<Modus> <Objekt> <Pfad>"
=20
 #: builtin/update-index.c:742
 msgid "add the specified entry to the index"
-msgstr "stellt den angegebenen Eintrag zur Eintragung bereit"
+msgstr "merkt den angegebenen Eintrag zum Commit vor"
=20
 #: builtin/update-index.c:746
 msgid "(+/-)x"
@@ -9152,12 +9150,12 @@ msgstr "l=C3=B6scht \"skip-worktree\"-Bit"
 #: builtin/update-index.c:763
 msgid "add to index only; do not add content to object database"
 msgstr ""
-"f=C3=BCgt nur der Bereitstellung hinzu; Inhalt wird nicht der Objekt-=
Datenbank "
-"hinzugef=C3=BCgt"
+"merkt die =C3=84nderungen nur zum Commit vor; Inhalt wird nicht der "
+"Objekt-Datenbank hinzugef=C3=BCgt"
=20
 #: builtin/update-index.c:765
 msgid "remove named paths even if present in worktree"
-msgstr "l=C3=B6scht benannte Pfade, auch wenn sie sich im Arbeitsbaum =
befinden"
+msgstr "l=C3=B6scht benannte Pfade, auch wenn sie sich im Arbeitsverze=
ichnis befinden"
=20
 #: builtin/update-index.c:767
 msgid "with --stdin: input lines are terminated by null bytes"
@@ -9169,7 +9167,7 @@ msgstr "liest Liste der zu aktualisierenden Pfade=
 von der Standard-Eingabe"
=20
 #: builtin/update-index.c:773
 msgid "add entries from standard input to the index"
-msgstr "f=C3=BCgt Eintr=C3=A4ge von der Standard-Eingabe der Bereitste=
llung hinzu"
+msgstr "merkt Eintr=C3=A4ge von der Standard-Eingabe zum Commit vor"
=20
 #: builtin/update-index.c:777
 msgid "repopulate stages #2 and #3 for the listed paths"
@@ -9179,11 +9177,11 @@ msgstr ""
 #: builtin/update-index.c:781
 msgid "only update entries that differ from HEAD"
 msgstr ""
-"aktualisiert nur Eintr=C3=A4ge, die unterschiedlich zur Zweigspitze (=
HEAD) sind"
+"aktualisiert nur Eintr=C3=A4ge, die unterschiedlich zu HEAD sind"
=20
 #: builtin/update-index.c:785
 msgid "ignore files missing from worktree"
-msgstr "ignoriert fehlende Dateien im Arbeitsbaum"
+msgstr "ignoriert fehlende Dateien im Arbeitsverzeichnis"
=20
 #: builtin/update-index.c:788
 msgid "report actions to standard output"
@@ -9195,7 +9193,7 @@ msgstr "(f=C3=BCr Fremdprogramme) keine gespeiche=
rten, nicht aufgel=C3=B6ste Konflikte"
=20
 #: builtin/update-index.c:794
 msgid "write index in this format"
-msgstr "schreibt Bereitstellungsdatei in diesem Format"
+msgstr "schreibt Staging-Area-Datei in diesem Format"
=20
 #: builtin/update-ref.c:7
 msgid "git update-ref [options] -d <refname> [<oldval>]"
@@ -9235,11 +9233,11 @@ msgstr "zeigt nur Statistiken"
=20
 #: builtin/verify-tag.c:17
 msgid "git verify-tag [-v|--verbose] <tag>..."
-msgstr "git verify-tag [-v|--verbose] <Markierung>..."
+msgstr "git verify-tag [-v|--verbose] <Tag>..."
=20
 #: builtin/verify-tag.c:73
 msgid "print tag contents"
-msgstr "gibt Markierungsinhalte aus"
+msgstr "gibt Tag-Inhalte aus"
=20
 #: builtin/write-tree.c:13
 msgid "git write-tree [--missing-ok] [--prefix=3D<prefix>/]"
@@ -9251,7 +9249,7 @@ msgstr "<Prefix>/"
=20
 #: builtin/write-tree.c:27
 msgid "write tree object for a subdirectory <prefix>"
-msgstr "schreibt das Baumobjekt f=C3=BCr ein Unterverzeichnis <Prefix>=
"
+msgstr "schreibt das \"Tree\"-Objekt f=C3=BCr ein Unterverzeichnis <Pr=
efix>"
=20
 #: builtin/write-tree.c:30
 msgid "only useful for debugging"
@@ -9286,7 +9284,7 @@ msgstr "benutze <n> Ziffern zur Anzeige von SHA-1=
s"
=20
 #: common-cmds.h:8
 msgid "Add file contents to the index"
-msgstr "stellt Dateiinhalte zur Eintragung bereit"
+msgstr "merkt Dateiinhalte zum Commit vor"
=20
 #: common-cmds.h:9
 msgid "Find by binary search the change that introduced a bug"
@@ -9295,27 +9293,27 @@ msgstr ""
=20
 #: common-cmds.h:10
 msgid "List, create, or delete branches"
-msgstr "Zeigt an, erstellt oder entfernt Zweige"
+msgstr "Zeigt an, erstellt oder entfernt Branches"
=20
 #: common-cmds.h:11
 msgid "Checkout a branch or paths to the working tree"
-msgstr "Checkt Zweige oder Pfade im Arbeitszweig aus"
+msgstr "Checkt Branches oder Pfade im Arbeitsverzeichnis aus"
=20
 #: common-cmds.h:12
 msgid "Clone a repository into a new directory"
-msgstr "Klont ein Projektarchiv in einem neuen Verzeichnis"
+msgstr "Klont ein Repository in einem neuen Verzeichnis"
=20
 #: common-cmds.h:13
 msgid "Record changes to the repository"
-msgstr "Tr=C3=A4gt =C3=84nderungen in das Projektarchiv ein"
+msgstr "Tr=C3=A4gt =C3=84nderungen in das Repository ein"
=20
 #: common-cmds.h:14
 msgid "Show changes between commits, commit and working tree, etc"
-msgstr "Zeigt =C3=84nderungen zwischen Versionen, Version und Arbeitsz=
weig, etc. an"
+msgstr "Zeigt =C3=84nderungen zwischen Commits, Commit und Arbeitsverz=
eichnis, etc. an"
=20
 #: common-cmds.h:15
 msgid "Download objects and refs from another repository"
-msgstr "L=C3=A4dt Objekte und Referenzen von einem anderen Projektarch=
iv herunter"
+msgstr "L=C3=A4dt Objekte und Referenzen von einem anderen Repository =
herunter"
=20
 #: common-cmds.h:16
 msgid "Print lines matching a pattern"
@@ -9324,11 +9322,11 @@ msgstr "Stellt Zeilen dar, die einem Muster ent=
sprechen"
 #: common-cmds.h:17
 msgid "Create an empty Git repository or reinitialize an existing one"
 msgstr ""
-"Erstellt ein leeres Git-Projektarchiv oder initialisiert ein bestehen=
des neu"
+"Erstellt ein leeres Git-Repository oder initialisiert ein bestehendes=
 neu"
=20
 #: common-cmds.h:18
 msgid "Show commit logs"
-msgstr "Zeigt Versionshistorie an"
+msgstr "Zeigt Commit-Historie an"
=20
 #: common-cmds.h:19
 msgid "Join two or more development histories together"
@@ -9337,30 +9335,30 @@ msgstr "F=C3=BChrt zwei oder mehr Entwicklungsz=
weige zusammen"
 #: common-cmds.h:20
 msgid "Move or rename a file, a directory, or a symlink"
 msgstr ""
-"Verschiebt oder benennt eine Datei, ein Verzeichnis, oder eine symbol=
ische "
-"Verkn=C3=BCpfung um"
+"Verschiebt oder benennt eine Datei, ein Verzeichnis, oder einen symbo=
lischen "
+"Verweis um"
=20
 #: common-cmds.h:21
 msgid "Fetch from and merge with another repository or a local branch"
 msgstr ""
-"Fordert Objekte von einem externen Projektarchiv an und f=C3=BChrt si=
e mit einem "
-"anderen Projektarchiv oder einem lokalen Zweig zusammen"
+"Fordert Objekte von einem externen Repository an und f=C3=BChrt sie m=
it einem "
+"anderen Repository oder einem lokalen Branch zusammen"
=20
 #: common-cmds.h:22
 msgid "Update remote refs along with associated objects"
-msgstr "Aktualisiert externe Referenzen mitsamt den verbundenen Objekt=
en"
+msgstr "Aktualisiert Remote-Referenzen mitsamt den verbundenen Objekte=
n"
=20
 #: common-cmds.h:23
 msgid "Forward-port local commits to the updated upstream head"
-msgstr "Baut lokale Versionen auf einem aktuellerem externen Zweig neu=
 auf"
+msgstr "Baut lokale Commits auf einem aktuellerem Upstream-Branch neu =
auf"
=20
 #: common-cmds.h:24
 msgid "Reset current HEAD to the specified state"
-msgstr "Setzt die aktuelle Zweigspitze (HEAD) zu einem spezifizierten =
Zustand"
+msgstr "Setzt aktuellen HEAD zu einem spezifizierten Zustand"
=20
 #: common-cmds.h:25
 msgid "Remove files from the working tree and from the index"
-msgstr "L=C3=B6scht Dateien im Arbeitszweig und von der Bereitstellung=
"
+msgstr "L=C3=B6scht Dateien im Arbeitsverzeichnis und von der Staging-=
Area"
=20
 #: common-cmds.h:26
 msgid "Show various types of objects"
@@ -9368,25 +9366,24 @@ msgstr "Zeigt verschiedene Arten von Objekten a=
n"
=20
 #: common-cmds.h:27
 msgid "Show the working tree status"
-msgstr "Zeigt den Zustand des Arbeitszweiges an"
+msgstr "Zeigt den Zustand des Arbeitsverzeichnisses an"
=20
 #: common-cmds.h:28
 msgid "Create, list, delete or verify a tag object signed with GPG"
 msgstr ""
 "Erzeugt, listet auf, l=C3=B6scht oder verifiziert ein mit GPG signier=
tes "
-"Markierungsobjekt"
+"Tag-Objekt"
=20
 #: git-am.sh:50
 msgid "You need to set your committer info first"
-msgstr "Sie m=C3=BCssen zuerst die Informationen des Eintragenden setz=
en."
+msgstr "Sie m=C3=BCssen zuerst die Informationen zum Commit-Ersteller =
setzen."
=20
 #: git-am.sh:95
 msgid ""
 "You seem to have moved HEAD since the last 'am' failure.\n"
 "Not rewinding to ORIG_HEAD"
 msgstr ""
-"Sie scheinen seit dem letzten gescheiterten 'am' die Zweigspitze (HEA=
D)\n"
-"ge=C3=A4ndert zu haben.\n"
+"Sie scheinen seit dem letzten gescheiterten 'am' HEAD ge=C3=A4ndert z=
u haben.\n"
 "Keine Zur=C3=BCcksetzung zu ORIG_HEAD."
=20
 #: git-am.sh:105
@@ -9399,23 +9396,23 @@ msgstr ""
 "Wenn Sie das Problem gel=C3=B6st haben, f=C3=BChren Sie \"$cmdline --=
resolved\" aus.\n"
 "Falls Sie diesen Patch auslassen m=C3=B6chten, f=C3=BChren Sie stattd=
essen\n"
 "\"$cmdline --skip\" aus.\n"
-"Um den urspr=C3=BCnglichen Zweig wiederherzustellen und die Anwendung=
 der\n"
+"Um den urspr=C3=BCnglichen Branch wiederherzustellen und die Anwendun=
g der\n"
 "Patches abzubrechen, f=C3=BChren Sie \"$cmdline --abort\" aus."
=20
 #: git-am.sh:121
 msgid "Cannot fall back to three-way merge."
-msgstr "Kann nicht zu 3-Wege-Zusammenf=C3=BChrung zur=C3=BCckfallen."
+msgstr "Kann nicht zu 3-Wege-Merge zur=C3=BCckfallen."
=20
 #: git-am.sh:137
 msgid "Repository lacks necessary blobs to fall back on 3-way merge."
 msgstr ""
-"Dem Projektarchiv fehlen notwendige Blobs um auf eine 3-Wege-Zusammen=
f=C3=BChrung "
+"Dem Repository fehlen notwendige Blobs um auf einen 3-Wege-Merge "
 "zur=C3=BCckzufallen."
=20
 #: git-am.sh:139
 msgid "Using index info to reconstruct a base tree..."
 msgstr ""
-"Verwende Informationen aus der Bereitstellung um einen Basisbaum "
+"Verwende Informationen aus der Staging-Area um einen Basisverzeichnis=
 "
 "nachzustellen"
=20
 #: git-am.sh:154
@@ -9428,11 +9425,11 @@ msgstr ""
=20
 #: git-am.sh:163
 msgid "Falling back to patching base and 3-way merge..."
-msgstr "Falle zur=C3=BCck zum Patchen der Basis und der 3-Wege-Zusamme=
nf=C3=BChrung..."
+msgstr "Falle zur=C3=BCck zum Patchen der Basis und des 3-Wege-Merges.=
=2E."
=20
 #: git-am.sh:179
 msgid "Failed to merge in the changes."
-msgstr "Zusammenf=C3=BChrung der =C3=84nderungen fehlgeschlagen"
+msgstr "Merge der =C3=84nderungen fehlgeschlagen"
=20
 #: git-am.sh:274
 msgid "Only one StGIT patch series can be applied at once"
@@ -9459,7 +9456,7 @@ msgstr ""
 #, sh-format
 msgid "previous rebase directory $dotest still exists but mbox given."
 msgstr ""
-"Vorheriges Verzeichnis des Neuaufbaus $dotest existiert noch, aber mb=
ox "
+"Vorheriges Rebase-Verzeichnis $dotest existiert noch, aber mbox "
 "gegeben."
=20
 #: git-am.sh:482
@@ -9474,7 +9471,7 @@ msgstr "Es ist keine Aufl=C3=B6sung im Gange, es =
wird nicht fortgesetzt."
 #, sh-format
 msgid "Dirty index: cannot apply patches (dirty: $files)"
 msgstr ""
-"Unsaubere Bereitstellung: kann Patches nicht anwenden (unsauber: $fil=
es)"
+"Unsaubere Staging-Area: kann Patches nicht anwenden (unsauber: $files=
)"
=20
 #: git-am.sh:679
 #, sh-format
@@ -9486,7 +9483,7 @@ msgstr ""
 "Patch ist leer. Wurde er falsch aufgeteilt?\n"
 "Wenn Sie diesen Patch auslassen m=C3=B6chten, f=C3=BChren Sie stattde=
ssen\n"
 "\"$cmdline --skip\" aus.\n"
-"Um den urspr=C3=BCnglichen Zweig wiederherzustellen und die Anwendung=
 der "
+"Um den urspr=C3=BCnglichen Branch wiederherzustellen und die Anwendun=
g der "
 "Patches\n"
 "abzubrechen, f=C3=BChren Sie \"$cmdline --abort\" aus."
=20
@@ -9502,7 +9499,7 @@ msgstr ""
=20
 #: git-am.sh:757
 msgid "Commit Body is:"
-msgstr "Beschreibung der Eintragung ist:"
+msgstr "Commit-Beschreibung ist:"
=20
 #. TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
 #. in your translation. The program will only accept English
@@ -9532,7 +9529,7 @@ msgid ""
 "You still have unmerged paths in your index\n"
 "did you forget to use 'git add'?"
 msgstr ""
-"Sie haben immer noch nicht zusammengef=C3=BChrte Pfade in der Bereits=
tellung.\n"
+"Sie haben immer noch nicht zusammengef=C3=BChrte Pfade in der Staging=
-Area.\n"
 "Haben Sie vergessen 'git add' zu benutzen?"
=20
 #: git-am.sh:845
@@ -9580,7 +9577,7 @@ msgstr "'$arg' scheint keine g=C3=BCltige Revisio=
n zu sein"
=20
 #: git-bisect.sh:117
 msgid "Bad HEAD - I need a HEAD"
-msgstr "Ung=C3=BCltige Zweigspitze (HEAD) - Zweigspitze (HEAD) wird be=
n=C3=B6tigt"
+msgstr "Ung=C3=BCltiger HEAD - HEAD wird ben=C3=B6tigt"
=20
 #: git-bisect.sh:130
 #, sh-format
@@ -9588,15 +9585,15 @@ msgid ""
 "Checking out '$start_head' failed. Try 'git bisect reset <validbranch=
>'."
 msgstr ""
 "Auschecken von '$start_head' fehlgeschlagen. Versuchen Sie 'git bisec=
t reset "
-"<gueltigerzweig>'."
+"<gueltigerbranch>'."
=20
 #: git-bisect.sh:140
 msgid "won't bisect on seeked tree"
-msgstr "bin=C3=A4re Suche auf gesuchtem Zweig nicht m=C3=B6glich"
+msgstr "bin=C3=A4re Suche auf gesuchtem Branch nicht m=C3=B6glich"
=20
 #: git-bisect.sh:144
 msgid "Bad HEAD - strange symbolic ref"
-msgstr "Ung=C3=BCltige Zweigspitze (HEAD) - merkw=C3=BCrdige symbolisc=
he Referenz"
+msgstr "Ung=C3=BCltiger HEAD - merkw=C3=BCrdige symbolische Referenz"
=20
 #: git-bisect.sh:189
 #, sh-format
@@ -9625,7 +9622,7 @@ msgstr "'git bisect bad' kann nur ein Argument en=
tgegennehmen."
 #. this is less optimum.
 #: git-bisect.sh:273
 msgid "Warning: bisecting only with a bad commit."
-msgstr "Warnung: bin=C3=A4re Suche nur mit einer fehlerhaften Version"
+msgstr "Warnung: bin=C3=A4re Suche nur mit einem fehlerhaften Commit"
=20
 #. TRANSLATORS: Make sure to include [Y] and [n] in your
 #. translation. The program will only accept English input
@@ -9660,7 +9657,7 @@ msgstr "keine bin=C3=A4re Suche im Gange"
 #: git-bisect.sh:370
 #, sh-format
 msgid "'$invalid' is not a valid commit"
-msgstr "'$invalid' ist keine g=C3=BCltige Version"
+msgstr "'$invalid' ist kein g=C3=BCltiger Commit"
=20
 #: git-bisect.sh:379
 #, sh-format
@@ -9668,8 +9665,8 @@ msgid ""
 "Could not check out original HEAD '$branch'.\n"
 "Try 'git bisect reset <commit>'."
 msgstr ""
-"Konnte die urspr=C3=BCngliche Zweigspitze (HEAD) '$branch' nicht ausc=
hecken.\n"
-"Versuchen Sie 'git bisect reset <Version>'."
+"Konnte den urspr=C3=BCnglichen HEAD '$branch' nicht auschecken.\n"
+"Versuchen Sie 'git bisect reset <Commit>'."
=20
 #: git-bisect.sh:406
 msgid "No logfile given"
@@ -9722,10 +9719,9 @@ msgid ""
 "as appropriate to mark resolution, or use 'git commit -a'."
 msgstr ""
 "\"pull\" ist nicht m=C3=B6glich, weil Sie nicht zusammengef=C3=BChrte=
 Dateien haben.\n"
-"Bitte korrigieren Sie dies im Arbeitsbaum und benutzen Sie dann 'git =
add/rm "
-"<Datei>'\n"
-"um die Aufl=C3=B6sung entsprechend zu markieren, oder benutzen Sie 'g=
it commit -"
-"a'."
+"Bitte korrigieren Sie dies im Arbeitsverzeichnis und benutzen Sie dan=
n \n"
+"'git add/rm <Datei>' um die Aufl=C3=B6sung entsprechend zu markieren,=
 oder\n"
+"benutzen Sie 'git commit -a'."
=20
 #: git-pull.sh:25
 msgid "Pull is not possible because you have unmerged files."
@@ -9735,8 +9731,8 @@ msgstr ""
 #: git-pull.sh:203
 msgid "updating an unborn branch with changes added to the index"
 msgstr ""
-"Aktualisiere eine ungeborenen Zweig mit =C3=84nderungen, die zur Bere=
itstellung "
-"hinzugef=C3=BCgt wurden"
+"Aktualisiere eine ungeborenen Branch mit =C3=84nderungen, die zum Com=
mit "
+"vorgemerkt sind"
=20
 #. The fetch involved updating the current branch.
 #. The working tree and the index file is still based on the
@@ -9749,16 +9745,16 @@ msgid ""
 "Warning: fast-forwarding your working tree from\n"
 "Warning: commit $orig_head."
 msgstr ""
-"Warnung: Die Anforderung aktualisierte die Spitze des aktuellen Zweig=
es.\n"
-"Warnung: Spule Ihren Arbeitszweig von Version $orig_head vor."
+"Warnung: \"fetch\" aktualisierte die Spitze des aktuellen Branches.\n=
"
+"Warnung: Spule Ihr Arbeitsverzeichnis von Commit $orig_head vor."
=20
 #: git-pull.sh:260
 msgid "Cannot merge multiple branches into empty head"
-msgstr "Kann nicht mehrere Zweige in einen ungeborenen Zweig zusammenf=
=C3=BChren"
+msgstr "Kann nicht mehrere Branches in einen ungeborenen Branch zusamm=
enf=C3=BChren"
=20
 #: git-pull.sh:264
 msgid "Cannot rebase onto multiple branches"
-msgstr "kann nicht auf mehrere Zweige neu aufbauen"
+msgstr "kann Rebase nicht auf mehrere Branches ausf=C3=BChren"
=20
 #: git-rebase.sh:53
 msgid ""
@@ -9771,17 +9767,16 @@ msgstr ""
 "aus.\n"
 "Falls Sie diesen Patch auslassen m=C3=B6chten, f=C3=BChren Sie stattd=
essen \"git "
 "rebase --skip\" aus.\n"
-"Um den urspr=C3=BCnglichen Zweig wiederherzustellen und den Neuaufbau=
 "
-"abzubrechen,\n"
+"Um den urspr=C3=BCnglichen Branch wiederherzustellen und den Rebase a=
bzubrechen,\n"
 "f=C3=BChren Sie \"git rebase --abort\" aus."
=20
 #: git-rebase.sh:160
 msgid "The pre-rebase hook refused to rebase."
-msgstr "Der \"pre-rebase hook\" hat den Neuaufbau zur=C3=BCckgewiesen.=
"
+msgstr "Der \"pre-rebase hook\" hat den Rebase zur=C3=BCckgewiesen."
=20
 #: git-rebase.sh:165
 msgid "It looks like git-am is in progress. Cannot rebase."
-msgstr "\"git-am\" scheint im Gange zu sein. Kann nicht neu aufbauen."
+msgstr "\"git-am\" scheint im Gange zu sein. Kann Rebase nicht durchf=C3=
=BChren."
=20
 #: git-rebase.sh:296
 msgid "The --exec option must be used with the --interactive option"
@@ -9789,24 +9784,24 @@ msgstr "Die Option --exec muss mit --interactiv=
e verwendet werden."
=20
 #: git-rebase.sh:301
 msgid "No rebase in progress?"
-msgstr "Kein Neuaufbau im Gange?"
+msgstr "Kein Rebase im Gange?"
=20
 #: git-rebase.sh:312
 msgid "The --edit-todo action can only be used during interactive reba=
se."
 msgstr ""
-"Die --edit-todo Aktion kann nur w=C3=A4hrend eines interaktiven Neuau=
fbaus "
+"Die --edit-todo Aktion kann nur w=C3=A4hrend eines interaktiven Rebas=
e "
 "verwendet werden."
=20
 #: git-rebase.sh:319
 msgid "Cannot read HEAD"
-msgstr "Kann Zweigspitze (HEAD) nicht lesen"
+msgstr "Kann HEAD nicht lesen"
=20
 #: git-rebase.sh:322
 msgid ""
 "You must edit all merge conflicts and then\n"
 "mark them as resolved using git add"
 msgstr ""
-"Sie m=C3=BCssen alle Zusammenf=C3=BChrungskonflikte editieren und die=
se dann\n"
+"Sie m=C3=BCssen alle Merge-Konflikte editieren und diese dann\n"
 "mittels \"git add\" als aufgel=C3=B6st markieren"
=20
 #: git-rebase.sh:340
@@ -9827,7 +9822,7 @@ msgid ""
 "valuable there."
 msgstr ""
 "Es sieht so aus, als ob es das Verzeichnis $state_dir_base bereits gi=
bt\n"
-"und es k=C3=B6nnte ein anderer Neuaufbau im Gange sein. Wenn das der =
=46all ist,\n"
+"und es k=C3=B6nnte ein anderer Rebase im Gange sein. Wenn das der Fal=
l ist,\n"
 "probieren Sie bitte\n"
 "\t$cmd_live_rebase\n"
 "Wenn das nicht der Fall ist, probieren Sie bitte\n"
@@ -9838,42 +9833,42 @@ msgstr ""
 #: git-rebase.sh:404
 #, sh-format
 msgid "invalid upstream $upstream_name"
-msgstr "ung=C3=BCltiger =C3=9Cbernahmezweig $upstream_name"
+msgstr "ung=C3=BCltiger Upstream-Branch $upstream_name"
=20
 #: git-rebase.sh:428
 #, sh-format
 msgid "$onto_name: there are more than one merge bases"
-msgstr "$onto_name: es gibt mehr als eine Zusammenf=C3=BChrungsbasis"
+msgstr "$onto_name: es gibt mehr als eine Merge-Basis"
=20
 #: git-rebase.sh:431 git-rebase.sh:435
 #, sh-format
 msgid "$onto_name: there is no merge base"
-msgstr "$onto_name: es gibt keine Zusammenf=C3=BChrungsbasis"
+msgstr "$onto_name: es gibt keine Merge-Basis"
=20
 #: git-rebase.sh:440
 #, sh-format
 msgid "Does not point to a valid commit: $onto_name"
-msgstr "$onto_name zeigt auf keine g=C3=BCltige Version"
+msgstr "$onto_name zeigt auf keinen g=C3=BCltigen Commit"
=20
 #: git-rebase.sh:463
 #, sh-format
 msgid "fatal: no such branch: $branch_name"
-msgstr "fatal: Zweig $branch_name nicht gefunden"
+msgstr "fatal: Branch $branch_name nicht gefunden"
=20
 #: git-rebase.sh:483
 msgid "Please commit or stash them."
-msgstr "Bitte tragen Sie die =C3=84nderungen ein oder benutzen Sie \"s=
tash\"."
+msgstr "Bitte committen Sie die =C3=84nderungen oder benutzen Sie \"st=
ash\"."
=20
 #: git-rebase.sh:501
 #, sh-format
 msgid "Current branch $branch_name is up to date."
-msgstr "Aktueller Zweig $branch_name ist auf dem neusten Stand."
+msgstr "Aktueller Branch $branch_name ist auf dem neusten Stand."
=20
 #: git-rebase.sh:504
 #, sh-format
 msgid "Current branch $branch_name is up to date, rebase forced."
 msgstr ""
-"Aktueller Zweig $branch_name ist auf dem neusten Stand, Neuaufbau erz=
wungen."
+"Aktueller Branch $branch_name ist auf dem neusten Stand, Rebase erzwu=
ngen."
=20
 #: git-rebase.sh:515
 #, sh-format
@@ -9884,7 +9879,7 @@ msgstr "=C3=84nderungen von $mb zu $onto:"
 #: git-rebase.sh:524
 msgid "First, rewinding head to replay your work on top of it..."
 msgstr ""
-"Zun=C3=A4chst wird die Zweigspitze zur=C3=BCckgespult, um Ihre =C3=84=
nderungen\n"
+"Zun=C3=A4chst wird der Branch zur=C3=BCckgespult, um Ihre =C3=84nderu=
ngen\n"
 "darauf neu anzuwenden..."
=20
 #: git-rebase.sh:532
@@ -9898,15 +9893,15 @@ msgstr "git stash clear mit Parametern ist nich=
t implementiert"
=20
 #: git-stash.sh:74
 msgid "You do not have the initial commit yet"
-msgstr "Sie haben bisher noch keine initiale Version"
+msgstr "Sie haben bisher noch keinen initialen Commit"
=20
 #: git-stash.sh:89
 msgid "Cannot save the current index state"
-msgstr "Kann den aktuellen Zustand der Bereitstellung nicht speichern"
+msgstr "Kann den aktuellen Zustand der Staging-Area nicht speichern"
=20
 #: git-stash.sh:123 git-stash.sh:136
 msgid "Cannot save the current worktree state"
-msgstr "Kann den aktuellen Zustand des Arbeitsbaumes nicht speichern"
+msgstr "Kann den aktuellen Zustand des Arbeitsverzeichnisses nicht spe=
ichern"
=20
 #: git-stash.sh:140
 msgid "No changes selected"
@@ -9914,11 +9909,11 @@ msgstr "Keine =C3=84nderungen ausgew=C3=A4hlt"
=20
 #: git-stash.sh:143
 msgid "Cannot remove temporary index (can't happen)"
-msgstr "Kann tempor=C3=A4re Bereitstellung nicht l=C3=B6schen (kann ni=
cht passieren)"
+msgstr "Kann tempor=C3=A4re Staging-Area nicht l=C3=B6schen (kann nich=
t passieren)"
=20
 #: git-stash.sh:156
 msgid "Cannot record working tree state"
-msgstr "Kann Zustand des Arbeitsbaumes nicht aufzeichnen"
+msgstr "Kann Zustand des Arbeitsverzeichnisses nicht aufzeichnen"
=20
 #. TRANSLATORS: $option is an invalid option, like
 #. `--blah-blah'. The 7 spaces at the beginning of the
@@ -9954,7 +9949,7 @@ msgstr "Kann den aktuellen Status nicht speichern=
"
=20
 #: git-stash.sh:253
 msgid "Cannot remove worktree changes"
-msgstr "Kann =C3=84nderungen am Arbeitsbaum nicht l=C3=B6schen"
+msgstr "Kann =C3=84nderungen im Arbeitsverzeichnis nicht l=C3=B6schen"
=20
 #: git-stash.sh:352
 msgid "No stash found."
@@ -9973,7 +9968,7 @@ msgstr "$reference ist keine g=C3=BCltige Referen=
z"
 #: git-stash.sh:393
 #, sh-format
 msgid "'$args' is not a stash-like commit"
-msgstr "'$args' ist keine \"stash\"-artige Version"
+msgstr "'$args' ist kein \"stash\"-artiger Commit"
=20
 #: git-stash.sh:404
 #, sh-format
@@ -9982,28 +9977,28 @@ msgstr "'$args' ist keine \"stash\"-Referenz"
=20
 #: git-stash.sh:412
 msgid "unable to refresh index"
-msgstr "unf=C3=A4hig die Bereitstellung zu aktualisieren"
+msgstr "unf=C3=A4hig die Staging-Area zu aktualisieren"
=20
 #: git-stash.sh:416
 msgid "Cannot apply a stash in the middle of a merge"
 msgstr ""
-"Kann \"stash\" nicht anwenden, solang eine Zusammenf=C3=BChrung im Ga=
nge ist"
+"Kann \"stash\" nicht anwenden, solang ein Merge im Gange ist"
=20
 #: git-stash.sh:424
 msgid "Conflicts in index. Try without --index."
-msgstr "Konflikte in der Bereitstellung. Versuchen Sie es ohne --index=
=2E"
+msgstr "Konflikte in der Staging-Area. Versuchen Sie es ohne --index."
=20
 #: git-stash.sh:426
 msgid "Could not save index tree"
-msgstr "Konnte Bereitstellungsbaum nicht speichern"
+msgstr "Konnte Staging-Area-Verzeichnis nicht speichern"
=20
 #: git-stash.sh:460
 msgid "Cannot unstage modified files"
-msgstr "Kann ge=C3=A4nderte Dateien nicht aus der Bereitstellung herau=
snehmen"
+msgstr "Kann ge=C3=A4nderte Dateien nicht aus der Staging-Area entfern=
en"
=20
 #: git-stash.sh:475
 msgid "Index was not unstashed."
-msgstr "Bereitstellung wurde nicht ausgelagert."
+msgstr "Staging-Area wurde nicht aus dem Stash zur=C3=BCckgeladen."
=20
 #: git-stash.sh:492
 #, sh-format
@@ -10017,7 +10012,7 @@ msgstr "${REV}: Konnte \"stash\"-Eintrag nicht =
l=C3=B6schen"
=20
 #: git-stash.sh:500
 msgid "No branch name specified"
-msgstr "Kein Zweigname spezifiziert"
+msgstr "Kein Branchname spezifiziert"
=20
 #: git-stash.sh:571
 msgid "(To restore them type \"git stash apply\")"
@@ -10032,18 +10027,18 @@ msgstr "Kann eine Komponente von URL '$remote=
url' nicht extrahieren"
 #, sh-format
 msgid "No submodule mapping found in .gitmodules for path '$sm_path'"
 msgstr ""
-"Keine Unterprojekt-Zuordnung in .gitmodules f=C3=BCr Pfad '$sm_path' =
gefunden"
+"Keine Submodul-Zuordnung in .gitmodules f=C3=BCr Pfad '$sm_path' gefu=
nden"
=20
 #: git-submodule.sh:239
 #, sh-format
 msgid "Clone of '$url' into submodule path '$sm_path' failed"
-msgstr "Klonen von '$url' in Unterprojekt-Pfad '$sm_path' fehlgeschlag=
en"
+msgstr "Klonen von '$url' in Submodul-Pfad '$sm_path' fehlgeschlagen"
=20
 #: git-submodule.sh:251
 #, sh-format
 msgid "Gitdir '$a' is part of the submodule path '$b' or vice versa"
 msgstr ""
-"Git-Verzeichnis '$a' ist Teil des Unterprojekt-Pfades '$b', oder umge=
kehrt"
+"Git-Verzeichnis '$a' ist Teil des Submodul-Pfades '$b', oder umgekehr=
t"
=20
 #: git-submodule.sh:349
 #, sh-format
@@ -10053,7 +10048,7 @@ msgstr "repo URL: '$repo' muss absolut sein ode=
r mit ./|../ beginnen"
 #: git-submodule.sh:366
 #, sh-format
 msgid "'$sm_path' already exists in the index"
-msgstr "'$sm_path' existiert bereits in der Bereitstellung"
+msgstr "'$sm_path' ist bereits zum Commit vorgemerkt"
=20
 #: git-submodule.sh:370
 #, sh-format
@@ -10070,19 +10065,19 @@ msgstr ""
 #, sh-format
 msgid "Adding existing repo at '$sm_path' to the index"
 msgstr ""
-"F=C3=BCge existierendes Projektarchiv in '$sm_path' der Bereitstellun=
g hinzu."
+"F=C3=BCge existierendes Repository in '$sm_path' der Staging-Area hin=
zu."
=20
 #: git-submodule.sh:390
 #, sh-format
 msgid "'$sm_path' already exists and is not a valid git repo"
-msgstr "'$sm_path' existiert bereits und ist kein g=C3=BCltiges Git-Pr=
ojektarchiv"
+msgstr "'$sm_path' existiert bereits und ist kein g=C3=BCltiges Git-Re=
pository"
=20
 #: git-submodule.sh:398
 #, sh-format
 msgid "A git directory for '$sm_name' is found locally with remote(s):=
"
 msgstr ""
-"Ein Git-Verzeichnis f=C3=BCr '$sm_name' wurde lokal gefunden mit den =
=46ernarchiv"
-"(en):"
+"Ein Git-Verzeichnis f=C3=BCr '$sm_name' wurde lokal gefunden mit den =
Remote-"
+"Repositories:"
=20
 #: git-submodule.sh:400
 #, sh-format
@@ -10098,7 +10093,7 @@ msgid ""
 "use the '--force' option. If the local git directory is not the corre=
ct repo"
 msgstr ""
 "benutzen Sie die Option '--force'. Wenn das lokale Git-Verzeichnis ni=
cht das "
-"korrekte Projektarchiv ist"
+"korrekte Repository ist"
=20
 #: git-submodule.sh:403
 #, sh-format
@@ -10112,23 +10107,23 @@ msgstr ""
 #: git-submodule.sh:405
 #, sh-format
 msgid "Reactivating local git directory for submodule '$sm_name'."
-msgstr "Reaktiviere lokales Git-Verzeichnis f=C3=BCr Unterprojekt '$sm=
_name'."
+msgstr "Reaktiviere lokales Git-Verzeichnis f=C3=BCr Submodul '$sm_nam=
e'."
=20
 #: git-submodule.sh:417
 #, sh-format
 msgid "Unable to checkout submodule '$sm_path'"
-msgstr "Unf=C3=A4hig Unterprojekt '$sm_path' auszuchecken"
+msgstr "Unf=C3=A4hig Submodul '$sm_path' auszuchecken"
=20
 #: git-submodule.sh:422
 #, sh-format
 msgid "Failed to add submodule '$sm_path'"
-msgstr "Hinzuf=C3=BCgen von Unterprojekt '$sm_path' fehlgeschlagen"
+msgstr "Hinzuf=C3=BCgen von Submodul '$sm_path' fehlgeschlagen"
=20
 #: git-submodule.sh:431
 #, sh-format
 msgid "Failed to register submodule '$sm_path'"
 msgstr ""
-"Fehler beim Eintragen von Unterprojekt '$sm_path' in die Konfiguratio=
n."
+"Fehler beim Eintragen von Submodul '$sm_path' in die Konfiguration."
=20
 #: git-submodule.sh:474
 #, sh-format
@@ -10143,48 +10138,48 @@ msgstr "Stoppe bei '$sm_path'; Skript gab nic=
ht-Null Status zur=C3=BCck."
 #: git-submodule.sh:532
 #, sh-format
 msgid "No url found for submodule path '$sm_path' in .gitmodules"
-msgstr "Keine URL f=C3=BCr Unterprojekt-Pfad '$sm_path' in .gitmodules=
 gefunden"
+msgstr "Keine URL f=C3=BCr Submodul-Pfad '$sm_path' in .gitmodules gef=
unden"
=20
 #: git-submodule.sh:541
 #, sh-format
 msgid "Failed to register url for submodule path '$sm_path'"
 msgstr ""
-"Fehler beim Eintragen der URL f=C3=BCr Unterprojekt-Pfad '$sm_path' i=
n die "
+"Fehler beim Eintragen der URL f=C3=BCr Submodul-Pfad '$sm_path' in di=
e "
 "Konfiguration."
=20
 #: git-submodule.sh:543
 #, sh-format
 msgid "Submodule '$name' ($url) registered for path '$sm_path'"
 msgstr ""
-"Unterprojekt '$name' ($url) f=C3=BCr Pfad '$sm_path' in die Konfigura=
tion "
+"Submodul '$name' ($url) f=C3=BCr Pfad '$sm_path' in die Konfiguration=
 "
 "eingetragen"
=20
 #: git-submodule.sh:551
 #, sh-format
 msgid "Failed to register update mode for submodule path '$sm_path'"
 msgstr ""
-"Fehler bei =C3=84nderung des Aktualisierungsmodus f=C3=BCr Unterproje=
kt-Pfad "
+"Fehler bei =C3=84nderung des Aktualisierungsmodus f=C3=BCr Submodul-P=
fad "
 "'$sm_path' in der Konfiguration."
=20
 #: git-submodule.sh:588
 #, sh-format
 msgid "Use '.' if you really want to deinitialize all submodules"
 msgstr ""
-"Verwenden Sie '.' wenn Sie wirklich alle Unterprojekte\n"
+"Verwenden Sie '.' wenn Sie wirklich alle Submodule\n"
 "deinitialisieren m=C3=B6chten."
=20
 #: git-submodule.sh:603
 #, sh-format
 msgid "Submodule work tree '$sm_path' contains a .git directory"
 msgstr ""
-"Arbeitsbaum des Unterprojekts in '$sm_path' enth=C3=A4lt ein .git-Ver=
zeichnis"
+"Arbeitsverzeichnis des Submoduls in '$sm_path' enth=C3=A4lt ein .git-=
Verzeichnis"
=20
 #: git-submodule.sh:604
 #, sh-format
 msgid ""
 "(use 'rm -rf' if you really want to remove it including all of its hi=
story)"
 msgstr ""
-"(benutzen Sie 'rm -rf' wenn Sie dieses Unterprojekt wirklich mitsamt\=
n"
+"(benutzen Sie 'rm -rf' wenn Sie dieses Submodul wirklich mitsamt\n"
 "seiner Historie l=C3=B6schen m=C3=B6chten)"
=20
 #: git-submodule.sh:610
@@ -10193,7 +10188,7 @@ msgid ""
 "Submodule work tree '$sm_path' contains local modifications; use '-f'=
 to "
 "discard them"
 msgstr ""
-"Arbeitsbaum von Unterprojekt in '$sm_path' enth=C3=A4lt lokale =C3=84=
nderungen; "
+"Arbeitsverzeichnis von Submodul in '$sm_path' enth=C3=A4lt lokale =C3=
=84nderungen; "
 "verwenden Sie '-f' um diese zu verwerfen"
=20
 #: git-submodule.sh:613
@@ -10204,19 +10199,19 @@ msgstr "Verzeichnis '$sm_path' bereinigt."
 #: git-submodule.sh:614
 #, sh-format
 msgid "Could not remove submodule work tree '$sm_path'"
-msgstr "Konnte Arbeitsbaum des Unterprojektes in '$sm_path' nicht l=C3=
=B6schen."
+msgstr "Konnte Arbeitsverzeichnis des Submoduls in '$sm_path' nicht l=C3=
=B6schen."
=20
 #: git-submodule.sh:617
 #, sh-format
 msgid "Could not create empty submodule directory '$sm_path'"
 msgstr ""
-"Konnte kein leeres Verzeichnis f=C3=BCr Unterprojekt in '$sm_path' er=
stellen."
+"Konnte kein leeres Verzeichnis f=C3=BCr Submodul in '$sm_path' erstel=
len."
=20
 #: git-submodule.sh:626
 #, sh-format
 msgid "Submodule '$name' ($url) unregistered for path '$sm_path'"
 msgstr ""
-"Unterprojekt '$name' ($url) f=C3=BCr Pfad '$sm_path' wurde aus der Ko=
nfiguration "
+"Submodul '$name' ($url) f=C3=BCr Pfad '$sm_path' wurde aus der Konfig=
uration "
 "entfernt."
=20
 #: git-submodule.sh:731
@@ -10225,63 +10220,62 @@ msgid ""
 "Submodule path '$prefix$sm_path' not initialized\n"
 "Maybe you want to use 'update --init'?"
 msgstr ""
-"Unterprojekt-Pfad '$prefix$sm_path' ist nicht initialisiert.\n"
+"Submodul-Pfad '$prefix$sm_path' ist nicht initialisiert.\n"
 "Vielleicht m=C3=B6chten Sie 'update --init' benutzen?"
=20
 #: git-submodule.sh:744
 #, sh-format
 msgid "Unable to find current revision in submodule path '$prefix$sm_p=
ath'"
 msgstr ""
-"Konnte aktuelle Revision in Unterprojekt-Pfad '$prefix$sm_path' nicht=
 finden."
+"Konnte aktuelle Revision in Submodul-Pfad '$prefix$sm_path' nicht fin=
den."
=20
 #: git-submodule.sh:753
 #, sh-format
 msgid "Unable to fetch in submodule path '$sm_path'"
-msgstr "Konnte in Unterprojekt-Pfad '$sm_path' nicht anfordern"
+msgstr "Konnte \"fetch\" in Submodul-Pfad '$sm_path' nicht ausf=C3=BCh=
ren"
=20
 #: git-submodule.sh:777
 #, sh-format
 msgid "Unable to fetch in submodule path '$prefix$sm_path'"
-msgstr "Konnte in Unterprojekt-Pfad '$prefix$sm_path' nicht anfordern"
+msgstr "Konnte \"fetch\" in Submodul-Pfad '$prefix$sm_path' nicht ausf=
=C3=BChren"
=20
 #: git-submodule.sh:791
 #, sh-format
 msgid "Unable to rebase '$sha1' in submodule path '$prefix$sm_path'"
 msgstr ""
-"Neuaufbau von '$sha1' in Unterprojekt-Pfad '$prefix$sm_path' nicht m=C3=
=B6glich"
+"Rebase auf '$sha1' in Submodul-Pfad '$prefix$sm_path' nicht m=C3=B6gl=
ich"
=20
 #: git-submodule.sh:792
 #, sh-format
 msgid "Submodule path '$prefix$sm_path': rebased into '$sha1'"
-msgstr "Unterprojekt-Pfad '$prefix$sm_path': neu aufgebaut in '$sha1'"
+msgstr "Submodul-Pfad '$prefix$sm_path': Rebase auf '$sha1'"
=20
 #: git-submodule.sh:797
 #, sh-format
 msgid "Unable to merge '$sha1' in submodule path '$prefix$sm_path'"
 msgstr ""
-"Zusammenf=C3=BChrung von '$sha1' in Unterprojekt-Pfad '$prefix$sm_pat=
h' "
-"fehlgeschlagen"
+"Merge von '$sha1' in Submodul-Pfad '$prefix$sm_path' fehlgeschlagen"
=20
 #: git-submodule.sh:798
 #, sh-format
 msgid "Submodule path '$prefix$sm_path': merged in '$sha1'"
-msgstr "Unterprojekt-Pfad '$prefix$sm_path': zusammengef=C3=BChrt in '=
$sha1'"
+msgstr "Submodul-Pfad '$prefix$sm_path': zusammengef=C3=BChrt in '$sha=
1'"
=20
 #: git-submodule.sh:803
 #, sh-format
 msgid "Unable to checkout '$sha1' in submodule path '$prefix$sm_path'"
 msgstr ""
-"Konnte '$sha1' in Unterprojekt-Pfad '$prefix$sm_path' nicht auschecke=
n."
+"Konnte '$sha1' in Submodul-Pfad '$prefix$sm_path' nicht auschecken."
=20
 #: git-submodule.sh:804
 #, sh-format
 msgid "Submodule path '$prefix$sm_path': checked out '$sha1'"
-msgstr "Unterprojekt-Pfad: '$prefix$sm_path': '$sha1' ausgecheckt"
+msgstr "Submodul-Pfad: '$prefix$sm_path': '$sha1' ausgecheckt"
=20
 #: git-submodule.sh:831
 #, sh-format
 msgid "Failed to recurse into submodule path '$prefix$sm_path'"
-msgstr "Fehler bei Rekursion in Unterprojekt-Pfad '$prefix$sm_path'"
+msgstr "Fehler bei Rekursion in Submodul-Pfad '$prefix$sm_path'"
=20
 #: git-submodule.sh:939
 msgid "The --cached option cannot be used with the --files option"
@@ -10297,18 +10291,18 @@ msgstr "unerwarteter Modus $mod_dst"
 #: git-submodule.sh:997
 #, sh-format
 msgid "  Warn: $name doesn't contain commit $sha1_src"
-msgstr "  Warnung: $name beinhaltet nicht Version $sha1_src"
+msgstr "  Warnung: $name beinhaltet nicht Commit $sha1_src"
=20
 #: git-submodule.sh:1000
 #, sh-format
 msgid "  Warn: $name doesn't contain commit $sha1_dst"
-msgstr "  Warnung: $name beinhaltet nicht Version $sha1_dst"
+msgstr "  Warnung: $name beinhaltet nicht Commit $sha1_dst"
=20
 #: git-submodule.sh:1003
 #, sh-format
 msgid "  Warn: $name doesn't contain commits $sha1_src and $sha1_dst"
 msgstr ""
-"  Warnung: $name beinhaltet nicht die Versionen $sha1_src und $sha1_d=
st"
+"  Warnung: $name beinhaltet nicht die Commits $sha1_src und $sha1_dst=
"
=20
 #: git-submodule.sh:1028
 msgid "blob"
@@ -10316,21 +10310,21 @@ msgstr "Blob"
=20
 #: git-submodule.sh:1066
 msgid "Submodules changed but not updated:"
-msgstr "Unterprojekte ge=C3=A4ndert, aber nicht aktualisiert:"
+msgstr "Submodule ge=C3=A4ndert, aber nicht aktualisiert:"
=20
 #: git-submodule.sh:1068
 msgid "Submodule changes to be committed:"
-msgstr "=C3=84nderungen in Unterprojekt zum Eintragen:"
+msgstr "=C3=84nderungen in Submodul zum Committen:"
=20
 #: git-submodule.sh:1153
 #, sh-format
 msgid "Failed to recurse into submodule path '$sm_path'"
-msgstr "Fehler bei Rekursion in Unterprojekt-Pfad '$sm_path'"
+msgstr "Fehler bei Rekursion in Submodul-Pfad '$sm_path'"
=20
 #: git-submodule.sh:1216
 #, sh-format
 msgid "Synchronizing submodule url for '$prefix$sm_path'"
-msgstr "Synchronisiere Unterprojekt-URL f=C3=BCr '$prefix$sm_path'"
+msgstr "Synchronisiere Submodul-URL f=C3=BCr '$prefix$sm_path'"
=20
 #~ msgid "It took %.2f seconds to enumerate untracked files.  'status =
-uno'"
 #~ msgstr ""
--=20
1.8.2.1230.g519726a

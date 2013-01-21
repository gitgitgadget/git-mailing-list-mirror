From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: fix some minor issues
Date: Mon, 21 Jan 2013 20:02:25 +0100
Message-ID: <1358794945-4254-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Mon Jan 21 20:03:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxMe5-0004xp-JX
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 20:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756384Ab3AUTCh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 14:02:37 -0500
Received: from mail-bk0-f47.google.com ([209.85.214.47]:38602 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755950Ab3AUTCg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 14:02:36 -0500
Received: by mail-bk0-f47.google.com with SMTP id jc3so18655bkc.34
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 11:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=2y9AmG/qsI4FVnkURDPDnDDfMje57vxvhP8LUBmXQ2M=;
        b=zQpTAGBkoWBR5gR2teDB0e9Ontip91+dK+fUAc3BMu3GAhAodQqXbG2v6MJLi6R0YP
         ETU7vjEg7R73N3kCjVWpfcwfw+mzWIun5ei1uiKtBbi+e9hVgqddS0Hf09de0xsYA+K5
         GfTJV8QBdPurxBm0ygIWsVj5TUSQ2eqJOQwp+CRW+IoLF7lsUdIS1yYDzaPFJ6dd8k7k
         Pb8E/D3HsXUeXRUeF8bWWpKq40BzE63zOlNTKKo/Gwz2OE2Khgalf+tDARTDLh9E183o
         S24RId1k41h6s21v0pjR2awcGeTXjStqDJH2vEj9kD6gaqUWmOvgGnmPV5x1C09QWAI9
         FQmg==
X-Received: by 10.204.150.205 with SMTP id z13mr5192452bkv.16.1358794954229;
        Mon, 21 Jan 2013 11:02:34 -0800 (PST)
Received: from localhost.localdomain (dslb-094-222-138-000.pools.arcor-ip.net. [94.222.138.0])
        by mx.google.com with ESMTPS id hm8sm9401934bkc.10.2013.01.21.11.02.32
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 11:02:33 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.250.geacf011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214141>

This fixes some minor issues and improves the
German translation a bit. The following things
were changed:
- use complete sentences in option related messages
- translate "use" consistently as "verwendet"
- don't translate "make sense" as "macht Sinn"

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 205 +++++++++++++++++++++++++++++++++----------------------=
--------
 1 file changed, 109 insertions(+), 96 deletions(-)

diff --git a/po/de.po b/po/de.po
index c8ad2f0..a23991d 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1550,12 +1550,12 @@ msgstr "Hinzuf=C3=BCgen von Dateien fehlgeschla=
gen"
=20
 #: builtin/add.c:392
 msgid "-A and -u are mutually incompatible"
-msgstr "-A und -u sind zueinander inkompatibel"
+msgstr "Die Optionen -A und -u sind zueinander inkompatibel."
=20
 #: builtin/add.c:394
 msgid "Option --ignore-missing can only be used together with --dry-ru=
n"
 msgstr ""
-"Die Option --ignore-missing kann nur zusammen mit --dry-run benutzt w=
erden."
+"Die Option --ignore-missing kann nur zusammen mit --dry-run verwendet=
 werden."
=20
 #: builtin/add.c:414
 #, c-format
@@ -2045,15 +2045,18 @@ msgstr "stellt <Wurzelverzeichnis> vor alle Dat=
einamen"
=20
 #: builtin/apply.c:4384
 msgid "--3way outside a repository"
-msgstr "--3way au=C3=9Ferhalb eines Projektarchivs"
+msgstr "Die Option --3way kann nicht au=C3=9Ferhalb eines Projektarchi=
vs verwendet"
+" werden."
=20
 #: builtin/apply.c:4392
 msgid "--index outside a repository"
-msgstr "--index au=C3=9Ferhalb eines Projektarchivs"
+msgstr "Die Option --index kann nicht au=C3=9Ferhalb eines Projektarch=
ivs verwendet"
+" werden."
=20
 #: builtin/apply.c:4395
 msgid "--cached outside a repository"
-msgstr "--cached au=C3=9Ferhalb eines Projektarchivs"
+msgstr "Die Option --cached kann nicht au=C3=9Ferhalb eines Projektarc=
hivs verwendet"
+" werden."
=20
 #: builtin/apply.c:4411
 #, c-format
@@ -2503,7 +2506,7 @@ msgstr "Zweigspitze (HEAD) wurde nicht unter \"re=
fs/heads\" gefunden!"
=20
 #: builtin/branch.c:836
 msgid "--column and --verbose are incompatible"
-msgstr "--column und --verbose sind inkompatibel"
+msgstr "Die Optionen --column und --verbose sind inkompatibel."
=20
 #: builtin/branch.c:887
 #, c-format
@@ -2518,8 +2521,8 @@ msgstr "Zweig '%s' hat keinen externen =C3=9Cbern=
ahmezweig gesetzt"
 #: builtin/branch.c:914
 msgid "-a and -r options to 'git branch' do not make sense with a bran=
ch name"
 msgstr ""
-"Die Optionen -a und -r bei 'git branch' machen mit einem Zweignamen k=
einen "
-"Sinn."
+"Die Optionen -a und -r bei 'git branch' k=C3=B6nnen nicht gemeimsam m=
it einem "
+"Zweignamen verwendet werden."
=20
 #: builtin/branch.c:917
 #, c-format
@@ -2720,12 +2723,12 @@ msgstr "Konnte Ergebnis der Zusammenf=C3=BChrun=
g von '%s' nicht hinzuf=C3=BCgen."
 #: builtin/checkout.c:245
 #, c-format
 msgid "'%s' cannot be used with updating paths"
-msgstr "'%s' kann nicht mit Pfaden benutzt werden"
+msgstr "'%s' kann nicht mit Pfaden verwendet werden"
=20
 #: builtin/checkout.c:248 builtin/checkout.c:251
 #, c-format
 msgid "'%s' cannot be used with %s"
-msgstr "'%s' kann nicht mit '%s' benutzt werden"
+msgstr "'%s' kann nicht mit '%s' verwendet werden"
=20
 #: builtin/checkout.c:254
 #, c-format
@@ -2849,18 +2852,18 @@ msgstr "Referenz ist kein Baum: %s"
=20
 #: builtin/checkout.c:964
 msgid "paths cannot be used with switching branches"
-msgstr "Pfade k=C3=B6nnen nicht mit dem Wechseln von Zweigen benutzt w=
erden"
+msgstr "Pfade k=C3=B6nnen nicht mit dem Wechseln von Zweigen verwendet=
 werden"
=20
 #: builtin/checkout.c:967 builtin/checkout.c:971
 #, c-format
 msgid "'%s' cannot be used with switching branches"
-msgstr "'%s' kann nicht mit dem Wechseln von Zweigen benutzt werden"
+msgstr "'%s' kann nicht mit dem Wechseln von Zweigen verwendet werden"
=20
 #: builtin/checkout.c:975 builtin/checkout.c:978 builtin/checkout.c:98=
3
 #: builtin/checkout.c:986
 #, c-format
 msgid "'%s' cannot be used with '%s'"
-msgstr "'%s' kann nicht mit '%s' benutzt werden"
+msgstr "'%s' kann nicht mit '%s' verwendet werden"
=20
 #: builtin/checkout.c:991
 #, c-format
@@ -2938,11 +2941,11 @@ msgstr "second guess 'git checkout no-such-bran=
ch'"
=20
 #: builtin/checkout.c:1057
 msgid "-b, -B and --orphan are mutually exclusive"
-msgstr "-b, -B und --orphan schliessen sich gegenseitig aus"
+msgstr "Die Optionen -b, -B und --orphan schlie=C3=9Fen sich gegenseit=
ig aus."
=20
 #: builtin/checkout.c:1074
 msgid "--track needs a branch name"
-msgstr "--track ben=C3=B6tigt einen Zweignamen"
+msgstr "Bei der Option --track muss ein Zweigname angegeben werden."
=20
 #: builtin/checkout.c:1081
 msgid "Missing branch name; try -b"
@@ -3010,7 +3013,7 @@ msgstr "l=C3=B6scht nur ignorierte Dateien"
=20
 #: builtin/clean.c:78
 msgid "-x and -X cannot be used together"
-msgstr "-x und -X k=C3=B6nnen nicht zusammen benutzt werden"
+msgstr "Die Optionen -x und -X k=C3=B6nnen nicht gemeinsam verwendet w=
erden."
=20
 #: builtin/clean.c:82
 msgid ""
@@ -3079,7 +3082,7 @@ msgstr "um von einem lokalen Projektarchiv zu klo=
nen"
=20
 #: builtin/clone.c:76
 msgid "don't use local hardlinks, always copy"
-msgstr "benutzt lokal keine harten Links, immer Kopien"
+msgstr "verwendet lokal keine harten Links, immer Kopien"
=20
 #: builtin/clone.c:78
 msgid "setup as shared repository"
@@ -3107,7 +3110,7 @@ msgstr "Name"
=20
 #: builtin/clone.c:88
 msgid "use <name> instead of 'origin' to track upstream"
-msgstr "benutzt <Name> statt 'origin' f=C3=BCr externes Projektarchiv"
+msgstr "verwendet <Name> statt 'origin' f=C3=BCr externes Projektarchi=
v"
=20
 #: builtin/clone.c:90
 msgid "checkout <branch> instead of the remote's HEAD"
@@ -3208,7 +3211,7 @@ msgstr "Sie m=C3=BCssen ein Projektarchiv zum Klo=
nen angeben."
 #: builtin/clone.c:705
 #, c-format
 msgid "--bare and --origin %s options are incompatible."
-msgstr "--bare und --origin %s Optionen sind inkompatibel."
+msgstr "Die Optionen --bare und --origin %s sind inkompatibel."
=20
 #: builtin/clone.c:719
 #, c-format
@@ -3217,7 +3220,8 @@ msgstr "Projektarchiv '%s' existiert nicht."
=20
 #: builtin/clone.c:724
 msgid "--depth is ignored in local clones; use file:// instead."
-msgstr "--depth wird in lokalen Klonen ignoriert; benutzen Sie stattde=
ssen file://."
+msgstr "Die Option --depth wird in lokalen Klonen ignoriert; benutzen =
Sie "
+"stattdessen file://"
=20
 #: builtin/clone.c:734
 #, c-format
@@ -3293,7 +3297,7 @@ msgstr "Abstand zwischen Spalten"
=20
 #: builtin/column.c:51
 msgid "--command must be the first argument"
-msgstr "Option --command muss zuerst angegeben werden"
+msgstr "Die Option --command muss zuerst angegeben werden."
=20
 #: builtin/commit.c:34
 msgid "git commit [options] [--] <filepattern>..."
@@ -3531,7 +3535,8 @@ msgstr "Ung=C3=BCltiger Modus '%s' f=C3=BCr unbeo=
bachtete Dateien"
=20
 #: builtin/commit.c:984
 msgid "Using both --reset-author and --author does not make sense"
-msgstr "Verwendung von --reset-author und --author macht keinen Sinn."
+msgstr "Die Optionen --reset-author und --author k=C3=B6nnen nicht gem=
einsam "
+"verwendet werden."
=20
 #: builtin/commit.c:995
 msgid "You have nothing to amend."
@@ -3548,29 +3553,30 @@ msgstr "\"cherry-pick\" ist im Gange -- kann ni=
cht nachbessern."
 #: builtin/commit.c:1003
 msgid "Options --squash and --fixup cannot be used together"
 msgstr ""
-"Die Optionen --squash und --fixup k=C3=B6nnen nicht gemeinsam benutzt=
 werden."
+"Die Optionen --squash und --fixup k=C3=B6nnen nicht gemeinsam verwend=
et werden."
=20
 #: builtin/commit.c:1013
 msgid "Only one of -c/-C/-F/--fixup can be used."
-msgstr "Nur eines von -c/-C/-F/--fixup kann benutzt werden."
+msgstr "Es kann nur eine Option von -c/-C/-F/--fixup verwendet werden.=
"
=20
 #: builtin/commit.c:1015
 msgid "Option -m cannot be combined with -c/-C/-F/--fixup."
-msgstr "Option -m kann nicht mit -c/-C/-F/--fixup kombiniert werden"
+msgstr "Die Option -m kann nicht mit -c/-C/-F/--fixup kombiniert werde=
n."
=20
 #: builtin/commit.c:1023
 msgid "--reset-author can be used only with -C, -c or --amend."
-msgstr "--reset--author kann nur mit -C, -c oder --amend benutzt werde=
n"
+msgstr "Die Option --reset--author kann nur mit -C, -c oder --amend ve=
rwendet werden."
=20
 #: builtin/commit.c:1040
 msgid "Only one of --include/--only/--all/--interactive/--patch can be=
 used."
 msgstr ""
-"Nur eines von --include/--only/--all/--interactive/--patch kann benut=
zt "
-"werden."
+"Es kann nur eine Option von --include/--only/--all/--interactive/--pa=
tch "
+"verwendet werden."
=20
 #: builtin/commit.c:1042
 msgid "No paths with --include/--only does not make sense."
-msgstr "--include/--only machen ohne Pfade keinen Sinn."
+msgstr "Die Optionen --include und --only k=C3=B6nnen nur mit der Anga=
be von Pfaden "
+"verwendet werden."
=20
 #: builtin/commit.c:1044
 msgid "Clever... amending the last one with dirty index."
@@ -3590,11 +3596,11 @@ msgstr "Ung=C3=BCltiger \"cleanup\" Modus %s"
=20
 #: builtin/commit.c:1061
 msgid "Paths with -a does not make sense."
-msgstr "Pfade mit -a machen keinen Sinn."
+msgstr "Die Option -a kann nur mit der Angabe von Pfaden verwendet wer=
den."
=20
 #: builtin/commit.c:1067 builtin/commit.c:1202
 msgid "--long and -z are incompatible"
-msgstr "--long und -z sind inkompatibel"
+msgstr "Die Optionen --long und -z sind inkompatibel."
=20
 #: builtin/commit.c:1162 builtin/commit.c:1398
 msgid "show status concisely"
@@ -3715,18 +3721,18 @@ msgstr "verwendet Beschreibung der angegebenen =
Version wieder"
 #: builtin/commit.c:1378
 msgid "use autosquash formatted message to fixup specified commit"
 msgstr ""
-"benutzt eine automatisch zusammengesetzte Beschreibung zum Nachbesser=
n der "
+"verwendet eine automatisch zusammengesetzte Beschreibung zum Nachbess=
ern der "
 "angegebenen Version"
=20
 #: builtin/commit.c:1379
 msgid "use autosquash formatted message to squash specified commit"
 msgstr ""
-"benutzt eine automatisch zusammengesetzte Beschreibung zum Zusammenf=C3=
=BChren "
+"verwendet eine automatisch zusammengesetzte Beschreibung zum Zusammen=
f=C3=BChren "
 "der angegebenen Version"
=20
 #: builtin/commit.c:1380
 msgid "the commit is authored by me now (used with -C/-c/--amend)"
-msgstr "Setzt Sie als Autor der Version (benutzt mit -C/-c/--amend)"
+msgstr "Setzt Sie als Autor der Version (verwendet mit -C/-c/--amend)"
=20
 #: builtin/commit.c:1381 builtin/log.c:1073 builtin/revert.c:109
 msgid "add Signed-off-by:"
@@ -3734,7 +3740,7 @@ msgstr "f=C3=BCgt 'Signed-off-by:'-Zeile hinzu"
=20
 #: builtin/commit.c:1382
 msgid "use specified template file"
-msgstr "benutzt angegebene Vorlagendatei"
+msgstr "verwendet angegebene Vorlagendatei"
=20
 #: builtin/commit.c:1383
 msgid "force edit of commit"
@@ -3876,19 +3882,19 @@ msgstr "Ort der Konfigurationsdatei"
=20
 #: builtin/config.c:52
 msgid "use global config file"
-msgstr "benutzt globale Konfigurationsdatei"
+msgstr "verwendet globale Konfigurationsdatei"
=20
 #: builtin/config.c:53
 msgid "use system config file"
-msgstr "benutzt systemweite Konfigurationsdatei"
+msgstr "verwendet systemweite Konfigurationsdatei"
=20
 #: builtin/config.c:54
 msgid "use repository config file"
-msgstr "benutzt Konfigurationsdatei des Projektarchivs"
+msgstr "verwendet Konfigurationsdatei des Projektarchivs"
=20
 #: builtin/config.c:55
 msgid "use given config file"
-msgstr "benutzt die angegebene Konfigurationsdatei"
+msgstr "verwendet die angegebene Konfigurationsdatei"
=20
 #: builtin/config.c:56
 msgid "Action"
@@ -4076,15 +4082,15 @@ msgstr "protokolliert die Suchstrategie in der =
Standard-Fehlerausgabe"
=20
 #: builtin/describe.c:405
 msgid "use any ref in .git/refs"
-msgstr "benutzt jede Referenz in .git/refs"
+msgstr "verwendet alle Referenzen in .git/refs"
=20
 #: builtin/describe.c:406
 msgid "use any tag in .git/refs/tags"
-msgstr "benutzt alle Markierungen in .git/refs/tags"
+msgstr "verwendet alle Markierungen in .git/refs/tags"
=20
 #: builtin/describe.c:407
 msgid "always use long format"
-msgstr "benutzt immer langes Format"
+msgstr "verwendet immer langes Format"
=20
 #: builtin/describe.c:410
 msgid "only output exact matches"
@@ -4113,7 +4119,7 @@ msgstr ""
=20
 #: builtin/describe.c:436
 msgid "--long is incompatible with --abbrev=3D0"
-msgstr "--long ist inkompatibel mit --abbrev=3D0"
+msgstr "Die Optionen --long und --abbrev=3D0 sind inkompatibel."
=20
 #: builtin/describe.c:462
 msgid "No names found, cannot describe anything."
@@ -4121,7 +4127,7 @@ msgstr "Keine Namen gefunden, kann nichts beschre=
iben."
=20
 #: builtin/describe.c:482
 msgid "--dirty is incompatible with committishes"
-msgstr "--dirty ist inkompatibel mit Versionen"
+msgstr "Die Option --dirty ist inkompatibel mit Versionen."
=20
 #: builtin/diff.c:79
 #, c-format
@@ -4426,7 +4432,7 @@ msgstr "fetch --all akzeptiert kein Projektarchiv=
 als Argument"
=20
 #: builtin/fetch.c:986
 msgid "fetch --all does not make sense with refspecs"
-msgstr "fetch --all macht keinen Sinn mit Referenzspezifikationen"
+msgstr "fetch --all kann nicht mit Referenzspezifikationen verwendet w=
erden."
=20
 #: builtin/fetch.c:997
 #, c-format
@@ -4436,8 +4442,8 @@ msgstr "Kein externes Archiv (einzeln oder Gruppe=
): %s"
 #: builtin/fetch.c:1005
 msgid "Fetching a group and specifying refspecs does not make sense"
 msgstr ""
-"Abholen einer Gruppe mit Angabe von Referenzspezifikationen macht kei=
nen "
-"Sinn."
+"Das Abholen einer Gruppe von externen Archiven kann nicht mit der Ang=
abe\n"
+"von Referenzspezifikationen verwendet werden."
=20
 #: builtin/fmt-merge-msg.c:13
 msgid "git fmt-merge-msg [-m <message>] [--log[=3D<n>]|--no-log] [--fi=
le <file>]"
@@ -4464,7 +4470,7 @@ msgstr "Text"
=20
 #: builtin/fmt-merge-msg.c:661
 msgid "use <text> as start of message"
-msgstr "benutzt <Text> als Beschreibungsanfang"
+msgstr "verwendet <Text> als Beschreibungsanfang"
=20
 #: builtin/fmt-merge-msg.c:662
 msgid "file to read from"
@@ -4673,11 +4679,11 @@ msgstr "durchl=C3=A4uft h=C3=B6chstens <Tiefe> =
Ebenen"
=20
 #: builtin/grep.c:667
 msgid "use extended POSIX regular expressions"
-msgstr "benutzt erweiterte regul=C3=A4re Ausdr=C3=BCcke aus POSIX"
+msgstr "verwendet erweiterte regul=C3=A4re Ausdr=C3=BCcke aus POSIX"
=20
 #: builtin/grep.c:670
 msgid "use basic POSIX regular expressions (default)"
-msgstr "benutzt grundlegende regul=C3=A4re Ausdr=C3=BCcke aus POSIX (S=
tandard)"
+msgstr "verwendet grundlegende regul=C3=A4re Ausdr=C3=BCcke aus POSIX =
(Standard)"
=20
 #: builtin/grep.c:673
 msgid "interpret patterns as fixed strings"
@@ -4685,7 +4691,7 @@ msgstr "interpretiert Muster als feste Zeichenket=
ten"
=20
 #: builtin/grep.c:676
 msgid "use Perl-compatible regular expressions"
-msgstr "benutzt Perl-kompatible regul=C3=A4re Ausdr=C3=BCcke"
+msgstr "verwendet Perl-kompatible regul=C3=A4re Ausdr=C3=BCcke"
=20
 #: builtin/grep.c:679
 msgid "show line numbers"
@@ -4813,24 +4819,27 @@ msgstr "ung=C3=BCltiges Objekt %s"
=20
 #: builtin/grep.c:866
 msgid "--open-files-in-pager only works on the worktree"
-msgstr "--open-files-in-pager arbeitet nur innerhalb des Arbeitsbaums"
+msgstr "Die Option --open-files-in-pager kann nur innerhalb des "
+"Arbeitsbaums."
=20
 #: builtin/grep.c:889
 msgid "--cached or --untracked cannot be used with --no-index."
-msgstr "--cached oder --untracked kann nicht mit --no-index benutzt we=
rden"
+msgstr "Die Optionen --cached und --untracked k=C3=B6nnen nicht mit --=
no-index "
+"verwendet werden."
=20
 #: builtin/grep.c:894
 msgid "--no-index or --untracked cannot be used with revs."
-msgstr "--no-index oder --untracked kann nicht mit Versionen benutzt w=
erden"
+msgstr "Die Optionen --no-index und --untracked k=C3=B6nnen nicht mit =
Versionen "
+"verwendet werden."
=20
 #: builtin/grep.c:897
 msgid "--[no-]exclude-standard cannot be used for tracked contents."
-msgstr ""
-"--[no-]exlude-standard kann nicht mit beobachteten Inhalten benutzt w=
erden"
+msgstr "Die Option --[no-]exlude-standard kann nicht mit beobachteten =
"
+"Inhalten verwendet werden."
=20
 #: builtin/grep.c:905
 msgid "both --cached and trees are given."
-msgstr "sowohl --cached als auch Zweige gegeben"
+msgstr "Die Option --cached kann nicht mit Zweigen verwendet werden."
=20
 #: builtin/hash-object.c:60
 msgid ""
@@ -5223,7 +5232,7 @@ msgstr "%s ist ung=C3=BCltig"
=20
 #: builtin/index-pack.c:1559
 msgid "--fix-thin cannot be used without --stdin"
-msgstr "--fix-thin kann nicht ohne --stdin benutzt werden"
+msgstr "Die Option --fix-thin kann nicht ohne --stdin verwendet werden=
=2E"
=20
 #: builtin/index-pack.c:1563 builtin/index-pack.c:1573
 #, c-format
@@ -5232,7 +5241,7 @@ msgstr "Name der Paketdatei '%s' endet nicht mit =
'.pack'"
=20
 #: builtin/index-pack.c:1582
 msgid "--verify with no packfile name given"
-msgstr "--verify ohne Name der Paketdatei angegeben"
+msgstr "Die Option --verify wurde ohne Namen der Paketdatei angegeben.=
"
=20
 #: builtin/init-db.c:35
 #, c-format
@@ -5474,11 +5483,11 @@ msgstr "Zwei Ausgabeverzeichnisse?"
=20
 #: builtin/log.c:1068
 msgid "use [PATCH n/m] even with a single patch"
-msgstr "benutzt [PATCH n/m] auch mit einzelnem Patch"
+msgstr "verwendet [PATCH n/m] auch mit einzelnem Patch"
=20
 #: builtin/log.c:1071
 msgid "use [PATCH] even with multiple patches"
-msgstr "benutzt [PATCH] auch mit mehreren Patches"
+msgstr "verwendet [PATCH] auch mit mehreren Patches"
=20
 #: builtin/log.c:1075
 msgid "print patches to standard out"
@@ -5490,7 +5499,7 @@ msgstr "erzeugt ein Deckblatt"
=20
 #: builtin/log.c:1079
 msgid "use simple number sequence for output file names"
-msgstr "benutzt einfache Nummernfolge f=C3=BCr die Namen der Ausgabeda=
teien"
+msgstr "verwendet einfache Nummernfolge f=C3=BCr die Namen der Ausgabe=
dateien"
=20
 #: builtin/log.c:1080
 msgid "sfx"
@@ -5506,7 +5515,7 @@ msgstr "beginnt die Nummerierung der Patches bei =
<n> anstatt bei 1"
=20
 #: builtin/log.c:1085
 msgid "Use [<prefix>] instead of [PATCH]"
-msgstr "benutzt [<Prefix>] anstatt [PATCH]"
+msgstr "verwendet [<Prefix>] anstatt [PATCH]"
=20
 #: builtin/log.c:1088
 msgid "store resulting files in <dir>"
@@ -5596,23 +5605,23 @@ msgstr "unechte Einreicher-Informationen %s"
=20
 #: builtin/log.c:1208
 msgid "-n and -k are mutually exclusive."
-msgstr "-n und -k schlie=C3=9Fen sich gegenseitig aus"
+msgstr "Die Optionen -n und -k schlie=C3=9Fen sich gegenseitig aus."
=20
 #: builtin/log.c:1210
 msgid "--subject-prefix and -k are mutually exclusive."
-msgstr "--subject-prefix und -k schlie=C3=9Fen sich gegenseitig aus"
+msgstr "Die Optionen --subject-prefix und -k schlie=C3=9Fen sich gegen=
seitig aus."
=20
 #: builtin/log.c:1218
 msgid "--name-only does not make sense"
-msgstr "--name-only macht keinen Sinn"
+msgstr "Die Option --name-only kann nicht verwendet werden."
=20
 #: builtin/log.c:1220
 msgid "--name-status does not make sense"
-msgstr "--name-status macht keinen Sinn"
+msgstr "Die Option --name-status kann nicht verwendet werden."
=20
 #: builtin/log.c:1222
 msgid "--check does not make sense"
-msgstr "--check macht keinen Sinn"
+msgstr "Die Option --check kann nicht verwendet werden."
=20
 #: builtin/log.c:1245
 msgid "standard output, or directory, which one?"
@@ -5654,7 +5663,7 @@ msgstr "zeigt den Dateistatus mit Markierungen"
=20
 #: builtin/ls-files.c:465
 msgid "use lowercase letters for 'assume unchanged' files"
-msgstr "benutzt Kleinbuchstaben f=C3=BCr Dateien mit 'assume unchanged=
' Markierung"
+msgstr "verwendet Kleinbuchstaben f=C3=BCr Dateien mit 'assume unchang=
ed' Markierung"
=20
 #: builtin/ls-files.c:467
 msgid "show cached files in the output (default)"
@@ -5770,7 +5779,7 @@ msgstr "listet nur Dateinamen auf"
=20
 #: builtin/ls-tree.c:140
 msgid "use full path names"
-msgstr "benutzt vollst=C3=A4ndige Pfadnamen"
+msgstr "verwendet vollst=C3=A4ndige Pfadnamen"
=20
 #: builtin/ls-tree.c:142
 msgid "list entire tree; not just current directory (implies --full-na=
me)"
@@ -6072,7 +6081,8 @@ msgstr "Bin auf einem Zweig, der noch geboren wir=
d; kann nicht quetschen."
=20
 #: builtin/merge.c:1194
 msgid "Non-fast-forward commit does not make sense into an empty head"
-msgstr "nicht vorzuspulende Version macht in einem leeren Zweig keinen=
 Sinn"
+msgstr "Nicht vorzuspulende Version kann nicht in einem leeren Zweig "
+"verwendet werden."
=20
 #: builtin/merge.c:1309
 #, c-format
@@ -6171,7 +6181,7 @@ msgstr "sendet Ergebnisse zur Standard-Ausgabe"
=20
 #: builtin/merge-file.c:34
 msgid "use a diff3 based merge"
-msgstr "benutzt eine diff3 basierte Zusammenf=C3=BChrung"
+msgstr "verwendet eine diff3 basierte Zusammenf=C3=BChrung"
=20
 #: builtin/merge-file.c:35
 msgid "for conflicts, use our version"
@@ -6305,11 +6315,11 @@ msgstr "zeigt nur Namen an (keine SHA-1)"
=20
 #: builtin/name-rev.c:230
 msgid "only use tags to name the commits"
-msgstr "benutzt nur Markierungen um die Versionen zu benennen"
+msgstr "verwendet nur Markierungen um die Versionen zu benennen"
=20
 #: builtin/name-rev.c:232
 msgid "only use refs matching <pattern>"
-msgstr "benutzt nur Referenzen die <Muster> entsprechen"
+msgstr "verwendet nur Referenzen die <Muster> entsprechen"
=20
 #: builtin/name-rev.c:234
 msgid "list all commits reachable from all refs"
@@ -6672,7 +6682,7 @@ msgstr "Notiz-Referenz"
=20
 #: builtin/notes.c:1071
 msgid "use notes from <notes_ref>"
-msgstr "benutzt Notizen von <Notiz-Referenz>"
+msgstr "verwendet Notizen von <Notiz-Referenz>"
=20
 #: builtin/notes.c:1106 builtin/remote.c:1598
 #, c-format
@@ -6774,12 +6784,12 @@ msgstr "verwendet existierende Objekte wieder"
=20
 #: builtin/pack-objects.c:2475
 msgid "use OFS_DELTA objects"
-msgstr "benutzt OFS_DELTA Objekte"
+msgstr "verwendet OFS_DELTA Objekte"
=20
 #: builtin/pack-objects.c:2477
 msgid "use threads when searching for best delta matches"
 msgstr ""
-"benutzt Threads bei der Suche nach den besten =C3=9Cbereinstimmungen =
bei "
+"verwendet Threads bei der Suche nach den besten =C3=9Cbereinstimmunge=
n bei "
 "Unterschieden"
=20
 #: builtin/pack-objects.c:2479
@@ -6883,7 +6893,7 @@ msgstr "Kurzschrift f=C3=BCr Markierung ohne <Mar=
kierung>"
=20
 #: builtin/push.c:64
 msgid "--delete only accepts plain target ref names"
-msgstr "--delete akzeptiert nur reine Referenz-Namen als Ziel"
+msgstr "Die Option --delete akzeptiert nur reine Referenznamen als Zie=
l."
=20
 #: builtin/push.c:99
 msgid ""
@@ -7088,23 +7098,23 @@ msgstr ""
=20
 #: builtin/push.c:310
 msgid "--all and --tags are incompatible"
-msgstr "--all und --tags sind inkompatibel"
+msgstr "Die Optionen --all und --tags sind inkompatibel."
=20
 #: builtin/push.c:311
 msgid "--all can't be combined with refspecs"
-msgstr "--all kann nicht mit Referenzspezifikationen kombiniert werden=
"
+msgstr "Die Option --all kann nicht mit Referenzspezifikationen kombin=
iert werden."
=20
 #: builtin/push.c:316
 msgid "--mirror and --tags are incompatible"
-msgstr "--mirror und --tags sind inkompatibel"
+msgstr "Die Optionen --mirror und --tags sind inkompatibel."
=20
 #: builtin/push.c:317
 msgid "--mirror can't be combined with refspecs"
-msgstr "--mirror kann nicht mit Referenzspezifikationen kombiniert wer=
den"
+msgstr "Die Option --mirror kann nicht mit Referenzspezifikationen kom=
biniert werden."
=20
 #: builtin/push.c:322
 msgid "--all and --mirror are incompatible"
-msgstr "--all und --mirror sind inkompatibel"
+msgstr "Die Optionen --all und --mirror sind inkompatibel."
=20
 #: builtin/push.c:382
 msgid "repository"
@@ -7125,7 +7135,7 @@ msgstr "l=C3=B6scht Referenzen"
 #: builtin/push.c:387
 msgid "push tags (can't be used with --all or --mirror)"
 msgstr ""
-"versendet Markierungen (kann nicht mit --all oder --mirror benutzt we=
rden)"
+"versendet Markierungen (kann nicht mit --all oder --mirror verwendet =
werden)"
=20
 #: builtin/push.c:390
 msgid "force updates"
@@ -7141,7 +7151,7 @@ msgstr "steuert rekursives Versenden von Unterpro=
jekten"
=20
 #: builtin/push.c:394
 msgid "use thin pack"
-msgstr "benutzt kleinere Pakete"
+msgstr "verwendet kleinere Pakete"
=20
 #: builtin/push.c:395 builtin/push.c:396
 msgid "receive pack program"
@@ -7157,11 +7167,11 @@ msgstr "entfernt lokal gel=C3=B6schte Referenze=
n"
=20
 #: builtin/push.c:410
 msgid "--delete is incompatible with --all, --mirror and --tags"
-msgstr "--delete ist inkompatibel mit --all, --mirror und --tags"
+msgstr "Die Option --delete ist inkompatibel mit --all, --mirror und -=
-tags."
=20
 #: builtin/push.c:412
 msgid "--delete doesn't make sense without any refs"
-msgstr "--delete macht ohne irgendeine Referenz keinen Sinn"
+msgstr "Die Option --delete kann nur mit Referenzen verwendet werden."
=20
 #: builtin/read-tree.c:36
 msgid ""
@@ -7369,13 +7379,14 @@ msgstr ""
=20
 #: builtin/remote.c:185
 msgid "specifying a master branch makes no sense with --mirror"
-msgstr "Angabe eines Hauptzweiges macht mit --mirror keinen Sinn"
+msgstr "Die Option --mirror kann nicht mit der Angabe eines Hauptzweig=
es "
+"verwendet werden."
=20
 #: builtin/remote.c:187
 msgid "specifying branches to track makes sense only with fetch mirror=
s"
 msgstr ""
-"die Angabe von zu folgenden Zweigen macht nur mit dem Anfordern von "
-"Spiegelarchiven Sinn"
+"Die Angabe von zu folgenden Zweigen kann nur mit dem Anfordern von "
+"Spiegelarchiven verwendet werden."
=20
 #: builtin/remote.c:195 builtin/remote.c:646
 #, c-format
@@ -7726,7 +7737,8 @@ msgstr "l=C3=B6scht URLs"
=20
 #: builtin/remote.c:1447
 msgid "--add --delete doesn't make sense"
-msgstr "--add --delete macht keinen Sinn"
+msgstr "Die Optionen --add und --delete k=C3=B6nnen nicht gemeinsam ve=
rwendet "
+"werden."
=20
 #: builtin/remote.c:1487
 #, c-format
@@ -7945,7 +7957,7 @@ msgstr "git cherry-pick <Unterkommando>"
 #: builtin/revert.c:70 builtin/revert.c:92
 #, c-format
 msgid "%s: %s cannot be used with %s"
-msgstr "%s: %s kann nicht mit %s benutzt werden"
+msgstr "%s: %s kann nicht mit %s verwendet werden"
=20
 #: builtin/revert.c:103
 msgid "end revert or cherry-pick sequence"
@@ -8423,7 +8435,7 @@ msgstr "annotierte und GPG-signierte Markierung"
=20
 #: builtin/tag.c:464
 msgid "use another key to sign the tag"
-msgstr "benutzt einen anderen Schl=C3=BCssel um die Markierung zu sign=
ieren"
+msgstr "verwendet einen anderen Schl=C3=BCssel um die Markierung zu si=
gnieren"
=20
 #: builtin/tag.c:465
 msgid "replace the tag if exists"
@@ -9195,7 +9207,7 @@ msgstr "\"git-am\" scheint im Gange zu sein. Kann=
 nicht neu aufbauen."
=20
 #: git-rebase.sh:296
 msgid "The --exec option must be used with the --interactive option"
-msgstr "Die --exec Option muss mit der --interactive Option benutzt we=
rden"
+msgstr "Die Option --exec muss mit --interactive verwendet werden."
=20
 #: git-rebase.sh:301
 msgid "No rebase in progress?"
@@ -9204,7 +9216,7 @@ msgstr "Kein Neuaufbau im Gange?"
 #: git-rebase.sh:312
 msgid "The --edit-todo action can only be used during interactive reba=
se."
 msgstr "Die --edit-todo Aktion kann nur w=C3=A4hrend eines interaktive=
n "
-"Neuaufbaus benutzt werden."
+"Neuaufbaus verwendet werden."
=20
 #: git-rebase.sh:319
 msgid "Cannot read HEAD"
@@ -9626,7 +9638,8 @@ msgstr "Fehler bei Rekursion in Unterprojekt-Pfad=
 '$sm_path'"
=20
 #: git-submodule.sh:803
 msgid "The --cached option cannot be used with the --files option"
-msgstr "Die --cached Option kann nicht mit der --files Option benutzt =
werden"
+msgstr "Die Optionen --cached und --files k=C3=B6nnen nicht gemeinsam =
verwendet "
+"werden."
=20
 #. unexpected type
 #: git-submodule.sh:843
--=20
1.8.1.1.250.geacf011

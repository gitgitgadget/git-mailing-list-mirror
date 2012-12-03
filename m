From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?Re=3A=20=5BRFC/PATCH=5D=20l10n=3A=20de=2Epo=3A=20translate=20825=20new=20messages?=
Date: Mon,  3 Dec 2012 05:48:51 +0100
Message-ID: <1354510131-2881-1-git-send-email-ralf.thielow@gmail.com>
References: <87ehjcj9lq.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jk@jk.gs, stimming@tuhh.de,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@inf.ethz.ch, git@drmicha.warpmail.net
X-From: git-owner@vger.kernel.org Mon Dec 03 05:49:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfNy6-00076f-Fr
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 05:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261Ab2LCEtE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2012 23:49:04 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:40996 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab2LCEtB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 23:49:01 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so838560bkw.19
        for <git@vger.kernel.org>; Sun, 02 Dec 2012 20:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ls08yJ6TQe51R+P/xfxHm3xYd07bP9VJPtG/wlzEc9s=;
        b=tHN3zuuxt8l+ZEU7qAkbkZroaob5CIE+bV7xvUuaJiEfL44UH/a2SX9vYVcjiEIrf4
         XSZBRcbg9u2vFL494+EH0AiiF84iCf/qSg5a0wZcfWFb+JcCTbNG+sZvdou6T4OdPPmz
         CELFu+Qml0EGoXr5KB33TI/4dTak2E8j6wT+pPVAuT0UHF63y7AgtaLhcbV/Rvg1jWvp
         lytJ1xxtuu6U3vrw6C55STuhyVPnfUzDorXRS4xhp3gyYzqJIdxPJNP+AN9eMF9+ILBh
         4xMxUmT/f+qRvtr7c/GrmcBQ1mCSzdw6ikL/KVT4u28aHwHgRmQ1bO+nJuNSWipYkZtA
         UzGA==
Received: by 10.204.5.205 with SMTP id 13mr2520110bkw.111.1354510139324;
        Sun, 02 Dec 2012 20:48:59 -0800 (PST)
Received: from localhost.localdomain (dslb-094-222-147-091.pools.arcor-ip.net. [94.222.147.91])
        by mx.google.com with ESMTPS id 1sm6195082bks.3.2012.12.02.20.48.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Dec 2012 20:48:58 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <87ehjcj9lq.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211026>

Thanks Thomas and Michael!

2012/11/30 Thomas Rast <trast@inf.ethz.ch>:

>>  #: builtin/update-index.c:756
>>  msgid "mark files as \"index-only\""
>> -msgstr ""
>> +msgstr "markiert Dateien als \"index-only\""
>
> Likewise, but here I don't even understand what the manpage is trying=
 to
> tell me, in particular I don't see how it would be different from
> assume-unchanged.  Maybe "see manpage" would be the best documentatio=
n.

I'm not really sure what to do with it. In this version (see below) I k=
ept
it. Did you mean we should add "(siehe Hilfeseite)" or something in the
translation, or does it belong to the original message and the translat=
ion
would just follow?

>> +"wiederholte Ausf=C3=BChrung der Phasen #2 und #3 f=C3=BCr die aufg=
elisteten Pfade"
>
> ISTR we settled on something for 'stage', but it's not in the glossar=
y.
> Either way I don't think this is it.  "Ausf=C3=BChrung der Phasen" wo=
uld mean
> that it's some part of a process, whereas the stages are a state.
>
I've changed it to
"wiederholtes Einpflegen der Zust=C3=A4nde #2 und #3 f=C3=BCr die aufge=
listeten Pfade"
What do you think?

---
 po/de.po | 123 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 61 insertions(+), 62 deletions(-)

diff --git a/po/de.po b/po/de.po
index 1f49610..5e14d9c 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1978,7 +1978,7 @@ msgstr "Pfade sind getrennt durch NUL Zeichen"
 #: builtin/apply.c:4336
 msgid "ensure at least <n> lines of context match"
 msgstr ""
-"stellt sicher, dass mindestens <Anzahl> Zeilen des Kontextes =C3=BCbe=
reinstimmen"
+"stellt sicher, dass mindestens <n> Zeilen des Kontextes =C3=BCbereins=
timmen"
=20
 #: builtin/apply.c:4337
 msgid "action"
@@ -2167,7 +2167,7 @@ msgstr "Unterdr=C3=BCckt den Namen des Autors und=
 den Zeitstempel (Standard: aus)"
=20
 #: builtin/blame.c:2329
 msgid "Show author email instead of name (Default: off)"
-msgstr "Zeigt anstatt des Namens die eMail-Adresse des Autors (Standar=
d: aus)"
+msgstr "Zeigt anstatt des Namens die Email-Adresse des Autors (Standar=
d: aus)"
=20
 #: builtin/blame.c:2330
 msgid "Ignore whitespace differences"
@@ -4072,7 +4072,7 @@ msgstr "gibt nur exakte =C3=9Cbereinstimmungen au=
s"
=20
 #: builtin/describe.c:412
 msgid "consider <n> most recent tags (default: 10)"
-msgstr "betrachtet die j=C3=BCngsten <Anzahl> Markierungen (Standard: =
10)"
+msgstr "betrachtet die j=C3=BCngsten <n> Markierungen (Standard: 10)"
=20
 #: builtin/describe.c:414
 msgid "only consider tags matching <pattern>"
@@ -4143,7 +4143,7 @@ msgstr "git fast-export [rev-list-opts]"
=20
 #: builtin/fast-export.c:635
 msgid "show progress after <n> objects"
-msgstr "zeigt Fortschritt nach <Anzahl> Objekten an"
+msgstr "zeigt Fortschritt nach <n> Objekten an"
=20
 #: builtin/fast-export.c:637
 msgid "select handling of signed tags"
@@ -4422,7 +4422,7 @@ msgstr ""
 #: builtin/fmt-merge-msg.c:13
 msgid "git fmt-merge-msg [-m <message>] [--log[=3D<n>]|--no-log] [--fi=
le <file>]"
 msgstr ""
-"git fmt-merge-msg [-m <Beschreibung>] [--log[=3D<Anzahl>]|--no-log] [=
--file "
+"git fmt-merge-msg [-m <Beschreibung>] [--log[=3D<n>]|--no-log] [--fil=
e "
 "<Datei>]"
=20
 #: builtin/fmt-merge-msg.c:653 builtin/fmt-merge-msg.c:656 builtin/gre=
p.c:786
@@ -4433,7 +4433,7 @@ msgstr "Anzahl"
=20
 #: builtin/fmt-merge-msg.c:654
 msgid "populate log with at most <n> entries from shortlog"
-msgstr "f=C3=BCgt Historie mit h=C3=B6chstens <Nummer> Eintr=C3=A4gen =
von \"shortlog\" hinzu"
+msgstr "f=C3=BCgt Historie mit h=C3=B6chstens <n> Eintr=C3=A4gen von \=
"shortlog\" hinzu"
=20
 #: builtin/fmt-merge-msg.c:657
 msgid "alias for --log (deprecated)"
@@ -4457,23 +4457,23 @@ msgstr "git for-each-ref [Optionen] [<Muster>]"
=20
 #: builtin/for-each-ref.c:994
 msgid "quote placeholders suitably for shells"
-msgstr "quotiert Platzhalter geeignet f=C3=BCr Shells"
+msgstr "formatiert Platzhalter als Shell-String"
=20
 #: builtin/for-each-ref.c:996
 msgid "quote placeholders suitably for perl"
-msgstr "quotiert Platzhalter geeignet f=C3=BCr Perl"
+msgstr "formatiert Platzhalter als Perl-String"
=20
 #: builtin/for-each-ref.c:998
 msgid "quote placeholders suitably for python"
-msgstr "quotiert Platzhalter geeignet f=C3=BCr Python"
+msgstr "formatiert Platzhalter als Python-String"
=20
 #: builtin/for-each-ref.c:1000
 msgid "quote placeholders suitably for tcl"
-msgstr "quotiert Platzhalter geeignet f=C3=BCr TCL"
+msgstr "formatiert Platzhalter als TCL-String"
=20
 #: builtin/for-each-ref.c:1003
 msgid "show only <n> matched refs"
-msgstr "zeigt nur <Nummer> passende Referenzen"
+msgstr "zeigt nur <n> passende Referenzen"
=20
 #: builtin/for-each-ref.c:1004
 msgid "format"
@@ -4489,7 +4489,7 @@ msgstr "Sch=C3=BCssel"
=20
 #: builtin/for-each-ref.c:1006
 msgid "field name to sort on"
-msgstr "Name des Felder zum Sortieren"
+msgstr "sortiere nach diesem Feld"
=20
 #: builtin/fsck.c:608
 msgid "git fsck [options] [<object>...]"
@@ -4521,7 +4521,7 @@ msgstr "erzeugt Kopfknoten des Referenzprotokolls=
 (Standard)"
=20
 #: builtin/fsck.c:620
 msgid "also consider packs and alternate objects"
-msgstr "betrachtet auch Pakete und wechselnde Objekte"
+msgstr ""
=20
 #: builtin/fsck.c:621
 msgid "enable more strict checking"
@@ -4645,7 +4645,7 @@ msgstr "findet =C3=9Cbereinstimmungen unabh=C3=A4=
ngig von Gro=C3=9F- und Kleinschreibung"
=20
 #: builtin/grep.c:741
 msgid "match patterns only at word boundaries"
-msgstr "findet Muster nur innerhalb von W=C3=B6rtern"
+msgstr "sucht nur ganze W=C3=B6rter"
=20
 #: builtin/grep.c:743
 msgid "process binary files as text"
@@ -4728,15 +4728,15 @@ msgstr ""
=20
 #: builtin/grep.c:787
 msgid "show <n> context lines before and after matches"
-msgstr "zeigt <Anzahl> Zeilen vor und nach den =C3=9Cbereinstimmungen =
an"
+msgstr "zeigt <n> Zeilen vor und nach den =C3=9Cbereinstimmungen an"
=20
 #: builtin/grep.c:790
 msgid "show <n> context lines before matches"
-msgstr "zeigt <Anzahl> Zeilen vor den =C3=9Cbereinstimmungen an"
+msgstr "zeigt <n> Zeilen vor den =C3=9Cbereinstimmungen an"
=20
 #: builtin/grep.c:792
 msgid "show <n> context lines after matches"
-msgstr "zeigt <Anzahl> Zeilen nach den =C3=9Cbereinstimmungen an"
+msgstr "zeigt <n> Zeilen nach den =C3=9Cbereinstimmungen an"
=20
 #: builtin/grep.c:793
 msgid "shortcut for -C NUM"
@@ -4764,7 +4764,7 @@ msgstr "kombiniert Muster, die mit -e angegeben w=
urden"
=20
 #: builtin/grep.c:817
 msgid "indicate hit with exit status without output"
-msgstr "kennzeichnet =C3=9Cbereinstimmungen mit Beendigungsstatus, ohn=
e Ausgabe"
+msgstr "zeigt =C3=9Cbereinstimmungen nur durch Beendigungsstatus an"
=20
 #: builtin/grep.c:819
 msgid "show only matches from files that match all patterns"
@@ -4850,7 +4850,7 @@ msgstr "speichert Datei wie sie ist, ohne Filter"
=20
 #: builtin/hash-object.c:77
 msgid "process file as it were from this path"
-msgstr "verarbeitet Datei, wie es von diesem Pfad w=C3=A4re"
+msgstr "verarbeitet Datei, als ob sie von diesem Pfad w=C3=A4re"
=20
 #: builtin/help.c:43
 msgid "print all available commands"
@@ -4866,7 +4866,7 @@ msgstr "zeigt Handbuch in einem Webbrowser"
=20
 #: builtin/help.c:47
 msgid "show info page"
-msgstr "zeigt Informationsseite"
+msgstr "zeigt Info-Seite"
=20
 #: builtin/help.c:53
 msgid "git help [--all] [--man|--web|--info] [command]"
@@ -5110,7 +5110,7 @@ msgstr "Fehler beim Aufl=C3=B6sen der Unterschied=
e"
 #: builtin/index-pack.c:1112
 #, c-format
 msgid "completed with %d local objects"
-msgstr "fertiggestellt mit %d lokalen Objekten"
+msgstr "vervollst=C3=A4ndigt mit %d lokalen Objekten"
=20
 #: builtin/index-pack.c:1121
 #, c-format
@@ -5401,7 +5401,7 @@ msgstr "zeigt Quelle"
=20
 #: builtin/log.c:102
 msgid "decorate options"
-msgstr "Ausgabeoptionen"
+msgstr "decorate-Optionen"
=20
 #: builtin/log.c:189
 #, c-format
@@ -5486,7 +5486,7 @@ msgstr "verwendet <Dateiendung> anstatt '.patch'"
=20
 #: builtin/log.c:1078
 msgid "start numbering patches at <n> instead of 1"
-msgstr "beginnt die Nummerierung der Patches bei <Nummer> anstatt bei =
1"
+msgstr "beginnt die Nummerierung der Patches bei <n> anstatt bei 1"
=20
 #: builtin/log.c:1080
 msgid "Use [<prefix>] instead of [PATCH]"
@@ -5507,8 +5507,7 @@ msgstr "gibt keine bin=C3=A4ren Unterschiede aus"
 #: builtin/log.c:1091
 msgid "don't include a patch matching a commit upstream"
 msgstr ""
-"schlie=C3=9Ft keine Patches ein, die einer Version im externen Projek=
tarchiv "
-"entsprechen"
+"schlie=C3=9Ft keine Patches ein, die einer Version im =C3=9Cbernahmez=
weig entsprechen"
=20
 #: builtin/log.c:1093
 msgid "show patch format instead of default (patch + stat)"
@@ -5516,27 +5515,27 @@ msgstr "zeigt Patchformat anstatt des Standards=
 (Patch + Zusammenfassung)"
=20
 #: builtin/log.c:1095
 msgid "Messaging"
-msgstr "Datentransfer"
+msgstr "Email-Einstellungen"
=20
 #: builtin/log.c:1096
 msgid "header"
-msgstr "Kopfteil"
+msgstr "Header"
=20
 #: builtin/log.c:1097
 msgid "add email header"
-msgstr "f=C3=BCgt Kopfteil f=C3=BCr eMail hinzu"
+msgstr "f=C3=BCgt Email-Header hinzu"
=20
 #: builtin/log.c:1098 builtin/log.c:1100
 msgid "email"
-msgstr "eMail"
+msgstr "Email"
=20
 #: builtin/log.c:1098
 msgid "add To: header"
-msgstr "f=C3=BCgt Kopfteil \"To:\" hinzu"
+msgstr "f=C3=BCgt  \"To:\"-Header hinzu"
=20
 #: builtin/log.c:1100
 msgid "add Cc: header"
-msgstr "f=C3=BCgt Kopteil \"Cc:\" hinzu"
+msgstr "f=C3=BCgt \"Cc:\"-Header hinzu"
=20
 #: builtin/log.c:1102
 msgid "message-id"
@@ -5544,7 +5543,7 @@ msgstr "message-id"
=20
 #: builtin/log.c:1103
 msgid "make first mail a reply to <message-id>"
-msgstr "macht aus erster eMail eine Antwort zu <message-id>"
+msgstr "macht aus erster Email eine Antwort zu <message-id>"
=20
 #: builtin/log.c:1104 builtin/log.c:1107
 msgid "boundary"
@@ -5556,7 +5555,7 @@ msgstr "h=C3=A4ngt einen Patch an"
=20
 #: builtin/log.c:1108
 msgid "inline the patch"
-msgstr "f=C3=BCgt einen Patch ein"
+msgstr "f=C3=BCgt den Patch direkt in die Nachricht ein"
=20
 #: builtin/log.c:1112
 msgid "enable message threading, styles: shallow, deep"
@@ -5635,7 +5634,7 @@ msgstr "git ls-files [Optionen] [<Datei>...]"
=20
 #: builtin/ls-files.c:463
 msgid "identify the file status with tags"
-msgstr "bestimmt den Dateistatus mit Markierungen"
+msgstr "zeigt den Dateistatus mit Markierungen"
=20
 #: builtin/ls-files.c:465
 msgid "use lowercase letters for 'assume unchanged' files"
@@ -5812,7 +5811,7 @@ msgstr "(Synonym f=C3=BCr --stat)"
 #: builtin/merge.c:189
 msgid "add (at most <n>) entries from shortlog to merge commit message=
"
 msgstr ""
-"f=C3=BCgt (h=C3=B6chstens <Nummber>) Eintr=C3=A4ge von \"short\" zur =
Beschreibung der "
+"f=C3=BCgt (h=C3=B6chstens <n>) Eintr=C3=A4ge von \"shortlog\" zur Bes=
chreibung der "
 "Zusammenf=C3=BChrung hinzu"
=20
 #: builtin/merge.c:192
@@ -6502,7 +6501,7 @@ msgstr "Ung=C3=BCltiger notes.rewriteMode Wert: '=
%s'"
 #, c-format
 msgid "Refusing to rewrite notes in %s (outside of refs/notes/)"
 msgstr ""
-"Neuschreiben der Notizen in %s zur=C3=BCckgewiesen (au=C3=9Ferhalb vo=
n refs/notes/)"
+"Umschreiben der Notizen in %s zur=C3=BCckgewiesen (au=C3=9Ferhalb von=
 refs/notes/)"
=20
 #. TRANSLATORS: The first %s is the name of the
 #. environment variable, the second %s is its value
@@ -6578,7 +6577,7 @@ msgstr "liest Objekte von der Standard-Eingabe"
 #: builtin/notes.c:617
 msgid "load rewriting config for <command> (implies --stdin)"
 msgstr ""
-"l=C3=A4dt Konfiguration f=C3=BCr <Kommando> beim =C3=9Cberschreiben v=
on Versionen "
+"l=C3=A4dt Konfiguration f=C3=BCr <Kommando> beim Umschreiben von Vers=
ionen "
 "(impliziert --stdin)"
=20
 #: builtin/notes.c:635
@@ -6817,7 +6816,7 @@ msgstr "entpackt nicht erreichbare Objekte, die n=
euer als <Zeit> sind"
=20
 #: builtin/pack-objects.c:2502
 msgid "create thin packs"
-msgstr "erzeugt kleinere Pakete"
+msgstr "erzeugt d=C3=BCnnere Pakete"
=20
 #: builtin/pack-objects.c:2504
 msgid "ignore packs that have companion .keep file"
@@ -6845,7 +6844,7 @@ msgstr "entfernt lose Referenzen (Standard)"
=20
 #: builtin/prune-packed.c:7
 msgid "git prune-packed [-n|--dry-run] [-q|--quiet]"
-msgstr "git prune-packed [-n|--dry-run] [-q|--quite]"
+msgstr "git prune-packed [-n|--dry-run] [-q|--quiet]"
=20
 #: builtin/prune.c:12
 msgid "git prune [-n] [-v] [--expire <time>] [--] [<head>...]"
@@ -7123,7 +7122,7 @@ msgstr "erzwingt Aktualisierung"
=20
 #: builtin/push.c:391
 msgid "check"
-msgstr "=C3=9Cberpr=C3=BCfung"
+msgstr ""
=20
 #: builtin/push.c:392
 msgid "control recursive pushing of submodules"
@@ -7135,7 +7134,7 @@ msgstr "benutzt kleinere Pakete"
=20
 #: builtin/push.c:395 builtin/push.c:396
 msgid "receive pack program"
-msgstr "Programm zum Empfangen von Paketen"
+msgstr "'receive pack' Programm"
=20
 #: builtin/push.c:397
 msgid "set upstream for git pull/status"
@@ -7170,7 +7169,7 @@ msgstr "schreibt resultierende Bereitstellung nac=
h <Datei>"
=20
 #: builtin/read-tree.c:111
 msgid "only empty the index"
-msgstr "leert nur die Bereitstellung"
+msgstr "leert die Bereitstellung"
=20
 #: builtin/read-tree.c:113
 msgid "Merging"
@@ -7233,7 +7232,7 @@ msgstr "protokolliert Entpacken der B=C3=A4ume"
=20
 #: builtin/remote.c:11
 msgid "git remote [-v | --verbose]"
-msgstr "git remove [-v | --verbose]"
+msgstr "git remote [-v | --verbose]"
=20
 #: builtin/remote.c:12
 msgid ""
@@ -7359,7 +7358,7 @@ msgstr "push|fetch"
 #: builtin/remote.c:173
 msgid "set up remote as a mirror to push to or fetch from"
 msgstr ""
-"Aufsetzen der Fernarchivs als Spiegelarchiv zum Versenden und Anforde=
rn"
+"Aufsetzen des Fernarchivs als Spiegelarchiv zum Versenden und Anforde=
rn"
=20
 #: builtin/remote.c:185
 msgid "specifying a master branch makes no sense with --mirror"
@@ -7913,8 +7912,8 @@ msgid ""
 "Run \"git rev-parse --parseopt -h\" for more information on the first=
 usage."
 msgstr ""
 "git rev-parse --parseopt [Optionen] -- [<Argumente>...]\n"
-"   or: git rev-parse --sq-quote [<Argumente>...]\n"
-"   or: git rev-parse [Optionen] [<Argumente>...]\n"
+"   oder: git rev-parse --sq-quote [<Argumente>...]\n"
+"   oder: git rev-parse [Optionen] [<Argumente>...]\n"
 "\n"
 "F=C3=BChre \"git rev-parse --parseopt -h\" f=C3=BCr weitere Informati=
onen bei erster "
 "Verwendung aus."
@@ -8092,7 +8091,7 @@ msgstr "Unterdr=C3=BCckt Versionsbeschreibungen, =
liefert nur Anzahl der Versionen"
=20
 #: builtin/shortlog.c:257
 msgid "Show the email address of each author"
-msgstr "Zeigt die eMail-Adresse von jedem Autor"
+msgstr "Zeigt die Email-Adresse von jedem Autor"
=20
 #: builtin/shortlog.c:258
 msgid "w[,i1[,i2]]"
@@ -8110,22 +8109,22 @@ msgid ""
 "<glob>)...]"
 msgstr ""
 "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r] [--"
-"current] [--color[=3D<Wann>] | --no-color] [--sparse] [--more=3D<Numm=
er> | --"
+"current] [--color[=3D<Wann>] | --no-color] [--sparse] [--more=3D<n> |=
 --"
 "list | --independent | --merge-base] [--no-name | --sha1-name] [--top=
ics] "
 "[(<Revision> | <glob>)...]"
=20
 #: builtin/show-branch.c:10
 msgid "git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref>]=
"
 msgstr ""
-"git show-branch (-g|--reflog)[=3D<Nummer>[,<Basis>]] [--list] [<Refer=
enz>]"
+"git show-branch (-g|--reflog)[=3D<n>[,<Basis>]] [--list] [<Referenz>]=
"
=20
 #: builtin/show-branch.c:651
 msgid "show remote-tracking and local branches"
-msgstr "zeigt externer =C3=9Cbernahmezweige und lokale Zweige an"
+msgstr "zeigt externe =C3=9Cbernahmezweige und lokale Zweige an"
=20
 #: builtin/show-branch.c:653
 msgid "show remote-tracking branches"
-msgstr "zeigt externer =C3=9Cbernahmezweige an"
+msgstr "zeigt externe =C3=9Cbernahmezweige an"
=20
 #: builtin/show-branch.c:655
 msgid "color '*!+-' corresponding to the branch"
@@ -8133,7 +8132,7 @@ msgstr "f=C3=A4rbt '*!+-' entsprechend des Zweige=
s ein"
=20
 #: builtin/show-branch.c:657
 msgid "show <n> more commits after the common ancestor"
-msgstr "zeigt <Nummer> weitere Versionen nach dem gemeinsamen Vorfahre=
n"
+msgstr "zeigt <n> weitere Versionen nach dem gemeinsamen Vorfahren"
=20
 #: builtin/show-branch.c:659
 msgid "synonym to more=3D-1"
@@ -8178,12 +8177,12 @@ msgstr "zeigt Versionen, wo kein Elternteil vor=
 seinem Kind kommt"
=20
 #: builtin/show-branch.c:678
 msgid "<n>[,<base>]"
-msgstr "<Nummer>[,<Basis>]"
+msgstr "<n>[,<Basis>]"
=20
 #: builtin/show-branch.c:679
 msgid "show <n> most recent ref-log entries starting at base"
 msgstr ""
-"zeigt die <Nummer> j=C3=BCngsten Eintr=C3=A4ge im Referenzprotokoll b=
eginnend an der "
+"zeigt die <n> j=C3=BCngsten Eintr=C3=A4ge im Referenzprotokoll beginn=
end an der "
 "Basis"
=20
 #: builtin/show-ref.c:10
@@ -8192,7 +8191,7 @@ msgid ""
 "[=3D<n>]] [--abbrev[=3D<n>]] [--tags] [--heads] [--] [pattern*] "
 msgstr ""
 "git show-ref [-q|--quiet] [--verify] [--head] [-d|--dereference] [-s|=
--hash"
-"[=3D<Nummer>]] [--abbrev[=3D<Nummer>]] [--tags] [--heads] [--] [patte=
rn*] "
+"[=3D<n>]] [--abbrev[=3D<n>]] [--tags] [--heads] [--] [pattern*] "
=20
 #: builtin/show-ref.c:11
 msgid "git show-ref --exclude-existing[=3Dpattern] < ref-list"
@@ -8220,7 +8219,7 @@ msgstr "dereferenziert Markierungen in Objekt-Ide=
ntifikationen"
=20
 #: builtin/show-ref.c:193
 msgid "only show SHA1 hash using <n> digits"
-msgstr "zeigt nur SHA1 Hash mit <Nummer> Ziffern"
+msgstr "zeigt nur SHA1 Hash mit <n> Ziffern"
=20
 #: builtin/show-ref.c:197
 msgid "do not print results to stdout (useful with --verify)"
@@ -8372,7 +8371,7 @@ msgstr "listet Markierungsnamen auf"
=20
 #: builtin/tag.c:449
 msgid "print <n> lines of each tag message"
-msgstr "zeigt <Anzahl> Zeilen jeder Markierungsbeschreibung"
+msgstr "zeigt <n> Zeilen jeder Markierungsbeschreibung"
=20
 #: builtin/tag.c:451
 msgid "delete tags"
@@ -8400,7 +8399,7 @@ msgstr "annotierte und GPG-signierte Markierung"
=20
 #: builtin/tag.c:464
 msgid "use another key to sign the tag"
-msgstr "benutzt einen Schl=C3=BCssel um die Markierung zu signieren"
+msgstr "benutzt einen anderen Schl=C3=BCssel um die Markierung zu sign=
ieren"
=20
 #: builtin/tag.c:465
 msgid "replace the tag if exists"
@@ -8529,7 +8528,7 @@ msgstr "=C3=BCberschreibt das \"ausf=C3=BChrbar\"=
-Bit der aufgelisteten Dateien"
=20
 #: builtin/update-index.c:750
 msgid "mark files as \"not changing\""
-msgstr "markiert Dateien als \"not changing\""
+msgstr "betrachte diese Datei immer als unver=C3=A4ndert"
=20
 #: builtin/update-index.c:753
 msgid "clear assumed-unchanged bit"
@@ -8568,7 +8567,7 @@ msgstr "f=C3=BCgt Eintr=C3=A4ge von der Standard-=
Eingabe der Bereitstellung hinzu"
 #: builtin/update-index.c:776
 msgid "repopulate stages #2 and #3 for the listed paths"
 msgstr ""
-"wiederholte Ausf=C3=BChrung der Phasen #2 und #3 f=C3=BCr die aufgeli=
steten Pfade"
+"wiederholtes Einpflegen der Zust=C3=A4nde #2 und #3 f=C3=BCr die aufg=
elisteten Pfade"
=20
 #: builtin/update-index.c:780
 msgid "only update entries that differ from HEAD"
@@ -8671,7 +8670,7 @@ msgstr "weniger Ausgaben"
=20
 #: parse-options.h:236
 msgid "use <n> digits to display SHA-1s"
-msgstr "benutze <Anzahl> Ziffern zur Anzeige von SHA-1s"
+msgstr "benutze <n> Ziffern zur Anzeige von SHA-1s"
=20
 #: common-cmds.h:8
 msgid "Add file contents to the index"
@@ -8883,7 +8882,7 @@ msgstr ""
=20
 #: git-am.sh:706
 msgid "Patch does not have a valid e-mail address."
-msgstr "Patch enth=C3=A4lt keine g=C3=BCltige eMail-Adresse."
+msgstr "Patch enth=C3=A4lt keine g=C3=BCltige Email-Adresse."
=20
 #: git-am.sh:753
 msgid "cannot be interactive without stdin connected to a terminal."
--=20
1.8.0

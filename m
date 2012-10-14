From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?fixes=20of=20previous=20commit?=
Date: Sun, 14 Oct 2012 15:29:45 +0200
Message-ID: <1350221385-3467-1-git-send-email-ralf.thielow@gmail.com>
References: <87pq4mgli6.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jk@jk.gs, stimming@tuhh.de,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@inf.ethz.ch
X-From: git-owner@vger.kernel.org Sun Oct 14 15:30:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNOGc-00030N-Ib
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 15:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242Ab2JNN3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 09:29:54 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41168 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab2JNN3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 09:29:53 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so1114981wib.1
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LOOsCvqdNSRuDGzkEBWEd3ZGe9nGeE39TMKbockocTI=;
        b=LCclPAtfa4ftkpiD1p+ZpEvHOeaIP/gQc6C4B1bg8f8vAmoNOCIb8dW3dEkT82jmIe
         DxD0pfKS7N8WeaP39WhnMECQi1Uun4RbFVYKDGEyfVpxhoIK6q6gRbfyoOBHJTKZeEug
         f4IYG5zbZ+1z/4ngCFNMtpglwwkLck+pYBMnow03e1Lic3YbKVwSTphs2A8WzEa+3HRh
         Gp34nUEGRaDEC7LdySnK4gj/LuKDPtUs2/ekUo+4pAFW8I7JxP65mjZhdQH8Hd6ZJx3q
         MVH3yMhBNUMdqCyKgLdsGXd+Cfo2ewenLfSgHPAGRMiYR8trouwzf7GDViKYLRse9UQi
         d6yg==
Received: by 10.216.212.232 with SMTP id y82mr5287324weo.120.1350221391455;
        Sun, 14 Oct 2012 06:29:51 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id gg4sm9826076wib.6.2012.10.14.06.29.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 06:29:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc0.18.gf84667d
In-Reply-To: <87pq4mgli6.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207664>

---

> Hi Ralf
>

Hi Thomas,

thanks for your work! All your suggestions are very good.

> I just realized that, unfortunately, your original message is far bey=
ond
> the message size limit on vger (100000 bytes according to [1]).  So
> nobody outside of the Cc list has seen it...
>

Oops, I didn't notice that and can't remember of a hint from vger.
Next time I'll check the mailing list whether the mail is there.

>> +msgstr "kopiert Dateien von einer benannten Bereitstellung"
>
> "Stage" in this context means the 0/1/2/3 thing where unmerged entrie=
s
> differ from normal entries.  Thank the Git gods for overloading yet
> another term heavily.
>
> We don't have a translation for "stage" in the glossary.  The best I =
can
> come up with is "Stufe", but if you can find something that evokes th=
e
> mental image of the "sides" of a merge, that would be better IMO.

What about "Stand"?

>> +msgstr "checkt ihre Version f=C3=BCr nicht zusammengef=C3=BChrte Da=
teien aus"
>
> You're translating 'our/their version' -> unsere/ihre Version.  Taken
> just by itself I think it would be okay or at worst mildly confusing
> (how about "unsere/ihre Seite [der Zusammenf=C3=BChrung]"?).
>
> However, in the wider context it is actually dangerous, because you a=
re
> overloading the (German) Version here.  It already means 'commit'!
>

I've changed it to "Variante", what do you think?

> entfernt -> gel=C3=B6scht avoids the ambiguity with the whole remote
> branch/repo business.
>

Thanks, I've changed also other messages this way.

>>  #: builtin/fast-export.c:643
>>  msgid "Dump marks to this file"
>> -msgstr ""
>> +msgstr "Anzeige von Kennzeichen f=C3=BCr diese Datei"
> [...]
>>  #: builtin/fast-export.c:645
>>  msgid "Import marks from this file"
>> -msgstr ""
>> +msgstr "Importiert Kennzeichen von dieser Datei"
>
> How did you manage to nail the second one, but get the first one wron=
g?
> :-)

Gaahh, how embarrassing :)

 po/de.po | 157 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 78 insertions(+), 79 deletions(-)

diff --git a/po/de.po b/po/de.po
index 9ffe4f2..796ada1 100644
--- a/po/de.po
+++ b/po/de.po
@@ -50,12 +50,12 @@ msgstr "git archive --list"
 msgid ""
 "git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [<pat=
h>...]"
 msgstr ""
-"git archive --remote <Projektarchiv> [--exec <Kommando>] [Optionen] "
+"git archive --remote <Projektarchiv> [--exec <Programm>] [Optionen] "
 "<Versionsreferenz> [Pfad...]"
=20
 #: archive.c:13
 msgid "git archive --remote <repo> [--exec <cmd>] --list"
-msgstr "git archive --remote <Projektarchiv> [--exec <Kommando>] --lis=
t"
+msgstr "git archive --remote <Projektarchiv> [--exec <Programm>] --lis=
t"
=20
 #: archive.c:322
 msgid "fmt"
@@ -63,7 +63,7 @@ msgstr "Format"
=20
 #: archive.c:322
 msgid "archive format"
-msgstr "Archivformat"
+msgstr "Ausgabeformat"
=20
 #: archive.c:323 builtin/log.c:1079
 msgid "prefix"
@@ -71,7 +71,7 @@ msgstr "Prefix"
=20
 #: archive.c:324
 msgid "prepend prefix to each pathname in the archive"
-msgstr "stellt einen Prefix vor jeden Pfadnamen in dem Archiv"
+msgstr "stellt einen Pr=C3=A4fix vor jeden Pfadnamen in der Ausgabe"
=20
 #: archive.c:325 builtin/archive.c:91 builtin/blame.c:2332
 #: builtin/blame.c:2333 builtin/config.c:56 builtin/fast-export.c:642
@@ -83,7 +83,7 @@ msgstr "Datei"
=20
 #: archive.c:326 builtin/archive.c:92
 msgid "write the archive to this file"
-msgstr "schreibt das Archiv in diese Datei"
+msgstr "schreibt die Ausgabe in diese Datei"
=20
 #: archive.c:328
 msgid "read .gitattributes in working directory"
@@ -107,7 +107,7 @@ msgstr "besser komprimieren"
=20
 #: archive.c:342
 msgid "list supported archive formats"
-msgstr "listet unterst=C3=BCtzte Archivformate auf"
+msgstr "listet unterst=C3=BCtzte Ausgabeformate auf"
=20
 #: archive.c:344 builtin/archive.c:93 builtin/clone.c:85
 msgid "repo"
@@ -119,11 +119,11 @@ msgstr "ruft das Archiv von externem Projektarchi=
v <Projektarchiv> ab"
=20
 #: archive.c:346 builtin/archive.c:95 builtin/notes.c:616
 msgid "command"
-msgstr "Kommando"
+msgstr "Programm"
=20
 #: archive.c:347 builtin/archive.c:96
 msgid "path to the remote git-upload-archive command"
-msgstr "Pfad zum externen \"git-upload-archive\" Kommando"
+msgstr "Pfad zum externen \"git-upload-archive\"-Programm"
=20
 #: bundle.c:36
 #, c-format
@@ -1346,25 +1346,25 @@ msgstr "nichts zum Eintragen hinzugef=C3=BCgt, =
aber es gibt unbeobachtete Dateien\n"
 #, c-format
 msgid "nothing to commit (create/copy files and use \"git add\" to tra=
ck)\n"
 msgstr ""
-"nichts zum Eintragen (Erstelle/Kopiere Dateien und benutze \"git add\=
" zum "
+"nichts einzutragen (Erstelle/Kopiere Dateien und benutze \"git add\" =
zum "
 "Beobachten)\n"
=20
 #: wt-status.c:1043 wt-status.c:1048
 #, c-format
 msgid "nothing to commit\n"
-msgstr "nichts zum Eintragen\n"
+msgstr "nichts einzutragen\n"
=20
 #: wt-status.c:1046
 #, c-format
 msgid "nothing to commit (use -u to show untracked files)\n"
 msgstr ""
-"nichts zum Eintragen (benutze die Option -u, um unbeobachtete Dateien=
 "
+"nichts einzutragen (benutze die Option -u, um unbeobachtete Dateien "
 "anzuzeigen)\n"
=20
 #: wt-status.c:1050
 #, c-format
 msgid "nothing to commit, working directory clean\n"
-msgstr "nichts zum Eintragen, Arbeitsverzeichnis sauber\n"
+msgstr "nichts einzutragen, Arbeitsverzeichnis sauber\n"
=20
 #: wt-status.c:1158
 msgid "HEAD (no branch)"
@@ -1407,7 +1407,7 @@ msgstr "Aktualisierung der Dateien fehlgeschlagen=
"
 #: builtin/add.c:77
 #, c-format
 msgid "remove '%s'\n"
-msgstr "entferne '%s'\n"
+msgstr "l=C3=B6sche '%s'\n"
=20
 #: builtin/add.c:176
 #, c-format
@@ -1476,7 +1476,7 @@ msgstr "erweiterte Ausgaben"
=20
 #: builtin/add.c:322
 msgid "interactive picking"
-msgstr "interaktives Pfl=C3=BCcken"
+msgstr "interaktives Ausw=C3=A4hlen"
=20
 #: builtin/add.c:323 builtin/checkout.c:1028 builtin/reset.c:248
 msgid "select hunks interactively"
@@ -1496,7 +1496,7 @@ msgstr "aktualisiert beobachtete Dateien"
=20
 #: builtin/add.c:327
 msgid "record only the fact that the path will be added later"
-msgstr "speichert nur den Fakt, dass der Pfad sp=C3=A4ter hinzugef=C3=BC=
gt wird"
+msgstr "speichert nur, dass der Pfad sp=C3=A4ter hinzugef=C3=BCgt werd=
en soll"
=20
 #: builtin/add.c:328
 msgid "add changes from all tracked and untracked files"
@@ -1515,7 +1515,7 @@ msgstr ""
=20
 #: builtin/add.c:331
 msgid "check if - even missing - files are ignored in dry run"
-msgstr "pr=C3=BCft ob - auch fehlende - Dateien im Trockenlauf ignorie=
rt werden"
+msgstr "pr=C3=BCft ob - auch fehlende - Dateien im Probelauf ignoriert=
 werden"
=20
 #: builtin/add.c:353
 #, c-format
@@ -2114,15 +2114,15 @@ msgstr "[rev-opts] sind dokumentiert in git-rev=
-list(1)"
=20
 #: builtin/blame.c:2316
 msgid "Show blame entries as we find them, incrementally"
-msgstr "Zeigt \"blame\"-Eintr=C3=A4ge wie gefunden, schrittweise"
+msgstr "Zeigt \"blame\"-Eintr=C3=A4ge schrittweise, w=C3=A4hrend wir s=
ie generieren"
=20
 #: builtin/blame.c:2317
 msgid "Show blank SHA-1 for boundary commits (Default: off)"
-msgstr "Zeigt leere SHA-1 f=C3=BCr Grenzversionen (Standard: off)"
+msgstr "Zeigt leere SHA-1 f=C3=BCr Grenzversionen (Standard: aus)"
=20
 #: builtin/blame.c:2318
 msgid "Do not treat root commits as boundaries (Default: off)"
-msgstr "Behandelt Ursprungsversionen nicht als Grenzen (Standard: off)=
"
+msgstr "Behandelt Ursprungsversionen nicht als Grenzen (Standard: aus)=
"
=20
 #: builtin/blame.c:2319
 msgid "Show work cost statistics"
@@ -2138,7 +2138,7 @@ msgstr "Zeigt urspr=C3=BCnglichen Dateinamen (Sta=
ndard: auto)"
=20
 #: builtin/blame.c:2322
 msgid "Show original linenumber (Default: off)"
-msgstr "Zeigt urspr=C3=BCngliche Zeilennummer (Standard: off)"
+msgstr "Zeigt urspr=C3=BCngliche Zeilennummer (Standard: aus)"
=20
 #: builtin/blame.c:2323
 msgid "Show in a format designed for machine consumption"
@@ -2151,23 +2151,23 @@ msgstr ""
=20
 #: builtin/blame.c:2325
 msgid "Use the same output mode as git-annotate (Default: off)"
-msgstr "Benutzt den gleichen Ausgabemodus wie \"git-annotate\" (Standa=
rd: off)"
+msgstr "Benutzt den gleichen Ausgabemodus wie \"git-annotate\" (Standa=
rd: aus)"
=20
 #: builtin/blame.c:2326
 msgid "Show raw timestamp (Default: off)"
-msgstr "Zeigt unbearbeiteten Zeitstempel (Standard: off)"
+msgstr "Zeigt unbearbeiteten Zeitstempel (Standard: aus)"
=20
 #: builtin/blame.c:2327
 msgid "Show long commit SHA1 (Default: off)"
-msgstr "Zeigt langen Versions-SHA1 (Standard: off)"
+msgstr "Zeigt langen Versions-SHA1 (Standard: aus)"
=20
 #: builtin/blame.c:2328
 msgid "Suppress author name and timestamp (Default: off)"
-msgstr "Unterdr=C3=BCckt den Namen des Autors und den Zeitstempel (Sta=
ndard: off)"
+msgstr "Unterdr=C3=BCckt den Namen des Autors und den Zeitstempel (Sta=
ndard: aus)"
=20
 #: builtin/blame.c:2329
 msgid "Show author email instead of name (Default: off)"
-msgstr "Zeigt anstatt des Namens die eMail-Adresse des Autors (Standar=
d: off)"
+msgstr "Zeigt anstatt des Namens die eMail-Adresse des Autors (Standar=
d: aus)"
=20
 #: builtin/blame.c:2330
 msgid "Ignore whitespace differences"
@@ -2175,7 +2175,7 @@ msgstr "Ignoriert Unterschiede in Leerzeichen"
=20
 #: builtin/blame.c:2331
 msgid "Spend extra cycles to find better match"
-msgstr "f=C3=BChrt zus=C3=A4tzliche Durchl=C3=A4ufe f=C3=BCr bessere =C3=
=9Cbereinstimmungen durch"
+msgstr "arbeite l=C3=A4nger, um bessere =C3=9Cbereinstimmungen zu find=
en"
=20
 #: builtin/blame.c:2332
 msgid "Use revisions from <file> instead of calling git-rev-list"
@@ -2387,17 +2387,16 @@ msgstr "Konnte Beschreibungsvorlage f=C3=BCr Zw=
eig nicht schreiben: %s"
=20
 #: builtin/branch.c:724
 msgid "Generic options"
-msgstr "Generische Optionen"
+msgstr "Allgemeine Optionen"
=20
 #: builtin/branch.c:726
 msgid "show hash and subject, give twice for upstream branch"
 msgstr ""
-"Zeigt Hash und Betreff, doppelte Angabe f=C3=BCr Anzeige des externen=
 "
-"=C3=9Cbernahmezweiges"
+"Zeigt Hash und Betreff; -vv: zus=C3=A4tzlich externen =C3=9Cbernahmez=
weig"
=20
 #: builtin/branch.c:727
 msgid "suppress informational messages"
-msgstr "unterdr=C3=BCckt informatorische Meldungen"
+msgstr "unterdr=C3=BCckt Informationsmeldungen"
=20
 #: builtin/branch.c:728
 msgid "set up tracking mode (see git-pull(1))"
@@ -2464,7 +2463,7 @@ msgstr "bearbeitet die Beschreibung f=C3=BCr den =
Zweig"
=20
 #: builtin/branch.c:762
 msgid "force creation (when already exists)"
-msgstr "erzwingt Erzeugung (wenn dieser bereits existiert)"
+msgstr "erzeuge auch, wenn der Zweig bereits existiert"
=20
 #: builtin/branch.c:765
 msgid "print only not merged branches"
@@ -2498,7 +2497,7 @@ msgstr "Zweig '%s' existiert nicht"
 #: builtin/branch.c:876
 #, c-format
 msgid "Branch '%s' has no upstream information"
-msgstr "Zweig '%s' hat keine Informationen zu einem externen =C3=9Cber=
nahmezweig"
+msgstr "Zweig '%s' hat keinen externen =C3=9Cbernahmezweig gesetzt"
=20
 #: builtin/branch.c:891
 msgid "-a and -r options to 'git branch' do not make sense with a bran=
ch name"
@@ -2579,7 +2578,7 @@ msgstr "ansprechende Anzeige des Objektinhaltes"
=20
 #: builtin/cat-file.c:273
 msgid "for blob objects, run textconv on object's content"
-msgstr "f=C3=BCr Blob-Objekte, f=C3=BChrt \"textconv\" auf den Objekti=
nhalt aus"
+msgstr "f=C3=BChrt eine Textkonvertierung auf den Inhalt von Blob-Obje=
kten aus"
=20
 #: builtin/cat-file.c:275
 msgid "show info and content of objects fed from the standard input"
@@ -2656,11 +2655,11 @@ msgstr "Zeichenkette"
=20
 #: builtin/checkout-index.c:204
 msgid "when creating files, prepend <string>"
-msgstr "wenn Dateien erzeugt werden, stelle <Zeichenkette> voran"
+msgstr "wenn Dateien erzeugt werden, stelle <Zeichenkette> dem Dateina=
men voran"
=20
 #: builtin/checkout-index.c:207
 msgid "copy out the files from named stage"
-msgstr "kopiert Dateien von einer benannten Bereitstellung"
+msgstr "kopiert Dateien von dem benannten Stand"
=20
 #: builtin/checkout.c:25
 msgid "git checkout [options] <branch>"
@@ -2704,7 +2703,7 @@ msgstr "Konnte Ergebnis der Zusammenf=C3=BChrung =
von '%s' nicht hinzuf=C3=BCgen."
 #: builtin/checkout.c:245
 #, c-format
 msgid "'%s' cannot be used with updating paths"
-msgstr "'%s' kann nicht mit der Aktualisierung von Pfaden benutzt werd=
en"
+msgstr "'%s' kann nicht mit Pfaden benutzt werden"
=20
 #: builtin/checkout.c:248 builtin/checkout.c:251
 #, c-format
@@ -2875,15 +2874,15 @@ msgstr "erzeugt/setzt neu und checkt einen Zwei=
g aus"
=20
 #: builtin/checkout.c:1014
 msgid "create reflog for new branch"
-msgstr "erzeugt Referenzprotokoll f=C3=BCr einen neuen Zweig"
+msgstr "erzeugt Referenzprotokoll f=C3=BCr den neuen Zweig"
=20
 #: builtin/checkout.c:1015
 msgid "detach the HEAD at named commit"
-msgstr "l=C3=B6st die Zweigspitze (HEAD) zu benannter Version"
+msgstr "setzt die Zweigspitze (HEAD) zu benannter Version"
=20
 #: builtin/checkout.c:1016
 msgid "set upstream info for new branch"
-msgstr "setzt Informationen zum externen =C3=9Cbernahmezweig f=C3=BCr =
einen neuen Zweig"
+msgstr "setzt Informationen zum externen =C3=9Cbernahmezweig f=C3=BCr =
den neuen Zweig"
=20
 #: builtin/checkout.c:1018
 msgid "new branch"
@@ -2895,11 +2894,11 @@ msgstr "neuer Zweig ohne Elternversion"
=20
 #: builtin/checkout.c:1019
 msgid "checkout our version for unmerged files"
-msgstr "checkt unsere Version f=C3=BCr nicht zusammengef=C3=BChrte Dat=
eien aus"
+msgstr "checkt unsere Variante f=C3=BCr nicht zusammengef=C3=BChrte Da=
teien aus"
=20
 #: builtin/checkout.c:1021
 msgid "checkout their version for unmerged files"
-msgstr "checkt ihre Version f=C3=BCr nicht zusammengef=C3=BChrte Datei=
en aus"
+msgstr "checkt ihre Variante f=C3=BCr nicht zusammengef=C3=BChrte Date=
ien aus"
=20
 #: builtin/checkout.c:1023
 msgid "force checkout (throw away local modifications)"
@@ -2907,7 +2906,7 @@ msgstr "erzwingt Auschecken (verwirft lokale =C3=84=
nderungen)"
=20
 #: builtin/checkout.c:1024
 msgid "perform a 3-way merge with the new branch"
-msgstr "f=C3=BChrt eine 3-Wege-Zusammenf=C3=BChrung mit einem neuen Zw=
eig aus"
+msgstr "f=C3=BChrt eine 3-Wege-Zusammenf=C3=BChrung mit dem neuen Zwei=
g aus"
=20
 #: builtin/checkout.c:1025 builtin/merge.c:215
 msgid "update ignored files (default)"
@@ -2923,7 +2922,7 @@ msgstr "Konfliktstil (merge oder diff3)"
=20
 #: builtin/checkout.c:1030
 msgid "second guess 'git checkout no-such-branch'"
-msgstr "zweite Vermutung 'git checkout no-such-branch'"
+msgstr "second guess 'git checkout no-such-branch'"
=20
 #: builtin/checkout.c:1054
 msgid "-b, -B and --orphan are mutually exclusive"
@@ -2970,7 +2969,7 @@ msgstr "git clean [-d] [-f] [-n] [-q] [-e <Muster=
>] [-x | -X] [--] <Pfade>..."
=20
 #: builtin/clean.c:51
 msgid "do not print names of files removed"
-msgstr "gibt keine Namen von entfernten Dateien aus"
+msgstr "gibt keine Namen von gel=C3=B6schten Dateien aus"
=20
 #: builtin/clean.c:53
 msgid "force"
@@ -2978,7 +2977,7 @@ msgstr "erzwingt Aktion"
=20
 #: builtin/clean.c:55
 msgid "remove whole directories"
-msgstr "entfernt ganze Verzeichnisse"
+msgstr "l=C3=B6scht ganze Verzeichnisse"
=20
 #: builtin/clean.c:56 builtin/describe.c:413 builtin/grep.c:802
 #: builtin/ls-files.c:491 builtin/name-rev.c:231 builtin/show-ref.c:19=
9
@@ -2991,11 +2990,11 @@ msgstr "f=C3=BCgt <Muster> zu den Regeln f=C3=BC=
r ignorierte Pfade hinzu"
=20
 #: builtin/clean.c:58
 msgid "remove ignored files, too"
-msgstr "entfernt auch ignorierte Dateien"
+msgstr "l=C3=B6scht auch ignorierte Dateien"
=20
 #: builtin/clean.c:60
 msgid "remove only ignored files"
-msgstr "entfernt nur ignorierte Dateien"
+msgstr "l=C3=B6scht nur ignorierte Dateien"
=20
 #: builtin/clean.c:78
 msgid "-x and -X cannot be used together"
@@ -3019,22 +3018,22 @@ msgstr ""
 #: builtin/clean.c:155 builtin/clean.c:176
 #, c-format
 msgid "Would remove %s\n"
-msgstr "W=C3=BCrde %s entfernen\n"
+msgstr "W=C3=BCrde %s l=C3=B6schen\n"
=20
 #: builtin/clean.c:159 builtin/clean.c:179
 #, c-format
 msgid "Removing %s\n"
-msgstr "Entferne %s\n"
+msgstr "L=C3=B6sche %s\n"
=20
 #: builtin/clean.c:162 builtin/clean.c:182
 #, c-format
 msgid "failed to remove %s"
-msgstr "Fehler beim Entfernen von %s"
+msgstr "Fehler beim L=C3=B6schen von %s"
=20
 #: builtin/clean.c:166
 #, c-format
 msgid "Would not remove %s\n"
-msgstr "W=C3=BCrde nicht entfernen %s\n"
+msgstr "W=C3=BCrde '%s' nicht l=C3=B6schen\n"
=20
 #: builtin/clean.c:168
 #, c-format
@@ -3068,7 +3067,7 @@ msgstr "um von einem lokalen Projektarchiv zu klo=
nen"
=20
 #: builtin/clone.c:76
 msgid "don't use local hardlinks, always copy"
-msgstr "benutzt lokal keine harten Verkn=C3=BCpfungen, immer Kopien"
+msgstr "benutzt lokal keine harten Links, immer Kopien"
=20
 #: builtin/clone.c:78
 msgid "setup as shared repository"
@@ -3121,7 +3120,7 @@ msgstr "klont nur einen Zweig, Zweigspitze (HEAD)=
 oder --branch"
=20
 #: builtin/clone.c:97 builtin/init-db.c:494
 msgid "gitdir"
-msgstr "Git-Verzeichnis"
+msgstr ".git-Verzeichnis"
=20
 #: builtin/clone.c:98 builtin/init-db.c:495
 msgid "separate git dir from working tree"
@@ -3262,7 +3261,7 @@ msgstr "schl=C3=A4gt Konfigurationsvariablen nach=
"
=20
 #: builtin/column.c:27 builtin/column.c:28
 msgid "layout to use"
-msgstr "zu verwendender Aufbau"
+msgstr "zu verwendende Anordnung"
=20
 #: builtin/column.c:29
 msgid "Maximum width"
@@ -3270,11 +3269,11 @@ msgstr "maximale Breite"
=20
 #: builtin/column.c:30
 msgid "Padding space on left border"
-msgstr "Abstand zur linken Grenze"
+msgstr "Abstand zum linken Rand"
=20
 #: builtin/column.c:31
 msgid "Padding space on right border"
-msgstr "Abstand zur rechten Grenze"
+msgstr "Abstand zur rechten Rand"
=20
 #: builtin/column.c:32
 msgid "Padding space between columns"
@@ -3446,7 +3445,7 @@ msgid ""
 msgstr ""
 "\n"
 "Es sieht so aus, als tr=C3=A4gst du eine Zusammenf=C3=BChrung ein.\n"
-"Falls das nicht korrekt ist, entferne bitte die Datei\n"
+"Falls das nicht korrekt ist, l=C3=B6sche bitte die Datei\n"
 "\t%s\n"
 "und versuche es erneut.\n"
=20
@@ -3461,7 +3460,7 @@ msgid ""
 msgstr ""
 "\n"
 "Es sieht so aus, als tr=C3=A4gst du ein \"cherry-pick\" ein.\n"
-"Falls das nicht korrekt ist, entferne bitte die Datei\n"
+"Falls das nicht korrekt ist, l=C3=B6sche bitte die Datei\n"
 "\t%s\n"
 "und versuche es erneut.\n"
=20
@@ -3707,7 +3706,7 @@ msgstr ""
=20
 #: builtin/commit.c:1399
 msgid "the commit is authored by me now (used with -C/-c/--amend)"
-msgstr "diese Version ist jetzt von mir verfasst (benutzt mit -C/-c/--=
amend)"
+msgstr "Setze mich als Autor der Version (benutzt mit -C/-c/--amend)"
=20
 #: builtin/commit.c:1400 builtin/log.c:1068 builtin/revert.c:109
 msgid "add Signed-off-by:"
@@ -3753,7 +3752,7 @@ msgstr "tr=C3=A4gt alle ge=C3=A4nderten Dateien e=
in"
=20
 #: builtin/commit.c:1411
 msgid "add specified files to index for commit"
-msgstr "stellt angegebene Dateien zur Eintragung bereit"
+msgstr "tr=C3=A4gt die angegebenen Dateien zus=C3=A4tzlich zur Bereits=
tellung ein"
=20
 #: builtin/commit.c:1412
 msgid "interactively add files"
@@ -4061,7 +4060,7 @@ msgstr "benutzt jede Referenz in .git/refs"
=20
 #: builtin/describe.c:406
 msgid "use any tag in .git/refs/tags"
-msgstr "benutzt jede Markierung in .git/refs/tags"
+msgstr "benutzt alle Markierungen in .git/refs/tags"
=20
 #: builtin/describe.c:407
 msgid "always use long format"
@@ -4081,7 +4080,7 @@ msgstr "betrachtet nur Markierungen die <Muster> =
entsprechen"
=20
 #: builtin/describe.c:416 builtin/name-rev.c:238
 msgid "show abbreviated commit object as fallback"
-msgstr "zeigt als Reserve gek=C3=BCrztes Versionsobjekt"
+msgstr "zeigt gek=C3=BCrztes Versionsobjekt, wenn sonst nichts zutriff=
t"
=20
 #: builtin/describe.c:417
 msgid "mark"
@@ -4156,7 +4155,7 @@ msgstr "w=C3=A4hlt Behandlung von Markierungen, d=
ie gefilterte Objekte markieren"
=20
 #: builtin/fast-export.c:643
 msgid "Dump marks to this file"
-msgstr "Anzeige von Kennzeichen f=C3=BCr diese Datei"
+msgstr "Schreibt Kennzeichen in diese Datei"
=20
 #: builtin/fast-export.c:645
 msgid "Import marks from this file"
@@ -4336,7 +4335,7 @@ msgid ""
 " 'git remote prune %s' to remove any old, conflicting branches"
 msgstr ""
 "Einige lokale Referenzen konnten nicht aktualisiert werden; versuche\=
n"
-"'git remote prune %s' um jeden =C3=A4lteren, widerspr=C3=BCchlichen Z=
weig zu entfernen."
+"'git remote prune %s' um jeden =C3=A4lteren, widerspr=C3=BCchlichen Z=
weig zu l=C3=B6schen."
=20
 #: builtin/fetch.c:550
 #, c-format
@@ -4584,7 +4583,7 @@ msgid ""
 "There are too many unreachable loose objects; run 'git prune' to remo=
ve them."
 msgstr ""
 "Es gibt zu viele unerreichbare lose Objekte; f=C3=BChre 'git prune' a=
us, um diese "
-"zu entfernen."
+"zu l=C3=B6schen."
=20
 #: builtin/grep.c:22
 msgid "git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...]"
@@ -5668,7 +5667,7 @@ msgstr "zeigt Objektnamen von Inhalten in der Ber=
eitstellung in der Ausgabe an"
=20
 #: builtin/ls-files.c:480
 msgid "show files on the filesystem that need to be removed"
-msgstr "zeigt Dateien im Dateisystem, die entfernt werden m=C3=BCssen,=
 an"
+msgstr "zeigt Dateien im Dateisystem, die gel=C3=B6scht werden m=C3=BC=
ssen, an"
=20
 #: builtin/ls-files.c:482
 msgid "show 'other' directories' name only"
@@ -5719,7 +5718,7 @@ msgstr "Versionsreferenz"
 #: builtin/ls-files.c:508
 msgid "pretend that paths removed since <tree-ish> are still present"
 msgstr ""
-"gibt vor, dass Pfade, die seit <Versionsreferenz> entfernt wurden, im=
mer "
+"gibt vor, dass Pfade, die seit <Versionsreferenz> gel=C3=B6scht wurde=
n, immer "
 "noch vorhanden sind"
=20
 #: builtin/ls-files.c:510
@@ -6651,7 +6650,7 @@ msgstr "Objekt %s hat keine Notiz\n"
 #: builtin/notes.c:983
 msgid "attempt to remove non-existent note is not an error"
 msgstr ""
-"der Versuch, eine nicht existierende Notiz zu entfernen, ist kein Feh=
ler"
+"der Versuch, eine nicht existierende Notiz zu l=C3=B6schen, ist kein =
=46ehler"
=20
 #: builtin/notes.c:986
 msgid "read object names from the standard input"
@@ -6854,11 +6853,11 @@ msgstr "git prune [-n] [-v] [--expire <Zeit>] [=
--] [<Zweigspitze>...]"
=20
 #: builtin/prune.c:132
 msgid "do not remove, show only"
-msgstr "nicht entfernen, nur anzeigen"
+msgstr "nicht l=C3=B6schen, nur anzeigen"
=20
 #: builtin/prune.c:133
 msgid "report pruned objects"
-msgstr "meldet entfernte Objekte"
+msgstr "meldet gel=C3=B6schte Objekte"
=20
 #: builtin/prune.c:136
 msgid "expire objects older than <time>"
@@ -7460,7 +7459,7 @@ msgstr "Konnte '%s' nicht erstellen"
 #: builtin/remote.c:764
 #, c-format
 msgid "Could not remove branch %s"
-msgstr "Konnte Zweig %s nicht entfernen"
+msgstr "Konnte Zweig %s nicht l=C3=B6schen"
=20
 #: builtin/remote.c:834
 msgid ""
@@ -7471,8 +7470,8 @@ msgid_plural ""
 "to delete them, use:"
 msgstr[0] ""
 "Hinweis: Ein Zweig au=C3=9Ferhalb der /refs/remotes/ Hierachie wurde =
nicht "
-"entfernt;\n"
-"um diesen zu entfernen, benutze:"
+"gel=C3=B6scht;\n"
+"um diesen zu l=C3=B6schen, benutze:"
 msgstr[1] ""
 "Hinweis: Einige Zweige au=C3=9Fer der /refs/remotes/ Hierarchie wurde=
n nicht "
 "entfernt;\n"
@@ -7489,7 +7488,7 @@ msgstr " gefolgt"
=20
 #: builtin/remote.c:948
 msgid " stale (use 'git remote prune' to remove)"
-msgstr " veraltet (benutze 'git remote prune' zum Entfernen)"
+msgstr " veraltet (benutze 'git remote prune' zum L=C3=B6schen)"
=20
 #: builtin/remote.c:950
 msgid " ???"
@@ -8044,7 +8043,7 @@ msgstr ""
=20
 #: builtin/rm.c:134
 msgid "do not list removed files"
-msgstr "listet keine entfernten Dateien auf"
+msgstr "listet keine gel=C3=B6schten Dateien auf"
=20
 #: builtin/rm.c:135
 msgid "only remove from the index"
@@ -8070,7 +8069,7 @@ msgstr "'%s' wird nicht ohne -r rekursiv entfernt=
"
 #: builtin/rm.c:230
 #, c-format
 msgid "git rm: unable to remove %s"
-msgstr "git rm: konnte %s nicht entfernen"
+msgstr "git rm: konnte %s nicht l=C3=B6schen"
=20
 #: builtin/shortlog.c:13
 msgid "git shortlog [-n] [-s] [-e] [-w] [rev-opts] [--] [<commit-id>..=
=2E ]"
@@ -8552,7 +8551,7 @@ msgstr ""
=20
 #: builtin/update-index.c:764
 msgid "remove named paths even if present in worktree"
-msgstr "entfernt benannte Pfade, auch wenn sie sich im Arbeitsbaum bef=
inden"
+msgstr "l=C3=B6scht benannte Pfade, auch wenn sie sich im Arbeitsbaum =
befinden"
=20
 #: builtin/update-index.c:766
 msgid "with --stdin: input lines are terminated by null bytes"
@@ -9297,7 +9296,7 @@ msgstr "Keine =C3=84nderungen ausgew=C3=A4hlt"
=20
 #: git-stash.sh:143
 msgid "Cannot remove temporary index (can't happen)"
-msgstr "Kann tempor=C3=A4re Bereitstellung nicht entfernen (kann nicht=
 passieren)"
+msgstr "Kann tempor=C3=A4re Bereitstellung nicht l=C3=B6schen (kann ni=
cht passieren)"
=20
 #: git-stash.sh:156
 msgid "Cannot record working tree state"
@@ -9337,7 +9336,7 @@ msgstr "Kann den aktuellen Status nicht speichern=
"
=20
 #: git-stash.sh:253
 msgid "Cannot remove worktree changes"
-msgstr "Kann =C3=84nderungen am Arbeitsbaum nicht entfernen"
+msgstr "Kann =C3=84nderungen am Arbeitsbaum nicht l=C3=B6schen"
=20
 #: git-stash.sh:352
 msgid "No stash found."
--=20
1.8.0.rc0.18.gf84667d

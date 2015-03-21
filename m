From: Phillip Sz <phillip.szelat@gmail.com>
Subject: [PATCH 1/1] =?UTF-8?q?l10n:=20de.po:=20use=20"bla=20=E2=80=A6"=20?= =?UTF-8?q?instead=20of=20"bla..."?=
Date: Sat, 21 Mar 2015 13:52:37 +0100
Message-ID: <1426942357-5618-1-git-send-email-phillip.szelat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	ralf.thielow@gmail.com, Phillip Sz <phillip.szelat@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 13:52:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZItb-0007WC-TB
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 13:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbbCUMwv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2015 08:52:51 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38824 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbbCUMwt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 08:52:49 -0400
Received: by wibgn9 with SMTP id gn9so13116238wib.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2015 05:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=PttnECC4+ii+DbkdE6SPqwpEFmGtdmLlrWtAonalhLg=;
        b=QBCyeUnDHQpzCiSFKiWrwf/YacxJHFU8LUo0jQoYSRY4p9KzY0ypTEjTmMkhQWoixL
         TjcFMadcftehtTu9z04ojHk8KZbCr6V6+w+OGQKCUw0jDUcjhfop4HuLzXuXOLHxlNqO
         enwV2tyMprPo14csn9q/3zXG7f5p3h1L+7q5NlvCZ0du/w1XmfPD+HUutKi9itRYaJx3
         IWqmCU6iOc5RLFiQENf3FpYztNeza/m4dX+q05YgmbV66Xa29QQZRQJgjuE4ZRSQrs/I
         JAbbkLQpBGGZXbwidyL8rnWsTk4EdZKlTvE5i/V7qJ7HJwW/aLzVNLMrWnlNCXne607O
         GLlg==
X-Received: by 10.194.174.164 with SMTP id bt4mr135398770wjc.155.1426942367599;
        Sat, 21 Mar 2015 05:52:47 -0700 (PDT)
Received: from phillip.fritz.box (i59F45558.versanet.de. [89.244.85.88])
        by mx.google.com with ESMTPSA id fo8sm2240818wib.14.2015.03.21.05.52.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 Mar 2015 05:52:46 -0700 (PDT)
X-Mailer: git-send-email 2.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266019>

Hi,

I think we should use it like this, as most open-source projects do.=20
Also we should use a space before the three dots as per http://www.dude=
n.de/sprachwissen/rechtschreibregeln/auslassungspunkte

Phillip

Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
---
 po/de.po | 190 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 95 insertions(+), 95 deletions(-)

diff --git a/po/de.po b/po/de.po
index 11fbd0f..4c1e90e 100644
--- a/po/de.po
+++ b/po/de.po
@@ -33,7 +33,7 @@ msgstr ""
=20
 #: archive.c:11
 msgid "git archive [options] <tree-ish> [<path>...]"
-msgstr "git archive [Optionen] <Commit-Referenz> [<Pfad>...]"
+msgstr "git archive [Optionen] <Commit-Referenz> [<Pfad> =E2=80=A6]"
=20
 #: archive.c:12
 msgid "git archive --list"
@@ -44,7 +44,7 @@ msgid ""
 "git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [<pat=
h>...]"
 msgstr ""
 "git archive --remote <Repository> [--exec <Programm>] [Optionen] <Com=
mit-"
-"Referenz> [Pfad...]"
+"Referenz> [Pfad =E2=80=A6]"
=20
 #: archive.c:14
 msgid "git archive --remote <repo> [--exec <cmd>] --list"
@@ -616,7 +616,7 @@ msgstr ""
 #: help.c:373
 #, c-format
 msgid "in %0.1f seconds automatically..."
-msgstr "Automatische Ausf=C3=BChrung in %0.1f Sekunden..."
+msgstr "Automatische Ausf=C3=BChrung in %0.1f Sekunden =E2=80=A6"
=20
 #: help.c:380
 #, c-format
@@ -945,7 +945,7 @@ msgstr "Konnte Objekt '%s' nicht parsen."
=20
 #: parse-options.c:546
 msgid "..."
-msgstr "..."
+msgstr " =E2=80=A6"
=20
 #: parse-options.c:564
 #, c-format
@@ -1271,12 +1271,12 @@ msgstr "Kann keine Commit-Beschreibung f=C3=BCr=
 %s bekommen"
 #: sequencer.c:611
 #, c-format
 msgid "could not revert %s... %s"
-msgstr "Konnte \"revert\" nicht auf %s ausf=C3=BChren... %s"
+msgstr "Konnte \"revert\" nicht auf %s ausf=C3=BChren =E2=80=A6 %s"
=20
 #: sequencer.c:612
 #, c-format
 msgid "could not apply %s... %s"
-msgstr "Konnte %s nicht anwenden... %s"
+msgstr "Konnte %s nicht anwenden =E2=80=A6 %s"
=20
 #: sequencer.c:648
 msgid "empty commit set passed"
@@ -1425,7 +1425,7 @@ msgstr ""
 "Sie diese angeben. Diese Referenzen k=C3=B6nnten aus Versehen\n"
 "erzeugt worden sein. Zum Beispiel,\n"
 "\n"
-"  git checkout -b $br $(git rev-parse ...)\n"
+"  git checkout -b $br $(git rev-parse =E2=80=A6)\n"
 "\n"
 "wobei \"$br\" leer ist und eine 40-Hex-Referenz erzeugt\n"
 "wurde. Bitte pr=C3=BCfen Sie diese Referenzen und l=C3=B6schen\n"
@@ -1576,30 +1576,30 @@ msgstr "Nicht zusammengef=C3=BChrte Pfade:"
 #, c-format
 msgid "  (use \"git reset %s <file>...\" to unstage)"
 msgstr ""
-"  (benutzen Sie \"git reset %s <Datei>...\" zum Entfernen aus der Sta=
ging-"
+"  (benutzen Sie \"git reset %s <Datei> =E2=80=A6\" zum Entfernen aus =
der Staging-"
 "Area)"
=20
 #: wt-status.c:179 wt-status.c:206
 msgid "  (use \"git rm --cached <file>...\" to unstage)"
 msgstr ""
-"  (benutzen Sie \"git rm --cached <Datei>...\" zum Entfernen aus der =
Staging-"
+"  (benutzen Sie \"git rm --cached <Datei> =E2=80=A6\" zum Entfernen a=
us der Staging-"
 "Area)"
=20
 #: wt-status.c:183
 msgid "  (use \"git add <file>...\" to mark resolution)"
 msgstr ""
-"  (benutzen Sie \"git add/rm <Datei>...\", um die Aufl=C3=B6sung zu m=
arkieren)"
+"  (benutzen Sie \"git add/rm <Datei> =E2=80=A6\", um die Aufl=C3=B6su=
ng zu markieren)"
=20
 #: wt-status.c:185 wt-status.c:189
 msgid "  (use \"git add/rm <file>...\" as appropriate to mark resoluti=
on)"
 msgstr ""
-"  (benutzen Sie \"git add/rm <Datei>...\", um die Aufl=C3=B6sung ents=
prechend zu "
+"  (benutzen Sie \"git add/rm <Datei> =E2=80=A6\", um die Aufl=C3=B6su=
ng entsprechend zu "
 "markieren)"
=20
 #: wt-status.c:187
 msgid "  (use \"git rm <file>...\" to mark resolution)"
 msgstr ""
-"  (benutzen Sie \"git add/rm <Datei>...\", um die Aufl=C3=B6sung zu m=
arkieren)"
+"  (benutzen Sie \"git add/rm <Datei> =E2=80=A6\", um die Aufl=C3=B6su=
ng zu markieren)"
=20
 #: wt-status.c:198
 msgid "Changes to be committed:"
@@ -1612,20 +1612,20 @@ msgstr "=C3=84nderungen, die nicht zum Commit v=
orgemerkt sind:"
 #: wt-status.c:220
 msgid "  (use \"git add <file>...\" to update what will be committed)"
 msgstr ""
-"  (benutzen Sie \"git add <Datei>...\", um die =C3=84nderungen zum Co=
mmit "
+"  (benutzen Sie \"git add <Datei> =E2=80=A6\", um die =C3=84nderungen=
 zum Commit "
 "vorzumerken)"
=20
 #: wt-status.c:222
 msgid "  (use \"git add/rm <file>...\" to update what will be committe=
d)"
 msgstr ""
-"  (benutzen Sie \"git add/rm <Datei>...\", um die =C3=84nderungen zum=
 Commit "
+"  (benutzen Sie \"git add/rm <Datei> =E2=80=A6\", um die =C3=84nderun=
gen zum Commit "
 "vorzumerken)"
=20
 #: wt-status.c:223
 msgid ""
 "  (use \"git checkout -- <file>...\" to discard changes in working di=
rectory)"
 msgstr ""
-"  (benutzen Sie \"git checkout -- <Datei>...\", um die =C3=84nderunge=
n im "
+"  (benutzen Sie \"git checkout -- <Datei> =E2=80=A6\", um die =C3=84n=
derungen im "
 "Arbeitsverzeichnis zu verwerfen)"
=20
 #: wt-status.c:225
@@ -1638,7 +1638,7 @@ msgstr ""
 #, c-format
 msgid "  (use \"git %s <file>...\" to include in what will be committe=
d)"
 msgstr ""
-"  (benutzen Sie \"git %s <Datei>...\", um die =C3=84nderungen zum Com=
mit "
+"  (benutzen Sie \"git %s <Datei> =E2=80=A6\", um die =C3=84nderungen =
zum Commit "
 "vorzumerken)"
=20
 #: wt-status.c:252
@@ -2035,7 +2035,7 @@ msgstr "Konnte '%s' nicht entfernen."
=20
 #: builtin/add.c:22
 msgid "git add [options] [--] <pathspec>..."
-msgstr "git add [Optionen] [--] [<Pfadspezifikation>...]"
+msgstr "git add [Optionen] [--] [<Pfadspezifikation> =E2=80=A6]"
=20
 #: builtin/add.c:65
 #, c-format
@@ -2187,7 +2187,7 @@ msgstr "Konnte neue Staging-Area-Datei nicht schr=
eiben."
=20
 #: builtin/apply.c:58
 msgid "git apply [options] [<patch>...]"
-msgstr "git apply [Optionen] [<Patch>...]"
+msgstr "git apply [Optionen] [<Patch> =E2=80=A6]"
=20
 #: builtin/apply.c:111
 #, c-format
@@ -2436,7 +2436,7 @@ msgstr "%s: Patch konnte nicht angewendet werden"
 #: builtin/apply.c:3653
 #, c-format
 msgid "Checking patch %s..."
-msgstr "Pr=C3=BCfe Patch %s..."
+msgstr "Pr=C3=BCfe Patch %s =E2=80=A6"
=20
 #: builtin/apply.c:3746 builtin/checkout.c:231 builtin/reset.c:135
 #, c-format
@@ -2848,7 +2848,7 @@ msgstr "git branch [Optionen] [-l] [-f] <Branchna=
me> [<Startpunkt>]"
=20
 #: builtin/branch.c:26
 msgid "git branch [options] [-r] (-d | -D) <branchname>..."
-msgstr "git branch [Optionen] [-r] (-d | -D) <Branchname>..."
+msgstr "git branch [Optionen] [-r] (-d | -D) <Branchname> =E2=80=A6"
=20
 #: builtin/branch.c:27
 msgid "git branch [options] (-m | -M) [<oldbranch>] <newbranch>"
@@ -3318,12 +3318,12 @@ msgstr ""
=20
 #: builtin/check-attr.c:11
 msgid "git check-attr [-a | --all | attr...] [--] pathname..."
-msgstr "git check-attr [-a | --all | Attribut...] [--] Pfadname..."
+msgstr "git check-attr [-a | --all | Attribut =E2=80=A6] [--] Pfadname=
 =E2=80=A6"
=20
 #: builtin/check-attr.c:12
 msgid "git check-attr --stdin [-z] [-a | --all | attr...] < <list-of-p=
aths>"
 msgstr ""
-"git check-attr --stdin [-z] [-a | --all | Attribut...] < <Liste-von-P=
faden>"
+"git check-attr --stdin [-z] [-a | --all | Attribut =E2=80=A6] < <List=
e-von-Pfaden>"
=20
 #: builtin/check-attr.c:19
 msgid "report all attributes set on file"
@@ -3380,7 +3380,7 @@ msgstr "--non-matching ist nur mit --verbose zul=C3=
=A4ssig"
=20
 #: builtin/check-mailmap.c:8
 msgid "git check-mailmap [options] <contact>..."
-msgstr "git check-mailmap [Optionen] <Kontakt>..."
+msgstr "git check-mailmap [Optionen] <Kontakt> =E2=80=A6"
=20
 #: builtin/check-mailmap.c:13
 msgid "also read contacts from stdin"
@@ -3397,7 +3397,7 @@ msgstr "keine Kontakte angegeben"
=20
 #: builtin/checkout-index.c:126
 msgid "git checkout-index [options] [--] [<file>...]"
-msgstr "git checkout-index [Optionen] [--] [<Datei>...]"
+msgstr "git checkout-index [Optionen] [--] [<Datei> =E2=80=A6]"
=20
 #: builtin/checkout-index.c:188
 msgid "check out all files in the index"
@@ -3448,7 +3448,7 @@ msgstr "git checkout [Optionen] <Branch>"
=20
 #: builtin/checkout.c:26
 msgid "git checkout [options] [<branch>] -- <file>..."
-msgstr "git checkout [Optionen] [<Branch>] -- <Datei>..."
+msgstr "git checkout [Optionen] [<Branch>] -- <Datei> =E2=80=A6"
=20
 #: builtin/checkout.c:132 builtin/checkout.c:165
 #, c-format
@@ -3547,7 +3547,7 @@ msgstr "Zu Branch '%s' gewechselt\n"
 #: builtin/checkout.c:723
 #, c-format
 msgid " ... and %d more.\n"
-msgstr " ... und %d weitere.\n"
+msgstr " =E2=80=A6 und %d weitere.\n"
=20
 #: builtin/checkout.c:729
 #, c-format
@@ -3746,7 +3746,7 @@ msgstr ""
 msgid ""
 "git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <pat=
hs>..."
 msgstr ""
-"git clean [-d] [-f] [-i] [-n] [-q] [-e <Muster>] [-x | -X] [--] <Pfad=
e>..."
+"git clean [-d] [-f] [-i] [-n] [-q] [-e <Muster>] [-x | -X] [--] <Pfad=
e> =E2=80=A6"
=20
 #: builtin/clean.c:30
 #, c-format
@@ -4091,7 +4091,7 @@ msgstr "Konnte zu klonenden Remote-Branch %s nich=
t finden."
 #: builtin/clone.c:561
 #, c-format
 msgid "Checking connectivity... "
-msgstr "Pr=C3=BCfe Konnektivit=C3=A4t... "
+msgstr "Pr=C3=BCfe Konnektivit=C3=A4t =E2=80=A6 "
=20
 #: builtin/clone.c:564
 msgid "remote did not send all necessary objects"
@@ -4165,12 +4165,12 @@ msgstr "Konnte Arbeitsverzeichnis '%s' nicht er=
stellen."
 #: builtin/clone.c:870
 #, c-format
 msgid "Cloning into bare repository '%s'...\n"
-msgstr "Klone in Bare-Repository '%s'...\n"
+msgstr "Klone in Bare-Repository '%s' =E2=80=A6\n"
=20
 #: builtin/clone.c:872
 #, c-format
 msgid "Cloning into '%s'...\n"
-msgstr "Klone nach '%s'...\n"
+msgstr "Klone nach '%s' =E2=80=A6\n"
=20
 #: builtin/clone.c:897
 msgid "--dissociate given, but there is no --reference"
@@ -4240,11 +4240,11 @@ msgstr "Die Option --command muss an erster Ste=
lle stehen."
=20
 #: builtin/commit.c:37
 msgid "git commit [options] [--] <pathspec>..."
-msgstr "git commit [Optionen] [--] <Pfadspezifikation>..."
+msgstr "git commit [Optionen] [--] <Pfadspezifikation> =E2=80=A6"
=20
 #: builtin/commit.c:42
 msgid "git status [options] [--] <pathspec>..."
-msgstr "git status [Optionen] [--] <Pfadspezifikation>..."
+msgstr "git status [Optionen] [--] <Pfadspezifikation> =E2=80=A6"
=20
 #: builtin/commit.c:47
 msgid ""
@@ -4600,7 +4600,7 @@ msgstr ""
 #: builtin/commit.c:1199
 msgid "Clever... amending the last one with dirty index."
 msgstr ""
-"Klug... den letzten Commit mit einer ge=C3=A4nderten Staging-Area nac=
hbessern."
+"Klug =E2=80=A6 den letzten Commit mit einer ge=C3=A4nderten Staging-A=
rea nachbessern."
=20
 #: builtin/commit.c:1201
 msgid "Explicit paths specified without -i or -o; assuming --only path=
s..."
@@ -5258,7 +5258,7 @@ msgstr "Ausgabe anonymisieren"
=20
 #: builtin/fetch.c:20
 msgid "git fetch [<options>] [<repository> [<refspec>...]]"
-msgstr "git fetch [<Optionen>] [<Repository> [<Refspec>...]]"
+msgstr "git fetch [<Optionen>] [<Repository> [<Refspec> =E2=80=A6]]"
=20
 #: builtin/fetch.c:21
 msgid "git fetch [<options>] <group>"
@@ -5266,7 +5266,7 @@ msgstr "git fetch [<Optionen>] <Gruppe>"
=20
 #: builtin/fetch.c:22
 msgid "git fetch --multiple [<options>] [(<repository> | <group>)...]"
-msgstr "git fetch --multiple [<Optionen>] [(<Repository> | <Gruppe>)..=
=2E]"
+msgstr "git fetch --multiple [<Optionen>] [(<Repository> | <Gruppe>) =E2=
=80=A6]"
=20
 #: builtin/fetch.c:23
 msgid "git fetch --all [<options>]"
@@ -5620,7 +5620,7 @@ msgstr "Pr=C3=BCfe Objekt-Verzeichnisse"
=20
 #: builtin/fsck.c:603
 msgid "git fsck [options] [<object>...]"
-msgstr "git fsck [Optionen] [<Objekt>...]"
+msgstr "git fsck [Optionen] [<Objekt> =E2=80=A6]"
=20
 #: builtin/fsck.c:609
 msgid "show unreachable objects"
@@ -5734,7 +5734,7 @@ msgstr ""
=20
 #: builtin/grep.c:23
 msgid "git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...]"
-msgstr "git grep [Optionen] [-e] <Muster> [<Commit>...] [[--] <Pfad>..=
=2E]"
+msgstr "git grep [Optionen] [-e] <Muster> [<Commit> =E2=80=A6] [[--] <=
Pfad> =E2=80=A6]"
=20
 #: builtin/grep.c:218
 #, c-format
@@ -5972,10 +5972,10 @@ msgstr "Die Option --cached kann nicht mit \"Tr=
ee\"-Objekten verwendet werden."
 #: builtin/hash-object.c:82
 msgid ""
 "git hash-object [-t <type>] [-w] [--path=3D<file>|--no-filters] [--st=
din] [--] "
-"<file>..."
+"<file> =E2=80=A6"
 msgstr ""
 "git hash-object [-t <Art>] [-w] [--path=3D<Datei>|--no-filters] [--st=
din] [--] "
-"<Datei>..."
+"<Datei> =E2=80=A6"
=20
 #: builtin/hash-object.c:83
 msgid "git hash-object  --stdin-paths < <list-of-paths>"
@@ -6576,11 +6576,11 @@ msgstr "Kann nicht auf Arbeitsverzeichnis '%s' =
zugreifen."
=20
 #: builtin/interpret-trailers.c:15
 msgid ""
-"git interpret-trailers [--trim-empty] [(--trailer <token>[(=3D|:)<val=
ue>])...] "
-"[<file>...]"
+"git interpret-trailers [--trim-empty] [(--trailer <token>[(=3D|:)<val=
ue>]) =E2=80=A6] "
+"[<file> =E2=80=A6]"
 msgstr ""
-"git interpret-trailers [--trim-empty] [(--trailer <Token>[(=3D|:)<Wer=
t>])...] "
-"[<Datei>...]"
+"git interpret-trailers [--trim-empty] [(--trailer <Token>[(=3D|:)<Wer=
t>]) =E2=80=A6] "
+"[<Datei> =E2=80=A6]"
=20
 #: builtin/interpret-trailers.c:25
 msgid "trim empty trailers"
@@ -6596,11 +6596,11 @@ msgstr "Anhang/Anh=C3=A4nge hinzuf=C3=BCgen"
=20
 #: builtin/log.c:41
 msgid "git log [<options>] [<revision range>] [[--] <path>...]"
-msgstr "git log [<Optionen>] [<Commitbereich>] [[--] <Pfad>...]"
+msgstr "git log [<Optionen>] [<Commitbereich>] [[--] <Pfad> =E2=80=A6]=
"
=20
 #: builtin/log.c:42
 msgid "git show [options] <object>..."
-msgstr "git show [Optionen] <Objekt>..."
+msgstr "git show [Optionen] <Objekt> =E2=80=A6"
=20
 #: builtin/log.c:81
 #, c-format
@@ -6882,7 +6882,7 @@ msgstr "Unbekannter Commit %s"
=20
 #: builtin/ls-files.c:401
 msgid "git ls-files [options] [<file>...]"
-msgstr "git ls-files [Optionen] [<Datei>...]"
+msgstr "git ls-files [Optionen] [<Datei> =E2=80=A6]"
=20
 #: builtin/ls-files.c:458
 msgid "identify the file status with tags"
@@ -6981,7 +6981,7 @@ msgstr "Ausgaben zur Fehlersuche anzeigen"
=20
 #: builtin/ls-tree.c:28
 msgid "git ls-tree [<options>] <tree-ish> [<path>...]"
-msgstr "git ls-tree [<Optionen>] <Commit-Referenz> [<Pfad>...]"
+msgstr "git ls-tree [<Optionen>] <Commit-Referenz> [<Pfad> =E2=80=A6]"
=20
 #: builtin/ls-tree.c:127
 msgid "only show trees"
@@ -7019,7 +7019,7 @@ msgstr ""
=20
 #: builtin/merge.c:45
 msgid "git merge [options] [<commit>...]"
-msgstr "git merge [Optionen] [<Commit>...]"
+msgstr "git merge [Optionen] [<Commit> =E2=80=A6]"
=20
 #: builtin/merge.c:46
 msgid "git merge [options] <msg> HEAD <commit>"
@@ -7335,7 +7335,7 @@ msgstr "Aktualisiere %s..%s\n"
 #: builtin/merge.c:1388
 #, c-format
 msgid "Trying really trivial in-index merge...\n"
-msgstr "Probiere wirklich trivialen \"in-index\"-Merge...\n"
+msgstr "Probiere wirklich trivialen \"in-index\"-Merge =E2=80=A6\n"
=20
 #: builtin/merge.c:1395
 #, c-format
@@ -7349,12 +7349,12 @@ msgstr "Vorspulen nicht m=C3=B6glich, breche ab=
=2E"
 #: builtin/merge.c:1450 builtin/merge.c:1529
 #, c-format
 msgid "Rewinding the tree to pristine...\n"
-msgstr "R=C3=BCcklauf des Verzeichnisses bis zum Ursprung...\n"
+msgstr "R=C3=BCcklauf des Verzeichnisses bis zum Ursprung =E2=80=A6\n"
=20
 #: builtin/merge.c:1454
 #, c-format
 msgid "Trying merge strategy %s...\n"
-msgstr "Probiere Merge-Strategie %s...\n"
+msgstr "Probiere Merge-Strategie %s =E2=80=A6\n"
=20
 #: builtin/merge.c:1520
 #, c-format
@@ -7379,15 +7379,15 @@ msgstr ""
=20
 #: builtin/merge-base.c:29
 msgid "git merge-base [-a|--all] <commit> <commit>..."
-msgstr "git merge-base [-a|--all] <Commit> <Commit>..."
+msgstr "git merge-base [-a|--all] <Commit> <Commit> =E2=80=A6"
=20
 #: builtin/merge-base.c:30
 msgid "git merge-base [-a|--all] --octopus <commit>..."
-msgstr "git merge-base [-a|--all] --octopus <Commit>..."
+msgstr "git merge-base [-a|--all] --octopus <Commit> =E2=80=A6"
=20
 #: builtin/merge-base.c:31
 msgid "git merge-base --independent <commit>..."
-msgstr "git merge-base --independent <Commit>..."
+msgstr "git merge-base --independent <Commit> =E2=80=A6"
=20
 #: builtin/merge-base.c:32
 msgid "git merge-base --is-ancestor <commit> <commit>"
@@ -7475,7 +7475,7 @@ msgstr "die Erstellung von mehr als einem \"Tree\=
"-Objekt erlauben"
=20
 #: builtin/mv.c:15
 msgid "git mv [options] <source>... <destination>"
-msgstr "git mv [Optionen] <Quelle>... <Ziel>"
+msgstr "git mv [Optionen] <Quelle> =E2=80=A6 <Ziel>"
=20
 #: builtin/mv.c:69
 #, c-format
@@ -7570,7 +7570,7 @@ msgstr "Umbenennung von '%s' fehlgeschlagen"
=20
 #: builtin/name-rev.c:255
 msgid "git name-rev [options] <commit>..."
-msgstr "git name-rev [Optionen] <Commit>..."
+msgstr "git name-rev [Optionen] <Commit> =E2=80=A6"
=20
 #: builtin/name-rev.c:256
 msgid "git name-rev [options] --all"
@@ -7658,7 +7658,7 @@ msgstr "git notes merge --abort [-v | -q]"
=20
 #: builtin/notes.c:33
 msgid "git notes [--ref <notes_ref>] remove [<object>...]"
-msgstr "git notes [--ref <Notiz-Referenz>] remove [<Objekt>...]"
+msgstr "git notes [--ref <Notiz-Referenz>] remove [<Objekt> =E2=80=A6]=
"
=20
 #: builtin/notes.c:34
 msgid "git notes [--ref <notes_ref>] prune [-n | -v]"
@@ -7682,7 +7682,7 @@ msgstr "git notes copy [<Optionen>] <von-Objekt> =
<nach-Objekt>"
=20
 #: builtin/notes.c:51
 msgid "git notes copy --stdin [<from-object> <to-object>]..."
-msgstr "git notes copy --stdin [<von-Objekt> <nach-Objekt>]..."
+msgstr "git notes copy --stdin [<von-Objekt> <nach-Objekt>] =E2=80=A6"
=20
 #: builtin/notes.c:56
 msgid "git notes append [<options>] [<object>]"
@@ -7950,12 +7950,12 @@ msgstr "Unbekanntes Unterkommando: %s"
 #: builtin/pack-objects.c:28
 msgid "git pack-objects --stdout [options...] [< ref-list | < object-l=
ist]"
 msgstr ""
-"git pack-objects --stdout [Optionen...] [< Referenzliste | < Objektli=
ste]"
+"git pack-objects --stdout [Optionen =E2=80=A6] [< Referenzliste | < O=
bjektliste]"
=20
 #: builtin/pack-objects.c:29
 msgid "git pack-objects [options...] base-name [< ref-list | < object-=
list]"
 msgstr ""
-"git pack-objects [Optionen...] Basis-Name [< Referenzliste | < Objekt=
liste]"
+"git pack-objects [Optionen =E2=80=A6] Basis-Name [< Referenzliste | <=
 Objektliste]"
=20
 #: builtin/pack-objects.c:177 builtin/pack-objects.c:180
 #, c-format
@@ -8167,7 +8167,7 @@ msgstr "L=C3=B6sche doppelte Objekte"
=20
 #: builtin/prune.c:12
 msgid "git prune [-n] [-v] [--expire <time>] [--] [<head>...]"
-msgstr "git prune [-n] [-v] [--expire <Zeit>] [--] [<head>...]"
+msgstr "git prune [-n] [-v] [--expire <Zeit>] [--] [<head> =E2=80=A6]"
=20
 #: builtin/prune.c:106
 msgid "do not remove, show only"
@@ -8183,7 +8183,7 @@ msgstr "Objekte =C3=A4lter als <Zeit> verfallen l=
assen"
=20
 #: builtin/push.c:14
 msgid "git push [<options>] [<repository> [<refspec>...]]"
-msgstr "git push [<Optionen>] [<Repository> [<Refspec>...]]"
+msgstr "git push [<Optionen>] [<Repository> [<Refspec> =E2=80=A6]]"
=20
 #: builtin/push.c:85
 msgid "tag shorthand without <tag>"
@@ -8341,7 +8341,7 @@ msgid ""
 msgstr ""
 "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze Ihres ak=
tuellen\n"
 "Branches hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen i=
st. F=C3=BChren Sie\n"
-"die externen =C3=84nderungen zusammen (z.B. 'git pull ...') bevor Sie=
 \"push\"\n"
+"die externen =C3=84nderungen zusammen (z.B. 'git pull =E2=80=A6') bev=
or Sie \"push\"\n"
 "erneut ausf=C3=BChren.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
 "f=C3=BCr weitere Details."
@@ -8356,7 +8356,7 @@ msgstr ""
 "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze eines ve=
rsendeten\n"
 "Branches hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen i=
st. Checken Sie\n"
 "diesen Branch aus und f=C3=BChren Sie die externen =C3=84nderungen zu=
sammen\n"
-"(z.B. 'git pull ...') bevor Sie erneut \"push\" ausf=C3=BChren.\n"
+"(z.B. 'git pull =E2=80=A6') bevor Sie erneut \"push\" ausf=C3=BChren.=
\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
 "f=C3=BCr weitere Details."
=20
@@ -8365,7 +8365,7 @@ msgid ""
 "Updates were rejected because the remote contains work that you do\n"
 "not have locally. This is usually caused by another repository pushin=
g\n"
 "to the same ref. You may want to first integrate the remote changes\n=
"
-"(e.g., 'git pull ...') before pushing again.\n"
+"(e.g., 'git pull =E2=80=A6') before pushing again.\n"
 "See the 'Note about fast-forwards' in 'git push --help' for details."
 msgstr ""
 "Aktualisierungen wurden zur=C3=BCckgewiesen, weil das Remote-Reposito=
ry Commits "
@@ -8374,7 +8374,7 @@ msgstr ""
 "von\n"
 "Commits auf dieselbe Referenz von einem anderen Repository aus verurs=
acht.\n"
 "Vielleicht m=C3=BCssen Sie die externen =C3=84nderungen zusammenzuf=C3=
=BChren (z.B. 'git "
-"pull ...')\n"
+"pull =E2=80=A6')\n"
 "bevor Sie erneut \"push\" ausf=C3=BChren.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
 "f=C3=BCr weitere Details."
@@ -8645,11 +8645,11 @@ msgstr "git remote prune [-n | --dry-run] <Name=
>"
 msgid ""
 "git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote=
>)...]"
 msgstr ""
-"git remote [-v | --verbose] update [-p | --prune] [(<Gruppe> | <Remot=
e>)...]"
+"git remote [-v | --verbose] update [-p | --prune] [(<Gruppe> | <Remot=
e>) =E2=80=A6]"
=20
 #: builtin/remote.c:20
 msgid "git remote set-branches [--add] <name> <branch>..."
-msgstr "git remote set-branches [--add] <Name> <Branch>..."
+msgstr "git remote set-branches [--add] <Name> <Branch> =E2=80=A6"
=20
 #: builtin/remote.c:21 builtin/remote.c:69
 msgid "git remote set-url [--push] <name> <newurl> [<oldurl>]"
@@ -8673,11 +8673,11 @@ msgstr "git remote set-head <Name> (-a | --auto=
 | -d | --delete | <Branch>)"
=20
 #: builtin/remote.c:48
 msgid "git remote set-branches <name> <branch>..."
-msgstr "git remote set-branches <Name> <Branch>..."
+msgstr "git remote set-branches <Name> <Branch> =E2=80=A6"
=20
 #: builtin/remote.c:49
 msgid "git remote set-branches --add <name> <branch>..."
-msgstr "git remote set-branches --add <Name> <Branch>..."
+msgstr "git remote set-branches --add <Name> <Branch> =E2=80=A6"
=20
 #: builtin/remote.c:54
 msgid "git remote show [<options>] <name>"
@@ -8689,7 +8689,7 @@ msgstr "git remote prune [<Optionen>] <Name>"
=20
 #: builtin/remote.c:64
 msgid "git remote update [<options>] [<group> | <remote>]..."
-msgstr "git remote update [<Optionen>] [<Gruppe> | <externesRepository=
>]..."
+msgstr "git remote update [<Optionen>] [<Gruppe> | <externesRepository=
>] =E2=80=A6"
=20
 #: builtin/remote.c:88
 #, c-format
@@ -9201,11 +9201,11 @@ msgstr "git replace [-f] --edit <Objekt>"
=20
 #: builtin/replace.c:21
 msgid "git replace [-f] --graft <commit> [<parent>...]"
-msgstr "git replace [-f] --graft <Commit> [<Eltern-Commit>...]"
+msgstr "git replace [-f] --graft <Commit> [<Eltern-Commit> =E2=80=A6]"
=20
 #: builtin/replace.c:22
 msgid "git replace -d <object>..."
-msgstr "git replace -d <Objekt>..."
+msgstr "git replace -d <Objekt> =E2=80=A6"
=20
 #: builtin/replace.c:23
 msgid "git replace [--format=3D<format>] [-l [<pattern>]]"
@@ -9279,7 +9279,7 @@ msgstr "das angegebene Format benutzen"
=20
 #: builtin/rerere.c:12
 msgid "git rerere [clear | forget path... | status | remaining | diff =
| gc]"
-msgstr "git rerere [clean | forget path... | status | remaining | diff=
 | gc]"
+msgstr "git rerere [clean | forget path =E2=80=A6 | status | remaining=
 | diff | gc]"
=20
 #: builtin/rerere.c:57
 msgid "register clean resolutions in index"
@@ -9293,11 +9293,11 @@ msgstr ""
=20
 #: builtin/reset.c:27
 msgid "git reset [-q] <tree-ish> [--] <paths>..."
-msgstr "git reset [-q] <Commit-Referenz> [--] <Pfade>..."
+msgstr "git reset [-q] <Commit-Referenz> [--] <Pfade> =E2=80=A6"
=20
 #: builtin/reset.c:28
 msgid "git reset --patch [<tree-ish>] [--] [<paths>...]"
-msgstr "git reset --patch [<Commit-Referenz>] [--] [<Pfade>...]"
+msgstr "git reset --patch [<Commit-Referenz>] [--] [<Pfade> =E2=80=A6]=
"
=20
 #: builtin/reset.c:34
 msgid "mixed"
@@ -9420,7 +9420,7 @@ msgstr "Konnte neue Staging-Area-Datei nicht schr=
eiben."
=20
 #: builtin/rev-parse.c:361
 msgid "git rev-parse --parseopt [options] -- [<args>...]"
-msgstr "git rev-parse --parseopt [Optionen] -- [<Argumente>...]"
+msgstr "git rev-parse --parseopt [Optionen] -- [<Argumente> =E2=80=A6]=
"
=20
 #: builtin/rev-parse.c:366
 msgid "keep the `--` passed as an arg"
@@ -9443,16 +9443,16 @@ msgid ""
 "\n"
 "Run \"git rev-parse --parseopt -h\" for more information on the first=
 usage."
 msgstr ""
-"git rev-parse --parseopt [Optionen] -- [<Argumente>...]\n"
-"   oder: git rev-parse --sq-quote [<Argumente>...]\n"
-"   oder: git rev-parse [Optionen] [<Argumente>...]\n"
+"git rev-parse --parseopt [Optionen] -- [<Argumente> =E2=80=A6]\n"
+"   oder: git rev-parse --sq-quote [<Argumente> =E2=80=A6]\n"
+"   oder: git rev-parse [Optionen] [<Argumente> =E2=80=A6]\n"
 "\n"
 "F=C3=BChren Sie \"git rev-parse --parseopt -h\" f=C3=BCr weitere Info=
rmationen bei "
 "erster Verwendung aus."
=20
 #: builtin/revert.c:22
 msgid "git revert [options] <commit-ish>..."
-msgstr "git revert [Optionen] <Commit-Angabe>..."
+msgstr "git revert [Optionen] <Commit-Angabe> =E2=80=A6"
=20
 #: builtin/revert.c:23
 msgid "git revert <subcommand>"
@@ -9460,7 +9460,7 @@ msgstr "git revert <Unterkommando>"
=20
 #: builtin/revert.c:28
 msgid "git cherry-pick [options] <commit-ish>..."
-msgstr "git cherry-pick [Optionen] <Commit-Angabe>..."
+msgstr "git cherry-pick [Optionen] <Commit-Angabe> =E2=80=A6"
=20
 #: builtin/revert.c:29
 msgid "git cherry-pick <subcommand>"
@@ -9541,7 +9541,7 @@ msgstr "\"cherry-pick\" fehlgeschlagen"
=20
 #: builtin/rm.c:17
 msgid "git rm [options] [--] <file>..."
-msgstr "git rm [Optionen] [--] [<Datei>...]"
+msgstr "git rm [Optionen] [--] [<Datei> =E2=80=A6]"
=20
 #: builtin/rm.c:65
 msgid ""
@@ -9649,7 +9649,7 @@ msgstr "git rm: konnte %s nicht l=C3=B6schen"
=20
 #: builtin/shortlog.c:13
 msgid "git shortlog [<options>] [<revision range>] [[--] [<path>...]]"
-msgstr "git shortlog [<Optionen>] [Commitbereich] [[--] <Pfad>...]"
+msgstr "git shortlog [<Optionen>] [Commitbereich] [[--] <Pfad> =E2=80=A6=
]"
=20
 #: builtin/shortlog.c:131
 #, c-format
@@ -9686,7 +9686,7 @@ msgstr ""
 "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r]\n"
 "\t\t[--current] [--color[=3D<Wann>] | --no-color] [--sparse]\n"
 "\t\t[--more=3D<n> | --list | --independent | --merge-base]\n"
-"\t\t[--no-name | --sha1-name] [--topics] [(<Commit> | <glob>)...]"
+"\t\t[--no-name | --sha1-name] [--topics] [(<Commit> | <glob>) =E2=80=A6=
]"
=20
 #: builtin/show-branch.c:13
 msgid "git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref>]=
"
@@ -9843,7 +9843,7 @@ msgstr ""
=20
 #: builtin/tag.c:23
 msgid "git tag -d <tagname>..."
-msgstr "git tag -d <Tagname>..."
+msgstr "git tag -d <Tagname> =E2=80=A6"
=20
 #: builtin/tag.c:24
 msgid ""
@@ -9851,11 +9851,11 @@ msgid ""
 "\t\t[<pattern>...]"
 msgstr ""
 "git tag -l [-n[<Nummer>]] [--contains <Commit>] [--points-at <Objekt>=
] \n"
-"\t\t[<Muster>...]"
+"\t\t[<Muster> =E2=80=A6]"
=20
 #: builtin/tag.c:26
 msgid "git tag -v <tagname>..."
-msgstr "git tag -v <Tagname>..."
+msgstr "git tag -v <Tagname> =E2=80=A6"
=20
 #: builtin/tag.c:69
 #, c-format
@@ -9865,7 +9865,7 @@ msgstr "fehlerhaftes Objekt bei '%s'"
 #: builtin/tag.c:301
 #, c-format
 msgid "tag name too long: %.*s..."
-msgstr "Tagname zu lang: %.*s..."
+msgstr "Tagname zu lang: %.*s =E2=80=A6"
=20
 #: builtin/tag.c:306
 #, c-format
@@ -10063,7 +10063,7 @@ msgstr "Entpacke Objekte"
=20
 #: builtin/update-index.c:403
 msgid "git update-index [options] [--] [<file>...]"
-msgstr "git update-index [Optionen] [--] [<Datei>...]"
+msgstr "git update-index [Optionen] [--] [<Datei> =E2=80=A6]"
=20
 #: builtin/update-index.c:756
 msgid "continue refresh even when index needs update"
@@ -10223,7 +10223,7 @@ msgstr "die Informationsdateien von Grund auf a=
ktualisieren"
=20
 #: builtin/verify-commit.c:17
 msgid "git verify-commit [-v|--verbose] <commit>..."
-msgstr "git verify-commit [-v|--verbose] <Commit>..."
+msgstr "git verify-commit [-v|--verbose] <Commit> =E2=80=A6"
=20
 #: builtin/verify-commit.c:75
 msgid "print commit contents"
@@ -10231,7 +10231,7 @@ msgstr "Commit-Inhalte ausgeben"
=20
 #: builtin/verify-pack.c:54
 msgid "git verify-pack [-v|--verbose] [-s|--stat-only] <pack>..."
-msgstr "git verify-pack [-v|--verbose] [-s|--stat-only] <Paket>..."
+msgstr "git verify-pack [-v|--verbose] [-s|--stat-only] <Paket> =E2=80=
=A6"
=20
 #: builtin/verify-pack.c:64
 msgid "verbose"
@@ -10243,7 +10243,7 @@ msgstr "nur Statistiken anzeigen"
=20
 #: builtin/verify-tag.c:17
 msgid "git verify-tag [-v|--verbose] <tag>..."
-msgstr "git verify-tag [-v|--verbose] <Tag>..."
+msgstr "git verify-tag [-v|--verbose] <Tag> =E2=80=A6"
=20
 #: builtin/verify-tag.c:73
 msgid "print tag contents"
@@ -10450,7 +10450,7 @@ msgstr ""
=20
 #: git-am.sh:166
 msgid "Falling back to patching base and 3-way merge..."
-msgstr "Falle zur=C3=BCck zum Patchen der Basis und des 3-Wege-Merges.=
=2E."
+msgstr "Falle zur=C3=BCck zum Patchen der Basis und des 3-Wege-Merges =
=E2=80=A6"
=20
 #: git-am.sh:182
 msgid "Failed to merge in the changes."
@@ -10943,7 +10943,7 @@ msgstr "=C3=84nderungen von $mb zu $onto:"
 msgid "First, rewinding head to replay your work on top of it..."
 msgstr ""
 "Zun=C3=A4chst wird der Branch zur=C3=BCckgespult, um Ihre =C3=84nderu=
ngen\n"
-"darauf neu anzuwenden..."
+"darauf neu anzuwenden =E2=80=A6"
=20
 #: git-rebase.sh:620
 #, sh-format
--=20
2.3.3

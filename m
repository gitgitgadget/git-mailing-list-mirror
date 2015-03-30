From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] l10n: de.po: translate 99 new messages
Date: Mon, 30 Mar 2015 19:39:59 +0200
Message-ID: <1427737199-5780-1-git-send-email-ralf.thielow@gmail.com>
References: <1427571482-7508-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 19:40:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycdfa-00018O-Dx
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 19:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbbC3RkJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2015 13:40:09 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34308 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbbC3RkG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 13:40:06 -0400
Received: by wgbdm7 with SMTP id dm7so77125224wgb.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 10:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hZwyXpsz+s6beFTufc6mgfJcBW/lTKehEI1UbDl+cPU=;
        b=amrg1EykJpkjomCgFZn+2aR2CW3pO00kxAEgw9emqg+QHQ09F6RK60TzHxCGPRCj+x
         BXL31qh9+ntLEGZzn1nClgxBapXSch3vDMXQZQ7ZExsz8pTTz+Y/+fJjqVhK8lyVGoHJ
         lb9Tqs1RMV3tyIsbjaCiOD6HqMIb2LxjLIVVVr4Ldi0PGqSzj50gx7mQIn2V/4TjqlXR
         Sh7KmT/hklXbctfAgmFlum+IzjhwRBrqogpIdiLFlN1vkc28d0N8Ckder0r0+//IcMh6
         DBxXNW1boIdiHeAbGxxXbRu8wJBGluzZgpH5EmGpasq+2bTDnXd/ledZHaQECEaz7+QZ
         m1AA==
X-Received: by 10.194.8.2 with SMTP id n2mr65123064wja.46.1427737204421;
        Mon, 30 Mar 2015 10:40:04 -0700 (PDT)
Received: from localhost (dslb-178-000-084-015.178.000.pools.vodafone-ip.de. [178.0.84.15])
        by mx.google.com with ESMTPSA id ei8sm17286989wib.10.2015.03.30.10.40.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 10:40:03 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.554.gb58f7a9
In-Reply-To: <1427571482-7508-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266460>

Translate 99 messages came from git.pot update in c2ea120
(l10n: git.pot: v2.4.0 round 1 (99 new, 92 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 289 ++++++++++++++++++++++---------------------------------=
--------
 1 file changed, 101 insertions(+), 188 deletions(-)

diff --git a/po/de.po b/po/de.po
index c68804f..58e0c8f 100644
--- a/po/de.po
+++ b/po/de.po
@@ -32,21 +32,19 @@ msgstr ""
 "und zu committen."
=20
 #: archive.c:11
-#, fuzzy
 msgid "git archive [<options>] <tree-ish> [<path>...]"
-msgstr "git archive [Optionen] <Commit-Referenz> [<Pfad>...]"
+msgstr "git archive [<Optionen>] <Commit-Referenz> [<Pfad>...]"
=20
 #: archive.c:12
 msgid "git archive --list"
 msgstr "git archive --list"
=20
 #: archive.c:13
-#, fuzzy
 msgid ""
 "git archive --remote <repo> [--exec <cmd>] [<options>] <tree-ish> [<p=
ath>...]"
 msgstr ""
-"git archive --remote <Repository> [--exec <Programm>] [Optionen] <Com=
mit-"
-"Referenz> [Pfad...]"
+"git archive --remote <Repository> [--exec <Programm>] [<Optionen>] <C=
ommit-"
+"Referenz> [<Pfad>...]"
=20
 #: archive.c:14
 msgid "git archive --remote <repo> [--exec <cmd>] --list"
@@ -1144,9 +1142,8 @@ msgstr ""
 "zusammenzuf=C3=BChren)\n"
=20
 #: revision.c:2348
-#, fuzzy
 msgid "--first-parent is incompatible with --bisect"
-msgstr "Die Option --dirty kann nicht mit Commits verwendet werden."
+msgstr "Die Optionen --first-parent und --bisect sind inkompatibel."
=20
 #: run-command.c:83
 msgid "open /dev/null failed"
@@ -1167,10 +1164,9 @@ msgstr ""
 "die Gegenseite unterst=C3=BCtzt keinen signierten Versand (\"--signed=
 push\")"
=20
 #: send-pack.c:366
-#, fuzzy
 msgid "server does not support --atomic push"
 msgstr ""
-"die Gegenseite unterst=C3=BCtzt keinen signierten Versand (\"--signed=
 push\")"
+"die Gegenseite unterst=C3=BCtzt keinen atomaren Versand (\"--atomic p=
ush\")"
=20
 #: sequencer.c:172 builtin/merge.c:782 builtin/merge.c:893 builtin/mer=
ge.c:995
 #: builtin/merge.c:1005
@@ -2047,9 +2043,8 @@ msgid "failed to unlink '%s'"
 msgstr "Konnte '%s' nicht entfernen."
=20
 #: builtin/add.c:22
-#, fuzzy
 msgid "git add [<options>] [--] <pathspec>..."
-msgstr "git add [Optionen] [--] [<Pfadspezifikation>...]"
+msgstr "git add [<Optionen>] [--] <Pfadspezifikation>..."
=20
 #: builtin/add.c:65
 #, c-format
@@ -2200,9 +2195,8 @@ msgid "Unable to write new index file"
 msgstr "Konnte neue Staging-Area-Datei nicht schreiben."
=20
 #: builtin/apply.c:59
-#, fuzzy
 msgid "git apply [<options>] [<patch>...]"
-msgstr "git apply [Optionen] [<Patch>...]"
+msgstr "git apply [<Optionen>] [<Patch>...]"
=20
 #: builtin/apply.c:112
 #, c-format
@@ -2390,9 +2384,9 @@ msgid "read of %s failed"
 msgstr "Konnte %s nicht lesen"
=20
 #: builtin/apply.c:3238
-#, fuzzy, c-format
+#, c-format
 msgid "reading from '%s' beyond a symbolic link"
-msgstr "Pfadspezifikation '%s' ist hinter einem symbolischen Verweis"
+msgstr "'%s' ist hinter einem symbolischen Verweis"
=20
 #: builtin/apply.c:3266 builtin/apply.c:3488
 #, c-format
@@ -2429,9 +2423,9 @@ msgid "%s has type %o, expected %o"
 msgstr "%s ist vom Typ %o, erwartete %o"
=20
 #: builtin/apply.c:3688 builtin/apply.c:3690
-#, fuzzy, c-format
+#, c-format
 msgid "invalid path '%s'"
-msgstr "Ung=C3=BCltige Option: %s"
+msgstr "Ung=C3=BCltiger Pfad '%s'"
=20
 #: builtin/apply.c:3745
 #, c-format
@@ -2454,9 +2448,9 @@ msgid "new mode (%o) of %s does not match old mod=
e (%o) of %s"
 msgstr "neuer Modus (%o) von %s entspricht nicht dem alten Modus (%o) =
von %s"
=20
 #: builtin/apply.c:3793
-#, fuzzy, c-format
+#, c-format
 msgid "affected file '%s' is beyond a symbolic link"
-msgstr "Pfadspezifikation '%s' ist hinter einem symbolischen Verweis"
+msgstr "betroffene Datei '%s' ist hinter einem symbolischen Verweis"
=20
 #: builtin/apply.c:3797
 #, c-format
@@ -2607,9 +2601,8 @@ msgid "apply a patch without touching the working=
 tree"
 msgstr "Patch anwenden, ohne =C3=84nderungen im Arbeitsverzeichnis vor=
zunehmen"
=20
 #: builtin/apply.c:4546
-#, fuzzy
 msgid "accept a patch that touches outside the working area"
-msgstr "Patch anwenden, ohne =C3=84nderungen im Arbeitsverzeichnis vor=
zunehmen"
+msgstr "Patch anwenden, der =C3=84nderungen au=C3=9Ferhalb des Arbeits=
verzeichnisses vornimmt"
=20
 #: builtin/apply.c:4548
 msgid "also apply the patch (use with --stat/--summary/--check)"
@@ -2761,14 +2754,12 @@ msgid "update BISECT_HEAD instead of checking o=
ut the current commit"
 msgstr "BISECT_HEAD aktualisieren, anstatt den aktuellen Commit auszuc=
hecken"
=20
 #: builtin/blame.c:30
-#, fuzzy
 msgid "git blame [<options>] [<rev-opts>] [<rev>] [--] file"
-msgstr "git blame [Optionen] [rev-opts] [rev] [--] Datei"
+msgstr "git blame [<Optionen>] [<rev-opts>] [<Commit>] [--] Datei"
=20
 #: builtin/blame.c:35
-#, fuzzy
 msgid "<rev-opts> are documented in git-rev-list(1)"
-msgstr "[rev-opts] sind dokumentiert in git-rev-list(1)"
+msgstr "<rev-opts> sind dokumentiert in git-rev-list(1)"
=20
 #: builtin/blame.c:2500
 msgid "Show blame entries as we find them, incrementally"
@@ -2876,24 +2867,20 @@ msgid "4 years, 11 months ago"
 msgstr "vor 4 Jahren, und 11 Monaten"
=20
 #: builtin/branch.c:24
-#, fuzzy
 msgid "git branch [<options>] [-r | -a] [--merged | --no-merged]"
-msgstr "git branch [Optionen] [-r | -a] [--merged | --no-merged]"
+msgstr "git branch [<Optionen>] [-r | -a] [--merged | --no-merged]"
=20
 #: builtin/branch.c:25
-#, fuzzy
 msgid "git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"
-msgstr "git branch [Optionen] [-l] [-f] <Branchname> [<Startpunkt>]"
+msgstr "git branch [<Optionen>] [-l] [-f] <Branchname> [<Startpunkt>]"
=20
 #: builtin/branch.c:26
-#, fuzzy
 msgid "git branch [<options>] [-r] (-d | -D) <branch-name>..."
-msgstr "git branch [Optionen] [-r] (-d | -D) <Branchname>..."
+msgstr "git branch [<Optionen>] [-r] (-d | -D) <Branchname>..."
=20
 #: builtin/branch.c:27
-#, fuzzy
 msgid "git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"
-msgstr "git branch [Optionen] (-m | -M) [<alterBranch>] <neuerBranch>"
+msgstr "git branch [<Optionen>] (-m | -M) [<alter-Branch>] <neuer-Bran=
ch>"
=20
 #: builtin/branch.c:152
 #, c-format
@@ -3036,14 +3023,14 @@ msgid "(no branch, bisect started on %s)"
 msgstr "(kein Branch, bin=C3=A4re Suche begonnen bei %s)"
=20
 #: builtin/branch.c:596
-#, fuzzy, c-format
+#, c-format
 msgid "(HEAD detached at %s)"
-msgstr "HEAD losgel=C3=B6st bei "
+msgstr "(HEAD losgel=C3=B6st bei %s)"
=20
 #: builtin/branch.c:599
-#, fuzzy, c-format
+#, c-format
 msgid "(HEAD detached from %s)"
-msgstr "HEAD losgel=C3=B6st von "
+msgstr "(HEAD losgel=C3=B6st von %s)"
=20
 #: builtin/branch.c:603
 msgid "(no branch)"
@@ -3320,14 +3307,12 @@ msgid "Need a repository to unbundle."
 msgstr "Zum Entpacken wird ein Repository ben=C3=B6tigt."
=20
 #: builtin/cat-file.c:326
-#, fuzzy
 msgid "git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>=
"
-msgstr "git cat-file (-t|-s|-e|-p|<Art>|--textconv) <Objekt>"
+msgstr "git cat-file (-t | -s | -e | -p | <Art> | --textconv) <Objekt>=
"
=20
 #: builtin/cat-file.c:327
-#, fuzzy
 msgid "git cat-file (--batch | --batch-check) < <list-of-objects>"
-msgstr "git cat-file (--batch|--batch-check) < <Liste_von_Objekten>"
+msgstr "git cat-file (--batch | --batch-check) < <Liste-von-Objekten>"
=20
 #: builtin/cat-file.c:364
 msgid "<type> can be one of: blob, tree, commit, tag"
@@ -3365,15 +3350,13 @@ msgstr ""
 "Anzeige von Informationen =C3=BCber Objekte, gelesen von der Standard=
-Eingabe"
=20
 #: builtin/check-attr.c:11
-#, fuzzy
 msgid "git check-attr [-a | --all | <attr>...] [--] <pathname>..."
-msgstr "git check-attr [-a | --all | Attribut...] [--] Pfadname..."
+msgstr "git check-attr [-a | --all | <Attribut>...] [--] <Pfadname>...=
"
=20
 #: builtin/check-attr.c:12
-#, fuzzy
 msgid "git check-attr --stdin [-z] [-a | --all | <attr>...] < <list-of=
-paths>"
 msgstr ""
-"git check-attr --stdin [-z] [-a | --all | Attribut...] < <Liste-von-P=
faden>"
+"git check-attr --stdin [-z] [-a | --all | <Attribut>...] < <Liste-von=
-Pfaden>"
=20
 #: builtin/check-attr.c:19
 msgid "report all attributes set on file"
@@ -3429,9 +3412,8 @@ msgid "--non-matching is only valid with --verbos=
e"
 msgstr "--non-matching ist nur mit --verbose zul=C3=A4ssig"
=20
 #: builtin/check-mailmap.c:8
-#, fuzzy
 msgid "git check-mailmap [<options>] <contact>..."
-msgstr "git check-mailmap [Optionen] <Kontakt>..."
+msgstr "git check-mailmap [<Optionen>] <Kontakt>..."
=20
 #: builtin/check-mailmap.c:13
 msgid "also read contacts from stdin"
@@ -3447,9 +3429,8 @@ msgid "no contacts specified"
 msgstr "keine Kontakte angegeben"
=20
 #: builtin/checkout-index.c:126
-#, fuzzy
 msgid "git checkout-index [<options>] [--] [<file>...]"
-msgstr "git checkout-index [Optionen] [--] [<Datei>...]"
+msgstr "git checkout-index [<Optionen>] [--] [<Datei>...]"
=20
 #: builtin/checkout-index.c:188
 msgid "check out all files in the index"
@@ -3495,14 +3476,12 @@ msgid "copy out the files from named stage"
 msgstr "Dateien von dem benannten Stand kopieren"
=20
 #: builtin/checkout.c:25
-#, fuzzy
 msgid "git checkout [<options>] <branch>"
-msgstr "git checkout [Optionen] <Branch>"
+msgstr "git checkout [<Optionen>] <Branch>"
=20
 #: builtin/checkout.c:26
-#, fuzzy
 msgid "git checkout [<options>] [<branch>] -- <file>..."
-msgstr "git checkout [Optionen] [<Branch>] -- <Datei>..."
+msgstr "git checkout [<Optionen>] [<Branch>] -- <Datei>..."
=20
 #: builtin/checkout.c:132 builtin/checkout.c:165
 #, c-format
@@ -3627,7 +3606,7 @@ msgstr[1] ""
 "%s\n"
=20
 #: builtin/checkout.c:747
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "If you want to keep them by creating a new branch, this may be a good=
 time\n"
 "to do so with:\n"
@@ -3638,7 +3617,7 @@ msgstr ""
 "Wenn Sie diese durch einen neuen Branch behalten m=C3=B6chten, dann k=
=C3=B6nnte jetzt\n"
 "ein guter Zeitpunkt sein dies zu tun mit:\n"
 "\n"
-" git branch neuer_branch_name %s\n"
+" git branch <neuer-Branchname> %s\n"
 "\n"
=20
 #: builtin/checkout.c:777
@@ -3754,9 +3733,8 @@ msgid "do not limit pathspecs to sparse entries o=
nly"
 msgstr "keine Einschr=C3=A4nkung bei Pfadspezifikationen zum partielle=
n Auschecken"
=20
 #: builtin/checkout.c:1130
-#, fuzzy
 msgid "second guess 'git checkout <no-such-branch>'"
-msgstr "second guess 'git checkout no-such-branch'"
+msgstr "second guess 'git checkout <no-such-branch>'"
=20
 #: builtin/checkout.c:1153
 msgid "-b, -B and --orphan are mutually exclusive"
@@ -3881,9 +3859,9 @@ msgstr "W=C3=A4hlen Sie Eintr=C3=A4ge zum L=C3=B6=
schen"
=20
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:758
-#, fuzzy, c-format
+#, c-format
 msgid "Remove %s [y/N]? "
-msgstr "'%s' l=C3=B6schen? "
+msgstr "'%s' l=C3=B6schen [y/N]? "
=20
 #: builtin/clean.c:783
 msgid "Bye."
@@ -3979,9 +3957,8 @@ msgstr ""
 "f gegeben; \"clean\" verweigert"
=20
 #: builtin/clone.c:37
-#, fuzzy
 msgid "git clone [<options>] [--] <repo> [<dir>]"
-msgstr "git clone [Optionen] [--] <Repository> [<Verzeichnis>]"
+msgstr "git clone [<Optionen>] [--] <Repository> [<Verzeichnis>]"
=20
 #: builtin/clone.c:66 builtin/fetch.c:111 builtin/merge.c:224
 #: builtin/push.c:523
@@ -4215,9 +4192,9 @@ msgid "could not create leading directories of '%=
s'"
 msgstr "Konnte f=C3=BChrende Verzeichnisse von '%s' nicht erstellen."
=20
 #: builtin/clone.c:853
-#, fuzzy, c-format
+#, c-format
 msgid "could not create work tree dir '%s'"
-msgstr "Konnte Arbeitsverzeichnis '%s' nicht erstellen."
+msgstr "Konnte Arbeitsverzeichnis '%s' nicht erstellen"
=20
 #: builtin/clone.c:871
 #, c-format
@@ -4264,9 +4241,8 @@ msgid "You appear to have cloned an empty reposit=
ory."
 msgstr "Sie scheinen ein leeres Repository geklont zu haben."
=20
 #: builtin/column.c:9
-#, fuzzy
 msgid "git column [<options>]"
-msgstr "git column [Optionen]"
+msgstr "git column [<Optionen>]"
=20
 #: builtin/column.c:26
 msgid "lookup config vars"
@@ -4297,14 +4273,12 @@ msgid "--command must be the first argument"
 msgstr "Die Option --command muss an erster Stelle stehen."
=20
 #: builtin/commit.c:37
-#, fuzzy
 msgid "git commit [<options>] [--] <pathspec>..."
-msgstr "git commit [Optionen] [--] <Pfadspezifikation>..."
+msgstr "git commit [<Optionen>] [--] <Pfadspezifikation>..."
=20
 #: builtin/commit.c:42
-#, fuzzy
 msgid "git status [<options>] [--] <pathspec>..."
-msgstr "git status [Optionen] [--] <Pfadspezifikation>..."
+msgstr "git status [<Optionen>] [--] <Pfadspezifikation>..."
=20
 #: builtin/commit.c:47
 msgid ""
@@ -4598,7 +4572,7 @@ msgstr ""
 #: builtin/commit.c:1053
 #, c-format
 msgid "--author '%s' is not 'Name <email>' and matches no existing aut=
hor"
-msgstr ""
+msgstr "--author '%s' ist nicht im Format 'Name <E-Mail>' und stimmt m=
it keinem vorhandenen Autor =C3=BCberein"
=20
 #: builtin/commit.c:1068 builtin/commit.c:1308
 #, c-format
@@ -4938,9 +4912,8 @@ msgstr ""
 "anschlie=C3=9Fend \"git reset HEAD\" zu Wiederherstellung aus."
=20
 #: builtin/config.c:8
-#, fuzzy
 msgid "git config [<options>]"
-msgstr "git config [Optionen]"
+msgstr "git config [<Optionen>]"
=20
 #: builtin/config.c:53
 msgid "Config file location"
@@ -5095,14 +5068,12 @@ msgid "print sizes in human readable format"
 msgstr "gibt Gr=C3=B6=C3=9Fenangaben in menschenlesbaren Format aus"
=20
 #: builtin/describe.c:17
-#, fuzzy
 msgid "git describe [<options>] [<commit-ish>...]"
-msgstr "git describe [Optionen] <commit-ish>*"
+msgstr "git describe [<Optionen>] [<Commit-Angabe>...]"
=20
 #: builtin/describe.c:18
-#, fuzzy
 msgid "git describe [<options>] --dirty"
-msgstr "git describe [Optionen] --dirty"
+msgstr "git describe [<Optionen>] --dirty"
=20
 #: builtin/describe.c:217
 #, c-format
@@ -5598,11 +5569,10 @@ msgstr ""
 "von Refspecs verwendet werden."
=20
 #: builtin/fmt-merge-msg.c:13
-#, fuzzy
 msgid ""
 "git fmt-merge-msg [-m <message>] [--log[=3D<n>] | --no-log] [--file <=
file>]"
 msgstr ""
-"git fmt-merge-msg [-m <Beschreibung>] [--log[=3D<n>]|--no-log] [--fil=
e <Datei>]"
+"git fmt-merge-msg [-m <Beschreibung>] [--log[=3D<n>] | --no-log] [--f=
ile <Datei>]"
=20
 #: builtin/fmt-merge-msg.c:662 builtin/fmt-merge-msg.c:665 builtin/gre=
p.c:698
 #: builtin/merge.c:198 builtin/repack.c:178 builtin/repack.c:182
@@ -5636,9 +5606,8 @@ msgid "unable to parse format"
 msgstr "Konnte Format nicht parsen."
=20
 #: builtin/for-each-ref.c:1063
-#, fuzzy
 msgid "git for-each-ref [<options>] [<pattern>]"
-msgstr "git for-each-ref [Optionen] [<Muster>]"
+msgstr "git for-each-ref [<Optionen>] [<Muster>]"
=20
 #: builtin/for-each-ref.c:1078
 msgid "quote placeholders suitably for shells"
@@ -5685,9 +5654,8 @@ msgid "Checking object directories"
 msgstr "Pr=C3=BCfe Objekt-Verzeichnisse"
=20
 #: builtin/fsck.c:603
-#, fuzzy
 msgid "git fsck [<options>] [<object>...]"
-msgstr "git fsck [Optionen] [<Objekt>...]"
+msgstr "git fsck [<Optionen>] [<Objekt>...]"
=20
 #: builtin/fsck.c:609
 msgid "show unreachable objects"
@@ -5734,9 +5702,8 @@ msgid "Checking objects"
 msgstr "Pr=C3=BCfe Objekte"
=20
 #: builtin/gc.c:24
-#, fuzzy
 msgid "git gc [<options>]"
-msgstr "git gc [Optionen]"
+msgstr "git gc [<Optionen>]"
=20
 #: builtin/gc.c:79
 #, c-format
@@ -5801,9 +5768,8 @@ msgstr ""
 "diese zu l=C3=B6schen."
=20
 #: builtin/grep.c:23
-#, fuzzy
 msgid "git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]=
"
-msgstr "git grep [Optionen] [-e] <Muster> [<Commit>...] [[--] <Pfad>..=
=2E]"
+msgstr "git grep [<Optionen>] [-e] <Muster> [<Commit>...] [[--] <Pfad>=
=2E..]"
=20
 #: builtin/grep.c:218
 #, c-format
@@ -5844,7 +5810,7 @@ msgstr "in versionierten und unversionierten Date=
ien suchen"
=20
 #: builtin/grep.c:644
 msgid "ignore files specified via '.gitignore'"
-msgstr ""
+msgstr "Dateien, die =C3=BCber '.gitignore' angegeben sind, ignorieren=
"
=20
 #: builtin/grep.c:647
 msgid "show non-matching lines"
@@ -6039,12 +6005,11 @@ msgid "both --cached and trees are given."
 msgstr "Die Option --cached kann nicht mit \"Tree\"-Objekten verwendet=
 werden."
=20
 #: builtin/hash-object.c:82
-#, fuzzy
 msgid ""
 "git hash-object [-t <type>] [-w] [--path=3D<file> | --no-filters] [--=
stdin] "
 "[--] <file>..."
 msgstr ""
-"git hash-object [-t <Art>] [-w] [--path=3D<Datei>|--no-filters] [--st=
din] [--] "
+"git hash-object [-t <Art>] [-w] [--path=3D<Datei> | --no-filters] [--=
stdin] [--] "
 "<Datei>..."
=20
 #: builtin/hash-object.c:83
@@ -6103,9 +6068,8 @@ msgid "show info page"
 msgstr "Info-Seite anzeigen"
=20
 #: builtin/help.c:52
-#, fuzzy
 msgid "git help [--all] [--guides] [--man | --web | --info] [<command>=
]"
-msgstr "git help [--all] [--guides] [--man|--web|--info] [Kommando]"
+msgstr "git help [--all] [--guides] [--man | --web | --info] [<Kommand=
o>]"
=20
 #: builtin/help.c:64
 #, c-format
@@ -6602,13 +6566,12 @@ msgid " shared"
 msgstr " gemeinsames"
=20
 #: builtin/init-db.c:475
-#, fuzzy
 msgid ""
 "git init [-q | --quiet] [--bare] [--template=3D<template-directory>] =
[--"
 "shared[=3D<permissions>]] [<directory>]"
 msgstr ""
 "git init [-q | --quiet] [--bare] [--template=3D<Vorlagenverzeichnis>]=
 [--"
-"shared[=3D<Berechtigungen>]] [Verzeichnis]"
+"shared[=3D<Berechtigungen>]] [<Verzeichnis>]"
=20
 #: builtin/init-db.c:498
 msgid "permissions"
@@ -6671,9 +6634,8 @@ msgid "git log [<options>] [<revision range>] [[-=
-] <path>...]"
 msgstr "git log [<Optionen>] [<Commitbereich>] [[--] <Pfad>...]"
=20
 #: builtin/log.c:42
-#, fuzzy
 msgid "git show [<options>] <object>..."
-msgstr "git show [Optionen] <Objekt>..."
+msgstr "git show [<Optionen>] <Objekt>..."
=20
 #: builtin/log.c:81
 #, c-format
@@ -6751,9 +6713,8 @@ msgid "insane in-reply-to: %s"
 msgstr "ung=C3=BCltiges in-reply-to: %s"
=20
 #: builtin/log.c:1026
-#, fuzzy
 msgid "git format-patch [<options>] [<since> | <revision-range>]"
-msgstr "git format-patch [Optionen] [<seit> | <Commitbereich>]"
+msgstr "git format-patch [<Optionen>] [<seit> | <Commitbereich>]"
=20
 #: builtin/log.c:1071
 msgid "Two output directories?"
@@ -6955,9 +6916,8 @@ msgid "Unknown commit %s"
 msgstr "Unbekannter Commit %s"
=20
 #: builtin/ls-files.c:358
-#, fuzzy
 msgid "git ls-files [<options>] [<file>...]"
-msgstr "git ls-files [Optionen] [<Datei>...]"
+msgstr "git ls-files [<Optionen>] [<Datei>...]"
=20
 #: builtin/ls-files.c:415
 msgid "identify the file status with tags"
@@ -7093,14 +7053,12 @@ msgstr ""
 "(impliziert --full-name)"
=20
 #: builtin/merge.c:45
-#, fuzzy
 msgid "git merge [<options>] [<commit>...]"
-msgstr "git merge [Optionen] [<Commit>...]"
+msgstr "git merge [<Optionen>] [<Commit>...]"
=20
 #: builtin/merge.c:46
-#, fuzzy
 msgid "git merge [<options>] <msg> HEAD <commit>"
-msgstr "git merge [Optionen] <Beschreibung> HEAD <Commit>"
+msgstr "git merge [<Optionen>] <Beschreibung> HEAD <Commit>"
=20
 #: builtin/merge.c:47
 msgid "git merge --abort"
@@ -7455,14 +7413,12 @@ msgstr ""
 "Automatischer Merge abgeschlossen; halte, wie gew=C3=BCnscht, vor dem=
 Commit an\n"
=20
 #: builtin/merge-base.c:29
-#, fuzzy
 msgid "git merge-base [-a | --all] <commit> <commit>..."
-msgstr "git merge-base [-a|--all] <Commit> <Commit>..."
+msgstr "git merge-base [-a | --all] <Commit> <Commit>..."
=20
 #: builtin/merge-base.c:30
-#, fuzzy
 msgid "git merge-base [-a | --all] --octopus <commit>..."
-msgstr "git merge-base [-a|--all] --octopus <Commit>..."
+msgstr "git merge-base [-a | --all] --octopus <Commit>..."
=20
 #: builtin/merge-base.c:31
 msgid "git merge-base --independent <commit>..."
@@ -7497,13 +7453,12 @@ msgid "find where <commit> forked from reflog o=
f <ref>"
 msgstr "<Commit> finden, von wo Reflog von <Referenz> abgespalten wurd=
e"
=20
 #: builtin/merge-file.c:8
-#, fuzzy
 msgid ""
 "git merge-file [<options>] [-L <name1> [-L <orig> [-L <name2>]]] <fil=
e1> "
 "<orig-file> <file2>"
 msgstr ""
-"git merge-file [Optionen] [-L Name1 [-L orig [-L Name2]]] Datei1 orig=
_Datei "
-"Datei2"
+"git merge-file [<Optionen>] [-L <Name1> [-L <orig> [-L <Name2>]]] <Da=
tei1> "
+"<orig-Datei> <Datei2>"
=20
 #: builtin/merge-file.c:33
 msgid "send results to standard output"
@@ -7534,9 +7489,8 @@ msgid "do not warn about conflicts"
 msgstr "keine Warnung bei Konflikten"
=20
 #: builtin/merge-file.c:45
-#, fuzzy
 msgid "set labels for file1/orig-file/file2"
-msgstr "Beschriftung f=C3=BCr Datei1/orig_Datei/Datei2 setzen"
+msgstr "Beschriftung f=C3=BCr Datei1/orig-Datei/Datei2 setzen"
=20
 #: builtin/mktree.c:64
 msgid "git mktree [-z] [--missing] [--batch]"
@@ -7555,9 +7509,8 @@ msgid "allow creation of more than one tree"
 msgstr "die Erstellung von mehr als einem \"Tree\"-Objekt erlauben"
=20
 #: builtin/mv.c:15
-#, fuzzy
 msgid "git mv [<options>] <source>... <destination>"
-msgstr "git mv [Optionen] <Quelle>... <Ziel>"
+msgstr "git mv [<Optionen>] <Quelle>... <Ziel>"
=20
 #: builtin/mv.c:69
 #, c-format
@@ -7651,19 +7604,16 @@ msgid "renaming '%s' failed"
 msgstr "Umbenennung von '%s' fehlgeschlagen"
=20
 #: builtin/name-rev.c:255
-#, fuzzy
 msgid "git name-rev [<options>] <commit>..."
-msgstr "git name-rev [Optionen] <Commit>..."
+msgstr "git name-rev [<Optionen>] <Commit>..."
=20
 #: builtin/name-rev.c:256
-#, fuzzy
 msgid "git name-rev [<options>] --all"
-msgstr "git name-rev [Optionen] --all"
+msgstr "git name-rev [<Optionen>] --all"
=20
 #: builtin/name-rev.c:257
-#, fuzzy
 msgid "git name-rev [<options>] --stdin"
-msgstr "git name-rev [Optionen] --stdin"
+msgstr "git name-rev [<Optionen>] --stdin"
=20
 #: builtin/name-rev.c:309
 msgid "print only names (no SHA-1)"
@@ -7694,12 +7644,10 @@ msgid "dereference tags in the input (internal =
use)"
 msgstr "Tags in der Eingabe dereferenzieren (interne Verwendung)"
=20
 #: builtin/notes.c:24
-#, fuzzy
 msgid "git notes [--ref <notes-ref>] [list [<object>]]"
 msgstr "git notes [--ref <Notiz-Referenz>] [list [<Objekt>]]"
=20
 #: builtin/notes.c:25
-#, fuzzy
 msgid ""
 "git notes [--ref <notes-ref>] add [-f] [--allow-empty] [-m <msg> | -F=
 <file> "
 "| (-c | -C) <object>] [<object>]"
@@ -7708,13 +7656,11 @@ msgstr ""
 "<Beschreibung> | -F <Datei> | (-c | -C) <Objekt>] [<Objekt>]"
=20
 #: builtin/notes.c:26
-#, fuzzy
 msgid "git notes [--ref <notes-ref>] copy [-f] <from-object> <to-objec=
t>"
 msgstr ""
 "git notes [--ref <Notiz-Referenz>] copy [-f] <von-Objekt> <nach-Objek=
t>"
=20
 #: builtin/notes.c:27
-#, fuzzy
 msgid ""
 "git notes [--ref <notes-ref>] append [--allow-empty] [-m <msg> | -F <=
file> | "
 "(-c | -C) <object>] [<object>]"
@@ -7723,21 +7669,18 @@ msgstr ""
 "| -F <Datei> | (-c | -C) <Objekt>] [<Objekt>]"
=20
 #: builtin/notes.c:28
-#, fuzzy
 msgid "git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"
 msgstr "git notes [--ref <Notiz-Referenz>] edit [--allow-empty] [<Obje=
kt>]"
=20
 #: builtin/notes.c:29
-#, fuzzy
 msgid "git notes [--ref <notes-ref>] show [<object>]"
 msgstr "git notes [--ref <Notiz-Referenz>] show [<Objekt>]"
=20
 #: builtin/notes.c:30
-#, fuzzy
 msgid ""
 "git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-=
ref>"
 msgstr ""
-"git notes [--ref <Notiz-Referenz>] merge [-v | -q] [-s <Strategie> ] =
<Notiz-"
+"git notes [--ref <Notiz-Referenz>] merge [-v | -q] [-s <Strategie>] <=
Notiz-"
 "Referenz>"
=20
 #: builtin/notes.c:31
@@ -7749,17 +7692,14 @@ msgid "git notes merge --abort [-v | -q]"
 msgstr "git notes merge --abort [-v | -q]"
=20
 #: builtin/notes.c:33
-#, fuzzy
 msgid "git notes [--ref <notes-ref>] remove [<object>...]"
 msgstr "git notes [--ref <Notiz-Referenz>] remove [<Objekt>...]"
=20
 #: builtin/notes.c:34
-#, fuzzy
 msgid "git notes [--ref <notes-ref>] prune [-n | -v]"
 msgstr "git notes [--ref <Notiz-Referenz>] prune [-n | -v]"
=20
 #: builtin/notes.c:35
-#, fuzzy
 msgid "git notes [--ref <notes-ref>] get-ref"
 msgstr "git notes [--ref <Notiz-Referenz>] get-ref"
=20
@@ -7792,7 +7732,6 @@ msgid "git notes show [<object>]"
 msgstr "git notes show [<Objekt>]"
=20
 #: builtin/notes.c:71
-#, fuzzy
 msgid "git notes merge [<options>] <notes-ref>"
 msgstr "git notes merge [<Optionen>] <Notiz-Referenz>"
=20
@@ -8035,7 +7974,6 @@ msgid "notes-ref"
 msgstr "Notiz-Referenz"
=20
 #: builtin/notes.c:954
-#, fuzzy
 msgid "use notes from <notes-ref>"
 msgstr "Notizen von <Notiz-Referenz> verwenden"
=20
@@ -8243,9 +8181,8 @@ msgid "Counting objects"
 msgstr "Z=C3=A4hle Objekte"
=20
 #: builtin/pack-refs.c:6
-#, fuzzy
 msgid "git pack-refs [<options>]"
-msgstr "git pack-refs [Optionen]"
+msgstr "git pack-refs [<Optionen>]"
=20
 #: builtin/pack-refs.c:14
 msgid "pack everything"
@@ -8256,9 +8193,8 @@ msgid "prune loose refs (default)"
 msgstr "lose Referenzen entfernen (Standard)"
=20
 #: builtin/prune-packed.c:7
-#, fuzzy
 msgid "git prune-packed [-n | --dry-run] [-q | --quiet]"
-msgstr "git prune-packed [-n|--dry-run] [-q|--quiet]"
+msgstr "git prune-packed [-n | --dry-run] [-q | --quiet]"
=20
 #: builtin/prune-packed.c:40
 msgid "Removing duplicate objects"
@@ -8617,7 +8553,7 @@ msgstr "signiert \"push\" mit GPG"
=20
 #: builtin/push.c:530
 msgid "request atomic transaction on remote side"
-msgstr ""
+msgstr "Referenzen atomar versenden"
=20
 #: builtin/push.c:539
 msgid "--delete is incompatible with --all, --mirror and --tags"
@@ -8717,12 +8653,11 @@ msgid "git remote [-v | --verbose]"
 msgstr "git remote [-v | --verbose]"
=20
 #: builtin/remote.c:13
-#, fuzzy
 msgid ""
 "git remote add [-t <branch>] [-m <master>] [-f] [--tags | --no-tags] =
[--"
 "mirror=3D<fetch|push>] <name> <url>"
 msgstr ""
-"git remote add [-t <Branch>] [-m <master>] [-f] [--tags|--no-tags] [-=
-"
+"git remote add [-t <Branch>] [-m <master>] [-f] [--tags | --no-tags] =
[--"
 "mirror=3D<fetch|push>] <Name> <URL>"
=20
 #: builtin/remote.c:14 builtin/remote.c:33
@@ -9216,9 +9151,8 @@ msgid "be verbose; must be placed before a subcom=
mand"
 msgstr "erweiterte Ausgaben; muss vor einem Unterkommando angegeben we=
rden"
=20
 #: builtin/repack.c:17
-#, fuzzy
 msgid "git repack [<options>]"
-msgstr "git repack [Optionen]"
+msgstr "git repack [<Optionen>]"
=20
 #: builtin/repack.c:159
 msgid "pack everything in a single pack"
@@ -9379,9 +9313,8 @@ msgid "use this format"
 msgstr "das angegebene Format benutzen"
=20
 #: builtin/rerere.c:12
-#, fuzzy
 msgid "git rerere [clear | forget <path>... | status | remaining | dif=
f | gc]"
-msgstr "git rerere [clean | forget path... | status | remaining | diff=
 | gc]"
+msgstr "git rerere [clean | forget <Pfad>... | status | remaining | di=
ff | gc]"
=20
 #: builtin/rerere.c:57
 msgid "register clean resolutions in index"
@@ -9521,9 +9454,8 @@ msgid "Could not write new index file."
 msgstr "Konnte neue Staging-Area-Datei nicht schreiben."
=20
 #: builtin/rev-parse.c:361
-#, fuzzy
 msgid "git rev-parse --parseopt [<options>] -- [<args>...]"
-msgstr "git rev-parse --parseopt [Optionen] -- [<Argumente>...]"
+msgstr "git rev-parse --parseopt [<Optionen>] -- [<Argumente>...]"
=20
 #: builtin/rev-parse.c:366
 msgid "keep the `--` passed as an arg"
@@ -9539,7 +9471,6 @@ msgstr ""
 "Ausgabe in Langform mit Argumenten an den Optionen (getrennt durch '=3D=
')"
=20
 #: builtin/rev-parse.c:499
-#, fuzzy
 msgid ""
 "git rev-parse --parseopt [<options>] -- [<args>...]\n"
 "   or: git rev-parse --sq-quote [<arg>...]\n"
@@ -9547,26 +9478,24 @@ msgid ""
 "\n"
 "Run \"git rev-parse --parseopt -h\" for more information on the first=
 usage."
 msgstr ""
-"git rev-parse --parseopt [Optionen] -- [<Argumente>...]\n"
+"git rev-parse --parseopt [<Optionen>] -- [<Argumente>...]\n"
 "   oder: git rev-parse --sq-quote [<Argumente>...]\n"
-"   oder: git rev-parse [Optionen] [<Argumente>...]\n"
+"   oder: git rev-parse [<Optionen>] [<Argumente>...]\n"
 "\n"
 "F=C3=BChren Sie \"git rev-parse --parseopt -h\" f=C3=BCr weitere Info=
rmationen bei "
 "erster Verwendung aus."
=20
 #: builtin/revert.c:22
-#, fuzzy
 msgid "git revert [<options>] <commit-ish>..."
-msgstr "git revert [Optionen] <Commit-Angabe>..."
+msgstr "git revert [<Optionen>] <Commit-Angabe>..."
=20
 #: builtin/revert.c:23
 msgid "git revert <subcommand>"
 msgstr "git revert <Unterkommando>"
=20
 #: builtin/revert.c:28
-#, fuzzy
 msgid "git cherry-pick [<options>] <commit-ish>..."
-msgstr "git cherry-pick [Optionen] <Commit-Angabe>..."
+msgstr "git cherry-pick [<Optionen>] <Commit-Angabe>..."
=20
 #: builtin/revert.c:29
 msgid "git cherry-pick <subcommand>"
@@ -9646,9 +9575,8 @@ msgid "cherry-pick failed"
 msgstr "\"cherry-pick\" fehlgeschlagen"
=20
 #: builtin/rm.c:17
-#, fuzzy
 msgid "git rm [<options>] [--] <file>..."
-msgstr "git rm [Optionen] [--] [<Datei>...]"
+msgstr "git rm [<Optionen>] [--] <Datei>..."
=20
 #: builtin/rm.c:65
 msgid ""
@@ -9755,9 +9683,8 @@ msgid "git rm: unable to remove %s"
 msgstr "git rm: konnte %s nicht l=C3=B6schen"
=20
 #: builtin/shortlog.c:13
-#, fuzzy
 msgid "git shortlog [<options>] [<revision-range>] [[--] [<path>...]]"
-msgstr "git shortlog [<Optionen>] [Commitbereich] [[--] <Pfad>...]"
+msgstr "git shortlog [<Optionen>] [<Commitbereich>] [[--] [<Pfad>...]]=
"
=20
 #: builtin/shortlog.c:131
 #, c-format
@@ -9785,22 +9712,20 @@ msgid "Linewrap output"
 msgstr "Ausgabe mit Zeilenumbr=C3=BCchen"
=20
 #: builtin/show-branch.c:9
-#, fuzzy
 msgid ""
 "git show-branch [-a | --all] [-r | --remotes] [--topo-order | --date-=
order]\n"
 "\t\t[--current] [--color[=3D<when>] | --no-color] [--sparse]\n"
 "\t\t[--more=3D<n> | --list | --independent | --merge-base]\n"
 "\t\t[--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"
 msgstr ""
-"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r]\n"
+"git show-branch [-a | --all] [-r | --remotes] [--topo-order | --date-=
order]\n"
 "\t\t[--current] [--color[=3D<Wann>] | --no-color] [--sparse]\n"
 "\t\t[--more=3D<n> | --list | --independent | --merge-base]\n"
 "\t\t[--no-name | --sha1-name] [--topics] [(<Commit> | <glob>)...]"
=20
 #: builtin/show-branch.c:13
-#, fuzzy
 msgid "git show-branch (-g | --reflog)[=3D<n>[,<base>]] [--list] [<ref=
>]"
-msgstr "git show-branch (-g|--reflog)[=3D<n>[,<Basis>]] [--list] [<Ref=
erenz>]"
+msgstr "git show-branch (-g | --reflog)[=3D<n>[,<Basis>]] [--list] [<R=
eferenz>]"
=20
 #: builtin/show-branch.c:652
 msgid "show remote-tracking and local branches"
@@ -9868,13 +9793,12 @@ msgid "show <n> most recent ref-log entries sta=
rting at base"
 msgstr "die <n> j=C3=BCngsten Eintr=C3=A4ge im Reflog, beginnend an de=
r Basis, anzeigen"
=20
 #: builtin/show-ref.c:10
-#, fuzzy
 msgid ""
 "git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference] =
[-s | --"
 "hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags] [--heads] [--] [<pattern>..=
=2E]"
 msgstr ""
-"git show-ref [-q|--quiet] [--verify] [--head] [-d|--dereference] [-s|=
--"
-"hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags] [--heads] [--] [pattern*] "
+"git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference] =
[-s | --"
+"hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags] [--heads] [--] [<Muster>...=
] "
=20
 #: builtin/show-ref.c:11
 msgid "git show-ref --exclude-existing[=3Dpattern] < ref-list"
@@ -9917,14 +9841,12 @@ msgstr ""
 "Repository befinden"
=20
 #: builtin/symbolic-ref.c:7
-#, fuzzy
 msgid "git symbolic-ref [<options>] <name> [<ref>]"
-msgstr "git symbolic-ref [Optionen] name [ref]"
+msgstr "git symbolic-ref [<Optionen>] <Name> [<Referenz>]"
=20
 #: builtin/symbolic-ref.c:8
-#, fuzzy
 msgid "git symbolic-ref -d [-q] <name>"
-msgstr "git symbolic-ref -d [-q] name"
+msgstr "git symbolic-ref -d [-q] <Name>"
=20
 #: builtin/symbolic-ref.c:40
 msgid "suppress error message for non-symbolic (detached) refs"
@@ -9948,12 +9870,11 @@ msgid "reason of the update"
 msgstr "Grund f=C3=BCr die Aktualisierung"
=20
 #: builtin/tag.c:22
-#, fuzzy
 msgid ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname>=
 "
 "[<head>]"
 msgstr ""
-"git tag [-a|-s|-u <Schl=C3=BCssel-id>] [-f] [-m <Beschreibung>|-F <Da=
tei>] "
+"git tag [-a | -s | -u <Schl=C3=BCssel-id>] [-f] [-m <Beschreibung> | =
-F <Datei>] "
 "<Tagname> [<Commit>]"
=20
 #: builtin/tag.c:23
@@ -9961,12 +9882,11 @@ msgid "git tag -d <tagname>..."
 msgstr "git tag -d <Tagname>..."
=20
 #: builtin/tag.c:24
-#, fuzzy
 msgid ""
 "git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]\n=
"
 "\t\t[<pattern>...]"
 msgstr ""
-"git tag -l [-n[<Nummer>]] [--contains <Commit>] [--points-at <Objekt>=
] \n"
+"git tag -l [-n[<Nummer>]] [--contains <Commit>] [--points-at <Objekt>=
]\n"
 "\t\t[<Muster>...]"
=20
 #: builtin/tag.c:26
@@ -10178,9 +10098,8 @@ msgid "Unpacking objects"
 msgstr "Entpacke Objekte"
=20
 #: builtin/update-index.c:403
-#, fuzzy
 msgid "git update-index [<options>] [--] [<file>...]"
-msgstr "git update-index [Optionen] [--] [<Datei>...]"
+msgstr "git update-index [<Optionen>] [--] [<Datei>...]"
=20
 #: builtin/update-index.c:756
 msgid "continue refresh even when index needs update"
@@ -10303,19 +10222,16 @@ msgid "enable or disable split index"
 msgstr "Aktivierung oder Deaktivierung des Splittings der Staging-Area=
"
=20
 #: builtin/update-ref.c:9
-#, fuzzy
 msgid "git update-ref [<options>] -d <refname> [<old-val>]"
-msgstr "git update-ref [Optionen] -d <Referenzname> [<alterWert>]"
+msgstr "git update-ref [<Optionen>] -d <Referenzname> [<alter-Wert>]"
=20
 #: builtin/update-ref.c:10
-#, fuzzy
 msgid "git update-ref [<options>]    <refname> <new-val> [<old-val>]"
-msgstr "git update-ref [Optionen]    <Referenzname> <neuerWert> [<alte=
rWert>]"
+msgstr "git update-ref [<Optionen>]    <Referenzname> <neuer-Wert> [<a=
lter-Wert>]"
=20
 #: builtin/update-ref.c:11
-#, fuzzy
 msgid "git update-ref [<options>] --stdin [-z]"
-msgstr "git update-ref [Optionen] --stdin [-z]"
+msgstr "git update-ref [<Optionen>] --stdin [-z]"
=20
 #: builtin/update-ref.c:359
 msgid "delete the reference"
@@ -10342,18 +10258,16 @@ msgid "update the info files from scratch"
 msgstr "die Informationsdateien von Grund auf aktualisieren"
=20
 #: builtin/verify-commit.c:17
-#, fuzzy
 msgid "git verify-commit [-v | --verbose] <commit>..."
-msgstr "git verify-commit [-v|--verbose] <Commit>..."
+msgstr "git verify-commit [-v | --verbose] <Commit>..."
=20
 #: builtin/verify-commit.c:75
 msgid "print commit contents"
 msgstr "Commit-Inhalte ausgeben"
=20
 #: builtin/verify-pack.c:54
-#, fuzzy
 msgid "git verify-pack [-v | --verbose] [-s | --stat-only] <pack>..."
-msgstr "git verify-pack [-v|--verbose] [-s|--stat-only] <Paket>..."
+msgstr "git verify-pack [-v | --verbose] [-s | --stat-only] <Paket>...=
"
=20
 #: builtin/verify-pack.c:64
 msgid "verbose"
@@ -10364,9 +10278,8 @@ msgid "show statistics only"
 msgstr "nur Statistiken anzeigen"
=20
 #: builtin/verify-tag.c:17
-#, fuzzy
 msgid "git verify-tag [-v | --verbose] <tag>..."
-msgstr "git verify-tag [-v|--verbose] <Tag>..."
+msgstr "git verify-tag [-v | --verbose] <Tag>..."
=20
 #: builtin/verify-tag.c:73
 msgid "print tag contents"
@@ -10735,12 +10648,12 @@ msgid "Bad HEAD - I need a HEAD"
 msgstr "Ung=C3=BCltiger HEAD - HEAD wird ben=C3=B6tigt"
=20
 #: git-bisect.sh:130
-#, fuzzy, sh-format
+#, sh-format
 msgid ""
 "Checking out '$start_head' failed. Try 'git bisect reset <valid-branc=
h>'."
 msgstr ""
 "Auschecken von '$start_head' fehlgeschlagen. Versuchen Sie 'git bisec=
t reset "
-"<gueltigerbranch>'."
+"<g=C3=BCltiger-Branch>'."
=20
 #: git-bisect.sh:140
 msgid "won't bisect on cg-seek'ed tree"
--=20
2.3.4.554.gb58f7a9

From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH 1/3] l10n: de.po: switch from pure German to German+English (part 1)
Date: Wed, 12 Jun 2013 19:15:29 +0200
Message-ID: <1371057331-3917-2-git-send-email-ralf.thielow@gmail.com>
References: <1371057331-3917-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Wed Jun 12 19:16:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umoeo-0004rg-OP
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 19:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078Ab3FLRQS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 13:16:18 -0400
Received: from mail-bk0-f47.google.com ([209.85.214.47]:63906 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066Ab3FLRQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 13:16:16 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg1so4512017bkc.34
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=s+0UcMg+Z4tUXCL6ajUger7p+5bHENdGkqirsfWh0rM=;
        b=ymRsHK8VqH20t15AClrch8LLVIwwydozdpdP6celtFndMW44vdBxeZFfv38WAa7C9l
         aEiST3rswzFfwcI0nf1m+RbXpmEdYM8osN7mSnJT5Oe0EfgHiJ/Obg1mjkC6ZXchfVKG
         gsVOAvuv41+KzuUZTfMTEws1gE93kCpld6yy2SV12Sa+HKIlsVZFfjYLGngIHucz9jBh
         183PVHVvoWKC7MMYTgaktaHz5meosUbuwixfzjnmCWt0o8lK4331MtMzPzorpQCzuDdu
         4qUBtPlR8nrj8lU/9kbbKYT5Nx1W/IOMj5FstMKoda8aUP0UZJu4WL9YQW9ZO7Z0cd8J
         8P2A==
X-Received: by 10.204.237.130 with SMTP id ko2mr3153912bkb.154.1371057373727;
        Wed, 12 Jun 2013 10:16:13 -0700 (PDT)
Received: from localhost (dslb-178-005-125-192.pools.arcor-ip.net. [178.5.125.192])
        by mx.google.com with ESMTPSA id ok9sm2038015bkb.8.2013.06.12.10.16.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Jun 2013 10:16:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1228.g75fb170
In-Reply-To: <1371057331-3917-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227657>

This switches the translation from pure German to German+English.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 565 ++++++++++++++++++++++++++++++++-----------------------=
--------
 1 file changed, 283 insertions(+), 282 deletions(-)

diff --git a/po/de.po b/po/de.po
index 4901488..ff69291 100644
--- a/po/de.po
+++ b/po/de.po
@@ -33,14 +33,14 @@ msgid ""
 "appropriate to mark resolution and make a commit,\n"
 "or use 'git commit -a'."
 msgstr ""
-"Korrigieren Sie dies im Arbeitsbaum,\n"
+"Korrigieren Sie dies im Arbeitsverzeichnis,\n"
 "und benutzen Sie dann 'git add/rm <Datei>'\n"
-"um die Aufl=C3=B6sung entsprechend zu markieren und einzutragen,\n"
+"um die Aufl=C3=B6sung entsprechend zu markieren und zu committen,\n"
 "oder benutzen Sie 'git commit -a'."
=20
 #: archive.c:10
 msgid "git archive [options] <tree-ish> [<path>...]"
-msgstr "git archive [Optionen] <Versionsreferenz> [<Pfad>...]"
+msgstr "git archive [Optionen] <Commit-Referenz> [<Pfad>...]"
=20
 #: archive.c:11
 msgid "git archive --list"
@@ -50,12 +50,12 @@ msgstr "git archive --list"
 msgid ""
 "git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [<pat=
h>...]"
 msgstr ""
-"git archive --remote <Projektarchiv> [--exec <Programm>] [Optionen] "
-"<Versionsreferenz> [Pfad...]"
+"git archive --remote <Repository> [--exec <Programm>] [Optionen] "
+"<Commit-Referenz> [Pfad...]"
=20
 #: archive.c:13
 msgid "git archive --remote <repo> [--exec <cmd>] --list"
-msgstr "git archive --remote <Projektarchiv> [--exec <Programm>] --lis=
t"
+msgstr "git archive --remote <Repository> [--exec <Programm>] --list"
=20
 #: archive.c:323
 msgid "fmt"
@@ -63,7 +63,7 @@ msgstr "Format"
=20
 #: archive.c:323
 msgid "archive format"
-msgstr "Ausgabeformat"
+msgstr "Archivformat"
=20
 #: archive.c:324 builtin/log.c:1126
 msgid "prefix"
@@ -71,7 +71,7 @@ msgstr "Prefix"
=20
 #: archive.c:325
 msgid "prepend prefix to each pathname in the archive"
-msgstr "stellt einen Pr=C3=A4fix vor jeden Pfadnamen in der Ausgabe"
+msgstr "stellt einen Pr=C3=A4fix vor jeden Pfadnamen in dem Archiv"
=20
 #: archive.c:326 builtin/archive.c:88 builtin/blame.c:2371
 #: builtin/blame.c:2372 builtin/config.c:55 builtin/fast-export.c:665
@@ -83,7 +83,7 @@ msgstr "Datei"
=20
 #: archive.c:327 builtin/archive.c:89
 msgid "write the archive to this file"
-msgstr "schreibt die Ausgabe in diese Datei"
+msgstr "schreibt das Archiv in diese Datei"
=20
 #: archive.c:329
 msgid "read .gitattributes in working directory"
@@ -107,15 +107,15 @@ msgstr "besser komprimieren"
=20
 #: archive.c:343
 msgid "list supported archive formats"
-msgstr "listet unterst=C3=BCtzte Ausgabeformate auf"
+msgstr "listet unterst=C3=BCtzte Archivformate auf"
=20
 #: archive.c:345 builtin/archive.c:90 builtin/clone.c:86
 msgid "repo"
-msgstr "Projektarchiv"
+msgstr "Repository"
=20
 #: archive.c:346 builtin/archive.c:91
 msgid "retrieve the archive from remote repository <repo>"
-msgstr "ruft das Archiv von externem Projektarchiv <Projektarchiv> ab"
+msgstr "ruft das Archiv von Remote-Repository <Repository> ab"
=20
 #: archive.c:347 builtin/archive.c:92 builtin/notes.c:615
 msgid "command"
@@ -136,86 +136,86 @@ msgstr ""
 #: branch.c:60
 #, c-format
 msgid "Not setting branch %s as its own upstream."
-msgstr "Zweig %s kann nicht sein eigener =C3=9Cbernahmezweig sein."
+msgstr "Branch %s kann nicht sein eigener Upstream-Branch sein."
=20
 #: branch.c:82
 #, c-format
 msgid "Branch %s set up to track remote branch %s from %s by rebasing.=
"
-msgstr "Zweig %s konfiguriert zum Folgen von externem Zweig %s von %s =
durch "
-"Neuaufbau."
+msgstr "Branch %s konfiguriert zum Folgen von Remote-Branch %s von %s =
durch "
+"Rebase."
=20
 #: branch.c:83
 #, c-format
 msgid "Branch %s set up to track remote branch %s from %s."
-msgstr "Zweig %s konfiguriert zum Folgen von externem Zweig %s von %s.=
"
+msgstr "Branch %s konfiguriert zum Folgen von Remote-Branch %s von %s.=
"
=20
 #: branch.c:87
 #, c-format
 msgid "Branch %s set up to track local branch %s by rebasing."
-msgstr "Zweig %s konfiguriert zum Folgen von lokalem Zweig %s durch Ne=
uaufbau."
+msgstr "Branch %s konfiguriert zum Folgen von lokalem Branch %s durch =
Rebase."
=20
 #: branch.c:88
 #, c-format
 msgid "Branch %s set up to track local branch %s."
-msgstr "Zweig %s konfiguriert zum Folgen von lokalem Zweig %s."
+msgstr "Branch %s konfiguriert zum Folgen von lokalem Branch %s."
=20
 #: branch.c:92
 #, c-format
 msgid "Branch %s set up to track remote ref %s by rebasing."
-msgstr "Zweig %s konfiguriert zum Folgen von externer Referenz %s durc=
h "
-"Neuaufbau."
+msgstr "Branch %s konfiguriert zum Folgen von Remote-Referenz %s durch=
 "
+"Rebase."
=20
 #: branch.c:93
 #, c-format
 msgid "Branch %s set up to track remote ref %s."
-msgstr "Zweig %s konfiguriert zum Folgen von externer Referenz %s."
+msgstr "Branch %s konfiguriert zum Folgen von Remote-Referenz %s."
=20
 #: branch.c:97
 #, c-format
 msgid "Branch %s set up to track local ref %s by rebasing."
-msgstr "Zweig %s konfiguriert zum Folgen von lokaler Referenz %s durch=
 "
-"Neuaufbau."
+msgstr "Branch %s konfiguriert zum Folgen von lokaler Referenz %s durc=
h "
+"Rebase."
=20
 #: branch.c:98
 #, c-format
 msgid "Branch %s set up to track local ref %s."
-msgstr "Zweig %s konfiguriert zum Folgen von lokaler Referenz %s."
+msgstr "Branch %s konfiguriert zum Folgen von lokaler Referenz %s."
=20
 #: branch.c:118
 #, c-format
 msgid "Tracking not set up: name too long: %s"
-msgstr "Konfiguration zum Folgen von Zweig nicht eingerichtet. Name zu=
 lang: %s"
+msgstr "Konfiguration zum Folgen von Branch nicht eingerichtet. Name z=
u lang: %s"
=20
 #: branch.c:137
 #, c-format
 msgid "Not tracking: ambiguous information for ref %s"
-msgstr "Konfiguration zum Folgen von Zweig nicht eingerichtet. Referen=
z %s ist mehrdeutig."
+msgstr "Konfiguration zum Folgen von Branch nicht eingerichtet. Refere=
nz %s ist mehrdeutig."
=20
 #: branch.c:182
 #, c-format
 msgid "'%s' is not a valid branch name."
-msgstr "'%s' ist kein g=C3=BCltiger Zweigname."
+msgstr "'%s' ist kein g=C3=BCltiger Branchname."
=20
 #: branch.c:187
 #, c-format
 msgid "A branch named '%s' already exists."
-msgstr "Zweig '%s' existiert bereits."
+msgstr "Branch '%s' existiert bereits."
=20
 #: branch.c:195
 msgid "Cannot force update the current branch."
-msgstr "Kann Aktualisierung des aktuellen Zweiges nicht erzwingen."
+msgstr "Kann Aktualisierung des aktuellen Branches nicht erzwingen."
=20
 #: branch.c:201
 #, c-format
 msgid "Cannot setup tracking information; starting point '%s' is not a=
 branch."
 msgstr ""
-"Kann Informationen zum =C3=9Cbernahmezweig nicht einrichten; Startpun=
kt '%s' ist "
-"kein Zweig."
+"Kann Tracking-Informationen nicht einrichten; Startpunkt '%s' ist kei=
n "
+"Branch."
=20
 #: branch.c:203
 #, c-format
 msgid "the requested upstream branch '%s' does not exist"
-msgstr "der angeforderte externe =C3=9Cbernahmezweig '%s' existiert ni=
cht"
+msgstr "der angeforderte Upstream-Branch '%s' existiert nicht"
=20
 #: branch.c:205
 msgid ""
@@ -229,14 +229,14 @@ msgid ""
 "\"git push -u\" to set the upstream config as you push."
 msgstr ""
 "\n"
-"Falls Sie vorhaben, Ihre Arbeit auf einem bereits existierenden,\n"
-"externen =C3=9Cbernahmezweig aufzubauen, sollten Sie \"git fetch\"\n"
+"Falls Sie vorhaben, Ihre Arbeit auf einem bereits existierenden\n"
+"Upstream-Branch aufzubauen, sollten Sie \"git fetch\"\n"
 "ausf=C3=BChren, um diesen abzurufen.\n"
 "\n"
-"Falls Sie vorhaben, einen neuen lokalen Zweig zu versenden\n"
+"Falls Sie vorhaben, einen neuen lokalen Branch zu versenden\n"
 "der seinem externen Gegenst=C3=BCck folgen soll, k=C3=B6nnen Sie\n"
-"\"git push -u\" verwenden, um den externen =C3=9Cbernahmezweig\n"
-"beim Versand zu konfigurieren."
+"\"git push -u\" verwenden, um den Upstream-Branch beim \"push\"\n"
+"zu konfigurieren."
=20
 #: branch.c:250
 #, c-format
@@ -251,7 +251,7 @@ msgstr "mehrdeutiger Objekt-Name: '%s'"
 #: branch.c:275
 #, c-format
 msgid "Not a valid branch point: '%s'."
-msgstr "Ung=C3=BCltiger Verzweigungspunkt: '%s'"
+msgstr "Ung=C3=BCltiger Branchpunkt: '%s'"
=20
 #: branch.c:281
 msgid "Failed to lock ref for update"
@@ -278,7 +278,7 @@ msgstr "Konnte '%s' nicht =C3=B6ffnen"
=20
 #: bundle.c:140
 msgid "Repository lacks these prerequisite commits:"
-msgstr "Dem Projektarchiv fehlen folgende vorausgesetzte Versionen:"
+msgstr "Dem Repository fehlen folgende vorausgesetzte Commits:"
=20
 #: bundle.c:164 sequencer.c:651 sequencer.c:1101 builtin/log.c:300
 #: builtin/log.c:770 builtin/log.c:1344 builtin/log.c:1570 builtin/mer=
ge.c:349
@@ -347,7 +347,7 @@ msgstr "konnte %s nicht parsen"
 #: commit.c:52
 #, c-format
 msgid "%s %s is not a commit!"
-msgstr "%s %s ist keine Version!"
+msgstr "%s %s ist kein Commit!"
=20
 #: compat/obstack.c:406 compat/obstack.c:408
 msgid "memory exhausted"
@@ -576,12 +576,12 @@ msgstr "Lesen des Zwischenspeichers fehlgeschlage=
n"
 #: merge.c:110 builtin/checkout.c:365 builtin/checkout.c:566
 #: builtin/clone.c:645
 msgid "unable to write new index file"
-msgstr "Konnte neue Bereitstellungsdatei nicht schreiben."
+msgstr "Konnte neue Staging-Area-Datei nicht schreiben."
=20
 #: merge-recursive.c:190
 #, c-format
 msgid "(bad commit)\n"
-msgstr "(ung=C3=BCltige Version)\n"
+msgstr "(ung=C3=BCltiger Commit)\n"
=20
 #: merge-recursive.c:206
 #, c-format
@@ -590,7 +590,7 @@ msgstr "addinfo_cache f=C3=BCr Pfad '%s' fehlgeschl=
agen"
=20
 #: merge-recursive.c:268
 msgid "error building trees"
-msgstr "Fehler beim Erstellen der B=C3=A4ume"
+msgstr "Fehler beim Erstellen der Verzeichnisse"
=20
 #: merge-recursive.c:672
 #, c-format
@@ -631,7 +631,7 @@ msgstr "Fehler beim =C3=96ffnen von '%s'"
 #: merge-recursive.c:781
 #, c-format
 msgid "failed to symlink '%s'"
-msgstr "Fehler beim Erstellen einer symbolischen Verkn=C3=BCpfung f=C3=
=BCr '%s'"
+msgstr "Fehler beim Erstellen eines symbolischen Verweises f=C3=BCr '%=
s'"
=20
 #: merge-recursive.c:784
 #, c-format
@@ -640,7 +640,7 @@ msgstr "wei=C3=9F nicht was mit %06o %s '%s' zu mac=
hen ist"
=20
 #: merge-recursive.c:922
 msgid "Failed to execute internal merge"
-msgstr "Fehler bei Ausf=C3=BChrung der internen Zusammenf=C3=BChrung"
+msgstr "Fehler bei Ausf=C3=BChrung des internen Merges"
=20
 #: merge-recursive.c:926
 #, c-format
@@ -649,7 +649,7 @@ msgstr "Konnte %s nicht zur Datenbank hinzuf=C3=BCg=
en"
=20
 #: merge-recursive.c:942
 msgid "unsupported object type in the tree"
-msgstr "nicht unterst=C3=BCtzter Objekttyp im Baum"
+msgstr "nicht unterst=C3=BCtzter Objekttyp im Verzeichnis"
=20
 #: merge-recursive.c:1021 merge-recursive.c:1035
 #, c-format
@@ -688,8 +688,8 @@ msgid ""
 "CONFLICT (rename/rename): Rename \"%s\"->\"%s\" in branch \"%s\" rena=
me \"%s"
 "\"->\"%s\" in \"%s\"%s"
 msgstr ""
-"KONFLIKT (umbenennen/umbenennen): Benenne um \"%s\"->\"%s\" in Zweig =
\"%s\" "
-"und \"%s\"->\"%s\" in Zweig \"%s\"%s"
+"KONFLIKT (umbenennen/umbenennen): Benenne um \"%s\"->\"%s\" in Branch=
 \"%s\" "
+"und \"%s\"->\"%s\" in Branch \"%s\"%s"
=20
 #: merge-recursive.c:1164
 msgid " (left unresolved)"
@@ -753,21 +753,21 @@ msgstr "hinzuf=C3=BCgen/hinzuf=C3=BCgen"
 #: merge-recursive.c:1615
 #, c-format
 msgid "Skipped %s (merged same as existing)"
-msgstr "%s ausgelassen (Ergebnis der Zusammenf=C3=BChrung existiert be=
reits)"
+msgstr "%s ausgelassen (Ergebnis des Merges existiert bereits)"
=20
 #: merge-recursive.c:1629
 #, c-format
 msgid "Auto-merging %s"
-msgstr "automatische Zusammenf=C3=BChrung von %s"
+msgstr "automatischer Merge von %s"
=20
 #: merge-recursive.c:1633 git-submodule.sh:1029
 msgid "submodule"
-msgstr "Unterprojekt"
+msgstr "Submodul"
=20
 #: merge-recursive.c:1634
 #, c-format
 msgid "CONFLICT (%s): Merge conflict in %s"
-msgstr "KONFLIKT (%s): Zusammenf=C3=BChrungskonflikt in %s"
+msgstr "KONFLIKT (%s): Merge-Konflikt in %s"
=20
 #: merge-recursive.c:1724
 #, c-format
@@ -796,7 +796,7 @@ msgstr "F=C3=BCge %s hinzu"
=20
 #: merge-recursive.c:1787
 msgid "Fatal merge failure, shouldn't happen."
-msgstr "Fataler Fehler bei der Zusammenf=C3=BChrung. Sollte nicht pass=
ieren."
+msgstr "Fataler Merge-Fehler. Sollte nicht passieren."
=20
 #: merge-recursive.c:1806
 msgid "Already up-to-date!"
@@ -805,7 +805,7 @@ msgstr "Bereits aktuell!"
 #: merge-recursive.c:1815
 #, c-format
 msgid "merging of trees %s and %s failed"
-msgstr "Zusammenf=C3=BChren der B=C3=A4ume %s und %s fehlgeschlagen"
+msgstr "Zusammenf=C3=BChren der Verzeichnisse %s und %s fehlgeschlagen=
"
=20
 #: merge-recursive.c:1845
 #, c-format
@@ -814,18 +814,18 @@ msgstr "unverarbeiteter Pfad??? %s"
=20
 #: merge-recursive.c:1890
 msgid "Merging:"
-msgstr "Zusammenf=C3=BChrung:"
+msgstr "Merge:"
=20
 #: merge-recursive.c:1903
 #, c-format
 msgid "found %u common ancestor:"
 msgid_plural "found %u common ancestors:"
-msgstr[0] "%u gemeinsamen Vorfahren gefunden"
-msgstr[1] "%u gemeinsame Vorfahren gefunden"
+msgstr[0] "%u gemeinsamen Vorg=C3=A4nger-Commit gefunden"
+msgstr[1] "%u gemeinsame Vorg=C3=A4nger-Commits gefunden"
=20
 #: merge-recursive.c:1940
 msgid "merge returned no commit"
-msgstr "Zusammenf=C3=BChrung hat keine Version zur=C3=BCckgegeben"
+msgstr "Merge hat keinen Commit zur=C3=BCckgegeben"
=20
 #: merge-recursive.c:1997
 #, c-format
@@ -834,7 +834,7 @@ msgstr "Konnte Objekt '%s' nicht parsen."
=20
 #: merge-recursive.c:2009 builtin/merge.c:658
 msgid "Unable to write index."
-msgstr "Konnte Bereitstellung nicht schreiben."
+msgstr "Konnte Staging-Area nicht schreiben."
=20
 #: object.c:195
 #, c-format
@@ -869,23 +869,23 @@ msgstr "-NUM"
 #: pathspec.c:83
 #, c-format
 msgid "Path '%s' is in submodule '%.*s'"
-msgstr "Pfad '%s' befindet sich in Unterprojekt '%.*s'"
+msgstr "Pfad '%s' befindet sich in Submodul '%.*s'"
=20
 #: pathspec.c:99
 #, c-format
 msgid "'%s' is beyond a symbolic link"
-msgstr "'%s' ist =C3=BCber einem symbolischen Link"
+msgstr "'%s' ist hinter einem symbolischen Verweis"
=20
 #: remote.c:1781
 #, c-format
 msgid "Your branch is ahead of '%s' by %d commit.\n"
 msgid_plural "Your branch is ahead of '%s' by %d commits.\n"
-msgstr[0] "Ihr Zweig ist vor '%s' um %d Version.\n"
-msgstr[1] "Ihr Zweig ist vor '%s' um %d Versionen.\n"
+msgstr[0] "Ihr Branch ist vor '%s' um %d Commit.\n"
+msgstr[1] "Ihr Branch ist vor '%s' um %d Commits.\n"
=20
 #: remote.c:1787
 msgid "  (use \"git push\" to publish your local commits)\n"
-msgstr "  (benutzen Sie \"git push\" um lokalen Versionen herauszubrin=
gen)\n"
+msgstr "  (benutzen Sie \"git push\" um lokale Commits herauszubringen=
)\n"
=20
 #: remote.c:1790
 #, c-format
@@ -893,15 +893,15 @@ msgid "Your branch is behind '%s' by %d commit, a=
nd can be fast-forwarded.\n"
 msgid_plural ""
 "Your branch is behind '%s' by %d commits, and can be fast-forwarded.\=
n"
 msgstr[0] ""
-"Ihr Zweig ist zu '%s' um %d Version hinterher, und kann vorgespult we=
rden.\n"
+"Ihr Branch ist zu '%s' um %d Commit hinterher, und kann vorgespult we=
rden.\n"
 msgstr[1] ""
-"Ihr Zweig ist zu '%s' um %d Versionen hinterher, und kann vorgespult =
"
+"Ihr Branch ist zu '%s' um %d Commits hinterher, und kann vorgespult "
 "werden.\n"
=20
 #: remote.c:1798
 msgid "  (use \"git pull\" to update your local branch)\n"
 msgstr ""
-"  (benutzen Sie \"git pull\" um Ihren lokalen Zweig zu aktualisieren)=
\n"
+"  (benutzen Sie \"git pull\" um Ihren lokalen Branch zu aktualisieren=
)\n"
=20
 #: remote.c:1801
 #, c-format
@@ -912,16 +912,16 @@ msgid_plural ""
 "Your branch and '%s' have diverged,\n"
 "and have %d and %d different commits each, respectively.\n"
 msgstr[0] ""
-"Ihr Zweig und '%s' sind divergiert,\n"
-"und haben jeweils %d und %d unterschiedliche Versionen.\n"
+"Ihr Branch und '%s' sind divergiert,\n"
+"und haben jeweils %d und %d unterschiedliche Commits.\n"
 msgstr[1] ""
-"Ihr Zweig und '%s' sind divergiert,\n"
-"und haben jeweils %d und %d unterschiedliche Versionen.\n"
+"Ihr Branch und '%s' sind divergiert,\n"
+"und haben jeweils %d und %d unterschiedliche Commits.\n"
=20
 #: remote.c:1811
 msgid "  (use \"git pull\" to merge the remote branch into yours)\n"
 msgstr ""
-"  (benutzen Sie \"git pull\" um Ihren Zweig mit dem externen "
+"  (benutzen Sie \"git pull\" um Ihren Branch mit dem Remote-Branch "
 "zusammenzuf=C3=BChren)\n"
=20
 #: sequencer.c:206 builtin/merge.c:776 builtin/merge.c:889 builtin/mer=
ge.c:999
@@ -982,64 +982,64 @@ msgstr ""
 #: sequencer.c:319
 #, c-format
 msgid "%s: Unable to write new index file"
-msgstr "%s: Konnte neue Bereitstellungsdatei nicht schreiben"
+msgstr "%s: Konnte neue Staging-Area-Datei nicht schreiben"
=20
 #: sequencer.c:350
 msgid "Could not resolve HEAD commit\n"
-msgstr "Konnte Version der Zweigspitze (HEAD) nicht aufl=C3=B6sen\n"
+msgstr "Konnte Commit von HEAD nicht aufl=C3=B6sen\n"
=20
 #: sequencer.c:371
 msgid "Unable to update cache tree\n"
-msgstr "Konnte zwischengespeicherten Baum nicht aktualisieren\n"
+msgstr "Konnte Cache-Verzeichnis nicht aktualisieren\n"
=20
 #: sequencer.c:416
 #, c-format
 msgid "Could not parse commit %s\n"
-msgstr "Konnte Version %s nicht parsen\n"
+msgstr "Konnte Commit %s nicht parsen\n"
=20
 #: sequencer.c:421
 #, c-format
 msgid "Could not parse parent commit %s\n"
-msgstr "Konnte Elternversion %s nicht parsen\n"
+msgstr "Konnte Eltern-Commit %s nicht parsen\n"
=20
 #: sequencer.c:487
 msgid "Your index file is unmerged."
-msgstr "Ihre Bereitstellungsdatei ist nicht zusammengef=C3=BChrt."
+msgstr "Ihre Staging-Area-Datei ist nicht zusammengef=C3=BChrt."
=20
 #: sequencer.c:506
 #, c-format
 msgid "Commit %s is a merge but no -m option was given."
 msgstr ""
-"Version %s ist eine Zusammenf=C3=BChrung, aber die Option -m wurde ni=
cht "
+"Commit %s ist ein Merge, aber die Option -m wurde nicht "
 "angegeben."
=20
 #: sequencer.c:514
 #, c-format
 msgid "Commit %s does not have parent %d"
-msgstr "Version %s hat keinen Elternteil %d"
+msgstr "Commit %s hat keinen Elternteil %d"
=20
 #: sequencer.c:518
 #, c-format
 msgid "Mainline was specified but commit %s is not a merge."
 msgstr ""
-"Hauptlinie wurde spezifiziert, aber Version %s ist keine Zusammenf=C3=
=BChrung."
+"Hauptlinie wurde spezifiziert, aber Commit %s ist kein Merge."
=20
 #. TRANSLATORS: The first %s will be "revert" or
 #. "cherry-pick", the second %s a SHA1
 #: sequencer.c:531
 #, c-format
 msgid "%s: cannot parse parent commit %s"
-msgstr "%s: kann Elternversion %s nicht parsen"
+msgstr "%s: kann Eltern-Commit %s nicht parsen"
=20
 #: sequencer.c:535
 #, c-format
 msgid "Cannot get commit message for %s"
-msgstr "Kann keine Versionsbeschreibung f=C3=BCr %s bekommen"
+msgstr "Kann keine Commit-Beschreibung f=C3=BCr %s bekommen"
=20
 #: sequencer.c:621
 #, c-format
 msgid "could not revert %s... %s"
-msgstr "Konnte %s nicht zur=C3=BCcknehmen... %s"
+msgstr "Konnte \"revert\" nicht auf %s ausf=C3=BChren... %s"
=20
 #: sequencer.c:622
 #, c-format
@@ -1048,17 +1048,17 @@ msgstr "Konnte %s nicht anwenden... %s"
=20
 #: sequencer.c:654
 msgid "empty commit set passed"
-msgstr "leere Menge von Versionen =C3=BCbergeben"
+msgstr "leere Menge von Commits =C3=BCbergeben"
=20
 #: sequencer.c:662
 #, c-format
 msgid "git %s: failed to read the index"
-msgstr "git %s: Fehler beim Lesen der Bereitstellung"
+msgstr "git %s: Fehler beim Lesen der Staging-Area"
=20
 #: sequencer.c:667
 #, c-format
 msgid "git %s: failed to refresh the index"
-msgstr "git %s: Fehler beim Aktualisieren der Bereitstellung"
+msgstr "git %s: Fehler beim Aktualisieren der Staging-Area"
=20
 #: sequencer.c:725
 #, c-format
@@ -1072,7 +1072,7 @@ msgstr "Konnte Zeile %d nicht parsen."
=20
 #: sequencer.c:752
 msgid "No commits parsed."
-msgstr "Keine Versionen geparst."
+msgstr "Keine Commits geparst."
=20
 #: sequencer.c:765
 #, c-format
@@ -1128,11 +1128,11 @@ msgstr "kein \"cherry-pick\" oder \"revert\" im=
 Gang"
=20
 #: sequencer.c:882
 msgid "cannot resolve HEAD"
-msgstr "kann Zweigspitze (HEAD) nicht aufl=C3=B6sen"
+msgstr "kann HEAD nicht aufl=C3=B6sen"
=20
 #: sequencer.c:884
 msgid "cannot abort from a branch yet to be born"
-msgstr "kann nicht abbrechen: bin auf einem Zweig, der noch geboren wi=
rd"
+msgstr "kann nicht abbrechen: bin auf einem Branch, der noch geboren w=
ird"
=20
 #: sequencer.c:906 builtin/apply.c:4060
 #, c-format
@@ -1152,8 +1152,7 @@ msgstr "Unerwartetes Dateiende"
 #, c-format
 msgid "stored pre-cherry-pick HEAD file '%s' is corrupt"
 msgstr ""
-"gespeicherte \"pre-cherry-pick\" Datei der Zweigspitze (HEAD) '%s' is=
t "
-"besch=C3=A4digt"
+"gespeicherte \"pre-cherry-pick\" HEAD Datei '%s' ist besch=C3=A4digt"
=20
 #: sequencer.c:939
 #, c-format
@@ -1172,31 +1171,31 @@ msgstr "%s: ung=C3=BCltige Revision"
=20
 #: sequencer.c:1119
 msgid "Can't revert as initial commit"
-msgstr "R=C3=BCcknahme-Version kann nicht initial sein."
+msgstr "Revert-Commit kann nicht initial sein."
=20
 #: sequencer.c:1120
 msgid "Can't cherry-pick into empty head"
-msgstr "Kann \"cherry-pick\" nicht in einem leeren Zweig ausf=C3=BChre=
n."
+msgstr "Kann \"cherry-pick\" nicht in einem leeren Branch ausf=C3=BChr=
en."
=20
 #: sha1_name.c:1036
 msgid "HEAD does not point to a branch"
-msgstr "Zweigspitze (HEAD) zeigt auf keinen Zweig"
+msgstr "HEAD zeigt auf keinen Branch"
=20
 #: sha1_name.c:1039
 #, c-format
 msgid "No such branch: '%s'"
-msgstr "Kein solcher Zweig '%s'"
+msgstr "Kein solcher Branch '%s'"
=20
 #: sha1_name.c:1041
 #, c-format
 msgid "No upstream configured for branch '%s'"
-msgstr "Kein entferntes Projektarchiv f=C3=BCr Zweig '%s' konfiguriert=
=2E"
+msgstr "Kein Upstream-Branch f=C3=BCr Branch '%s' konfiguriert."
=20
 #: sha1_name.c:1044
 #, c-format
 msgid "Upstream branch '%s' not stored as a remote-tracking branch"
 msgstr ""
-"Zweig '%s' des entfernten Projektarchivs ist kein gefolgter =C3=9Cber=
nahmezweig"
+"Upstream-Branch '%s' ist nicht als Remote-Tracking-Branch gespeichert=
"
=20
 #: wrapper.c:408
 #, c-format
@@ -1225,14 +1224,14 @@ msgstr "Nicht zusammengef=C3=BChrte Pfade:"
 #, c-format
 msgid "  (use \"git reset %s <file>...\" to unstage)"
 msgstr ""
-"  (benutzen Sie \"git reset %s <Datei>...\" zum Herausnehmen aus der =
"
-"Bereitstellung)"
+"  (benutzen Sie \"git reset %s <Datei>...\" zum Entfernen aus der "
+"Staging-Area)"
=20
 #: wt-status.c:169 wt-status.c:196
 msgid "  (use \"git rm --cached <file>...\" to unstage)"
 msgstr ""
-"  (benutzen Sie \"git rm --cached <Datei>...\" zum Herausnehmen aus d=
er "
-"Bereitstellung)"
+"  (benutzen Sie \"git rm --cached <Datei>...\" zum Entfernen aus der =
"
+"Staging-Area)"
=20
 #: wt-status.c:173
 msgid "  (use \"git add <file>...\" to mark resolution)"
@@ -1252,19 +1251,21 @@ msgstr ""
=20
 #: wt-status.c:188
 msgid "Changes to be committed:"
-msgstr "zum Eintragen bereitgestellte =C3=84nderungen:"
+msgstr "zum Commit vorgemerkte =C3=84nderungen:"
=20
 #: wt-status.c:206
 msgid "Changes not staged for commit:"
-msgstr "=C3=84nderungen, die nicht zum Eintragen bereitgestellt sind:"
+msgstr "=C3=84nderungen, die nicht zum Commit vorgemerkt sind:"
=20
 #: wt-status.c:210
 msgid "  (use \"git add <file>...\" to update what will be committed)"
-msgstr "  (benutzen Sie \"git add <Datei>...\" zum Bereitstellen)"
+msgstr "  (benutzen Sie \"git add <Datei>...\" um die =C3=84nderungen =
zum Commit "
+"vorzumerken)"
=20
 #: wt-status.c:212
 msgid "  (use \"git add/rm <file>...\" to update what will be committe=
d)"
-msgstr "  (benutzen Sie \"git add/rm <Datei>...\" zum Bereitstellen)"
+msgstr "  (benutzen Sie \"git add/rm <Datei>...\" um die =C3=84nderung=
en zum "
+"Commit vorzumerken)"
=20
 #: wt-status.c:213
 msgid ""
@@ -1276,13 +1277,14 @@ msgstr ""
 #: wt-status.c:215
 msgid "  (commit or discard the untracked or modified content in submo=
dules)"
 msgstr ""
-"  (tragen Sie ein oder verwerfen Sie den unbeobachteten oder ge=C3=A4=
nderten "
-"Inhalt in den Unterprojekten)"
+"  (committen oder verwerfen Sie den unbeobachteten oder ge=C3=A4ndert=
en "
+"Inhalt in den Submodulen)"
=20
 #: wt-status.c:227
 #, c-format
 msgid "  (use \"git %s <file>...\" to include in what will be committe=
d)"
-msgstr "  (benutzen Sie \"git %s <Datei>...\" zum Einf=C3=BCgen in die=
 Eintragung)"
+msgstr "  (benutzen Sie \"git %s <Datei>...\" um die =C3=84nderungen z=
um Commit "
+"vorzumerken)"
=20
 #: wt-status.c:244
 msgid "bug"
@@ -1318,7 +1320,7 @@ msgstr "von beiden ge=C3=A4ndert:"
=20
 #: wt-status.c:285
 msgid "new commits, "
-msgstr "neue Versionen, "
+msgstr "neue Commits, "
=20
 #: wt-status.c:287
 msgid "modified content, "
@@ -1384,11 +1386,11 @@ msgstr " (beheben Sie die Konflikte und f=C3=BC=
hren Sie \"git commit\" aus)"
 #: wt-status.c:809
 msgid "All conflicts fixed but you are still merging."
 msgstr ""
-"Alle Konflikte sind behoben, aber Sie sind immer noch beim Zusammenf=C3=
=BChren."
+"Alle Konflikte sind behoben, aber Sie sind immer noch beim Merge."
=20
 #: wt-status.c:812
 msgid "  (use \"git commit\" to conclude merge)"
-msgstr "  (benutzen Sie \"git commit\" um die Zusammenf=C3=BChrung abz=
uschlie=C3=9Fen)"
+msgstr "  (benutzen Sie \"git commit\" um den Merge abzuschlie=C3=9Fen=
)"
=20
 #: wt-status.c:822
 msgid "You are in the middle of an am session."
@@ -1410,17 +1412,17 @@ msgstr " (benutzen Sie \"git am --skip\" um die=
sen Patch auszulassen)"
 #: wt-status.c:833
 msgid "  (use \"git am --abort\" to restore the original branch)"
 msgstr ""
-"  (benutzen Sie \"git am --abort\" um den urspr=C3=BCnglichen Zweig "
+"  (benutzen Sie \"git am --abort\" um den urspr=C3=BCnglichen Branch =
"
 "wiederherzustellen)"
=20
 #: wt-status.c:893 wt-status.c:910
 #, c-format
 msgid "You are currently rebasing branch '%s' on '%s'."
-msgstr "Sie sind gerade beim Neuaufbau von Zweig '%s' auf '%s'."
+msgstr "Sie sind gerade beim Rebase von Branch '%s' auf '%s'."
=20
 #: wt-status.c:898 wt-status.c:915
 msgid "You are currently rebasing."
-msgstr "Sie sind gerade beim Neuaufbau."
+msgstr "Sie sind gerade beim Rebase."
=20
 #: wt-status.c:901
 msgid "  (fix conflicts and then run \"git rebase --continue\")"
@@ -1435,7 +1437,7 @@ msgstr "  (benutzen Sie \"git rebase --skip\" um =
diesen Patch auszulassen)"
 #: wt-status.c:905
 msgid "  (use \"git rebase --abort\" to check out the original branch)=
"
 msgstr ""
-"  (benutzen Sie \"git rebase --abort\" um den urspr=C3=BCnglichen Zwe=
ig "
+"  (benutzen Sie \"git rebase --abort\" um den urspr=C3=BCnglichen Bra=
nch "
 "auszuchecken)"
=20
 #: wt-status.c:918
@@ -1447,12 +1449,12 @@ msgstr "  (alle Konflikte behoben: f=C3=BChren =
Sie \"git rebase --continue\" aus)"
 msgid ""
 "You are currently splitting a commit while rebasing branch '%s' on '%=
s'."
 msgstr ""
-"Sie teilen gerade eine Version auf, w=C3=A4hrend ein Neuaufbau von Zw=
eig '%s' auf "
+"Sie teilen gerade einen Commit auf, w=C3=A4hrend ein Rebase von Branc=
h '%s' auf "
 "'%s' im Gange ist."
=20
 #: wt-status.c:927
 msgid "You are currently splitting a commit during a rebase."
-msgstr "Sie teilen gerade eine Version w=C3=A4hrend eines Neuaufbaus a=
uf."
+msgstr "Sie teilen gerade einen Commit w=C3=A4hrend eines Rebase auf."
=20
 #: wt-status.c:930
 msgid "  (Once your working directory is clean, run \"git rebase --con=
tinue\")"
@@ -1464,17 +1466,17 @@ msgstr ""
 #, c-format
 msgid "You are currently editing a commit while rebasing branch '%s' o=
n '%s'."
 msgstr ""
-"Sie editieren gerade eine Version w=C3=A4hrend eines Neuaufbaus von Z=
weig '%s' "
+"Sie editieren gerade einen Commit w=C3=A4hrend eines Rebase von Branc=
h '%s' "
 "auf '%s'."
=20
 #: wt-status.c:939
 msgid "You are currently editing a commit during a rebase."
-msgstr "Sie editieren gerade eine Version w=C3=A4hrend eines Neuaufbau=
s."
+msgstr "Sie editieren gerade einen Commit w=C3=A4hrend eines Rebase."
=20
 #: wt-status.c:942
 msgid "  (use \"git commit --amend\" to amend the current commit)"
 msgstr ""
-"  (benutzen Sie \"git commit --amend\" um die aktuelle Version nachzu=
bessern)"
+"  (benutzen Sie \"git commit --amend\" um den aktuellen Commit nachzu=
bessern)"
=20
 #: wt-status.c:944
 msgid ""
@@ -1494,7 +1496,7 @@ msgstr "  (alle Konflikte behoben: f=C3=BChren Si=
e \"git commit\" aus)"
 #: wt-status.c:970
 #, c-format
 msgid "You are currently reverting commit %s."
-msgstr "Sie nehmen gerade Version '%s' zur=C3=BCck."
+msgstr "Sie nehmen gerade Commit '%s' zur=C3=BCck."
=20
 #: wt-status.c:975
 msgid "  (fix conflicts and run \"git revert --continue\")"
@@ -1509,12 +1511,12 @@ msgstr "  (alle Konflikte behoben: f=C3=BChren =
Sie \"git revert --continue\" aus)"
 #: wt-status.c:980
 msgid "  (use \"git revert --abort\" to cancel the revert operation)"
 msgstr ""
-"  (benutzen Sie \"git revert --abort\" um die Umkehroperation abzubre=
chen)"
+"  (benutzen Sie \"git revert --abort\" um die Revert-Operation abzubr=
echen)"
=20
 #: wt-status.c:991
 #, c-format
 msgid "You are currently bisecting, started from branch '%s'."
-msgstr "Sie sind gerade bei einer bin=C3=A4ren Suche, gestartet von Zw=
eig '%s'."
+msgstr "Sie sind gerade bei einer bin=C3=A4ren Suche, gestartet von Br=
anch '%s'."
=20
 #: wt-status.c:995
 msgid "You are currently bisecting."
@@ -1523,28 +1525,28 @@ msgstr "Sie sind gerade bei einer bin=C3=A4ren =
Suche."
 #: wt-status.c:998
 msgid "  (use \"git bisect reset\" to get back to the original branch)=
"
 msgstr ""
-"  (benutzen Sie \"git bisect reset\" um zum urspr=C3=BCnglichen Zweig=
 "
+"  (benutzen Sie \"git bisect reset\" um zum urspr=C3=BCnglichen Branc=
h "
 "zur=C3=BCckzukehren)"
=20
 #: wt-status.c:1173
 msgid "On branch "
-msgstr "Auf Zweig "
+msgstr "Auf Branch "
=20
 #: wt-status.c:1184
 msgid "HEAD detached at "
-msgstr "Zweigspitze (HEAD) losgel=C3=B6st bei "
+msgstr "HEAD losgel=C3=B6st bei "
=20
 #: wt-status.c:1186
 msgid "HEAD detached from "
-msgstr "Zweigspitze (HEAD) losgel=C3=B6st von "
+msgstr "HEAD losgel=C3=B6st von "
=20
 #: wt-status.c:1189
 msgid "Not currently on any branch."
-msgstr "Im Moment auf keinem Zweig."
+msgstr "Im Moment auf keinem Branch."
=20
 #: wt-status.c:1206
 msgid "Initial commit"
-msgstr "Initiale Version"
+msgstr "Initialer Commit"
=20
 #: wt-status.c:1220
 msgid "Untracked files"
@@ -1582,13 +1584,13 @@ msgstr "Keine =C3=84nderungen"
 #, c-format
 msgid "no changes added to commit (use \"git add\" and/or \"git commit=
 -a\")\n"
 msgstr ""
-"keine =C3=84nderungen zum Eintragen hinzugef=C3=BCgt (benutzen Sie \"=
git add\" und/"
+"keine =C3=84nderungen zum Commit vorgemerkt (benutzen Sie \"git add\"=
 und/"
 "oder \"git commit -a\")\n"
=20
 #: wt-status.c:1248
 #, c-format
 msgid "no changes added to commit\n"
-msgstr "keine =C3=84nderungen zum Eintragen hinzugef=C3=BCgt\n"
+msgstr "keine =C3=84nderungen zum Commit vorgemerkt\n"
=20
 #: wt-status.c:1251
 #, c-format
@@ -1596,45 +1598,45 @@ msgid ""
 "nothing added to commit but untracked files present (use \"git add\" =
to "
 "track)\n"
 msgstr ""
-"nichts zum Eintragen hinzugef=C3=BCgt, aber es gibt unbeobachtete Dat=
eien "
+"nichts zum Commit vorgemerkt, aber es gibt unbeobachtete Dateien "
 "(benutzen Sie \"git add\" zum Beobachten)\n"
=20
 #: wt-status.c:1254
 #, c-format
 msgid "nothing added to commit but untracked files present\n"
-msgstr "nichts zum Eintragen hinzugef=C3=BCgt, aber es gibt unbeobacht=
ete Dateien\n"
+msgstr "nichts zum Commit vorgemerkt, aber es gibt unbeobachtete Datei=
en\n"
=20
 #: wt-status.c:1257
 #, c-format
 msgid "nothing to commit (create/copy files and use \"git add\" to tra=
ck)\n"
 msgstr ""
-"nichts einzutragen (Erstellen/Kopieren Sie Dateien und benutzen Sie \=
"git add"
+"nichts zu committen (Erstellen/Kopieren Sie Dateien und benutzen Sie =
\"git add"
 "\" zum Beobachten)\n"
=20
 #: wt-status.c:1260 wt-status.c:1265
 #, c-format
 msgid "nothing to commit\n"
-msgstr "nichts einzutragen\n"
+msgstr "nichts zu committen\n"
=20
 #: wt-status.c:1263
 #, c-format
 msgid "nothing to commit (use -u to show untracked files)\n"
 msgstr ""
-"nichts einzutragen (benutzen Sie die Option -u, um unbeobachtete Date=
ien "
+"nichts zu committen (benutzen Sie die Option -u, um unbeobachtete Dat=
eien "
 "anzuzeigen)\n"
=20
 #: wt-status.c:1267
 #, c-format
 msgid "nothing to commit, working directory clean\n"
-msgstr "nichts einzutragen, Arbeitsverzeichnis sauber\n"
+msgstr "nichts zu committen, Arbeitsverzeichnis sauber\n"
=20
 #: wt-status.c:1375
 msgid "HEAD (no branch)"
-msgstr "HEAD (kein Zweig)"
+msgstr "HEAD (kein Branch)"
=20
 #: wt-status.c:1381
 msgid "Initial commit on "
-msgstr "Initiale Version auf "
+msgstr "Initialer Commit auf "
=20
 #: wt-status.c:1396
 msgid "behind "
@@ -1748,7 +1750,7 @@ msgstr "l=C3=B6sche '%s'\n"
 #: builtin/add.c:253
 msgid "Unstaged changes after refreshing the index:"
 msgstr ""
-"Nicht bereitgestellte =C3=84nderungen nach Aktualisierung der Bereits=
tellung:"
+"Nicht zum Commit vorgemerkte =C3=84nderungen nach Aktualisierung der =
Staging-Area:"
=20
 #: builtin/add.c:256 builtin/add.c:572 builtin/rm.c:275
 #, c-format
@@ -1757,7 +1759,7 @@ msgstr "Pfadspezifikation '%s' stimmt mit keinen =
Dateien =C3=BCberein"
=20
 #: builtin/add.c:339
 msgid "Could not read the index"
-msgstr "Konnte die Bereitstellung nicht lesen"
+msgstr "Konnte die Staging-Area nicht lesen"
=20
 #: builtin/add.c:349
 #, c-format
@@ -1806,7 +1808,7 @@ msgstr "interaktives Ausw=C3=A4hlen"
=20
 #: builtin/add.c:397 builtin/checkout.c:1063 builtin/reset.c:258
 msgid "select hunks interactively"
-msgstr "interaktiv Bereiche ausw=C3=A4hlen"
+msgstr "Bl=C3=B6cke interaktiv ausw=C3=A4hlen"
=20
 #: builtin/add.c:398
 msgid "edit current diff and apply"
@@ -1837,7 +1839,7 @@ msgstr "ignoriert gel=C3=B6schte Pfade im Arbeits=
verzeichnis (genau wie "
=20
 #: builtin/add.c:407
 msgid "don't add, only refresh the index"
-msgstr "f=C3=BCgt nichts hinzu, aktualisiert nur die Bereitstellung"
+msgstr "f=C3=BCgt nichts hinzu, aktualisiert nur die Staging-Area"
=20
 #: builtin/add.c:408
 msgid "just skip files which cannot be added because of errors"
@@ -1884,11 +1886,11 @@ msgstr "Wollten Sie vielleicht 'git add .' sage=
n?\n"
 #: builtin/add.c:532 builtin/check-ignore.c:66 builtin/clean.c:204
 #: builtin/commit.c:293 builtin/mv.c:82 builtin/rm.c:235
 msgid "index file corrupt"
-msgstr "Bereitstellungsdatei besch=C3=A4digt"
+msgstr "Staging-Area-Datei besch=C3=A4digt"
=20
 #: builtin/add.c:604 builtin/apply.c:4505 builtin/mv.c:229 builtin/rm.=
c:370
 msgid "Unable to write new index file"
-msgstr "Konnte neue Bereitstellungsdatei nicht schreiben."
+msgstr "Konnte neue Staging-Area-Datei nicht schreiben."
=20
 #: builtin/apply.c:57
 msgid "git apply [options] [<patch>...]"
@@ -1897,12 +1899,12 @@ msgstr "git apply [Optionen] [<Patch>...]"
 #: builtin/apply.c:110
 #, c-format
 msgid "unrecognized whitespace option '%s'"
-msgstr "nicht erkannte Option f=C3=BCr Leerzeichen: '%s'"
+msgstr "nicht erkannte Whitespace-Option: '%s'"
=20
 #: builtin/apply.c:125
 #, c-format
 msgid "unrecognized whitespace ignore option '%s'"
-msgstr "nicht erkannte Option zum Ignorieren von Leerzeichen: '%s'"
+msgstr "nicht erkannte Option zum Ignorieren von Whitespace: '%s'"
=20
 #: builtin/apply.c:823
 #, c-format
@@ -2015,7 +2017,7 @@ msgstr "Patch mit nutzlosen Informationen bei Zei=
le %d"
 #: builtin/apply.c:2076
 #, c-format
 msgid "unable to read symlink %s"
-msgstr "konnte symbolische Verkn=C3=BCpfung %s nicht lesen"
+msgstr "konnte symbolischen Verweis %s nicht lesen"
=20
 #: builtin/apply.c:2080
 #, c-format
@@ -2088,7 +2090,7 @@ msgstr "Pfad %s wurde umbenannt/gel=C3=B6scht"
 #: builtin/apply.c:3254 builtin/apply.c:3409
 #, c-format
 msgid "%s: does not exist in index"
-msgstr "%s ist nicht bereitgestellt"
+msgstr "%s ist nicht in der Staging-Area"
=20
 #: builtin/apply.c:3258 builtin/apply.c:3401 builtin/apply.c:3423
 #, c-format
@@ -2098,7 +2100,7 @@ msgstr "%s: %s"
 #: builtin/apply.c:3263 builtin/apply.c:3417
 #, c-format
 msgid "%s: does not match index"
-msgstr "%s entspricht nicht der Bereitstellung"
+msgstr "%s entspricht nicht der Version in der Staging-Area"
=20
 #: builtin/apply.c:3365
 msgid "removal patch leaves file contents"
@@ -2152,12 +2154,12 @@ msgstr "make_cache_entry f=C3=BCr Pfad '%s' feh=
lgeschlagen"
 #: builtin/apply.c:3822
 #, c-format
 msgid "unable to remove %s from index"
-msgstr "konnte %s nicht aus der Bereitstellung entfernen"
+msgstr "konnte %s nicht aus der Staging-Area entfernen"
=20
 #: builtin/apply.c:3850
 #, c-format
 msgid "corrupt patch for subproject %s"
-msgstr "fehlerhafter Patch f=C3=BCr Unterprojekt %s"
+msgstr "fehlerhafter Patch f=C3=BCr Submodul %s"
=20
 #: builtin/apply.c:3854
 #, c-format
@@ -2214,7 +2216,7 @@ msgstr "Patch-Bereich #%d sauber angewendet."
 #: builtin/apply.c:4076
 #, c-format
 msgid "Rejected hunk #%d."
-msgstr "Patch-Bereich #%d zur=C3=BCckgewiesen."
+msgstr "Patch-Block #%d zur=C3=BCckgewiesen."
=20
 #: builtin/apply.c:4226
 msgid "unrecognized input"
@@ -2222,7 +2224,7 @@ msgstr "nicht erkannte Eingabe"
=20
 #: builtin/apply.c:4237
 msgid "unable to read index file"
-msgstr "Konnte Bereitstellungsdatei nicht lesen"
+msgstr "Konnte Staging-Area-Datei nicht lesen"
=20
 #: builtin/apply.c:4356 builtin/apply.c:4359 builtin/clone.c:92
 #: builtin/fetch.c:63
@@ -2276,12 +2278,12 @@ msgstr ""
 #: builtin/apply.c:4378
 msgid "make sure the patch is applicable to the current index"
 msgstr ""
-"stellt sicher, dass der Patch in der aktuellen Bereitstellung angewen=
det "
+"stellt sicher, dass der Patch in der aktuellen Staging-Area angewende=
t "
 "werden kann"
=20
 #: builtin/apply.c:4380
 msgid "apply a patch without touching the working tree"
-msgstr "wendet einen Patch an, ohne =C3=84nderungen im Arbeitszweig vo=
rzunehmen"
+msgstr "wendet einen Patch an, ohne =C3=84nderungen im Arbeitsverzeich=
nis vorzunehmen"
=20
 #: builtin/apply.c:4382
 msgid "also apply the patch (use with --stat/--summary/--check)"
@@ -2290,14 +2292,13 @@ msgstr "wendet den Patch an (Benutzung mit --st=
at/--summary/--check)"
 #: builtin/apply.c:4384
 msgid "attempt three-way merge if a patch does not apply"
 msgstr ""
-"versucht 3-Wege-Zusammenf=C3=BChrung, wenn der Patch nicht angewendet=
 werden "
-"konnte"
+"versucht 3-Wege-Merge, wenn der Patch nicht angewendet werden konnte"
=20
 #: builtin/apply.c:4386
 msgid "build a temporary index based on embedded index information"
 msgstr ""
-"erstellt eine tempor=C3=A4re Bereitstellung basierend auf den integri=
erten "
-"Bereitstellungsinformationen"
+"erstellt eine tempor=C3=A4re Staging-Area basierend auf den integrier=
ten "
+"Staging-Area-Informationen"
=20
 #: builtin/apply.c:4388 builtin/checkout-index.c:197 builtin/ls-files.=
c:456
 msgid "paths are separated with NUL character"
@@ -2313,11 +2314,11 @@ msgstr "Aktion"
=20
 #: builtin/apply.c:4393
 msgid "detect new or modified lines that have whitespace errors"
-msgstr "ermittelt neue oder ge=C3=A4nderte Zeilen die Fehler in Leerze=
ichen haben"
+msgstr "ermittelt neue oder ge=C3=A4nderte Zeilen die Whitespace-Fehle=
r haben"
=20
 #: builtin/apply.c:4396 builtin/apply.c:4399
 msgid "ignore changes in whitespace when finding context"
-msgstr "ignoriert =C3=84nderungen in Leerzeichen bei der Suche des Kon=
textes"
+msgstr "ignoriert =C3=84nderungen in Whitespaces bei der Suche des Kon=
textes"
=20
 #: builtin/apply.c:4402
 msgid "apply the patch in reverse"
@@ -2330,12 +2331,12 @@ msgstr "erwartet keinen Kontext"
 #: builtin/apply.c:4406
 msgid "leave the rejected hunks in corresponding *.rej files"
 msgstr ""
-"hinterl=C3=A4sst zur=C3=BCckgewiesene Patch-Bereiche in den entsprech=
enden *.rej "
+"hinterl=C3=A4sst zur=C3=BCckgewiesene Patch-Bl=C3=B6cke in den entspr=
echenden *.rej "
 "Dateien"
=20
 #: builtin/apply.c:4408
 msgid "allow overlapping hunks"
-msgstr "erlaubt sich =C3=BCberlappende Patch-Bereiche"
+msgstr "erlaubt sich =C3=BCberlappende Patch-Bl=C3=B6cke"
=20
 #: builtin/apply.c:4411
 msgid "tolerate incorrectly detected missing new-line at the end of fi=
le"
@@ -2343,7 +2344,7 @@ msgstr "toleriert fehlerhaft erkannten fehlenden =
Zeilenumbruch am Dateiende"
=20
 #: builtin/apply.c:4414
 msgid "do not trust the line counts in the hunk headers"
-msgstr "vertraut nicht den Zeilennummern im Kopf des Patch-Bereiches"
+msgstr "vertraut nicht den Zeilennummern im Kopf des Patch-Blocks"
=20
 #: builtin/apply.c:4416
 msgid "root"
@@ -2356,18 +2357,18 @@ msgstr "stellt <Wurzelverzeichnis> vor alle Dat=
einamen"
 #: builtin/apply.c:4439
 msgid "--3way outside a repository"
 msgstr ""
-"Die Option --3way kann nicht au=C3=9Ferhalb eines Projektarchivs verw=
endet werden."
+"Die Option --3way kann nicht au=C3=9Ferhalb eines Repositories verwen=
det werden."
=20
 #: builtin/apply.c:4447
 msgid "--index outside a repository"
 msgstr ""
-"Die Option --index kann nicht au=C3=9Ferhalb eines Projektarchivs ver=
wendet "
+"Die Option --index kann nicht au=C3=9Ferhalb eines Repositories verwe=
ndet "
 "werden."
=20
 #: builtin/apply.c:4450
 msgid "--cached outside a repository"
 msgstr ""
-"Die Option --cached kann nicht au=C3=9Ferhalb eines Projektarchivs ve=
rwendet "
+"Die Option --cached kann nicht au=C3=9Ferhalb eines Repositories verw=
endet "
 "werden."
=20
 #: builtin/apply.c:4466
@@ -2379,15 +2380,15 @@ msgstr "kann Patch '%s' nicht =C3=B6ffnen"
 #, c-format
 msgid "squelched %d whitespace error"
 msgid_plural "squelched %d whitespace errors"
-msgstr[0] "unterdr=C3=BCckte %d Fehler in Leerzeichen"
-msgstr[1] "unterdr=C3=BCckte %d Fehler in Leerzeichen"
+msgstr[0] "unterdr=C3=BCckte %d Whitespace-Fehler"
+msgstr[1] "unterdr=C3=BCckte %d Whitespace-Fehler"
=20
 #: builtin/apply.c:4486 builtin/apply.c:4496
 #, c-format
 msgid "%d line adds whitespace errors."
 msgid_plural "%d lines add whitespace errors."
-msgstr[0] "%d Zeile f=C3=BCgt Fehler in Leerzeichen hinzu."
-msgstr[1] "%d Zeilen f=C3=BCgen Fehler in Leerzeichen hinzu."
+msgstr[0] "%d Zeile f=C3=BCgt Whitespace-Fehler hinzu."
+msgstr[1] "%d Zeilen f=C3=BCgen Whitespace-Fehler hinzu."
=20
 #: builtin/archive.c:17
 #, c-format
@@ -2434,7 +2435,7 @@ msgstr "f=C3=BChrt 'git bisect next' aus"
=20
 #: builtin/bisect--helper.c:19
 msgid "update BISECT_HEAD instead of checking out the current commit"
-msgstr "aktualisiert BISECT_HEAD, anstatt die aktuelle Version auszuch=
ecken"
+msgstr "aktualisiert BISECT_HEAD, anstatt den aktuellen Commit auszuch=
ecken"
=20
 #: builtin/blame.c:25
 msgid "git blame [options] [rev-opts] [rev] [--] file"
@@ -2450,11 +2451,11 @@ msgstr "Zeigt \"blame\"-Eintr=C3=A4ge schrittwe=
ise, w=C3=A4hrend wir sie generieren"
=20
 #: builtin/blame.c:2356
 msgid "Show blank SHA-1 for boundary commits (Default: off)"
-msgstr "Zeigt leere SHA-1 f=C3=BCr Grenzversionen (Standard: aus)"
+msgstr "Zeigt leere SHA-1 f=C3=BCr Grenz-Commits (Standard: aus)"
=20
 #: builtin/blame.c:2357
 msgid "Do not treat root commits as boundaries (Default: off)"
-msgstr "Behandelt Ursprungsversionen nicht als Grenzen (Standard: aus)=
"
+msgstr "Behandelt Ursprungs-Commit nicht als Grenzen (Standard: aus)"
=20
 #: builtin/blame.c:2358
 msgid "Show work cost statistics"
@@ -2479,7 +2480,7 @@ msgstr "Anzeige in einem Format f=C3=BCr maschine=
lle Auswertung"
 #: builtin/blame.c:2363
 msgid "Show porcelain format with per-line commit information"
 msgstr ""
-"Anzeige in Format f=C3=BCr Fremdprogramme mit Versionsinformationen p=
ro Zeile"
+"Anzeige in Format f=C3=BCr Fremdprogramme mit Commit-Informationen pr=
o Zeile"
=20
 #: builtin/blame.c:2364
 msgid "Use the same output mode as git-annotate (Default: off)"
@@ -2491,7 +2492,7 @@ msgstr "Zeigt unbearbeiteten Zeitstempel (Standar=
d: aus)"
=20
 #: builtin/blame.c:2366
 msgid "Show long commit SHA1 (Default: off)"
-msgstr "Zeigt langen Versions-SHA1 (Standard: aus)"
+msgstr "Zeigt langen Commit-SHA1 (Standard: aus)"
=20
 #: builtin/blame.c:2367
 msgid "Suppress author name and timestamp (Default: off)"
@@ -2503,7 +2504,7 @@ msgstr "Zeigt anstatt des Namens die Email-Adress=
e des Autors (Standard: aus)"
=20
 #: builtin/blame.c:2369
 msgid "Ignore whitespace differences"
-msgstr "Ignoriert Unterschiede in Leerzeichen"
+msgstr "Ignoriert Unterschiede in Whitespaces"
=20
 #: builtin/blame.c:2370
 msgid "Spend extra cycles to find better match"
@@ -2543,15 +2544,15 @@ msgstr "git branch [Optionen] [-r | -a] [--merg=
ed | --no-merged]"
=20
 #: builtin/branch.c:25
 msgid "git branch [options] [-l] [-f] <branchname> [<start-point>]"
-msgstr "git branch [Optionen] [-l] [-f] <Zweigname> [<Startpunkt>]"
+msgstr "git branch [Optionen] [-l] [-f] <Branchname> [<Startpunkt>]"
=20
 #: builtin/branch.c:26
 msgid "git branch [options] [-r] (-d | -D) <branchname>..."
-msgstr "git branch [Optionen] [-r] (-d | -D) <Zweigname>..."
+msgstr "git branch [Optionen] [-r] (-d | -D) <Branchname>..."
=20
 #: builtin/branch.c:27
 msgid "git branch [options] (-m | -M) [<oldbranch>] <newbranch>"
-msgstr "git branch [Optionen] (-m | -M) [<alterZweig>] <neuerZweig>"
+msgstr "git branch [Optionen] (-m | -M) [<alterBranch>] <neuerBranch>"
=20
 #: builtin/branch.c:150
 #, c-format
@@ -2559,8 +2560,8 @@ msgid ""
 "deleting branch '%s' that has been merged to\n"
 "         '%s', but not yet merged to HEAD."
 msgstr ""
-"entferne Zweig '%s', der zusammengef=C3=BChrt wurde mit\n"
-"         '%s', aber noch nicht mit der Zweigspitze (HEAD) zusammengef=
=C3=BChrt "
+"entferne Branch '%s', der zusammengef=C3=BChrt wurde mit\n"
+"         '%s', aber noch nicht mit HEAD zusammengef=C3=BChrt "
 "wurde."
=20
 #: builtin/branch.c:154
@@ -2569,13 +2570,13 @@ msgid ""
 "not deleting branch '%s' that is not yet merged to\n"
 "         '%s', even though it is merged to HEAD."
 msgstr ""
-"entferne Zweig '%s' nicht, der noch nicht zusammengef=C3=BChrt wurde =
mit\n"
-"         '%s', obwohl er mit der Zweigspitze (HEAD) zusammengef=C3=BC=
hrt wurde."
+"entferne Branch '%s' nicht, der noch nicht zusammengef=C3=BChrt wurde=
 mit\n"
+"         '%s', obwohl er mit HEAD zusammengef=C3=BChrt wurde."
=20
 #: builtin/branch.c:168
 #, c-format
 msgid "Couldn't look up commit object for '%s'"
-msgstr "Konnte Versionsobjekt f=C3=BCr '%s' nicht nachschlagen."
+msgstr "Konnte Commit-Objekt f=C3=BCr '%s' nicht nachschlagen."
=20
 #: builtin/branch.c:172
 #, c-format
@@ -2583,8 +2584,8 @@ msgid ""
 "The branch '%s' is not fully merged.\n"
 "If you are sure you want to delete it, run 'git branch -D %s'."
 msgstr ""
-"Der Zweig '%s' ist nicht vollst=C3=A4ndig zusammengef=C3=BChrt.\n"
-"Wenn Sie sicher sind diesen Zweig zu entfernen, f=C3=BChren Sie 'git =
branch -D "
+"Der Branch '%s' ist nicht vollst=C3=A4ndig zusammengef=C3=BChrt.\n"
+"Wenn Sie sicher sind diesen Branch zu entfernen, f=C3=BChren Sie 'git=
 branch -D "
 "%s' aus."
=20
 #: builtin/branch.c:185
@@ -2597,48 +2598,48 @@ msgstr "kann -a nicht mit -d benutzen"
=20
 #: builtin/branch.c:219
 msgid "Couldn't look up commit object for HEAD"
-msgstr "Konnte Versionsobjekt f=C3=BCr Zweigspitze (HEAD) nicht nachsc=
hlagen."
+msgstr "Konnte Commit-Objekt f=C3=BCr HEAD nicht nachschlagen."
=20
 #: builtin/branch.c:227
 #, c-format
 msgid "Cannot delete the branch '%s' which you are currently on."
 msgstr ""
-"Kann Zweig '%s' nicht entfernen, da Sie sich gerade auf diesem befind=
en."
+"Kann Branch '%s' nicht entfernen, da Sie sich gerade auf diesem befin=
den."
=20
 #: builtin/branch.c:240
 #, c-format
 msgid "remote branch '%s' not found."
-msgstr "externer Zweig '%s' nicht gefunden"
+msgstr "Remote-Branch '%s' nicht gefunden"
=20
 #: builtin/branch.c:241
 #, c-format
 msgid "branch '%s' not found."
-msgstr "Zweig '%s' nicht gefunden."
+msgstr "Branch '%s' nicht gefunden."
=20
 #: builtin/branch.c:255
 #, c-format
 msgid "Error deleting remote branch '%s'"
-msgstr "Fehler beim Entfernen des externen Zweiges '%s'"
+msgstr "Fehler beim Entfernen des Remote-Branches '%s'"
=20
 #: builtin/branch.c:256
 #, c-format
 msgid "Error deleting branch '%s'"
-msgstr "Fehler beim Entfernen des Zweiges '%s'"
+msgstr "Fehler beim Entfernen des Branches '%s'"
=20
 #: builtin/branch.c:263
 #, c-format
 msgid "Deleted remote branch %s (was %s).\n"
-msgstr "Externer Zweig %s entfernt (war %s).\n"
+msgstr "Remote-Branch %s entfernt (war %s).\n"
=20
 #: builtin/branch.c:264
 #, c-format
 msgid "Deleted branch %s (was %s).\n"
-msgstr "Zweig %s entfernt (war %s).\n"
+msgstr "Branch %s entfernt (war %s).\n"
=20
 #: builtin/branch.c:366
 #, c-format
 msgid "branch '%s' does not point at a commit"
-msgstr "Zweig '%s' zeigt auf keine Version"
+msgstr "Branch '%s' zeigt auf keinen Commit"
=20
 #: builtin/branch.c:453
 #, c-format
@@ -2677,12 +2678,12 @@ msgstr " **** ung=C3=BCltige Referenz ****"
 #: builtin/branch.c:582
 #, c-format
 msgid "(no branch, rebasing %s)"
-msgstr "(kein Zweig, Neuaufbau von Zweig %s im Gange)"
+msgstr "(kein Branch, Rebase von Branch %s im Gange)"
=20
 #: builtin/branch.c:585
 #, c-format
 msgid "(no branch, bisect started on %s)"
-msgstr "(kein Zweig, Neuaufbau begonnen bei %s)"
+msgstr "(kein Branch, Rebase begonnen bei %s)"
=20
 #: builtin/branch.c:588
 #, c-format
@@ -2691,12 +2692,12 @@ msgstr "(losgel=C3=B6st von %s)"
=20
 #: builtin/branch.c:591
 msgid "(no branch)"
-msgstr "(kein Zweig)"
+msgstr "(kein Branch)"
=20
 #: builtin/branch.c:637
 #, c-format
 msgid "object '%s' does not point to a commit"
-msgstr "Objekt '%s' zeigt auf keine Version"
+msgstr "Objekt '%s' zeigt auf keinen Commit"
=20
 #: builtin/branch.c:669
 msgid "some refs could not be read"
@@ -2705,31 +2706,31 @@ msgstr "Konnte einige Referenzen nicht lesen"
 #: builtin/branch.c:682
 msgid "cannot rename the current branch while not on any."
 msgstr ""
-"Kann aktuellen Zweig nicht umbenennen, solange Sie sich auf keinem be=
finden."
+"Kann aktuellen Branch nicht umbenennen, solange Sie sich auf keinem b=
efinden."
=20
 #: builtin/branch.c:692
 #, c-format
 msgid "Invalid branch name: '%s'"
-msgstr "Ung=C3=BCltiger Zweig-Name: '%s'"
+msgstr "Ung=C3=BCltiger Branchname: '%s'"
=20
 #: builtin/branch.c:707
 msgid "Branch rename failed"
-msgstr "Umbenennung des Zweiges fehlgeschlagen"
+msgstr "Umbenennung des Branches fehlgeschlagen"
=20
 #: builtin/branch.c:711
 #, c-format
 msgid "Renamed a misnamed branch '%s' away"
-msgstr "falsch benannten Zweig '%s' umbenannt"
+msgstr "falsch benannten Branch '%s' umbenannt"
=20
 #: builtin/branch.c:715
 #, c-format
 msgid "Branch renamed to %s, but HEAD is not updated!"
-msgstr "Zweig umbenannt zu %s, aber Zweigspitze (HEAD) ist nicht aktua=
lisiert!"
+msgstr "Branch umbenannt zu %s, aber HEAD ist nicht aktualisiert!"
=20
 #: builtin/branch.c:722
 msgid "Branch is renamed, but update of config-file failed"
 msgstr ""
-"Zweig ist umbenannt, aber die Aktualisierung der Konfigurationsdatei =
ist "
+"Branch ist umbenannt, aber die Aktualisierung der Konfigurationsdatei=
 ist "
 "fehlgeschlagen."
=20
 #: builtin/branch.c:737
@@ -2740,7 +2741,7 @@ msgstr "Missgebildeter Objektname %s"
 #: builtin/branch.c:761
 #, c-format
 msgid "could not write branch description template: %s"
-msgstr "Konnte Beschreibungsvorlage f=C3=BCr Zweig nicht schreiben: %s=
"
+msgstr "Konnte Beschreibungsvorlage f=C3=BCr Branch nicht schreiben: %=
s"
=20
 #: builtin/branch.c:791
 msgid "Generic options"
@@ -2748,7 +2749,7 @@ msgstr "Allgemeine Optionen"
=20
 #: builtin/branch.c:793
 msgid "show hash and subject, give twice for upstream branch"
-msgstr "Zeigt Hash und Betreff; -vv: zus=C3=A4tzlich externen =C3=9Cbe=
rnahmezweig"
+msgstr "Zeigt Hash und Betreff; -vv: zus=C3=A4tzlich Upstream-Branch"
=20
 #: builtin/branch.c:794
 msgid "suppress informational messages"
@@ -2760,7 +2761,7 @@ msgstr "stellt den =C3=9Cbernahmemodus ein (siehe=
 git-pull(1))"
=20
 #: builtin/branch.c:797
 msgid "change upstream info"
-msgstr "=C3=A4ndert Informationen zum externen =C3=9Cbernahmezweig"
+msgstr "=C3=A4ndert Informationen zum Upstream-Branch"
=20
 #: builtin/branch.c:801
 msgid "use colored output"
@@ -2768,17 +2769,17 @@ msgstr "verwendet farbliche Ausgaben"
=20
 #: builtin/branch.c:802
 msgid "act on remote-tracking branches"
-msgstr "wirkt auf externe =C3=9Cbernahmezweige"
+msgstr "wirkt auf Remote-Tracking-Branches"
=20
 #: builtin/branch.c:805 builtin/branch.c:811 builtin/branch.c:832
 #: builtin/branch.c:838 builtin/commit.c:1368 builtin/commit.c:1369
 #: builtin/commit.c:1370 builtin/commit.c:1371 builtin/tag.c:468
 msgid "commit"
-msgstr "Version"
+msgstr "Commit"
=20
 #: builtin/branch.c:806 builtin/branch.c:812
 msgid "print only branches that contain the commit"
-msgstr "gibt nur Zweige aus, welche diese Version beinhalten"
+msgstr "gibt nur Branches aus, welche diesen Commit beinhalten"
=20
 #: builtin/branch.c:818
 msgid "Specific git-branch actions:"
@@ -2786,60 +2787,60 @@ msgstr "spezifische Aktionen f=C3=BCr \"git-bra=
nch\":"
=20
 #: builtin/branch.c:819
 msgid "list both remote-tracking and local branches"
-msgstr "listet externe =C3=9Cbernahmezweige und lokale Zweige auf"
+msgstr "listet Remote-Tracking und lokale Branches auf"
=20
 #: builtin/branch.c:821
 msgid "delete fully merged branch"
-msgstr "entfernt vollst=C3=A4ndig zusammengef=C3=BChrten Zweig"
+msgstr "entfernt vollst=C3=A4ndig zusammengef=C3=BChrten Branch"
=20
 #: builtin/branch.c:822
 msgid "delete branch (even if not merged)"
-msgstr "l=C3=B6scht Zweig (auch wenn nicht zusammengef=C3=BChrt)"
+msgstr "l=C3=B6scht Branch (auch wenn nicht zusammengef=C3=BChrt)"
=20
 #: builtin/branch.c:823
 msgid "move/rename a branch and its reflog"
-msgstr "verschiebt/benennt einen Zweig und dessen Referenzprotokoll um=
"
+msgstr "verschiebt/benennt einen Branch und dessen Reflog um"
=20
 #: builtin/branch.c:824
 msgid "move/rename a branch, even if target exists"
 msgstr ""
-"verschiebt/benennt einen Zweig um, auch wenn das Ziel bereits existie=
rt"
+"verschiebt/benennt einen Branch um, auch wenn das Ziel bereits existi=
ert"
=20
 #: builtin/branch.c:825
 msgid "list branch names"
-msgstr "listet Zweignamen auf"
+msgstr "listet Branchnamen auf"
=20
 #: builtin/branch.c:826
 msgid "create the branch's reflog"
-msgstr "erzeugt das Referenzprotokoll des Zweiges"
+msgstr "erzeugt das Reflog des Branches"
=20
 #: builtin/branch.c:828
 msgid "edit the description for the branch"
-msgstr "bearbeitet die Beschreibung f=C3=BCr den Zweig"
+msgstr "bearbeitet die Beschreibung f=C3=BCr den Branch"
=20
 #: builtin/branch.c:829
 msgid "force creation (when already exists)"
-msgstr "erzeuge auch, wenn der Zweig bereits existiert"
+msgstr "erzeuge auch, wenn der Branch bereits existiert"
=20
 #: builtin/branch.c:832
 msgid "print only not merged branches"
-msgstr "gibt nur Zweige aus, die nicht zusammengef=C3=BChrt sind"
+msgstr "gibt nur Branches aus, die nicht zusammengef=C3=BChrt sind"
=20
 #: builtin/branch.c:838
 msgid "print only merged branches"
-msgstr "gibt nur Zweige aus, die zusammengef=C3=BChrt sind"
+msgstr "gibt nur Branches aus, die zusammengef=C3=BChrt sind"
=20
 #: builtin/branch.c:842
 msgid "list branches in columns"
-msgstr "listet Zweige in Spalten auf"
+msgstr "listet Branches in Spalten auf"
=20
 #: builtin/branch.c:855
 msgid "Failed to resolve HEAD as a valid ref."
-msgstr "Konnte Zweigspitze (HEAD) nicht als g=C3=BCltige Referenz aufl=
=C3=B6sen."
+msgstr "Konnte HEAD nicht als g=C3=BCltige Referenz aufl=C3=B6sen."
=20
 #: builtin/branch.c:860 builtin/clone.c:619
 msgid "HEAD not found below refs/heads!"
-msgstr "Zweigspitze (HEAD) wurde nicht unter \"refs/heads\" gefunden!"
+msgstr "HEAD wurde nicht unter \"refs/heads\" gefunden!"
=20
 #: builtin/branch.c:883
 msgid "--column and --verbose are incompatible"
@@ -2847,68 +2848,68 @@ msgstr "Die Optionen --column und --verbose sin=
d inkompatibel."
=20
 #: builtin/branch.c:889 builtin/branch.c:928
 msgid "branch name required"
-msgstr "Zweigname erforderlich"
+msgstr "Branchname erforderlich"
=20
 #: builtin/branch.c:904
 msgid "Cannot give description to detached HEAD"
 msgstr ""
-"zu losgel=C3=B6ster Zweigspitze (HEAD) kann keine Beschreibung hinter=
legt werden"
+"zu losgel=C3=B6stem HEAD kann keine Beschreibung hinterlegt werden"
=20
 #: builtin/branch.c:909
 msgid "cannot edit description of more than one branch"
-msgstr "Beschreibung von mehr als einem Zweig kann nicht bearbeitet we=
rden"
+msgstr "Beschreibung von mehr als einem Branch kann nicht bearbeitet w=
erden"
=20
 #: builtin/branch.c:916
 #, c-format
 msgid "No commit on branch '%s' yet."
-msgstr "Noch keine Version in Zweig '%s'."
+msgstr "Noch kein Commit in Branch '%s'."
=20
 #: builtin/branch.c:919
 #, c-format
 msgid "No branch named '%s'."
-msgstr "Zweig '%s' nicht vorhanden."
+msgstr "Branch '%s' nicht vorhanden."
=20
 #: builtin/branch.c:934
 msgid "too many branches for a rename operation"
-msgstr "zu viele Zweige f=C3=BCr eine Umbenennen-Operation angegeben"
+msgstr "zu viele Branches f=C3=BCr eine Umbenennen-Operation angegeben=
"
=20
 #: builtin/branch.c:939
 msgid "too many branches to set new upstream"
-msgstr "zu viele Zweige angegeben um neuen =C3=9Cbernahmezweig zu setz=
en"
+msgstr "zu viele Branches angegeben um Upstream-Branch zu setzen"
=20
 #: builtin/branch.c:943
 #, c-format
 msgid ""
 "could not set upstream of HEAD to %s when it does not point to any br=
anch."
 msgstr ""
-"Konnte keinen neuen =C3=9Cbernahmezweig von Zweigspitze (HEAD) zu %s =
setzen,\n"
-"da diese auf keinen Zweig zeigt."
+"Konnte keinen neuen Upstream-Branch von HEAD zu %s setzen, da dieser =
auf\n"
+"keinen Branch zeigt."
=20
 #: builtin/branch.c:946 builtin/branch.c:968 builtin/branch.c:990
 #, c-format
 msgid "no such branch '%s'"
-msgstr "Kein solcher Zweig '%s'"
+msgstr "Kein solcher Branch '%s'"
=20
 #: builtin/branch.c:950
 #, c-format
 msgid "branch '%s' does not exist"
-msgstr "Zweig '%s' existiert nicht"
+msgstr "Branch '%s' existiert nicht"
=20
 #: builtin/branch.c:962
 msgid "too many branches to unset upstream"
 msgstr ""
-"zu viele Zweige angegeben um Konfiguration zu =C3=9Cbernahmezweig zu =
entfernen"
+"zu viele Branches angegeben um Konfiguration zu Upstream-Branch zu en=
tfernen"
=20
 #: builtin/branch.c:966
 msgid "could not unset upstream of HEAD when it does not point to any =
branch."
 msgstr ""
-"Konnte Konfiguration zum =C3=9Cbernahmezweig von Zweigspitze (HEAD) n=
icht\n"
-"entfernen, da diese auf keinen Zweig zeigt."
+"Konnte Konfiguration zu Upstream-Branch von HEAD nicht entfernen, da =
dieser\n"
+"auf keinen Branch zeigt."
=20
 #: builtin/branch.c:972
 #, c-format
 msgid "Branch '%s' has no upstream information"
-msgstr "Zweig '%s' hat keinen externen =C3=9Cbernahmezweig gesetzt"
+msgstr "Branch '%s' hat keinen Upstream-Branch gesetzt"
=20
 #: builtin/branch.c:987
 msgid "it does not make sense to create 'HEAD' manually"
@@ -2918,7 +2919,7 @@ msgstr "'HEAD' darf nicht manuell erstellt werden=
"
 msgid "-a and -r options to 'git branch' do not make sense with a bran=
ch name"
 msgstr ""
 "Die Optionen -a und -r bei 'git branch' k=C3=B6nnen nicht gemeimsam m=
it einem "
-"Zweignamen verwendet werden."
+"Branchnamen verwendet werden."
=20
 #: builtin/branch.c:996
 #, c-format
@@ -2937,7 +2938,7 @@ msgid ""
 "\n"
 msgstr ""
 "\n"
-"Wenn Sie wollten, dass '%s' den Zweig '%s' als externen =C3=9Cbernahm=
ezweig hat, "
+"Wenn Sie wollten, dass '%s' den Branch '%s' als Upstream-Branch hat, =
"
 "f=C3=BChren Sie aus:\n"
=20
 #: builtin/branch.c:1014
@@ -2957,11 +2958,11 @@ msgstr "%s ist in Ordnung\n"
=20
 #: builtin/bundle.c:56
 msgid "Need a repository to create a bundle."
-msgstr "Um ein Paket zu erstellen wird ein Projektarchiv ben=C3=B6tigt=
=2E"
+msgstr "Um ein Paket zu erstellen wird ein Repository ben=C3=B6tigt."
=20
 #: builtin/bundle.c:60
 msgid "Need a repository to unbundle."
-msgstr "Zum Entpacken wird ein Projektarchiv ben=C3=B6tigt."
+msgstr "Zum Entpacken wird ein Repository ben=C3=B6tigt."
=20
 #: builtin/cat-file.c:176
 msgid "git cat-file (-t|-s|-e|-p|<type>|--textconv) <object>"
@@ -3021,7 +3022,7 @@ msgstr "gibt alle Attribute einer Datei aus"
=20
 #: builtin/check-attr.c:20
 msgid "use .gitattributes only from the index"
-msgstr "verwendet .gitattributes nur von der Bereitstellung"
+msgstr "verwendet .gitattributes nur von der Staging-Area"
=20
 #: builtin/check-attr.c:21 builtin/check-ignore.c:22 builtin/hash-obje=
ct.c:75
 msgid "read file names from stdin"
@@ -3062,7 +3063,7 @@ msgstr "git checkout-index [Optionen] [--] [<Date=
i>...]"
=20
 #: builtin/checkout-index.c:187
 msgid "check out all files in the index"
-msgstr "checkt alle Dateien in der Bereitstellung aus"
+msgstr "checkt alle Dateien in der Staging-Area aus"
=20
 #: builtin/checkout-index.c:188
 msgid "force overwrite of existing files"
@@ -3072,7 +3073,7 @@ msgstr "erzwingt das =C3=9Cberschreiben bereits e=
xistierender Dateien"
 msgid "no warning for existing files and files not in index"
 msgstr ""
 "keine Warnung f=C3=BCr existierende Dateien, und Dateien, die sich ni=
cht in der "
-"Bereitstellung befinden"
+"Staging-Area befinden"
=20
 #: builtin/checkout-index.c:192
 msgid "don't checkout new files"
@@ -3080,7 +3081,7 @@ msgstr "checkt keine neuen Dateien aus"
=20
 #: builtin/checkout-index.c:194
 msgid "update stat information in the index file"
-msgstr "aktualisiert Dateiinformationen in der Bereitstellungsdatei"
+msgstr "aktualisiert Dateiinformationen in der Staging-Area-Datei"
=20
 #: builtin/checkout-index.c:200
 msgid "read list of paths from the standard input"
@@ -3105,11 +3106,11 @@ msgstr "kopiert Dateien von dem benannten Stand=
"
=20
 #: builtin/checkout.c:25
 msgid "git checkout [options] <branch>"
-msgstr "git checkout [Optionen] <Zweig>"
+msgstr "git checkout [Optionen] <Branch>"
=20
 #: builtin/checkout.c:26
 msgid "git checkout [options] [<branch>] -- <file>..."
-msgstr "git checkout [Optionen] [Zweig>] -- <Datei>..."
+msgstr "git checkout [Optionen] [<Branch>] -- <Datei>..."
=20
 #: builtin/checkout.c:117 builtin/checkout.c:150
 #, c-format
@@ -3139,7 +3140,7 @@ msgstr "Pfad '%s': kann nicht zusammenf=C3=BChren=
"
 #: builtin/checkout.c:213
 #, c-format
 msgid "Unable to add merge result for '%s'"
-msgstr "Konnte Ergebnis der Zusammenf=C3=BChrung von '%s' nicht hinzuf=
=C3=BCgen."
+msgstr "Konnte Merge-Ergebnis von '%s' nicht hinzuf=C3=BCgen."
=20
 #: builtin/checkout.c:237 builtin/checkout.c:240 builtin/checkout.c:24=
3
 #: builtin/checkout.c:246
@@ -3155,11 +3156,11 @@ msgstr "'%s' kann nicht mit '%s' verwendet werd=
en"
 #: builtin/checkout.c:255
 #, c-format
 msgid "Cannot update paths and switch to branch '%s' at the same time.=
"
-msgstr "Kann nicht gleichzeitig Pfade aktualisieren und zu Zweig '%s' =
wechseln"
+msgstr "Kann nicht gleichzeitig Pfade aktualisieren und zu Branch '%s'=
 wechseln"
=20
 #: builtin/checkout.c:266 builtin/checkout.c:458
 msgid "corrupt index file"
-msgstr "besch=C3=A4digte Bereitstellungsdatei"
+msgstr "besch=C3=A4digte Staging-Area-Datei"
=20
 #: builtin/checkout.c:329 builtin/checkout.c:336
 #, c-format
@@ -3168,7 +3169,7 @@ msgstr "Pfad '%s' ist nicht zusammengef=C3=BChrt.=
"
=20
 #: builtin/checkout.c:480
 msgid "you need to resolve your current index first"
-msgstr "Sie m=C3=BCssen zuerst Ihre aktuelle Bereitstellung aufl=C3=B6=
sen."
+msgstr "Sie m=C3=BCssen zuerst Ihre aktuelle Staging-Area aufl=C3=B6se=
n."
=20
 #: builtin/checkout.c:601
 #, c-format
@@ -3177,12 +3178,12 @@ msgstr "Konnte \"reflog\" f=C3=BCr '%s' nicht d=
urchf=C3=BChren\n"
=20
 #: builtin/checkout.c:634
 msgid "HEAD is now at"
-msgstr "Zweigspitze (HEAD) ist jetzt bei"
+msgstr "HEAD ist jetzt bei"
=20
 #: builtin/checkout.c:641
 #, c-format
 msgid "Reset branch '%s'\n"
-msgstr "Setze Zweig '%s' neu\n"
+msgstr "Setze Branch '%s' neu\n"
=20
 #: builtin/checkout.c:644
 #, c-format
@@ -3192,17 +3193,17 @@ msgstr "Bereits auf '%s'\n"
 #: builtin/checkout.c:648
 #, c-format
 msgid "Switched to and reset branch '%s'\n"
-msgstr "Gewechselt zu neu gesetztem Zweig '%s'\n"
+msgstr "Gewechselt zu umgesetzten Branch '%s'\n"
=20
 #: builtin/checkout.c:650 builtin/checkout.c:987
 #, c-format
 msgid "Switched to a new branch '%s'\n"
-msgstr "Gewechselt zu einem neuen Zweig '%s'\n"
+msgstr "Gewechselt zu einem neuem Branch '%s'\n"
=20
 #: builtin/checkout.c:652
 #, c-format
 msgid "Switched to branch '%s'\n"
-msgstr "Gewechselt zu Zweig '%s'\n"
+msgstr "Gewechselt zu Branch '%s'\n"
=20
 #: builtin/checkout.c:708
 #, c-format
@@ -3223,13 +3224,13 @@ msgid_plural ""
 "\n"
 "%s\n"
 msgstr[0] ""
-"Warnung: Sie sind um %d Version hinterher, nicht verbunden zu\n"
-"einem Ihrer Zweige:\n"
+"Warnung: Sie sind um %d Commit hinterher, nicht verbunden zu\n"
+"einem Ihrer Branches:\n"
 "\n"
 "%s\n"
 msgstr[1] ""
-"Warnung: Sie sind um %d Versionen hinterher, nicht verbunden zu\n"
-"einem Ihrer Zweige:\n"
+"Warnung: Sie sind um %d Commits hinterher, nicht verbunden zu\n"
+"einem Ihrer Branches:\n"
 "\n"
 "%s\n"
=20
@@ -3242,10 +3243,10 @@ msgid ""
 " git branch new_branch_name %s\n"
 "\n"
 msgstr ""
-"Wenn Sie diese durch einen neuen Zweig behalten m=C3=B6chten, dann k=C3=
=B6nnte jetzt\n"
+"Wenn Sie diese durch einen neuen Branch behalten m=C3=B6chten, dann k=
=C3=B6nnte jetzt\n"
 "ein guter Zeitpunkt sein dies zu tun mit:\n"
 "\n"
-" git branch neuer_zweig_name %s\n"
+" git branch neuer_branch_name %s\n"
 "\n"
=20
 #: builtin/checkout.c:762
@@ -3254,11 +3255,11 @@ msgstr "interner Fehler im Revisionsgang"
=20
 #: builtin/checkout.c:766
 msgid "Previous HEAD position was"
-msgstr "Vorherige Position der Zweigspitze (HEAD) war"
+msgstr "Vorherige Position von HEAD war"
=20
 #: builtin/checkout.c:793 builtin/checkout.c:982
 msgid "You are on a branch yet to be born"
-msgstr "Sie sind auf einem Zweig, der noch geboren wird"
+msgstr "Sie sind auf einem Branch, der noch geboren wird"
=20
 #. case (1)
 #: builtin/checkout.c:918
@@ -3270,16 +3271,16 @@ msgstr "Ung=C3=BCltige Referenz: %s"
 #: builtin/checkout.c:957
 #, c-format
 msgid "reference is not a tree: %s"
-msgstr "Referenz ist kein Baum: %s"
+msgstr "Referenz ist kein \"Tree\"-Objekt: %s"
=20
 #: builtin/checkout.c:996
 msgid "paths cannot be used with switching branches"
-msgstr "Pfade k=C3=B6nnen nicht beim Wechseln von Zweigen verwendet we=
rden"
+msgstr "Pfade k=C3=B6nnen nicht beim Wechseln von Branches verwendet w=
erden"
=20
 #: builtin/checkout.c:999 builtin/checkout.c:1003
 #, c-format
 msgid "'%s' cannot be used with switching branches"
-msgstr "'%s' kann nicht beim Wechseln von Zweigen verwendet werden"
+msgstr "'%s' kann nicht beim Wechseln von Branches verwendet werden"
=20
 #: builtin/checkout.c:1007 builtin/checkout.c:1010 builtin/checkout.c:=
1015
 #: builtin/checkout.c:1018
@@ -3290,40 +3291,40 @@ msgstr "'%s' kann nicht mit '%s' verwendet werd=
en"
 #: builtin/checkout.c:1023
 #, c-format
 msgid "Cannot switch branch to a non-commit '%s'"
-msgstr "Kann Zweig nicht zu Nicht-Version '%s' wechseln"
+msgstr "Kann Branch nicht zu Nicht-Commit '%s' wechseln"
=20
 #: builtin/checkout.c:1045 builtin/checkout.c:1047 builtin/clone.c:90
 #: builtin/remote.c:169 builtin/remote.c:171
 msgid "branch"
-msgstr "Zweig"
+msgstr "Branch"
=20
 #: builtin/checkout.c:1046
 msgid "create and checkout a new branch"
-msgstr "erzeugt und checkt einen neuen Zweig aus"
+msgstr "erzeugt und checkt einen neuen Branch aus"
=20
 #: builtin/checkout.c:1048
 msgid "create/reset and checkout a branch"
-msgstr "erzeugt/setzt neu und checkt einen Zweig aus"
+msgstr "erzeugt/setzt um und checkt einen Branch aus"
=20
 #: builtin/checkout.c:1049
 msgid "create reflog for new branch"
-msgstr "erzeugt Referenzprotokoll f=C3=BCr den neuen Zweig"
+msgstr "erzeugt das Reflog f=C3=BCr den neuen Branch"
=20
 #: builtin/checkout.c:1050
 msgid "detach the HEAD at named commit"
-msgstr "setzt die Zweigspitze (HEAD) zu benannter Version"
+msgstr "setzt HEAD zu benanntem Commit"
=20
 #: builtin/checkout.c:1051
 msgid "set upstream info for new branch"
-msgstr "setzt Informationen zum externen =C3=9Cbernahmezweig f=C3=BCr =
den neuen Zweig"
+msgstr "setzt Informationen zum Upstream-Branch f=C3=BCr den neuen Bra=
nch"
=20
 #: builtin/checkout.c:1053
 msgid "new branch"
-msgstr "neuer Zweig"
+msgstr "neuer Branch"
=20
 #: builtin/checkout.c:1053
 msgid "new unparented branch"
-msgstr "neuer Zweig ohne Elternversion"
+msgstr "neuer Branch ohne Elternversion"
=20
 #: builtin/checkout.c:1054
 msgid "checkout our version for unmerged files"
--=20
1.8.2.1228.g75fb170

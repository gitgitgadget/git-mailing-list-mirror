From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] po/pl.po: Eliminate fuzzy translations
Date: Thu, 07 Jul 2011 02:53:57 -0700 (PDT)
Message-ID: <m3ipre4dtf.fsf@localhost.localdomain>
References: <CACBZZX4dP-OsrZ3wBOeSkzDFy6XBgeY=eqJUF2acyLC8W-3Vpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?iso-8859-2?q?Marcin_Cie=B6lak?= <saper@saper.info>,
	=?iso-8859-4?q?Jakub_Nar=EAbski?= <jnareb@gmail.com>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 11:54:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QelHe-0001E4-Oe
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 11:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067Ab1GGJyF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jul 2011 05:54:05 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:53473 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab1GGJyB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2011 05:54:01 -0400
Received: by fxd18 with SMTP id 18so923026fxd.11
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=QZrQg7gXjCt1Vbt/sLwHgEw4u+JesRprUgMa3ikKp8Y=;
        b=DORvxmKEX182qFFy4SQCbje+4HR3ZwXSL/411OQzapfwQn8wLI6GToeYWz/fPDOzg2
         35XSKUgfHTkxsRPe2dBRYfVlOttcsNc8PigTdVE++SLQkipi/VBDbSO/ENeuxkQwfP4l
         fkftJ9JYP1pK8djEt/FI7Q+/aMJNkBuYUwcQo=
Received: by 10.223.145.78 with SMTP id c14mr955272fav.75.1310032439367;
        Thu, 07 Jul 2011 02:53:59 -0700 (PDT)
Received: from localhost.localdomain (abwq132.neoplus.adsl.tpnet.pl [83.8.240.132])
        by mx.google.com with ESMTPS id k26sm6608841fak.24.2011.07.07.02.53.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jul 2011 02:53:57 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p679rSY6026073;
	Thu, 7 Jul 2011 11:53:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p679rHLY026069;
	Thu, 7 Jul 2011 11:53:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CACBZZX4dP-OsrZ3wBOeSkzDFy6XBgeY=eqJUF2acyLC8W-3Vpg@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176752>

Remove all fuzzy translations by either correcting them where trivial,
or removing them altogether.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Only corrected translations that were trivial, trying not to introduce
any new words / phrases, because I don't know what should be Polish
translations of English terminology.

=2E..
The following changes since commit ceb58337358d93caae779b33daf6d7fd58cc=
df23:

  en_GB is OK now (2011-07-06 19:24:58 +0000)

are available in the git repository at:
  git@github.com:jnareb/git.git i18n-po.pl

Jakub Narebski (1):
      po/pl.po: Eliminate fuzzy translations

 po/pl.po |  208 ++++++++++++++++++++++++++++++++++--------------------=
--------
 1 files changed, 114 insertions(+), 94 deletions(-)

diff --git a/po/pl.po b/po/pl.po
index f7f2129..414c881 100644
--- a/po/pl.po
+++ b/po/pl.po
@@ -3,13 +3,45 @@
 # This file is distributed under the same license as the Git package.
 # Marcin Cie=B6lak <saper@saper.info>, 2010.
 #
+# Terminologia dla kluczowych termin=F3w z Subversion:
+# path - =B6cie=BFka
+# URL - URL
+# file - plik
+# directory - katalog
+# update - aktualizacja
+# commit - zatwierdzenie, zatwierdzenie zmian
+# version control - zarz=B1dzanie wersjami
+# repository - repozytorium
+# branch - odga=B3=EAzienie
+# tag - tag
+# merge - =B3=B1czenie zmian
+# conflict - konflikt
+# property - atrybut
+# revision - wersja
+# log message - opis zmian
+# entry/item - element
+# ancestry - pochodzenie
+# ancestor - przodek
+# working copy - kopia robocza
+# working dir - bie=BF=B1cy katalog
+# usage - wykorzystanie
+# source - =BCr=F3d=B3owy
+# destination - docelowy
+# hook - skrypt (skrypt repozytorium)
+# exclude - wykluczy=E6
+# crop - obci=B1=E6
+# cache - pami=EA=E6 podr=EAczna
+# child - obiekt podrz=EAdny
+# obliteration - obliteracja
+# patch - =B3ata
+# notes - adnotacja
 msgid ""
 msgstr ""
 "Project-Id-Version: Git\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
 "POT-Creation-Date: 2011-07-06 19:20+0000\n"
-"PO-Revision-Date: 2010-08-30 17:02+0200\n"
-"Last-Translator: Marcin Cie=B6lak <saper@saper.info>\n"
+"PO-Revision-Date: 2011-07-07 10:53+0200\n"
+"Last-Translator: Jakub Nar=EAbski <jnareb@gmail.com>\n"
 "Language-Team: Git Mailing List <git@vger.kernel.org>\n"
 "Language: pl\n"
 "MIME-Version: 1.0\n"
@@ -24,9 +56,9 @@ msgid "  Failed to parse dirstat cut-off percentage '=
%.*s'\n"
 msgstr ""
=20
 #: diff.c:109
-#, fuzzy, c-format
+#, c-format
 msgid "  Unknown dirstat parameter '%.*s'\n"
-msgstr "nie mog=EA tkn=B1=E6 szablonu '%s'"
+msgstr "  Nieznany argument '%.*s' opcji '--dirstat'\n"
=20
 #: diff.c:205
 #, c-format
@@ -192,9 +224,8 @@ msgid "Not currently on any branch."
 msgstr ""
=20
 #: wt-status.c:731
-#, fuzzy
 msgid "Initial commit"
-msgstr "Utworzy=B3em puste"
+msgstr ""
=20
 #: wt-status.c:745
 msgid "Untracked"
@@ -315,14 +346,13 @@ msgid "Could not open '%s' for writing."
 msgstr ""
=20
 #: builtin/add.c:288
-#, fuzzy
 msgid "Could not write patch"
-msgstr "Nie mog=EA da=E6 prawa zapisu grupie w %s"
+msgstr ""
=20
 #: builtin/add.c:293
-#, fuzzy, c-format
+#, c-format
 msgid "Could not stat '%s'"
-msgstr "nie mog=EA tkn=B1=E6 '%s'"
+msgstr "Nie mo=BFna wykona=E6 stat na '%s'"
=20
 #: builtin/add.c:295
 msgid "Empty patch. Aborted."
@@ -427,9 +457,8 @@ msgid "remote "
 msgstr ""
=20
 #: builtin/branch.c:169
-#, fuzzy
 msgid "cannot use -a with -d"
-msgstr "nie wiem w kt=F3rym katalogu jestem"
+msgstr "nie mo=BFna u=BFy=E6 opcji -a z opcj=B1 -d"
=20
 #: builtin/branch.c:175
 msgid "Couldn't look up commit object for HEAD"
@@ -619,9 +648,9 @@ msgid "you need to resolve your current index first=
"
 msgstr ""
=20
 #: builtin/checkout.c:527
-#, fuzzy, c-format
+#, c-format
 msgid "Can not do reflog for '%s'\n"
-msgstr "nie mog=EA otworzy=E6 katalogu '%s'"
+msgstr "Nie mo=BFna utworzy=E6 reflog dla '%s'\n"
=20
 #: builtin/checkout.c:557
 msgid "HEAD is now at"
@@ -720,9 +749,8 @@ msgid "--detach cannot be used with -b/-B/--orphan"
 msgstr ""
=20
 #: builtin/checkout.c:979
-#, fuzzy
 msgid "--detach cannot be used with -t"
-msgstr "nie wiem w kt=F3rym katalogu jestem"
+msgstr "--detach nie mo=BFe by=E6 u=BFyte z -t"
=20
 #: builtin/checkout.c:985
 msgid "--track needs a branch name"
@@ -813,9 +841,9 @@ msgid "Removing %s\n"
 msgstr ""
=20
 #: builtin/clean.c:161 builtin/clean.c:181
-#, fuzzy, c-format
+#, c-format
 msgid "failed to remove %s"
-msgstr "nie mog=EA otworzy=E6 katalogu '%s'"
+msgstr "nie mog=EA usun=B1=E6 '%s'"
=20
 #: builtin/clean.c:165
 #, c-format
@@ -833,24 +861,24 @@ msgid "reference repository '%s' is not a local d=
irectory."
 msgstr ""
=20
 #: builtin/clone.c:241
-#, fuzzy, c-format
+#, c-format
 msgid "failed to open '%s'"
-msgstr "nie mog=EA otworzy=E6 katalogu '%s'"
+msgstr "nie mog=EA otworzy=E6 '%s'"
=20
 #: builtin/clone.c:245
-#, fuzzy, c-format
+#, c-format
 msgid "failed to create directory '%s'"
-msgstr "beznadziejny katalog gita %s"
+msgstr "nie mog=EA utworzy=E6 katalogu '%s'"
=20
 #: builtin/clone.c:247 builtin/diff.c:74
-#, fuzzy, c-format
+#, c-format
 msgid "failed to stat '%s'"
-msgstr "nie mog=EA tkn=B1=E6 '%s'"
+msgstr "nie mog=EA wykona=E6 stat na '%s'"
=20
 #: builtin/clone.c:249
-#, fuzzy, c-format
+#, c-format
 msgid "%s exists and is not a directory"
-msgstr "beznadziejny katalog gita %s"
+msgstr "%s istnieje i nie jest katalogiem"
=20
 #: builtin/clone.c:263
 #, c-format
@@ -863,14 +891,14 @@ msgid "failed to unlink '%s'"
 msgstr ""
=20
 #: builtin/clone.c:278
-#, fuzzy, c-format
+#, c-format
 msgid "failed to create link '%s'"
-msgstr "readlink nie zadzia=B3a=B3o dla '%s'"
+msgstr "nie mog=EA utworzy=E6 dowi=B1zania '%s'"
=20
 #: builtin/clone.c:282
-#, fuzzy, c-format
+#, c-format
 msgid "failed to copy file to '%s'"
-msgstr "nie mog=EA skopiowa=E6 '%s' to '%s'"
+msgstr "nie mog=EA skopiowa=E6 pliku do '%s'"
=20
 #: builtin/clone.c:311
 #, c-format
@@ -915,9 +943,9 @@ msgid "could not create leading directories of '%s'=
"
 msgstr ""
=20
 #: builtin/clone.c:461
-#, fuzzy, c-format
+#, c-format
 msgid "could not create work tree dir '%s'."
-msgstr "Nie mog=EA dosta=E6 si=EA do drzewa roboczego '%s'"
+msgstr "nie mog=EA utworzy=E6 katalogu roboczego '%s'"
=20
 #: builtin/clone.c:480
 #, c-format
@@ -983,9 +1011,8 @@ msgid "failed to unpack HEAD tree object"
 msgstr ""
=20
 #: builtin/commit.c:359
-#, fuzzy
 msgid "unable to create temporary index"
-msgstr "beznadziejny katalog gita %s"
+msgstr "nie mog=EA utworzy=E6 tymczasowego indeksu"
=20
 #: builtin/commit.c:365
 msgid "interactive add failed"
@@ -1001,9 +1028,8 @@ msgid "cannot do a partial commit during a %s."
 msgstr ""
=20
 #: builtin/commit.c:456
-#, fuzzy
 msgid "cannot read the index"
-msgstr "readlink nie zadzia=B3a=B3o dla '%s'"
+msgstr "nie mog=EA odczyta=E6 indeksu"
=20
 #: builtin/commit.c:476
 msgid "unable to write temporary index file"
@@ -1042,9 +1068,9 @@ msgid "could not read log from standard input"
 msgstr ""
=20
 #: builtin/commit.c:674
-#, fuzzy, c-format
+#, c-format
 msgid "could not read log file '%s'"
-msgstr "readlink nie zadzia=B3a=B3o dla '%s'"
+msgstr ""
=20
 #: builtin/commit.c:680
 msgid "commit has empty message"
@@ -1059,14 +1085,14 @@ msgid "could not read SQUASH_MSG"
 msgstr ""
=20
 #: builtin/commit.c:704
-#, fuzzy, c-format
+#, c-format
 msgid "could not read '%s'"
-msgstr "readlink nie zadzia=B3a=B3o dla '%s'"
+msgstr "nie mo=BFna odczyta=E6 '%s'"
=20
 #: builtin/commit.c:732
-#, fuzzy, c-format
+#, c-format
 msgid "could not open '%s'"
-msgstr "nie mog=EA otworzy=E6 katalogu '%s'"
+msgstr "nie mog=EA otworzy=E6 '%s'"
=20
 #: builtin/commit.c:756
 msgid "could not write commit template"
@@ -1110,9 +1136,8 @@ msgid "%sCommitter: %s"
 msgstr ""
=20
 #: builtin/commit.c:829
-#, fuzzy
 msgid "Cannot read index"
-msgstr "readlink nie zadzia=B3a=B3o dla '%s'"
+msgstr "Nie mog=EA odczyta=E6 indeksu"
=20
 #: builtin/commit.c:869
 msgid "Error building trees"
@@ -1272,9 +1297,9 @@ msgid "%s is not a valid '%s' object"
 msgstr ""
=20
 #: builtin/describe.c:287
-#, fuzzy, c-format
+#, c-format
 msgid "no tag exactly matches '%s'"
-msgstr "nie mog=EA tkn=B1=E6 szablonu '%s'"
+msgstr "nie znaleziono taga kt=F3ry dok=B3adnie pasuje do '%s'"
=20
 #: builtin/describe.c:289
 #, c-format
@@ -1363,9 +1388,9 @@ msgid "Couldn't find remote ref HEAD"
 msgstr ""
=20
 #: builtin/fetch.c:252
-#, fuzzy, c-format
+#, c-format
 msgid "object %s not found"
-msgstr "nie znaleziono szablon=F3w %s"
+msgstr "nie znaleziono obiektu %s"
=20
 #: builtin/fetch.c:257
 msgid "[up to date]"
@@ -1413,9 +1438,9 @@ msgid "(non-fast-forward)"
 msgstr ""
=20
 #: builtin/fetch.c:361 builtin/fetch.c:684
-#, fuzzy, c-format
+#, c-format
 msgid "cannot open %s: %s\n"
-msgstr "nie mog=EA otworzy=E6 katalogu '%s'"
+msgstr "nie mog=EA otworzy=E6 %s: %s\n"
=20
 #: builtin/fetch.c:439
 #, c-format
@@ -1528,9 +1553,9 @@ msgid "Too many options specified"
 msgstr ""
=20
 #: builtin/gc.c:103
-#, fuzzy, c-format
+#, c-format
 msgid "insanely long object directory %.*s"
-msgstr "beznadziejny katalog gita %s"
+msgstr ""
=20
 #: builtin/gc.c:223
 #, c-format
@@ -1590,9 +1615,9 @@ msgid "switch `%c' expects a numerical value"
 msgstr ""
=20
 #: builtin/grep.c:691
-#, fuzzy, c-format
+#, c-format
 msgid "cannot open '%s'"
-msgstr "nie mog=EA otworzy=E6 katalogu '%s'"
+msgstr "nie mog=EA otworzy=E6 '%s'"
=20
 #: builtin/grep.c:974
 msgid "no pattern given."
@@ -1701,14 +1726,14 @@ msgid "unable to handle file type %d"
 msgstr ""
=20
 #: builtin/init-db.c:357
-#, fuzzy, c-format
+#, c-format
 msgid "unable to move %s to %s"
-msgstr "nie mog=EA skopiowa=E6 '%s' to '%s'"
+msgstr "nie mog=EA przenie=B6=E6 %s do %s"
=20
 #: builtin/init-db.c:362
-#, fuzzy, c-format
+#, c-format
 msgid "Could not create git link %s"
-msgstr "readlink nie zadzia=B3a=B3o dla '%s'"
+msgstr "Nie mog=EA utworzy=E6 git-dowi=B1zania %s"
=20
 #.
 #. * TRANSLATORS: The first '%s' is either "Reinitialized
@@ -1793,9 +1818,9 @@ msgid "name of output directory is too long"
 msgstr ""
=20
 #: builtin/log.c:688
-#, fuzzy, c-format
+#, c-format
 msgid "Cannot open patch file %s"
-msgstr "nie mog=EA otworzy=E6 katalogu '%s'"
+msgstr "Nie mog=EA otworzy=E6 pliku =B3aty %s"
=20
 #: builtin/log.c:702
 msgid "Need exactly one range."
@@ -1814,9 +1839,9 @@ msgid "Cover letter needs email format"
 msgstr ""
=20
 #: builtin/log.c:872
-#, fuzzy, c-format
+#, c-format
 msgid "insane in-reply-to: %s"
-msgstr "beznadziejny katalog gita %s"
+msgstr "niepoprawne in-reply-to: %s"
=20
 #: builtin/log.c:945
 msgid "Two output directories?"
@@ -1983,14 +2008,14 @@ msgstr ""
=20
 #: builtin/merge.c:841 builtin/merge.c:920 builtin/merge.c:1427
 #: builtin/merge.c:1436 builtin/revert.c:210
-#, fuzzy, c-format
+#, c-format
 msgid "Could not open '%s' for writing"
-msgstr "Nie mog=EA da=E6 prawa zapisu grupie w %s"
+msgstr "Nie mog=EA otworzy=E6 '%s' do zapisu"
=20
 #: builtin/merge.c:852
-#, fuzzy, c-format
+#, c-format
 msgid "Could not read from '%s'"
-msgstr "readlink nie zadzia=B3a=B3o dla '%s'"
+msgstr "Nie mog=EA czyta=E6 z '%s'"
=20
 #: builtin/merge.c:869
 #, c-format
@@ -2123,9 +2148,9 @@ msgid "Automatic merge went well; stopped before =
committing as requested\n"
 msgstr ""
=20
 #: builtin/mv.c:103
-#, fuzzy, c-format
+#, c-format
 msgid "Checking rename of '%s' to '%s'\n"
-msgstr "nie mog=EA skopiowa=E6 '%s' to '%s'"
+msgstr "Sprawdzanie zmiany nazwy z '%s' na '%s'\n"
=20
 #: builtin/mv.c:107
 msgid "bad source"
@@ -2204,9 +2229,9 @@ msgid "failed to finish 'show' for object '%s'"
 msgstr ""
=20
 #: builtin/notes.c:175 builtin/tag.c:303
-#, fuzzy, c-format
+#, c-format
 msgid "could not create file '%s'"
-msgstr "readlink nie zadzia=B3a=B3o dla '%s'"
+msgstr "nie mog=EA utworzy=E6 pliku '%s'"
=20
 #: builtin/notes.c:189
 msgid "Please supply the note contents using either -m or -F option"
@@ -2227,14 +2252,14 @@ msgid "The note contents has been left in %s"
 msgstr ""
=20
 #: builtin/notes.c:251 builtin/tag.c:448
-#, fuzzy, c-format
+#, c-format
 msgid "cannot read '%s'"
-msgstr "readlink nie zadzia=B3a=B3o dla '%s'"
+msgstr "nie mo=BFna odczyta=E6 '%s'"
=20
 #: builtin/notes.c:253 builtin/tag.c:451
-#, fuzzy, c-format
+#, c-format
 msgid "could not open or read '%s'"
-msgstr "nie mog=EA otworzy=E6 katalogu '%s'"
+msgstr "nie mog=EA otworzy=E6 ani odczyta=E6 '%s'"
=20
 #: builtin/notes.c:272 builtin/notes.c:445 builtin/notes.c:447
 #: builtin/notes.c:507 builtin/notes.c:561 builtin/notes.c:644
@@ -2276,9 +2301,9 @@ msgid "Malformed input line: '%s'."
 msgstr ""
=20
 #: builtin/notes.c:456
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to copy notes from '%s' to '%s'"
-msgstr "nie mog=EA skopiowa=E6 '%s' to '%s'"
+msgstr "Nie uda=B3o si=EA skopiowa=E6 adnotacji z '%s' do '%s'"
=20
 #: builtin/notes.c:500 builtin/notes.c:554 builtin/notes.c:627
 #: builtin/notes.c:639 builtin/notes.c:712 builtin/notes.c:759
@@ -2687,9 +2712,9 @@ msgid "tag name too long: %.*s..."
 msgstr ""
=20
 #: builtin/tag.c:126
-#, fuzzy, c-format
+#, c-format
 msgid "tag '%s' not found."
-msgstr "nie znaleziono szablon=F3w %s"
+msgstr "nie znaleziono tagu '%s'."
=20
 #: builtin/tag.c:141
 #, c-format
@@ -3027,9 +3052,9 @@ msgid "No logfile given"
 msgstr ""
=20
 #: git-bisect.sh:372
-#, fuzzy, sh-format
+#, sh-format
 msgid "cannot read $file for replaying"
-msgstr "readlink nie zadzia=B3a=B3o dla '%s'"
+msgstr ""
=20
 #: git-bisect.sh:388
 msgid "?? what are you talking about?"
@@ -3106,14 +3131,12 @@ msgid "You do not have the initial commit yet"
 msgstr ""
=20
 #: git-stash.sh:80
-#, fuzzy
 msgid "Cannot save the current index state"
-msgstr "Nie mog=EA dobra=E6 si=EA do bie=BF=B1cego katalogu"
+msgstr "Nie mog=EA zapisa=E6 bie=BF=B1cego stanu indeksu"
=20
 #: git-stash.sh:94 git-stash.sh:107
-#, fuzzy
 msgid "Cannot save the current worktree state"
-msgstr "Nie mog=EA dobra=E6 si=EA do bie=BF=B1cego katalogu"
+msgstr "Nie mog=EA zapisa=E6 bie=BF=B1cego stanu katalogu roboczego"
=20
 #: git-stash.sh:111
 msgid "No changes selected"
@@ -3124,9 +3147,8 @@ msgid "Cannot remove temporary index (can't happe=
n)"
 msgstr ""
=20
 #: git-stash.sh:127
-#, fuzzy
 msgid "Cannot record working tree state"
-msgstr "Nie mog=EA dosta=E6 si=EA do drzewa roboczego '%s'"
+msgstr ""
=20
 #: git-stash.sh:182
 msgid "No local changes to save"
@@ -3141,9 +3163,8 @@ msgid "Cannot save the current status"
 msgstr ""
=20
 #: git-stash.sh:207
-#, fuzzy
 msgid "Cannot remove worktree changes"
-msgstr "Nie mog=EA dosta=E6 si=EA do drzewa roboczego '%s'"
+msgstr "Nie mog=EA usun=B1=E6 zmian w katalogu roboczym"
=20
 #: git-stash.sh:302
 msgid "No stash found."
@@ -3182,9 +3203,8 @@ msgid "Conflicts in index. Try without --index."
 msgstr ""
=20
 #: git-stash.sh:373
-#, fuzzy
 msgid "Could not save index tree"
-msgstr "Nie mog=EA da=E6 prawa zapisu grupie w %s"
+msgstr ""
=20
 #: git-stash.sh:399
 msgid "Cannot unstage modified files"
@@ -3238,9 +3258,9 @@ msgid "repo URL: '$repo' must be absolute or begi=
n with ./|../"
 msgstr ""
=20
 #: git-submodule.sh:222
-#, fuzzy, sh-format
+#, sh-format
 msgid "'$path' already exists in the index"
-msgstr "readlink nie zadzia=B3a=B3o dla '%s'"
+msgstr "'$path' ju=BF jest w indeksie"
=20
 #: git-submodule.sh:227
 #, sh-format
@@ -3256,9 +3276,9 @@ msgid "Adding existing repo at '$path' to the ind=
ex"
 msgstr ""
=20
 #: git-submodule.sh:242
-#, fuzzy, sh-format
+#, sh-format
 msgid "'$path' already exists and is not a valid git repo"
-msgstr "beznadziejny katalog gita %s"
+msgstr "'$path' ju=BF istnieje i nie jest poprawnym repozytorium Gita"
=20
 #: git-submodule.sh:265
 #, sh-format
--=20
1.7.5

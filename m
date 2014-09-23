From: Phillip Sz <phillip.szelat@gmail.com>
Subject: [PATCH] l10n:de.po: use comma before "um"
Date: Tue, 23 Sep 2014 14:00:52 +0200
Message-ID: <1411473652-14582-1-git-send-email-phillip.szelat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	ralf.thielow@gmail.com, Phillip Sz <phillip.szelat@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 14:15:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWOo9-0002Dp-Ap
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 14:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106AbaIWMCz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Sep 2014 08:02:55 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:49223 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbaIWMCw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 08:02:52 -0400
Received: by mail-we0-f178.google.com with SMTP id t60so4464248wes.9
        for <git@vger.kernel.org>; Tue, 23 Sep 2014 05:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=D7aYIhClLiVEM2Qa0cVqf/SbzFRy3c97wPb4J6Oov/s=;
        b=hngVbp7DRgSoFbIWZ9caSAR9L0AiXj5FMF8VEHQ3NhGoFs9XBjjvx5G8uTlebtRuz9
         1h9dTsYiuWkVUV4iH+L2FEdacX9Yw6p0lziu0SORCF/N9YmTQbku4z0UrvXORi2ta3/L
         UGCq4p6i0+tUHyqwc/ll/T5XyUKZcf4AINPKwDg6oZlZhj7qEqHUg3Wok1/2t2/VZ3wz
         0OSjSLu9zbxwrFpvc5ZylKHyWBn9aAsJz+O3DItYx/xz4NjzskqXqKcamS6QH5HlMIal
         4wxKDmMQ2fxwJ/QqGqE75ynSxKmEbxuxNlNguz4Wklz7tlH4PxS2fnRQmBZzCwF/PfWk
         pjog==
X-Received: by 10.194.84.175 with SMTP id a15mr28812481wjz.12.1411473770700;
        Tue, 23 Sep 2014 05:02:50 -0700 (PDT)
Received: from phillip.fritz.box (i577AA68D.versanet.de. [87.122.166.141])
        by mx.google.com with ESMTPSA id e5sm2065386wiw.2.2014.09.23.05.02.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Sep 2014 05:02:50 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257413>

Hi,
this patch added a comma before the "um". See:

http://www.duden.de/sprachwissen/rechtschreibregeln/komma#K117

Phillip=20

Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
---
 po/de.po | 86 ++++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/po/de.po b/po/de.po
index c6aa69f..c807967 100644
--- a/po/de.po
+++ b/po/de.po
@@ -29,7 +29,7 @@ msgid ""
 "'git commit -a'."
 msgstr ""
 "Korrigieren Sie dies im Arbeitsverzeichnis, und benutzen Sie\n"
-"dann 'git add/rm <Datei>' um die Aufl=C3=B6sung entsprechend zu marki=
eren\n"
+"dann 'git add/rm <Datei>', um die Aufl=C3=B6sung entsprechend zu mark=
ieren\n"
 "und zu committen, oder benutzen Sie 'git commit -a'."
=20
 #: archive.c:10
@@ -619,7 +619,7 @@ msgstr "Fehler beim Erstellen des Pfades '%s'%s"
 #: merge-recursive.c:703
 #, c-format
 msgid "Removing %s to make room for subdirectory\n"
-msgstr "Entferne %s um Platz f=C3=BCr Unterverzeichnis zu schaffen\n"
+msgstr "Entferne %s, um Platz f=C3=BCr Unterverzeichnis zu schaffen\n"
=20
 #: merge-recursive.c:717 merge-recursive.c:738
 msgid ": perhaps a D/F conflict?"
@@ -1037,7 +1037,7 @@ msgstr[1] "Ihr Branch ist vor '%s' um %d Commits.=
\n"
=20
 #: remote.c:1960
 msgid "  (use \"git push\" to publish your local commits)\n"
-msgstr "  (benutzen Sie \"git push\" um lokale Commits zu publizieren)=
\n"
+msgstr "  (benutzen Sie \"git push\", um lokale Commits zu publizieren=
)\n"
=20
 #: remote.c:1963
 #, c-format
@@ -1052,7 +1052,7 @@ msgstr[1] ""
 #: remote.c:1971
 msgid "  (use \"git pull\" to update your local branch)\n"
 msgstr ""
-"  (benutzen Sie \"git pull\" um Ihren lokalen Branch zu aktualisieren=
)\n"
+"  (benutzen Sie \"git pull\", um Ihren lokalen Branch zu aktualisiere=
n)\n"
=20
 #: remote.c:1974
 #, c-format
@@ -1072,7 +1072,7 @@ msgstr[1] ""
 #: remote.c:1984
 msgid "  (use \"git pull\" to merge the remote branch into yours)\n"
 msgstr ""
-"  (benutzen Sie \"git pull\" um Ihren Branch mit dem Remote-Branch "
+"  (benutzen Sie \"git pull\", um Ihren Branch mit dem Remote-Branch "
 "zusammenzuf=C3=BChren)\n"
=20
 #: run-command.c:80
@@ -1136,7 +1136,7 @@ msgstr "Ihre lokalen =C3=84nderungen w=C3=BCrden =
von \"revert\" =C3=BCberschrieben werden."
 #: sequencer.c:233
 msgid "Commit your changes or stash them to proceed."
 msgstr ""
-"Tragen Sie Ihre =C3=84nderungen ein oder benutzen Sie \"stash\" um fo=
rtzufahren."
+"Tragen Sie Ihre =C3=84nderungen ein oder benutzen Sie \"stash\", um f=
ortzufahren."
=20
 #: sequencer.c:250
 msgid "Failed to lock HEAD during fast_forward_to"
@@ -1488,18 +1488,18 @@ msgstr ""
 #: wt-status.c:183
 msgid "  (use \"git add <file>...\" to mark resolution)"
 msgstr ""
-"  (benutzen Sie \"git add/rm <Datei>...\" um die Aufl=C3=B6sung zu ma=
rkieren)"
+"  (benutzen Sie \"git add/rm <Datei>...\", um die Aufl=C3=B6sung zu m=
arkieren)"
=20
 #: wt-status.c:185 wt-status.c:189
 msgid "  (use \"git add/rm <file>...\" as appropriate to mark resoluti=
on)"
 msgstr ""
-"  (benutzen Sie \"git add/rm <Datei>...\" um die Aufl=C3=B6sung entsp=
rechend zu "
+"  (benutzen Sie \"git add/rm <Datei>...\", um die Aufl=C3=B6sung ents=
prechend zu "
 "markieren)"
=20
 #: wt-status.c:187
 msgid "  (use \"git rm <file>...\" to mark resolution)"
 msgstr ""
-"  (benutzen Sie \"git add/rm <Datei>...\" um die Aufl=C3=B6sung zu ma=
rkieren)"
+"  (benutzen Sie \"git add/rm <Datei>...\", um die Aufl=C3=B6sung zu m=
arkieren)"
=20
 #: wt-status.c:198
 msgid "Changes to be committed:"
@@ -1512,20 +1512,20 @@ msgstr "=C3=84nderungen, die nicht zum Commit v=
orgemerkt sind:"
 #: wt-status.c:220
 msgid "  (use \"git add <file>...\" to update what will be committed)"
 msgstr ""
-"  (benutzen Sie \"git add <Datei>...\" um die =C3=84nderungen zum Com=
mit "
+"  (benutzen Sie \"git add <Datei>...\", um die =C3=84nderungen zum Co=
mmit "
 "vorzumerken)"
=20
 #: wt-status.c:222
 msgid "  (use \"git add/rm <file>...\" to update what will be committe=
d)"
 msgstr ""
-"  (benutzen Sie \"git add/rm <Datei>...\" um die =C3=84nderungen zum =
Commit "
+"  (benutzen Sie \"git add/rm <Datei>...\", um die =C3=84nderungen zum=
 Commit "
 "vorzumerken)"
=20
 #: wt-status.c:223
 msgid ""
 "  (use \"git checkout -- <file>...\" to discard changes in working di=
rectory)"
 msgstr ""
-"  (benutzen Sie \"git checkout -- <Datei>...\" um die =C3=84nderungen=
 im "
+"  (benutzen Sie \"git checkout -- <Datei>...\", um die =C3=84nderunge=
n im "
 "Arbeitsverzeichnis zu verwerfen)"
=20
 #: wt-status.c:225
@@ -1538,7 +1538,7 @@ msgstr ""
 #, c-format
 msgid "  (use \"git %s <file>...\" to include in what will be committe=
d)"
 msgstr ""
-"  (benutzen Sie \"git %s <Datei>...\" um die =C3=84nderungen zum Comm=
it "
+"  (benutzen Sie \"git %s <Datei>...\", um die =C3=84nderungen zum Com=
mit "
 "vorzumerken)"
=20
 #: wt-status.c:252
@@ -1653,7 +1653,7 @@ msgstr "Alle Konflikte sind behoben, aber Sie sin=
d immer noch beim Merge."
=20
 #: wt-status.c:945
 msgid "  (use \"git commit\" to conclude merge)"
-msgstr "  (benutzen Sie \"git commit\" um den Merge abzuschlie=C3=9Fen=
)"
+msgstr "  (benutzen Sie \"git commit\", um den Merge abzuschlie=C3=9Fe=
n)"
=20
 #: wt-status.c:955
 msgid "You are in the middle of an am session."
@@ -1670,12 +1670,12 @@ msgstr ""
=20
 #: wt-status.c:964
 msgid "  (use \"git am --skip\" to skip this patch)"
-msgstr "  (benutzen Sie \"git am --skip\" um diesen Patch auszulassen)=
"
+msgstr "  (benutzen Sie \"git am --skip\", um diesen Patch auszulassen=
)"
=20
 #: wt-status.c:966
 msgid "  (use \"git am --abort\" to restore the original branch)"
 msgstr ""
-"  (benutzen Sie \"git am --abort\" um den urspr=C3=BCnglichen Branch =
"
+"  (benutzen Sie \"git am --abort\", um den urspr=C3=BCnglichen Branch=
 "
 "wiederherzustellen)"
=20
 #: wt-status.c:1026 wt-status.c:1043
@@ -1695,12 +1695,12 @@ msgstr ""
=20
 #: wt-status.c:1036
 msgid "  (use \"git rebase --skip\" to skip this patch)"
-msgstr "  (benutzen Sie \"git rebase --skip\" um diesen Patch auszulas=
sen)"
+msgstr "  (benutzen Sie \"git rebase --skip\", um diesen Patch auszula=
ssen)"
=20
 #: wt-status.c:1038
 msgid "  (use \"git rebase --abort\" to check out the original branch)=
"
 msgstr ""
-"  (benutzen Sie \"git rebase --abort\" um den urspr=C3=BCnglichen Bra=
nch "
+"  (benutzen Sie \"git rebase --abort\", um den urspr=C3=BCnglichen Br=
anch "
 "auszuchecken)"
=20
 #: wt-status.c:1051
@@ -1739,7 +1739,7 @@ msgstr "Sie editieren gerade einen Commit w=C3=A4=
hrend eines Rebase."
 #: wt-status.c:1075
 msgid "  (use \"git commit --amend\" to amend the current commit)"
 msgstr ""
-"  (benutzen Sie \"git commit --amend\" um den aktuellen Commit nachzu=
bessern)"
+"  (benutzen Sie \"git commit --amend\", um den aktuellen Commit nachz=
ubessern)"
=20
 #: wt-status.c:1077
 msgid ""
@@ -1767,7 +1767,7 @@ msgstr ""
 #: wt-status.c:1097
 msgid "  (use \"git cherry-pick --abort\" to cancel the cherry-pick op=
eration)"
 msgstr ""
-"  (benutzen Sie \"git cherry-pick --abort\" um die Cherry-Pick-Operat=
ion "
+"  (benutzen Sie \"git cherry-pick --abort\", um die Cherry-Pick-Opera=
tion "
 "abzubrechen)"
=20
 #: wt-status.c:1106
@@ -1788,7 +1788,7 @@ msgstr "  (alle Konflikte behoben: f=C3=BChren Si=
e \"git revert --continue\" aus)"
 #: wt-status.c:1116
 msgid "  (use \"git revert --abort\" to cancel the revert operation)"
 msgstr ""
-"  (benutzen Sie \"git revert --abort\" um die Revert-Operation abzubr=
echen)"
+"  (benutzen Sie \"git revert --abort\", um die Revert-Operation abzub=
rechen)"
=20
 #: wt-status.c:1127
 #, c-format
@@ -1802,7 +1802,7 @@ msgstr "Sie sind gerade bei einer bin=C3=A4ren Su=
che."
 #: wt-status.c:1134
 msgid "  (use \"git bisect reset\" to get back to the original branch)=
"
 msgstr ""
-"  (benutzen Sie \"git bisect reset\" um zum urspr=C3=BCnglichen Branc=
h "
+"  (benutzen Sie \"git bisect reset\", um zum urspr=C3=BCnglichen Bran=
ch "
 "zur=C3=BCckzukehren)"
=20
 #: wt-status.c:1309
@@ -1855,7 +1855,7 @@ msgstr "Unbeobachtete Dateien nicht aufgelistet%s=
"
=20
 #: wt-status.c:1373
 msgid " (use -u option to show untracked files)"
-msgstr " (benutzen Sie die Option -u um unbeobachteten Dateien anzuzei=
gen)"
+msgstr " (benutzen Sie die Option -u, um unbeobachteten Dateien anzuze=
igen)"
=20
 #: wt-status.c:1379
 msgid "No changes"
@@ -2235,7 +2235,7 @@ msgstr[1] ""
 #: builtin/apply.c:2818
 #, c-format
 msgid "Context reduced to (%ld/%ld) to apply fragment at %d"
-msgstr "Kontext reduziert zu (%ld/%ld) um Patch-Bereich bei %d anzuwen=
den"
+msgstr "Kontext reduziert zu (%ld/%ld), um Patch-Bereich bei %d anzuwe=
nden"
=20
 #: builtin/apply.c:2824
 #, c-format
@@ -3085,7 +3085,7 @@ msgstr "zu viele Branches f=C3=BCr eine Umbenenne=
n-Operation angegeben"
=20
 #: builtin/branch.c:952
 msgid "too many branches to set new upstream"
-msgstr "zu viele Branches angegeben um Upstream-Branch zu setzen"
+msgstr "zu viele Branches angegeben, um Upstream-Branch zu setzen"
=20
 #: builtin/branch.c:956
 #, c-format
@@ -3108,7 +3108,7 @@ msgstr "Branch '%s' existiert nicht"
 #: builtin/branch.c:975
 msgid "too many branches to unset upstream"
 msgstr ""
-"zu viele Branches angegeben um Konfiguration zu Upstream-Branch zu en=
tfernen"
+"zu viele Branches angegeben, um Konfiguration zu Upstream-Branch zu e=
ntfernen"
=20
 #: builtin/branch.c:979
 msgid "could not unset upstream of HEAD when it does not point to any =
branch."
@@ -5071,7 +5071,7 @@ msgstr "gibt f=C3=BCr jeden Commit das gesamte Ve=
rzeichnis aus"
=20
 #: builtin/fast-export.c:718
 msgid "Use the done feature to terminate the stream"
-msgstr "Benutzt die \"done\"-Funktion um den Strom abzuschlie=C3=9Fen"
+msgstr "Benutzt die \"done\"-Funktion, um den Strom abzuschlie=C3=9Fen=
"
=20
 #: builtin/fast-export.c:719
 msgid "Skip output of blob data"
@@ -5268,7 +5268,7 @@ msgid ""
 " 'git remote prune %s' to remove any old, conflicting branches"
 msgstr ""
 "Einige lokale Referenzen konnten nicht aktualisiert werden; versuchen=
 Sie\n"
-"'git remote prune %s' um jeden =C3=A4lteren, widerspr=C3=BCchlichen B=
ranch zu l=C3=B6schen."
+"'git remote prune %s', um jeden =C3=A4lteren, widerspr=C3=BCchlichen =
Branch zu l=C3=B6schen."
=20
 #: builtin/fetch.c:759
 #, c-format
@@ -6978,7 +6978,7 @@ msgstr "konnte nicht von '%s' lesen"
 #, c-format
 msgid "Not committing merge; use 'git commit' to complete the merge.\n=
"
 msgstr ""
-"Merge wurde nicht committet; benutzen Sie 'git commit' um den Merge "
+"Merge wurde nicht committet; benutzen Sie 'git commit', um den Merge =
"
 "abzuschlie=C3=9Fen.\n"
=20
 #: builtin/merge.c:809
@@ -6990,7 +6990,7 @@ msgid ""
 "Lines starting with '%c' will be ignored, and an empty message aborts=
\n"
 "the commit.\n"
 msgstr ""
-"Bitte geben Sie eine Commit-Beschreibung ein um zu erkl=C3=A4ren, war=
um dieser\n"
+"Bitte geben Sie eine Commit-Beschreibung ein, um zu erkl=C3=A4ren, wa=
rum dieser\n"
 "Merge erforderlich ist, insbesondere wenn es einen aktualisierten\n"
 "Upstream-Branch mit einem Thema-Branch zusammenf=C3=BChrt.\n"
 "\n"
@@ -7156,7 +7156,7 @@ msgstr "Merge mit Strategie %s fehlgeschlagen.\n"
 #: builtin/merge.c:1539
 #, c-format
 msgid "Using the %s to prepare resolving by hand.\n"
-msgstr "Benutzen Sie \"%s\" um die Aufl=C3=B6sung per Hand vorzubereit=
en.\n"
+msgstr "Benutzen Sie \"%s\", um die Aufl=C3=B6sung per Hand vorzuberei=
ten.\n"
=20
 #: builtin/merge.c:1551
 #, c-format
@@ -7299,7 +7299,7 @@ msgid "Please, stage your changes to .gitmodules =
or stash them to proceed"
 msgstr ""
 "Bitte merken Sie Ihre =C3=84nderungen in .gitmodules zum Commit vor o=
der "
 "benutzen\n"
-"Sie \"stash\" um fortzufahren."
+"Sie \"stash\", um fortzufahren."
=20
 #: builtin/mv.c:156
 #, c-format
@@ -7368,7 +7368,7 @@ msgstr "zeigt nur Namen an (keine SHA-1)"
=20
 #: builtin/name-rev.c:310
 msgid "only use tags to name the commits"
-msgstr "verwendet nur Tags um die Commits zu benennen"
+msgstr "verwendet nur Tags, um die Commits zu benennen"
=20
 #: builtin/name-rev.c:312
 msgid "only use refs matching <pattern>"
@@ -7621,7 +7621,7 @@ msgid ""
 "existing notes"
 msgstr ""
 "Konnte Notizen nicht hinzuf=C3=BCgen. Existierende Notizen f=C3=BCr O=
bjekt %s "
-"gefunden. Verwenden Sie '-f' um die existierenden Notizen zu =C3=BCbe=
rschreiben."
+"gefunden. Verwenden Sie '-f', um die existierenden Notizen zu =C3=BCb=
erschreiben."
=20
 #: builtin/notes.c:460 builtin/notes.c:537
 #, c-format
@@ -7649,7 +7649,7 @@ msgid ""
 "existing notes"
 msgstr ""
 "Kann Notizen nicht kopieren. Existierende Notizen f=C3=BCr Objekt %s =
gefunden. "
-"Verwenden Sie '-f' um die existierenden Notizen zu =C3=BCberschreiben=
=2E"
+"Verwenden Sie '-f', um die existierenden Notizen zu =C3=BCberschreibe=
n."
=20
 #: builtin/notes.c:543
 #, c-format
@@ -9359,7 +9359,7 @@ msgid ""
 "(use -f to force removal)"
 msgstr ""
 "\n"
-"(benutzen Sie -f um die L=C3=B6schung zu erzwingen)"
+"(benutzen Sie -f, um die L=C3=B6schung zu erzwingen)"
=20
 #: builtin/rm.c:240
 msgid "the following file has changes staged in the index:"
@@ -9373,7 +9373,7 @@ msgid ""
 "(use --cached to keep the file, or -f to force removal)"
 msgstr ""
 "\n"
-"(benutzen Sie --cached um die Datei zu behalten, oder -f um die Entfe=
rnung "
+"(benutzen Sie --cached, um die Datei zu behalten, oder -f, um die Ent=
fernung "
 "zu erzwingen)"
=20
 #: builtin/rm.c:252
@@ -9751,7 +9751,7 @@ msgstr "annotiertes und GPG-signiertes Tag"
=20
 #: builtin/tag.c:605
 msgid "use another key to sign the tag"
-msgstr "verwendet einen anderen Schl=C3=BCssel um das Tag zu signieren=
"
+msgstr "verwendet einen anderen Schl=C3=BCssel, um das Tag zu signiere=
n"
=20
 #: builtin/tag.c:606
 msgid "replace the tag if exists"
@@ -10046,7 +10046,7 @@ msgid ""
 msgstr ""
 "'git help -a' und 'git help -g' listet verf=C3=BCgbare Unterkommandos=
 und\n"
 "einige Anleitungen zu Git-Konzepten auf. Benutzen Sie 'git help <Komm=
ando>'\n"
-"oder 'git help <Konzept>' um mehr =C3=BCber ein spezifisches Kommando=
 oder\n"
+"oder 'git help <Konzept>', um mehr =C3=BCber ein spezifisches Kommand=
o oder\n"
 "Konzept zu erfahren."
=20
 #: parse-options.h:143
@@ -10200,7 +10200,7 @@ msgstr ""
 #: git-am.sh:141
 msgid "Using index info to reconstruct a base tree..."
 msgstr ""
-"Verwende Informationen aus der Staging-Area um einen Basisverzeichnis=
 "
+"Verwende Informationen aus der Staging-Area, um einen Basisverzeichni=
s "
 "nachzustellen"
=20
 #: git-am.sh:156
@@ -10257,7 +10257,7 @@ msgid ""
 "Use \"git am --abort\" to remove it."
 msgstr ""
 "Stray $dotest Verzeichnis gefunden.\n"
-"Benutzen Sie \"git am --abort\" um es zu entfernen."
+"Benutzen Sie \"git am --abort\", um es zu entfernen."
=20
 #: git-am.sh:535
 msgid "Resolve operation not in progress, we are not resuming."
@@ -10515,7 +10515,7 @@ msgid ""
 msgstr ""
 "\"pull\" ist nicht m=C3=B6glich, weil Sie nicht zusammengef=C3=BChrte=
 Dateien haben.\n"
 "Bitte korrigieren Sie dies im Arbeitsverzeichnis und benutzen Sie dan=
n \n"
-"'git add/rm <Datei>' um die Aufl=C3=B6sung entsprechend zu markieren,=
 oder\n"
+"'git add/rm <Datei>', um die Aufl=C3=B6sung entsprechend zu markieren=
, oder\n"
 "benutzen Sie 'git commit -a'."
=20
 #: git-pull.sh:25
@@ -11014,7 +11014,7 @@ msgid ""
 "discard them"
 msgstr ""
 "Arbeitsverzeichnis von Submodul in '$displaypath' enth=C3=A4lt lokale=
 =C3=84nderungen; "
-"verwenden Sie '-f' um diese zu verwerfen"
+"verwenden Sie '-f', um diese zu verwerfen"
=20
 #: git-submodule.sh:701
 #, sh-format
--=20
2.1.0

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=203/9=5D=20po/de=2Epo=3A=20update=20German=20translation?=
Date: Mon,  3 Oct 2011 18:58:11 +0000
Message-ID: <1317668297-2702-4-git-send-email-avarab@gmail.com>
References: <1317668297-2702-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?q?Marcin=20Cie=C5=9Blak?= <saper@saper.info>,
	Sam Reed <sam@reedyboy.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 21:00:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAnkN-0005pX-Hq
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757260Ab1JCTAJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 15:00:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34197 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab1JCTAI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 15:00:08 -0400
Received: by yxl31 with SMTP id 31so3790720yxl.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7yMT2ZJoo04kUVBCQynbxOh6SmVJ02xMpDg0TIL14Eo=;
        b=JACV0ehN0NzmzHa048ywgfL5P2veYgZethpIfoYklyPX+1+giKW75uqWoEVvMCFz4x
         X31/2RIOJc43ATUeXaPb2xPFIpeJl4FKIitX7d/jJp9fw3fGY7kL+e4CRNP3qrxslD3T
         x0WRwMZ1866Ytd7PhmnqFRX0NixYqPrwdLsME=
Received: by 10.223.37.26 with SMTP id v26mr327216fad.100.1317668345232;
        Mon, 03 Oct 2011 11:59:05 -0700 (PDT)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id f25sm22312819faf.7.2011.10.03.11.59.04
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 11:59:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.3
In-Reply-To: <1317668297-2702-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182694>

=46rom: Jan Engelhardt <jengelh@medozas.de>

* resolve fuzzy strings
* fill in new empty strings
* anglicism reduction: use "Zweig" for "branch"

Signed-off-by: Jan Engelhardt <jengelh@medozas.de>
---
 po/de.po |  391 +++++++++++++++++++++++++++++++-----------------------=
--------
 1 files changed, 194 insertions(+), 197 deletions(-)

diff --git a/po/de.po b/po/de.po
index d802bfd..966e330 100644
--- a/po/de.po
+++ b/po/de.po
@@ -8,7 +8,7 @@ msgstr ""
 "Project-Id-Version: Git\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
 "POT-Creation-Date: 2011-07-06 19:20+0000\n"
-"PO-Revision-Date: 2010-10-29 15:20+0100\n"
+"PO-Revision-Date: 2011-07-06 23:05+0200\n"
 "Last-Translator: Jan Engelhardt <jengelh@medozas.de>\n"
 "Language-Team: Git Mailing List <git@vger.kernel.org>\n"
 "Language: de\n"
@@ -20,12 +20,12 @@ msgstr ""
 #: diff.c:104
 #, c-format
 msgid "  Failed to parse dirstat cut-off percentage '%.*s'\n"
-msgstr ""
+msgstr "  Konnte den Trimprozentsatz \"%.*s\" f=C3=BCr dirstat nicht p=
arsen\n"
=20
 #: diff.c:109
-#, fuzzy, c-format
+#, c-format
 msgid "  Unknown dirstat parameter '%.*s'\n"
-msgstr "kann Vorlage \"%s\" nicht finden/pr=C3=BCfen"
+msgstr "  Unbekannter dirstat-Parameter \"%.*s\"\n"
=20
 #: diff.c:205
 #, c-format
@@ -33,6 +33,8 @@ msgid ""
 "Found errors in 'diff.dirstat' config variable:\n"
 "%s"
 msgstr ""
+"Es gibt Fehler in der \"diff.dirstat\"-Konfigurationsvariable:\n"
+"%s"
=20
 #: diff.c:3295
 #, c-format
@@ -40,79 +42,72 @@ msgid ""
 "Failed to parse --dirstat/-X option parameter:\n"
 "%s"
 msgstr ""
+"Konnte das Argument zur --dirstat/-X Option nicht parsen:\n"
+"%s"
=20
 #: wt-status.c:134
-#, fuzzy
 msgid "Unmerged paths:"
-msgstr "# Verbleibende Konflikte in Pfaden:"
+msgstr "Verbleibende Konflikte in Pfaden:"
=20
 #: wt-status.c:140 wt-status.c:157
-#, fuzzy, c-format
+#, c-format
 msgid "  (use \"git reset %s <file>...\" to unstage)"
 msgstr ""
-"#   (verwende `git reset %s <Datei>`, um die =C3=84nderungen nicht me=
hr "
+"  (verwende `git reset %s <Datei>`, um die =C3=84nderungen nicht mehr=
 "
 "vorzumerken)"
=20
 #: wt-status.c:142 wt-status.c:159
-#, fuzzy
 msgid "  (use \"git rm --cached <file>...\" to unstage)"
 msgstr ""
-"#   (verwende `git rm --cached <Datei>`, um die Datei nicht mehr vorz=
umerken)"
+"  (verwende `git rm --cached <Datei>`, um die Datei nicht mehr vorzum=
erken)"
=20
 #: wt-status.c:143
-#, fuzzy
 msgid "  (use \"git add/rm <file>...\" as appropriate to mark resoluti=
on)"
 msgstr ""
-"#   (verwende `git add/rm <Datei>...`, um Konflikte als gel=C3=B6st z=
u markieren)"
+"  (verwende `git add/rm <Datei>...`, um Konflikte als gel=C3=B6st zu =
markieren)"
=20
 #: wt-status.c:151
-#, fuzzy
 msgid "Changes to be committed:"
-msgstr "# Vorgemerkte =C3=84nderungen f=C3=BCr den n=C3=A4chsten Commi=
t:"
+msgstr "Vorgemerkte =C3=84nderungen f=C3=BCr den n=C3=A4chsten Commit:=
"
=20
 #: wt-status.c:169
-#, fuzzy
 msgid "Changes not staged for commit:"
-msgstr "# Vorgemerkte =C3=84nderungen f=C3=BCr den n=C3=A4chsten Commi=
t:"
+msgstr "Ge=C3=A4ndert, aber nicht f=C3=BCr den n=C3=A4chsten Commit vo=
rgemerkt:"
=20
 #: wt-status.c:173
-#, fuzzy
 msgid "  (use \"git add <file>...\" to update what will be committed)"
 msgstr ""
-"#   (verwende `git add <Datei>...`, um den aktuellen Stand vorzumerke=
n)"
+"  (verwende `git add <Datei>...`, um den aktuellen Stand vorzumerken)=
"
=20
 #: wt-status.c:175
-#, fuzzy
 msgid "  (use \"git add/rm <file>...\" to update what will be committe=
d)"
 msgstr ""
-"#   (verwende entsprechend `git add/rm <Datei>...`, um den aktuellen =
Stand "
+"  (verwende entsprechend `git add/rm <Datei>...`, um den aktuellen St=
and "
 "vorzumerken)"
=20
 #: wt-status.c:176
-#, fuzzy
 msgid ""
 "  (use \"git checkout -- <file>...\" to discard changes in working di=
rectory)"
 msgstr ""
-"#   (verwende `git checkout -- <Datei>...`, um =C3=84nderungen in der=
 Datei zu "
+"  (verwende `git checkout -- <Datei>...`, um =C3=84nderungen in der A=
rbeitskopie der Datei zu "
 "verwerfen)"
=20
 #: wt-status.c:178
-#, fuzzy
 msgid "  (commit or discard the untracked or modified content in submo=
dules)"
 msgstr ""
-"#   (committe oder verwerfe die unber=C3=BCcksichtigten Dateien oder =
=C3=84nderungen "
+"  (committe oder verwerfe die unber=C3=BCcksichtigten Dateien oder =C3=
=84nderungen "
 "in Submodulen)"
=20
 #: wt-status.c:187
-#, fuzzy, c-format
+#, c-format
 msgid "%s files:"
-msgstr "# %s Dateien:"
+msgstr "%s Dateien:"
=20
 #: wt-status.c:190
-#, fuzzy, c-format
+#, c-format
 msgid "  (use \"git %s <file>...\" to include in what will be committe=
d)"
 msgstr ""
-"#   (verwende `git %s <Datei>...`, um zu vorgemerkten Dateien hinzuzu=
f=C3=BCgen)"
+"  (verwende `git %s <Datei>...`, um zu vorgemerkten Dateien hinzuzuf=C3=
=BCgen)"
=20
 #: wt-status.c:207
 msgid "bug"
@@ -205,16 +200,15 @@ msgstr "Bug: nicht behandelter Diff-Status %c"
=20
 #: wt-status.c:713
 msgid "On branch "
-msgstr "Auf Branch: "
+msgstr "Auf Zweig: "
=20
 #: wt-status.c:720
 msgid "Not currently on any branch."
-msgstr "Gegenw=C3=A4rtig auf keiner Branch."
+msgstr "Gegenw=C3=A4rtig auf keinem Zweig."
=20
 #: wt-status.c:731
-#, fuzzy
 msgid "Initial commit"
-msgstr "# Erster Commit"
+msgstr "Erster Commit"
=20
 #: wt-status.c:745
 msgid "Untracked"
@@ -225,18 +219,16 @@ msgid "Ignored"
 msgstr "Ignorierte"
=20
 #: wt-status.c:749
-#, fuzzy, c-format
 msgid "Untracked files not listed%s"
-msgstr "# Unber=C3=BCcksichtigte Dateien werden nicht aufgef=C3=BChrt%=
s\n"
+msgstr "Unber=C3=BCcksichtigte Dateien werden nicht aufgef=C3=BChrt%s"
=20
 #: wt-status.c:751
 msgid " (use -u option to show untracked files)"
 msgstr " (verwende die Option -u, um unber=C3=BCcksichtigte Dateien an=
zuzeigen)"
=20
 #: wt-status.c:757
-#, fuzzy
 msgid "No changes"
-msgstr "# Keine =C3=84nderungen\n"
+msgstr "Keine =C3=84nderungen"
=20
 #: wt-status.c:761
 #, c-format
@@ -277,7 +269,7 @@ msgstr " (Arbeitsverzeichnis sauber)"
=20
 #: wt-status.c:884
 msgid "HEAD (no branch)"
-msgstr "HEAD (keine Branch)"
+msgstr "HEAD (kein Zweig)"
=20
 #: wt-status.c:890
 msgid "Initial commit on "
@@ -356,12 +348,8 @@ msgid "Could not apply '%s'"
 msgstr "Konnte \"%s\" nicht anwenden"
=20
 #: builtin/add.c:310
-#, fuzzy
 msgid "The following paths are ignored by one of your .gitignore files=
:\n"
-msgstr ""
-"Der folgende Pfad ist mittels einer der .gitignore-Dateien ignoriert:=
\n"
-"$path\n"
-"Verwende -f um Hinzuf=C3=BCgen zu erzwingen."
+msgstr "Die folgenden Pfade sind mittels einer .gitignore-Dateien igno=
riert:\n"
=20
 #: builtin/add.c:350
 #, c-format
@@ -434,12 +422,12 @@ msgid "git archive: expected a flush"
 msgstr "git archive: Flush erwartet"
=20
 #: builtin/branch.c:136
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "deleting branch '%s' that has been merged to\n"
 "         '%s', but not yet merged to HEAD."
 msgstr ""
-"l=C3=B6sche Branch \"%s\", die zwar bereits in \"%s\" gemerged wurde,=
 aber noch "
+"l=C3=B6sche Zweig \"%s\", der zwar bereits in \"%s\" gemerged wurde, =
aber noch "
 "nicht in HEAD ist."
=20
 #: builtin/branch.c:140
@@ -448,8 +436,8 @@ msgid ""
 "not deleting branch '%s' that is not yet merged to\n"
 "         '%s', even though it is merged to HEAD."
 msgstr ""
-"Branch \"%s\" wird nicht gel=C3=B6scht, da noch nicht in \"%s\" gemer=
ged, obwohl "
-"bereits in HEAD gemerged."
+"Zweig \"%s\" wird nicht gel=C3=B6scht, da dieser noch nicht in \"%s\"=
 gemerged ist, obwohl "
+"bereits in HEAD vorhanden."
=20
 #. TRANSLATORS: This is "remote " in "remote branch '%s' not found"
 #: builtin/branch.c:161
@@ -467,12 +455,12 @@ msgstr "Konnte Commit-Objekt f=C3=BCr HEAD nicht =
finden"
 #: builtin/branch.c:180
 #, c-format
 msgid "Cannot delete the branch '%s' which you are currently on."
-msgstr "Aktive Branch \"%s\" nicht l=C3=B6schbar."
+msgstr "Aktiver Zweig \"%s\" nicht l=C3=B6schbar."
=20
 #: builtin/branch.c:190
 #, c-format
 msgid "%sbranch '%s' not found."
-msgstr "%sBranch \"%s\" nicht gefunden."
+msgstr "%sZweig \"%s\" nicht gefunden."
=20
 #: builtin/branch.c:198
 #, c-format
@@ -485,18 +473,18 @@ msgid ""
 "The branch '%s' is not fully merged.\n"
 "If you are sure you want to delete it, run 'git branch -D %s'."
 msgstr ""
-"Die Branch \"%s\" ist nicht komplett gemerged.\n"
+"Der Zweig \"%s\" ist nicht komplett gemerged.\n"
 "L=C3=B6schung mittels `git branch -D %s` erzwingbar."
=20
 #: builtin/branch.c:212
 #, c-format
 msgid "Error deleting %sbranch '%s'"
-msgstr "Fehler beim L=C3=B6schen von %sBranch \"%s\""
+msgstr "Fehler beim L=C3=B6schen des %sZweiges \"%s\""
=20
 #: builtin/branch.c:217
 #, c-format
 msgid "Deleted %sbranch %s (was %s).\n"
-msgstr "%sBranch \"%s\" gel=C3=B6scht (war %s).\n"
+msgstr "%sZweig \"%s\" gel=C3=B6scht (war %s).\n"
=20
 #: builtin/branch.c:222
 msgid "Update of config-file failed"
@@ -505,7 +493,7 @@ msgstr "Konfigurationsdatei konnte nicht aktualisie=
rt werden"
 #: builtin/branch.c:304
 #, c-format
 msgid "branch '%s' does not point at a commit"
-msgstr "Branch \"%s\" zeigt nicht auf einen Commit"
+msgstr "Zweig \"%s\" zeigt auf keinen Commit"
=20
 #: builtin/branch.c:376
 #, c-format
@@ -524,44 +512,44 @@ msgstr "um %d voraus, um %d hinterher] "
=20
 #: builtin/branch.c:483
 msgid "(no branch)"
-msgstr "(keine Branch)"
+msgstr "(kein Zweig)"
=20
 #: builtin/branch.c:543
 msgid "some refs could not be read"
-msgstr "einige Eintr=C3=A4ge konnten nicht gelesen werden"
+msgstr "einige Referenzen konnten nicht gelesen werden"
=20
 #: builtin/branch.c:556
 msgid "cannot rename the current branch while not on any."
-msgstr "kann die aktuelle Branch nicht umbenennen, wenn man auf keiner=
 ist"
+msgstr "kann den aktuellen Zweig nicht umbenennen, wenn man auf keinem=
 ist."
=20
 #: builtin/branch.c:566 builtin/branch.c:570
 #, c-format
 msgid "Invalid branch name: '%s'"
-msgstr "Ung=C3=BCltiger Name f=C3=BCr Branch: \"%s\""
+msgstr "Ung=C3=BCltiger Name f=C3=BCr Zweig: \"%s\""
=20
 #: builtin/branch.c:573
 #, c-format
 msgid "A branch named '%s' already exists."
-msgstr "Eine Branch namens \"%s\" gibt es bereits."
+msgstr "Einen Zweig namens \"%s\" gibt es bereits."
=20
 #: builtin/branch.c:579
 msgid "Branch rename failed"
-msgstr "Umbenennung der Branch fehlgeschlagen"
+msgstr "Umbenennung des Zweigs fehlgeschlagen"
=20
 #: builtin/branch.c:583
 #, c-format
 msgid "Renamed a misnamed branch '%s' away"
-msgstr "Ung=C3=BCltiger Branchname \"%s\" durch Umbenennen in Ordnung =
gebracht"
+msgstr "Ung=C3=BCltiger Zweigname \"%s\" durch Umbenennen in Ordnung g=
ebracht"
=20
 #: builtin/branch.c:587
 #, c-format
 msgid "Branch renamed to %s, but HEAD is not updated!"
-msgstr "Branch in %s umbenannt, aber HEAD nicht aktualisiert!"
+msgstr "Zweig in %s umbenannt, aber HEAD nicht aktualisiert!"
=20
 #: builtin/branch.c:594
 msgid "Branch is renamed, but update of config-file failed"
 msgstr ""
-"Branch wurde umbenannt, aber die Konfigurationsdatei konnte nicht "
+"Zweig wurde umbenannt, aber die Konfigurationsdatei konnte nicht "
 "aktualisiert werden"
=20
 #: builtin/branch.c:609
@@ -575,13 +563,13 @@ msgstr "Konnte HEAD nicht als g=C3=BCltige Refere=
nze aufl=C3=B6sen."
=20
 #: builtin/branch.c:689
 msgid "HEAD not found below refs/heads!"
-msgstr "HEAD zeigt nicht auf eine Referenz unter refs/heads!"
+msgstr "HEAD zeigt nicht auf eine Referenz unter refs/heads/!"
=20
 #: builtin/branch.c:709
 msgid "-a and -r options to 'git branch' do not make sense with a bran=
ch name"
 msgstr ""
 "Die Optionen -a und -r f=C3=BCr `git branch` ergeben zusammen mit ein=
em "
-"Branchnamen keinen Sinn"
+"Zweignamen keinen Sinn"
=20
 #: builtin/bundle.c:47
 #, c-format
@@ -665,27 +653,27 @@ msgstr "HEAD zeigt jetzt auf"
 #: builtin/checkout.c:563
 #, c-format
 msgid "Already on '%s'\n"
-msgstr "Bereits auf Branch \"%s\"\n"
+msgstr "Bereits auf Zweig \"%s\"\n"
=20
 #: builtin/checkout.c:567
 #, c-format
 msgid "Switched to and reset branch '%s'\n"
-msgstr "Zu Branch \"%s\" gewechselt und Inhalt =C3=BCberschrieben\n"
+msgstr "Zum Zweig \"%s\" gewechselt und Inhalte =C3=BCberschrieben\n"
=20
 #: builtin/checkout.c:569
 #, c-format
 msgid "Switched to a new branch '%s'\n"
-msgstr "Zu neuer Branch \"%s\" gewechselt\n"
+msgstr "Zu neuem Zweig \"%s\" gewechselt\n"
=20
 #: builtin/checkout.c:571
 #, c-format
 msgid "Switched to branch '%s'\n"
-msgstr "Zu Branch \"%s\" gewechselt\n"
+msgstr "Zum Zweig \"%s\" gewechselt\n"
=20
 #: builtin/checkout.c:651
 #, c-format
 msgid " ... and %d more.\n"
-msgstr ""
+msgstr " ... und %d weitere.\n"
=20
 #. The singular version
 #: builtin/checkout.c:657
@@ -701,7 +689,13 @@ msgid_plural ""
 "\n"
 "%s\n"
 msgstr[0] ""
+"Warnung: Du hinterl=C3=A4sst %d Commit, der =C3=BCber keinen deiner Z=
weige erreichbar ist:\n"
+"\n"
+"%s\n"
 msgstr[1] ""
+"Warnung: Du hinterl=C3=A4sst %d Commits, die =C3=BCber keinen deiner =
Zweige erreichbar sind:\n"
+"\n"
+"%s\n"
=20
 #: builtin/checkout.c:675
 #, c-format
@@ -712,14 +706,19 @@ msgid ""
 " git branch new_branch_name %s\n"
 "\n"
 msgstr ""
+"Wenn diese mittels eines neuen Zweiges behalten werden sollen, so bie=
tet\n"
+"sich dies jetzt an:\n"
+"\n"
+" git branch new_branch_name %s\n"
+"\n"
=20
 #: builtin/checkout.c:700
 msgid "internal error: only -- alone should have been left"
-msgstr ""
+msgstr "Interner Fehler: nur \"--\" selbst sollte =C3=BCbrig bleiben"
=20
 #: builtin/checkout.c:702
 msgid "internal error in revision walk"
-msgstr ""
+msgstr "Interner Fehler beim Durchsuchen der Revisionen"
=20
 #: builtin/checkout.c:706
 msgid "Previous HEAD position was"
@@ -727,7 +726,7 @@ msgstr "HEAD zeigte vorher auf"
=20
 #: builtin/checkout.c:731
 msgid "You are on a branch yet to be born"
-msgstr "Die aktive Branch ist noch nicht angelegt"
+msgstr "Der aktive Zweig ist noch nicht angelegt"
=20
 #. case (1)
 #: builtin/checkout.c:859
@@ -750,22 +749,20 @@ msgid "--patch is incompatible with all other opt=
ions"
 msgstr "--patch kann mit keinen weiteren Optionen kombiniert werden"
=20
 #: builtin/checkout.c:977
-#, fuzzy
 msgid "--detach cannot be used with -b/-B/--orphan"
-msgstr "--cached kann nicht mit --no-index kombiniert werden."
+msgstr "--detach kann nicht mit -b/-B/--orphan kombiniert werden"
=20
 #: builtin/checkout.c:979
-#, fuzzy
 msgid "--detach cannot be used with -t"
-msgstr "--orphan kann nicht mit -t kombiniert werden"
+msgstr "--detach kann nicht mit -t kombiniert werden"
=20
 #: builtin/checkout.c:985
 msgid "--track needs a branch name"
-msgstr "--track ben=C3=B6tigt einen Branchnamen"
+msgstr "--track ben=C3=B6tigt einen Zweignamen"
=20
 #: builtin/checkout.c:992
 msgid "Missing branch name; try -b"
-msgstr "Fehlender Branchname; versuch's mit -b"
+msgstr "Fehlender Zweigname; versuch's mit -b"
=20
 #: builtin/checkout.c:998
 msgid "--orphan and -b|-B are mutually exclusive"
@@ -789,21 +786,19 @@ msgid ""
 "git checkout: updating paths is incompatible with switching branches.=
\n"
 "Did you intend to checkout '%s' which can not be resolved as commit?"
 msgstr ""
-"git checkout: Pfade aktualisieren und Branchwechsel kann nicht\n"
+"git checkout: Pfade aktualisieren und den Zweig wechseln kann nicht\n=
"
 "kombiniert werden. Sollte \"%s\" (das aber nicht als Commit\n"
 "gefunden werden konnte) ausgecheckt werden?"
=20
 #: builtin/checkout.c:1054
 msgid "git checkout: updating paths is incompatible with switching bra=
nches."
 msgstr ""
-"git checkout: Pfade aktualisieren kann nicht mit Branchwechsel kombin=
iert "
+"git checkout: Pfade aktualisieren kann nicht mit Wechsel des Zweiges =
kombiniert "
 "werden."
=20
 #: builtin/checkout.c:1059
-#, fuzzy
 msgid "git checkout: --detach does not take a path argument"
-msgstr ""
-"fetch --all akzeptiert keine explizite Angabe eines Ursprungs-Reposit=
orys"
+msgstr "git checkout: --detach akzeptiert keinen Pfad"
=20
 #: builtin/checkout.c:1062
 msgid ""
@@ -817,20 +812,20 @@ msgstr ""
 #: builtin/checkout.c:1073
 #, c-format
 msgid "git checkout: we do not like '%s' as a branch name."
-msgstr "git checkout: \"%s\" ist kein g=C3=BCltiger Branchname."
+msgstr "git checkout: \"%s\" ist kein g=C3=BCltiger Zweigname."
=20
 #: builtin/checkout.c:1078
 #, c-format
 msgid "git checkout: branch %s already exists"
-msgstr "git checkout: Branch \"%s\" existiert bereits"
+msgstr "git checkout: Zweig \"%s\" existiert bereits"
=20
 #: builtin/checkout.c:1085
 msgid "Cannot switch branch to a non-commit."
-msgstr "Kann Branch nicht auf etwas anderes als einen Commit umsetzen.=
"
+msgstr "Kann Zweig nicht auf etwas anderes als einen Commit umsetzen."
=20
 #: builtin/checkout.c:1088
 msgid "--ours/--theirs is incompatible with switching branches."
-msgstr "--ours/--theirs k=C3=B6nnen nicht beim Branchwechsel benutzt w=
erden."
+msgstr "--ours/--theirs k=C3=B6nnen beim Zweigwechsel nicht benutzt we=
rden."
=20
 #: builtin/clean.c:78
 msgid "-x and -X cannot be used together"
@@ -862,7 +857,7 @@ msgid "Removing %s\n"
 msgstr "Entferne %s\n"
=20
 #: builtin/clean.c:161 builtin/clean.c:181
-#, fuzzy, c-format
+#, c-format
 msgid "failed to remove %s"
 msgstr "konnte \"%s\" nicht entfernen"
=20
@@ -940,13 +935,13 @@ msgid "--bare and --origin %s options are incompa=
tible."
 msgstr "--bare kann nicht mit --origin %s kombiniert werden."
=20
 #: builtin/clone.c:420
-#, fuzzy, c-format
+#, c-format
 msgid "repository '%s' does not exist"
-msgstr "ung=C3=BCltiges Repository \"%s\""
+msgstr "Repository \"%s\" existiert nicht"
=20
 #: builtin/clone.c:425
 msgid "--depth is ignored in local clones; use file:// instead."
-msgstr ""
+msgstr "--depth wird in lokalen Clones ignoriert; verwende stattdessen=
 file://."
=20
 #: builtin/clone.c:435
 #, c-format
@@ -969,14 +964,14 @@ msgid "could not create work tree dir '%s'."
 msgstr "konnte Verzeichnis \"%s\" im Arbeitsverzeichnis nicht anlegen.=
"
=20
 #: builtin/clone.c:480
-#, fuzzy, c-format
+#, c-format
 msgid "Cloning into bare repository %s...\n"
-msgstr "Klone nach Lager-Repository %s\n"
+msgstr "Klone nach Lager-Repository %s...\n"
=20
 #: builtin/clone.c:482
-#, fuzzy, c-format
+#, c-format
 msgid "Cloning into %s...\n"
-msgstr "Klone nach %s\n"
+msgstr "Klone nach %s...\n"
=20
 #: builtin/clone.c:540
 #, c-format
@@ -987,7 +982,7 @@ msgstr "Keine Ahnung, wie man %s klont"
 #, c-format
 msgid "Remote branch %s not found in upstream %s, using HEAD instead"
 msgstr ""
-"Remote-Branch %s nicht in Ursprung %s gefunden, verwende stattdessen =
HEAD"
+"Remote-Zweig %s nicht in Ursprung %s gefunden, verwende stattdessen H=
EAD"
=20
 #: builtin/clone.c:589
 msgid "You appear to have cloned an empty repository."
@@ -1000,7 +995,6 @@ msgstr ""
 "vornehmen.\n"
=20
 #: builtin/commit.c:41
-#, fuzzy
 msgid ""
 "Your name and email address were configured automatically based\n"
 "on your username and hostname. Please check that they are accurate.\n=
"
@@ -1013,18 +1007,16 @@ msgid ""
 "\n"
 "    git commit --amend --reset-author\n"
 msgstr ""
-"Name und E-Mail-Adresse wurden automatisch aus deinem Benutzernamen u=
nd "
+"Name und E-Mail-Adresse wurden automatisch aus deinem Benutzer- und "
 "Hostnamen =C3=BCbernommen. Pr=C3=BCfe, ob diese korrekt sind.\n"
-"Diese Nachricht kann mittels expliziter Konfiguration unterdr=C3=BCck=
t werden:\n"
+"Diese Warnmeldung kann mittels expliziter Konfiguration unterdr=C3=BC=
ckt werden:\n"
 "\n"
 "    git config --global user.name \"Vorname Nachname\"\n"
 "    git config --global user.email ich@example.de\n"
 "\n"
-"Falls die Angaben f=C3=BCr diesen Commit falsch sind, k=C3=B6nnen sie=
 mittels\n"
-"\n"
-"    git commit --amend --author=3D\"Vorname Nachname <ich@example.de>=
\"\n"
+"Nachdem dies durchgef=C3=BChrt ist, kann die Identit=C3=A4t f=C3=BCr =
diesen Commit korrigiert werden:\n"
 "\n"
-"nachtr=C3=A4glich korrigiert werden.\n"
+"    git commit --amend --reset-author\n"
=20
 #: builtin/commit.c:53
 msgid ""
@@ -1045,15 +1037,20 @@ msgid ""
 "\n"
 "Otherwise, please use 'git reset'\n"
 msgstr ""
+"Der vorhergehende Cherry-Pick ist nun leer, wom=C3=B6glich durch Konf=
liktl=C3=B6sung.\n"
+"Falls dennoch ein Commit gew=C3=BCnscht ist, verwende:\n"
+"\n"
+"    git commit --allow-empty\n"
+"\n"
+"Verwende ansonsten `git reset`\n"
=20
 #: builtin/commit.c:318
 msgid "failed to unpack HEAD tree object"
 msgstr "konnte das HEAD-Baum-Objekt nicht entpacken"
=20
 #: builtin/commit.c:359
-#, fuzzy
 msgid "unable to create temporary index"
-msgstr "kann keine tempor=C3=A4re Indexdatei anlegen"
+msgstr "kann keinen tempor=C3=A4ren Index anlegen"
=20
 #: builtin/commit.c:365
 msgid "interactive add failed"
@@ -1064,9 +1061,9 @@ msgid "unable to write new_index file"
 msgstr "konnte new_index-Datei nicht anlegen"
=20
 #: builtin/commit.c:447
-#, fuzzy, c-format
+#, c-format
 msgid "cannot do a partial commit during a %s."
-msgstr "kann keinen partiellen Commit w=C3=A4hrend eines Merges durchf=
=C3=BChren."
+msgstr "kann keinen partiellen Commit w=C3=A4hrend eines %s durchf=C3=BC=
hren."
=20
 #: builtin/commit.c:456
 msgid "cannot read the index"
@@ -1090,9 +1087,9 @@ msgid "malformed --author parameter"
 msgstr "ung=C3=BCltiger --author-Parameter"
=20
 #: builtin/commit.c:622
-#, fuzzy, c-format
+#, c-format
 msgid "Malformed ident string: '%s'"
-msgstr "Ung=C3=BCltige Eingabezeile: \"%s\"."
+msgstr "Ung=C3=BCltige Identifikationsstring: \"%s\""
=20
 #: builtin/commit.c:656 builtin/commit.c:689 builtin/commit.c:989
 #, c-format
@@ -1140,7 +1137,7 @@ msgid "could not write commit template"
 msgstr "konnte Kommentarvorlage nicht anlegen"
=20
 #: builtin/commit.c:769
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "\n"
 "It looks like you may be committing a %s.\n"
@@ -1148,51 +1145,45 @@ msgid ""
 "\t%s\n"
 "and try again.\n"
 msgstr ""
-"#\n"
-"# Es scheint, als ob ein MERGE committet wird.\n"
-"# Falls das nicht stimmt, entferne die Datei\n"
-"#\t%s\n"
-"# und versuche es nochmal.\n"
-"#\n"
+"\n"
+"Es scheint, als ob ein %s committet wird.\n"
+"Falls dies nicht stimmt, entferne die Datei\n"
+"\t%s\n"
+"und versuche es nochmal.\n"
=20
 #: builtin/commit.c:782
-#, fuzzy
 msgid "Please enter the commit message for your changes."
-msgstr ""
-"\n"
-"# Gib einen Commit-Kommentar f=C3=BCr die =C3=84nderungen an."
+msgstr "Gib einen Commit-Kommentar f=C3=BCr die =C3=84nderungen an."
=20
 #: builtin/commit.c:785
-#, fuzzy
 msgid ""
 " Lines starting\n"
 "with '#' will be ignored, and an empty message aborts the commit.\n"
 msgstr ""
 " Zeilen, die mit '#'\n"
-"# anfangen, werden ignoriert, und ein leerer Kommentar bricht den Com=
mit "
+"anfangen, werden ignoriert. Ein leerer Kommentar bricht den Commit "
 "ab.\n"
=20
 #: builtin/commit.c:790
-#, fuzzy
 msgid ""
 " Lines starting\n"
 "with '#' will be kept; you may remove them yourself if you want to.\n=
"
 "An empty message aborts the commit.\n"
 msgstr ""
 " Zeilen, die mit '#'\n"
-"# anfangen, werden beibehalten; sie k=C3=B6nnen entfernen werden, wen=
n "
+"anfangen, werden beibehalten; sie k=C3=B6nnen entfernen werden, wenn =
"
 "gew=C3=BCnscht.\n"
-"# Ein leerer Kommentar bricht den Commit ab.\n"
+"Ein leerer Kommentar bricht den Commit ab.\n"
=20
 #: builtin/commit.c:802
-#, fuzzy, c-format
+#, c-format
 msgid "%sAuthor:    %s"
-msgstr "%s# Autor:     %s\n"
+msgstr "%sAutor:     %s"
=20
 #: builtin/commit.c:809
-#, fuzzy, c-format
+#, c-format
 msgid "%sCommitter: %s"
-msgstr "%s# Committer: %s\n"
+msgstr "%sCommitter: %s"
=20
 #: builtin/commit.c:829
 msgid "Cannot read index"
@@ -1226,35 +1217,31 @@ msgid "You have nothing to amend."
 msgstr "Es gibt nichts zum Nachbearbeiten."
=20
 #: builtin/commit.c:1034
-#, fuzzy, c-format
+#, c-format
 msgid "You are in the middle of a %s -- cannot amend."
-msgstr "Du bist mitten in einem Merge; Nachbearbeitung nicht m=C3=B6gl=
ich."
+msgstr "Du bist mitten in einem %s -- Nachbearbeitung nicht m=C3=B6gli=
ch."
=20
 #: builtin/commit.c:1036
-#, fuzzy
 msgid "Options --squash and --fixup cannot be used together"
-msgstr "-x und -X k=C3=B6nnen nicht zusammen verwendet werden"
+msgstr "Die Optionen --squash und --fixup k=C3=B6nnen nicht zusammen v=
erwendet werden"
=20
 #: builtin/commit.c:1046
-#, fuzzy
 msgid "Only one of -c/-C/-F/--fixup can be used."
-msgstr "Nur eine der Optionen -c, -C und -F kann auf einmal benutzt we=
rden."
+msgstr "Nur eine der Optionen -c, -C, -F und --fixup kann auf einmal b=
enutzt werden."
=20
 #: builtin/commit.c:1048
-#, fuzzy
 msgid "Option -m cannot be combined with -c/-C/-F/--fixup."
-msgstr "Option -m kann nicht mit -c, -C oder -F kombiniert werden."
+msgstr "Option -m kann nicht mit -c, -C, -F oder --fixup kombiniert we=
rden."
=20
 #: builtin/commit.c:1054
 msgid "--reset-author can be used only with -C, -c or --amend."
 msgstr "--reset-author kann nur mit -C, -c oder --amend benutzt werden=
=2E"
=20
 #: builtin/commit.c:1071
-#, fuzzy
 msgid "Only one of --include/--only/--all/--interactive/--patch can be=
 used."
 msgstr ""
-"Nur eine der Optionen --include, --only, --all und --interactive kann=
 auf "
-"einmal benutzt werden."
+"Nur eine der Optionen --include, --only, --all, --interactive und --p=
atch "
+"kann auf einmal benutzt werden."
=20
 #: builtin/commit.c:1073
 msgid "No paths with --include/--only does not make sense."
@@ -1481,7 +1468,7 @@ msgstr "[aktuell]"
 #: builtin/fetch.c:270
 #, c-format
 msgid "! %-*s %-*s -> %s  (can't fetch in current branch)"
-msgstr "! %-*s %-*s -> %s  (kann aktuelle Branch nicht =C3=BCberschrei=
ben)"
+msgstr "! %-*s %-*s -> %s  (kann aktuellen Zweig nicht =C3=BCberschrei=
ben)"
=20
 #: builtin/fetch.c:271 builtin/fetch.c:342
 msgid "[rejected]"
@@ -1501,7 +1488,7 @@ msgstr "[neuer Tag]"
=20
 #: builtin/fetch.c:298
 msgid "[new branch]"
-msgstr "[neue Branch]"
+msgstr "[neuer Zweig]"
=20
 #: builtin/fetch.c:338
 msgid "unable to update local ref"
@@ -1532,7 +1519,7 @@ msgid ""
 " 'git remote prune %s' to remove any old, conflicting branches"
 msgstr ""
 "einige lokale Referenzen konnten nicht aktualisiert werden; versuche,=
\n"
-"alte kollidierende Branches mit `git remote prune %s` zu entfernen"
+"alte kollidierende Zweige mit `git remote prune %s` zu entfernen"
=20
 #: builtin/fetch.c:500
 msgid "could not run rev-list"
@@ -1573,7 +1560,7 @@ msgstr "(nichts)"
 #: builtin/fetch.c:674
 #, c-format
 msgid "Refusing to fetch into current branch %s of non-bare repository=
"
-msgstr "=C3=9Cberschreiben der aktuellen Branch %s im Lager-Repository=
 verweigert"
+msgstr "=C3=9Cberschreiben des aktuellen Zweiges %s im Lager-Repositor=
y verweigert"
=20
 #: builtin/fetch.c:708
 #, c-format
@@ -1651,14 +1638,14 @@ msgstr ""
 "Automatische Komprimierung des Repositories f=C3=BCr optimale Perform=
ance.\n"
=20
 #: builtin/gc.c:226
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Auto packing the repository for optimum performance. You may also\n"
 "run \"git gc\" manually. See \"git help gc\" for more information.\n"
 msgstr ""
 "Automatische Komprimierung des Repositories f=C3=BCr optimale Perform=
ance. `git "
 "gc` kann auch manuell ausgef=C3=BChrt werden. Siehe `git help gc` f=C3=
=BCr weitere "
-"Informationen."
+"Informationen.\n"
=20
 #: builtin/gc.c:254
 msgid ""
@@ -1808,24 +1795,24 @@ msgid "insane git directory %s"
 msgstr "irrsinniges git-Verzeichnis %s"
=20
 #: builtin/init-db.c:322 builtin/init-db.c:325
-#, fuzzy, c-format
+#, c-format
 msgid "%s already exists"
-msgstr "Tag '%s' existiert bereits"
+msgstr "\"%s\" existiert bereits"
=20
 #: builtin/init-db.c:354
-#, fuzzy, c-format
+#, c-format
 msgid "unable to handle file type %d"
-msgstr "kann Baum nicht lesen (%s)"
+msgstr "Dateityp %d ist unbekannt"
=20
 #: builtin/init-db.c:357
-#, fuzzy, c-format
+#, c-format
 msgid "unable to move %s to %s"
-msgstr "konnte %s nicht schreiben"
+msgstr "konnte \"%s\" nicht nach \"%s\" verschieben"
=20
 #: builtin/init-db.c:362
-#, fuzzy, c-format
+#, c-format
 msgid "Could not create git link %s"
-msgstr "konnte Datei \"%s\" nicht anlegen"
+msgstr "Konnte den Git-Link \"%s\" nicht anlegen"
=20
 #.
 #. * TRANSLATORS: The first '%s' is either "Reinitialized
@@ -1987,7 +1974,7 @@ msgstr "Konnte Ausgabedateien nicht anlegen"
 msgid ""
 "Could not find a tracked remote branch, please specify <upstream> man=
ually.\n"
 msgstr ""
-"Konnte keine verfolgte Remote-Branch finden, bitte gib <Ursprung> sel=
bst "
+"Konnte keinen verfolgten Remote-Zweig finden, bitte gib <Ursprung> se=
lbst "
 "an.\n"
=20
 #: builtin/log.c:1474 builtin/log.c:1476 builtin/log.c:1488
@@ -2067,12 +2054,12 @@ msgstr "\"%s\" zeigt nicht auf einen Commit"
 #: builtin/merge.c:517
 #, c-format
 msgid "Bad branch.%s.mergeoptions string: %s"
-msgstr "Ung=C3=BCltige Branch.%s.mergeoptions string: %s"
+msgstr "Ung=C3=BCltiger String in branch.%s.mergeoptions: %s"
=20
 #: builtin/merge.c:550
 #, c-format
 msgid "%s: negative length %s"
-msgstr ""
+msgstr "%s: negative L=C3=A4nge: %s"
=20
 #: builtin/merge.c:609
 msgid "git write-tree failed to write a tree"
@@ -2107,7 +2094,7 @@ msgid "Could not open '%s' for writing"
 msgstr "Konnte \"%s\" nicht zum Schreiben =C3=B6ffnen"
=20
 #: builtin/merge.c:852
-#, fuzzy, c-format
+#, c-format
 msgid "Could not read from '%s'"
 msgstr "konnte \"%s\" nicht lesen"
=20
@@ -2129,27 +2116,25 @@ msgid "'%s' is not a commit"
 msgstr "\"%s\" ist kein Commit"
=20
 #: builtin/merge.c:992
-#, fuzzy
 msgid "No current branch."
-msgstr "Gegenw=C3=A4rtig auf keiner Branch."
+msgstr "Gegenw=C3=A4rtig auf keinem Zweig."
=20
 #: builtin/merge.c:994
-#, fuzzy
 msgid "No remote for the current branch."
-msgstr "Gegenw=C3=A4rtig auf keiner Branch."
+msgstr "Kein Remote f=C3=BCr den aktuellen Zweig gesetzt."
=20
 #: builtin/merge.c:996
 msgid "No default upstream defined for the current branch."
-msgstr ""
+msgstr "Kein Standard-Ursprung f=C3=BCr den aktuellen Zweig definiert.=
"
=20
 #: builtin/merge.c:1001
 #, c-format
 msgid "No remote tracking branch for %s from %s"
-msgstr ""
+msgstr "Kein verfolgter Remotezweig f=C3=BCr %s von %s"
=20
 #: builtin/merge.c:1053
 msgid "There is no merge to abort (MERGE_HEAD missing)."
-msgstr ""
+msgstr "Es gibt keinen Merge, den man abbrechen k=C3=B6nnte (MERGE_HEA=
D fehlt)."
=20
 #: builtin/merge.c:1068 git-pull.sh:31
 msgid ""
@@ -2157,25 +2142,23 @@ msgid ""
 "Please, commit your changes before you can merge."
 msgstr ""
 "Du hast deinen Merge nicht abgeschlossen (MERGE_HEAD existiert).\n"
-"Committe die =C3=84nderungen, bevor du einen weiteren Merge startest.=
"
+"Bevor du einen weiteren Merge beginnen kannst, m=C3=BCssen die =C3=84=
nderungen committed werden."
=20
 #: builtin/merge.c:1071 git-pull.sh:34
 msgid "You have not concluded your merge (MERGE_HEAD exists)."
 msgstr "Du hast deinen Merge nicht abgeschlossen (MERGE_HEAD existiert=
)."
=20
 #: builtin/merge.c:1075
-#, fuzzy
 msgid ""
 "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 "Please, commit your changes before you can merge."
 msgstr ""
-"Du hast deinen Merge nicht abgeschlossen (MERGE_HEAD existiert).\n"
-"Committe die =C3=84nderungen, bevor du einen weiteren Merge startest.=
"
+"Du hast deinen Cherry-Pick nicht abgeschlossen (CHERRY_PICK_HEAD exis=
tiert).\n"
+"Bevor du mergen kannst, m=C3=BCssen =C3=84nderungen committed werden.=
"
=20
 #: builtin/merge.c:1078
-#, fuzzy
 msgid "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exist=
s)."
-msgstr "Du hast deinen Merge nicht abgeschlossen (MERGE_HEAD existiert=
)."
+msgstr "Du hast deinen Cherry-Pick nicht abgeschlossen (CHERRY_PICK_HE=
AD existiert)."
=20
 #: builtin/merge.c:1087
 msgid "You cannot combine --squash with --no-ff."
@@ -2495,6 +2478,10 @@ msgid ""
 "\n"
 "    git push %s HEAD:<name-of-remote-branch>\n"
 msgstr ""
+"Du bist gegenw=C3=A4rtig auf keinem Zweig.\n"
+"Um die zu dem aktuellen Zustand (freistehender HEAD) f=C3=BChrende Hi=
storie nun zu senden, verwende\n"
+"\n"
+"    git push %s HEAD:<Name des Remotezweigs>\n"
=20
 #: builtin/push.c:79
 #, c-format
@@ -2504,12 +2491,16 @@ msgid ""
 "\n"
 "    git push --set-upstream %s %s\n"
 msgstr ""
+"Der aktuelle Zweig %s hat keinen zugeh=C3=B6rigen Ursprungszweig.\n"
+"Um den aktuellen Zweig zu senden und den Remote als Ursprung zu setze=
n, verwende\n"
+"\n"
+"    git push --set-upstream %s %s\n"
=20
 #: builtin/push.c:87
-#, fuzzy, c-format
+#, c-format
 msgid "The current branch %s has multiple upstream branches, refusing =
to push."
 msgstr ""
-"Die aktuelle Branch %s verfolgt mehrere Branches, daher \"push\" verw=
eigert."
+"Der aktuelle Zweig %s hat mehrere Ursprungszweige, daher wird das Sen=
den verweigert."
=20
 #: builtin/push.c:110
 msgid ""
@@ -2559,6 +2550,14 @@ msgid ""
 "\n"
 "    git push <name>\n"
 msgstr ""
+"Kein konfiguriertes Sendeziel.\n"
+"Gib entweder die URL auf der Kommandozeile an, oder setze ein Remote-=
Repository mittels\n"
+"\n"
+"    git remote add <name> <url>\n"
+"\n"
+"und sende dann unter Verwendung des Remote-Namens\n"
+"\n"
+"    git push <name>\n"
=20
 #: builtin/push.c:175
 msgid "--all and --tags are incompatible"
@@ -2715,18 +2714,14 @@ msgstr ""
 "Committe oder stashe die =C3=84nderungen um fortzufahren."
=20
 #: builtin/revert.c:283
-#, fuzzy
 msgid "Your local changes would be overwritten by revert.\n"
 msgstr ""
-"Lokale =C3=84nderungen w=C3=BCrden durch revert =C3=BCberschrieben we=
rden.\n"
-"Committe oder stashe die =C3=84nderungen um fortzufahren."
+"Lokale =C3=84nderungen w=C3=BCrden durch den Revert =C3=BCberschriebe=
n werden.\n"
=20
 #: builtin/revert.c:285
-#, fuzzy
 msgid "Your local changes would be overwritten by cherry-pick.\n"
 msgstr ""
-"Lokale =C3=84nderungen w=C3=BCrden durch cherry-pick =C3=BCberschrieb=
en werden.\n"
-"Committe oder stashe die =C3=84nderungen um fortzufahren."
+"Lokale =C3=84nderungen w=C3=BCrden durch den Cherry-pick =C3=BCbersch=
rieben werden.\n"
=20
 #. TRANSLATORS: %s will be "revert" or "cherry-pick"
 #: builtin/revert.c:335
@@ -2789,9 +2784,9 @@ msgid "git %s: failed to read the index"
 msgstr "git %s: konnte den Index nicht auslesen"
=20
 #: builtin/revert.c:555
-#, fuzzy, c-format
+#, c-format
 msgid "git %s: failed to refresh the index"
-msgstr "git %s: konnte den Index nicht auslesen"
+msgstr "git %s: konnte den Index nicht aktualisieren"
=20
 #: builtin/revert.c:571
 msgid "cherry-pick --ff cannot be used with --signoff"
@@ -2981,6 +2976,8 @@ msgid ""
 "You seem to have moved HEAD since the last 'am' failure.\n"
 "Not rewinding to ORIG_HEAD"
 msgstr ""
+"Es scheint, als ob sich HEAD seit dem letzten Fehlschlagen von \"am\"=
 ge=C3=A4ndert hat.\n"
+"Zur=C3=BCcksetzung auf ORIG_HEAD daher ausgesetzt"
=20
 #: git-am.sh:105
 #, sh-format
@@ -2992,7 +2989,7 @@ msgstr ""
 "Sobald das Problem gel=C3=B6st ist, f=C3=BChre \\`$cmdline --resolved=
``` aus.\n"
 "Soll dieser Patch stattdessen =C3=BCbersprungen werden, verwende \\`$=
cmdline --"
 "skip\\`.\n"
-"Um die urspr=C3=BCngliche Branch wiederherzustellen und den Patchvorg=
ang zu "
+"Um den urspr=C3=BCnglichen Zweig wiederherzustellen und den Patchvorg=
ang zu "
 "stoppen, verwende \\`$cmdline --abort\\`."
=20
 #: git-am.sh:121
@@ -3013,9 +3010,8 @@ msgstr ""
 "Er passt nicht auf die in dessen Index angegebenen Blobs."
=20
 #: git-am.sh:154
-#, fuzzy
 msgid "Falling back to patching base and 3-way merge..."
-msgstr "Kann den 3-Wege-Merge auch nicht durchf=C3=BChren."
+msgstr "Greife zur=C3=BCck auf: Basis patchen und dann 3-Wege-Merge...=
"
=20
 #: git-am.sh:261
 msgid "Only one StGIT patch series can be applied at once"
@@ -3063,8 +3059,8 @@ msgid ""
 msgstr ""
 "Der Patch ist leer. Wurde er falsch aufgeteilt?\n"
 "=C3=9Cberspringen des Patches mittels \\\\`$cmdline --skip\\\\`.\n"
-"Um die urspr=C3=BCngle Branch wiederherstellen und den Patchvorgang z=
u stoppen, "
-"verwendet \\\\`$cmdline --abort\\\\`."
+"Um den urspr=C3=BCnglichen Zweig wiederherzustellen und den Patchvorg=
ang zu stoppen, "
+"verwende \\\\`$cmdline --abort\\\\`."
=20
 #: git-am.sh:651
 msgid "Patch does not have a valid e-mail address."
@@ -3225,10 +3221,12 @@ msgid ""
 "Could not check out original HEAD '$branch'.\n"
 "Try 'git bisect reset <commit>'."
 msgstr ""
+"Konnte den urspr=C3=BCnglichen HEAD ($branch) nicht wieder auschecken=
=2E\n"
+"Versuche `git bisect reset <commit>`."
=20
 #: git-bisect.sh:371
 msgid "No logfile given"
-msgstr ""
+msgstr "Keine Logdatei angegeben"
=20
 #: git-bisect.sh:372
 #, sh-format
@@ -3286,7 +3284,7 @@ msgstr "Pull ist nicht m=C3=B6glich, da noch Konf=
likte in Dateien bestehen."
=20
 #: git-pull.sh:189
 msgid "updating an unborn branch with changes added to the index"
-msgstr "Update eine ungeborene Branch mit =C3=84nderungen aus dem/in d=
en(?) Index"
+msgstr "Update einen ungeborenen Zweig mit =C3=84nderungen aus dem/in =
den(?) Index"
=20
 #. The fetch involved updating the current branch.
 #. The working tree and the index file is still based on the
@@ -3299,7 +3297,7 @@ msgid ""
 "Warning: fast-forwarding your working tree from\n"
 "Warning: commit $orig_head."
 msgstr ""
-"Warnung: fetch aktualisierte den aktuellen Branch-HEAD.\n"
+"Warnung: Fetch aktualisierte den aktuellen Zweig.\n"
 "Warnung: Update der Arbeitskopie von Commit $orig_head aus ohne Merge=
=2E"
=20
 # Die Originalumschreibung "exactly one commit" ist irref=C3=BChrend; =
es geht
@@ -3310,7 +3308,7 @@ msgstr "Kann nur exakt eine Historie in einen lee=
ren HEAD mergen"
=20
 #: git-pull.sh:252
 msgid "Cannot rebase onto multiple branches"
-msgstr "Kann nicht auf mehrere Branches rebasen"
+msgstr "Kann nicht auf mehrere Zweige rebasen"
=20
 #: git-stash.sh:43
 msgid "git stash clear with parameters is unimplemented"
@@ -3383,9 +3381,8 @@ msgid "'$args' is not a stash reference"
 msgstr "\\\"$args\\\" ist keine Stash-Referenz"
=20
 #: git-stash.sh:359
-#, fuzzy
 msgid "unable to refresh index"
-msgstr "Konnte den Index nicht anlegen."
+msgstr "konnte den Index nicht aktualisieren"
=20
 #: git-stash.sh:363
 msgid "Cannot apply a stash in the middle of a merge"
@@ -3419,7 +3416,7 @@ msgstr "$REV: Konnte Stash-Eintrag nicht verwerfe=
n"
=20
 #: git-stash.sh:441
 msgid "No branch name specified"
-msgstr "Kein Branchname angegeben"
+msgstr "Kein Zweigname angegeben"
=20
 #: git-stash.sh:512
 msgid "(To restore them type \"git stash apply\")"
@@ -3433,7 +3430,7 @@ msgstr "F=C3=BCr Remote ($remote) ist in .git/con=
fig keine URL definiert"
 #: git-submodule.sh:56
 #, sh-format
 msgid "cannot strip one component off url '$remoteurl'"
-msgstr ""
+msgstr "Kann keinen Teil von der URL \"$remoteurl\" abtrennen"
=20
 #: git-submodule.sh:108
 #, sh-format
@@ -3553,9 +3550,9 @@ msgid "Submodule path '$path': rebased into '$sha=
1'"
 msgstr "Submodul-Pfad \"$path\": auf \"$sha1\" rebased"
=20
 #: git-submodule.sh:522
-#, fuzzy, sh-format
+#, sh-format
 msgid "Unable to merge '$sha1' in submodule path '$path'"
-msgstr "Kann nicht auf \"$sha1\" im Submodul-Pfad \"$path\" rebasen"
+msgstr "Kann \"$sha1\" im Submodul-Pfad \"$path\" nicht mergen"
=20
 #: git-submodule.sh:523
 #, sh-format
@@ -3563,9 +3560,9 @@ msgid "Submodule path '$path': merged in '$sha1'"
 msgstr "Submodul-Pfad \"$path\": \"$sha1\" wurde gemerged"
=20
 #: git-submodule.sh:527
-#, fuzzy, sh-format
+#, sh-format
 msgid "Unable to checkout '$sha1' in submodule path '$path'"
-msgstr "Kann nicht auf \"$sha1\" im Submodul-Pfad \"$path\" rebasen"
+msgstr "Kann nicht auf \"$sha1\" im Submodul-Pfad \"$path\" wechseln"
=20
 #: git-submodule.sh:528
 #, sh-format
--=20
1.7.6.3

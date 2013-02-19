From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCHv2] l10n: de.po: translate 35 new messages
Date: Tue, 19 Feb 2013 17:55:22 +0100
Message-ID: <1361292922-3383-1-git-send-email-ralf.thielow@gmail.com>
References: <1361211754-5641-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@jk.gs, stimming@tuhh.de, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, git@drmicha.warpmail.net
X-From: git-owner@vger.kernel.org Tue Feb 19 17:55:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7qTy-0004RX-PF
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 17:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790Ab3BSQza convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Feb 2013 11:55:30 -0500
Received: from mail-bk0-f44.google.com ([209.85.214.44]:60147 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932600Ab3BSQz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 11:55:29 -0500
Received: by mail-bk0-f44.google.com with SMTP id j4so3140693bkw.3
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 08:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=5evE2wjtyk/jFY3rHIldeCbLWjPjDqHGxcUlSKthAd0=;
        b=sO7m1bTePWqVYhMj38FuxITIJUlQJ9RL8Y79N43T7mctQHJdkJQq+S+ObsK2cW3t4M
         6rdzlpT1QvlpAVZXaBPzyyWus3rpNWioL8zTiGuYisbGcwhJomDHywWGEO9fOmH+GLQh
         WZEnaXGfRZaNck0HxQUIGhNUFdC8mZFblKuJXsVwXdgVWglG+l7yDcCUmgw1XI0ZhZdV
         +nP8MZ8UrqJGajght4DQqaoVaoj1Dzi+WBmZrgaIPygZCP/av8BJlz8eH861EKoT+EvY
         6R8kjJaAAuTmGuf6vBa0AuhVnf/wWK0TBQfEdu6oUNg+RVoQZ5iILKzdGDfUxxMTRUVW
         7XVA==
X-Received: by 10.204.4.201 with SMTP id 9mr6978275bks.39.1361292928234;
        Tue, 19 Feb 2013 08:55:28 -0800 (PST)
Received: from localhost (dslb-094-223-176-203.pools.arcor-ip.net. [94.223.176.203])
        by mx.google.com with ESMTPS id ge12sm22385098bkc.19.2013.02.19.08.55.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Feb 2013 08:55:27 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.16.g20a599e
In-Reply-To: <1361211754-5641-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216633>

Translate 35 new messages came from git.pot update
in 9caaf23 (l10n: Update git.pot (35 new, 14 removed
messages)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
Acked-by: Thomas Rast <trast@inf.ethz.ch>
---

Thanks Thomas and Michael for review.

 po/de.po | 142 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 69 insertions(+), 73 deletions(-)

diff --git a/po/de.po b/po/de.po
index df98a0f..cd2d116 100644
--- a/po/de.po
+++ b/po/de.po
@@ -358,14 +358,14 @@ msgid "gpg failed to sign the data"
 msgstr "gpg beim Signieren der Daten fehlgeschlagen"
=20
 #: gpg-interface.c:112
-#, fuzzy, c-format
+#, c-format
 msgid "could not create temporary file '%s': %s"
-msgstr "konnte Datei '%s' nicht erstellen"
+msgstr "konnte tempor=C3=A4re Datei '%s' nicht erstellen: %s"
=20
 #: gpg-interface.c:115
-#, fuzzy, c-format
+#, c-format
 msgid "failed writing detached signature to '%s': %s"
-msgstr "Fehler beim Erstellen des Pfades '%s'%s"
+msgstr "Fehler beim Schreiben der Signatur nach '%s': %s"
=20
 #: grep.c:1622
 #, c-format
@@ -1440,12 +1440,11 @@ msgstr ", hinterher "
 #: compat/precompose_utf8.c:58 builtin/clone.c:341
 #, c-format
 msgid "failed to unlink '%s'"
-msgstr "Konnte '%s' nicht entfernen"
+msgstr "Konnte '%s' nicht entfernen."
=20
 #: builtin/add.c:20
-#, fuzzy
 msgid "git add [options] [--] <pathspec>..."
-msgstr "git add [Optionen] [--] [<Dateimuster>...]"
+msgstr "git add [Optionen] [--] [<Pfadspezifikation>...]"
=20
 #: builtin/add.c:63
 #, c-format
@@ -1601,6 +1600,21 @@ msgid ""
 "With the current Git version, the command is restricted to the curren=
t "
 "directory."
 msgstr ""
+"Das Verhalten von 'git add %s (oder %s)' ohne ein Pfad-Argument von\n=
"
+"einem Unterverzeichnis aus wird in Git 2.0 ge=C3=A4ndert und sollte n=
icht\n"
+"mehr verwendet werden.\n"
+"Um Dateien des gesamten Projektverzeichnisses hinzuzuf=C3=BCgen, f=C3=
=BChren Sie aus:\n"
+"\n"
+"  git add %s :/\n"
+"  (oder git add %s :/)\n"
+"\n"
+"Zur Einschr=C3=A4nkung auf das aktuelle Verzeichnis f=C3=BChren Sie a=
us:\n"
+"\n"
+"  git add %s .\n"
+"  (oder git add %s .)\n"
+"\n"
+"Mit der aktuellen Version von Git ist das Kommando auf das aktuelle\n=
"
+"Verzeichnis beschr=C3=A4nkt."
=20
 #: builtin/add.c:381
 msgid "-A and -u are mutually incompatible"
@@ -2412,16 +2426,16 @@ msgstr "[%d voraus, %d hinterher]"
=20
 #: builtin/branch.c:469
 msgid " **** invalid ref ****"
-msgstr ""
+msgstr " **** ung=C3=BCltige Referenz ****"
=20
 #: builtin/branch.c:560
 msgid "(no branch)"
 msgstr "(kein Zweig)"
=20
 #: builtin/branch.c:593
-#, fuzzy, c-format
+#, c-format
 msgid "object '%s' does not point to a commit"
-msgstr "'%s' zeigt auf keine Version"
+msgstr "Objekt '%s' zeigt auf keine Version"
=20
 #: builtin/branch.c:625
 msgid "some refs could not be read"
@@ -2571,33 +2585,30 @@ msgid "--column and --verbose are incompatible"
 msgstr "Die Optionen --column und --verbose sind inkompatibel."
=20
 #: builtin/branch.c:845
-#, fuzzy
 msgid "branch name required"
-msgstr "Kein Zweigname spezifiziert"
+msgstr "Zweigname erforderlich"
=20
 #: builtin/branch.c:860
-#, fuzzy
 msgid "Cannot give description to detached HEAD"
-msgstr "Kann Hauptzweig des externen Projektarchivs nicht bestimmen"
+msgstr "zu losgel=C3=B6ster Zweigspitze (HEAD) kann keine Beschreibung=
 hinterlegt werden"
=20
 #: builtin/branch.c:865
-#, fuzzy
 msgid "cannot edit description of more than one branch"
-msgstr "bearbeitet die Beschreibung f=C3=BCr den Zweig"
+msgstr "Beschreibung von mehr als einem Zweig kann nicht bearbeitet we=
rden"
=20
 #: builtin/branch.c:872
-#, fuzzy, c-format
+#, c-format
 msgid "No commit on branch '%s' yet."
-msgstr "Kein solcher Zweig '%s'"
+msgstr "Noch keine Version in Zweig '%s'."
=20
 #: builtin/branch.c:875
-#, fuzzy, c-format
+#, c-format
 msgid "No branch named '%s'."
-msgstr "Ung=C3=BCltiger Zweig-Name: '%s'"
+msgstr "Zweig '%s' nicht vorhanden."
=20
 #: builtin/branch.c:888
 msgid "too many branches for a rename operation"
-msgstr ""
+msgstr "zu viele Zweige f=C3=BCr eine Umbenennen-Operation angegeben"
=20
 #: builtin/branch.c:893
 #, c-format
@@ -2731,28 +2742,24 @@ msgid "suppress progress reporting"
 msgstr "unterdr=C3=BCckt Fortschrittsanzeige"
=20
 #: builtin/check-ignore.c:151
-#, fuzzy
 msgid "cannot specify pathnames with --stdin"
-msgstr "kann -a nicht mit -d benutzen"
+msgstr "Angabe von Pfadnamen kann nicht gemeinsam mit --stdin verwende=
t werden"
=20
 #: builtin/check-ignore.c:154
 msgid "-z only makes sense with --stdin"
-msgstr ""
+msgstr "Die Option -z kann nur mit --stdin verwendet werden."
=20
 #: builtin/check-ignore.c:156
-#, fuzzy
 msgid "no path specified"
-msgstr "kein externes Projektarchiv angegeben"
+msgstr "kein Pfad angegeben"
=20
 #: builtin/check-ignore.c:160
-#, fuzzy
 msgid "--quiet is only valid with a single pathname"
-msgstr "verwendet [PATCH n/m] auch mit einzelnem Patch"
+msgstr "Die Option --quiet ist nur mit einem einzelnen Pfadnamen g=C3=BC=
ltig."
=20
 #: builtin/check-ignore.c:162
-#, fuzzy
 msgid "cannot have both --quiet and --verbose"
-msgstr "Kann den aktuellen Zustand der Bereitstellung nicht speichern"
+msgstr "Die Optionen --quiet und --verbose k=C3=B6nnen nicht gemeinsam=
 verwendet werden."
=20
 #: builtin/checkout-index.c:126
 msgid "git checkout-index [options] [--] [<file>...]"
@@ -3421,14 +3428,12 @@ msgid "--command must be the first argument"
 msgstr "Die Option --command muss an erster Stelle stehen."
=20
 #: builtin/commit.c:34
-#, fuzzy
 msgid "git commit [options] [--] <pathspec>..."
-msgstr "git commit [Optionen] [--] <Dateimuster>..."
+msgstr "git commit [Optionen] [--] <Pfadspezifikation>..."
=20
 #: builtin/commit.c:39
-#, fuzzy
 msgid "git status [options] [--] <pathspec>..."
-msgstr "git status [Optionen] [--] <Dateimuster>..."
+msgstr "git status [Optionen] [--] <Pfadspezifikation>..."
=20
 #: builtin/commit.c:44
 msgid ""
@@ -3604,17 +3609,17 @@ msgstr ""
 "und versuchen Sie es erneut.\n"
=20
 #: builtin/commit.c:735
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Please enter the commit message for your changes. Lines starting\n"
 "with '%c' will be ignored, and an empty message aborts the commit.\n"
 msgstr ""
 "Bitte geben Sie eine Versionsbeschreibung f=C3=BCr Ihre =C3=84nderung=
en ein. Zeilen,\n"
-"die mit '#' beginnen, werden ignoriert, und eine leere Versionsbeschr=
eibung\n"
+"die mit '%c' beginnen, werden ignoriert, und eine leere Versionsbesch=
reibung\n"
 "bricht die Eintragung ab.\n"
=20
 #: builtin/commit.c:740
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Please enter the commit message for your changes. Lines starting\n"
 "with '%c' will be kept; you may remove them yourself if you want to.\=
n"
@@ -3622,7 +3627,7 @@ msgid ""
 msgstr ""
 "Bitte geben Sie eine Versionsbeschreibung f=C3=BCr Ihre =C3=84nderung=
en ein. Zeilen, "
 "die\n"
-"mit '#' beginnen, werden beibehalten; wenn Sie m=C3=B6chten, k=C3=B6n=
nen Sie diese "
+"mit '%c' beginnen, werden beibehalten; wenn Sie m=C3=B6chten, k=C3=B6=
nnen Sie diese "
 "entfernen.\n"
 "Eine leere Versionsbeschreibung bricht die Eintragung ab.\n"
=20
@@ -4403,9 +4408,8 @@ msgid "deepen history of shallow clone"
 msgstr "vertieft die Historie eines flachen Klon"
=20
 #: builtin/fetch.c:86
-#, fuzzy
 msgid "convert to a complete repository"
-msgstr "um von einem lokalen Projektarchiv zu klonen"
+msgstr "konvertiert zu einem vollst=C3=A4ndigen Projektarchiv"
=20
 #: builtin/fetch.c:88 builtin/log.c:1119
 msgid "dir"
@@ -4561,14 +4565,13 @@ msgid "You need to specify a tag name."
 msgstr "Sie m=C3=BCssen den Namen der Markierung angeben."
=20
 #: builtin/fetch.c:981
-#, fuzzy
 msgid "--depth and --unshallow cannot be used together"
-msgstr "Die Optionen -x und -X k=C3=B6nnen nicht gemeinsam verwendet w=
erden."
+msgstr "Die Optionen --depth und --unshallow k=C3=B6nnen nicht gemeins=
am verwendet werden."
=20
 #: builtin/fetch.c:983
-#, fuzzy
 msgid "--unshallow on a complete repository does not make sense"
-msgstr "Die Option --name-only kann nicht verwendet werden."
+msgstr "Die Option --unshallow kann nicht in einem vollst=C3=A4ndigen =
Projektarchiv "
+"verwendet werden."
=20
 #: builtin/fetch.c:1002
 msgid "fetch --all does not take a repository argument"
@@ -6122,7 +6125,7 @@ msgstr ""
 "Zusammenf=C3=BChrung abzuschlie=C3=9Fen.\n"
=20
 #: builtin/merge.c:788
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Please enter a commit message to explain why this merge is necessary,=
\n"
 "especially if it merges an updated upstream into a topic branch.\n"
@@ -6135,7 +6138,7 @@ msgstr ""
 "insbesondere wenn es einen aktualisierten, externen Zweig mit einem T=
hema-"
 "Zweig zusammenf=C3=BChrt.\n"
 "\n"
-"Zeilen beginnend mit '#' werden ignoriert, und eine leere Beschreibun=
g "
+"Zeilen beginnend mit '%c' werden ignoriert, und eine leere Beschreibu=
ng "
 "bricht die Eintragung ab.\n"
=20
 #: builtin/merge.c:812
@@ -6606,9 +6609,8 @@ msgid "unable to start 'show' for object '%s'"
 msgstr "konnte 'show' f=C3=BCr Objekt '%s' nicht starten"
=20
 #: builtin/notes.c:143
-#, fuzzy
 msgid "could not read 'show' output"
-msgstr "Konnte '%s' nicht lesen"
+msgstr "Konnte Ausgabe von 'show' nicht lesen."
=20
 #: builtin/notes.c:151
 #, c-format
@@ -7213,7 +7215,6 @@ msgstr ""
 "f=C3=BCr weitere Details."
=20
 #: builtin/push.c:224
-#, fuzzy
 msgid ""
 "Updates were rejected because the remote contains work that you do\n"
 "not have locally. This is usually caused by another repository pushin=
g\n"
@@ -7221,18 +7222,18 @@ msgid ""
 "'git pull') before pushing again.\n"
 "See the 'Note about fast-forwards' in 'git push --help' for details."
 msgstr ""
-"Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze Ihres ak=
tuellen\n"
-"Zweiges hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen is=
t. F=C3=BChren Sie\n"
-"die externen =C3=84nderungen zusammen (z.B. 'git pull') bevor Sie ern=
eut\n"
-"versenden.\n"
+"Aktualisierungen wurden zur=C3=BCckgewiesen, weil das Fernarchiv Vers=
ionen enth=C3=A4lt,\n"
+"die lokal nicht vorhanden sind. Das wird =C3=BCblicherweise durch das=
 Versenden von\n"
+"Versionen auf dieselbe Referenz von einem anderen Projektarchiv aus v=
erursacht.\n"
+"Vielleicht m=C3=BCssen Sie die externen =C3=84nderungen zusammenzuf=C3=
=BChren (z.B. 'git pull')\n"
+"bevor Sie erneut versenden.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
 "f=C3=BCr weitere Details."
=20
 #: builtin/push.c:231
-#, fuzzy
 msgid "Updates were rejected because the tag already exists in the rem=
ote."
 msgstr ""
-"Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Zielreferenz be=
reits\n"
+"Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Markierung bere=
its\n"
 "im Fernarchiv existiert."
=20
 #: builtin/push.c:234
@@ -7241,6 +7242,9 @@ msgid ""
 "or update a remote ref to make it point at a non-commit object,\n"
 "without using the '--force' option.\n"
 msgstr ""
+"Sie k=C3=B6nnen keine externe Referenz aktualisieren, die auf ein Obj=
ekt zeigt,\n"
+"das keine Version ist, oder es auf ein solches Objekt zeigen lassen, =
ohne\n"
+"die Option '--force' zu verwenden.\n"
=20
 #: builtin/push.c:294
 #, c-format
@@ -7351,9 +7355,8 @@ msgid "prune locally removed refs"
 msgstr "entfernt lokal gel=C3=B6schte Referenzen"
=20
 #: builtin/push.c:439
-#, fuzzy
 msgid "bypass pre-push hook"
-msgstr "umgeht \"pre-commit hook\""
+msgstr "umgeht \"pre-push hook\""
=20
 #: builtin/push.c:448
 msgid "--delete is incompatible with --all, --mirror and --tags"
@@ -8536,20 +8539,18 @@ msgid "could not verify the tag '%s'"
 msgstr "Konnte Markierung '%s' nicht verifizieren"
=20
 #: builtin/tag.c:249
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "\n"
 "Write a tag message\n"
 "Lines starting with '%c' will be ignored.\n"
 msgstr ""
 "\n"
-"#\n"
-"# Geben Sie eine Markierungsbeschreibung ein.\n"
-"# Zeilen, die mit '#' beginnen, werden ignoriert.\n"
-"#\n"
+"Geben Sie eine Markierungsbeschreibung ein.\n"
+"Zeilen, die mit '%c' beginnen, werden ignoriert.\n"
=20
 #: builtin/tag.c:253
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "\n"
 "Write a tag message\n"
@@ -8557,11 +8558,9 @@ msgid ""
 "want to.\n"
 msgstr ""
 "\n"
-"#\n"
-"# Geben Sie eine Markierungsbeschreibung ein.\n"
-"# Zeilen, die mit '#' beginnen, werden behalten; Sie d=C3=BCrfen dies=
e\n"
-"# selbst entfernen wenn Sie m=C3=B6chten.\n"
-"#\n"
+"Geben Sie eine Markierungsbeschreibung ein.\n"
+"Zeilen, die mit '%c' beginnen, werden behalten; Sie d=C3=BCrfen diese=
\n"
+"selbst entfernen wenn Sie m=C3=B6chten.\n"
=20
 #: builtin/tag.c:292
 msgid "unable to sign the tag"
@@ -8942,7 +8941,6 @@ msgid "Print lines matching a pattern"
 msgstr "Stellt Zeilen dar, die einem Muster entsprechen"
=20
 #: common-cmds.h:17
-#, fuzzy
 msgid "Create an empty Git repository or reinitialize an existing one"
 msgstr ""
 "Erstellt ein leeres Git-Projektarchiv oder initialisiert ein bestehen=
des neu"
@@ -9869,14 +9867,12 @@ msgid "blob"
 msgstr "Blob"
=20
 #: git-submodule.sh:979
-#, fuzzy
 msgid "Submodules changed but not updated:"
-msgstr "# Unterprojekte ge=C3=A4ndert, aber nicht aktualisiert:"
+msgstr "Unterprojekte ge=C3=A4ndert, aber nicht aktualisiert:"
=20
 #: git-submodule.sh:981
-#, fuzzy
 msgid "Submodule changes to be committed:"
-msgstr "# =C3=84nderungen in Unterprojekt zum Eintragen:"
+msgstr "=C3=84nderungen in Unterprojekt zum Eintragen:"
=20
 #: git-submodule.sh:1129
 #, sh-format
--=20
1.8.2.rc0.16.g20a599e

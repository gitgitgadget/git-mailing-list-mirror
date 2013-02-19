From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] l10n: de.po: translate 35 new messages
Date: Tue, 19 Feb 2013 16:06:57 +0100
Message-ID: <51239511.90604@drmicha.warpmail.net>
References: <1361211754-5641-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de,
	git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 16:07:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7omx-0007Bn-E3
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 16:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933021Ab3BSPG6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Feb 2013 10:06:58 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35000 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932995Ab3BSPG4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Feb 2013 10:06:56 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B330E201BF;
	Tue, 19 Feb 2013 10:06:55 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Tue, 19 Feb 2013 10:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=lw0G7NlMz5sdepDam2ExIk
	tFvMM=; b=Fk40wx/Ly/I9dOnHAtH6LakR15SZTa7U8vTU+ufIImUfyOupdsSUvC
	ahcP689MX6muxCi+UnIh+zm8Byta9FR7FS/9dnZB3MqRKzh2uq8oPtJ1sPNqD2Xq
	zW+1emWGxYjzP0XaVvi1Pl9lQjL9X+SXjwtf9VwyXDBUJhLB5qzFA=
X-Sasl-enc: eB1VFfu8nhKuX/Ng9jVC9mkmlUG6rEfRSYVSD37Vu7t2 1361286415
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C59958E05B0;
	Tue, 19 Feb 2013 10:06:54 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <1361211754-5641-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216622>

Ralf Thielow venit, vidit, dixit 18.02.2013 19:22:
> Translate 35 new messages came from git.pot update
> in 9caaf23 (l10n: Update git.pot (35 new, 14 removed
> messages)).
>=20
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/de.po | 140 +++++++++++++++++++++++++++++++----------------------=
----------
>  1 file changed, 68 insertions(+), 72 deletions(-)
>=20
> diff --git a/po/de.po b/po/de.po
> index df98a0f..9690cd7 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -358,14 +358,14 @@ msgid "gpg failed to sign the data"
>  msgstr "gpg beim Signieren der Daten fehlgeschlagen"
> =20
>  #: gpg-interface.c:112
> -#, fuzzy, c-format
> +#, c-format
>  msgid "could not create temporary file '%s': %s"
> -msgstr "konnte Datei '%s' nicht erstellen"
> +msgstr "konnte tempor=C3=A4re Datei '%s' nicht erstellen: %s"
> =20
>  #: gpg-interface.c:115
> -#, fuzzy, c-format
> +#, c-format
>  msgid "failed writing detached signature to '%s': %s"
> -msgstr "Fehler beim Erstellen des Pfades '%s'%s"
> +msgstr "Fehler beim Schreiben der Signatur nach '%s': %s"
> =20
>  #: grep.c:1622
>  #, c-format
> @@ -1443,9 +1443,8 @@ msgid "failed to unlink '%s'"
>  msgstr "Konnte '%s' nicht entfernen"

Maybe a "." at the end, or begin with lower case.

>  #: builtin/add.c:20
> -#, fuzzy
>  msgid "git add [options] [--] <pathspec>..."
> -msgstr "git add [Optionen] [--] [<Dateimuster>...]"
> +msgstr "git add [Optionen] [--] [<Pfadspezifikation>...]"
> =20
>  #: builtin/add.c:63
>  #, c-format
> @@ -1601,6 +1600,21 @@ msgid ""
>  "With the current Git version, the command is restricted to the curr=
ent "
>  "directory."
>  msgstr ""
> +"Das Verhalten von 'git add %s (oder %s)' ohne ein Pfad-Argument von=
\n"
> +"einem Unterverzeichnis aus, wird in Git 2.0 ge=C3=A4ndert und sollt=
e nicht\n"

There should be no "," here because there is no subclause.

> +"mehr verwendet werden.\n"
> +"Um Dateien des gesamten Projektverzeichnisses hinzuzuf=C3=BCgen, f=C3=
=BChren Sie aus:\n"

There can be a comma here, it is a (shortened subclause).

> +"\n"
> +"  git add %s :/\n"
> +"  (oder git add %s :/)\n"
> +"\n"
> +"Zur Einschr=C3=A4nkung auf das aktuelle Verzeichnis, f=C3=BChren Si=
e aus:\n"

There should be no "," here because there is no subclause.

Rest looks fine (Thomas mentioned the missed "rename" already).

> +"\n"
> +"  git add %s .\n"
> +"  (oder git add %s .)\n"
> +"\n"
> +"Mit der aktuellen Version von Git ist das Kommando auf das aktuelle=
\n"
> +"Verzeichnis beschr=C3=A4nkt."
> =20
>  #: builtin/add.c:381
>  msgid "-A and -u are mutually incompatible"
> @@ -2412,16 +2426,16 @@ msgstr "[%d voraus, %d hinterher]"
> =20
>  #: builtin/branch.c:469
>  msgid " **** invalid ref ****"
> -msgstr ""
> +msgstr " **** ung=C3=BCltige Referenz ****"
> =20
>  #: builtin/branch.c:560
>  msgid "(no branch)"
>  msgstr "(kein Zweig)"
> =20
>  #: builtin/branch.c:593
> -#, fuzzy, c-format
> +#, c-format
>  msgid "object '%s' does not point to a commit"
> -msgstr "'%s' zeigt auf keine Version"
> +msgstr "Objekt '%s' zeigt auf keine Version"
> =20
>  #: builtin/branch.c:625
>  msgid "some refs could not be read"
> @@ -2571,33 +2585,30 @@ msgid "--column and --verbose are incompatibl=
e"
>  msgstr "Die Optionen --column und --verbose sind inkompatibel."
> =20
>  #: builtin/branch.c:845
> -#, fuzzy
>  msgid "branch name required"
> -msgstr "Kein Zweigname spezifiziert"
> +msgstr "Zweigname erforderlich"
> =20
>  #: builtin/branch.c:860
> -#, fuzzy
>  msgid "Cannot give description to detached HEAD"
> -msgstr "Kann Hauptzweig des externen Projektarchivs nicht bestimmen"
> +msgstr "zu losgel=C3=B6ster Zweigspitze (HEAD) kann keine Beschreibu=
ng hinterlegt werden"
> =20
>  #: builtin/branch.c:865
> -#, fuzzy
>  msgid "cannot edit description of more than one branch"
> -msgstr "bearbeitet die Beschreibung f=C3=BCr den Zweig"
> +msgstr "Beschreibung von mehr als einem Zweig kann nicht bearbeitet =
werden"
> =20
>  #: builtin/branch.c:872
> -#, fuzzy, c-format
> +#, c-format
>  msgid "No commit on branch '%s' yet."
> -msgstr "Kein solcher Zweig '%s'"
> +msgstr "Noch keine Version in Zweig '%s'."
> =20
>  #: builtin/branch.c:875
> -#, fuzzy, c-format
> +#, c-format
>  msgid "No branch named '%s'."
> -msgstr "Ung=C3=BCltiger Zweig-Name: '%s'"
> +msgstr "Zweig '%s' nicht vorhanden."
> =20
>  #: builtin/branch.c:888
>  msgid "too many branches for a rename operation"
> -msgstr ""
> +msgstr "zu viele Zweige angegeben"
> =20
>  #: builtin/branch.c:893
>  #, c-format
> @@ -2731,28 +2742,24 @@ msgid "suppress progress reporting"
>  msgstr "unterdr=C3=BCckt Fortschrittsanzeige"
> =20
>  #: builtin/check-ignore.c:151
> -#, fuzzy
>  msgid "cannot specify pathnames with --stdin"
> -msgstr "kann -a nicht mit -d benutzen"
> +msgstr "Angabe von Pfadnamen kann nicht gemeinsam mit --stdin verwen=
det werden"
> =20
>  #: builtin/check-ignore.c:154
>  msgid "-z only makes sense with --stdin"
> -msgstr ""
> +msgstr "Die Option -z kann nur mit --stdin verwendet werden."
> =20
>  #: builtin/check-ignore.c:156
> -#, fuzzy
>  msgid "no path specified"
> -msgstr "kein externes Projektarchiv angegeben"
> +msgstr "kein Pfad angegeben"
> =20
>  #: builtin/check-ignore.c:160
> -#, fuzzy
>  msgid "--quiet is only valid with a single pathname"
> -msgstr "verwendet [PATCH n/m] auch mit einzelnem Patch"
> +msgstr "Die Option --quiet ist nur mit einem einzelnen Pfadnamen g=C3=
=BCltig."
> =20
>  #: builtin/check-ignore.c:162
> -#, fuzzy
>  msgid "cannot have both --quiet and --verbose"
> -msgstr "Kann den aktuellen Zustand der Bereitstellung nicht speicher=
n"
> +msgstr "Die Optionen --quiet und --verbose k=C3=B6nnen nicht gemeins=
am verwendet werden."
> =20
>  #: builtin/checkout-index.c:126
>  msgid "git checkout-index [options] [--] [<file>...]"
> @@ -3421,14 +3428,12 @@ msgid "--command must be the first argument"
>  msgstr "Die Option --command muss an erster Stelle stehen."
> =20
>  #: builtin/commit.c:34
> -#, fuzzy
>  msgid "git commit [options] [--] <pathspec>..."
> -msgstr "git commit [Optionen] [--] <Dateimuster>..."
> +msgstr "git commit [Optionen] [--] <Pfadspezifikation>..."
> =20
>  #: builtin/commit.c:39
> -#, fuzzy
>  msgid "git status [options] [--] <pathspec>..."
> -msgstr "git status [Optionen] [--] <Dateimuster>..."
> +msgstr "git status [Optionen] [--] <Pfadspezifikation>..."
> =20
>  #: builtin/commit.c:44
>  msgid ""
> @@ -3604,17 +3609,17 @@ msgstr ""
>  "und versuchen Sie es erneut.\n"
> =20
>  #: builtin/commit.c:735
> -#, fuzzy, c-format
> +#, c-format
>  msgid ""
>  "Please enter the commit message for your changes. Lines starting\n"
>  "with '%c' will be ignored, and an empty message aborts the commit.\=
n"
>  msgstr ""
>  "Bitte geben Sie eine Versionsbeschreibung f=C3=BCr Ihre =C3=84nderu=
ngen ein. Zeilen,\n"
> -"die mit '#' beginnen, werden ignoriert, und eine leere Versionsbesc=
hreibung\n"
> +"die mit '%c' beginnen, werden ignoriert, und eine leere Versionsbes=
chreibung\n"
>  "bricht die Eintragung ab.\n"
> =20
>  #: builtin/commit.c:740
> -#, fuzzy, c-format
> +#, c-format
>  msgid ""
>  "Please enter the commit message for your changes. Lines starting\n"
>  "with '%c' will be kept; you may remove them yourself if you want to=
=2E\n"
> @@ -3622,7 +3627,7 @@ msgid ""
>  msgstr ""
>  "Bitte geben Sie eine Versionsbeschreibung f=C3=BCr Ihre =C3=84nderu=
ngen ein. Zeilen, "
>  "die\n"
> -"mit '#' beginnen, werden beibehalten; wenn Sie m=C3=B6chten, k=C3=B6=
nnen Sie diese "
> +"mit '%c' beginnen, werden beibehalten; wenn Sie m=C3=B6chten, k=C3=B6=
nnen Sie diese "
>  "entfernen.\n"
>  "Eine leere Versionsbeschreibung bricht die Eintragung ab.\n"
> =20
> @@ -4403,9 +4408,8 @@ msgid "deepen history of shallow clone"
>  msgstr "vertieft die Historie eines flachen Klon"
> =20
>  #: builtin/fetch.c:86
> -#, fuzzy
>  msgid "convert to a complete repository"
> -msgstr "um von einem lokalen Projektarchiv zu klonen"
> +msgstr "konvertiert zu einem vollst=C3=A4ndigen Projektarchiv"
> =20
>  #: builtin/fetch.c:88 builtin/log.c:1119
>  msgid "dir"
> @@ -4561,14 +4565,13 @@ msgid "You need to specify a tag name."
>  msgstr "Sie m=C3=BCssen den Namen der Markierung angeben."
> =20
>  #: builtin/fetch.c:981
> -#, fuzzy
>  msgid "--depth and --unshallow cannot be used together"
> -msgstr "Die Optionen -x und -X k=C3=B6nnen nicht gemeinsam verwendet=
 werden."
> +msgstr "Die Optionen --depth und --unshallow k=C3=B6nnen nicht gemei=
nsam verwendet werden."
> =20
>  #: builtin/fetch.c:983
> -#, fuzzy
>  msgid "--unshallow on a complete repository does not make sense"
> -msgstr "Die Option --name-only kann nicht verwendet werden."
> +msgstr "Die Option --unshallow kann nicht in einem vollst=C3=A4ndige=
n Projektarchiv "
> +"verwendet werden."
> =20
>  #: builtin/fetch.c:1002
>  msgid "fetch --all does not take a repository argument"
> @@ -6122,7 +6125,7 @@ msgstr ""
>  "Zusammenf=C3=BChrung abzuschlie=C3=9Fen.\n"
> =20
>  #: builtin/merge.c:788
> -#, fuzzy, c-format
> +#, c-format
>  msgid ""
>  "Please enter a commit message to explain why this merge is necessar=
y,\n"
>  "especially if it merges an updated upstream into a topic branch.\n"
> @@ -6135,7 +6138,7 @@ msgstr ""
>  "insbesondere wenn es einen aktualisierten, externen Zweig mit einem=
 Thema-"
>  "Zweig zusammenf=C3=BChrt.\n"
>  "\n"
> -"Zeilen beginnend mit '#' werden ignoriert, und eine leere Beschreib=
ung "
> +"Zeilen beginnend mit '%c' werden ignoriert, und eine leere Beschrei=
bung "
>  "bricht die Eintragung ab.\n"
> =20
>  #: builtin/merge.c:812
> @@ -6606,9 +6609,8 @@ msgid "unable to start 'show' for object '%s'"
>  msgstr "konnte 'show' f=C3=BCr Objekt '%s' nicht starten"
> =20
>  #: builtin/notes.c:143
> -#, fuzzy
>  msgid "could not read 'show' output"
> -msgstr "Konnte '%s' nicht lesen"
> +msgstr "Konnte Ausgabe von 'show' nicht lesen."
> =20
>  #: builtin/notes.c:151
>  #, c-format
> @@ -7213,7 +7215,6 @@ msgstr ""
>  "f=C3=BCr weitere Details."
> =20
>  #: builtin/push.c:224
> -#, fuzzy
>  msgid ""
>  "Updates were rejected because the remote contains work that you do\=
n"
>  "not have locally. This is usually caused by another repository push=
ing\n"
> @@ -7221,18 +7222,18 @@ msgid ""
>  "'git pull') before pushing again.\n"
>  "See the 'Note about fast-forwards' in 'git push --help' for details=
=2E"
>  msgstr ""
> -"Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze Ihres =
aktuellen\n"
> -"Zweiges hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen =
ist. F=C3=BChren Sie\n"
> -"die externen =C3=84nderungen zusammen (z.B. 'git pull') bevor Sie e=
rneut\n"
> -"versenden.\n"
> +"Aktualisierungen wurden zur=C3=BCckgewiesen, weil das Fernarchiv Ve=
rsionen enth=C3=A4lt,\n"
> +"die lokal nicht vorhanden sind. Das wird =C3=BCblicherweise durch d=
as Versenden von\n"
> +"Versionen auf dieselbe Referenz von einem anderen Projektarchiv aus=
 verursacht.\n"
> +"Vielleicht m=C3=BCssen Sie die externen =C3=84nderungen zusammenzuf=
=C3=BChren (z.B. 'git pull')\n"
> +"bevor Sie erneut versenden.\n"
>  "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --he=
lp'\n"
>  "f=C3=BCr weitere Details."
> =20
>  #: builtin/push.c:231
> -#, fuzzy
>  msgid "Updates were rejected because the tag already exists in the r=
emote."
>  msgstr ""
> -"Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Zielreferenz =
bereits\n"
> +"Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Markierung be=
reits\n"
>  "im Fernarchiv existiert."
> =20
>  #: builtin/push.c:234
> @@ -7241,6 +7242,9 @@ msgid ""
>  "or update a remote ref to make it point at a non-commit object,\n"
>  "without using the '--force' option.\n"
>  msgstr ""
> +"Sie k=C3=B6nnen keine externe Referenz aktualisieren, die auf ein O=
bjekt zeigt,\n"
> +"das keine Version ist, oder es auf ein solches Objekt zeigen lassen=
, ohne\n"
> +"die Option '--force' zu verwenden.\n"
> =20
>  #: builtin/push.c:294
>  #, c-format
> @@ -7351,9 +7355,8 @@ msgid "prune locally removed refs"
>  msgstr "entfernt lokal gel=C3=B6schte Referenzen"
> =20
>  #: builtin/push.c:439
> -#, fuzzy
>  msgid "bypass pre-push hook"
> -msgstr "umgeht \"pre-commit hook\""
> +msgstr "umgeht \"pre-push hook\""
> =20
>  #: builtin/push.c:448
>  msgid "--delete is incompatible with --all, --mirror and --tags"
> @@ -8536,20 +8539,18 @@ msgid "could not verify the tag '%s'"
>  msgstr "Konnte Markierung '%s' nicht verifizieren"
> =20
>  #: builtin/tag.c:249
> -#, fuzzy, c-format
> +#, c-format
>  msgid ""
>  "\n"
>  "Write a tag message\n"
>  "Lines starting with '%c' will be ignored.\n"
>  msgstr ""
>  "\n"
> -"#\n"
> -"# Geben Sie eine Markierungsbeschreibung ein.\n"
> -"# Zeilen, die mit '#' beginnen, werden ignoriert.\n"
> -"#\n"
> +"Geben Sie eine Markierungsbeschreibung ein.\n"
> +"Zeilen, die mit '%c' beginnen, werden ignoriert.\n"
> =20
>  #: builtin/tag.c:253
> -#, fuzzy, c-format
> +#, c-format
>  msgid ""
>  "\n"
>  "Write a tag message\n"
> @@ -8557,11 +8558,9 @@ msgid ""
>  "want to.\n"
>  msgstr ""
>  "\n"
> -"#\n"
> -"# Geben Sie eine Markierungsbeschreibung ein.\n"
> -"# Zeilen, die mit '#' beginnen, werden behalten; Sie d=C3=BCrfen di=
ese\n"
> -"# selbst entfernen wenn Sie m=C3=B6chten.\n"
> -"#\n"
> +"Geben Sie eine Markierungsbeschreibung ein.\n"
> +"Zeilen, die mit '%c' beginnen, werden behalten; Sie d=C3=BCrfen die=
se\n"
> +"selbst entfernen wenn Sie m=C3=B6chten.\n"
> =20
>  #: builtin/tag.c:292
>  msgid "unable to sign the tag"
> @@ -8942,7 +8941,6 @@ msgid "Print lines matching a pattern"
>  msgstr "Stellt Zeilen dar, die einem Muster entsprechen"
> =20
>  #: common-cmds.h:17
> -#, fuzzy
>  msgid "Create an empty Git repository or reinitialize an existing on=
e"
>  msgstr ""
>  "Erstellt ein leeres Git-Projektarchiv oder initialisiert ein besteh=
endes neu"
> @@ -9869,14 +9867,12 @@ msgid "blob"
>  msgstr "Blob"
> =20
>  #: git-submodule.sh:979
> -#, fuzzy
>  msgid "Submodules changed but not updated:"
> -msgstr "# Unterprojekte ge=C3=A4ndert, aber nicht aktualisiert:"
> +msgstr "Unterprojekte ge=C3=A4ndert, aber nicht aktualisiert:"
> =20
>  #: git-submodule.sh:981
> -#, fuzzy
>  msgid "Submodule changes to be committed:"
> -msgstr "# =C3=84nderungen in Unterprojekt zum Eintragen:"
> +msgstr "=C3=84nderungen in Unterprojekt zum Eintragen:"
> =20
>  #: git-submodule.sh:1129
>  #, sh-format
>=20

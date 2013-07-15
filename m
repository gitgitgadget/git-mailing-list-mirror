From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCHv2 2/3] l10n: de.po: switch from pure German to German+English (part 2)
Date: Mon, 15 Jul 2013 23:53:45 +0200
Message-ID: <878v171od2.fsf@hexa.v.cablecom.net>
References: <1371057331-3917-1-git-send-email-ralf.thielow@gmail.com>
	<1373478890-8480-1-git-send-email-ralf.thielow@gmail.com>
	<1373478890-8480-2-git-send-email-ralf.thielow@gmail.com>
	<1373478890-8480-3-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <trast@student.ethz.ch>, <jk@jk.gs>, <stimming@tuhh.de>,
	<git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 23:53:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyqiP-0007b1-Cd
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 23:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758115Ab3GOVxs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jul 2013 17:53:48 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:32951 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758100Ab3GOVxr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jul 2013 17:53:47 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 15 Jul
 2013 23:53:45 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 15 Jul
 2013 23:53:46 +0200
In-Reply-To: <1373478890-8480-3-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Wed, 10 Jul 2013 19:54:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230527>

Ralf Thielow <ralf.thielow@gmail.com> writes:

>  #: builtin/clone.c:73
>  msgid "create a mirror repository (implies bare)"
> -msgstr "erstellt ein Spiegelarchiv (impliziert blo=C3=9Fes Projektar=
chiv)"
> +msgstr "erstellt ein Spiegelarchiv (impliziert Bare-Repository)"

Perhaps it's better to just say --bare here?

>  #: builtin/clone.c:93
>  msgid "path to git-upload-pack on the remote"
> -msgstr "Pfad zu \"git-upload-pack\" auf der Gegenseite"
> +msgstr "Pfad zu \"git-upload-pack\" im Remote-Repository"

Here 'remote' does not refer to a repository, but the machine in
general.  I guess "Gegenseite" was okay.

>  #: builtin/commit.c:819
>  msgid "Error building trees"
> -msgstr "Fehler beim Erzeugen der Zweige"
> +msgstr "Fehler beim Erzeugen der Verzeichnisse"

Similar to the one in merge-recursive.c, this is an internal function
that writes trees failing (update_main_cache_tree() in this case).  So
neither old nor new German translations are in fact correct; it is abou=
t
tree objects.

>  #: builtin/commit.c:1371
>  msgid "use autosquash formatted message to squash specified commit"
>  msgstr ""
>  "verwendet eine automatisch zusammengesetzte Beschreibung zum Zusamm=
enf=C3=BChren "
> -"der angegebenen Version"
> +"des angegebenen Commits"

Shouldn't the "Zusammenf=C3=BChren" also change to "Mergen"?

> @@ -4503,8 +4501,8 @@ msgid ""
>  "No annotated tags can describe '%s'.\n"
>  "However, there were unannotated tags: try --tags."
>  msgstr ""
> -"Keine annotierten Markierungen k=C3=B6nnen '%s' beschreiben.\n"
> -"Jedoch gab es nicht annotierte Markierungen: versuchen Sie --tags."
> +"Keine annotierten Tags k=C3=B6nnen '%s' beschreiben.\n"
> +"Jedoch gab es nicht annotierte Tags: versuchen Sie --tags."

You could add a clarifying dash to make it easier to read:

  Jedoch gab es nicht-annotierte Tags: versuchen Sie --tags.

(My German teacher probably hates me now.)

> @@ -4572,7 +4570,7 @@ msgstr "Kennzeichen"
>  #: builtin/describe.c:417
>  msgid "append <mark> on dirty working tree (default: \"-dirty\")"
>  msgstr ""
> -"f=C3=BCgt <Kennzeichen> bei ge=C3=A4ndertem Arbeitsbaum hinzu (Stan=
dard: \"-dirty\")"
> +"f=C3=BCgt <Kennzeichen> bei ge=C3=A4ndertem Arbeitsverzeichnis hinz=
u (Standard: \"-dirty\")"

Here you have dirty -> ge=C3=A4ndertes Arbeitsverzeichnis ("modified
worktree"), but in other places I saw clean (relating to worktree) ->
sauber.

How about always talking about an (un)modified worktree, i.e.,
ge=C3=A4ndertem/unver=C3=A4ndertem Arbeitsbaum?

>  #: builtin/fetch.c:64
>  msgid "path to upload pack on remote end"
> -msgstr "Pfad des Programms zum Hochladen von Paketen auf der Gegense=
ite"
> +msgstr "Pfad des Programms zum Hochladen von Paketen im Remote-Repos=
itory"

Similar to the message in clone.c, this does not refer to a
repo-specific path and should probably remain "auf der Gegenseite".

>  #: builtin/fetch.c:1023
>  msgid "Fetching a group and specifying refspecs does not make sense"
>  msgstr ""
>  "Das Abholen einer Gruppe von externen Archiven kann nicht mit der A=
ngabe\n"
> -"von Referenzspezifikationen verwendet werden."
> +"von Refspecs verwendet werden."

You missed an instance of "externe Archive" here.

>  #: builtin/fsck.c:618
>  msgid "make index objects head nodes"
> -msgstr "erzeugt Kopfknoten der Bereitstellungsobjekte"
> +msgstr "erzeugt Kopfknoten der Staging-Area-Objekte"
>=20
>  #: builtin/fsck.c:619
>  msgid "make reflogs head nodes (default)"
> -msgstr "erzeugt Kopfknoten des Referenzprotokolls (Standard)"
> +msgstr "erzeugt Kopfknoten des Reflogs (Standard)"

Not a new problem, but none of these (including English) is particularl=
y
enlightening without context.  The message refers to fsck starting an
unreachability and verification walk at a list of objects.  This option
(--cache) adds all blobs in the index to that list.

So perhaps simply

  pr=C3=BCfe Objekte in der Staging Area

and then similarly change all the "head nodes" talk to an application o=
f
"pr=C3=BCfen".

>  #: builtin/grep.c:905
>  msgid "both --cached and trees are given."
> -msgstr "Die Option --cached kann nicht mit Zweigen verwendet werden.=
"
> +msgstr "Die Option --cached kann nicht mit Verzeichnissen verwendet =
werden."

"Trees" here refers to a tree object.

>  #: builtin/init-db.c:102
>  #, c-format
>  msgid "cannot symlink '%s' '%s'"
> -msgstr "kann '%s' nicht mit '%s' symbolisch verkn=C3=BCpfen"
> +msgstr "kann '%s' nicht mit '%s' symbolisch verweisen"

Is "verweisen" transitive?  Perhaps

  Kann symbolischen Verweis '%s' auf '%s' nicht erstellen

>  #: builtin/log.c:1138
>  msgid "don't include a patch matching a commit upstream"
>  msgstr ""
> -"schlie=C3=9Ft keine Patches ein, die einer Version im =C3=9Cbernahm=
ezweig entsprechen"
> +"schlie=C3=9Ft keine Patches ein, die einem Commit im Upstream-Branc=
h entsprechen"

Perhaps it doesn't matter, but: the use of "upstream" here does not
refer to the upstream config, but the argument to format-patch.  Which
might be the upstream, but the user is free to specify e.g. HEAD~1
instead.

>  #: builtin/log.c:1484
>  msgid "git cherry [-v] [<upstream> [<head> [<limit>]]]"
> -msgstr "git cherry [-v] [<=C3=9Cbernahmezweig> [<Arbeitszweig> [<Lim=
it>]]]"
> +msgstr "git cherry [-v] [<Upstream> [<Arbeitsbranch> [<Limit>]]]"

Perhaps lose the "Arbeits" to reduce possible confusion -- AFAICT it is
only used as a direct equivalent of "work" in "worktree".

--=20
Thomas Rast
trast@{inf,student}.ethz.ch

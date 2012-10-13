From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [RFC/PATCH] l10n: de.po: translate 825 new messages
Date: Sat, 13 Oct 2012 22:33:37 +0200
Message-ID: <87pq4mgli6.fsf@pctrast.inf.ethz.ch>
References: <1349200849-7436-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, <jk@jk.gs>, <stimming@tuhh.de>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 22:34:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TN8PF-0008Mv-2A
	for gcvg-git-2@plane.gmane.org; Sat, 13 Oct 2012 22:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157Ab2JMUdm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Oct 2012 16:33:42 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:35508 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754147Ab2JMUdl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Oct 2012 16:33:41 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 13 Oct
 2012 22:33:37 +0200
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 13 Oct
 2012 22:33:37 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207576>

Hi Ralf

I just realized that, unfortunately, your original message is far beyon=
d
the message size limit on vger (100000 bytes according to [1]).  So
nobody outside of the Cc list has seen it...

Note for other readers: the glossary (also mentioned a few times below)
is at

  https://github.com/ralfth/git-po-de/wiki/Glossary

We're using it to keep things consistent.


Ralf Thielow <ralf.thielow@gmail.com> writes:

>  msgid "git archive --list"
> -msgstr "git archive: NACK %s"
> +msgstr "git archive --list"

I suppose a literal command invocation shouldn't be translatable in the
first place.

>  #: archive.c:322
>  msgid "archive format"
> -msgstr ""
> +msgstr "Archivformat"

This is a bit tricky because you call a repository "Projektarchiv".  Th=
e
simplest solution I can come up with is replacing all instances of
"archive" in the messages of git-archive with "Ausgabe" (output).  Stil=
l
leaves the confusion between git-archive's name and the Projektarchiv,
though.

>  #: archive.c:324
>  msgid "prepend prefix to each pathname in the archive"
> -msgstr ""
> +msgstr "stellt einen Prefix vor jeden Pfadnamen in dem Archiv"

Pr=C3=A4fix?

>  #: archive.c:346 builtin/archive.c:95 builtin/notes.c:616
> -#, fuzzy
>  msgid "command"
> -msgstr "f=C3=BChre $command aus"
> +msgstr "Kommando"
> =20
>  #: archive.c:347 builtin/archive.c:96
>  msgid "path to the remote git-upload-archive command"
> -msgstr ""
> +msgstr "Pfad zum externen \"git-upload-archive\" Kommando"

In both of these it may be less strange to call it "Programm", since
you're supposed to give it the path to the git-upload-archive program.

>  #: wt-status.c:1040
> -#, fuzzy, c-format
> +#, c-format
>  msgid "nothing to commit (create/copy files and use \"git add\" to t=
rack)\n"
> -msgstr " (Erstelle/Kopiere Dateien und benutze \"git add\" zum Beoba=
chten)"
> +msgstr ""
> +"nichts zum Eintragen (Erstelle/Kopiere Dateien und benutze \"git ad=
d\" zum "
> +"Beobachten)\n"
> =20
>  #: wt-status.c:1043 wt-status.c:1048
> -#, fuzzy, c-format
> +#, c-format
>  msgid "nothing to commit\n"
> -msgstr "nichts zum Eintragen%s\n"
> +msgstr "nichts zum Eintragen\n"

In these and others, "nichts einzutragen" would sound nicer.

>  #: builtin/add.c:322
> -#, fuzzy
>  msgid "interactive picking"
> -msgstr "interaktives Hinzuf=C3=BCgen fehlgeschlagen"
> +msgstr "interaktives Pfl=C3=BCcken"

"interaktives Ausw=C3=A4hlen" would let us reserve "pfl=C3=BCcken" for
cherry-picking (and similar operations, e.g. in the TODO sheet of rebas=
e
-i).

>  #: builtin/add.c:327
>  msgid "record only the fact that the path will be added later"
> -msgstr ""
> +msgstr "speichert nur den Fakt, dass der Pfad sp=C3=A4ter hinzugef=C3=
=BCgt wird"

=46akt? :-)

How about:

  speichert nur, dass der Pfad sp=C3=A4ter hinzugef=C3=BCgt werden soll

>  #: builtin/add.c:331
>  msgid "check if - even missing - files are ignored in dry run"
> -msgstr ""
> +msgstr "pr=C3=BCft ob - auch fehlende - Dateien im Trockenlauf ignor=
iert werden"

You called "dry run" a "Probelauf" earlier, which I liked better.

>  #: builtin/blame.c:2316
>  msgid "Show blame entries as we find them, incrementally"
> -msgstr ""
> +msgstr "Zeigt \"blame\"-Eintr=C3=A4ge wie gefunden, schrittweise"

Zeigt "blame"-Eintr=C3=A4ge schrittweise, w=C3=A4hrend wir sie generier=
en

(or something along those lines, but "wie gefunden" makes no sense)

>  #: builtin/blame.c:2317
>  msgid "Show blank SHA-1 for boundary commits (Default: off)"
> -msgstr ""
> +msgstr "Zeigt leere SHA-1 f=C3=BCr Grenzversionen (Standard: off)"
> =20
>  #: builtin/blame.c:2318
>  msgid "Do not treat root commits as boundaries (Default: off)"
> -msgstr ""
> +msgstr "Behandelt Ursprungsversionen nicht als Grenzen (Standard: of=
f)"

"Standard: aus"?  It's not like it takes an argument "on" or "off".
This is in a lot of the messages of git-blame.

I added {root,boundary} commit to the glossary according to these.

>  #: builtin/blame.c:2331
>  msgid "Spend extra cycles to find better match"
> -msgstr ""
> +msgstr "f=C3=BChrt zus=C3=A4tzliche Durchl=C3=A4ufe f=C3=BCr bessere=
 =C3=9Cbereinstimmungen durch"

Cycles here does not mean "Durchl=C3=A4ufe" (cycles through a loop) but=
 CPU
cycles.  How about

  arbeite l=C3=A4nger, um bessere =C3=9Cbereinstimmungen zu finden

>  #: builtin/branch.c:724
> -#, fuzzy
>  msgid "Generic options"
> -msgstr "Ung=C3=BCltige Option: %s"
> +msgstr "Generische Optionen"

Allgemeine Optionen?

>  #: builtin/branch.c:726
>  msgid "show hash and subject, give twice for upstream branch"
>  msgstr ""
> +"Zeigt Hash und Betreff, doppelte Angabe f=C3=BCr Anzeige des extern=
en "
> +"=C3=9Cbernahmezweiges"

I don't think I would understand the "doppelte Angabe".  How about

  Zeigt Hash und Betreff; -vv: zus=C3=A4tzlich externen =C3=9Cbernahmez=
weig

>  #: builtin/branch.c:727
>  msgid "suppress informational messages"
> -msgstr ""
> +msgstr "unterdr=C3=BCckt informatorische Meldungen"

I don't think that's a word.  "unterdr=C3=BCckt Informationsmeldungen"?

>  #: builtin/branch.c:762
> -#, fuzzy
>  msgid "force creation (when already exists)"
> -msgstr "externes Projektarchiv %s existiert bereits"
> +msgstr "erzwingt Erzeugung (wenn dieser bereits existiert)"

Erzeuge auch, wenn der Zweig bereits existiert?

Not a big difference, but avoids "Erzeugung".

>  #: builtin/branch.c:876
>  #, c-format
>  msgid "Branch '%s' has no upstream information"
> -msgstr ""
> +msgstr "Zweig '%s' hat keine Informationen zu einem externen =C3=9Cb=
ernahmezweig"

The information bit sounds strange to me.

Zweig '%s' hat keinen externen =C3=9Cbernahmezweig gesetzt?

>  #: builtin/cat-file.c:273
>  msgid "for blob objects, run textconv on object's content"
> -msgstr ""
> +msgstr "f=C3=BCr Blob-Objekte, f=C3=BChrt \"textconv\" auf den Objek=
tinhalt aus"

f=C3=BChrt textconv auf dem Inhalt von Blob-Objekten aus?

I guess there's a deeper question hiding here: do we want to translate
textconv (the concept, not the config)?

>  #: builtin/checkout-index.c:204
>  msgid "when creating files, prepend <string>"
> -msgstr ""
> +msgstr "wenn Dateien erzeugt werden, stelle <Zeichenkette> voran"

This is a rather cryptic message.  Does it mean prepending something to
the content?  The original should probably say "... to their name" to
clarify, and then the German one would end in "vor ihren Namen" or
something.

>  #: builtin/checkout-index.c:207
>  msgid "copy out the files from named stage"
> -msgstr ""
> +msgstr "kopiert Dateien von einer benannten Bereitstellung"

"Stage" in this context means the 0/1/2/3 thing where unmerged entries
differ from normal entries.  Thank the Git gods for overloading yet
another term heavily.

We don't have a translation for "stage" in the glossary.  The best I ca=
n
come up with is "Stufe", but if you can find something that evokes the
mental image of the "sides" of a merge, that would be better IMO.

> @@ -2709,19 +2702,19 @@ msgstr "Konnte Ergebnis der Zusammenf=C3=BChr=
ung von '%s' nicht hinzuf=C3=BCgen."
> =20
>  #: builtin/checkout.c:236 builtin/checkout.c:239 builtin/checkout.c:=
242
>  #: builtin/checkout.c:245
> -#, fuzzy, c-format
> +#, c-format
>  msgid "'%s' cannot be used with updating paths"
> -msgstr "%s: %s kann nicht mit %s benutzt werden"
> +msgstr "'%s' kann nicht mit der Aktualisierung von Pfaden benutzt we=
rden"

Another one that is odd even in the original.  Does it update paths?
No, it updates the content of files matching the listed pathspecs.
"cannot be used with paths" would be nicer.

>  #: builtin/checkout.c:1013
>  msgid "create/reset and checkout a branch"
> -msgstr ""
> +msgstr "erzeugt/setzt neu und checkt einen Zweig aus"

I added 'reset =3D neu setzen' to the glossary.  I don't particularly l=
ike
it, but everything I can think about relates to overwriting and sounds
like an operation on _files_.

>  #: builtin/checkout.c:1014
> -#, fuzzy
>  msgid "create reflog for new branch"
> -msgstr "Zeigt an, erstellt oder entfernt Zweige"
> +msgstr "erzeugt Referenzprotokoll f=C3=BCr einen neuen Zweig"

=46=C3=BCr _den_ neuen Zweig?

>  #: builtin/checkout.c:1015
>  msgid "detach the HEAD at named commit"
> -msgstr ""
> +msgstr "l=C3=B6st die Zweigspitze (HEAD) zu benannter Version"

I like the angle of "l=C3=B6sen" (perhaps losl=C3=B6sen?) on detaching =
HEAD, but
it just doesn't fit with "zu" in my ears.

Once you settle on something, note that 'detach' is not in the glossary
yet.

>  #: builtin/checkout.c:1016
> -#, fuzzy
>  msgid "set upstream info for new branch"
> -msgstr "Kein entferntes Projektarchiv f=C3=BCr Zweig '%s' konfigurie=
rt."
> +msgstr "setzt Informationen zum externen =C3=9Cbernahmezweig f=C3=BC=
r einen neuen Zweig"

=46=C3=BCr _den_ neuen Zweig (again).

>  #: builtin/checkout.c:1019
>  msgid "checkout our version for unmerged files"
> -msgstr ""
> +msgstr "checkt unsere Version f=C3=BCr nicht zusammengef=C3=BChrte D=
ateien aus"
>=20
>  #: builtin/checkout.c:1021
>  msgid "checkout their version for unmerged files"
> -msgstr ""
> +msgstr "checkt ihre Version f=C3=BCr nicht zusammengef=C3=BChrte Dat=
eien aus"

You're translating 'our/their version' -> unsere/ihre Version.  Taken
just by itself I think it would be okay or at worst mildly confusing
(how about "unsere/ihre Seite [der Zusammenf=C3=BChrung]"?).

However, in the wider context it is actually dangerous, because you are
overloading the (German) Version here.  It already means 'commit'!

>  #: builtin/checkout.c:1024
>  msgid "perform a 3-way merge with the new branch"
> -msgstr ""
> +msgstr "f=C3=BChrt eine 3-Wege-Zusammenf=C3=BChrung mit einem neuen =
Zweig aus"

Mit _dem_ neuen Zweig.  This one actually has the definite article in
the original, too.

However, speaking of the original, "with the target branch" would be
clearer.  The merge operation only makes sense if the branch already
exists, so it's not "new branch" in the sense of the previous group of
options, which apply to the _to-be-created_ branch.

>  #: builtin/checkout.c:1030
>  msgid "second guess 'git checkout no-such-branch'"
> -msgstr ""
> +msgstr "zweite Vermutung 'git checkout no-such-branch'"

Umm, no?  Second-guessing means doubting or criticising an earlier
decision, and dict.leo.org tells me that it can also be used in the
sense of predicting an action.  Either way, it has nothing to do with a
"Vermutung".

That being said, it's a help string for an undocumented option that onl=
y
makes sense as --no-guess (i.e. it's on by default).  You may as well
just leave it untranslated.

>  #: builtin/clean.c:51
>  msgid "do not print names of files removed"
> -msgstr ""
> +msgstr "gibt keine Namen von entfernten Dateien aus"
[...]
>  #: builtin/clean.c:55
> -#, fuzzy
>  msgid "remove whole directories"
> -msgstr "Zwei Ausgabeverzeichnisse?"
> +msgstr "entfernt ganze Verzeichnisse"
[...]
>  #: builtin/clean.c:58
>  msgid "remove ignored files, too"
> -msgstr ""
> +msgstr "entfernt auch ignorierte Dateien"
> =20
>  #: builtin/clean.c:60
>  msgid "remove only ignored files"
> -msgstr ""
> +msgstr "entfernt nur ignorierte Dateien"

entfernt -> gel=C3=B6scht avoids the ambiguity with the whole remote
branch/repo business.

>  #: builtin/clone.c:76
>  msgid "don't use local hardlinks, always copy"
> -msgstr ""
> +msgstr "benutzt lokal keine harten Verkn=C3=BCpfungen, immer Kopien"

Wikipedia's "in other languages" points from en:hardlink to de:"harter
Link".  Not that I like this (I would have guessed it's "hardlink"
literally), but maybe we should stick to it since it's not Git's own
jargon?

>  #: builtin/clone.c:78
> -#, fuzzy
>  msgid "setup as shared repository"
> -msgstr "Kein Git-Projektarchiv"
> +msgstr "Einrichtung als verteiltes Projektarchiv"
[...]
>  #: builtin/clone.c:86
>  msgid "reference repository"
> -msgstr ""
> +msgstr "referenziert Projektarchiv"

Both of these scare me a bit, but so do the English versions.  They're
very terse for options that should not be used unless you know what the
implications are.  Perhaps it should say "(see help)" or something.

>  #: builtin/clone.c:97 builtin/init-db.c:494
>  msgid "gitdir"
> -msgstr ""
> +msgstr "Git-Verzeichnis"

=2Egit-Verzeichnis?

It doesn't have to be named like this, but that would clarify things.

>  #: builtin/column.c:27 builtin/column.c:28
> -#, fuzzy
>  msgid "layout to use"
> -msgstr "lokal nicht aktuell"
> +msgstr "zu verwendender Aufbau"

Anordnung?

>  #: builtin/column.c:30
>  msgid "Padding space on left border"
> -msgstr ""
> +msgstr "Abstand zur linken Grenze"
[...]
>  #: builtin/column.c:31
>  msgid "Padding space on right border"
> -msgstr ""
> +msgstr "Abstand zur rechten Grenze"

border here means "Rand"!

>  #: builtin/commit.c:1399
>  msgid "the commit is authored by me now (used with -C/-c/--amend)"
> -msgstr ""
> +msgstr "diese Version ist jetzt von mir verfasst (benutzt mit -C/-c/=
--amend)"

"Ich bin jetzt der Autor der Version" or "Setze mich als Autor der
Version" would make much clearer which field is being updated by this.

>  #: builtin/commit.c:1411
>  msgid "add specified files to index for commit"
> -msgstr ""
> +msgstr "stellt angegebene Dateien zur Eintragung bereit"

This doesn't make very clear what is going on (it's the help for the
commit --include option).  Perhaps something entirely different from th=
e
original, like

  Tr=C3=A4gt die angegebenen Dateien zus=C3=A4tzlich zur Bereitstellung=
 ein

  Tr=C3=A4gt die angegebenen Dateien zus=C3=A4tzlich zu jenen in der Be=
reitstellung ein

would be better.

>  #: builtin/config.c:64
>  msgid "remove all matches: name [value-regex]"

Not your fault or area of expertise, but most of the git-config options
seem to suffer the problem that there cannot be two (or more)
argument descriptors in the help.

I.e., right now it looks like

    --get                 get value: name [value-regex]                =
                               =20
    --get-all             get all values: key [value-regex]
    --get-regexp          get values for regexp: name-regex [value-rege=
x]

So far it's understandable, if a bit hard to read.  But this is very
confusing:

    --get-color <slot>    find the color configured: [default]

>  #: builtin/describe.c:406
>  msgid "use any tag in .git/refs/tags"
> -msgstr ""
> +msgstr "benutzt jede Markierung in .git/refs/tags"

alle Markierungen?

>  #: builtin/describe.c:416 builtin/name-rev.c:238
>  msgid "show abbreviated commit object as fallback"
> -msgstr ""
> +msgstr "zeigt als Reserve gek=C3=BCrztes Versionsobjekt"

fallback should be something like Ausweichl=C3=B6sung.  But how about

  zeigt gek=C3=BCrzte Versions-SHA, wenn sonst nichts zutrifft

>  #: builtin/fast-export.c:643
>  msgid "Dump marks to this file"
> -msgstr ""
> +msgstr "Anzeige von Kennzeichen f=C3=BCr diese Datei"
[...]
>  #: builtin/fast-export.c:645
>  msgid "Import marks from this file"
> -msgstr ""
> +msgstr "Importiert Kennzeichen von dieser Datei"

How did you manage to nail the second one, but get the first one wrong?
:-)

The first one should be "Schreibe Kennzeichen in diese Datei".


I got as far as (all from) builtin/fetch.c.  I'll post the rest in one
or two more batches as I get around to it.

Cheers,
Thomas


=46ootnotes:=20
[1]  http://vger.kernel.org/majordomo-info.html

--=20
Thomas Rast
trast@{inf,student}.ethz.ch

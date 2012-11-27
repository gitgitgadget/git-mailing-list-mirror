From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [RFC/PATCH] l10n: de.po: translate 825 new messages
Date: Tue, 27 Nov 2012 12:44:04 +0100
Message-ID: <87wqx7s22j.fsf@pctrast.inf.ethz.ch>
References: <1349200849-7436-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, <jk@jk.gs>, <stimming@tuhh.de>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 12:50:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdJgT-0004ft-Ml
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 12:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689Ab2K0LuU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2012 06:50:20 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:33894 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322Ab2K0LuT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 06:50:19 -0500
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2012 06:50:18 EST
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 27 Nov
 2012 12:44:00 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 27 Nov 2012 12:44:04 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210559>

Hi Ralf,

This is the middle third of my review.  Sorry for the long wait!  I hop=
e
it can still be useful.

Also, sorry for the other mail that I just sent out seconds ago.  That
was what I wanted to save as "to be done in the last third", but
I accidentally hit the wrong key and sent it out.

- Thomas


> @@ -4459,6 +4423,8 @@ msgstr ""
>  #: builtin/fmt-merge-msg.c:13
>  msgid "git fmt-merge-msg [-m <message>] [--log[=3D<n>]|--no-log] [--=
file <file>]"
>  msgstr ""
> +"git fmt-merge-msg [-m <Beschreibung>] [--log[=3D<Anzahl>]|--no-log]=
 [--file "
> +"<Datei>]"
> =20
>  #: builtin/fmt-merge-msg.c:653 builtin/fmt-merge-msg.c:656 builtin/g=
rep.c:786
>  #: builtin/merge.c:188 builtin/show-branch.c:656 builtin/show-ref.c:=
192
> @@ -4468,115 +4434,111 @@ msgstr "Anzahl"
> =20
>  #: builtin/fmt-merge-msg.c:654
>  msgid "populate log with at most <n> entries from shortlog"
> -msgstr ""
> +msgstr "f=C3=BCgt Historie mit h=C3=B6chstens <Nummer> Eintr=C3=A4ge=
n von \"shortlog\" hinzu"

I don't really share your apparent aversion to just using "<n>" :-)

>  #: builtin/for-each-ref.c:994
>  msgid "quote placeholders suitably for shells"
> -msgstr ""
> +msgstr "quotiert Platzhalter geeignet f=C3=BCr Shells"
[...]
>  #: builtin/for-each-ref.c:996
>  msgid "quote placeholders suitably for perl"
> +msgstr "quotiert Platzhalter geeignet f=C3=BCr Perl"
[etc]

"quote" is a hard one, and "quotiert" sounds very wrong to me.  How
about weaseling out along the lines of

  Formatiert Platzhalter als {Shell|Perl|Python|TCL} Zeichenfolge

or even "Shell-String".

>  #: builtin/for-each-ref.c:1003
>  msgid "show only <n> matched refs"
> -msgstr ""
> +msgstr "zeigt nur <Nummer> passende Referenzen"

This should be <Anzahl> if you insist on translating the 'n'.

>  #: builtin/for-each-ref.c:1006
>  msgid "field name to sort on"
> -msgstr ""
> +msgstr "Name des Felder zum Sortieren"

=46eld_s_?

Or just "sortiere nach diesem Feld".

>  #: builtin/fsck.c:618
>  msgid "make index objects head nodes"
> -msgstr ""
> +msgstr "erzeugt Kopfknoten der Bereitstellungsobjekte"

The English version is equally obscure, but this refers to (also)
walking the objects listed in the index.  Furthermore, --cache is
actually the default if you don't list any objects to walk.

>  #: builtin/fsck.c:620
>  msgid "also consider packs and alternate objects"
> -msgstr ""
> +msgstr "betrachtet auch Pakete und wechselnde Objekte"

The glossary tells me pack -> Archiv.

An alternate object [store] is essentially a pointer to the object stor=
e
of another repository.  It may best be left untranslated, as it's a
pretty advanced feature.

>  #: builtin/grep.c:741
>  msgid "match patterns only at word boundaries"
> -msgstr ""
> +msgstr "findet Muster nur innerhalb von W=C3=B6rtern"

The translation gets the purpose wrong: the option forces a
word-boundary match on either side of the pattern, so that you will fin=
d
only one or more words matching the pattern.  The manpage has a precise
definition:

	Match the pattern only at word boundary (either begin at the
	beginning of a line, or preceded by a non-word character; end at
	the end of a line or followed by a non-word character).

Maybe "suche nur ganze W=C3=B6rter" would suffice as a concise descript=
ion.

>  #: builtin/grep.c:817
>  msgid "indicate hit with exit status without output"
> -msgstr ""
> +msgstr "kennzeichnet =C3=9Cbereinstimmungen mit Beendigungsstatus, o=
hne Ausgabe"

The "indicate" should be "zeigen" or some such, since it only tells
whether there were any matches at all.

I spent some time looking for a better translation of "exit status", bu=
t
couldn't find anything helpful (such as a German translation of diff(1)
or a Wikipedia page on "exit status").

>  #: builtin/hash-object.c:77
>  msgid "process file as it were from this path"
> -msgstr ""
> +msgstr "verarbeitet Datei, wie es von diesem Pfad w=C3=A4re"

als ob sie von diesem Pfad w=C3=A4re?

>  #: builtin/help.c:47
>  msgid "show info page"
> -msgstr ""
> +msgstr "zeigt Informationsseite"

info here refers to GNU info, presumably it should be left as
"info-Seite" or some such.

>  #: builtin/index-pack.c:1106
>  msgid "confusion beyond insanity"
> @@ -5150,12 +5111,12 @@ msgstr "Fehler beim Aufl=C3=B6sen der Untersc=
hiede"
>  #: builtin/index-pack.c:1112
>  #, c-format
>  msgid "completed with %d local objects"
> -msgstr ""
> +msgstr "fertiggestellt mit %d lokalen Objekten"

*vervollst=C3=A4ndigt* mit %d lokalen Objekten

>  #: builtin/log.c:102
>  msgid "decorate options"
> -msgstr ""
> +msgstr "Ausgabeoptionen"

'decorate' is the option to mark commits by the refs pointing at them,
and should probably not be translated.

The English version is quite tautological though, since it just turns
into

    --decorate[=3D...]      decorate options

>  #: builtin/log.c:1091
>  msgid "don't include a patch matching a commit upstream"
>  msgstr ""
> +"schlie=C3=9Ft keine Patches ein, die einer Version im externen Proj=
ektarchiv "
> +"entsprechen"

Upstream refers to the notional upstream state, which does not even hav=
e
to be a branch here.  I.e., if you say

  git format-patch --ignore-if-in-upstream <commit>

then it will format the range 'commit..HEAD', ignoring patches that are
already in 'HEAD..commit'.

So it's not an upstream repo, and in fact doesn't even have to be a
branch.  I don't really have a good suggestion though.  Perhaps you can
still call it "im =C3=9Cbernahmezweig", since the original makes the sa=
me
mistake.

>  #: builtin/log.c:1095
> -#, fuzzy
>  msgid "Messaging"
> -msgstr "Zusammenf=C3=BChrung:"
> +msgstr "Datentransfer"

"Email-Einstellungen"?

>  #: builtin/log.c:1096
> -#, fuzzy
>  msgid "header"
> -msgstr "voraus "
> +msgstr "Kopfteil"
> =20
>  #: builtin/log.c:1097
>  msgid "add email header"
> -msgstr ""
> +msgstr "f=C3=BCgt Kopfteil f=C3=BCr eMail hinzu"

Does anyone call them anything except "headers" in german?

I can even quote a (non)reference:

  http://de.wikipedia.org/wiki/E-Mail#Header_.E2.80.93_der_Kopf_der_E-M=
ail

>  #: builtin/log.c:1108
> -#, fuzzy
>  msgid "inline the patch"
> -msgstr "ignoriert hinzugef=C3=BCgte Zeilen des Patches"
> +msgstr "f=C3=BCgt einen Patch ein"

f=C3=BCgt den Patch direkt in die Nachricht ein

>  #: builtin/ls-files.c:463
>  msgid "identify the file status with tags"
> -msgstr ""
> +msgstr "bestimmt den Dateistatus mit Markierungen"

*zeigt* den Dateistatus mit Markierungen

>  #: builtin/merge.c:189
>  msgid "add (at most <n>) entries from shortlog to merge commit messa=
ge"
>  msgstr ""
> +"f=C3=BCgt (h=C3=B6chstens <Nummber>) Eintr=C3=A4ge von \"short\" zu=
r Beschreibung der "
                        ^^^
typo  -------------------=C2=B4

> +"Zusammenf=C3=BChrung hinzu"

=46urthermore, you changed 'shortlog' to '"short"'.  Presumably you mea=
nt
to keep the 'log' too?

>  #: builtin/notes.c:617
>  msgid "load rewriting config for <command> (implies --stdin)"
>  msgstr ""
> +"l=C3=A4dt Konfiguration f=C3=BCr <Kommando> beim =C3=9Cberschreiben=
 von Versionen "
> +"(impliziert --stdin)"

This would be a good time to settle on a good translation for
"rewriting".  Perhaps "neu schreiben".  "=C3=9Cberschreiben" to me impl=
ies
that it's done in-place, but the whole point of calling it "rewriting"
instead of "changing" is that it is *not* done (or indeed possible to
do) in-place.

>  #: builtin/pack-objects.c:2502
>  msgid "create thin packs"
> -msgstr ""
> +msgstr "erzeugt kleinere Pakete"

Smaller is not really the point: they are packs that do not have the
delta bases.  It can only be used in the context of a repository that
has them.  A thin pack is used only(?) in network transfer, and then
"completed" by adding the delta bases to it, which lets it stand on its
own.

You could call them "abgespeckt" ;-)


--=20
Thomas Rast
trast@{inf,student}.ethz.ch

From: "Stephan Beyer" <s-beyer@gmx.net>
Subject: Re: [PATCH] gitk: Update German translation
Date: Sat, 03 May 2008 03:24:19 +0200
Message-ID: <20080503012419.327120@gmx.net>
References: <200805012142.10151.stimming@tuhh.de>
 <20080501211004.GE7868@leksak.fem-net> <200805022123.22333.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, paulus@samba.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sat May 03 03:25:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js6Uw-0003BO-TX
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 03:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758773AbYECBYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 21:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759330AbYECBYW
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 21:24:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:55232 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758326AbYECBYW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 21:24:22 -0400
Received: (qmail 4234 invoked by uid 0); 3 May 2008 01:24:19 -0000
Received: from 89.49.41.92 by www167.gmx.net with HTTP;
 Sat, 03 May 2008 03:24:19 +0200 (CEST)
In-Reply-To: <200805022123.22333.stimming@tuhh.de>
X-Authenticated: #1499303
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX1/wkxVcvjvwp0VGJtSKnxIVygFRZcjV5PoScNdAhP
 ZYZGgDr+xlIX3Lceul5XGKIm/5tqtIAUBUyw== 
X-GMX-UID: rdN5HI9fbXB+bcKSJDQ2hyQiLyUmZQhO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81057>

Hi,

> That glossary and the git-gui translation was created by myself as we=
ll.

And you did a great job doing it. ;)

> Hence, translations for terms like "commit" have indeed been discusse=
d
> quite a bit,

It's ok then. I didn't know that there was big discussion about that.=20
Thanks for the links.

> > >  msgid "Reading commits..."
> > >  msgstr "Versionen lesen..."
> >
> > Is "Version" really the German translation for "commit" throughout =
the
> > whole git suite?
> > (Ehh, is git translated at all?)
> > I'd recommend "Commit" or "Eintragung"...
>=20
> "Version" is what came out as most convincing from last September's=20
> discussion. "Commit" is only for those who want the English version
> anyway, hence that's not the target audience of this translation.

I understand the point for using "Version" as the German translation fo=
r
the noun "commit" (seems to be the best choice), but I think I have a=20
different view on the target audience of the translation. :-)

I think, most of the users of a translated git-gui or gitk are not peop=
le
who do not understand an English word at all. I think, they just like t=
o
act in a localized environment.
But SCM tool users of any nationality usually know what a "commit" is,
so I see nothing bad in using "Commit" in the German translation.
And the German word "Version" is a broader term that can lead to some
misunderstanding; the English word "commit" used in German sentences
is a clear technical term for SCM tool users.

It's the typical problem in German technical literature. There is the o=
ne
type where every technical term is translated to a German word in the h=
ope
that it will be easier to understand but could also leave the reader in=
=20
some confusion because she has another understanding of the known word.
And there is the other type, where technical terms are kept untranslate=
d=20
to let the readers easily understand original English literature=20
but also resulting in a lot of "denglisch" sentences.
So a really good translation of technical literature and its technical=20
terms is pretty hard.

The most German translations in the free software world are translated
using the first, the "translate every term" paradigm. So it seems good
to me that gitk/git-gui follows that way. Nevertheless, just because of=
=20
this paradigm I switched back to the original/English versions. ;)

> > "nach vorne gehen" sounds so colloquial.
> > Better, perhaps: "weitergehen"?
>=20
> Ok. "weitergehen" IMHO has a similar problem as the first/last issue =
- the
> user doesn't know which direction is meant.

Mh, I thought that "nach vorne" and "weiter" have the same meaning here=
=2E
But perhaps I'm wrong.

> But your proposal is better than the colloquial term.

I don't know if colloquial terms are really bad in software.
Perhaps it depends on the software. E.g. in games or fun tools it can b=
e nice.

> > > -#: gitk:6081
> > > +#: gitk:6143
> > >  msgid "Error creating patch:"
> > >  msgstr "Fehler beim Patch erzeugen:"
> >
> > "Fehler bei der Erzeugung des Patches"
>=20
> I agree the original string is sub-optimal, but "Erzeugung"? Also not=
 a
> nice word. Anything better?

Sorry, I meant "Fehler beim Erzeugen des Patches"
as in
 > > >  msgid "Error writing commit:"
 > > >  msgstr "Fehler beim Version eintragen:"
 > > [...]
 > "Fehler beim Schreiben der Version" it is, thanks.
(which also could be "Fehler beim Eintragen der Version")

The reason for my correction is that "beim Version eintragen"
is wrong according to my last look at the German grammar rules,
but note that I'm not up-to-date ;-)
A correct choice could be something like "beim Versionseintragen"=20
or "beim Version-Eintragen" (or Version-eintragen?) Not sure.
So I thought using the Genitive case is a good choice.

Btw, I'm convinced that every German will also understand your
original translation.

> > >  msgid "containing:"
> > >  msgstr "enthaltend:"
> >
> > "enth=E4lt:"
>=20
> No. Please have a look at the place where this is used.

I did. But you are right that my proposal is wrong.

> In fact this word is used as the part of a full sentence=20
> (which in itself is very bad i18n style, but that's another discussio=
n),
> and the sentence reads "Suche n=E4chste/vorige Version enthaltend:".

My mistake was that I began reading at "Version"... ;)

> The sentence is already quite "holprig"

The original
 "Find next/prev commit _containing:_ [insert]"
should be translated to
 "Suche n=E4chste/vorige Version, die [insert] enth=E4lt."
But this is beyond the used techniques for software translation ;-)

Looking at the other two cases:
 "Find next/prev commit _touching paths:_ [insert]"
and
 "Find next/prev commit _adding/removing String:_ [insert]"
and looking what they are actually doing,
I come to another solution that should make it clear:
 1. "Suche n=E4chste/vorige Version _nach Beschreibung:_ [insert]"
 2. "Suche n=E4chste/vorige Version _nach Pfaden:_ [insert]"
    (or maybe "nach Dateien:", if it's commonly accepted that=20
     directories are files, too.)
 3. "Suche n=E4chste/vorige Version _nach =C4nderungen:_ [insert]"
(This is btw a very cool feature and a reason to use gitk more often.)

> > >  msgid "IgnCase"
> > >  msgstr "Kein Gro??/Klein"
> >
> > The translation is rather ambiguous. Or is it just me? ;)
> > "Ignoriere Gro=DF-/Kleinschreibung"  or
> > "Gro=DF-/Kleinschreibung ignorieren"
>=20
> In principle yes, but again please have a look at where this string
> actually appears in the program. The multichoice box there really mus=
t
> not be very wide.

Ah ok. I got in a hurry when writing the last mail, but I wondered
why there's "IgnCase" and not "Ignore case".
Hmmm, so I'd possibly take "Gro=DF/klein egal" which has the same lengt=
h
as yours but yours is also good, since it's not ambiguous to me anymore=
,
because another choice of the multichoice box is "exakt" ;-)

> > >  msgid "Cherry-pick this commit"
> > >  msgstr "Diese Version pfl??cken"
> >
> > If I didn't knew that it means "cherry-pick", I'd have no idea
> > what the function behind that German words does. ;-)
>=20
> No, you're missing the point again. If you didn't knew what "cherry-p=
ick"=20
> means, you would have no idea what the function behind it does.

Right, but if I know what "cherry-pick" means, I could still have no id=
ea
what the function behind "Version pfl=FCcken" does.
A word-by-word translation like "Kirsche pfl=FCcken" would also result =
in a
grinning me (as a user), but I'd recognize it as the 'git-cherry-pick'=20
that I know.

> In other words: Git invented a new word here anyway.

No, "cherry picking" is a commonly used term.

I wonder what a commonly used German phrase with a similar meaning is..=
=2E
Something like "sich die Rosine(n) herauspicken"? (Is this a common phr=
ase?)
But a translation to "Diese Rosine herauspicken" is also confusing.
("Warum ist dieser Commit eine Rosine?=20
  Was passiert, wenn ich sie herauspicke?
  Ist er dann weg?")

> It *is* an argument if the actual action can be described in a better
> and more understandable way by a different German word, though.

Yes.
A user of the English version might also need to know what=20
git-cherry-pick does before clicking on "Cherry-pick this commit".
Or does this come by intuition?=20
(Hard to see for me, as I'm no native English speaker.)

> > "Diesen Commit =FCbernehmen"
> > "Diesen Commit kopieren"
> > "Diese Eintragung =FCbernehmen"
>=20
> "Diese Version kopieren" would be one possibility - but this bears th=
e=20
> question why git itself doesn't call this action "to copy a commit".

To confuse the translation issue. ;-)

> "Version kopieren" rather sounds like the familiar "copy to clipboard=
"
> action in the Edit menu,

Good point.

Btw, 'man git-cherry-pick' says
        "Apply the change introduced by an existing commit".
So why not take this and use
 "Durch diese Version eingef=FChrte =C4nderungen =FCbernehmen" or
 "Durch diese Version eingef=FChrte =C4nderungen anwenden"?

Regards,
  Stephan
--=20
GMX startet ShortView.de. Hier findest Du Leute mit Deinen Interessen!
Jetzt dabei sein: http://www.shortview.de/?mc=3Dsv_ext_mf@gmx

From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] gitk: Update German translation
Date: Fri, 2 May 2008 21:23:22 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200805022123.22333.stimming@tuhh.de>
References: <200805012142.10151.stimming@tuhh.de> <20080501211004.GE7868@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri May 02 22:13:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js1co-0004pL-Au
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 22:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761388AbYEBUMH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 16:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761130AbYEBUMG
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 16:12:06 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:34417 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656AbYEBUMD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2008 16:12:03 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m42KBxMi020645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 2 May 2008 22:11:59 +0200
Received: from [192.168.2.102] (p5490016D.dip0.t-ipconnect.de [84.144.1.109])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m42KBva3003397
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 May 2008 22:11:58 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <20080501211004.GE7868@leksak.fem-net>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81031>

Am Donnerstag, 1. Mai 2008 23:10 schrieb Stephan Beyer:
> > I'd propose to talk about the newest or topmost commit,
> > but rather not about the "first".
>
> I agree, but s/newest/latest/ :)

Both is possible, and a third alternative is "most recent". I couldn't =
care=20
less, as long as we get away from the ambiguous "first".

> Well.
> Although your patch does not cover the translations itself (and altho=
ugh
> I neither use the German translation of gitk and use gitk very seldom=
 at
> all), I've taken a look at the given translations and want to drop so=
me
> comments/corrections.

Thanks for the feedback about the German translation. Indeed there is n=
o git=20
translation into German, at least none that I know of so far. What exis=
ts is=20
the translation of git-gui which includes a glossary of terms that are =
used=20
throughout git-gui (and git). That glossary and the git-gui translation=
 was=20
created by myself as well. At the time when the glossary was created, i=
t was=20
also discussed here in the list quite a lot, see=20
http://article.gmane.org/gmane.comp.version-control.git/53181 and more=20
importantly this whole thread=20
http://kerneltrap.org/mailarchive/git/2007/9/16/269956 (somehow gmane.o=
rg=20
doesn't have this thread available?!?)

Hence, translations for terms like "commit" have indeed been discussed =
quite a=20
bit, and I'm quite satisfied with the current wording. You're welcome t=
o=20
propose alternatives, but please be prepared to give really good reason=
s as=20
for why an alternative is really better than the current version.

Nevertheless thanks a lot for the typos you spotted. I'll list those th=
at are=20
easy and I agree upon first, and I'll comment on the other and more dif=
ficult=20
words later.

+++ The easy ones:

> > -#: gitk:264
> > +#: gitk:275
> >  msgid "Can't parse git log output:"
> >  msgstr "Git log Ausgabe kann nicht erkannt werden:"
>
> "git-log-Ausgabe" oder "Ausgabe von git-log"

Ok.

> > -#: gitk:650
> > +#: gitk:665
> >  msgid "List references"
> >  msgstr "Zweige auflisten"
>
> Hm, the button lists branches and tags.
> Is then "Zweige" (=3D branches) only correct?
> What about "Referenzen auflisten" or "Zweige/Markierungen auflisten"
> (or however "tags" is translated).

Ok.

> > -#: gitk:7966
> > +#: gitk:8024
> > +msgid "Auto-select SHA1"
> > +msgstr "SHA1 Hashwert automatisch markieren"
>
> "SHA1-Hashwert"

Ok.

> > -#: gitk:7985
> > +#: gitk:8048
> >  msgid "Background"
> >  msgstr "Vordergrund"
> >
> > -#: gitk:7989
> > +#: gitk:8052
> >  msgid "Foreground"
> >  msgstr "Hintergrund"
>
> Funny. It's vice versa!

Thanks a lot! No idea why nobody saw this so far, including me.

> > -#: gitk:8587
> > +#: gitk:8656
> >  msgid ""
> >  "No files selected: --merge specified but no unmerged files are wi=
thin
> > file " "limit."
> > @@ -720,6 +891,6 @@ msgstr ""
> >  "Keine Dateien ausgew??hle:=20
>                             ^
> 			    t

Ok, thanks.

> > +#: gitk:1354
> > +msgid "<Left>, z, j\tGo back in history list"
> > +msgstr "<Links>, z, j\tEine Version zur??ck gehen"
>
> I think it's still "zur=C3=BCckgehen" and not "zur=C3=BCck gehen" in =
the latest
> German spelling.

Ok.

> > +#: gitk:1355
> > +msgid "<Right>, x, l\tGo forward in history list"
> > +msgstr "<Rechts>, x, l\tEine Version nach vorne gehen"
>
> "nach vorne gehen" sounds so colloquial.
> Better, perhaps: "weitergehen"?

Ok. "weitergehen" IMHO has a similar problem as the first/last issue - =
the=20
user doesn't know which direction is meant. But your proposal is better=
 than=20
the colloquial term.

> > -#: gitk:5719
> > +#: gitk:5781
> >  msgid "SHA1 ID:"
> >  msgstr "SHA1 Kennung:"
>
> Somewhere else it has been translated to "SHA1:", which is imho bette=
r.
> Otherwise it'd be "SHA1-Kennung".

The latter. Thanks. As for why it was "SHA1:" in one string, I'll expla=
in=20
below.

> > -#: gitk:6233
> > +#: gitk:6291
> >  msgid "Error writing commit:"
> >  msgstr "Fehler beim Version eintragen:"
>
> "Fehler bei der Eintragung:"
> "Fehler beim Schreiben der Eintragung:" (or "Version", if really used=
 in
> other places)

"Fehler beim Schreiben der Version" it is, thanks.


+++ Now the more difficult ones

> > -#: gitk:141 gitk:2143
> > +#: gitk:151 gitk:2191
> >  msgid "Reading commits..."
> >  msgstr "Versionen lesen..."
>
> Is "Version" really the German translation for "commit" throughout th=
e
> whole git suite?
> (Ehh, is git translated at all?)
> I'd recommend "Commit" or "Eintragung"...
>
> "Version" is so CVS/SVN-like.

"Version" is what came out as most convincing from last September's=20
discussion. "Commit" is only for those who want the English version any=
way,=20
hence that's not the target audience of this translation. "Eintragung" =
would=20
indeed be one possibility, but when I explain how git works to other Ge=
rmans,=20
I would always talk about the "Versionen" that you can browse and merge=
 and=20
add. The word works quite nicely, which is another argument for it. On =
the=20
other hand I don't understand how "is so CVS-like" would be any argumen=
t in=20
favor or against this particular German word.

> > -#: gitk:782 gitk:784 gitk:2308 gitk:2331 gitk:2355 gitk:4257 gitk:=
4320
> > +#: gitk:797 gitk:799 gitk:2356 gitk:2379 gitk:2403 gitk:4306 gitk:=
4369
> >  msgid "containing:"
> >  msgstr "enthaltend:"
>
> "enth=C3=A4lt:"

No. Please have a look at the place where this is used. In fact this wo=
rd is=20
used as the part of a full sentence (which in itself is very bad i18n s=
tyle,=20
but that's another discussion), and the sentence reads "Suche n=C3=A4ch=
ste/vorige=20
Version enthaltend:". The sentence is already quite "holprig" and I'm s=
orry=20
for that, but at least it is still gramatically correct. Using "enth=C3=
=A4lt"=20
would make it gramatically wrong. Same for the other following strings =
that=20
you mentioned.

> > -#: gitk:786 gitk:2388
> > +#: gitk:801 gitk:2436
> >  msgid "adding/removing string:"
> >  msgstr "String dazu/l??schen:"
>
> "=C3=A4ndert Zeichenkette:"

Hm... I'd say "Zeichenkette =C3=A4ndernd", but thinking about it, I'm n=
ot even sure=20
anymore whether this is what this criterion will search for?

> > -#: gitk:797 gitk:2466 gitk:4225
> > +#: gitk:812 gitk:2514 gitk:4274
> >  msgid "IgnCase"
> >  msgstr "Kein Gro??/Klein"
>
> The translation is rather ambiguous. Or is it just me? ;)
> "Ignoriere Gro=C3=9F-/Kleinschreibung"  or
> "Gro=C3=9F-/Kleinschreibung ignorieren"

In principle yes, but again please have a look at where this string act=
ually=20
appears in the program. The multichoice box there really must not be ve=
ry=20
wide. That's why I came up with this weird short form=20
of "Gro=C3=9F-/Kleinschreibung ignorieren", but the original string is =
just as=20
well already a weird abbreviation.

> > -#: gitk:1026
> > +#: gitk:1061
> >  msgid "Cherry-pick this commit"
> >  msgstr "Diese Version pfl??cken"
>
> If I didn't knew that it means "cherry-pick", I'd have no idea
> what the function behind that German words does. ;-)
> (That's why I don't have locales set to my mother tongue. Just becaus=
e I
> only have to understand the programmer and not the translator first.)

No, you're missing the point again. If you didn't knew what "cherry-pic=
k"=20
means, you would have no idea what the function behind it does. In othe=
r=20
words: Git invented a new word here anyway. Hence, a new word will appe=
ar in=20
the translation, too, and it isn't an argument that you didn't recogniz=
e it=20
as your familiar english word at first. It *is* an argument if the actu=
al=20
action can be described in a better and more understandable way by a=20
different German word, though.

> "Diesen Commit =C3=BCbernehmen"
> "Diesen Commit kopieren"
> "Diese Eintragung =C3=BCbernehmen"

"Diese Version kopieren" would be one possibility - but this bears the=20
question why git itself doesn't call this action "to copy a commit". To=
=20
me, "Version kopieren" rather sounds like the familiar "copy to clipboa=
rd"=20
action in the Edit menu, but it misses the part that this commit will=20
immediately be committed (heh) to the currently checked out branch.

> > -#: gitk:6081
> > +#: gitk:6143
> >  msgid "Error creating patch:"
> >  msgstr "Fehler beim Patch erzeugen:"
>
> "Fehler bei der Erzeugung des Patches"

I agree the original string is sub-optimal, but "Erzeugung"? Also not a=
 nice=20
word. Anything better?

Thank you very much for your feedback!

Regards,

Christian

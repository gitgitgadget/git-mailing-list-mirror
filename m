From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] gitk: Update German translation
Date: Wed, 7 May 2008 22:56:50 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200805072256.50520.stimming@tuhh.de>
References: <200805012142.10151.stimming@tuhh.de> <200805022123.22333.stimming@tuhh.de> <20080503012419.327120@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Stephan Beyer" <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed May 07 22:57:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtqhx-0003U9-9t
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 22:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111AbYEGU47 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 May 2008 16:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754998AbYEGU47
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 16:56:59 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:54916 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996AbYEGU45 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 May 2008 16:56:57 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m47KurfA011177
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 7 May 2008 22:56:54 +0200
Received: from [192.168.2.102] (p5490218D.dip0.t-ipconnect.de [84.144.33.141])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m47KuqcR032660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 May 2008 22:56:53 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <20080503012419.327120@gmx.net>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81478>

Hi Stephan,

thanks for your feedback. I won't have time to answer this in detail un=
til end=20
of next week. I'll just highlight a few things:

* Translation "commit" - "Version": Indeed this depends on the target=20
audience. Those who prefer the english terms IMHO are by definition no =
longer=20
the target audience. That's why I prefer this German word in the transl=
ation.=20
By the way, I strongly suggest reading the German TortoiseSVN documenta=
tion -=20
IMHO they've created a really good translation.

Am Samstag, 3. Mai 2008 03:24 schrieb Stephan Beyer:
> > In fact this word is used as the part of a full sentence
> > (which in itself is very bad i18n style, but that's another discuss=
ion),
> > and the sentence reads "Suche n=E4chste/vorige Version enthaltend:"=
=2E
>
> My mistake was that I began reading at "Version"... ;)
>
> > The sentence is already quite "holprig"
>
> The original
>  "Find next/prev commit _containing:_ [insert]"
> should be translated to
>  "Suche n=E4chste/vorige Version, die [insert] enth=E4lt."
> But this is beyond the used techniques for software translation ;-)

Yes. But maybe even without GUI modifications this can be translated in=
 a=20
better way. Eventually, I would expect something like this:

  Suchen: N=E4chste / vorige Fundstelle mit Kriterium 'Enth=E4lt Zeiche=
nkette':=20
[insert]

IMHO this shouldn't be one single sentence which is what the current en=
glish=20
GUI tries to mimic. Instead, this should be something with a heading an=
d a=20
choicebox for the criteria and appropriate labels for those. Maybe we c=
an=20
come up with a translation that already does this - the above sentence =
was a=20
quick thought but there are surely better ways to do this.

> > > >  msgid "Cherry-pick this commit"
> > > >  msgstr "Diese Version pfl=FCcken"
>
> > In other words: Git invented a new word here anyway.
>
> No, "cherry picking" is a commonly used term.
>
> I wonder what a commonly used German phrase with a similar meaning is=
=2E..
> Something like "sich die Rosine(n) herauspicken"? (Is this a common
> phrase?) But a translation to "Diese Rosine herauspicken" is also
> confusing. ("Warum ist dieser Commit eine Rosine?
>   Was passiert, wenn ich sie herauspicke?
>   Ist er dann weg?")

Good point. We shouldn't come up with "Rosinen" here. Maybe "herauspick=
en",=20
but then "pfl=FCcken" can work as well. Branches are called "Zweige", s=
o it's=20
not too far-fetched to have an action for "etwas von einem Zweig pfl=FC=
cken".

> Btw, 'man git-cherry-pick' says
>         "Apply the change introduced by an existing commit".
> So why not take this and use
>  "Durch diese Version eingef=FChrte =C4nderungen =FCbernehmen" or
>  "Durch diese Version eingef=FChrte =C4nderungen anwenden"?

This is indeed a case where a better translation can still be found. Ho=
wever,=20
all of "kopieren, =FCbernehmen, anwenden" IMHO sound too similar to act=
ions=20
that already appear here or there in the version control GUI. Cherry-pi=
cking=20
is a specialized action and should thus get a specialized German word.=20

Regards,

Christian

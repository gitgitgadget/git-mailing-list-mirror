From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Thu, 16 Sep 2010 12:57:51 +0200
Message-ID: <20100916125751.163d8691@jk.gs>
References: <20100915093313.44396t6yr62ixccg@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, avarab@gmail.com, git <git@vger.kernel.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Thu Sep 16 12:58:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwCAE-00071a-9F
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 12:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab0IPK55 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 06:57:57 -0400
Received: from zoidberg.org ([88.198.6.61]:41522 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422Ab0IPK54 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 06:57:56 -0400
Received: from jk.gs (p4FDBFDAA.dip.t-dialin.net [::ffff:79.219.253.170])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 16 Sep 2010 12:57:54 +0200
  id 0040017D.4C91F832.00001C5B
In-Reply-To: <20100915093313.44396t6yr62ixccg@webmail.tu-harburg.de>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156316>

Christian Stimming <stimming@tuhh.de> wrote:

> As you might guess, as the (initial) translator of git-gui I've been =
=20
> through this discussion before [1] and as you have noticed, I have =20
> decided to take a translation approach different from what you have =20
> recently discussed here. I deliberately tried to translate as much
> of the terms into German as possible. I do not agree about the
> importance of statements on this mailing list like "This translation
> translates too much terms - I cannot find the commands I'm used to".
> The point of a translation is to enable the usage of a program to
> people who do *not* know the original language.

Please explain how translating all terms makes it easier for Germans to
work with git. As far as I am concerned, all the terms you tried so
hard to translate are technical terms, i.e. their full meaning cannot b=
e
readily understood without an explanation. That is the reason why we
have a glossary for those terms even in the English original.

Translating these terms into German does not change anything about
that. All terms still need to be explained.

There is some slight potential gain in that perhaps *some* translated
words will be more easily associated with their corresponding
explanations due to the imagery they use, but at the same time there is
a cost. I have never met anyone with experience with revision control
who used Germanized technical terms. If you never introduce new folks
to the terms that are actually used, they are in for a whole world of
communication problems.

There has always been opposition to borrowing words from other
languages, but it's the way language develops. Nobody says
"Haareschneider" or "Senf-Eier-Paste" or "d=C3=BCnne Nudelteigf=C3=A4de=
n". Nobody
says "Kompaktscheibe" or "Systemstartverwalter" or
"grafisches Dokumentabtastger=C3=A4t". If I used those words out of the
conviction that rigorously translating everything is a good thing,
people who have difficulty understanding me if I casually used some of
those (and I can think of lots more).

I don't actually think that translating words is bad, but I'd rather
keep the original word than translate it to something that either
doesn't map to the concept half as well or something that is simply
extremely unwieldy.

There are quite a few examples in the git-gui translation that I
consider extremely unwieldy, and in my initial translation of git
itself I tried very hard to avoid translations like "Bereitstellung
(zum Eintragen)", where I have absolutely no idea what that is supposed
to mean. I don't want to turn this into a critique of git-gui's
translation, though.=20

> [...] a translation is for people who do neither know nor understand
> the English wording for the git concepts.

Yes, but when you are first introduced to the words as an English
speaker, you don't=C2=A0understand the concepts either. This part of th=
e
learning curve cannot be eliminated.

> Wikipedia is a bad reference for measuring the importance of certain =
=20
> things. I (or you) could have easily adapted that article to my
> point of view before continuing the discussion.

But neither of us have, right? We're adults, after all. You're free to
assume that Wikipedia doesn't reflect some kind of social consensus. I
do assume that, moreso than I assume that Wikipedia is accurate.

> However, in this particular case that article doesn't even mention
> many of the terms which need to be discussed in a git glossary.

Of course not... but it reflects a tendency for terms to not be
translated.

> >  branch                Branch (m.) =20
>
> I'd go for "Zweig". It's even on the wikipedia page and it perfectly =
=20
> represents the concept.

My main reason for not translating this one is that we have a command
called "branch" and since people need to learn what it means anyway,
and we're certainly not going to change the command names in different
languages, translating the term in other uses just means that German
users have to remember two different words for the same thing. Similar
reasoning applies to some other terms.

> >  index                 Index
>=20
> I'd strongly vote for not using "Index". The "Index" is where the =20
> "Bundespr=C3=BCfstelle f=C3=BCr jugendgef=C3=A4hrdende Schriften" put=
s the =20
> Ballerspiele on. Don't let the identical word fool you into thinking =
=20
> this is a worthwhile translation. Also, the English term is a bad =20
> naming anyway IMHO. I'd use git-gui's replacement (staging area) and =
=20
> use "Bereitstellung" here as well. Feel free to propose something =20
> different, but please not "Index". Git isn't FSK18.

So we should strike the word "Index" from casual and professional usage
when referring to the reference section of a book?

>=20
> >  commit (noun, verb)                Commit/committen
>=20
> That's a hard one. It sounds terrible to use "committen" in German.

True, but it beats the alternatives. I seriously can't think of any
German word that is equivalent to "commit" in the sense that we use it;
neither verb nor noun form. The command name reasoning applies here,
too.

> >  revision              Revision
>=20
> Die "Revision" kommt ins Haus, um die B=C3=BCcher zu pr=C3=BCfen. Hon=
estly, =20
> please don't use that word in German. Why not "Version"?

Sure, why not... though there are a *lot* of other meanings for the wor=
d
in German.

> >  tag                   Tag
>=20
> Der heutige Tag oder der morgige Tag? What's the problem with =20
> "Markierung"? This is exactky the git concept which is meant.

I believe that the English "tag" is a much better metaphor than the
German "Markierung". One use of "tag" refers to a small label that is
attached to, for example, baggage. This is exactly the concept we have
in git. "Markierung" doesn't come close at all to describing the same
concept. Conflicts markers are "Markierungen"; tags are not.
The command name reasoning applies here, too.

> >  tree                  Tree
>=20
> I would not understand what the "Tree" in German should be. Any
> German word instead?

Okay, fair enough.

Anyway, to conclude: I appreciate the feedback, but I think translating
all words is not as conducive to making git accessible to Germans as yo=
u
think.

-Jan

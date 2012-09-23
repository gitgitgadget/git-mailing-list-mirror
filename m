From: Sascha Cunz <sascha-ml@babbelbox.org>
Subject: Re: Message from 'git-rebase'; German translation
Date: Sun, 23 Sep 2012 17:41:55 +0200
Message-ID: <224751243.JXpXFWu6vV@blacky>
References: <1527028.GPe6zkelBV@blacky> <CAN0XMO+Dd9S7j9Ujudcy+O3GwwBX1CvRPQTYWxymmEu=2bg7ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 17:42:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFoJn-0005ED-DJ
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 17:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183Ab2IWPlz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 11:41:55 -0400
Received: from babbelbox.org ([83.133.105.186]:54596 "EHLO mail.babbelbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754008Ab2IWPly convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2012 11:41:54 -0400
Received: (qmail 20092 invoked from network); 23 Sep 2012 15:42:27 -0000
Received: from p54aecaae.dip.t-dialin.net (HELO blacky.localnet) (sascha@babbelbox.org@84.174.202.174)
  by babbelbox.org with ESMTPA; 23 Sep 2012 15:42:27 -0000
User-Agent: KMail/4.9.1 (Linux/3.5.3-gentoo; KDE/4.9.1; x86_64; ; )
In-Reply-To: <CAN0XMO+Dd9S7j9Ujudcy+O3GwwBX1CvRPQTYWxymmEu=2bg7ww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206243>

Am Sonntag, 23. September 2012, 17:04:15 schrieb Ralf Thielow:
> On Sat, Sep 22, 2012 at 11:57 PM, Sascha Cunz <sascha-ml@babbelbox.or=
g>=20
wrote:
> > As I know how hard translations can be, esp. with that much technic=
al
> > terms
> > inside, I'm usually expecting _not_ to yield the same result when
> > translating a software's translation back to English.
>=20
> Yeah, I think the goal is not making translations which are looking n=
early
> the same when somebody translates them back to English in the first p=
lace.

Exactly. The meaning is more important then the exact wording. Please c=
onsider=20
this:

	Es wurden Neuaufbau- / Zusammenf=FChrungs-Informationen gefunden.
	Falls ein Neuaufbau bereits im Gange ist, versuche bitte:
		git rebase (--continue | --abort | --skip)
	Sollte dies nicht der Fall sein, k=F6nnen die Informationen durch
		rm -fr "$(GIT_DIR)/rebase-merge"
	entfernt werden. Es wird angehalten, falls etwas Sch=FCtzenswertes
	gefunden werden sollte.

It sounds way cleaner (to me at least) and transports all of the meanin=
g. Esp.=20
for  the last sentence, it's very hard to find something in German that=
=20
doesn't sound 'destructive'.

Btw: In the past I've seen quite a few topics on translation on this li=
st - is=20
this at all the right place for that kind of discussion?

Sascha

> > However, git-rebase just threw these two sentences at me (And thoug=
h i
> > know
> > their meaning, i couldn't get the meaning from the message, it gave=
). Both
> > are in context of starting a rebase while one is already in progres=
s.
> >=20
> > first is:
> >=20
> > Original:
> > ... and I wonder if you are in the middle of another rebase.
> >=20
> > German git translation:
> > ... und es w=E4re verwunderlich, wenn ein Neuaufbau bereits im Gang=
e ist.
> >=20
> > And a re-translation back to English from my understanding as nativ=
e
> > German
> > speaker:
> > ... and it would be astonishing (=3Di'd be surprised), if a rebase =
was
> > already in progress.
>=20
> We try to avoid translating terms like "I wonder if.." and similar as
> "ich wundere mich", because it's very unusual in German messages
> of computer programs. Translators should have the freedom to reword
> terms a bit to make a more optimal translation, but the meaning must
> not be lost, and I can't say that this is the case.
> Translate the term "in the middle of"  word-by-word would result in
> "in der Mitte eines", which can be interpreted as a place somewhere
> or that an action is in progress. To avoid a possible confusion, we
> decided to translate this term as "im Gange sein" ("be in progress") =
in
> the whole translation. I also think that "in der Mitte einer Zusammen=
f=FChrung
> sein" doesn't sound really good. It tends to mean a place, not an act=
ion.
> > And second:
> >=20
> > Original:
> > I am stopping in case you still have something valuable there.
> >=20
> > German git translation:
> > Es wird angehalten, falls bereits etwas N=FCtzliches vorhanden ist.
> >=20
> > I wanted to point out that "etwas N=FCtzliches" is more "something =
useful"
> > that "something valuable". But the more I thought about it, the mor=
e it
> > started to
> I've been thinking about possible different translations, and the onl=
y
> one I have in
> mind is "wertvoll". But translating "valuable" as "wertvoll" ("bereit=
s
> etwas Wertvolles
> vorhanden") sounds a bit like "we've found a treasure", instead of
> something which
> has a value in the meaning of content. I think having a translation
> which is more
> like "useful" than "valuable" does also hit the point of the message,
> doesn't it?
>=20
> > confuse me (even the original text) - and now I feel like I don't
> > understand the meaning of the last sentence at all; neither in Engl=
ish
> > nor in the German translation:
> > After removing the directory with all rebase-information inside it,=
 WHERE
> > should something valuable still be left over? Is it referring to my
> > working
> > tree?
>=20
> Yeah, I think it means the working tree and/or the index which would =
make
> sense.
>=20
> Ralf
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

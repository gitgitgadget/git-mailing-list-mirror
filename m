From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI
	script
Date: Fri, 14 May 2010 19:58:06 +0400
Organization: '
Message-ID: <20100514155806.GC17443@screwed.box>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005111258.53388.jnareb@gmail.com> <20100511120924.GC5220@screwed.box> <201005111551.21316.jnareb@gmail.com> <20100513131016.GA5250@screwed.box> <AANLkTilnaHQ4Q8n3GOhYPcYAFi_tT8uSE_uTZhU_QYhK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Vereshagin <peter@vereshagin.org>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: ??var Arnfj??r?? Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 17:58:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCxHf-0002wo-ID
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 17:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab0ENP6i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 11:58:38 -0400
Received: from ns1.skyriver.ru ([89.108.118.221]:49853 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544Ab0ENP6h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 11:58:37 -0400
Received: from localhost (tor-relay.kkh.se [130.242.7.253])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 3CD225AAB;
	Fri, 14 May 2010 19:46:59 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <AANLkTilnaHQ4Q8n3GOhYPcYAFi_tT8uSE_uTZhU_QYhK@mail.gmail.com>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L (~u 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147095>

God love is hard to find. You got lucky ??var!
2010/05/13 17:13:12 +0000 ??var Arnfj??r?? Bjarmason <avarab@gmail.com>=
 =3D> To Peter Vereshagin :
vArB> 2010/5/13 Peter Vereshagin <peter@vereshagin.org>:
vArB> > Hey Mr(s) Jakub show some good to me!
vArB> > 2010/05/11 15:51:15 +0200 Jakub Narebski <jnareb@gmail.com> =3D=
> To Peter Vereshagin :
vArB> > JN> On Tue, 11 May 2010, Peter Vereshagin wrote:
vArB> > JN> > 2010/05/11 12:58:50 +0200 Jakub Narebski <jnareb@gmail.co=
m> =3D> To Peter Vereshagin :
vArB> > JN>
vArB> > JN> > > > > I have changed this 'exit' to non-local goto to top=
level. =9AIt could be
vArB> > JN> > > > > done instead by redefining 'exit' subroutine, like =
shown below, but I
vArB> > JN> > > > > feel that would be hacky if you can change gitweb c=
ode (it is not
vArB> > JN> > > > > black box you should not touch).
vArB> > JN> > > >
vArB> > JN> > > > Right, one shouldn't ever redefine perl built-in func=
tions. I did only because
vArB> > JN> > > > of no other way to 'get things working'
vArB> > JN> > >
vArB> > JN> > > Why not? =9AFor example CGI::Carp redefines 'die' to lo=
g errors.
vArB> > JN> >
vArB> > JN> > Ouch, sorry, I meant 'last' or something like that.
vArB> > JN>
vArB> > JN> "last" / "last LABEL" is a command, not a function, therefo=
re you cannot
vArB> > JN> redefine it.
vArB> >
vArB> > it's a flow control statement thus it is a built-in thing same =
way as any other
vArB> > functions are explained in a 'perldoc -f'
vArB> > Therefore it is treated by monkeys crowd as function. It's obvi=
ous for me to
vArB> > stay out here ( here !=3D maillist ) yet in such an environment=
=2E
vArB>=20
vArB> These things are called "operators" in Perl, some of them (like e=
xit)
vArB> you can redefine. Some (like last) you can't. At least not withou=
t
vArB> some deep magic.

problem is not the naming, but that those are built-in and supposed to =
be used
'as is'. Operators or functions are whatever, but for perldoc they are =
the '-f'
so think not a big problem I named them functions.

vArB> > Anyway, I compare last() here =9Awith exit() and die() which lo=
ok to user just
vArB> > like the same kind of: the flow control statements. I guess any=
 perl user who
vArB> > makes things like gitweb ( at least as a CGI-only app ) shouldn=
't care about
vArB> > such an internal difference of flow control statements those ar=
e
vArB> > hidden/incapsulated inside the implementation of those statemen=
ts?
vArB> > Needless to mention that the 'last LABEL' ( goto, gosub, ... na=
med them ) =9Ais a
vArB> > bad and a very deprecated style which is every schoolboy is awa=
re about
vArB> > nowadays to keep from using in the application, not system, pro=
gramming in imho
vArB> > every language.
vArB>=20
vArB> `last LABEL' is not bad or deprecated. It's what you use to get o=
ut of
vArB> nested for-loops in Perl:
vArB>=20
vArB>     OUTER: for my $i (1 .. 10) {
vArB>         for my $j (1 .. 10) {
vArB>             last OUTER if $i =3D=3D 5 and $j =3D=3D 5;
vArB>         }
vArB>     }
vArB>=20
vArB> goto is also recommended in some cases in Perl. That's because it
vArB> doesn't do the same thing as in C:
vArB>=20
vArB>     # Don't create a stack frame
vArB>     sub foo { goto &bar }
vArB>=20
vArB> Anyway, arguing over which control flow operator is evil in an
vArB> imperitive language is just splitting hairs. Certain uses of them=
 are
vArB> a bad idea, not the operators themselves.

correct, just use-cases are a thing to change like cgi to fastcgi envir=
onment,
this is where exit() is intended to be redefined for performance reason=
s. Thus
original uses are not as certain as they were supposed to be at the mom=
ent of
applications' coding: there were no idea why the END{}'s exit() is any =
better
than the explicit in-code one. It's just can cause the lack of the perf=
ormance
and should be avoided in persistent perl processes to serve such a CGI-=
like
applications.

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 =
6627)
--=20
http://vereshagin.org

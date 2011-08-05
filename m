From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Fri, 05 Aug 2011 02:29:38 +0200
Message-ID: <1312504178.3261.1417.camel@Naugrim.eriador.com>
References: <4E0A08AE.8090407@web.de>
	 <1311792580.2413.82.camel@Naugrim.eriador.com>
	 <1311843465.3734.40.camel@Naugrim.eriador.com> <4E3192D4.5000504@web.de>
	 <1311932377.3734.182.camel@Naugrim.eriador.com> <4E34122B.5020509@web.de>
	 <1312062927.3261.334.camel@Naugrim.eriador.com> <4E370107.3050002@web.de>
	 <1312287584.3261.798.camel@Naugrim.eriador.com> <4E384510.1070803@web.de>
	 <20110803062536.GB33203@book.hvoigt.net>
	 <1312374382.3261.913.camel@Naugrim.eriador.com>
	 <7v8vractdw.fsf@alter.siamese.dyndns.org> <4E399C62.30604@web.de>
	 <7vaabqb7vf.fsf@alter.siamese.dyndns.org>  <4E39BDFF.3050804@web.de>
	 <1312410562.3261.1030.camel@Naugrim.eriador.com>  <4E3ADAD0.1060800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 05 02:26:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp8FK-00013T-K0
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 02:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755862Ab1HEA0c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 20:26:32 -0400
Received: from mailgw1.surf-town.net ([212.97.132.64]:49807 "EHLO
	mailgw1.surf-town.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540Ab1HEA0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 20:26:31 -0400
Received: by mailgw1.surf-town.net (Postfix, from userid 65534)
	id 0DF031CD704; Fri,  5 Aug 2011 02:26:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw1.surf-town.net (Postfix) with ESMTP id BF8241CD58A;
	Fri,  5 Aug 2011 02:26:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw1.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw1.surf-town.net ([127.0.0.1])
	by localhost (mailgw1.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hvLfOO-y7L0b; Fri,  5 Aug 2011 02:26:24 +0200 (CEST)
Received: from [192.168.0.6] (se167-1-82-242-149-125.fbx.proxad.net [82.242.149.125])
	by mailgw1.surf-town.net (Postfix) with ESMTPSA id 657381CD5DD;
	Fri,  5 Aug 2011 02:26:18 +0200 (CEST)
In-Reply-To: <4E3ADAD0.1060800@web.de>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178778>

Le jeudi 04 ao=C3=BBt 2011 =C3=A0 19:45 +0200, Jens Lehmann a =C3=A9cri=
t :
> Am 04.08.2011 00:29, schrieb henri GEIST:
> > Le mercredi 03 ao=C3=BBt 2011 =C3=A0 23:30 +0200, Jens Lehmann a =C3=
=A9crit :
> >> Am 03.08.2011 21:41, schrieb Junio C Hamano:
> >>> Jens Lehmann <Jens.Lehmann@web.de> writes:
> >> But when you fetch a new version of Gimp into your submodule, it w=
ould be
> >> really nice if the superproject could be notified that the Gimp de=
velopers
> >> updated to 1.2.4 of Glib and inform you that an update of Glib mig=
ht be
> >> appropriate. That could avoid having you to dig through compiler e=
rrors to
> >> find out that the new foobar() function from Glib 1.2.4 is needed =
(and if
> >> you need to pull in a bugfix in Glib, you might notice that *a lot=
* later
> >> when you forget to do that).
> >>
> >=20
> > Exact, I am really happy to read this.
> > And better do not bother to have the suproject.
>=20
> I don't get this, you can't get rid of the superproject.

Of corse I can.
I have done It the patch I have submit has been done for an do it
successfully.
I am doing it every day.

I have in the same "directory" not repository.
Two repository "gimp" and "libpng".
I cd in the gimp directory.
And do "git add ../libpng" and it is done.
The gimp repository track the "../libpng" repository by its path and
sha1.

I do not need anything else.

>=20
> > cd to gimp directory, type git status it can tell you every thing a=
nd
> > when your satisfied you just have to type make.
> > At this point the superproject have not any use.=20
>=20
> "git status" inside the submodule won't tell you anything about the
> dependencies,

Of corse It does if the repository add been add
It will just like any other submodules inside of the repository
Git status is even unable to see the difference.
Essential because there is no difference.

> but a "git status" in the superproject should.

Yes but I have no and want not to have a superproject.

> The submodule shouldn't know where exactly the submodules it depends =
on lives, that is
> the decision of the superproject, not the submodule.

Why not in my case it is needed has in "gimp.c" I have

#include "../libpng.h"

If the code need to know where is libpng why the repository should not
know it as well ?

>=20
> >>>> In addition to that, it can (but mustn't) specify any of the fol=
lowing:
> >>>
> >>> I am guessing you meant "does not have to", instead of mustn't, h=
ere...
> >>
> >> Sure, thanks for deciphering that.
> >>
> >>>> a) Of this submodule "foo" I need at least that version because =
I won't
> >>>>    compile/work with older versions of that. (this can be tighte=
ned to
> >>>>    "exactly that version" to give henri the behavior he wants, b=
ut that
> >>>>    should be policy, not mandatory)
> >>>
> >>> The "loose collection of projects" approach like that has its use=
s, and it
> >>> is called "repo". Why re-invent it? The behaviour Henri wants to =
specify
> >>> the exact version is how git submodules work already, so I do not=
 see
> >>> there is anything to be done here.
> >>
> >> Let me make this clear: this is not about changing how submodules =
are
> >> committed in a superproject. It is not about having a loose collec=
tion of
> >> projects, they stay tied together in a defined state by the superp=
roject.
> >>
> >=20
> > Yes but for me, from when I started this this topic, it was all abo=
ut
> > having a loose collection of project with dependency references bet=
ween
> > them. And get rid of the superproject.
> > It is my first and only goal.
>=20
> But I fail to see how that would improve anything.
>=20

It improve my life and the life of my team has developers everyday.
All my team agree on this point. In fact they asked me to implement it.
Because we used to have a superproject and it does not scale well.=20


The "gimp" team and the "gqview" team shares the libpng but at there
point of view they are not related they even not need to know that the
other one exist. Then they will never share the same superproject. It
has no sens for them.
Then in your model you will need a superproject by project.
I think we should put all that you put in the superproject in the
project itself. Then there will be only one project by project.

And if the dependency are not part of the superproject, this remove the
burden of each team to redefine all the dependencies recursively in any
dependency they have. has the original "libpng" team have done it in th=
e
"libpng" project and not in there own superprojec witch the can not
share.

> >> Henri wanted it a bit upside down: any submodule could request a c=
ertain
> >> version of another submodule somewhere else in the repo. And he wa=
nted to
> >> use gitlinks from one submodule to another for that, which I - hop=
efully -
> >> convinced him was no good idea.
> >>
> >=20
> > You just convince me that submodules are more than I need and to ma=
ke a
> > lighter independent version of submodules which will never been fol=
lowed
> > by git commands.
>=20
> Submodules are what you need, but it's no use to implement dependenci=
es by
> using gitlinks that point outside of their repositories.
>=20

Submodules is not what I need.
What I need is pointers to external repository tracked by git.
Submodule was to my eyes the logical tool to do it.
And I had made a patch to enable the tracking of external repository
just has they do for internal ones.

You convince me that you think prohibiting me to do so is a feature to
your eyes. Because gitlinks and submodules can do more than this and yo=
u
do not want those other things to work outside of the repository.

Then I propose to cook a kind of "my_light_gitlinks" which do only that=
=2E

> >>>> b) And if you don't know where to get it, use this url
> >>>
> >>> Again that is the job of .gitmodules in the superproject.
> >>
> >> Yes. But this idea is about how the url could get into the .gitmod=
ules of
> >> the superproject in the first place. That can make it easier for t=
he
> >> superproject's developer to import a submodule into his repo and m=
uch more
> >> important: it makes it possible to pull in submodule dependencies
> >> automatically e.g. when running "git submodule add --resolve-depen=
dencies
> >> Gimp".
> >=20
> > Only if you have a superproject.
> > If not do the same thing from the gimp repository, now it contain a=
ll
> > necessary infos to do the job.
>=20
> No, it doesn't. Apart from the Gimp project telling you what version =
it
> wants, you need to have a place to record the version that the user r=
eally
> used. And that won't work without a superproject.
>=20

the version of "libpng" that the user really use is stored in his
"libpng" repository !
And tracked by every project depending on it.

> >>>> That is all stuff the submodule knows better than the superproje=
ct.
> >>>
> >>> Not necessarily. The version A0 of submodule A may depend on subm=
odule B
> >>> and may also know it must have at least version B0 of that submod=
ule, but
> >>> the superproject would know other constraints, e.g. the superproj=
ect
> >>> itself also calls into submodule B and wants a newer version B1 o=
f it.
> >>
> >> Right. That's what I tried to explain to Henri, the superproject t=
ies it all
> >> together. But I also like his idea to add a way to communicate inf=
ormation
> >> from the submodule to the superproject, and give the superproject =
a choice
> >> if it wants to use it.
> >>
> >=20
> > yes but the superproject contain no code in your design.
> > Then it will never need anything by itself.
> > It is only a container which you will inform with data already know=
n by
> > the submodules I do not see any value to it.
>=20
> But being the container that ties it all together is more than enough=
 value.
>=20

It has absolutely no value to have a git repository as a container.
A simple directory will do it very well.

	Henri

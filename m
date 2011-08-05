From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Fri, 05 Aug 2011 04:19:17 +0200
Message-ID: <1312510757.3261.1439.camel@Naugrim.eriador.com>
References: <4E370107.3050002@web.de>
	 <1312287584.3261.798.camel@Naugrim.eriador.com> <4E384510.1070803@web.de>
	 <20110803062536.GB33203@book.hvoigt.net>
	 <1312374382.3261.913.camel@Naugrim.eriador.com>
	 <7v8vractdw.fsf@alter.siamese.dyndns.org> <4E399C62.30604@web.de>
	 <7vaabqb7vf.fsf@alter.siamese.dyndns.org> <4E39BDFF.3050804@web.de>
	 <1312410562.3261.1030.camel@Naugrim.eriador.com>
	 <20110804200529.GA35398@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Aug 05 04:16:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp9xQ-0004Px-8f
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 04:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab1HECQL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 22:16:11 -0400
Received: from mail11.surf-town.net ([212.97.132.51]:50409 "EHLO
	mailgw6.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754287Ab1HECQK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 22:16:10 -0400
Received: by mailgw6.surf-town.net (Postfix, from userid 65534)
	id B8B935F794; Fri,  5 Aug 2011 04:16:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw6.surf-town.net (Postfix) with ESMTP id 8D4205F794;
	Fri,  5 Aug 2011 04:16:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw6.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw6.surf-town.net ([127.0.0.1])
	by localhost (mailgw6.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id z5V4sq9lIpXu; Fri,  5 Aug 2011 04:16:02 +0200 (CEST)
Received: from [192.168.0.6] (se167-1-82-242-149-125.fbx.proxad.net [82.242.149.125])
	by mailgw6.surf-town.net (Postfix) with ESMTPSA id 4B8645F738;
	Fri,  5 Aug 2011 04:15:57 +0200 (CEST)
In-Reply-To: <20110804200529.GA35398@book.hvoigt.net>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178780>

Le jeudi 04 ao=C3=BBt 2011 =C3=A0 22:05 +0200, Heiko Voigt a =C3=A9crit=
 :
> Hi,
>=20
> On Thu, Aug 04, 2011 at 12:29:22AM +0200, henri GEIST wrote:
> > Le mercredi 03 ao??t 2011 ?? 23:30 +0200, Jens Lehmann a ??crit :
> > > Let me make this clear: this is not about changing how submodules=
 are
> > > committed in a superproject. It is not about having a loose colle=
ction of
> > > projects, they stay tied together in a defined state by the super=
project.
> > >=20
> >=20
> > Yes but for me, from when I started this this topic, it was all abo=
ut
> > having a loose collection of project with dependency references bet=
ween
> > them. And get rid of the superproject.
> > It is my first and only goal.
>=20
> In that case maybe what you want is your own completely independent
> implementation of a tool which manages a collection of submodules.

If I make a tool to managed a collection of submodules, it will became
the superproject I want to get rid of.
I do not want to have any concept of a collection. And that is why I do
not want a superproject.

I have no exhaustive list of project/modules/submodules.
Only some independent projects witch knows if they need some others.

Then I realy need the tool to be embedded in the repository.

> I doubt that tracking of submodules outside of the worktree will ever=
 be
> accepted inside core git. Some dependency scheme which makes use of t=
he
> current submodule implementation could be a feasible way but you can =
not
> get rid of the superproject.

I can not but have already done it.

>=20
> Your approach introduces many problems which you were not able to
> present solutions for.

But it does not break anything.
And generate no problem for me.
There is only when you try to get one step more and try to use even mor=
e
advanced things than I do on top of it.
And those problem also apply to normal submodules.

> So if you really want to work on this I suggest
> you try to implement your solution outside of core git first. If you =
can
> prove that you can solve all the immanent problems we can discuss
> integrating it into git again.
>=20

That is what I had proposed to do by making a file .gitdependencies
similar to .gitmodules and create shell script wrappers for :
  - git add
  - git status
  - git reset
  - git rm

the only thing is that with the previous patch I only had to touch "git
add" every thing else was already ready to handle it.

> > > Henri wanted it a bit upside down: any submodule could request a =
certain
> > > version of another submodule somewhere else in the repo. And he w=
anted to
> > > use gitlinks from one submodule to another for that, which I - ho=
pefully -
> > > convinced him was no good idea.
> > >=20
> >=20
> > You just convince me that submodules are more than I need and to ma=
ke a
> > lighter independent version of submodules which will never been fol=
lowed
> > by git commands.
>=20
> As described above this is probably the best way for you. Maybe you c=
an
> prove that such a tool works but git's submodules implementation can
> currently not really assist you with your approach.

We will see.

	Henri

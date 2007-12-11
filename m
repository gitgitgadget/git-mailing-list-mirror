From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Invert numbers and names in the git-shortlog summary  mode.
Date: Tue, 11 Dec 2007 17:11:04 +0100
Message-ID: <20071211161104.GG15448@artemis.madism.org>
References: <20071211092916.GF30948@artemis.madism.org> <m3ve75sfn3.fsf@roke.D-201> <20071211115914.GJ30948@artemis.madism.org> <20071211122539.GA13945@sigill.intra.peff.net> <20071211140508.GA12204@elte.hu> <20071211144351.GA15448@artemis.madism.org> <20071211145709.GB19427@elte.hu> <20071211152412.GB15448@artemis.madism.org> <20071211154841.GA29805@elte.hu> <20071211160744.GE15448@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="oPmsXEqKQNHCSXW7";
	protocol="application/pgp-signature"; micalg=SHA1
To: Ingo Molnar <mingo@elte.hu>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 17:11:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J27hh-0003X9-4i
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 17:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbXLKQLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 11:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbXLKQLH
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 11:11:07 -0500
Received: from pan.madism.org ([88.191.52.104]:34237 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864AbXLKQLF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 11:11:05 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1CD482E8FA;
	Tue, 11 Dec 2007 17:11:05 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 8311049EE04; Tue, 11 Dec 2007 17:11:04 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Ingo Molnar <mingo@elte.hu>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20071211160744.GE15448@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67878>


--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2007 at 04:07:45PM +0000, Pierre Habouzit wrote:
> On Tue, Dec 11, 2007 at 03:48:41PM +0000, Ingo Molnar wrote:
> > if we are growing legacies in git this fast it will turn itself into CV=
S=20
> > very quickly, give or take 20 years ;-) I think a straightforward usage=
=20
> > model is paramount, so phasing out such inconsistencies as early as=20
> > possible in the project's lifetime should be a priority IMHO. Git has a=
=20
> > very, very 'refreshing' approach to information management, and that=20
> > should permeate it all across. It's easy to be "fresh" in the beginning=
=20
> > of a project - maintaining freshness for years is a lot harder. (i dont=
=20
> > suggest to break compatibility, but to be aware of such inconsitencies=
=20
> > and make it a priority to get rid of them. It does not help that such=
=20
> > inconsistencies are only apparent to git newbies.)
>=20
>   Well that's what deprecation is for, but you cannot do that on short
> timeframes.
>=20
> > for example, if i type "git-checkout" in a Linux kernel tree, it just=
=20
> > sits there for up to a minute, and "does nothing". That is totally=20
> > wrong, human-interaction wise. Then after a minute it just returns. Wha=
t=20
> > happened? Why? Where? A newbie would then try "git-checkout -v", using=
=20
> > the well-established "verbose" flag, but that gives:
> >=20
> >  Usage: /usr/bin/git-checkout [-q] [-f] [-b <new_branch>] [-m] [<branch=
>] [<paths>...]
>=20
> not anymore:
>=20
>     $ git checkout -v
>     error: unknown switch `v'
>     usage: git-branch [options] [<branch>] [<paths>...]
                 ^^^^^^
  okay I felt stupid while reading this on list, a patch fixing this
  stupid lapsus has just been sent. Doh.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--oPmsXEqKQNHCSXW7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHXraYvGr7W6HudhwRAs6EAKCSqqzQWEz6TSm7xo6WLCFfP4fwPACeNeRB
8WpVrV/Z4PXXH2ym/Z/7oME=
=kDIH
-----END PGP SIGNATURE-----

--oPmsXEqKQNHCSXW7--

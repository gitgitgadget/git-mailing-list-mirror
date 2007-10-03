From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git push (mis ?)behavior
Date: Wed, 03 Oct 2007 11:03:32 +0200
Message-ID: <20071003090332.GC12042@artemis.corp>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <buoprzwn5qm.fsf@dhapc248.dev.necel.com> <20071003073554.GA8110@artemis.corp> <buobqbgmv6z.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="B4IIlcmfBL/1gGOG";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 11:03:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id08t-0005ZN-6X
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 11:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852AbXJCJDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 05:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753182AbXJCJDf
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 05:03:35 -0400
Received: from pan.madism.org ([88.191.52.104]:37588 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbXJCJDe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 05:03:34 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1833D2322F;
	Wed,  3 Oct 2007 11:03:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B3CD9342E30; Wed,  3 Oct 2007 11:03:32 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Miles Bader <miles@gnu.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <buobqbgmv6z.fsf@dhapc248.dev.necel.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59814>


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2007 at 08:57:56AM +0000, Miles Bader wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
> >   There definitely is a point: with the current behaviour you sometimes
> > end up pushing more than what you meant, with sometimes WIP that you
> > intend to rebase, and it hurts. Git porcelains should help you avoid to
> > shoot yourself in the foot, hence I think that (especially to git
> > newcomers), the current default _is_ dangerous.
>=20
> What's "dangerous" for newbies, often ends up being what doesn't
> correspond with their mental model.  I think the current default
> behavior without any <refspec> specified corresponds well to the
> operation of many other git commands (and unix command) in similar
> circumstances:  If you don't specify something to operate on, it
> essentially uses a wild card and operates on "every reasonable thing"
> (e.g., consider "git commit FILE" versus "git commit").

  Git commit is hardly a wildcard as it only operates on what you put in
your index, which is hardly something that happens behind your back.

> To the extent that a command _is_ "dangerous", there's always a tradeoff
> between convenience and "danger".  Some systems (e.g. those aimed at
> newbies) might have as a goal to do the absolute minimum with every
> command and always, always, err on the side of safety.  I don't think git
> is that system.

  I beg to differ then. I believe that "git push" default behavior is
wrong. I'm not really a newbie, and it often did not do what I meant. So
it could also be that there isn't a sane default either. I just say the
current one can lead to gross mistakes.

  I know that some porcelains are risky: if you rebase "under" a point
that was published you are shooting yourself in the foot e.g.. But
git-rebase _is_ a command that rewrites history. You're warned from the
first second you use it. But git-push is supposedly only a transport
command, not something that messes with remotes history behind your
back.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHA1rkvGr7W6HudhwRAsy8AJ9+IZgtwC4MIsp9FLvg5UM2T7kcWwCfSTXm
LOHVLmU1MAx9OaA7HallYSU=
=I4wN
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--

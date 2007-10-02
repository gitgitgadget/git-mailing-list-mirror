From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: merging .gitignore
Date: Wed, 03 Oct 2007 00:07:49 +0200
Message-ID: <20071002220749.GE19710@artemis.corp>
References: <20071001130314.GA5932@lapse.madduck.net> <Pine.LNX.4.64.0710011457120.28395@racer.site> <20071001130314.GA5932@lapse.madduck.net> <200710011448.17701.andyparkins@gmail.com> <20071002195148.GA14171@lapse.madduck.net> <20071002201318.GD16776@artemis.corp> <20071002204748.GA19710@artemis.corp> <20071002205618.GA19097@lapse.madduck.net> <20071002210748.GC19710@artemis.corp> <20071002214919.GA21260@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="6e7ZaeXHKrTJCxdu";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 00:08:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcpuQ-0004Rz-99
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 00:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543AbXJBWH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 18:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755541AbXJBWH4
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 18:07:56 -0400
Received: from pan.madism.org ([88.191.52.104]:39182 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756620AbXJBWHz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 18:07:55 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id B04DF23121;
	Wed,  3 Oct 2007 00:07:50 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B3091359F85; Wed,  3 Oct 2007 00:07:49 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	martin f krafft <madduck@debian.org>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <20071002214919.GA21260@lapse.madduck.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2007 at 09:49:19PM +0000, martin f krafft wrote:
> also sprach Pierre Habouzit <madcoder@debian.org> [2007.10.02.2207 +0100]:
> > > >        (a*)
> > > >       /    \
> > > >   (ab*)    (ac*)
> > > >       \    /
> > > >        ????
> > >=20
> > > (a*, ab*, ac*)
> >=20
> >   Definitely not. a* -> ab* is making a?* unignored for any value of ?
> > except b. So adding a* is definitely invalid.
>=20
> In left, ab* is still ignored, in right ac* is still ignored, and in
> the integration branch, they're all ignored. We don't merge up in
> this model...

  err maybe you didn't get my little picture

     (a*)
    /    \
   v      v
(ab*)    (ac*)
    \    /
     v  v
     ????

  This is a perfectly sensible history. Or I miss sth on your end.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHAsE1vGr7W6HudhwRAvXcAJ93cnVZss8PaAwJLTGttgDKvO1uXgCgia+G
dUQ2s/Tv8QTda+9OJbXsVfY=
=+CJ9
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--

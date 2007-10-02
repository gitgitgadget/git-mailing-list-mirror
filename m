From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: merging .gitignore
Date: Tue, 02 Oct 2007 23:07:48 +0200
Message-ID: <20071002210748.GC19710@artemis.corp>
References: <20071001130314.GA5932@lapse.madduck.net> <Pine.LNX.4.64.0710011457120.28395@racer.site> <20071001130314.GA5932@lapse.madduck.net> <200710011448.17701.andyparkins@gmail.com> <20071002195148.GA14171@lapse.madduck.net> <20071002201318.GD16776@artemis.corp> <20071002204748.GA19710@artemis.corp> <20071002205618.GA19097@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="rQ2U398070+RC21q";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 23:08:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcoyO-0007IK-QA
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 23:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593AbXJBVIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 17:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754298AbXJBVIA
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 17:08:00 -0400
Received: from pan.madism.org ([88.191.52.104]:38986 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753984AbXJBVIA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 17:08:00 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A3C01230FC;
	Tue,  2 Oct 2007 23:07:48 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 4E48F2F8E8C; Tue,  2 Oct 2007 23:07:48 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	martin f krafft <madduck@debian.org>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <20071002205618.GA19097@lapse.madduck.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59739>


--rQ2U398070+RC21q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2007 at 08:56:18PM +0000, martin f krafft wrote:
> also sprach Pierre Habouzit <madcoder@debian.org> [2007.10.02.2147 +0100]:
> >        (a*)
> >       /    \
> >   (ab*)    (ac*)
> >       \    /
> >        ????
>=20
> (a*, ab*, ac*)

  Definitely not. a* -> ab* is making a?* unignored for any value of ?
except b. So adding a* is definitely invalid.

  So your final merge is definitely invalid. I'd say that it's likely
that the final merge is (ab*, ac*) but on the left branch the ab* could
have been chosen because the programmer added a thing named ac.c, so the
merge would still have (probably little but still some) chances to be inval=
id.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--rQ2U398070+RC21q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHArMkvGr7W6HudhwRAgtMAJ9MV2bTsbWSJ6YOhkibLJOKw6LNDgCdHYYw
fYoO9678oAZF6TQkuLyWJxI=
=1LEu
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--

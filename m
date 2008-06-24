From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 5/7] parse-opt: fake short strings for callers to believe  in.
Date: Tue, 24 Jun 2008 21:26:34 +0200
Message-ID: <20080624192634.GA9189@artemis.madism.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <1214298732-6247-1-git-send-email-madcoder@debian.org> <1214298732-6247-2-git-send-email-madcoder@debian.org> <1214298732-6247-3-git-send-email-madcoder@debian.org> <1214298732-6247-4-git-send-email-madcoder@debian.org> <1214298732-6247-5-git-send-email-madcoder@debian.org> <1214298732-6247-6-git-send-email-madcoder@debian.org> <alpine.LFD.1.10.0806241019370.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="rwEMma7ioTxnRzrJ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 21:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEAx-0000n7-Lc
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbYFXT0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbYFXT0k
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:26:40 -0400
Received: from pan.madism.org ([88.191.52.104]:54463 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752125AbYFXT0j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:26:39 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id D3C3F36843;
	Tue, 24 Jun 2008 21:26:36 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 08F611D67E; Tue, 24 Jun 2008 21:26:34 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806241019370.2926@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86119>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2008 at 05:20:28PM +0000, Linus Torvalds wrote:
>=20
>=20
> On Tue, 24 Jun 2008, Pierre Habouzit wrote:
> >
> > If we begin to parse -abc and that the parser knew about -a and -b, it
> > will fake a -c switch for the caller to deal with.
> >=20
> > Of course in the case of -acb (supposing -c is not taking an argument) =
the
> > caller will have to be especially clever to do the same thing. We could
> > think about exposing an API to do so if it's really needed, but oh well=
=2E..
>=20
> Well, if the other parser is _also_ parse_options() (ie you just cascade=
=20
> them incrementally in a loop), then the other parser should get it right=
=20
> automatically. No?

  Exactly. There are minor glitches wrt the help generation to deal
with, but for pure parsing issues yes, it will work.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhhSmgACgkQvGr7W6HudhxFOQCfRuug6LDm2KIRZkxIoJ5NVsah
sw4An2GXMMMXWN1Y/tEypEJHpq6W1wwF
=lxrd
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

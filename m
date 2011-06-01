From: Joey Hess <joey@kitenet.net>
Subject: Re: speed of git reset -- file
Date: Wed, 1 Jun 2011 18:05:02 -0400
Message-ID: <20110601220502.GA28493@gnu.kitenet.net>
References: <20110531190015.GA12113@gnu.kitenet.net>
 <20110531212639.GA13234@sigill.intra.peff.net>
 <7v62oqignm.fsf@alter.siamese.dyndns.org>
 <20110601195831.GA30070@sigill.intra.peff.net>
 <20110601201629.GA25354@gnu.kitenet.net>
 <20110601211847.GA31958@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:05:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRtXS-0002IE-Kn
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 00:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab1FAWFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 18:05:10 -0400
Received: from wren.kitenet.net ([80.68.85.49]:40475 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754579Ab1FAWFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 18:05:09 -0400
Received: from gnu.kitenet.net (dialup-4.154.7.116.Dial1.Atlanta1.Level3.net [4.154.7.116])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id D4A3B11914F
	for <git@vger.kernel.org>; Wed,  1 Jun 2011 18:05:06 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 7FE3D51494; Wed,  1 Jun 2011 18:05:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110601211847.GA31958@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174905>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> > My experience with semi-large trees[1] is that I have to remember to use
> > "git status ." in a subdir; that "git commit -a" is of course slow when
> > I need to use it; and that the index gets big and things that need to
> > update it can become somewhat slow especially on slow disks, but that
>=20
> Generally I find that the stats are very fast because everything is in
> cache, and the disk doesn't come into it at all. Are you on an OS
> besides Linux, or on a machine with low memory?

I have Linux and a gigabyte of ram and a not particularly good SSD.
Here `git reset file` takes 30 seconds, `git status` 45 seconds.

I do not seem to be alone in finding git reset file to be slow, the
problem was reported to me by another user.

> Yeah, Junio's autorefresh suggestion is much better.

That did seem reasonable and something I'd probably use.

--=20
see shy jo

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTea3jckQ2SIlEuPHAQjOuQ/7BNnl7Jo9jgmcwxuQ47v6L3uCp0HZAVQS
Hy4d7hG2rupgdBWgpzA84KkrCq/VVmpfsT8AQkB2sliar95Cg3V4le6rf/Iqv6zR
aCDVJX2QlSzcaXeQUBweFmFx/CySqCW9IM4dtTpF9y+SnSCvjN7xqaaMLIRzZ2LN
I+BNGppeegi+Nvb9kZqZegQu74F5W8ALM1z7yVc6C+XGHAvcM/Uetx0hEwKGiZoy
/VCJ7C+5h4c9OrdLV3Q50QvI740i6ffSrWRbn1/PoSG6aGwBcyZIfoEbQc4R0uue
U2A82j8IQHyFEq3kU4lTdPRPDKAOVMa09ZiJBYa+fTsVD34nDs+aKC81mKsYFBpw
aqADnfyZ80nZmaUrOgdp5enW4NLVfZRIWvZnm0TxPE+v6SeYlclxSTliW95ApR/Z
1IC99yoGDm2BurMFbFc0yftevAoEXDp82ZHx89H5ojWIxbGqw0Q1AP0Ohm16jgHu
E2YkOnVLJkEJA/w6Mtlznc3N9/721cr5vapp54SfgqWK0StW2Rju72S1h2k+1TwF
BKcYODYs1jXyvGyLn7qyNRa7ubDhfep55mr0Jtlo1c9NtVi53Oiac84E9IfX4/yL
MhroAFJGsGeoapbPHE83a6qDyfn+rBI0jF0qLp6SHX3flc87d9gR1HOcx7K+5TTY
Yk8mqOyTO/g=
=lpXG
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

From: Simon Fowler <simon@himi.org>
Subject: Re: Merge with git-pasky II.
Date: Sun, 17 Apr 2005 01:55:37 +1000
Message-ID: <20050416155536.GX4488@himi.org>
References: <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org> <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org> <1113559330.12012.292.camel@baythorne.infradead.org> <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org> <20050416014442.GW4488@himi.org> <Pine.LNX.4.62.0504160518310.21837@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="41bjdpi19TcwJlr2"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 17:52:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMpab-0006lm-70
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 17:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVDPPzt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 11:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbVDPPzt
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 11:55:49 -0400
Received: from dreamcraft.goldweb.com.au ([202.55.152.19]:15246 "EHLO
	dreamcraft.com.au") by vger.kernel.org with ESMTP id S262691AbVDPPzo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 11:55:44 -0400
Received: from private.himi.org (dsl-203-113-232-142.ACT.netspace.net.au [203.113.232.142])
	by dreamcraft.com.au (Postfix) with ESMTP id 816FA5B986;
	Sun, 17 Apr 2005 01:55:49 +1000 (EST)
Received: by private.himi.org (Postfix, from userid 1000)
	id C7569B6E1; Sun, 17 Apr 2005 01:55:37 +1000 (EST)
To: David Lang <david.lang@digitalinsight.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504160518310.21837@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--41bjdpi19TcwJlr2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 16, 2005 at 05:19:24AM -0700, David Lang wrote:
> Simon
>=20
> given that you have multiple machines creating files, how do you deal wit=
h=20
> the idea of the same 'unique id' being assigned to different files by=20
> different machines?
>=20
The id is a sha1 hash of the current time and the full path of the
file being added - the chances of that being replicated without
malicious intent is extremely small. There are other things that
could be used, like the hostname, username of the person running the
program, etc, but I don't really see them being necessary.

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--41bjdpi19TcwJlr2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCYTV4QPlfmRRKmRwRAmsBAJ9ZNSjQeNRmiF1R1ubc+D9648ndeQCgmuxL
e3wQL5Lv4sf+ZGks08CHsX8=
=kbht
-----END PGP SIGNATURE-----

--41bjdpi19TcwJlr2--

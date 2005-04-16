From: Simon Fowler <simon@himi.org>
Subject: Re: Re: Merge with git-pasky II.
Date: Sun, 17 Apr 2005 02:26:14 +1000
Message-ID: <20050416162614.GY4488@himi.org>
References: <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org> <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org> <1113559330.12012.292.camel@baythorne.infradead.org> <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org> <20050416014442.GW4488@himi.org> <Pine.LNX.4.62.0504160518310.21837@qynat.qvtvafvgr.pbz> <20050416155536.GX4488@himi.org> <20050416160333.GF19099@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hmb9n29fjuiORm2l"
Cc: David Lang <david.lang@digitalinsight.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 18:23:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMq49-0000bt-RQ
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 18:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVDPQ0W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 12:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVDPQ0W
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 12:26:22 -0400
Received: from dreamcraft.goldweb.com.au ([202.55.152.19]:16014 "EHLO
	dreamcraft.com.au") by vger.kernel.org with ESMTP id S262694AbVDPQ0S
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 12:26:18 -0400
Received: from private.himi.org (dsl-203-113-232-142.ACT.netspace.net.au [203.113.232.142])
	by dreamcraft.com.au (Postfix) with ESMTP id 029E85B986;
	Sun, 17 Apr 2005 02:26:27 +1000 (EST)
Received: by private.himi.org (Postfix, from userid 1000)
	id 6504AB6E1; Sun, 17 Apr 2005 02:26:15 +1000 (EST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050416160333.GF19099@pasky.ji.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--Hmb9n29fjuiORm2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 16, 2005 at 06:03:33PM +0200, Petr Baudis wrote:
> Dear diary, on Sat, Apr 16, 2005 at 05:55:37PM CEST, I got a letter
> where Simon Fowler <simon@himi.org> told me that...
> > On Sat, Apr 16, 2005 at 05:19:24AM -0700, David Lang wrote:
> > > Simon
> > >=20
> > > given that you have multiple machines creating files, how do you deal=
 with=20
> > > the idea of the same 'unique id' being assigned to different files by=
=20
> > > different machines?
> > >=20
> > The id is a sha1 hash of the current time and the full path of the
> > file being added - the chances of that being replicated without
> > malicious intent is extremely small. There are other things that
> > could be used, like the hostname, username of the person running the
> > program, etc, but I don't really see them being necessary.
>=20
> Why not just use UUID?
>=20
Hey, everything else in git seems to use sha1, so I just copied
Linus' sha1 code ;-)

All I wanted was something that had a good chance of being unique
across any potential set of distributed repositories, to avoid the
chance of accidental clashes. A sha1 hash of something that's not
likely to be replicated is a simple way to do that.

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--Hmb9n29fjuiORm2l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCYTymQPlfmRRKmRwRAkGpAJ4infTGrERzZMFIaeOj+LhxpFMv1wCg18Jw
l7FDHzJ3mbLGrhHN/1yKVuw=
=DU9N
-----END PGP SIGNATURE-----

--Hmb9n29fjuiORm2l--

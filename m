From: Bart Trojanowski <bart@jukie.net>
Subject: Re: git push problem with v1.5.0-rc1
Date: Thu, 18 Jan 2007 22:16:37 -0500
Message-ID: <20070119031637.GR8624@jukie.net>
References: <20070118212615.GO8624@jukie.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kBrdouXwCpr7CNjf"
X-From: git-owner@vger.kernel.org Fri Jan 19 04:16:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7kF8-0005fL-Bj
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 04:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbXASDQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 22:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbXASDQk
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 22:16:40 -0500
Received: from bart.ott.istop.com ([66.11.172.99]:46902 "EHLO jukie.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964795AbXASDQj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 22:16:39 -0500
Received: from tau.jukie.net ([10.10.10.211]:34458)
	by jukie.net with esmtp (Exim 4.50)
	id 1H7kF4-0006Lf-KM
	for git@vger.kernel.org; Thu, 18 Jan 2007 22:16:38 -0500
Received: by tau.jukie.net (Postfix, from userid 1000)
	id D8BAE2DC03A; Thu, 18 Jan 2007 22:16:37 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070118212615.GO8624@jukie.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37150>


--kBrdouXwCpr7CNjf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks, Simon.

* Bart Trojanowski <bart@jukie.net> [070118 16:26]:
>       fatal: cannot fstat packfile: Value too large for defined data type=
=20
>       unpack index-pack exited with error code=20

Interestingly enough upgrading to 2.6.20-rc (from 2.6.19) fixed the real
problem.

-Bart

--=20
				WebSig: http://www.jukie.net/~bart/sig/

--kBrdouXwCpr7CNjf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFsDgV/zRZ1SKJaI8RAtSPAJ44fTXzLOaHPoSKTUuzJgpBiasK9wCfWs5P
9yL4deurGnRxCmmWAWe9Qr8=
=IdrU
-----END PGP SIGNATURE-----

--kBrdouXwCpr7CNjf--

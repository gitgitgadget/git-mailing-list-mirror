From: Joey Hess <joey@kitenet.net>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Wed, 26 Jan 2011 13:42:26 -0400
Message-ID: <20110126174226.GA14511@gnu.kitenet.net>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
 <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
 <20110121222440.GA1837@sigill.intra.peff.net>
 <20110123141417.GA6133@mew.padd.com>
 <AANLkTimE+s81Xbj4snNX0WWxG8x=qSwaQWfK+08+1Zy+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 18:42:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi9OR-0004O0-O4
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 18:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693Ab1AZRme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 12:42:34 -0500
Received: from wren.kitenet.net ([80.68.85.49]:45190 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435Ab1AZRmd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 12:42:33 -0500
Received: from gnu.kitenet.net (dialup-4.153.250.203.Dial1.Atlanta1.Level3.net [4.153.250.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 4FC2011833D;
	Wed, 26 Jan 2011 12:42:31 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id C4D844A34A; Wed, 26 Jan 2011 12:42:26 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <AANLkTimE+s81Xbj4snNX0WWxG8x=qSwaQWfK+08+1Zy+@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165524>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Scott Chacon wrote:
> Sorry to come in a bit late to this, but in addition to git-annex, I
> wrote something called 'git-media' a long time ago that works in a
> similar manner to what you both are discussing.

Huh, if I had known about that I might not have written git-annex.
Although probably I would have still, I needed a more distributed
approach to storing data than git-media seems to support, and the
ability to partially check out only some files.

> > =A0 =A0git config --global filter.huge.clean huge-clean %f
>=20
> This is amazing.  I absolutely did not know you could do this, and it
> would make parts of git-media way better if I re-implemented it using
> this.  Thanks for pointing this out.

Yeah, that's great, it should allow a smart clean filter to not waste
time reprocessing a known large file on every git status/git commit.

--=20
see shy jo

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBTUBc/8kQ2SIlEuPHAQj0XBAAl4OtoKrT0sc5mBk3NwtsNHBoXYypp/je
8M/l4npttK+kKLeOJIc6B6139y/O5q3xy67UejxXXDMh9TAS5G3XOo0pTWOr6vNh
/laa80kZG+pIVZ6wC/yHq6nfq7kceySZnViLaDzsQ7Qe06OMtnEnb1J7SAAqBIAf
+5kAo97Dd7Ge8G1FCj3mRBWeec3v+QXbizslY/5Cb3H4A5zTLr05KfbRRHfeG6J6
6xwsKFuFdCxLwgwO42G0WrMK7yhxPqIMwgFkeilwycRWdcRs+CbW7hw1VsEROsCJ
UFvymxVSZhu8bIewNyWz7pgkQBRK391xEXYCC7tYh/rapEYqniZDuAucPDNd1UM1
07gsoBIKUViWz2A2PdIpUOvtmxQxPqcGdswve3m7DbpNlPV1ay168xE14RhOChbG
5WiZKy5Baz22Y1rWa0M0q9zhNY+U2BVFH5n1AduhGCWEXgRdOjKjTDLVGAuEmxWm
Vjw+jSIc3lGdZwYIMVf+t7aZREuX/39b12OpNk/9Mp8BnJitlnP6vNr7/WPSI4bf
Ju+RQ3mGqaxCT42fO9AP1etcrsys3Vly53PeYOF2Cj1ITB8zicvNhVD5RGMRN5cg
Vo7WW7qfK3Wo1Rla5/ToLNPttmTH72zGTfp1k2/M6Fl2IDKgb+plxo8tS7xRKgCy
G5PeK/UlQyY=
=fqh/
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

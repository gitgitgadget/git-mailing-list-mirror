From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Problem while cloning a git repo
Date: Wed, 13 Nov 2013 23:40:58 +0000
Message-ID: <20131113234057.GA314350@vauxhall.crustytoothpaste.net>
References: <597769726.308442105.1384260624974.JavaMail.root@zimbra35-e6.priv.proxad.net>
 <20131113002035.GK183446@vauxhall.crustytoothpaste.net>
 <52832DA0.7040108@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
To: Yann COLLETTE <ycollette.nospam@free.fr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 00:41:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vgk3c-0002J2-ME
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 00:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755Ab3KMXlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 18:41:09 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33802 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751646Ab3KMXlH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Nov 2013 18:41:07 -0500
Received: from vauxhall.crustytoothpaste.net (ng1.cptxoffice.net [208.74.121.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 779D32807A;
	Wed, 13 Nov 2013 23:41:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <52832DA0.7040108@free.fr>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237809>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2013 at 08:43:28AM +0100, Yann COLLETTE wrote:
> Hello,
>=20
> When I perform the git clone via git, it works. The problem is only
> happening via http.
> I tried to play with http.postBuffer and I set this parameter to
> it's maximum (a little bit before a git clone triggered a memory
> alloc problem) and I see that something big is trying to be
> downloaded. But I don't see such a big file in my history of
> commits. The maximum one seems to be around 50 Mo ...

Please keep the list in CC.

http.postBuffer doesn't affect clones, only pushes, so that isn't
relevant here.  You're experiencing something that is dropping the
connection over HTTP.  So you either have a bad proxy, or something else
is causing the connection to be dropped.  Since it's only over HTTP, I
suspect it's the former.

Do you have HTTPS, and if so, does it work if you try to clone over
that?

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJShA4JAAoJEL9TXYEfUvaL2RUP+wQZIS7l3PLuKbChidaQzcAw
NbYfm1+ocyeCbw+DNxd9oZgvswRYMZWjwIFbDQzDk8pS9ObZKcFFn5m4y69/LLOp
KnA4kSGyrDdQ+l5dvRrk+/BQ5U78qodZU8AhGxvfpWXBiCFzJoC67GFitByuRoaX
wo2LoLB+u39EOwayazIFGoVL0/eYwh8sJjHOImwhhSsKVkQ3QJJLZgO18z7gNHOy
6KaJPJlRzf7ozx36ttlr2OTWUqSlUHd517Zq6cUJDn2o4NJamjIq9NzXIyqDxShp
HYNczWAPWkJu8tjxnfecqeVqccZ7xfeQeNJaA4TOehTws3Eu0Aa+aU4aXhmaxfIW
cSfNU/4raQvTkorhwMLBMtA+irGWddyz37DmpV1LvH6v10Ra1ekE8NBtu2437d30
bJVVXQjo6cW+4jpgVqWykSUE3wVSheICagA6fLQLyNos19XKQJzkVStvhqBFNdMs
tMmEMZE/Nn83pTR6EsU+/CFpPvrvOaz/cewjoyuxy7ysaGiv/dPGuXfZWLx0W0qE
Zue8MW/1AkzyzRIRSCGTWmbmHBzSLRrsNTI6TVqEXHxdvGLXVXSeK7mNfioP5MQ4
bNFEhlbGk/hzriVO7kkFASzrhCGpTRD7CPGpnppFWvSU0kJPKgmVPADXjaTgyiOt
NjlVgKiyatSMtYCoFsi5
=Q9ps
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

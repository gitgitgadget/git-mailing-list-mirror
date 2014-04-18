From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: user.signingkey without gpg? (using s/mime or ssh?)
Date: Fri, 18 Apr 2014 21:44:08 +0000
Message-ID: <20140418214408.GB57656@vauxhall.crustytoothpaste.net>
References: <trinity-c71c6cb0-0c4f-4283-bca9-ae4aa0f3419c-1397851490695@3capp-gmx-bs08>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Cc: git@vger.kernel.org
To: Thomas Schittli <schittli@gmx.ch>
X-From: git-owner@vger.kernel.org Fri Apr 18 23:44:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbGa2-0000lQ-QO
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 23:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbaDRVoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 17:44:14 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47194 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754232AbaDRVoN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2014 17:44:13 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:c032:a559:d879:260d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2FC4B28087;
	Fri, 18 Apr 2014 21:44:12 +0000 (UTC)
Mail-Followup-To: Thomas Schittli <schittli@gmx.ch>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <trinity-c71c6cb0-0c4f-4283-bca9-ae4aa0f3419c-1397851490695@3capp-gmx-bs08>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-rc7-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246484>


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2014 at 10:04:50PM +0200, Thomas Schittli wrote:
> We already have trusted Certificates from a CA. Can we use them
> instead of an additional PGP key?

Git wants a key that can be used by GnuPG, and X.509 certificates can't
be.  It invokes the gpg binary that's in your path, so X.509 integration
isn't possible unless gpg learns about it.

> We already have:
> - s/mime certificate
> - web server ssl/tls certificate
> - XMPP Jabber ssl/tls certificate
> - Object Code Signing certificate
> =C2=A0
> Or if we have to use a new pgp key: can we sign it using any of our
> certificates?

Only in the sense that you can sign any arbitrary piece of text or data
with your certificates.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTUZyoAAoJEL9TXYEfUvaLbfgQAKTZoxEz0Lh5jWOvulyGgUgW
x9eMIwXPG1FKt2+kJBwOcs2lD99WABty47az1QUy5WyS+n67+RWWBFpfMuhdNMvu
y4EenklJLIj3E8do4EnUijq4D9hyqp1OE5VjvbZyPNYB3r2oo99bbTRwYO9LEEUb
j7Hm73L/OrpXNXR6XZeGZXW/14OjIrk5n/zwAq2p8nv4h3H7zMiTJSKaoPD5yoau
RSeRhmT/CNYoKAaqIPe9fTWyAlWOD4F3uA6/ug5nh5wMcyEgpKvOc/YgVqZuIGl4
Jl3sJhY2Oq8OJyJ9BbddvkJPkDcKzJGrHh94810Idr/UZH5urPw6kSlVD3SaLuiR
rHsXRpsGnWRVFyr1M3WJS9ZRJATXGnFCOi5NBVKJ0SwAuDwaoA/GKdEs73SW5kTC
zXjWtC1D8ZjGop4ROqmusSlwm2TOrPgBmCjf4TMSGpUVTKOzPeSKQIRTVoM7/gX1
mp9ab4Utl70jnNf+nUUWv1a4K959aI63OIep8Zvy1NXz2CHp9KafsIcv+P/qz76o
3pglxlAB+zn0JItjQJKePfmvb+XC2ROBqYxVmtOwERkvl6uWPb83AXEwzL1mKt5+
qyn0qAY1qHU47rkwzgXpurM957MVE1LBNbC6n/oCZ1SGww4dcktx8levz7AWPMe/
W80QvS+9K4N6gS++FgOA
=pqA8
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--

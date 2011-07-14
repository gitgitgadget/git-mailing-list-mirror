From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: How to provide authentication along with git command itself ?
Date: Thu, 14 Jul 2011 13:12:55 +0200
Message-ID: <1310641975.6041.3.camel@centaur.lab.cmartin.tk>
References: <20110714161508.2378c155@shiva.selfip.org>
	 <1310640646.18730.10.camel@bee.lab.cmartin.tk>
	 <20110714162953.36347b76@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-oczxSkWNHP4JNANJEc4l"
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Thu Jul 14 13:13:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhJrC-00036X-Fq
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 13:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468Ab1GNLNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 07:13:21 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:36036 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754415Ab1GNLNV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 07:13:21 -0400
Received: from [192.168.1.15] (brln-d9ba36b2.pool.mediaWays.net [217.186.54.178])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id DF340461FA;
	Thu, 14 Jul 2011 13:12:32 +0200 (CEST)
In-Reply-To: <20110714162953.36347b76@shiva.selfip.org>
X-Mailer: Evolution 2.32.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177116>


--=-oczxSkWNHP4JNANJEc4l
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-07-14 at 16:29 +0530, J. Bakshi wrote:
[...]
>=20
> Thanks for the response. Can I use the same .netrc to store different
> authentication for different repo ? Is it somehow possible to store
> the information at the concerned .git of the repo ? I think this will
> be easier for multiple repos.
>=20

I'm not sure, but netrc is not specific for any particular protocol. It
assumes that your login and password are the same for several services
on the same computer or set of computers.

It's often less hassle (and more efficient wrt. data transfer) to use
SSH. With gitolite you can give people access to git repositories over
SSH without giving them SSH access to the machine proper.

Cheers,
   cmn

--=-oczxSkWNHP4JNANJEc4l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOHs8qAAoJEHKRP1jG7ZzTSxQH/2CAfOQS66v+ARn6cEbvVmLE
hXPKKkHM+P5Whl68VAUzMWJRVAwbDREANiPSDOqMAjc4Lz5F1Q+L6xw+TV0X7Oo4
LvcnvNLSi8UBWw7P1fHf2N+cuBbUM7h6uN2jETRBRz7QOVJZSUJRjHsyq9jhVg5d
DWzF5ogjn1NbUkY7jknv6JpH6q+DdZDP4V0QoXwGN/yOtRMNUiZUxqtDOJeRa9Xu
5BjcWpxz1BfZpvIYxF1/ZOL4ZbZ8fhpNbeXLQ+QgZgr8b56lIb1sr8V0TPMGc3Od
UUjUb2xr2WAqHk1WD3X0hzumwXyjjJe/B011yC+vyEbuD5Hzflq0M6we/LrgCDk=
=DA8o
-----END PGP SIGNATURE-----

--=-oczxSkWNHP4JNANJEc4l--

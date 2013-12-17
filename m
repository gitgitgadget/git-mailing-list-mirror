From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git log --no-walk --tags produces strange result for certain user
Date: Tue, 17 Dec 2013 00:40:44 +0000
Message-ID: <20131217004044.GB259467@vauxhall.crustytoothpaste.net>
References: <5EE449B7-AB75-4EFF-85F9-292727FA1C53@jetbrains.com>
 <01D3F259-94E1-4084-9210-34E2DB7B7545@jetbrains.com>
 <52AEB181.9020006@alum.mit.edu>
 <AEF2BC21-6EE1-479F-BC63-7A5B95406A7F@jetbrains.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 01:40:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsiiU-0003vV-Pv
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 01:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009Ab3LQAkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 19:40:51 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34801 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750962Ab3LQAku (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Dec 2013 19:40:50 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:25f2:d8a1:a1:c2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6DDFD2807E;
	Tue, 17 Dec 2013 00:40:49 +0000 (UTC)
Mail-Followup-To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Disposition: inline
In-Reply-To: <AEF2BC21-6EE1-479F-BC63-7A5B95406A7F@jetbrains.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239372>


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2013 at 03:52:35PM +0400, Kirill Likhodedov wrote:
>=20
> Hi everybody,
>=20
> I received one more complaint for this issue, and now it appears in a pub=
lic repository https://github.com/spray/spray=20
>=20
> To reproduce:
>=20
> # git clone https://github.com/spray/spray=20
> # cd spray
> # git log --no-walk --tags --pretty=3D"%H %d" --decorate=3Dfull | tail -3
> 3273edafcd9f9701d62e061c5257c0a09e2e1fb7  (tag: refs/tags/v0.8.0-RC1)
> ff3a2946bc54da76ddb47e82c81419cc7ae3db6b  (tag: refs/tags/v0.7.0)
> 8b4043428b90b7f45b7241b3c2c032cf785479ce=20
>=20
> So here the last hash doesn't have a decoration.

This looks like a bug:

vauxhall ok % git describe 8b4043428b90b7f45b7241b3c2c032cf785479ce
v0.5.0

I'm looking at it.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSr52MAAoJEL9TXYEfUvaLc7UP/A2Ht27cwVUIDRekcszyIucT
UwKy6VxNYt01m01mWa3mjFZl9KRzg2HMrNpCbdK0XbINytR2GYBuCkMdg+dAlF3i
2wWtohnCYi5P7NaPjoNUS8ro/5j5Oca+uUpelcjMmX0PwJe3fF7kY4rF7S7fh4Pi
8DtIlAX9/SIYAHcJgh16jIIY6xWhLK7MwiDXht4FzaCf+aGPKZNlHljHBEe2WZac
Q5lQ2b+b5iQJUMCD8GeCykTdTtcTQkkmq9fSqL/sz+QDV5IKzsKAJTGY4/F5TQbV
5f1K/FKO58nbR1wbq2Huse+TJi9WBhbTBd6dpZ4x60VXagTrBgnMhKOnwQN6n5ro
qTpAIMySJF+qqSdLKwEa7rZLGKuQgsy1bw5BtvU62/fRuj6hKF4RYEpZ30Qyi4RK
bNsd+nkpguC0nakXQLWEhgYbtTZDLoiYQvyoh5qO4od6Ej6/sVxCPsMphtVvJM9t
Z+ox7Y9EcFPc6+sjg/3bvbu1BID/KNReaBkzxtx0kn78RVdVWD10i9iYqege/d6Z
eAU9CZrRXVI18GnbNTKy1ygDe8n2VigHn+BjqmtMm+5sNtwLLf8DGTsizSZUzZfZ
gHM/ynbIfI84h236MqOgI4xrlFziQ9oQLm7tfJZ9x2gQm22OeLyXAydXVRs6aiuM
GBRtTGKOAfsHyaL2DonO
=2nJV
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--

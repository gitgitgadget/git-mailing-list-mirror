From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Sat, 21 Sep 2013 21:29:05 +0000
Message-ID: <20130921212904.GA235845@vauxhall.crustytoothpaste.net>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 21 23:29:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNUk5-0008HT-6G
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 23:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719Ab3IUV3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 17:29:13 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60443 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751567Ab3IUV3M (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Sep 2013 17:29:12 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9A65E80001;
	Sat, 21 Sep 2013 21:29:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc7-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235148>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2013 at 01:48:08PM -0500, Felipe Contreras wrote:
> Hi,
>=20
> It was discussed before that there was a need to replace Git scripts
> from perl and sh that utilize the 'git' binary to do everything they
> need, which requires many forks, and that creates problems on
> platforms like Windows.
>=20
> This is a first step meant to show how a solution using Ruby would look l=
ike.
>=20
> Other alternatives just don't cut it. Shell scripts are too simple, and
> invariably require forks. Perl could use Git's internal C code, but it's =
syntax
> is too cumbersome and it's loosing more and more popularity. Python and R=
uby
> are the only modern languages that could fit all the needs, but Python's =
syntax
> is not ideal, specially considering the background of the Git community, =
and
> also, Ruby's C extensibility is simply superb.
>=20
> This patch series introduces Ruby bindings for Git's C internal library, =
and
> add example commands to show how it could be used, and how it resembles t=
he
> original C code, shell code, and perl code. Basically, Ruby fits like a g=
love.

A couple of things: first, I'm not opposed in principle to using Ruby
for git.  As you say, it's a good language and it has much nicer C
bindings.

As Junio has also pointed out in the past, there are people who aren't
able to use Ruby in the same way that they are Perl and Python.  If it's
announced now, Git 2.0 might be a good time to start accepting Ruby
scripts, as that will give people time to plan for its inclusion.

On a more technical note, my objection to your binding implementation is
that fundamentally, Ruby is an object-oriented language, but your
bindings don't take advantage of that; they're completely procedural.  I
realize most of the git codebase is as well, but that's because it's
written in C.  It seems a shame not to take advantage of what the
language offers, especially since I know others are going to want to
take advantage of the provided bindings.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSPg+gAAoJEL9TXYEfUvaLt4cP/16IKNz0A+a3IeNUpmYyJXTn
YGvJrV0j1vRADnxGpBJKvS4tijNID0pbCGK4Ygb+/ku2LgBVkExLBKJ9pWilsRXA
8cRf6NpRw/C9hJe29bzNhFxBh7miCwGoPuPwZQhhO4+yEWmEQogX5bZ+7SrXRkjn
MQvMGdgN7BDrRzAEWDbUvtrqDgsAbvVfNppNIoBde4+Edg2Gk/GCz48vrGDTFLGs
tGPJWkgMdnu7EOk2lTgdU3V1PmooP2HjS/lGpZ2QQ6mYpGtrvBJjQJTLmHWFuAkA
tIfc3lRPJwSDwMIG2UWCscl4Ag/4HVpiQLDyLEIKbvvJ3KQxVKqX7ZHDu3qTbMWN
xRk9nnP64apvE3n8P1HL+lUoj5tjYS08ETFmZ3IKuDNtrMvipd7Y+GpzTdKxNEgH
E/Wbd8b1vQG1AT6gjYwBk0TTnCenk/vXS+ZJtGIF5U0wU9wCGIZ473Mm+/DSOLiv
F+6YH/ZksBMWG4MmgA9lZ7OrcZ3+cC5heCKIF/3x9dl2jEc1PWcWK763AgRDewiK
xlOL4vAD0EQzVziEJu93O+LluvrIcPOyvpgkpwlDUfT0SNjmuuQMjJusNKhmEuGt
TW95W7lqc/bUSiZeZD3LXRaYrGUXPlhovTHsihA6/XR0PsLWuYQk+i7AkAbPPMyr
v+18/+mdYCtWAteGNaHn
=jqGn
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

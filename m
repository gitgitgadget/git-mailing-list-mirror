From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Feature Proposal: Track all branches from a given remote
Date: Sun, 26 Oct 2014 00:16:10 +0000
Message-ID: <20141026001610.GK312818@vauxhall.crustytoothpaste.net>
References: <CAEFop41rvXCAawW7zWGzT251zWyyoMhQbg=5vtHzQrbk4W6D_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1rguoi8KZGYj2k4L"
Cc: git@vger.kernel.org
To: Scott Johnson <jaywir3@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 02:16:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiBVT-0006Zd-JS
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 02:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbaJZAQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2014 20:16:17 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49573 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751361AbaJZAQR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Oct 2014 20:16:17 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8EA722808F;
	Sun, 26 Oct 2014 00:16:14 +0000 (UTC)
Mail-Followup-To: Scott Johnson <jaywir3@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAEFop41rvXCAawW7zWGzT251zWyyoMhQbg=5vtHzQrbk4W6D_Q@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1rguoi8KZGYj2k4L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2014 at 04:34:30PM -0700, Scott Johnson wrote:
> Hello git experts:
>=20
> Recently, I've encountered the problem where I would like to set my
> local repository copy to track all branches on a given remote. There
> does not appear to be a switch for this in the git-branch command
> currently, however, I will admit that my somewhat limited
> understanding of the git-branch manpage might be causing me simply not
> to see it.

I don't know about a command line option for this, but I think there's a
way to achieve what you're looking for.

> So, for example, if I were to run:
>=20
> git-branch --track-remote origin
>=20
> and I had two branches on origin, master and maint, respectively,
> after the command finishes, my local repo would now have two branches,
> master (set up to track origin/master), and maint (setup to track
> origin/maint).

You could do something like this in .git/config:

[remote "origin"]
  fetch =3D refs/heads/*:refs/heads/*

You won't be able to fetch if you would overwrite the current branch,
though.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--1rguoi8KZGYj2k4L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUTD1KAAoJEL9TXYEfUvaLoDgP/0Vx44rcp2i/jTrffYsiTUCy
W5m0YE2AKNUZOPcLvP18+2KjiM9n/Ot9qWU3Q0pD7fcCKUjAerLstz/ADzWQy8uq
+IkCRJvjtqoBnVLZLm1IBetGELPkRpT3GOSgNVgKA8sz5UxWfZVgd4Sb1G3qemRO
hb14Qa4canFOkHy3+Fjn4a3LoruTt2SLeyXhYEvVas/Ie92dDmLUdPUAFzAx2h+9
rmUdcc9TASYvfZls1rW4qrPb1TVsTFgwF2wc/WlMWejTmWBdnpLinnoU3TsHzHr0
3k2z0VN469EXcaOmQ7e5gHUFtCYyWTOtgPuHjf+GYcdtbEUtGtp/jqOFcRg3IhN0
MM/+2/KG7uwpGl1McmtBnxoOISdma5p00CMqCDBdDq8K2yrw2xp3DEsbB61Dc4ou
kZjtbH7UcAIWinNcsjNN3LTA6LxdfZzIp5RKmqaN1PnnB7SSK7s0Z4PNoNIygL+T
pwSqNQWGeepPGjRyMvmTiPxnFtl+mYLInfo7hdwIRuUJGpSj1I+O8QEMMxv+C+98
glQcszaiJ36XLl5K8Qi7f30lDsrlQehJhyfepqOuSOLM1usuiMf5fKqxtysExKWD
O49jxVJ5/Z2ntcPvs0n5puFT3w9szW3A0mUSZ2yqtimMEZNqmOGmJDukZcpgE9WH
DeO9uhXXzpKmxsQrcP3J
=nObK
-----END PGP SIGNATURE-----

--1rguoi8KZGYj2k4L--

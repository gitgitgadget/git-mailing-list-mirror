From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Show total commit count of two authors or more authors into
 first author
Date: Sun, 6 Dec 2015 21:20:16 +0000
Message-ID: <20151206212016.GA585454@vauxhall.crustytoothpaste.net>
References: <CAD6G_RQ2Ub8HasupNbUFK2LJfir25tNFTqrqU2ELoEJHOibzHA@mail.gmail.com>
 <87wpsrz843.fsf@igel.home>
 <CAD6G_RRtH5yBqwrgMxhrSXb++n6CNA2qXcNn+Z2ALSyV8b9ZuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Git List <git@vger.kernel.org>
To: Jagan Teki <jteki@openedev.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 22:20:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5gjN-0004dT-Cg
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 22:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558AbbLFVUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 16:20:25 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60746 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754481AbbLFVUY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2015 16:20:24 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2D5242808C;
	Sun,  6 Dec 2015 21:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1449436822;
	bh=SaucXXyRMZ5N/sFlrL+SYGw6wwHWCaZl0JisGfvgOxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIBwrRufSNDR/xv0QznJPImgqChbaWSnSPQ95AAKg1xSdz0tr/4+5W/uIzvwwYimh
	 9a1eVFexcWKHuwAJo4LXz+n3Ihjb3c8h8mu1yFIgfEVDYWZhC5X5zNdCBK/8Bj8QkR
	 z/UkTj4Cb9PrvldjFlWbvDO+f/uB6yLHOFALtDhUjObvhKL3un5ocPop59LX/RC/Ej
	 1hFzTM4MwsoW6UC680cXLv6NjnhUX4UeeJOEXU65LZHjy6OeL84y5JfPb36S2diRIE
	 YXsH/o49pYC/D0hzstUuf80v6tLiyGxyAe4llqSdXzMkb5JtBSxiZwdJj+/vecnoMu
	 mPuiVb0oyuj1Ic06pOR0Xm6nyuwnQcXaRFv97h+YKKPFLsJiI3eGRAx5MgjUFqaJiY
	 nE2aZbnNzrZeWy3JOiSlVb0A5cbad/VRUyPJS62GdKYqWc631NOBlmJ/Bk9mnPFuxl
	 0sf80tbzpId09ws0rXOf3Rxvs15rnd1vyQVKg57s+Sf4cwOfgqJ
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jagan Teki <jteki@openedev.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Git List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD6G_RRtH5yBqwrgMxhrSXb++n6CNA2qXcNn+Z2ALSyV8b9ZuA@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.2.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282064>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 07, 2015 at 01:45:19AM +0530, Jagan Teki wrote:
> Thanks for the info, I'm able to map two author with e-mail but it's
> not working when I group 3
>=20
> $ .mailmap
> Jagan Teki <a@abc.com> Jagannadha Teki <x@xynz.com>
>=20
> The above worked but how about 3 names mapping
>=20
> $ .mailmap
> Jagan Teki <a@abc.com> Jagannadha Teki <x@xynz.com> Jagannadha
> Sutradharudu Teki<p@pqr.com>
>=20
> Finally I need to map all 3 into Jagan Teki <a@abc.com>

You probably want to map two at a time.  So something like this:

  Jagan Teki <a@abc.com> Jagannadha Teki <x@xynz.com>
  Jagan Teki <a@abc.com> Jagannadha Sutradharudu Teki <p@pqr.com>
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.9 (GNU/Linux)

iQIcBAEBCgAGBQJWZKaQAAoJEL9TXYEfUvaLYxYP/RRFLxgJ+Wo5IjjxWAMYKg0B
rHCFzvUEH9TBJbJeEi7kotzxVFkg3nLp3xbNs6l1XQq+TL4sS822BAaAVuoiJLA+
DrTJmpsJK+VA3tRxNUsKWeu9WCoNXC50PiJYUNtgLo3fW4xgImoOZ9YDql0fHCKy
IYt+HQQLUGp4EbFsduz7udYV6BXpetmBrsJKVvPJBGVTDi/uyn7GjljZvyCmtXh9
LZSJ8CqvyGu35mMKKFMQmIbyyS4agpQXw3m3nGMJ0XL6uq7paW8yhGdGnP5jIhUt
54sG/K0miqff+k0HHhP6fMt5I0QRKNWzVzvnw6oY4xJuPaB2v2lzm0gdh59U4KFU
nxobeCw8x/FpFpvMMVno2/COmJ95H0VPu5yW0e0b1WWGdncN9N5z5O1mTav5qJfn
qEhIC4xcMUG/fp7OX6D+1bsUzFmFJXLYMATjtrNvwmnq6iCroK/x3D9Eqj0W6+uQ
gSAxxIIT45ezhRJGg98a3I0inIlE8tUrmSSZKfq22MdLcaykb6Aid1FeOzzA6ilB
OU9NmqKabkG1FKZExAjqUU7kGLod2vtft292OQWmgpon1m8OhesH6WwuZaOkCd9M
HvdPMyn0CnMMsgxBb0/VWkbMEFTc/vUTBR+4JjLwSTEnXc0i3KZYchBMxp5hmMlQ
li5RZiRNZKdHP2fjh9VA
=ZqJr
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

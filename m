From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Sun, 26 Oct 2014 21:15:04 +0000
Message-ID: <20141026211503.GA422734@vauxhall.crustytoothpaste.net>
References: <20141020115943.GA27144@gmail.com>
 <CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>
 <20141020222809.GB223410@vauxhall.crustytoothpaste.net>
 <CA+55aFyZ1Mzjdx+JsD4jmFnJo+xL8xLz5+mtbh+_25bCak-7hQ@mail.gmail.com>
 <54461483.9010600@drmicha.warpmail.net>
 <xmqqwq7tz3wt.fsf@gitster.dls.corp.google.com>
 <54477C18.5060806@drmicha.warpmail.net>
 <20141023010927.GE312818@vauxhall.crustytoothpaste.net>
 <544D44AB.1080305@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 26 22:15:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiV9j-0007Fa-6z
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 22:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbaJZVPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 17:15:13 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49576 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751619AbaJZVPL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Oct 2014 17:15:11 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BF3F02808F
	for <git@vger.kernel.org>; Sun, 26 Oct 2014 21:15:07 +0000 (UTC)
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <544D44AB.1080305@web.de>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2014 at 07:59:55PM +0100, Ren=C3=A9 Scharfe wrote:
> Am 23.10.2014 um 03:09 schrieb brian m. carlson:
> >The pax format is an extension of the tar format.  All of the pax
> >implementations I've seen on Linux (OpenBSD's and MirBSD's) don't
> >actually understand the pax headers and emit them as files.  7zip does
> >as well.  I expect there are other Unix systems where tar itself doesn't
> >understand pax headers, although I don't have access to anything other
> >than Linux and FreeBSD.
>=20
> NetBSD's tar does as well.
>=20
> It's surprising and sad to see *pax* implementations not supporting pax
> extended headers in 2014, though.  It seems long file names etc. are not
> common enough.  Or perhaps pax is simply not used that much.

The original pax utility didn't specify the pax format, only cpio and
ustar.  The pax format was first release in POSIX 1003.1-2001.

> >Since it's very common to extract tar archives in /tmp, I didn't want to
> >leave world-writable files in /tmp (or anywhere else someone might get
> >to them).  While the contents probably aren't sensitive, a malicious
> >user might fill someone's quota by "helpfully" appending /dev/zero to
> >the file.  And yes, users do these things.
>=20
> The extracted files are only world-writable if umask & 2 =3D=3D 0 or if -p
> (preserve permissions) has been used, no?

Yes, unless you're the superuser, in which case that's the default.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUTWRXAAoJEL9TXYEfUvaLXxkP/0hL2oaKqqDKrDp7X+pOQNpr
KX5RWXeIw3Bi6CU7W28VzjqV/D6y8hbAmt/OdkMiBVp83lEA3QrBsl0OphAnkRyx
arCX7VOOIGIiAJbTBKcrGFoJXal5SrJGjcDpKk5EZAoAtL5CwexAe2HS1wlByc4S
SbRSeTVQzsVYMRVbIXAbIq5iWuxVWuyxoktILOl8YV/RioC2l0m6EDtLVxaWXpVZ
fuvqmmDpK++HioS0atUsSyHy9JWfSGh/0sZCKxDIqad/jobMQGAyKU+qJ6UNb/KV
qEo6e42qu5vX59FG3BBCM6obdMJNBQCB8bpSF2zXnxXPep8wgi461P8wBHeqJci4
+UDbWxXIPWpoDUxQ/BW7E1UXTAp28vUn7AXeQVBPIUuY0/KwsHCQ219+TEekesWr
RCRf+6v4lg0lPosnAOoNTJMQtO6bY2lqYrMcnAOPV3ffP08efZHY0SqdnYDhiGyS
YlSzo7bpFSqD7wWNqwLxCWOyrrbKRSbUDYyiQvmKD/L4tp8koQBPx12hO2V/1SmI
5F30TARDdhge62+LFAvvD3n/CQC1wJDn88MH0pTLmLO6pLPwHFM3HNIALa5EEPve
2NSCS9U0OoMIaMfedFmfDLqBEPq0dirdqukaJQv3W36tj9N9b9mEAO5fmwRlZKao
Wr1gVjkH7grouNDuRjnu
=XzAC
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

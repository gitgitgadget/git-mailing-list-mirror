Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9C13E02E
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727298045; cv=none; b=q1BmSYUzQ5BQ8Abdlf3sALa9OPCc31z4b+yeJvSbAhJR9AAv4KyuL1FsnYlflxDKiLsNyHO8LgeoZvAnRmZClyykm0ZjzvsVts1lniMb+icvwPSDreY7d1FzYmHtIMXXP4tWK1Y2gfE1FCB3qDTW5WVyH4tqtouYpxLoCvzjprQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727298045; c=relaxed/simple;
	bh=YIUrBbYnQBAGXeRitPPQyAk2rFeo528BfDP6jtTHsEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSzkfkrYTzaAADd2KB/hELK8BJklTtwDHduewnmLTpM+gF6rCC1PPw7rYbLCjMME8oUx5hJRgyZ8WeZhOYoCBIBwWRJf/0yd8D1qu6RhYXsnKMK+WYPxph0fX74v8p6RA9t0mSDiw56zNxu71XkUhn5zY3DSOjoJK++mjZt5jps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=GDJyHfiR; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GDJyHfiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727298039;
	bh=YIUrBbYnQBAGXeRitPPQyAk2rFeo528BfDP6jtTHsEs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=GDJyHfiRYaQ6nIGWCWLq+o378oFUyzpR4bDkoNLre/8acHCUNrInSxqrFmy/2XzSh
	 BfKTRHQc/6460RUrFPc8wRVEbOO4rCy6FoZOSc649UTLQgWdrW0D92XclX4Lafxtim
	 3+bpgWgmw8gVKzNbCx1TGU89Gg8tRa6jmP/6SyNGsS7sXNUUL8GtJDTTAuoW0TLBys
	 5gYTBxcRK/61THlVbwqexnTFxuVjOm4Rc9hwgstJCo5PDNM4qj+9Yi5gVOobwE6btz
	 jkAuS+OEuIvnUlHxt3cJXR5Qr1XyepfYg56+fdGZaaHSXMwAvDyy6hDosx3QCMfsD9
	 JCukW5PeBYlMEEiF6DIDNAPuddKAiW4FOkVNDfvBC77zMRsmm7Ohf39TOUNjDflGRk
	 V3WEGR9ISnaISGaxbre2Rux8oFwe/qhtLCN/pxN3rsvkIvtmeNu7rPZEBsb5TXBzcl
	 Hw+K1i/2eUGNgDTgT7/9OrIZJta298nn5R2MrTXDSALTImlcTEH
Received: from tapette.crustytoothpaste.net (bras-base-toroon0240w-grc-52-65-94-52-227.dsl.bell.ca [65.94.52.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CEA7820073;
	Wed, 25 Sep 2024 21:00:39 +0000 (UTC)
Date: Wed, 25 Sep 2024 21:00:34 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Git clone failure
Message-ID: <ZvR58tnLEMBZC4fa@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Krishna Vivek Vitta <kvitta@microsoft.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <SI2P153MB071833367C62DD94C96CF1F7D46F2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <ZvMy_gAL96v8ahfz@tapette.crustytoothpaste.net>
 <SI2P153MB07185B9AED66870BBAD3C78AD4692@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nIo12MNZpbr13s98"
Content-Disposition: inline
In-Reply-To: <SI2P153MB07185B9AED66870BBAD3C78AD4692@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.13 (2024-03-09)


--nIo12MNZpbr13s98
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-25 at 08:49:11, Krishna Vivek Vitta wrote:
>=20
> Hi Brian
>=20
> Thanks for the response.
>=20
> It is a WSL2 environment with kernel version: 5.15.153. We have used a ke=
rnel version 6.6.36.3 as well. Scenario fails there as well.
>=20
> root@DESKTOP-OOHD5UG:/sys/kernel/debug/tracing# uname -a Linux DESKTOP-OO=
HD5UG 5.15.153.1-microsoft-standard-WSL2 #1 SMP Fri Mar 29 23:14:13 UTC 202=
4 x86_64 x86_64 x86_64 GNU/Linux
>=20
> Mount point information:
> C:\ on /mnt/c type 9p (rw,noatime,dirsync,aname=3Ddrvfs;path=3DC:\;uid=3D=
1000;gid=3D1000;symlinkroot=3D/mnt/,mmap,access=3Dclient,msize=3D65536,tran=
s=3Dfd,rfd=3D5,wfd=3D5)
>=20
> We aren't using any sort of file syncing service.
>=20
> We have installed a defender software which is marking mount points for F=
ANOTIFY to intercept filesystem events. On removing the marking, git clone =
succeeds.

My guess is that whatever software you're using to intercept file system
events is causing the "unknown error occurred while reading the
configuration files" message and you should remove that software and
reboot to see if the problem goes away, even though fanotify is enabled.

It's very common that the kind of "defender software" you're using
breaks a variety of software, including Git and Git LFS, and in general,
the recommendation we give in the Git FAQ is that you use only the
system default antivirus (and on Linux or WSL, none, since there is no
default).
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--nIo12MNZpbr13s98
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZvR58QAKCRB8DEliiIei
gblqAQDbCFg31lICwkY1j74alWRGjhRsdRMsm1i+FiTFKyS9KwD/aJXdMChomYrT
RTW9ugUl6WV4JZsqQPfdZAjjGhehFAY=
=B09h
-----END PGP SIGNATURE-----

--nIo12MNZpbr13s98--

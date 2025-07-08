Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542361FAC4E
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973360; cv=none; b=kQwEgxteolaCJDBTXNlpN6tPBmv0JNav2l+1TfdC/X0c/t8StdQiD46KtyWGNsByM0CT+jJtTAAW1L0sZfZlAbXqo3k7SpR+rg8fP3w7ZKVbz1vXxPyKpLum6goQ9Dh3WYKPwYxyCs0tdExaE6VOvNY5GWjg58lg+OTHU6HmiNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973360; c=relaxed/simple;
	bh=cTXLVj7JUWpkARue+ZaTiBfHVgKIJLkJ92pF5TbgWXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyKp6RPFfFuu7nr7FbNZX4e5F8rQjSoV0w2yCriNYNpInRtIwgbB6SIKBDaqorhKhcFRHdZyAwuPbgud1rkZ6ZGzyPAp1JbO+fiOhHHWRR+uCkJF9+EYKujAp2TEMBqTe06cBpX5XI0qaGLVSyHgkh+7g7IK+x/dL/7NtvQJil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=KEfM7yE2; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KEfM7yE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751973350;
	bh=cTXLVj7JUWpkARue+ZaTiBfHVgKIJLkJ92pF5TbgWXc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=KEfM7yE2G2IC+3iY/F1dEl6eXfBrXqwz3MBHdr5sn3fLc9xxC7N8ZnflgxTDMsGmZ
	 82xGx4SI7RdI62GRwdwVx8hi+GewOhB657g+/6D9soFwWS0DY4bpXO2DP3oqpAQb6u
	 LnBjpM9ieFRmwx8Sq3OJ9hUZLWBmT31jNG8jrjYm6HtHtoS7SeXTqCic7nuk+kdfAp
	 qEXpvZu7m98oBDO6IzEUdRZKz+vrbwOpZVb3/45GnX/M03uhPoA6zfRUhMLO3PFvKp
	 AY5D826I33qmNuvLqYO3K8QjyPGtJTBXfK8RQpkl+c6O0hd6lTOuDSljcfwtXZbyUf
	 3NfYKON8eMIzCnXAwxFgv7jyToeEy6Nq5RYFnFeCvqbsIJeWb1FQELvbn1u2qz7AQ6
	 7BuExruyhRLIeRAzJQnfGqvr1T3KhESB64rRxa1mCR3M3P3Zv+7OWF8gEXtmtoMIX2
	 osQ/ScPtvbqOGKphWG8jZCeh574nJrpRwViPm2Fh4KJxFwn7vSZ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9b33:1455:7422:1bd9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AAED52006F;
	Tue,  8 Jul 2025 11:15:50 +0000 (UTC)
Date: Tue, 8 Jul 2025 11:15:49 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Fabio Frumento <frumento.fabio@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git bash 2.50.0(2) not working on windows 11 PRO 64bit
Message-ID: <aGz95cpfS0s4zsMc@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Fabio Frumento <frumento.fabio@gmail.com>, git@vger.kernel.org
References: <C4F62B0F-1729-437B-B9C0-0FEA74B307E0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pbaT0FlxsaFCaZwR"
Content-Disposition: inline
In-Reply-To: <C4F62B0F-1729-437B-B9C0-0FEA74B307E0@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--pbaT0FlxsaFCaZwR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-07 at 12:18:08, Fabio Frumento wrote:
> Hi,

Hi,

> After upgrading from 2.49 to 2.50 git bash won=E2=80=99t start anymore, a=
 prompt window shortly appears and close immediately, downgrading to 2.49 s=
olve the issue
>=20
> So 2.50 don=E2=80=99t work on windows 11 Pro

The Git project doesn't ship any binaries, only source code, and we
don't ship bash at all.  The Git for Windows project, however, does ship
Git bash, and you can report this problem to them at
https://github.com/git-for-windows/git/issues.

I would suggest reading the contributor documentation and seeing if you
can pin down more about why it's not working, since the report as it
stands seems unlikely to be resolved.  I feel confident that Git for
Windows 2.50 actually works fine for many people on Windows 11 Pro, so
the more information you can provide about what might be going on, the
more likely it is that your bug will be addressed.

Best of luck with your problem.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--pbaT0FlxsaFCaZwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaGz95AAKCRB8DEliiIei
gaWoAP9jJ7/HYzAelCbSrNyrsbHFs84esZ4EZn+tRTrY+BqogwD9HowLDK59Kw/R
Qbe6N2KPPpZ1pWUdVIuXCoHP0IgJRws=
=BQwz
-----END PGP SIGNATURE-----

--pbaT0FlxsaFCaZwR--

Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C74690
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749746935; cv=none; b=ig0Cm7bRR30Cfsrh+RDz0e8i9JKqt+bk+FSXbVRJpEYghDQxqlNxS5FcrNMJ7QysMN2KlIqUhKoLbUstyWsNhnoLolVmBeJ8TiTr+YwLLlAj0ZBQvJrj95r0BTSUXAtmyYLH435kB6wCDajRVgZS5UVxEFFynjHof2kMpWcrOcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749746935; c=relaxed/simple;
	bh=D8hYubGdUuVOqBZNixXhpQg7tqJTgMe3qgCmqj+fEQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfJvQLTvwa0qnk/IWmk8JelbGrpgWHfZbJ8KxJ/h+VvDM8UQG+zkKeLmUy6KRRqfEe/7Y9uHmgpuBmGNUzsvOz/jYN24emAcxSj70Xvly9ZTWUr3BrHrdUNo++hyStehv5/9GBpz+WoHgCZAN6tzOQECWQFUqQH8rD9JeXjeCWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=G0UAoDy2; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="G0UAoDy2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1749746931;
	bh=D8hYubGdUuVOqBZNixXhpQg7tqJTgMe3qgCmqj+fEQA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=G0UAoDy2KAtQEtJCjBn3wiElxqht/JlqkHr51z1mzmtGoFkLqiChyaUv/lHPjjgMM
	 Z3MY7V/beOSA3rJ+da/GFdp0z8Y41TP2GvlafU9B0W85l3AILT3Pduc/3w9iZ57I3u
	 VFdkz7HrdnhBj7w3IC5Wck2vGRE1MlkvG/DTwbixTaMTKVG+B2w9di7QszmADSzjBs
	 z+RVPiQDJNuPFhlKBwxf81TnmvQTTPo4dEg8oDQIs9gR5qUHDEZkfl9j7xvClNIadJ
	 QSSmrXQwwDTK3tLv1pjW/f2KdcX/KAYk9gzI7n0OMT7IXpeT3UAAWLBlOmvhMKd3eG
	 0LtpqRdfuuHHlc6P8dXkEfKx4668wkcxmEt50N3VSZKjjNHig/ALZV2ibNARYB2fFz
	 5MnOlL67glrmO2l89ygQiYf9mesvZiFitvxnlNFnK3a2oENHm6eUW6QEenlta1F7PR
	 GXJlOJyACiOM/lC2Y22SJc6GOjNf6nVd+6cfX1P5+bNrzdZA6v9
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2FD9420038;
	Thu, 12 Jun 2025 16:48:51 +0000 (UTC)
Date: Thu, 12 Jun 2025 16:48:49 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Carlo Arenas <carenas@gmail.com>
Cc: Brad Smith <brad@comstyle.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] config.mak.uname: update settings for FreeBSD
Message-ID: <aEsE8S90fJSr9Or5@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Carlo Arenas <carenas@gmail.com>, Brad Smith <brad@comstyle.com>,
	git@vger.kernel.org
References: <CAPUEspguEY+e-J0dMA2EdDgu=t4fK5ASS13Jfp_Mgwiq3Rtd0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3MA3HHKa4zT7/PQQ"
Content-Disposition: inline
In-Reply-To: <CAPUEspguEY+e-J0dMA2EdDgu=t4fK5ASS13Jfp_Mgwiq3Rtd0Q@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--3MA3HHKa4zT7/PQQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-12 at 13:52:03, Carlo Arenas wrote:
> On Thu, Jun 12, 2025 at 12:36:46AM -0800, Brad Smith wrote:
> >
> > FreeBSD 6.0 has memmem().
>=20
> but AFAIK it was buggy, uncompatible with the "standard" and
> didn't perform that well, at least until FreeBSD 12.
>=20
> assuming that the system version is indeed faster than the
> one provided with git (which should be true but worth testing)
> then it might be better to only enable this for later versions?

FreeBSD 11.4 (the last version of FreeBSD 11) went end of life in
September 2021, so nobody should be using it since it hasn't had
security support since then.  And it's even been functional (but slow)
since FreeBSD 11.0, and 10.4 went EOL in 2018.  So users shouldn't
actually be experiencing any actual functionality problems since then.

I don't think it's a big deal for people who want to use an obsolete OS
(which, to be clear, I'm not encouraging) to tweak the Makefile knobs a
bit.

> > With making 6.0 the minimum version drop bits for supporting
> > FreeBSD 4.x.
>=20
> FreeBSD 4.x is no longer supported and wouldn't even build a
> current git, since it predates C99 and is missing POSIX
> compatibility with what we require (ex: no statvfs)

I definitely think getting rid of FreeBSD 4 support is fine.  It doesn't
even support AMD64, so as a practical matter it wouldn't be useful on
any sort of modern hardware.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--3MA3HHKa4zT7/PQQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaEsE8QAKCRB8DEliiIei
gaf2AQDNuFWk83rq7afORPZ3vpPcAmZK189lNtz1E6Reva+n9AD/VBflpDljGgGo
jVYiDebxKNJS0t6tG5OpHBBuZ4tqFAE=
=/s17
-----END PGP SIGNATURE-----

--3MA3HHKa4zT7/PQQ--

Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D551E505
	for <git@vger.kernel.org>; Sat,  3 Aug 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722700835; cv=none; b=pFP4dbNtCpM4Mdh/a5VUmOH/n4S43JoBO1nQer4GBu9dsUxXpPaTS49O5NtRCH7cPu12LAPX74V/yOL2qgqsiQ9srJzGAVC3r09+Wzm1zDoyy8pmDpvYO5m3VNGbN+s9DtX57Ausa7/x8rKKP2aaBnEBC6jWtiW7zOta0nnrp+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722700835; c=relaxed/simple;
	bh=I2Udpg5ak8ImvdO4MqQoViu1YA7Q/TOof79k1R3tAuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUQ296tbTSvwuReewz6mTFly08OV9w1MT3YwcSoP+F3vHiDA7S6DojiP0sEw0fOg/BJ4YB+16TNOxX9o/naXa46S5DzNXyHQxDjXxmLCJH+E/HXvT2I6MASg+6HmRVoxpgQ/F4MyFVJLQdPkUe8a4oPtXPr+BOQG+fGcWcoQHcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Xv86Rzkk; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Xv86Rzkk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1722700823;
	bh=I2Udpg5ak8ImvdO4MqQoViu1YA7Q/TOof79k1R3tAuw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Xv86RzkkYnPUXBAQjl43+wYRn5qSy8JtAbt13csLelcy5xQ5sQbRYjmQnza4rM6Jq
	 cemHUDSJOYMhvKETTEObAO0+n+Dhibjdw/UQuPOQUaLbRt5H5sICBt5Hw6UpPn95kD
	 43rvlEYKsrGMsYlcimLly8lmK1KzVLn8i/7AjXfCmSQGidt95TCMjgyg2gv+cMqm3y
	 Zy5L8FCCK8gzR+jX39e3ydT1xPRV4e0oPCGa3lsqJavdaD3TQzZtzv+6Tslx6/qz9F
	 Xu8YSCszZ41Nptp1QoSRsFPxnwLN7y5Vw8i/TVFeAzkhOgpQr1O15CnN1RSYDYWTtQ
	 GDkx4YyOa3O7G19qsyxru8AuBAEEEzuLiDBp28z5MXZiLhULxDMnEC9jgNWyIjXZGx
	 FoD6KZRbJE9q9P7dl36xodyYmRYnV49rqtxp9o4rgs7LHKl2zez1G91ixzNRb8VuuM
	 QBpqCk+Xi1K+Olgchr4XM98/SvOkA/eKN8PeMaUmicqEbSWAr+1
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A0F5B209BD;
	Sat,  3 Aug 2024 16:00:23 +0000 (UTC)
Date: Sat, 3 Aug 2024 16:00:21 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kim Scarborough <kim@scarborough.kim>
Cc: git@vger.kernel.org
Subject: Re: Git and gettext
Message-ID: <Zq5UFYnWL1jdgDaH@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kim Scarborough <kim@scarborough.kim>, git@vger.kernel.org
References: <bf5a7771-f616-47d9-a014-f9d3e0afaa08@scarborough.kim>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oK2gpwVsg4QYD9R4"
Content-Disposition: inline
In-Reply-To: <bf5a7771-f616-47d9-a014-f9d3e0afaa08@scarborough.kim>
User-Agent: Mutt/2.2.12 (2023-09-09)


--oK2gpwVsg4QYD9R4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-03 at 07:58:55, Kim Scarborough wrote:
> Hi folks,
>=20
> Was wondering why I need gettext to compile git, even if I tell it I don't
> need NLS. I've not needed it to compile anything else. Is this really
> necessary to run git?

I believe you can use NO_GETTEXT=3D1 and NO_MSGFMT=3D1 (both must be set) to
remove the need for gettext and msgfmt.  The latter can be omitted if
you're not building git-gui.  You can see other configuration options at
the top of the Makefile.

I will note that both of these commands are required as of POSIX
1003.1-2024, though.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--oK2gpwVsg4QYD9R4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZq5UFQAKCRB8DEliiIei
gYGfAQDl0NaXxwMQMHzRV1j2U87YLspicA9DbEZSz2BEbonhQwEAjXwb7/4mwDqp
c2kPFPaFYxm2gLVZka/1e+PYo+OIigI=
=RLQt
-----END PGP SIGNATURE-----

--oK2gpwVsg4QYD9R4--

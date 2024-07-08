Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36AB7345B
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720475664; cv=none; b=kGUHjYgkHyrOnF3rDsCymexGbiKNygeq3Agb8hj/gblmvhzgQe9T3ejboMKZcrPwCssarIf111+WCw+8Hkblw4iZZ8tX9GMtvY+rfLJNyW20Ho3w4CXjWwEQjTIMpVB6HD3gmqe4mJf/GOit7zGnZ+25ME4GzrF6hiK+b3V38Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720475664; c=relaxed/simple;
	bh=8aFxmN1k4i25dNjsybQs3AduZYx3+qESNZ3FjoTUAcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrWd/FGhMzNUdfYLIxrZ5FwwFm7NDZH2T0Q/x+pkjc6lBQpuCSMxd6ngI7gDX/9r4qAdrvQLa/DtJNbp9WqGjq/GATrdDolwqNGGXFK21oxhzX0mL40gTS+BZJ1JUACBswpTpvOGcjS7GawXe1KmEsIHrc3tHdrWVBnc8jMdI0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=x6HAz1ni; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="x6HAz1ni"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720475660;
	bh=8aFxmN1k4i25dNjsybQs3AduZYx3+qESNZ3FjoTUAcE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=x6HAz1niSL221EPm5WKHKSqIW2uOVnasMv8vfRaRlqXBL/WodgKRePoSsx/EiOVwc
	 89twkjlE7MyjkQx3J+yFjtc1lfzaH4qvN1ijcY1I6FVkXSuFeMz6V4W5QvM83/drss
	 iNuPVHMandUmIrcdXS2HPEDlWtNM4lJFYpOeyfB6RdS2JEwUXonn28/FKtWJ99ia/s
	 bIcEHWw+fxDkx08wqXpplVkT0XD2VtfWvfZV2RCe5xVsViz2HNpCTXN/NOrZweJOb1
	 cYGNaX08IENlgL8SutR3VA/QoLoyH4aNbG4cEEH3OuIl0jULCleIKFCOJgTtKAk+kQ
	 InsM6DZqvWYaJN/U1IGdY9mlYUzMi7gJnYPC4iXFjShwC02rnVlR//wY3dU4wL2pWX
	 LR13lG8cTJxeqzRgOshAdBSgMALr3q4ZTl1t/Yp2lZzgYeobqZQ+V8+wPNCJ8ze+fe
	 w7dwa2KRykX91wNoQz2T1qazKDRRiv8DFRT5cGzDai/8f+qSkMB
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A564C20991;
	Mon,  8 Jul 2024 21:54:20 +0000 (UTC)
Date: Mon, 8 Jul 2024 21:54:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Adam Pickett <apickett@envirovent.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Update for Windows - Cloudflare Direct IP
Message-ID: <ZoxgCya4xt5JuLJP@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Adam Pickett <apickett@envirovent.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <DU0PR02MB9942C645E78AC23619F05D0CA0DA2@DU0PR02MB9942.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h8PUS6MbFJIZU38K"
Content-Disposition: inline
In-Reply-To: <DU0PR02MB9942C645E78AC23619F05D0CA0DA2@DU0PR02MB9942.eurprd02.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--h8PUS6MbFJIZU38K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-08 at 13:20:12, Adam Pickett wrote:
> Hello Everyone,
>=20
> I'm having an issue running 'git update-git-for-windows'
>=20
> I get the following error; curl: (35) Recv failure: Connection was reset.
>=20
> When speaking to my network team that have advised that they are seeing a=
nd error from Cloudflare.
>=20
> Error 1003 - Direct IP access not allowed
> A valid host header must be supplied to reach the desired website.
> 172.67.12.172
>=20
> Can anyone confirm if this is a general issue or limited to our network.

It sounds like you're writing about Git for Windows, which is maintained
separately at https://github.com/git-for-windows/git/.  You'd probably
want to report this there, since the utility you're describing isn't a
part of core Git.

I will just say that it sounds like you have some sort of corporate
proxy which is intercepting and tampering with the request, because I'm
pretty sure Git for Windows is using TLS for updates and therefore must
have provided a valid domain to curl.  If so, you'll want to try without
that proxy first, since if it _is_ the cause, obviously the Git for
Windows project won't be able to fix it.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--h8PUS6MbFJIZU38K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZoxgCwAKCRB8DEliiIei
gYuXAQCqcrvxyFAxTxRXlkZQOY6bmAeSoyM+XRAjDA3CPMfz7AEA3IeqxIoAyj+J
wmtBseiTzW1fEauXwsg44YeBni8KFQw=
=Layl
-----END PGP SIGNATURE-----

--h8PUS6MbFJIZU38K--

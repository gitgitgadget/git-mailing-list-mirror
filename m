Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A843ACB
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 02:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573753; cv=none; b=Brci/m6OK39XIj0u7wUABu6EO0/1FMWFYjakF+6UlIBEgYhBepXpmIt6vbz53Eu7xCBwDop0hSddc0L7cOEBK2w7mOvm+qhscXhYw76yNdchrsDpvxD68aW7QpZIQD8kYfs9HMWzyCLuOEMSUL6PlqvOzCTW314asMqi91h9D/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573753; c=relaxed/simple;
	bh=WXvgNW7pVak13O7AYAB+vXysBwJdR3D8sFKOcuPRlX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHZbobxAEUK3nhGmvcJIj9tFJ7YGsD1tKGFqSueorHiKk0Ewu+S0+tK7132G5y+XeZ7i00VfAJ+vF1LpE/FCg/10jRmFQPrykoWnOXU6N3e8XfCiN1aEwlgsCDQX2hx+AfJ0EjNE4xP8MzYmuRKjx9rzqxgkcpGkzMj5gwFlyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=r9sGTePf; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="r9sGTePf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1734573742;
	bh=WXvgNW7pVak13O7AYAB+vXysBwJdR3D8sFKOcuPRlX0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=r9sGTePfkD5gFOqHWkFIoV4OJww9jOSOuA1GBP7jSG9++Lv3rYgfwoWTe4xxxrIdx
	 S/1NjgFIqkFxKqJJME36pGGzNkQzgx5Xc5dZJfxfP1/E1OmXlSTFDFr2RnpqIPF8EK
	 fXQICvPP1ivLahcIavVg3wb2M8Zq3jFONdgsq9z6LvL6PZ7zi8b5qr15bmniilK/zS
	 ByJSkgR2J0A6ZdbAcxlCc8ajDbFX4LpCJU49LnVo01V886pLlEtrnaw8xaeqORBHXJ
	 5nTLCF9SAj1TgWj8rTwDwURDXkolIvaUILFcJgtAHu0b4WfLnezAFW1w2uEmVq3g1m
	 qm1M+zoqynRxfEATTetvbYamz2OEZUwalBt+Q9lQfLUrF3nlP6HZEKy/a+GM1aQJbI
	 n4Z0CgBnyvDcpxA8xH94yI1SC/HTJ1pi+BFtkvGYqgihkjneJhThyYD7DKMkpWlEeo
	 8BwIUUUb7DRgb2LDEKR4Ipx3GVsrdGp7M3u5eWexuMBu9vZqt7H
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C8DEA209B3;
	Thu, 19 Dec 2024 02:02:22 +0000 (UTC)
Date: Thu, 19 Dec 2024 02:02:21 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: M Hickford <mirth.hickford@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Fwd: [Bug] `credential fill` prints incomplete bearer credential
Message-ID: <Z2N-rV4fhF3ZkGlp@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	M Hickford <mirth.hickford@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
References: <CAGJzqs=ksKqY2M8Px3uv6ut=MBwkmpPUqp3xVzVpNMJ0YBrBww@mail.gmail.com>
 <CAGJzqsnAO_vDSYOC7ZbYUQHJ3fT10JuQ2RrC2cvY4hcPMnZ=bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KaJZZQjVbQvcm09e"
Content-Disposition: inline
In-Reply-To: <CAGJzqsnAO_vDSYOC7ZbYUQHJ3fT10JuQ2RrC2cvY4hcPMnZ=bg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--KaJZZQjVbQvcm09e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-12-18 at 20:42:31, M Hickford wrote:
> Hi. Is this a bug in git version 2.47.1? Or am I using it incorrectly?
>=20
> # erase existing example.com credentials
> printf "host=3Dexample.com\nprotocol=3Dhttps\n" | git -c credential.helpe=
r=3D -c credential.helper=3Dcache credential reject
> # store bearer token with expiry in far future in credential-cache
> printf "host=3Dexample.com\nprotocol=3Dhttps\nauthtype=3Dbearer\ncredenti=
al=3Dletmein\npassword_expiry_utc=3D2147483640\n"
> | git credential-cache store
> # try to retrieve credential
> printf "host=3Dexample.com\nprotocol=3Dhttps\n" | git -c credential.helpe=
r=3D -c credential.helper=3Dcache credential fill
>=20
> Expected output (complete credential):
>=20
> protocol=3Dhttps
> host=3Dexample.com
> authtype=3Dbearer
> credential=3Dletmein
> password_expiry_utc=3D2147483640
>=20
> Actual output (incomplete credential, no prompt for username or password):
>=20
> protocol=3Dhttps
> host=3Dexample.com
> password_expiry_utc=3D2147483640

This is expected.  Every request to a credential helper should include
all of the capabilities that the caller supports on input, and the
credential helper will always emit those on output.  `git credential`,
however, will only emit the capabilities that were actually supported,
so that general callers (including Git LFS) can determine the actual
set of supported capabilities.

In this case, you asked the cache helper for a credential, but didn't
tell it that you supported `authtype` and `credential`.  Therefore, the
only safe thing it can assume is that you are incapable of parsing and
understanding those fields, so it doesn't emit them.  This is a benefit
for security, because some tooling logs all fields but the `password`
field, and we don't want to include new secret fields that the caller is
going to shovel into a file or syslog.

In addition, the helper could actually store two different sets of
credentials, one which is a username and password, and one which is an
authtype and credential.  If you provided the capability, the latter
would be omitted, but otherwise the former would.  That can be helpful
if you have a stronger credential type but might occasionally need to
use older software (say, older versions of Git or Git LFS).

However, if you provide the proper capability, this works as you expect:

----
% printf "host=3Dexample.com\nprotocol=3Dhttps\n" | git -c credential.helpe=
r=3D -c credential.helper=3Dcache credential reject
% printf "capability[]=3Dauthtype\nhost=3Dexample.com\nprotocol=3Dhttps\nau=
thtype=3Dbearer\ncredential=3Dletmein\npassword_expiry_utc=3D2147483640\n" =
| git credential-cache store
% printf "capability[]=3Dauthtype\nhost=3Dexample.com\nprotocol=3Dhttps\n" =
| git -c credential.helper=3D -c credential.helper=3Dcache credential fill
capability[]=3Dauthtype
authtype=3Dbearer
credential=3Dletmein
protocol=3Dhttps
host=3Dexample.com
password_expiry_utc=3D2147483640
----

Note that `capability[]` directives should always start the request to
allow one-pass parsing.

Hopefully this is helpful.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--KaJZZQjVbQvcm09e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ2N+rAAKCRB8DEliiIei
gfqOAQCqgt+ChXOgsBypKU5AwJWlO7XOxJdMBmz9Dahd8TJmaQD+NB8ZJYY9ADJE
nEvVZJLLN8JAwt4G8suWJnyXRUJI0Qk=
=1y0I
-----END PGP SIGNATURE-----

--KaJZZQjVbQvcm09e--

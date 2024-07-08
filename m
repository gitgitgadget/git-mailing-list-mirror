Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A84418E
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720399955; cv=none; b=LjcDS2WhnE4W/1jcE1QMh7cF6C8PfIQMq9Hmf2nZH1+t1O9c00gLALZcF27vB8VuYvEUKEbMuAKualK0p73GiQRNdowwrVvorkPpqkipDC1MUi/GfX0S6JqQ9f8V6/wY5jR7CLaQFtbFh+YBdZ0LxRxCUiTLKMyHHDS0vVo++pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720399955; c=relaxed/simple;
	bh=5ARerIMS3rDYZeueMzxnIT91oeGHvBT4ZMnVxyvXAow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u02py1FJ5Z1E2p4j99n5NtqZgL1AOk7lMxxP0kGVipubJjQWy3a6ah1dlK4St0JNyWEHb4PNUY0bK4FewugLZfNtyp19GWDXtRX5OLWWYh+hK0YJs5+W72PO7PlhF/qIDxwHhf6MrHeNb5OQqZt0ubMO5REKx8qFyIWXVOUmu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=04X57STa; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="04X57STa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720399950;
	bh=5ARerIMS3rDYZeueMzxnIT91oeGHvBT4ZMnVxyvXAow=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=04X57STaYMYGrmVUJCtf98lO3aDN/DqOhTVRk1KHsp2SjD3nzlFWiL58Vwjzv8MVM
	 mUe5fWLHTWvj8WKx/nNqzW1LwuklNoBCTj2JckNpYjI0rU6LH51yFbKvBdtb8JFiaY
	 RQyZOzbzecEyKAqoQJ9YIJq0rKpOqDmg9URbRptYF4R/7la++Pcw5+WHSuCNBpSVUj
	 /iN4D5sogFm8geoiusOcgAS0E/VJCfj/GoOagxvXIpYNX1rdVpzrX7WhIx65WMXOqu
	 5mswneIbAI4alwDVR7itxpC5xGQNGfUKnNcHs2qEqE1pgZweXXZH72ZFjZ2sbPVJhW
	 bpN+ryR9mpk+rHx6U84dmaJJDZeho9tmPpjJVCR5lWbukjLvn38umgLO8lHwOgM64f
	 hiaPScfrsbn2WqJdR2i+mQCQLYaR+Rdnn4yi45Vv3vQ1w69CExj/Pv9P3QmYfdciaL
	 rZZE2YJ6e/VRSvqap56Qsg1Sx+wy6Do3DqBY7Q/3gjMx8sds/m9
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E32FF20991;
	Mon,  8 Jul 2024 00:52:30 +0000 (UTC)
Date: Mon, 8 Jul 2024 00:52:29 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Additional FAQ entries
Message-ID: <Zos4Ta6ddzoBuX-1@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
 <xmqqzfqx7muk.fsf@gitster.g>
 <ZocS0NgiAbg5Mnzp@tapette.crustytoothpaste.net>
 <xmqqo77b3vs2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GuSMLZGlq5WAdBDk"
Content-Disposition: inline
In-Reply-To: <xmqqo77b3vs2.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--GuSMLZGlq5WAdBDk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-06 at 05:59:57, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> >> Buffering the entire thing will break because ...?  Deadlock?  Or is
> >> there anything more subtle going on?
> >
> > When we use the smart HTTP protocol, the server sends keep-alive and
> > status messages as one of the data streams, which is important because
> > (a) the user is usually impatient and wants to know what's going on and
> > (b) it may take a long time to pack the data, especially for large
> > repositories, and sending no data may result in the connection being
> > dropped or the client being served a 500 by an intermediate layer.  We
> > know this does happen and I've seen reports of it.
>=20
> And this is an example of "a proxy that buffers the data, without
> modifying or tampering with, would still break transport"?

Yes.  The connection usually ends up dropped from the view of the
client, which is hard to debug (because it also looks like a network
problem, except often without any output from the remote side).
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--GuSMLZGlq5WAdBDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZos4TAAKCRB8DEliiIei
gUDKAQDxPuQCFgwiDUtDqFDszzBLvIdNjR80H+G6mDFBYyNZEQEA+WZMy4IPQj9K
tQES5TyW5nG65ZGYpjsKALWea/yWgQo=
=pegt
-----END PGP SIGNATURE-----

--GuSMLZGlq5WAdBDk--

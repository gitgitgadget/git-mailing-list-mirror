Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C5A6E614
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215610; cv=none; b=YHHBfqCvwqtrmNMsbFxmbIIBqf5T7/hUhm8RiTRKSuj4FKRHyuC0c0f5nPRoi/lGsmLBqVAH16E5Tgyfq/UbI4g5ZgND8jzf8vG3TwHj5MsIYFT+uIGxtMO/FJT5nChkoIqzodg4MUA+PaxVkF4HYVnOJPB0b/lQJb0xM/a4U/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215610; c=relaxed/simple;
	bh=pjncdKmpIHLkkDidezwgIBtdM/omiv80I0pXetLWTHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiwo6lsFy/l/fGKVF9FvDBOPn23k/Zu2JQRKKScReaqpaKPCDDZbKn+7BiQuhCB1qV/0oTrSkRBXsi4ACRoZhbghs+lPr6sik9H/BIqpil/ZcASWBJSVFIzKlxQo9gy/u0yMbt6O6sxrpXs7pQKMpyWzA1SiKIn+ZbzpxLYeWO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=yAeSJHDt; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yAeSJHDt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727215606;
	bh=pjncdKmpIHLkkDidezwgIBtdM/omiv80I0pXetLWTHI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=yAeSJHDtWVrjuPhX0TGQxHsrlG6rNAewy/qhIpHVXABPfcwXUuPR9FtxpE4SwpT3W
	 pZbDEHdI/juTqKbVJKYlDmbs3dVVXPlLmNLOgmWCBk+Gu9r4pbV4MwvGFaQ0lHQMf5
	 ETJlQgN80qmPI8+DQD5sv6J54TEH4KcPK+thlh7s5AEGIbY13/+DRpDi8I7aMMyfab
	 SFbagpMe7rJ1bLS1FRwBkFks8ABaOA79ZTbgoxpUDQ0/xckqyH4Kgu6IOfCQLhcLqh
	 O1/iqL/JIhV4PjQ2ttvEPqRpywg87qaULHKI5lmwgAgSwnuoXYg7yU9F+v5UCuoEiW
	 k1gJT8YNxpwBcBq9oJGi5fabWKMJtANEtHe5UERAW9vkA2avHos1InUeDS8YQ4imnX
	 ZnmMHt/RKagN9nGmti5txMt7SDQdFdGzHWKolfT5wQlIJ89dhMAbOsd3B6eTXC1uON
	 64ZvETn4g5np3aTUxxxVpLFfnCgpfochehRS6a8lPiVvsRR7gUg
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C9D1F20073;
	Tue, 24 Sep 2024 22:06:46 +0000 (UTC)
Date: Tue, 24 Sep 2024 22:06:45 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ron Ziroby Romero <ziroby@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Pretty output in JSON format
Message-ID: <ZvM39VNFptcfwMGk@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ron Ziroby Romero <ziroby@gmail.com>, git@vger.kernel.org
References: <CAGW8g7=21pPAgCixjpayEvmw_ns-hcB4e59NP476TKtCRXHPXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zu7okv6BRP62a+Pp"
Content-Disposition: inline
In-Reply-To: <CAGW8g7=21pPAgCixjpayEvmw_ns-hcB4e59NP476TKtCRXHPXQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--zu7okv6BRP62a+Pp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-24 at 21:52:35, Ron Ziroby Romero wrote:
> Howdy git folk,
>=20
> I want to revive the discussion on JSON output. I see a discussion in
> 2021 about it, but it didnt come to a resolution. That discussion was
> talking about adding a --json flag. I have a slightly different
> approach.
>=20
> I see online that many people have tried to make various hacks to
> convert git output into JSON, but they all lack completeness,
> especially with log messages with arbitrary text. I believe the best
> and most correct way to get JSON output from git is to add it as a new
> format to the pretty option. Then, it would be easy to pipe the output
> into something like jq to parse the JSON.  Trying to convert git's
> output into JSON is a losing proposition. You've already lost some of
> the context of the output by getting it out of the git program itself.
> A pretty option would provide a standard way to get correct JSON
> output, with git's code handling the weird corner cases.
>=20
> What do y'all think?

I think this is ultimately a bad idea.  JSON requires that the output be
UTF-8, but Git processes a large amount of data, including file names,
ref names, commit messages, author and committer identities, diff
output, and other file contents, that are not restricted to UTF-8.  In
fact, despite my recommendation, the trace2 JSON output simply outputs
invalid UTF-8, which just doesn't work in nearly any tool, if it
encounters such data.  We shouldn't add more broken-by-default
functionality.

However, if you were interested in CBOR output, which isn't
human-readable but is capable of handling byte strings, then I don't see
a problem.  CBOR is used in FIDO2 and a variety of other protocols and
is interoperable, so it should be a fine choice here.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--zu7okv6BRP62a+Pp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZvM39AAKCRB8DEliiIei
geneAQCf9x3mqBHtDQYyymrlMtigGjGdK1G65xjP/y54oDkwqQEA222JNyUkibXE
ap5Tbn/kBFVjwM6/B6QCJLw2DpTvyAw=
=BkC8
-----END PGP SIGNATURE-----

--zu7okv6BRP62a+Pp--

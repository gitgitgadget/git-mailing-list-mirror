Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61444C9E
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720128214; cv=none; b=UZgma6I6Qfg2+s+EclJaxTDsok/QDjd2D/B5x1XMsPBlPuK9pQgzZjs777TFgfrdFTlxofNKI9NWUSke6D/NLH6sTsO3XcoSlE1XMI5lrY1m+ADfPKwaYi1Otf+SYSiU46HG5vrh64HXUVO9Ee9i/dxnphvzAcZ8bA/gd8fCWVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720128214; c=relaxed/simple;
	bh=Dz8TXF6zvYtbGc8BZIlcpYQ6o0k8x5J2TLe/kxQfSx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuK4rGeX8isLr8yIx2cQmDmrDRZmqCkhla1xJVcIx+Ipm/2sYSHTBpxoLRawZan6+FgOs7Bmn3bo+OoLE5WSJfiugiok2mYGoi3RLblPpsNqH0SV7CqpTw0rhSeKZBA7Kb1NOqMSNtzicRVmjqUFVHpfaRDWjJfR7VNmB/h9A/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uT2+SrJ2; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uT2+SrJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720128209;
	bh=Dz8TXF6zvYtbGc8BZIlcpYQ6o0k8x5J2TLe/kxQfSx4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uT2+SrJ2KF0HztZNhB1WDQUQFPIXCwNmwIt4GUmfA6zaFoN/JE8OTjfhrVFEPsXir
	 2TwTX977TMphdpymdDNCX7JIke0H7gVKmqlyCtLRd2q1AqD10OePydMEX/7dhyJOW9
	 E81HwBKMfMj/hdFKvgIFQ6ZUkArD6JyxskoW8b4f5JWqLg8mOjJYqdR6DYWGFvd3+8
	 OkYnWJM6gcll0W6JdUZypX+em2gVaTjC6iRgLBk2uWMFUwzXpvNl4E1YqiWYnZbRVS
	 A0h+JYGrNPncyqHbegvK6T78zqsVghKxOt0lxnPrgND/yAq6NvvqEeJLHelIefh5El
	 XdMevxmZy2iANZh1FfSkJH+trkhYCOgrIPn1NLNdtfDMgMV7ga4RXzPYoy2viNFT+7
	 nE0hLgYBkvACEiks/suLc7JnGc/XHCdTCYuSxX/FjSze33L3sYfN4qKcUPfz12P0tF
	 qT0EH+8BmpNkrivoOa4GEtL7YVNxalUIrahItJSxPOxrQ8TkUy/
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7938720992;
	Thu,  4 Jul 2024 21:23:29 +0000 (UTC)
Date: Thu, 4 Jul 2024 21:23:28 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Additional FAQ entries
Message-ID: <ZocS0NgiAbg5Mnzp@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
 <xmqqzfqx7muk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z+HzzQhFVBYIirUI"
Content-Disposition: inline
In-Reply-To: <xmqqzfqx7muk.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--Z+HzzQhFVBYIirUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-04 at 05:22:27, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > This series introduces some additional Git FAQ entries on various
> > topics.  They are all things I've seen in my professional life or on
> > Stack Overflow, so I've written documentation.
> >
> > There were some suggestions in the past that the text "modify, tamper
> > with, or buffer" might be somewhat redundant, but I've chosen to keep
> > the text as it is to avoid arguments like, "Well, buffering the entire
> > request or response isn't really modifying it, so Git should just work
> > in that situation," when we already know that doesn't work.
>=20
> Buffering the entire thing will break because ...?  Deadlock?  Or is
> there anything more subtle going on?

When we use the smart HTTP protocol, the server sends keep-alive and
status messages as one of the data streams, which is important because
(a) the user is usually impatient and wants to know what's going on and
(b) it may take a long time to pack the data, especially for large
repositories, and sending no data may result in the connection being
dropped or the client being served a 500 by an intermediate layer.  We
know this does happen and I've seen reports of it.

We've also seen some cases where proxies refuse to accept
Transfer-Encoding: chunked (let's party like it's 1999) and send a 411
back since there's no Content-Length header.  That's presumably because
they want to scan the contents for "bad" data all in one chunk, but Git
has to stream the contents unless the data fits in the buffer size.
(This is the one case where http.postBuffer actually makes a
difference.)  I very much doubt that the appliance actually wants to get
a 2 GiB payload to scan, since it probably doesn't have tons of memory
in the first place, but that is what it's asking for.

> Are we affected by any frame boundary (do we even notice?) that
> happens at layer lower than our own pkt-line layer at all (i.e. we
> sent two chunks and we fail to work on them correctly if the network
> collapses them into one chunk, without changing a single byte, just
> changing the number of read() system calls that reads them?)?

No, that's not a problem.  We read four bytes for the pkt-line header,
and then we read the entire body based on that length until we get all
of it.  This is also the way OpenSSL works for TLS packets and is known
to work well.  If the underlying TCP connection provides a partial or
incomplete packet (which can happen due to MTU), we'll just block until
the rest comes in, which is fine.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Z+HzzQhFVBYIirUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZocSzwAKCRB8DEliiIei
gZeXAQCHp80EHtjjylk5OUf5G2PllYCDwdQB8VqgikWaqfEyJwEA/joyAe3KECLe
ZungrGO2MRNCknnT22aNb+M7V8JJ3Qo=
=zSVK
-----END PGP SIGNATURE-----

--Z+HzzQhFVBYIirUI--

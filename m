Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0956972634
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759187184; cv=none; b=KqyRtYZBlGo+NLWIYEuJYEmeAYgdaEsfr8EIIfJVR4v4t/vfg9f79HmVQ4MB3+xuOO0NptJpaLQ2vlpwtohre19/HiBgbhx9kBAeJTeGCzinAWmms8X8Y3eIox+f66vpS65HoIQRTnMEftkHszKPQYBJZKejdfUbeeoDGU+HhCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759187184; c=relaxed/simple;
	bh=LxsINIS1hIsc9U3LeIC6Zgzn+nPiCdLrNFYEv0zVj0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJK3QwUtoy5dB+P9bRX5eiYciQTRSEFnCHBe6XOej2kRJVKp3XX/X73BAtJkmTpgdG50wSvkGNRWjpKWrGKLJ2jKi9/O1qBwJnspr4WELtl59qRNfdFL/OEdODtTX8eRbgz21T5KgzXUGmtd0eYhgXH6BmEvRvYe2jOfaFiWwyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=OIlJSS6N; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OIlJSS6N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759187174;
	bh=LxsINIS1hIsc9U3LeIC6Zgzn+nPiCdLrNFYEv0zVj0E=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=OIlJSS6NO8CvafeI24LgUzzYZgRXmcnjigEdlm9Jn+H+w6f0xjhQB+neb1aAIAgNU
	 ea92qFHtQ81cM0iHwdi5hJTIaMqqUhRnEeJitvN/zgvJipf99HpcfJ8lqbHITknEgs
	 ziELjPm+ohlO46TA4crGgtJZ2Q7aUfNrwqeRWsxcyraJgkwUgS8ASkD/s6D/UUAXhE
	 ZG6ZzeX1GcoVhqnO65Q/zeHlxeixFgoYa39kAkZgdm/Rd4eMkt3P4iK4eIoYe0MMII
	 P6G//ACfb/u9iG1x+B022Vq2/AN9DO5El8DD3ufEWAjk8/g+nFXf04bsYQcYNN1wre
	 MDsd0ihBHvASfWbvElIJU3OQjbVCYgi1KY5AkmmHaxNEP8OlHAMc4nRRo8FX9WsvkA
	 RDJ/tPpWahTLYjj68HBVWjUZaBcZWW8OBOdSNO7QLdoMUcirUj3HPKgOlrs7+Wnkpg
	 VteQ3SecM0CEFqypCIz5XSKmLBp3yzPV6rtKv65yVFcnVIHtLyS
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:8e7a:7b63:26a7:22e4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4CEAB20113;
	Mon, 29 Sep 2025 23:06:14 +0000 (UTC)
Date: Mon, 29 Sep 2025 23:06:13 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #11; Mon, 29)
Message-ID: <aNsQ5UjjbqJr8_Ik@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqv7l06gwi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hAfpY5VOHyoqCFZ4"
Content-Disposition: inline
In-Reply-To: <xmqqv7l06gwi.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--hAfpY5VOHyoqCFZ4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-29 at 22:19:25, Junio C Hamano wrote:
> * ps/rust-balloon (2025-09-24) 9 commits
>  - ci: enable Rust for breaking-changes jobs
>  - ci: convert "pedantic" job into full build with breaking changes
>  - BreakingChanges: announce Rust becoming mandatory
>  - varint: reimplement as test balloon for Rust
>  - varint: use explicit width for integers
>  - help: report on whether or not Rust is enabled
>  - Makefile: introduce infrastructure to build internal Rust library
>  - Makefile: reorder sources after includes
>  - meson: add infrastructure to build internal Rust library
>=20
>  Dip our toes a bit to (optionally) use Rust implemented helper
>  called from our C code.
>=20
>  Comments?

This looks fine to me and addressed all of my previous feedback.  The
cover letter incorrectly says that it's only wiring up Meson (which is
no longer true), but we're not including that in the series, so we don't
need to fix it.

I confirmed that my branch using Rust builds fine on top of that version
as well.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--hAfpY5VOHyoqCFZ4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaNsQ5QAKCRB8DEliiIei
gR9TAQDnmsdzR/K76Ir+aBkCpTJOqUlm3ttXvYHBi7VZx9PXDgEA+Kzc5qLI9DZR
hMEDEEP+WdujvleLk6/v8K75yhpoQAA=
=BLQK
-----END PGP SIGNATURE-----

--hAfpY5VOHyoqCFZ4--

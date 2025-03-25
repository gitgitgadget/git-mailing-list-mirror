Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A6D268FF4
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742939804; cv=none; b=mCnY1mBfJ5KnSCawf/GwRwALuNY9JsJshuPutNrm6u8BxULr47CsQNaW5Z+lC6V9m667pYXbn+9WnxNXDAXk39Yg2GQ4GrQmjzC2+FRh8VCT2Qp6K1MxvRcu/ncf5rAqcZzs2imELW+vAiNJyW9gfoYsObwYrp2Xmgpo6u6Oh30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742939804; c=relaxed/simple;
	bh=gMRNiXgArobaR+Pl7LiNU9f2g+pOz950YKWidDc23lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L18wykdVuPFRPgqwAQMiAA9YskRiwN3pLOg6OS1NMVH2SxmCYRoDd8YXqMlMswGGpNu30SuAEBHVCqDHdy7BCK1S4xw34lvOhY1Yb1dbxhvFYncIUVNfqvqzMvPNE9feUHzxGOQwwA6LghSZQbpxZJ1CVdYohMTgS90HFoaFzTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=0RpvT3Ox; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0RpvT3Ox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1742939799;
	bh=gMRNiXgArobaR+Pl7LiNU9f2g+pOz950YKWidDc23lg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=0RpvT3OxwdEpZCivXT4QOUjd6peLq/mgIO8Hm84KU8tlHSG3nCxKjYDNIiU7h8ldK
	 FL1WBB5ba3/WS9Lua/RC1N1PSTK5h9G1XkCPTkGCM+5TCYFicSbDO/dRZlIN0wP2dS
	 Tf47kmsz58G4rsJI1viSm8IC7xf9KxGkY7Pg/kbiOgLuqmhuOR3X+YJgauI8hy4I8X
	 JdFQdopZdATieA2i2JvFRHwdq+zL94/Y1bOAU9/0Zv6ZbxRRlTPKakx4qpUFZ3etrc
	 ox+oyER+2QjjOWQnMw9EOpWOlc0V2l0gVihpAnuGpSqpr47XhXTJAoE8YLbSHOKMUE
	 UbgsWSudozxnFEZrhMMqACWKhM+iU4VOUOtDyBqeffdZnlxBqV5Ki/vSU3wAYQ7wK4
	 Ig4QGpCoxWnxhW7y4GyK1ZZ3YU+lviK5h+edeso3kGpevxxYvNarXFswmCQTdKg6Ue
	 eou/6AlPAOhFyOhc1139GScw4b3ksSWtQX0fG+qts/zJRhJprBm
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C37AC200C0;
	Tue, 25 Mar 2025 21:56:39 +0000 (UTC)
Date: Tue, 25 Mar 2025 21:56:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git Merge 2025, September 29-30, San Francisco, CA
Message-ID: <Z-Mmlr6kzozqZpkk@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <Z+L3Mt58n18KUNzs@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="80jJ6FKZUqJFt435"
Content-Disposition: inline
In-Reply-To: <Z+L3Mt58n18KUNzs@nand.local>
User-Agent: Mutt/2.2.13 (2024-03-09)


--80jJ6FKZUqJFt435
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-25 at 18:34:26, Taylor Blau wrote:
> Git Merge 2025 is happening on September 29-30th in San Francisco, CA!
> The Contributor's Summit will be on the 30th. Here are the details for
> the main conference:
>=20
>    When: September 29th and 30th
>   Where: GitHub HQ, 88 Colin P Kelly Jr. St., San Francisco, CA 94107
>    What: Main conference on the 29th, breakouts and Contributor's Summit
>          on the 30th.
>=20
> See you there!

Unfortunately, I'm afraid I won't be able to attend.  Given the current
political situation in the United States, the fact that I am openly
queer and outspoken about human rights, and the fact that I'd have to
pass through customs, I don't think that it would be a good idea to
travel to San Francisco.

I've heard similar concerns from some colleagues as well, although I
can't say whether they'll ultimately be able to come.

I realize there are some considerations that led to the choice of venue,
which is understandable, but it does seem regrettable that another
alternative wasn't viable.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--80jJ6FKZUqJFt435
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ+MmlgAKCRB8DEliiIei
gcJuAQCSwLRLZdNctx4Qb7Q7mIJcTyZ2AoUuNVvcBcwdZd3lMwD/cWMWC6nNd81g
ngt1NLexxy/2zi5vK2NSK473hBYFwAA=
=O3hq
-----END PGP SIGNATURE-----

--80jJ6FKZUqJFt435--

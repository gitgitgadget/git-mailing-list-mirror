Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B2244671
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 22:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759874832; cv=none; b=rjY3koK0LKzAX2PmI7MuU+yaSDsbWie0NGbEMKfCqPJJ1NZwax1SjE3AKyv10qywvJ8YCHYwxwsDAJk7sAYRj8qcoT9Wm4TsjjBUvcVwhqZqBtY5qKF7+cRbSZwFeT2870f0BwzXDSTmYX8rw6Hh+T3YfUjeDF9qiT+Ot4C0lsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759874832; c=relaxed/simple;
	bh=R40wMZm2p+nhIwAXyICSoTIPKjuwvzfrF6G7Afrvrq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubzhuWYZS+dlMwQH3AHATQwRSjj+3HQFRojtmShcPEqldzsV+QHJca76UMbKrTZk10AyMtAaSua+t5NOTabzByiJtA/DAKDj7F6sQ50eI7EezgfcMVXflSPGId8XPXG/DrEcRVDHOpoKSj0hcv/C/PAZkjncsnqLLfX/75xoBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=LaExbL5B; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LaExbL5B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759874822;
	bh=R40wMZm2p+nhIwAXyICSoTIPKjuwvzfrF6G7Afrvrq4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=LaExbL5BxNjgBJwUC1H2QytysOgGkljkESzv8AIWpGhTJQwNTJz2MTEi8w0fpryMF
	 9TeewSBTPXmCcRxZCZilBjNzfjIZYSZ2cXoM8yeDSEDVNw4jgye9iL7vkVQvrT3Fjq
	 LggAX09VjJ5pSBGN5j0Fg18jm6w8RNgY/0/KQg4WWKRW+3+oHYWFAY8MI8Pqqb+z0b
	 JPWOSlhX+32kEFdhbb//oVpjzUX7fS1XAWHbNaBfHtXe6rPw3/u7pEB4asqT8xfRhP
	 tFr3SF+WDPjiYgOCAQB5AJHocv+YJzTu+toleaHEnQkAJLY8r7iJfx2ehxvPblPEsV
	 iGJKITtui+B8ZB3r/dCxL7WAoR5pyUI0+OEjgoOFWVv1Fb+Yh+tokoydZY/PfVwf40
	 Tcw3ffuUf9E08mAWuYlZ7IT0F9L+I5uaPtblg9Pdq0qahetdEgWN4JVJHgeflsWFHj
	 1MgGtR/b9+iejWDBUGEdRvz2M80suSG1f4dnd2UxgNH/cVbtB2r
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:225c:7da:a6d4:350c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B8B54200C6;
	Tue,  7 Oct 2025 22:07:02 +0000 (UTC)
Date: Tue, 7 Oct 2025 22:07:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] ci: check formatting of our Rust code
Message-ID: <aOWPBZg5MXzGcNmU@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
 <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="elc+gQ9sMWR/fw4+"
Content-Disposition: inline
In-Reply-To: <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--elc+gQ9sMWR/fw4+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-07 at 12:36:30, Patrick Steinhardt wrote:
> Introduce a CI check that verifies that our Rust code is well-formatted.
> This check uses rustfmt(1), which is the de-facto standard in the Rust
> world.
>=20
> The rustfmt(1) tool allows to tweak the final format in theory. In
> practice though, the Rust ecosystem has aligned on style "editions".
> These editions only exist to ensure that any potential changes to the
> style don't cause reformats to existing code bases. Other than that,
> most Rust projects out there accept this default style of a specific
> edition.
>=20
> Let's do the same and use that default style. It may not be anyone's
> favorite, but it is consistent and by making it part of our CI we also
> enforce it right from the start.

Yes, I think this is the right decision.  We _can_ customize it if we
want, but I never do, even though I don't love some of the policies
(like the cuddled elses), since having a fixed standard avoids all of
the argument.  The Rust code I'll be sending in within the next few
weeks already uses rustfmt.

Even if we did decide to customize it, I think there's enormous value in
just being able to run the tool and accept what it outputs, saving us
enormous amounts of time not having to discuss style nits.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--elc+gQ9sMWR/fw4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaOWPBAAKCRB8DEliiIei
gVdpAQDMu8+QazjQ+O3LjUqjSHDOg5r3LEfBC+yP3EWDzS9MnAEAoK1DRZOf2nyr
MSkDoz1s4tx99RvwarqStAnMXzdOfgc=
=PFly
-----END PGP SIGNATURE-----

--elc+gQ9sMWR/fw4+--

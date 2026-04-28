Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E83E958E
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777371930; cv=none; b=NizCoxKYQ3cHY2omax1J4afkEaq7oeaG50Ji5HGjV6ff6K+sE7lpRspwLqhuyamG+ayeRKjSbu5dTXUT1C+kiY/jMYueD5b7uNSxgG2ppfm8PSYKV2ud6FsgPxsr9jwz/7KAQRKCsdrYocZsBXuz+86t92O2c47wcfqxOyqulnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777371930; c=relaxed/simple;
	bh=MLTenAI4K4g2rUwWXezZf37O5ku3Lx1cntOLBYgPICU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAkRb2a0wJbM2I8lnsnRO8gRN8v3D0K3YM2yQEWWBcqBDSnH1nys9GFBRcz2oXFq/o7ZlKjBj3m2VqFFdfkQgHMp+Y8pzU5AWZ9TW8RjB7ioCWY+g8Yni9UukwDN2/mV/8GlP2EinZOWEbnAzbQDXZXHULskqBAukFqAMz08tQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=b4ys7upS; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="b4ys7upS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1777371925;
	bh=MLTenAI4K4g2rUwWXezZf37O5ku3Lx1cntOLBYgPICU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=b4ys7upSMci3+pmAqzMl8WbYWs1+ExRyR5I8USS3k5PCtEWX/j7FQjQWzQ6BFPZa4
	 Pr0jro79I2CeOFzMu0o+3RjSbBVz153dj52Yjd+pMlhXOlpwqQRDHW99n+NC/smhyC
	 2CcEZcAjh67Zq5DfJ695tuIpoSWTNc8asOeosg5tOAZSse8QDLkw7k0wG2iQZCkMer
	 HL1BkbkuySsE8igdDBV1AEANfCoyIWHeqQsLQV0heUgIdDrzTFYkjhZsI2ZeqY9Pe9
	 GTFckw8bSuDWLU2M2FX1rln64+b4m9JAsaj+6l2Y3qcZHR9wmLG8tjE+BXbDcsxYOw
	 rFrglS3y+u/rX7qKiwp2IgXDPz01Zwe+BPWIYR5vaQsqmfkyHqjczAMdwROjqHIIMf
	 JqaDT0U/UJoTqoXw+7VwxCkBjILRmbg3FdUV9u7gvxa8c4fUGJ4Wg6PcLx93Uk3XUP
	 VRIDXoNtMN6yOKth0ON6JnGYSp+BZg9Z9/Z7XwPonUYz3T/SE2u
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:83ef:6e6f:372d:4e85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CAB78200C5;
	Tue, 28 Apr 2026 10:25:25 +0000 (UTC)
Date: Tue, 28 Apr 2026 10:25:24 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: git <git@vger.kernel.org>,
	Ian Jackson <ijackson@chiark.greenend.org.uk>
Subject: Re: Git generated tarballs and Debian
Message-ID: <afCLFJX86yEPKKfk@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Simon Richter <Simon.Richter@hogyros.de>, git <git@vger.kernel.org>,
	Ian Jackson <ijackson@chiark.greenend.org.uk>
References: <9030b26d-02ed-4452-b212-a69a4ff21e2d@hogyros.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I8qNVwLQOIdkMyqL"
Content-Disposition: inline
In-Reply-To: <9030b26d-02ed-4452-b212-a69a4ff21e2d@hogyros.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--I8qNVwLQOIdkMyqL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-04-28 at 08:40:05, Simon Richter wrote:
> Hi,
>=20
> in Debian, we're shipping "original" tarballs for each software package, =
and
> the Debian specific changes in a separate file.
>=20
> Historically, this users could do a bitwise comparison of the original
> tarball and the one in Debian to verify that these were unchanged.
>=20
> With git, some authors have stopped releasing official tarballs, so we're
> using git-archive a lot -- but this is reproducible only by accident. Git=
Hub
> also prepares some release tarballs that may or not be bitwise identical =
to
> what git archive produces.

I'll just note that we don't make any guarantees that `git archive`
produces identical output across versions.  Incorrectly making that
assumption broke kernel.org when we changed the format in the past.

Also, if you use `export-subst`, then it's possible to emit short object
IDs, which can differ in length depending on how many objects are in the
repository.  It's also possible to use zlib or pigz instead of gzip to
produce tarballs, in which case the compressed data will also differ.

I had intended to create and emit a standard, reproducible format for
`git archive`, but never got around to finishing that.  Perhaps I'll try
to pick it up at some point; I expect it will be easier to implement now
that we have Rust support in the tree.

When I was one of the maintainer of Git LFS, we intentionally produced
source tarballs specifically to emit bit-for-bit identical artifacts.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--I8qNVwLQOIdkMyqL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmnwixMJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZw+aJwYzGqbJNPZwJ6jnYvp5axio7noUUxgK9nKCjPcT
FiEECCzmip28ZfuD0cORfAxJYoiHooEAABPXAP42vzpA7jzxN/MJAZtcg0VDb8bV
UX5mfkF/wo26kDlQEgEA4DS5zkp7g71uOB/MjIlqiFPUVConROHA/TOyd1xVvAA=
=DK48
-----END PGP SIGNATURE-----

--I8qNVwLQOIdkMyqL--

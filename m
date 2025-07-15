Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1555826AD9
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752616096; cv=none; b=DFZvKWKU6EPPADthuQSpzPHsYyUvHVF/qwTR9NBkgpUVAlNoIBccZA3pNzZyUbev22GAeADuuCJuUWAGbQfVNgksbugFc/bNXlJITX9Be0VI4v+nYFFnRDiHKqzt8pGGxfAl1xs4hsSIQoslXKoO+gLxVuL/X8HlKPdRJZlatfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752616096; c=relaxed/simple;
	bh=Vb68sUsAb3/Nezc9BflG1C+5QZ6rL52mfV1kT6uc/kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEgRvk5C8sCa5mOdRqZHL38V75XhgLsp2PsEGhIOpEsTOru1Aq2rRANivSlKpCVpkEsiP5bOaeC/d7o3Fng0p0wostl4squcdFiwLmTUbXLjYrlq2G4BNA2pPYoWZ7wF5uoea/1DKE/ZDCe5Ch3Z8IgYRINTy34SFP4cl5JIwOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MGRWn7rj; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MGRWn7rj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752616087;
	bh=Vb68sUsAb3/Nezc9BflG1C+5QZ6rL52mfV1kT6uc/kU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=MGRWn7rjsBD1l40Sr1iynHrPv0QfFKQWG7a3JkjGJWi0+zcy/EzHcPHyB6yw0LGgW
	 ze1eO0hLTRLZrH+3cSSIB6Py5Di6MpVQEXzOh7YlOHNZ3vKJQ0hAgdyqPVkq2KYPGX
	 Uqp1gtS7LsaYrHuj40pPZmFndJ6rqcElJYHTc7Uv6WD4DXByT+z+gZqyKH590/3/iA
	 KeQC7ylZXCqYorczQDlCCIx5Ranyi+nzmJNj2dOEWdnLmOd/XjyR+o5Sq5b0A4FD0Z
	 DTMt60NkIAVAIAH12LrFtcjwhTFHPfl/syioqvdESqbXwcl+rSu6En/bDHq+SOBNHn
	 FejIvlQyMWwAmLKhl3y6dgHRAth+Ie3/0T0QRmvZ8gWDCcW9GODeOLguL3h9xcsSrt
	 i3FPCvH3j0J1LDuFGc+r8RXAYeLAeQFCwuR4aalfqEytz3gg62zFoVOxvAArmIDg4i
	 jvX2wxw+0JbVGJ9TCHYpV0X6MyqZAzgWXOTcT/ABGqMGHRm7Vub
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ef36:e137:e56a:1fad])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3D8552006F;
	Tue, 15 Jul 2025 21:48:07 +0000 (UTC)
Date: Tue, 15 Jul 2025 21:48:05 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] C99: declare bool experiment a success
Message-ID: <aHbMlUKNL2CAK_9I@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
 <cover.1752587571.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jIT01QYm6wvp6vaR"
Content-Disposition: inline
In-Reply-To: <cover.1752587571.git.phillip.wood@dunelm.org.uk>
User-Agent: Mutt/2.2.13 (2024-03-09)


--jIT01QYm6wvp6vaR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-15 at 13:52:49, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>=20
> We've had a test balloon for C99's bool type since 8277dbe987
> (git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool,
> 2023-12-16). As it has been over 18 months since this was added and
> there have been no complaints let's declare it a success and convert
> the return type our other string predicates to match.
>=20
> Thank you to everyone who commented on V1, the only change here is
> to fix the typos in the commit message for patch 2.

This series looked good to me.  I especially like the fact that we've
made it easier for me to figure out whether starts_with and friends are
booleans (that is, true if it starts with the value) or our standard
zero/negative-one (that is, false if it starts with the value).
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--jIT01QYm6wvp6vaR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaHbMlQAKCRB8DEliiIei
gR79AP9MirrblivcD1pV8DpU8iBrTVBJj7/J6iqdsqig7P+haAD/QL1joPvAzaWO
sxNVQg99pAaWrrWM17j9dwgeqoclegs=
=JyB3
-----END PGP SIGNATURE-----

--jIT01QYm6wvp6vaR--

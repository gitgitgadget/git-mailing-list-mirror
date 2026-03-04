Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F57F1A275
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583230; cv=none; b=HbXbEOVXs+vKs93qf7bGO6ovR0+02nnuRQTphlwdx+J7OmpcTmtvMyUgcPzR4Z78nh8ZqxKbF+p65E/0pO7+bbmTJrUjyLJkrV769rzLqhnuyl1jaxRedyHFl6IEcY6hna6bnZ6/jX1iv4ROdnvYpIYnypapJrc2oMHnvucoBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583230; c=relaxed/simple;
	bh=2ALqv19s1FtX1bm+SePyYwp+VQh3K4ivNvpVJU3iSkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHd848P0j4IFMLFBSCMJYBMVbWRTSIFppR5Vp6WCpK6mXDo47JjhfuknwCuCE3wyMOz/qi6mECVkLAAHd0k/RycDrPp9piJtsdJcwo3l8kic97NyaaQkTKUsEjs3eGvNlAGMgF5ad5x6jdafFUuV7HU/JPsxfie0uSEAgRVwn/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=M6UYPBkw; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="M6UYPBkw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1772583217;
	bh=2ALqv19s1FtX1bm+SePyYwp+VQh3K4ivNvpVJU3iSkw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=M6UYPBkwX6hv8kp4zRLzi0SAuWJ/UK6hxfqzJas6CVUl0RE12joNxlA0X7o+LwVZV
	 ocan4VGAE8rGneCUep0ZioHB3Nh6Jrwfi8vGHjfgAzmdY7tqWnSEpkrvMZ+iw4cQWK
	 2gtXaM4uT1Og5kHfbzfAtgPfeOqElcArmFIl4XTRTB0ITZjHuEn9llQorN238zYo3b
	 hkaLyy23rVMP/JuGR1voK2ktbBiJSWgONf8E3F0EBkxtEW5ApnkprwbqwwTRkvRzaT
	 c2UaK4+dkT0U53GDi6Ryksv7S/MphMi9g67hL3xqp1/gnaISleAjkvDK0JUNoEZr3Z
	 DXmgtFWVeNwatFNPQQ1WDkXJMVUjkkjupl3Sw4JDgypFLWJHQ8HM5DJxR2GboeVRW2
	 il9yW5NRvXOa1hJUW3ailuH0pHoK2AFobIRxWxPVw0Rf+whft8IfUr21I8jI/Q0cXk
	 I7Jznw8EV2zCACSSNdh7xm6f56yvTjOvBGlWMlO3uI8NnAYkIpU
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d404:ac95:e677:6cf5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3CF8E20107;
	Wed,  4 Mar 2026 00:13:37 +0000 (UTC)
Date: Wed, 4 Mar 2026 00:13:36 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #01)
Message-ID: <aad5MGUt8ZVdxLlY@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqbjh5fvsn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hDvf/7XIp2wV03Y1"
Content-Disposition: inline
In-Reply-To: <xmqqbjh5fvsn.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--hDvf/7XIp2wV03Y1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-03 at 03:15:20, Junio C Hamano wrote:
> * bc/sha1-256-interop-02 (2026-02-07) 16 commits
>  - object-file-convert: always make sure object ID algo is valid
>  - rust: add a small wrapper around the hashfile code
>  - rust: add a new binary object map format
>  - rust: add functionality to hash an object
>  - rust: add a build.rs script for tests
>  - rust: fix linking binaries with cargo
>  - hash: expose hash context functions to Rust
>  - write-or-die: add an fsync component for the object map
>  - csum-file: define hashwrite's count as a uint32_t
>  - rust: add additional helpers for ObjectID
>  - hash: add a function to look up hash algo structs
>  - rust: add a hash algorithm abstraction
>  - rust: add a ObjectID struct
>  - hash: use uint32_t for object_id algorithm
>  - conversion: don't crash when no destination algo
>  - repository: require Rust support for interoperability
>=20
>  The code to maintain mapping between object names in multiple hash
>  functions is being added, written in Rust.
>=20
>  Will merge to 'next'?
>  Message-Id: <20260207200446.2837699-1-sandals@crustytoothpaste.net>

I think this is ready.  Of course, if others have objections, I can make
changes.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--hDvf/7XIp2wV03Y1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaad5LwAKCRB8DEliiIei
gfvpAQCCQyBeoLxAHyamfsY7zvbusHRTRctfFF8tNMXDudML2AD8COm4+kT+CztL
ULeqRV9dBFASt/NHUxeZ0UlZYVh23gg=
=Gfga
-----END PGP SIGNATURE-----

--hDvf/7XIp2wV03Y1--

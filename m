Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26C41CBEB9
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770592231; cv=none; b=N/5klCm2d9AgZB4mG4ld0nFkQ0SPLYOY5gh3tI+tz0TYxH84FENT6ZV/x2HLZOkkNQxO7UsFQjyP4PtEbqPAQzptgdbhKoc6aImjRXzjTYJ500/kTQgcXja4kggNDykCjIRoaXB/SvHfMwcvIwhigeW+Uh7HWp7BnzHS7sLIQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770592231; c=relaxed/simple;
	bh=0SgKSu4xQ/aR7khLGKYWLse7hek2BivC28KIfR+2YIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9a5g4dLf21ZiMzHBQRyC649Jn/D2L1+V07y03c3yRV9osJTZ9klrt5Cr0lPYGrdZYdTH652N2rbUg3OrLo7QsZ8gG/uAb3fjif+gwBI90jSHWJ5GRx3swS4ucSFzld997EYpfMN38TpDTUpF34I1Isf9AIeKxM/pu5jlJczIH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qX/oMKJm; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qX/oMKJm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770592223;
	bh=0SgKSu4xQ/aR7khLGKYWLse7hek2BivC28KIfR+2YIo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=qX/oMKJmAJ0Wp0oRUOg9dxwtfvoSd25pu5EVRm/hcmA2yd/WQybxcT+nY+eZ5VSXS
	 kfck7ihwRs3vcs5EFeLY07EiUpc4atgSze2VZsL3UMdKE4Gd309hojoB3Qd6GAlteO
	 eocXtPQDbXI2nASsQwDqUiD8QT5kqq+Nz8fB6D0vH4Gsg64bR4SSTsAL2+R5faLhwo
	 Ad8OwU7qJAIKq+PwWH6fBjnRsfKzlGWTpCr1ZUcAy0PXHDgO9Q5LOJGx97JHesYBW4
	 6X8W04V6lGtPEPgUnjQLP6vQZn7L116AEI2DCJ7rfRz1mkdSRhPGJAZtAuKDGdbNGK
	 PHdMH8b5DJPVfdMgX4i3BdLHhgSNvN7UpLkPVzMOaAldz2LqoveMN4zUtGJDuR+92/
	 P+0KeAF9NJ4d/da2NbUqzvIq0poV9gqmckZ1Dhx4LTWcalizal6XfJUjEmkZJCXGQy
	 4UZnJHE3H5BtvB9HyabcaXlQt98Q59VWIbi8zWTFAU/Td97RpWm
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:452d:fee3:684a:bd07])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8060E200B0;
	Sun,  8 Feb 2026 23:10:23 +0000 (UTC)
Date: Sun, 8 Feb 2026 23:10:22 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2026, #03)
Message-ID: <aYkX3rIkpIvLsej0@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq7bsob0wo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lMR9ymj+hWA7w8Dm"
Content-Disposition: inline
In-Reply-To: <xmqq7bsob0wo.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--lMR9ymj+hWA7w8Dm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-07 at 23:15:51, Junio C Hamano wrote:
> * bc/sha1-256-interop-02 (2025-11-17) 15 commits
>  - object-file-convert: always make sure object ID algo is valid
>  - rust: add a small wrapper around the hashfile code
>  - rust: add a new binary object map format
>  - rust: add functionality to hash an object
>  - rust: add a build.rs script for tests
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
>  Any progress on CI breakages???
>  source: <20251117221621.2863243-1-sandals@crustytoothpaste.net>

I just sent v3 yesterday which fixes the CI breakages.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--lMR9ymj+hWA7w8Dm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaYkX3QAKCRB8DEliiIei
gdUaAQCXE4C6EfJIFO5juHjb8ShVDP3Vu4lZPkpjI9uhN3sytwEAlv/lf6+c8fzQ
JY8xImurpGux0eZap3LipvQlUVbDxA8=
=W1OH
-----END PGP SIGNATURE-----

--lMR9ymj+hWA7w8Dm--

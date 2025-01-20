Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48017C68
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737336758; cv=none; b=rE7hgvYPEG0ER7E1b6PoNV8k3KaKUxW8pmtlAp86xf8sN0Br9b54o08H9YIIoLxYFCjYnZoaGIKnsWAv6RW6ndAIF/0I0c360ZEqxM+g0uila29NNgy+jdYc+JjoWMuq35zERCWVa9sTNu7suoFe77EAWMzJHfCR7sO1RJjl0/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737336758; c=relaxed/simple;
	bh=HC2etLU15vfrDEV9ooCN1p1woPVgSpihaMicfx3vyBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojZGkPrpkPdXqR+Zd2EbGWwZlN1FZeQF8xQ7DEzUR8EMbL1DKzPpAiDDkkkXcNhGdl+ANciKB3tawG3QEI2geTV0ONfKmbnB6z/o8NEvhWQRrx8LLDAl43AhxrJgziboYAD9H+ugXsZSEScIGYGfZDtQH+ZYKjnwowXd2Gz3KIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=IsTMAryk; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IsTMAryk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737336748;
	bh=HC2etLU15vfrDEV9ooCN1p1woPVgSpihaMicfx3vyBE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=IsTMArykIPckRGUm6VFy2WLuNz9bW5wHkubuu75JOQ35j/E5XUIjgtOd4l0OXcBy/
	 GqelXIxUeKKGDKetEDu0cP9KHbJECAdKlqw5mSSgoQUYc/aTlBsQGDb7yTs0EZPZAR
	 ml4oLo1aMMV2NviN/tpo+ECGZ7FEQuBvxUm6TCBaESRGo7C+7xehh5xNZaV1hk/9j2
	 Y6dig9pVsDCXbiRsILWPRR/JSWG1xLedG8XzWiuimsTnenu5zGPyuz5LDz5qV04orM
	 dsWElrfrCDYr/QJxbClI0Z0DIiMy4NU6UqSJNCpu2eUZOsz3TqdMSgbqesUWVLtxPH
	 acz+oK2gHmjt9SoPklZdwLuBYm1cpVpUwKhPa7X+JyqLqctiAPcM1vjFk/v6AGjJvS
	 YSP6vNfNeotMQJpfhTi9NGn2HDiL1lK9CkOhjI/+f8LFI+5QU9L66t3pvMm9BrvlZC
	 9WbKHkcxEG8yR01IljN3F7GKLHWp8cby5ncbSYG8rERDUG5nk1s
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9ADE320033;
	Mon, 20 Jan 2025 01:32:28 +0000 (UTC)
Date: Mon, 20 Jan 2025 01:32:27 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Al Grant <bigal.nz@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Rebase
Message-ID: <Z42nq54yuWqiU4t6@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Al Grant <bigal.nz@gmail.com>, git@vger.kernel.org
References: <CAODtcdcTjquNUBaTWKzyy54J5NoH7WO+9uMzJ+wWRDf0Na3OPA@mail.gmail.com>
 <Z40mlmfnUOXI2ghd@tapette.crustytoothpaste.net>
 <CAODtcdf-+QpPpB5R-hLkKWKacwM=N3=XRDs-tK60W9WzUJu7xw@mail.gmail.com>
 <CAODtcdfS+TVmrwohtHFUXRZRwC1WmF5ENpZLVoZTyJgA--SC-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SN4onE02zbPrmdyZ"
Content-Disposition: inline
In-Reply-To: <CAODtcdfS+TVmrwohtHFUXRZRwC1WmF5ENpZLVoZTyJgA--SC-Q@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--SN4onE02zbPrmdyZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-19 at 20:39:13, Al Grant wrote:
> Yes. But I'm keen to understand how to deal with a merge conflict.
>=20
> My IDE is VSCode and when I run the merge I get this image:
>=20
> https://imgur.com/a/vynTxaj
>=20
> Which highlights this code:
>=20
> 255: <<<<<<< HEAD
> 256:        samples =3D signal.convolve(samples, [1]*189, 'same')/189
> 257:
> 258:        #for testing - log to file
> 259:        #self.f.write(samples.astype(np.float32).tobytes())
> 260:
> 261:=3D=3D=3D=3D=3D=3D=3D
> 262:        samples =3D signal.convolve(samples, [1] * 10, "same") / 189
> 263:
> 264:        # for testing - log to file
> 265:        # self.f.write(samples.astype(np.float32).tobytes())
> 266:
> 267:>>>>>>> 1f893dc (Make project runnable on Linux)
>=20
> Now I would assume that samples =3D .... from ln 256 abd 262 are the
> differences between MAIN and FEATURE?
>=20
> But when I search main (at least I think its main - my IDE doesnt tell
> me mid rebase process) for ` samples =3D signal.convolve(samples,
> [1]*189, 'same')/189` AND `samples =3D signal.convolve(samples, [1] *
> 10, "same") / 189` - those lines do not exists anywhere in MAIN???
>=20
> So what is going on????

First, I recommend that you set the `merge.conflictStyle` setting to
`diff3` so that you get the contents of the merge base as well.  That
can be illustrative when you have conflicts.

It's important to note that a rebase involves replaying individual
commits from one branch on top of another, usually using a merge
algorithm.  That means that it isn't necessarily the case during a
rebase that one side is the complete base branch, but rather one side is
the base branch _with all of the previous commits you've rebased on top
of it_.

So if you have this:

 A - B - C - D - E - F (main)
     \
      - G - H - I - J (feature)

and you rebase `feature` on to `main`, you're going to replay G, H, I,
and J (in that order) on top of F.  So it might not be that the code
exists in `main`, but that it comes from one of those intermediate
commits.

In this case, the conflict should be trivial to fix up in that the code
appears (at least to a first glance) to be logically equivalent.  I
would personally resolve this conflict in favour of the version with a
little more whitespace, since that seems nicer to read.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--SN4onE02zbPrmdyZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ42nqwAKCRB8DEliiIei
gfMUAP0T+1+GgZ1qAFklKxhrovDtbk1K4gvX+so7g4P01ijf8wEA2G15HVuxpREw
XZmC6rupMXO+84gPOMBpqkXmBtFD1wg=
=5yfO
-----END PGP SIGNATURE-----

--SN4onE02zbPrmdyZ--

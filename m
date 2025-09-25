Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF0531AF1F
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836409; cv=none; b=uqfgqfZz+qj5/3/sbHwUrJpCzBrHuVLSP22M/TV/rhRjIxgVSkdLqyQqjsa/szjBqOtTItt7KFgjoOF4vUAWefTmDA8nQFrgM/FOo1DUwwDiMFymiIKhGTbFYzeaHGUlkJH2tODhvIx1m9dLzgFXa4J7LQPlLYOYHUtQMTnsQlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836409; c=relaxed/simple;
	bh=0opRZDc8Q3vfyfP0LkFaoxfdygHtVR8siq30RV9q9FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cd76xjmE9+b2QHpc8McMfjpHGwDkotACdFKnjW0nr57asBZzIPwJJD91y4ps2MwhGtJJ3TmbbJaZfa4PagKkWNlXDVBdoSHXrYgiBvBc44PwgEVyQTdlogmr9hm5SBeushSuYaQqzomDwi/1NeqgoosmuWAdyW9s+YItUFn374I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=SD9Nl7go; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SD9Nl7go"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758836399;
	bh=0opRZDc8Q3vfyfP0LkFaoxfdygHtVR8siq30RV9q9FQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=SD9Nl7goYBST7DEPQED94/HUB0GsyfJM3eXRZ2M+T/O9DE1Qo00cv7/CFDaePXKbS
	 B/v09eTs/Io25te65+qLtodCS8Y9CpZoBtr5koPuTuX5REidN+s2sQha8hPPzj0hQ8
	 G8gs8RdgAkfoTMMkKhC3vXQQZ33FEQMZAgQ7EuZwBz8IXPc7k1Xo3lY8Pcj8INVnlx
	 Q69Vpp+VCaRg43Ct9Jo9Y2yljRUtzWpTtzSQL4PDwToxhsPa3XH5jpAovh9tWO6f0D
	 m8ruqRJbW3w/Ps/zJxy2eAsDZHVIeh+MdeJtaqUF1jGPdmEAxg0FHSK/WCH+S0P6wm
	 Rpp2Lj6dq+R4OGqhSvq9fmOvlTkOy9mtvc0HTR8G7w1bAEYv97f58q995bLqyijAXM
	 xPuyZOo9RMZnWP9PO+y4bQgP3XQ2hNyK8MgdZi7JteqO7gh3Huk2wRgUWREzjIDXn6
	 1DsSq+Ff7Usubx7BmTN0VvlLTA/nuTTGeHajLIfXauysAu5MxvX
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:916c:9d5f:e4b:808d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5863720107;
	Thu, 25 Sep 2025 21:39:59 +0000 (UTC)
Date: Thu, 25 Sep 2025 21:39:58 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/9] docs: update pack index v3 format
Message-ID: <aNW2riVWtLQbacSR@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-2-sandals@crustytoothpaste.net>
 <aNOj8fFTvkQ6jsaT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1JpXgFkjt8P7L3dn"
Content-Disposition: inline
In-Reply-To: <aNOj8fFTvkQ6jsaT@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--1JpXgFkjt8P7L3dn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-24 at 07:55:29, Patrick Steinhardt wrote:
> On Fri, Sep 19, 2025 at 01:09:03AM +0000, brian m. carlson wrote:
> > Our current pack index v3 format uses 4-byte integers to find the
> > trailer of the file.  This effectively means that the file cannot be
> > much larger than 2^32.  While this might at first seem to be okay, we
> > expect that each object will have at least 64 bytes worth of data, which
> > means that no more than about 67 million objects can be stored.
> >=20
> > Again, this might seem fine, but unfortunately, we know of many users
> > who attempt to create repos with extremely large numbers of commits to
> > get a "high score," and we've already seen repositories with at least 55
> > million commits.  In the interests of gracefully handling repositories
> > even for these well-intentioned but ultimately misguided users, let's
> > change these lengths to 8 bytes.
>=20
> Yeah, this makes sense. We can only assume that repositories will
> continue to grow, so it makes sense to future proof.
>=20
> We also have the 4-byte number of objects contained in the pack. But as
> you explain, it's nothing we should need to worry about given that this
> is a mere counter, and not an offset into the file. I doubt that there's
> repositories out there that'll have more than 4 billion objects anytime
> soon.

There are certainly some users who try to do that at $DAYJOB, but they
come to our attention (because our maintenance job fails due to taking
too long) before they get there.  I am not, however, aware of any
actually legitimate and productive uses of repositories that threaten to
break that limit, which is what I think what we should really care
about.

In the event we start seeing those kinds of problems, it should be easy
to implement pack v5 with a corresponding index, just with a larger
number of objects.

> For now we only have SHA256 and SHA1. But thinking about the future,
> there will be a time when SHA256 will be considered broken. I wonder
> whether we should safeguard against that and also specify the trailer
> hash to be agile? That is, instead of hardcoding the hash function, we
> add something like a "primary" hash to the packfile and then use the
> full output of that hash as checksum.
>=20
> In any case, please feel free to say "no" to the above thought. It's
> just something that popped into my mind upon reading this.

It is actually that it's the main hash algorithm in use.  So if we add a
third algorithm which is SHA-3-512, then the trailer checksum will be
SHA-3-512 when that's the main algorithm.

Technically, it's also SHA-1 if we're in a SHA-1 repository with SHA-256
compatibility.  That's not a use case I really encourage, but it is a
use case I'm testing because it exposes bugs in our codebase and I
expect people will want to do in-place conversion from SHA-1 only to
SHA-1 with SHA-256 at some point.

I'll fix that for v2.

> I guess one thing that should be explicitly pointed out in the commit
> message is that there are no implementations of the v3 format yet, so
> this is basically updating our envisioned design, only. Otherwise one
> might wonder why we can update the spec just so.

That isn't completely true.  There is an implementation, but it is not
yet on the list, and it follows the spec written here.  I will provide
documentation with the rest of the pack index code when index v3 comes
in, but I wanted to update this in case people are trying to add it in
other implementations as well.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--1JpXgFkjt8P7L3dn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaNW2rQAKCRB8DEliiIei
gcjhAQCWqU6L3EfGIL537g16WUnWefMoOfEMl1ZF4VLUjbJQVgD+MW1eWMouqK0v
R5ikmn43QJDeXuMMB5yu1IvIq1Egmwc=
=s7Hz
-----END PGP SIGNATURE-----

--1JpXgFkjt8P7L3dn--

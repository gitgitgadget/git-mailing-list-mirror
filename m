Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCC6229B38
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508581; cv=none; b=raRkqyuz951IavU3Sowt/l+oQngVB5SAJo5wHQFcovBXeiBl15jAQ7LOQlF7NADo/w8RUMwpa6JQV4XJBCGzP8Bxz+w1aLJmxtPQzKzfvmTHAtZBxTpDSBAJ3NtIS44gBhe91OIrlM0Lz7JUm8OhgVQib9NsbOJqywjgI1XUL+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508581; c=relaxed/simple;
	bh=jUi23mHQrRqZL1BSKYSH890mTk0SQHPJ3/E3CHR0/+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBvc4/JsJRnBOhT6ez/c25AovlyU+VjvkKRl3+li6iEKFNHHwJsx6+0u2cUFLbGA29Y8JxnTO5y4GdrbPtdK39wGgo/lOu/0OJoT/Z8zZBVnQq51uIXJO52yqnwwVX0QPBJw2OHtoiL0khuXhSUs0fimEvEeMgXlG/KRo6DDJkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=nl5YUObD; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nl5YUObD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1742508571;
	bh=jUi23mHQrRqZL1BSKYSH890mTk0SQHPJ3/E3CHR0/+w=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=nl5YUObDNjhTmVVX9vRUPprH1L8OXBYTimJ6nsU6JO/jYPkZTy2pZTYcJz24hy7wL
	 4ff93zVtkz3qhL/29Y9slAhhZjpi+j7F7I5VE66sNAsPhSej5W+itkQ0BS5RsmdIW+
	 /BzvRrzDmbA5cQafZaeE4V6CtS7lI9nhQuSWVqmVW4pqUkbtcTEVBFE0RnQBzOnJAT
	 XusA1+BE17CDYQoKnV5mFNT/qAMQaDoOmrshNm7GiMaLqvekOCyZZqItNZ0P/Vf6Ab
	 0JaFK2EHwCtYKOlgH6mySPSGoosBXzTZ/g1NQKXOKMU016YfXZLdeXxH1aouci2b1i
	 8H5EdK/Eqlxnf74+kzmGs+aO/RFYktIi0uEYdTo/F/LVDt/PnlPm8x9ibfckNadDc+
	 NYWMvpSJCoxCfjt8K6w9K9Gkpln066evkgVn/nzr5mVUFQy9h5PmcOCjdbtT0IcxiP
	 2S6YBZldnsT4RbxKJVUPMRNMkF0xBPZHIJpiZDnuI8Wzib2X9FR
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 687E1200BA;
	Thu, 20 Mar 2025 22:09:31 +0000 (UTC)
Date: Thu, 20 Mar 2025 22:09:29 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: Possible venues for Git Merge 2025
Message-ID: <Z9ySGbE4sq0JfgKs@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
References: <Z9vuiCnKcMRRXHOR@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cYI3Su7oSgZ/5FuY"
Content-Disposition: inline
In-Reply-To: <Z9vuiCnKcMRRXHOR@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--cYI3Su7oSgZ/5FuY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-20 at 10:31:36, Patrick Steinhardt wrote:
> given that this year is the 20th anniversary of the Git project it would
> be great to host another Git Merge so that the wider community can come
> together and celebrate. Taylor and I have been chatting about this
> opportunity a bit to figure out what we're going to do this year.
>=20
> We have been discussing two different options:
>=20
>   - Hosting in the US in San Francisco at the GitHub HQ.
>=20
>   - Hosting in the EU in Amsterdam colocated with the Open Source
>     Summit Europe.
>=20
> Typically, the location is alternating on a yearly basis between the US
> and the EU. So given that last year it was hosted in Berlin it would be
> the US' turn. But given the recent political climate in the US I'm
> afraid that many people would not feel comfortable traveling there right
> now. So in the spirit of being inclusive I think we should at least
> consider whether we may want to break the typical alternating cycle and
> host in the EU again.

Yes, I do think that given current circumstances the U.S. is not a good
place to host events.  Perhaps that will change in the future, but I
don't think that would be a prudent choice right now.  I've talked to
several people who are uncomfortable traveling there, so we'd probably
get better attendance hosting elsewhere.

I would be fine with Amsterdam, and I might also suggest a major
Canadian city (such as Toronto, Montreal, or Vancouver) if we preferred
to do this in North America (since we've traditionally alternated
continents).  I can imagine other locations outside of the U.S. that
might be fine as well, so I'm willing to keep an open mind if a good
opportunity comes up.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--cYI3Su7oSgZ/5FuY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ9ySGQAKCRB8DEliiIei
gZ2HAP4ncOGAMPlzZeGwBLGLP+XV9CtHQiFBWmjxsGpYAjoQ0wD+I9AWYFGVEbF7
cwje26/WtSQ2qDg8/1b0YDhkAPWuSgs=
=GjIb
-----END PGP SIGNATURE-----

--cYI3Su7oSgZ/5FuY--

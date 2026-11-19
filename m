Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126829;
	b=ZzI4p7ffbC5TWLwSZAjeU1IDRgnRNZ4VkFg8MkYx8JMmW5NPz9iBa+WAVn68bl73pPKr
	 aRtNKVLDywSnW2asoW9omuPqoljEacHNqclFgvJS4jCkU4AFAz7SjHkQzm8lvuOCpN3/I
	 sEDCWoAQOIoS0hWPWXOyqV78jfpS/7g8VpEpAjilkLfRZStgYf31Ky5GEmMi2Fr4adDC1
	 JYpls8o3zr6WQTYco3ykj7+dBLiNMiOO/vqv7T1JhzYZkp5AibJ8a1blxG2yiItaHqjb1
	 42jRaSKAMXRbVw6/AaANC2X+9ez8ZpnJOEaTmYYarN5nTiictWsPytg+HSKBUQUXNMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126829;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=bjM1xmNB6XN4oJRiCBprHNCa4am5fnQKD1qz79rFerI=;
	b=1ZVA32M0cFG6iXCoXIpxXucKRxZymhYZE0t3165I/Af/GqN2n+g37Up/bTejnG+7mBo9
	 4wBUX7k8ZRl88UcZmYpKFOYvqS6UXPPjEL8ko0J6ixrqLWRua5WusbxRibmEvZMhzZI0g
	 WIEe+EB+MXctX29wm2SEE4WTkfwhwvBAFYoBPOB/3GZFTYQtEY3/zXR/Bk/Cn5CRljM1q
	 GRsbBgcwRQ+Wf7GxS8gw9jmECuLBFr6tXsZ+IEr8qX4/30sleXdV3sgM6JE2qWLzPzIHQ
	 g3OZZGchl3p7VU10XdVJ7WxFE91W/Hew3JolfYQyQCPhWKOgPTdrtHcOl2MrqH7DcuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=DeGe8cSS;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25040606A32A
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 22:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25040606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=DeGe8cSS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1795126828;
	bh=+DzQL21zQ/ELk6n5rsMR71yTvFT1DqhibQQWM7X3r7Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=DeGe8cSSyvHTMci5a5OVQe/MaDAWvtRoVq0dsQDTenMbIxCtEv37okRouF185z0B0
	 ITqwvraBD6DsWHrxZoBQVLwJ5Np9ke+ht6beBnsJ0kh+9X5luSDqMd7dkjeH/wWriz
	 GnwXUPd32alE+RjAu2CnPqk9v4jMWQ+NqsiryN/KMoUCZqeedNlHcEvZkRPZL/OJ0k
	 pY9Oj/zsuNSQGFoS8YmbzPOcjVh9kym4q83cugcUmFMUV5oEbbjM0gC63h5MFsRV1i
	 poo4Sixc5CD77qzaO0q6msbQhaebtAbfu4QvxtyEZ6x/99nkIZl9CLwCmgUxX8g7Wl
	 T3PAOKGKP/lNi23M45aQ7mLaidTqZ5zlrQEhFV7r81Hkbra0HKDZwhQBj0nb4STKG8
	 USbvj0KqQfJMqgEHdyl6SdW1DojcKsIQXtVNvPa87xHoNnfHajBA9n5dJxEZzDlKqC
	 Uy77quZSObnre3IeBnGoIN9I0hnSSpRwcLRIDVnqpFJ+nsnAXbx
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e18e:32b8:962f:fd25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2E9F0200BF;
	Thu, 19 Nov 2026 22:20:28 +0000 (UTC)
Date: Thu, 19 Nov 2026 22:20:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v3] setup: fix hash algorithm detection
Message-ID: <av92KlePF0GKyQDh@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, Adam Dinwoodie <adam@dinwoodie.org>
References: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
 <20261119010612.687733-1-sandals@crustytoothpaste.net>
 <xmqqmrr4zsi2.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uyU3TFZMAbItIAIF"
Content-Disposition: inline
In-Reply-To: <xmqqmrr4zsi2.fsf@gitster.g>
User-Agent: Mutt/2.4.1 (2026-07-04)

--uyU3TFZMAbItIAIF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-19 at 16:38:13, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Our current hash algorithm selection code has a few different problems.
> > First, we do not actually default to GIT_HASH_DEFAULT.  Second, if we
> > have an algorithm chosen by init.defaultObjectFormat and we re-init a
> > repository, we will change the hash algorithm, which is very much not
> > desired.
>=20
> Can we end the "first" sentence with a reason?  We do not actually
> default to GIT_HASH_DEFAULT because we initialize a variable to
> SHA1_LEGACY and we do not consider it as "nowhere the user specifies
> which algorithm they want", or something?

I can expand on that.

> > Let's restructure this code slightly.  First, if an algorithm was
> > selected on the command line, assume that's what the user wanted.
> > Otherwise, the other options should only be chosen if our repository
> > doesn't exist (that is, repo_fmt->version is -1) or it's specifically
> > detected as having no hash algorithm.  In that case, first use the
> > environment, then the config, and finally, the default algorithm.
>=20
> In the current code, does "it's specifically having no hash
> algorithm" ever happen?  Or is it our wish in near future to have
> such a state to allow "the first use determines the hash algorithm
> used" mode?

It should not as far as I can tell, but we have a bunch of different
cases, including the clone case, and I'm not 100% sure if that actually
ever happens.

> > -	/*
> > -	 * If we already have an initialized repo, don't allow the user to
> > -	 * specify a different algorithm, as that could cause corruption.
> > -	 * Otherwise, if the user has specified one on the command line, use =
it.
> > -	 */
>=20
> I think the first two lines is still relevant and serves as a
> caution to whoever will be mucking with this function in the future.
> The last sentence is not quite right in that following the user's
> wish is not limited to the command line instruction (if they tell us
> via an environment variable, we would honor it).
>=20
> Oh, it just occured to me while I was writing the above
> parenthesized comment.  If I have ~/.gitconfig that was modified via
> "git config set --global init.defaultObjectFormat sha256", would
> that count as "the user has specified"?

I'll rewrite the comment.  The "user has specified one on the command
line" means with `--object-format`, but the user could specify one with
`init.defaultObjectFormat`.  The difference is we scream if the former
mismatches with the repository, whereas if the repository is already
initialized, we ignore `GIT_DEFAULT_HASH` and
`init.defaultObjectFormat`.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--uyU3TFZMAbItIAIF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmr/dioJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ5s7RZPUtMuqQgBB51EjUvS0H5jliPx+7OfxEMMY7MVw
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAFQAAQC4uJbXJg38coCFkoa4yHrCQDnB
NsSbkoBmS5rp9YKBZwEAp9SbY0VIkQ5R30X8l6nDxFPg1nqahhEErieqlSf/7wU=
=HBtc
-----END PGP SIGNATURE-----

--uyU3TFZMAbItIAIF--

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793467621;
	b=kRefOv0p057AzSixBvoFEiYACE0nnNaQhZx4KtjsM52IqlSw+NCOQLCcoQGPQbyk/tmN
	 WR69Hjhw1Ky0bPAUBakfH5UyO4FY6PshEDTwoQW1cJXIuxq/0LowEURbHFem/dQz3px2N
	 nT0++HF/klUaIx9SVGsRDV3WtzPgHylfPUh6q/UTM+jHG+qqikIBrg3jU5Df7OUVZdA5d
	 bO/sTdtbrNR6rOeWm9oHoKV6WboMYXzYh5q+gROhWOcWDf87YZrqrGJJWvKXtCdYtC+3i
	 dRRUDK9G5ABD2vAkzxDo8I7sTuWX53Ru/3UWYc9JystSEpqIZnYE0DEEbwRzv49RCnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793467621;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=QqCqhs884jZb1X76BgzsnZr9Zi0xRI124fXaGtnu+ak=;
	b=qfR+BvFk0rDKlQRBqT7N9mxxWwObTHpGiWGLu2wYc2SX4rNDOcozHWjm5B5J8l2LbhF+
	 dG82LKrv/LG9/63Ze4isXqgn2KtUTReQpP6/LaDDfoNSjUPdPj6omlKMhbe4QE/xH2/wS
	 /zT9jloevnRia145WQ7YxnTS5+2JYUHvKuygCJx9+mbY77I6Qb9nCSzBVS+lrtHqSyFsw
	 x92tdJJRgQL0jlYwk+eXI37A3LQveLNNrHMoc2xIRTZxfZsSxngH8dyzG+uXTtIHsZpDa
	 l0BVqEmlyEt5uEK76ZyXMnISmLKGGcY+rLWmd2x/I9X8fO2jOrzZirLvYkvMsxQHtfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=blYGavRY;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A64606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 17:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08A64606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=blYGavRY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1793467613;
	bh=ZaYBpURHXS7ad44Iyre3JDFOHDvy9ptpHJ0vIAx+H0A=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=blYGavRYJV4ju2XR8LGbQC9WiRLxWupscR0IyjFYgLPg3uWKHQ2qPoOV0N1jY9dgP
	 bAvIYLdN1RsnuW4UH6QWB+dZCnNENWD/WmWug7YW2MdhcwWYAJ1euVGObfJwS6fRS9
	 /eD5ZsEjYIij1YMMg7ws6gQuInZVb0LjRWap6FOY/bvxqgAMbDukiql1r1zAZ6n2li
	 yxWrd/dBHnPQrtU0X2xridNkKNIXFxBXyBMLIPedvhRHAScEXUqvWUPhfZ6Xe/32v+
	 jt+bz24iXZ6cZnnt3iDx1N0BxT5skW5efb0RRicvts6FMxSKsLTDy18Y+5s4ZjLsC1
	 Ra5hUwMIlfWnikiTdAVXDxGEPg5VfYhsS8cATT8P6JDySbJBSBHqEDwwmR2v5lqPoN
	 qBTTKmgtZhgwKAczOXR4ma82GJIe29kdoax+YslWaN+Tqg+4F9Jkt3smsohfSrBHTT
	 8QQOkcFgaZ5ODxucOP50JShZ31LadEUuCmyrO6Aq+8mgwcVvedk
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:77df:eff4:b627:e9c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8F30B2008B;
	Sat, 31 Oct 2026 17:26:53 +0000 (UTC)
Date: Sat, 31 Oct 2026 17:26:52 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Chris Torek <chris.torek@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: sharp edges in Git configuration files
Message-ID: <auYk201o4foYWl2d@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Chris Torek <chris.torek@gmail.com>, Git List <git@vger.kernel.org>
References: <CAPx1Gvd3rAcgDf-rBPOuZFf2=Y+=JxJDdr6AJTvdtpL6Vsk43w@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="hiXt9eqPJgUBBbxj"
Content-Disposition: inline
In-Reply-To: <CAPx1Gvd3rAcgDf-rBPOuZFf2=Y+=JxJDdr6AJTvdtpL6Vsk43w@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--hiXt9eqPJgUBBbxj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-31 at 02:56:44, Chris Torek wrote:
> The obvious thing with "doctor it hurts when I do this" is of course
> "well don't do that", and nobody should be splitting their .git/config
> into multiple included sub-config-files. But, in the spirit of robust
> software (and perhaps just as leftover bits?), it might be wise to
> make Git ignore include lines in config files that are intended to be
> Git-managed directly, such as .git/config.

I actually believe we're using includes for `.git/config` in some cases
at work and I'm pretty sure my colleagues do want them to continue to
work.

I don't know exactly why they're doing that, since I'm not intimately
involved with that project, but I will point out that our fork of Git
has a checksum that includes the `config` file (but not included files)
and that must be in sync across replicas, so they may be doing so to
test out a config setting on a particular host during development.  In
any event, I'd say that while it may seem bizarre, some people might
want to do this for other reasons[0], so we probably shouldn't break it.

[0] One reason I can imagine is personal configuration (via
`path=3D~/...`) in large shared repositories.  Yes, people shouldn't be
doing that, but we know they do.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--hiXt9eqPJgUBBbxj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrmJNsJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZzIl68wtEImqoAUiIJObv7LlRfQfaKt1Xr5RYMdDvBwQ
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAGqTAQCjGgYYmlEDksu5yi/92C14he24
qQr81ukpnu9sPDBkYQEA5pgi7uaDjgPvnAsCERl2DsHqobjtVRQUOw03QqxSUQo=
=OGqa
-----END PGP SIGNATURE-----

--hiXt9eqPJgUBBbxj--

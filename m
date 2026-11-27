Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743825;
	b=k1/w4CCu1uG/xJ4qvg5PsVRN+zDfmmztLxd+sQyNFYw4V/sEOPsE97A5Ytuj8CQvOHZP
	 d483vcA1uMhE8YAWjzAJ7Nm2weko+yJteTbkknnnBopLBKyH+lI6AJqyX7EghkBVX1tYI
	 i1iVZZ5aS4zFK+i00+Wyb/9ba537uCDvllVbiuPBFZ6J3Tdzg/yZ+gydYyj29OrZTeBSE
	 B/r8gSmXicGMg9Vp0LjYCQ4qsfcj2nktLpv7MXNp37fX9fyCkUlXgmHlGcWkW9OluHMFz
	 ayJYDzRQkZ2swgj6/JIjAyjzzRcLI8bkeH5iwBnq44rsGpDdgidKY1AwivNuubrN5fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743825;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=K4ac3URGZrLDowotzUkmFStWYlPWAzsxyDrLIPlpRfA=;
	b=XhZSHFMunCwJTdVCIFdcNhq5mzSKX1lqmBrGzyC7zD2txQ3/IglOtslho+pJNSGAA7i2
	 tfph6GA3XslqyqACafRA9zOYrS2pgqC/XMjmMcG/aYkRRhpYmnrHCq3y49uRgdYHvZPW3
	 NTeFTwOQ82oHIUbPZOaM2gB7dMFR6aN0hZjBpPnI13K+OIybzmwAo3KL/pFf2sAGKuL1d
	 hPo7nU40ztgAYFg4jyGo3GCCfDwVL78JW8Tpm4FWcgKNJydoX4VpLfB9DAZlRwMyannDp
	 mPgkiGpAcEmIXRfU65MrRWvwhOgYSyo4rAhkwBz8ahBjXRXfuAmDrf5TdqnMow1XhCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=bZ325fV3;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7825B606A321
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 01:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7825B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=bZ325fV3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1795743823;
	bh=TtYvUmXey71N3U64ExjBn68bFsBf6uavmtyBIVb/F+k=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bZ325fV32mYB3xP5WH2+27TAsw2jN0zqYU4FluTjDSF/XGFHQUjWodQ2dSofRPyeq
	 dvGvBd0C6+z+Uxz7ExGRgWcIIiPyIZ2Vumi0Pa2PkRratDVplBSsnlW8/IcXfqqXox
	 kUVkH20NExj2R1HGzVRGv8g6h4SzO4gV9XU7gqtxfgffDb995yV128VQwXV5rpjxzk
	 XIf7VCTVAQqxydyhj8xlDxfd0nXqS1iTMcDPNnujxBYu/D0kFy8XwKyT+hFSTJRR7J
	 UkTyQfwOgr8IzBUXtWCpA8vGnXjOfOclNS/N1nBeXVycTEPgOGZjaDHJyn8A/7KLOA
	 4VYurr/h0sJEMI85R/mdLnm2NJFLp6AyFy63xCjHIIUA7cLOqrdoHB+jkFcG4FbUlT
	 mG9RFBGF5fNwfzkJZgrWBt02ylN8EOgzlrwvsaqtmRASVh7G1B1xQ9hAApemRi9n2w
	 yllDbk3+ssjglkqGEXVqXawGnF6X0MgeNwZ6VBeBbYDmIB64JA6
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3039:9617:3790:4535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0F561200B1;
	Fri, 27 Nov 2026 01:43:43 +0000 (UTC)
Date: Fri, 27 Nov 2026 01:43:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "Prova, Maher Niger" <vse25@txstate.edu>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request for VPAT/Accessibility Conformance Report for Git
Message-ID: <awjgTF5k2xjTEcqw@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Prova, Maher Niger" <vse25@txstate.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <PH7PR11MB67956F9A406338B2F76B7B9ABC412@PH7PR11MB6795.namprd11.prod.outlook.com>
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
	protocol="application/pgp-signature"; boundary="O3es5dvrfmi2B7Gs"
Content-Disposition: inline
In-Reply-To: <PH7PR11MB67956F9A406338B2F76B7B9ABC412@PH7PR11MB6795.namprd11.prod.outlook.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--O3es5dvrfmi2B7Gs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-27 at 00:38:15, Prova, Maher Niger wrote:
> Dear Git Development Team,

Hey,

> I am a Ph.D. researcher at Texas State University, requesting institution=
al approval to use Git for scientific software development and version cont=
rol.
>=20
> Our university requires an Accessibility Conformance Report (ACR), prefer=
ably prepared using the Voluntary Product Accessibility Template (VPAT).
>=20
> Could you please provide the latest completed VPAT/ACR applicable to Git =
for Windows? If a completed report is not available, could you provide any =
official accessibility documentation or confirm its unavailability?
>=20
> The VPAT template is available at:
> https://www.itic.org/voluntary-product-accessibility-template-vpat/

Git and Git for Windows are open source projects.  While some people
work on them in their professional capacity, much of the work is done by
volunteers in their free time.  For instance, most of my contributions
to the project are in my personal capacity and free time.

Many of us have limited time to spend on the project, so like most open
source projects, we prefer to focus that on building the software,
documentation, translations, and other resources instead of filling out
paperwork.  It's considered rude to ask open source projects to fill out
paperwork or compliance documentation since it's often highly specific
to an organization, not readily interchangeable, and voluminous and
time-consuming.  Time we spend on those items is time we're not spending
on improving Git, so we just don't do that kind of thing.

If it's important to your organization to have this paperwork done, you
could fill it out or pay someone to do so and then share those results
with others, benefiting other organizations that have such compliance
needs.

As an alternative, if you're not willing to do one of those things, you
could try using a Linux distribution, which will almost certainly ship
with Git as an intrinsic part of the operating system and which may
avoid the need for this paperwork (or which may have its own
accessibility documentation).  Perhaps your institution already has some
supported options there.

This isn't to besmirch the good work of the folks working on Git for
Windows, only an attempt to help you solve your problem as expeditiously
and cheaply as possible.  I'll also say that I definitely value and
appreciate accessibility and the work that goes into it, both in the
physical world and the virtual, but as I mentioned, doing compliance
paperwork is a bit of a distraction from solving actual issues,
including accessibility work.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--O3es5dvrfmi2B7Gs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmsI4E0JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ4ujlGUQsX1IAk907vBMr30APINk4frPisIOCT0ZJRrh
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAIRlAPsGDlEVOEBqBStb5e7U9Hlfq41r
qCZeeTDu63rj84yHlwD+IyY6KztW529DkwkDkfJWoO8ARcHrDZ0Eo0XryyJ/wwA=
=JBRb
-----END PGP SIGNATURE-----

--O3es5dvrfmi2B7Gs--

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148721;
	b=a7Sfj0QM/k2eelNesHx4rKO+IvBdNFlo0fLPb99ZVVmJs3dOtSXKZ8JmrMF2D71mXqK2
	 l0ZOWRBsjn1tymN4mb5jfs9DQBhbSsZqREghloIe6xPImaxxRmQYDjklIH8JOFaavfyjK
	 xxVb4HoP6jgEZRmQCpK1GHtyO7m87T1SqEEWq1aSohJgeUDotHejLUS76EcAUoqo1Cx5q
	 FcG3XLKNw+Fnhb4IQ+LmLSrX0jHm1xZFJAXenKDC0N2Wqbf0BQL1e6nRfNhFrbDXB500a
	 pm2gtyqNUQ5XWlAabLzMDLS+vrIVs8yBkNjYv1k4+FA7E1v6h8xACNxw7G+84P3ZWgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148721;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=EsAtUe2cguol8bynsGkz066PKf2xpm83v9yMHvOWFy4=;
	b=3uylV+AXZsGXIXG+ULmCwV8aJMRRXfl1N5PnbLSeZKr2+VY/D4xQ3JYxt5RjMk2EBU9r
	 eLhezXJdbdSUY+YntPwPTd2issXnkBFXFx3ZwXBWHJxtKW4KpRqLakVE36qVg17TSB3iT
	 6Varqj7xyO/apSFAIvT5fLVKz5xPIgF7LllMefIXFmIhqwTKOft80FpaceHDb/9DOXKeK
	 BhtNxNeHEctPRHmK3g7TY5/YtB+5lCkndlK9XGik/BXp8zpsEDRy6pyLeDWSLO5Min0vo
	 +I8oUgfolbbmZQWagujeW8vi7pZiTLSspYcHpnBnNCCbydJUcGasR4inm4Ej6yjpCIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=uxOgjm4x;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C0A606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 14:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57C0A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=uxOgjm4x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1794148718;
	bh=1FRUDU4d57D1V9UmqsYF072dgwrKGqaLs/x4jys+DHs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uxOgjm4xrTQwaX4scmptSP6WIYxaaFZNSIGy2N4KY2ei1lYAPfu5Voyy76R/oMuLP
	 iYtJODQcq+7Zgzb0ve2wPuVnp+5QUwbUDSTpoFerEtxKiq6FsSOgp0fv0BG3C6JNsN
	 eZBa1KZN1YlboHJC7q13tFFpBMn+8dK1yP7ADaeyfhenx/209CdR2KphFcxwoCLJfY
	 FTMiXtpI7EFO8JYxJfeNbiRvlJCIjc7+mwz+julJ5tRJ4pdMs6h6CZaycUXNFYI1ZC
	 zJp0L8E2wwQqQfU0A3aEaAkYVTgabVIaqs6Tbt13P0HHkZCe1JFjpbM53EG/I1XWFX
	 LwoOphGkjZbIkOgBBT0ox3Tx05jj4qrUjh1e0E0kAjMOHRSr4Oad3XSe/hNEshf147
	 7LDil16NsPV44aEgG1f0tos3bhVEcGwl7uTLD5iW2etadb5XREeck2cZvo0t6mKUnU
	 KPKtH+G4antGp9npNp15slBD5yeQc5WWhZDRTL1QpodqzGvNt79
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ba43:21ec:77f4:1818])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BDDB0200AA;
	Sun,  8 Nov 2026 14:38:38 +0000 (UTC)
Date: Sun, 8 Nov 2026 14:38:37 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH] setup: default hash algo to GIT_HASH_DEFAULT
Message-ID: <avCJbJE7mx_Z2zLY@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>
References: <CA+kUOampvjU3=VK3VGhYw2L5-E+LBsk=Q0UrAxhhR7hC5SUdJg@mail.gmail.com>
 <20261108011633.1772000-1-sandals@crustytoothpaste.net>
 <xmqqtsls53xr.fsf@gitster.g>
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
	protocol="application/pgp-signature"; boundary="HklZObr7OUXM4dwr"
Content-Disposition: inline
In-Reply-To: <xmqqtsls53xr.fsf@gitster.g>
User-Agent: Mutt/2.4.1 (2026-07-04)

--HklZObr7OUXM4dwr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-08 at 04:42:56, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > When we have no other hash algorithm to choose, we set no hash
> > algorithm, which ends up with us defaulting to SHA-1.  Instead, default
> > to GIT_HASH_DEFAULT.  This means that we will choose SHA-256 in breaking
> > changes mode and in Git 3.0, which is what we want.
> >
> > Reported-by: Adam Dinwoodie <adam@dinwoodie.org>
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  setup.c         |  2 ++
> >  t/t0001-init.sh | 16 ++++++++++++++++
> >  2 files changed, 18 insertions(+)
>=20
> With Git 3.0, we promised that SHA-1/SHA-256 interop will not have
> to be ready, and that SHA-256 would become the default.  And this
> patch would be a good thing to have for the second promise.
>=20
> But didn't we also discuss "empty/initial repository whose hash
> algorithm is undecided can take a push of either SHA-1 or SHA-256
> payload and that first push can decide and freeze the hash algorithm
> used in the repository" or something along that line?

We discussed that as a possibility, but it requires protocol changes and
nobody has stepped up to implement that.  I think Peff was thinking
about maybe implementing that, but I don't think anyone came to a
decision.

> I am wondering if we want to reserve 'HASH_UNKNOWN' for such a "was
> just created, not quite finished initializing yet" state.

I think we concluded that we'd need to initialize a repository to _some_
hash algorithm even if we had the limbo state because otherwise people
could `git init` and then work locally and we need to have some existing
hash algorithm for that case.  That would be true even with bare
repositories.

So I think the limbo functionality, if we implemented it, would be a
separate option (maybe `extensions.potentialObjectFormat`?) and this
patch should go in either way.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--HklZObr7OUXM4dwr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrwiWwJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ3QhWGgE8/MweIJYSRWEgjkmGv1EzF0/A89QFobSFoc/
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAN9zAP40gpRmFO710rgI/HViVC7jCr3n
+Z8qNYWMlqLyKsIIzAD/aHb1BydUWK3jiZUvmfaKrkg0GEHIWAnV5zE0bejvHgw=
=MehV
-----END PGP SIGNATURE-----

--HklZObr7OUXM4dwr--

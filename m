Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793831314;
	b=pxsBTrIN/uS8hL25FJBD0UeNlcDo4Fo8bSWw7AobVwhDRKMLKp61vW3jc20vkEZ0QUF7
	 RB5Wq82dXYkXsH+A7XGK6t9SkygFlGPyBykOtJx4R8xe/+sk/1zDzfZxM4dhZaYW1fY5O
	 18DUH0gW470wzYFsc1iV5HZ50GwQk7JBdLvl+/RoMxrTswTw1+FzFFPb07dEIUQ7aX+vW
	 4jzlfgmOdtizxHoo8F7Jwc89cfMBD5Uh53VqasHhr8tJHhU8yG5I3Nj3NxBvpATe1eqh/
	 G2OY/xQjldbuhKowvXidUlbcZVuXEy8k0i7fSVkDUTYzCvAvCMWAGJAdzFP3D3KmJYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793831314;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=HvWWhI3lGhAiK/FDAF3vIQKsHLgePg6CcH+XL8jR/3g=;
	b=qzHqrHmR24IxUHAr7ShJnrBNOo4srXz1P9IJW/AT88qbUC5KS63ufTGQs8nOThe8dioQ
	 vKxr0gxOcYgB5I6DXs31hV48AJ76dmqb65zNPI1rUSNXJXMlXi0rFTD9MlaR8uTYNOoDg
	 8WMy+N0rBIOJ4NgmurMdME4q+TX/p7v4A1RHGspJj++xffwGRzwtY/pDFRkQZxRnBBM2m
	 ieyU4IOC//fkX4xDu0Ea8OwvKJZaZOr6tvvgYss/9THGXY50WNLNHIIV8d/k2B8figUV0
	 woydFwbZHqUfuLWrXi/U6lEUgZl4bG0u/cbEqrRMpVAAKL0eiJW4ISEAN/b410uxCKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b="UO/RUbi7";
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8047A606B3B0
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 22:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8047A606B3B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=UO/RUbi7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1793831312;
	bh=6lxD/ameqfUbjAJpIdO7tqF18J3jTJxmw7SGb9OmA80=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=UO/RUbi7G4qWTPECJ+ze6OWOj9mnwbkbNYrPZcz0Cufw5LZ/aPD8V1hyuFDvDoqCJ
	 ad6q1fr64khLpRTnoCOEDXRGRwOfkrNDzyMPEdHtAhvXqaUsx4FpafBgguXifMJrTj
	 LZsSAK1eqObGAs6tc4g7m2vx1n6vWThojNFfKuhpEifXZsZLu0KHPyBo7W3JgTtmHp
	 J9U4FtTuefxNEOyJNZAATIF0sYV9FQpJgvXTj4Va14DfAt9CZ28ukGJwv5DQOD6u6A
	 Whu/UuH8SEO9P7BIrJxNto6j6IdTWSewLdRJCIVFP4GBwyzw6c71oplsmjMjnA2+P6
	 7YOlXMNJU2aFXywmPglQEk+YfE4lhA4bmA0e+wZWyK0UJOHGspLdl/F6bzZpbUUsth
	 sXD8D9kd4RZ+G4SZTyQO4knOSH8DJv7US0ghWaotLXIlStz9WXEr774XyYV55yg9HT
	 Es6M8aKWTFaWprAgoze4J73RCK3mlDmr7Qx3OAi7BHvNDkNMfAf
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e583:5f34:4c85:81fa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2B940200A8;
	Wed,  4 Nov 2026 22:28:32 +0000 (UTC)
Date: Wed, 4 Nov 2026 22:28:30 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Tuomas Ahola <taahol@utu.fi>, git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: update the required Perl version
Message-ID: <auuxjhaauAQ7Vtjs@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>,
	git@vger.kernel.org
References: <20261101185846.24208-1-taahol@utu.fi>
 <xmqqjymvooyn.fsf@gitster.g>
 <20261104193450.XvTBf%taahol@utu.fi>
 <xmqq5wyc1iba.fsf@gitster.g>
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
	protocol="application/pgp-signature"; boundary="UULTjyjSpjWJFQPf"
Content-Disposition: inline
In-Reply-To: <xmqq5wyc1iba.fsf@gitster.g>
User-Agent: Mutt/2.4.1 (2026-07-04)

--UULTjyjSpjWJFQPf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-04 at 19:56:57, Junio C Hamano wrote:
> Tuomas Ahola <taahol@utu.fi> writes:
>=20
> > Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> Tuomas Ahola <taahol@utu.fi> writes:
> >>=20
> >> > - - We try to support Perl 5.8.1 and later ("use Perl 5.008001").
> >> > + - We try to support Perl 5.26.0 and later ("use Perl 5.026000").
> >>=20
> >> Is this in line with what 702d8c1f3b did?  Shouldn't we say
> >>=20
> >> > + - We try to support Perl 5.26.0 and later ("require v5.26").
> >>=20
> >> "require v5.26" instead?
> >>=20
> >
> > Frankly, I don't make head nor tail of such Perl minutiae.  I would fin=
d that
> > parenthetical much more useful if it told exactly when we are supposed =
to use
> > such incantations.
>=20
> I do not claim to be intimately familiar, but you can consult the
> commit you cited as the reason why you decided to make this update.
>=20
>     $ git show 702d8c1f3b
>     commit 702d8c1f3b5377a64670b0f22add157b0bfc33dd
>     Author: brian m. carlson <sandals@crustytoothpaste.net>
>     Date:   Wed Oct 23 00:45:59 2024 +0000
>=20
>         Require Perl 5.26.0
>=20
>         Our platform support policy states that we require "versions of
>         ...
>         Use require instead of use to avoid changing the behavior as the =
latter
>         enables features and the former does not.
>=20
>         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>         Signed-off-by: Taylor Blau <me@ttaylorr.com>
>=20
>     ...
>     diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-h=
ighlight/DiffHighlight.pm
>     index 636add6968..3d061bc0b7 100644
>     --- a/contrib/diff-highlight/DiffHighlight.pm
>     +++ b/contrib/diff-highlight/DiffHighlight.pm
>     @@ -1,6 +1,6 @@
>      package DiffHighlight;
>=20
>     -use 5.008001;
>     +require v5.26;
>      use warnings FATAL =3D> 'all';
>      use strict;
>=20
> It looks to me that the "parenthetical" you called was designed to
> be useful by telling you what to have near the top of your Perl
> source files.  Replacing it with "require v5.26" is exactly in line
> with that, I would think.

As mentioned above, you want `require`, not `use`, with Perl versions.
The latter enables the relevant features, which include Unicode strings
as of 5.12, and that will change the behaviour of our code in ways we're
probably not expecting.  That didn't happen in 5.8.1 because features
didn't exist, so the `use` for that version was okay.

You effectively always want `require v5.26` or something equivalent such
as `require 5.026` in our codebase.  The former is nicer to read,
though.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--UULTjyjSpjWJFQPf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrrsY4JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZy7qNj3FUGtPB9T8jd/ge5QBF+GekbnX4mdkxFQu25Xy
FiEECCzmip28ZfuD0cORfAxJYoiHooEAALn3AQDF47uK9lJSKSXkEnuz1iEGdf2E
kiAMPIeXomBJhx3jKgD/TXub9VDGtaxcT4y+D/1HLjzpTeFdL1hknqKdadHPVAI=
=pvkn
-----END PGP SIGNATURE-----

--UULTjyjSpjWJFQPf--

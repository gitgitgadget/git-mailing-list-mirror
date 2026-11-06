Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923390;
	b=sWpCKhZyw0BjXhHyDWN2j4E2vvQBvL8BLlZ7bgxZLac5tYp69PubkAOXleEHq+3i7syK
	 LrdwhePnBh8Li45Jwypph2urRlHimKIsOCiNq+s7aYRkcHjsprMasheUScXHgywbAIZF7
	 hzYqQoTo/2J8p/ZNlhrrmvxlFllYi0Tat1KnqCvG6vQsRbkFUQtcQwAJJMhqqKr2bkLON
	 sQ0F2NsMBC6kkG+n32SaFfKmIuuud96S1B7Sx+ycu2Ey9/Zz+Umlh6I7x7ox9We+gouUF
	 /KIEYyGjMday7DBL+K7wGlU9cIYNdnv8L2Pwp+0FM7ePJ/PgdWzpGUMpKKr6n4xUc0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923390;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=oR9pWeuAioOUkAsay3xEQ77KOK7cFC6oyKRL+/8iZh0=;
	b=0FfoLw/HJra+5FyzXmQk0LT5TB4CWw8IxGDXT+74Eid+MIODR7Hh6QT8JMKAkx2e/FjA
	 9oHJD+uA/YhdzzkqTOo8WBY0nb6vznbpQZU9EOUrVGd2rjPysirjU8nycWvf/X93piFef
	 Mot6L2zAJ5NtGhrJ0C/Eso+FwEdZZ0MxwHg0VdocRppe2M6xNA68nfshOZBze8k2rk9i+
	 U+SeHp2kfuHIR7LclJBK9yRkGQlsIdsPXJcSh2hsL1Vsso0X4r9UtAqSsF0ZJseC+cG7/
	 stRjnhCd7esohtj8sdFjZxDXHifhUuuxNYPTWgvRSAv5iR6DVrhPLBmPnSS3OQmcdnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=m4mNTKKT;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FC6606A31B
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 00:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4FC6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=m4mNTKKT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1793923388;
	bh=PXHs7wtal0ELgk3sVA4TVPmgthemMH+WB6BfZyx0IBM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=m4mNTKKTs5NJz/P5xA1aucGYd7xNwfnJR0BTxJo5xzQlgczrasm6wqpam0pq0XdUR
	 K5VKNZD8mBsfDKWR63FQmEPyVppKlZGtPI5DVShnZUvJWmShWs+GL5yhZpobaQA1CS
	 n/cm9AS63rJIJEH8r/RmYJ1xNbHJkkJ7Fys7v1fSr5LHkgsBby+ZEFp8hPqp8hhIwW
	 Ed6ue7jZjR7V4m1ESohn/cMKKqrp1kOxeOP8KIZ+X+SIYvywzBWSfOjc7X9CgDIyab
	 QiVqIy42JKZkAZrCo9/AO01NDySBcdEW8/2q2SBHJl4AuZDsixEfo7Ye5I+grRgfHA
	 1vIlOsixHhVyy7FFwv5kRrWrt8inP2W5PbUDQDBJixMUOIN7AWciEDL59avLtIL2hV
	 yoTGpgZ5ICEKdgHa0OPPtNWzr54ySRKqxcG26u16oiEBIjuymQZI5LuFUXuEGN8Xv/
	 h84rxx86RGblJSHS3vwEmZD8YVptZRo6zX6VWIw8UZGfdyui9HJ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e965:3ca0:f550:a37e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 740F020069;
	Fri,  6 Nov 2026 00:03:08 +0000 (UTC)
Date: Fri, 6 Nov 2026 00:03:07 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Tanga Joris <tangajoris@gmail.com>
Cc: shrimech <eddinen77@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1] hash: handle invalid algorithms when formatting
 object IDs
Message-ID: <au0ZOsuyo0YYyZsa@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Tanga Joris <tangajoris@gmail.com>, shrimech <eddinen77@gmail.com>,
	git@vger.kernel.org
References: <20261103043756.61627-1-eddinen77@gmail.com>
 <CAKrRMNrLvPck5psPpKX1eWe26To5srfFSLFObZ4zTX09RE551w@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="uZRsbri42iklGvrP"
Content-Disposition: inline
In-Reply-To: <CAKrRMNrLvPck5psPpKX1eWe26To5srfFSLFObZ4zTX09RE551w@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--uZRsbri42iklGvrP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-05 at 14:47:00, Tanga Joris wrote:
> Hello shrimech,
>=20
> Thank you for the patch.
>=20
> I tried it on top of master (0ffa3e35c7). "cargo test" passes, and
> the new test fails without your change to fmt(), so it does catch
> the problem.
>=20
> On Tue, 3 Nov 2026 at 07:42, shrimech <eddinen77@gmail.com> wrote:
> > +            Err(e) =3D> write!(f, ":invalid-hash-algo-{}", e.0),
>=20
> I have one question. In the C code, algo 0 is not treated as an
> error when printing: hash_to_hex_algop_r() in hex.c falls back to
> the default hash ("Our struct object_id has been memset to 0, so
> default to printing using the default hash"). Your test uses algo 0
> as the invalid case, so for algo 0 the Rust output would be
> different from C. Is that intended?

This is not a valid configuration.  I have a patch on my sha256-interop
branch, 5b208e4a3d34ffba0fbeafe991643d6d47a5caa0, that should make the
members not public.  It depends partially on things other in that
series, but it should be fine to drop those pieces if you want to pick
that up and send it in.

If you pass the structure from C, it's intended that it panics if algo
is zero.  That's because we don't want to rely on the behaviour of
depending on a mutable global in Rust, since that's unsafe and leads to
action at a distance.  We really should just drop that fallback and fix
all of the relevant callers at some point.

> brian m. carlson wrote most of src/hash.rs, so I have added him on
> Cc, I hope that is okay:)

Minor nit: I use they/them pronouns.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--uZRsbri42iklGvrP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrtGToJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ4zO2U2FX6pKO17QopteRNmnL4jA/nNtybKHG4OtE7jv
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAGRCAQD7CB3sQ8LWaGK6ShHYPOTVChgp
KpQn1aKdwwxETyyiAAEAr78dQI2vgfREVLwgEQU1jckgt1sT8uLjJTAeZNCcxgE=
=SUyQ
-----END PGP SIGNATURE-----

--uZRsbri42iklGvrP--

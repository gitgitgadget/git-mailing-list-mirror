Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703298;
	b=GJfJB+InyCwgRArFf4BPIzV9u5Qf0XFKs0D6/LPhp2BIHqMXjAAsQ0EOASMymDn7XXtJ
	 LFB8YnGK4wCtllQe6KUKqEcziEJRfcRGOryK1uR6hgGMBicNfRZAOM9nWy0A4Kvz6LOmw
	 l48A5f0oTPzKFy1QLhoaoM0saa2FaQ1F8byXKmMuD736dCb+5wefqNCOo2clg64Lk85Y8
	 t6TfsF7SDn+LQmtZsvSwDFj9VqXQS47XOYX+8wzLc+j/j6hU3Hn3OuVAYsMtrm3OUHOKE
	 1WAPx3SBP2PTplvAcTQ+OkvG5WgbiW2+GLOHc6mgp5Va44Iu0i7CsfD9jFAR0Rcpfag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703298;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=SaF6Dvdu/zijH70cIGqCfIFXuDcrQ9tUjTTiUCW9fLI=;
	b=XJIGLGkznmVFhEwLCyELHHVNUgC59X1hGomxFaiCMN6E1lnq/jaF9hnwqz8ORmpCb6zK
	 IFKKOQClrUEa4qFQYDt8flV/fBb1N5UPv1xgw5flrOsPsWAHJBy53M/zYtxmgJksEmQG3
	 2fbkk86Kpr7+OmwFhfluC+1ujwPwRvpd/7deeM1myrjF7pos0ndTsHmuEn/9k/9TXaOLH
	 E6W+yUgNSH79zP9Qww3RNOZQ5uoTpzJFOHMIxbtFbIuOPG/NLh5UTwzcFg5wl8L7yNdK2
	 xM+6LItMV4H4m3Z7rhpDe9fjDqP2tzBQgDQCQClaKIt4+9olmRXpAsiS32/5dbUiZIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=ds43KF6F;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF52606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 21:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFF52606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=ds43KF6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1792703296;
	bh=gUDEzC5BdqEDOD1BPWGiJtyaumjHbiimsBiTGQ61dPg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ds43KF6FAZzVeUl0oa4QNlnZs/LWRlLeCQo7/J9Ga3OucJHTreQL++VqsyqyslqGJ
	 8oxwDbezuVtlmf9hCrNW/5dFF7DPvWK9CMgCE3qS1I5LPcLSCkHYrdDztXBrmr5dkZ
	 wws8LYkYsi1nvP9cp4LImhybFStctOfv/g/vF9TqPyU6yhdmIlFj3InNY5vtMf+ysG
	 gR1qtGwUtQbZSwkZLkYtnj/kpdEzWrKfEUYtJM4JKVru1z+xVpClPWf22+CuEy/1yI
	 yV5VyNQi4y9W1vYlwowr79dORqwoZJc+1H1Bl2m0CMmJ+fQiCjbih1nPt42xixzH2D
	 DOh14cLe0lhoadBymKVFiAyY33Z6/lRzSCLRGEAlsSOUe8jmSFN5AokZbQSNpTi2q0
	 X42xkCScq8bDzdfMbeYVtPEMH6MfF8l/jEZphPUwHZTqXjyR9SEvg/C0njx9DOlppL
	 2wbTE44+6fxyqlXFPUO7LJdz5r9LMwKgoctxND/whKAk4BPcZzT
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b44d:c6f6:4e4b:66bf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B6FAF2006B;
	Thu, 22 Oct 2026 21:08:16 +0000 (UTC)
Date: Thu, 22 Oct 2026 21:08:15 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC/PATCH] config: honor file permission bits
Message-ID: <atp7Pvtp1rdL8Uj_@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqbj8p7okv.fsf@gitster.g>
 <xmqqpkx1e9iq.fsf@gitster.g>
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
	protocol="application/pgp-signature"; boundary="Ng5psN6Kn2xcPgeM"
Content-Disposition: inline
In-Reply-To: <xmqqpkx1e9iq.fsf@gitster.g>
User-Agent: Mutt/2.4.1 (2026-07-04)

--Ng5psN6Kn2xcPgeM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-22 at 20:59:57, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Because our updates to an existing file almost never makes
> > modifications in place, and instead create a new "lockfile",
> > propagate the permission bits from the original, copy the contents
> > from the original file while tweaking the contents as needed, and
> > then finally rename the lockfile to replace the original file, you
> > cannot "protect" your .global configuration file from accidental
> > clobbering by doing something like this:
> >
> > 	$ chmod a-w $HOME/.gitconfig
> >
> > Of course, if you make your $HOME directory unwritable, it may
> > protect your .gitconfig from getting updated, but that goes totally
> > against the intuition and is not how you would protect a regular
> > file from getting overwritten.
> >
> > Teach the configuration file writing machinery to inspect the
> > permission bits of the original with access(2) and refrain from
> > doing the usual "write a lockfile and replace the original with it"
> > dance ourselves when we shouldn't be able to write it.
> >
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  config.c          | 22 ++++++++++++++++++++++
> >  t/t1300-config.sh | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 52 insertions(+)
>=20
> Hmph, no responses to this RFC.  I somehow find it hard to believe
> that I was the only person who got annoyed by this behaviour [*].

Sorry, I looked but forgot to respond.  It seems sensible to me.

I don't personally make that file read-only, so it doesn't affect me at
all; instead, I just overwrite it with my personal configuration every
time I deploy my dotfiles.  I still think it's a reasonable thing to do
to help those who need it, though.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Ng5psN6Kn2xcPgeM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmraez4JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ1uD6T7PD6J/uZMcfj4RYf/1WuIPuele/Wy4Q2klWWQT
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAOpyAQCEaT0EEM88uz8bMrYVv+Zq7/x1
WOUDIBZd0gfJmz/ulQEAsA9WYzKzfNRlHhKZy1U8C3BO4vrsPP/FTMDpYhTSYg8=
=MHB5
-----END PGP SIGNATURE-----

--Ng5psN6Kn2xcPgeM--

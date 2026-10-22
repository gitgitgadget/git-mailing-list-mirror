Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709467;
	b=Jqwf1kTmm3pLlpJGjMKakpDEfwT91bjZLtv6+76nmkxeBXbZh5UhGV7gKOEFnAt4UmqM
	 zwKEnS8u/Lo5mgrdODQUB8S9bjXI2cW3rM7FNdyCx34oauGwIUOgz7fPoZTGOvxkDI6vZ
	 2OzJeGmdBD5hZzMLDmUR7BRyjoY2WKWjh6oSFVZJEYfnCohFLodLgyUvyhRmWdfx3gosu
	 VoWzbuLNJTaXFZ041Yd96CPq2sePrGNW260QQHpe5y3MG+89jpZPm/dbStCAuAbJnoios
	 U0slm+v1x8tV+pq2gBTaJmVYhIIQME2TyjbJerpIlE2HpLESbdpcLV5DDeN+blym+gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709467;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=zHdo0U00ihwOnZq61hnkc9vfuwwaXAjKMH+XMd2FifE=;
	b=zMEX8OYPrFmdiV1aP9SlLZAD46A2IrplzvKjyCTMFS7dpcb59RKJoLuUo7fTkTiGl1ph
	 MbRGEECuZC+vHOA4XCRWgpW/iTKySsQiLfJdtAf2TUFb4zcyDKykMU4GvXh/fWuTbMPsZ
	 OvqekZXZc0CKOHH57YtUF3HetiOnQq+KCHpCPxDpGhQEHhcJCDMWaP/RRqhGKPVOUg/kX
	 7/pyB0ZnXHNINa4QO2v2rXjNvPE81nMg3QGwcVxNa7dqfWkLS5eq7G2I4nh0cRmus4oMl
	 rcJia0Ge5Gcj4tWNtJGjUUarqI5c4UNUSld1inGoe4PVvMW898JgYNfKckUksRPoHVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=BcOu0kCn;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5515C60A2605
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 22:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5515C60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=BcOu0kCn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1792709465;
	bh=K4IgBBGTvaQ0vluIVTDFHSmBmhqngSyYjIZJHYtTI8w=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=BcOu0kCnR/3F/xwFRRMu37YLjnLSVHoBSfe6NXxYFVKW6Gf1OYZJi9/Q2PNdTUxSY
	 nDJ3y7Xu9QsJCEFz2t2+Fe+sHcceT5WNXbufkKOyDmSU+l2XglShoVc40FNhg09Gda
	 hvn+BYIJ2zHCYGnFBrtpfG99cP12nT91jBCT5XO4VGleyU17ixJiamIUGjwjVbGPfV
	 GrPMqI8M3gPfnaZawNy9NK2PBWO2VcMbXJztJN4Mz9+uqG+jU0qw5ZLN1IsMjv4nVf
	 06LNor4fkDBvFbz2Wu2paR1qzBJWh8u+nnpclFb2nw3Pu5B1UpYLCyP+S2ARBlzV3J
	 cBL4AGyADixG5XXtNDUW/Qk0AsXB1xnjTWp278EheA5dqdsfwNNSlRzjVvhwhA1akY
	 KjKQ/EViIeWRd3zOo1qxdAJTqxgdZnfDUBWYjGuoPKKWUvlRp4AFfB9BK/TMjxCYbl
	 996czIm+moT0WBAGvkrAqUDLdTWULYsrIQ0xy2H2khEKBgkNMSh
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b44d:c6f6:4e4b:66bf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5632C2006B;
	Thu, 22 Oct 2026 22:51:05 +0000 (UTC)
Date: Thu, 22 Oct 2026 22:51:04 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] Documentation: propose community voting process
Message-ID: <atqTWKaRQfvH0Xbm@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20261021200341.378978-1-emilyshaffer@google.com>
 <3fe1dc57-5bb2-4e12-8876-a4969e5201cb@app.fastmail.com>
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
	protocol="application/pgp-signature"; boundary="nTMr4xys6uYVOVQM"
Content-Disposition: inline
In-Reply-To: <3fe1dc57-5bb2-4e12-8876-a4969e5201cb@app.fastmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--nTMr4xys6uYVOVQM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-22 at 07:29:26, Kristoffer Haugsbakk wrote:
> On Wed, Oct 21, 2026, at 22:03, Emily Shaffer wrote:
> > As we discussed in the Contributor Summit this past September[1], there=
's
> > interest in taking a formal community vote to decide whether and how to=
 accept
> > AI contributions. The topic is of course a very contentious one, and I =
don't
> > think that we're going to come to general consensus the way we have on =
most
> > other concerns in the past.
>=20
> The vote will pass. Those who work on Git at least once a month work for
> tech companies. Those tech companies are now AI companies. The votes
> will happen to drift towards agreement with their management.

I do usually work on Git at least once a month and I do work for a tech
company, although I sent my first patch while I was in university.
Despite what some people might believe, I don't parrot my employer's
company line from my personal account.  Even when I'm speaking for my
employer, I don't speak in ways that I don't personally believe in
because I'm a person of integrity.  To the contrary, I think most people
who know me know that I'm a person who calls it as they see it.

I think anyone who was at the Contributor Summit or has read my emails
to the list knows how I feel about LLMs and how I vote as a contributor
will not be influenced by my employer.  I do think, though, that this is
a reason that votes should be secret because that prevents people from
having to prove their votes to others.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--nTMr4xys6uYVOVQM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmrak1gJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ9ttipUCR1tk6aF+whXIaoaYe2mRNYRTannz1Echnq1S
FiEECCzmip28ZfuD0cORfAxJYoiHooEAALEtAP4w3rAoBQKja19djhscjMZIBEFp
mUjJ/IW+L7i6b7xpFwEAncLQW/4cTPPvWv6q870FGa61JYYGm980qLSyzdLD4gM=
=DrMx
-----END PGP SIGNATURE-----

--nTMr4xys6uYVOVQM--

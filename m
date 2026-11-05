Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917981;
	b=iMR2ddL0ur3u6pkDPIPhtuXbyKNmbH79fSqzl5bkmx5D7z/R675pRUm3D2C/SabXVmWk
	 A5LBoa0uAQzsSltdg0YnTl2uzd7YqsPCXBLto6j4M7zsduZKn4GsWjyCk98ZVHyWRx6WO
	 +4RYwZI2Fzp0ipF2ZSreSj+oKIQXAH9/X5eDYgXHmAtUyzFZwgjwKCha7XbdH2lS4wMlP
	 XuCVOLrww0BJjjW8jKkSlD0S90wCTWMniQMxJuuXOIrT8Zy36SF2lh2YbZhSFSSocrqUn
	 yFbwTCD2PprP8X4UoFllGro9bp7J6ftNmcN7KFrxGV4e5wt7pQjUHWL6byE3Dr8U2rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917981;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=ud9cB0Lc5pB6H00qNAuhu0Jec5NgnYGIND5YF35BjMw=;
	b=jqiRL97QmSvg44b2R7UK7grZOZqcTE+1BliPV9n1YST7gcFwZvmY5b3GeR/azkZ6lVJ8
	 Ymbb+beTmnwnNZX2/8fU01ARiZHTbthvjfRkw4s1zUTcRFdCkdw5pQBaAxh5egNsw2M8N
	 CKkR+GFzl3g2NudPQaAv3L5PtySyPOLcGTQO8bntscEb6ewLww61cfMOZXKz0XPKiberT
	 5d1spESurK7Kv+kroJTwzMKOtaspaSN6k90OlA5S+6GYuAKep0vZ9vno1n0aWW9gfT2SF
	 L8y/0Q5HQMaLEARFC4OmjJyIwpSvYZb+0nj2M/RtS+Wvxu9Fv/5CQlm4lZxvq4rIyfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b="hLQT/JUl";
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3073A606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 22:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3073A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=hLQT/JUl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1793917973;
	bh=RJdFnxu0F9Z/8/fFb2DcRyE8v9iIewO3+AF+VufjnSw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=hLQT/JUlDMNmQNcEKsn+PB3+gHBA989UDNUMWrrf2r9czncP1F+gwLE9ejvTgqoYz
	 cTxnJ5yxgkWI22dObZWo9q5RUiqKdhu5tKC3p6X7kztGOaBESs+z29MoevysVp0mVE
	 Pn+lEoDDJJOQ92P+150ge3gDMrZ+oMpIipozWo3K7OfljUzwMOrWZ78eCfBbkPeEVB
	 V9i/lAutiH6ZrckhM7GH/TfYfNUZozzYcXyt0ikbYeiLI6DkcrCdZErke0pB+VSKk2
	 4lfTPtk77Nr0sROjjdOf7IPPO6QMWjFO9KImYPZq/b+cgX8osNh1h/VUWcHtxNyS8W
	 MRVDsYsWD29Bzy+W+OhXyYKg5RhHA09waS0BUJYvraCt6jnR/KNYWpldJIqARePkzk
	 qEI67RdKoOIvrICmDtUecq433jhXx0kOWXi/0GZEkIG5sg8reiQ337VMtjMEhdVpw+
	 sgMqXlKeYGxLsc3kgg2BfSsni22IBnrbGy+uhOU7HZyZIgtzZ8T
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e965:3ca0:f550:a37e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A76BA20069;
	Thu,  5 Nov 2026 22:32:53 +0000 (UTC)
Date: Thu, 5 Nov 2026 22:32:52 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ravi Mistry <rmistry@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/4] http: add exponential backoff without Retry-After
Message-ID: <au0EE96afsApvfZM@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ravi Mistry <rmistry@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
	Patrick Steinhardt <ps@pks.im>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v2.git.1793732247.gitgitgadget@gmail.com>
 <fe1e847dede7579da911b5a9ba16c806b5332723.1793732247.git.gitgitgadget@gmail.com>
 <auusPUaYRmUBDsdI@fruit.crustytoothpaste.net>
 <CAF+mdifcp+qkESZzd=8SmrL6eckxAQXR-4nxxSuL=xCV48OhVQ@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="+Q6zDRKNsLLUhIsW"
Content-Disposition: inline
In-Reply-To: <CAF+mdifcp+qkESZzd=8SmrL6eckxAQXR-4nxxSuL=xCV48OhVQ@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--+Q6zDRKNsLLUhIsW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-05 at 00:10:10, Ravi Mistry wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > We should not immediately retry on a 429 response, even if that's the
> > behaviour we have now.  The server told us we were being too aggressive,
> > so the exact thing we should not do is to continue making requests.  As
> > a server operator, I definitely don't want this behaviour; instead, we
> > should pick something sensible if no Retry-After is given, such as 30
> > seconds.
>=20
> Makes sense. Junio noted on v1 as well that defaulting http.retryAfter
> to 0 does not mesh well with exponential backoff.
>=20
> What do you think about defaulting http.retryAfter to 1 second, matching
> curl's --retry behavior (1s, 2s, 4s, ...)? Because the delay doubles on
> each attempt (and Patch 3/4 also reuses http.retryAfter for opt-in
> transient 5xx retries), starting at 30s would turn 3 retries into 30s,
> 60s, and 120s. Starting at 1s avoids hammering the server immediately
> while ramping up on repeated failures.

I can't imagine a situation where 1s is a reasonable backoff for a 429
response since I can't imagine how the load could reasonably decrease in
that amount of time.  I suggested 30 seconds because that's a reasonable
amount of time to back off and allow load to go down (and I think that
30, 60, and 120 seconds is a reasonable set of timeframes), but I'd say
it should be at the very least 10 seconds.  I've seen cases where users
retry very aggressively and it increases the load on the server so they
just get rate-limited way, way more than if they'd been more gentle and
waited a little bit longer.

Note that the curl binary often makes very cheap requests, such as
static pages or small files, but we are making what are almost certainly
very expensive requests requiring a substantial amount of server
computation, so the curl defaults are almost certainly not right here.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--+Q6zDRKNsLLUhIsW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrtBBMJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ0U6h02lCf/FSbTajAb/O+upkNQQapXSnSyIZ8eMEOF2
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAK5UAQDL7kgJz6Jx9vlg0xZzZh2fv3Aj
mglAd5w9zUAi5np4BgEAhAf5ow1S9bSbGWgTu6DyNn0nYot1xAJWfy3Q4hXmjgw=
=EoA6
-----END PGP SIGNATURE-----

--+Q6zDRKNsLLUhIsW--

Received: from mx.freebitcoin.gay (mx.freebitcoin.gay [92.65.121.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17612ECE87
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.65.121.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766347; cv=none; b=D2v73FJoWseBYYXSTCAJRuu2Sy2gn5XteINZafKgg7gjGBQmWoh79O9MCsVp/Qi4zHEKunMSqtsjWSZc6tpIhgNl3tI2mw3SRCg07YaYK8AtDl446ZwHV/KF9G4SsFirJj+qncNBNtG7HV2iaQwxQIm1fzVpCc3L0GBpUErSBNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766347; c=relaxed/simple;
	bh=Vw7AGpEj3eKUflku3QAb1uh1PtCMCLzi9eH8qrSBwyw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Sh8O53E74AB5x6wz1nOlWnts0RfNp3HFKeX9PsyKG5/3YGbCOYA4QckkQ6lhJLamFi9+AMhyQCuNtVi4drT9eLJIdZoRnR530ihV4khjwsgqlzeKWPKEZeDfPNzYWt5PKNEcsnDSYBwE18Bfuol+Ey94b+LsOuWHmcmsLzLivAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org; spf=pass smtp.mailfrom=ddevault.org; dkim=pass (1024-bit key) header.d=ddevault.org header.i=@ddevault.org header.b=gRUjpCtv; arc=none smtp.client-ip=92.65.121.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddevault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddevault.org header.i=@ddevault.org header.b="gRUjpCtv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddevault.org;
	s=_bikeshed; t=1755766267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8LavPImY2zBxHCoPZLTev9dxQXdh9ThWkVmS1pZJ4I=;
	b=gRUjpCtv3+8YfhMPfD2KRpqTUNMjI4GiuJNGzHGLt/nnA+ReESgkDNplfzkl8xbkk3BPb+
	zDuhlhB3iAP5Svx0YadRfOQWy2EYmjCr8FPt0cLe4kWaPgj8hFI+bXlsS3sFLDSc1fsRhx
	Ajj5KmeII9M+d7lCzopWgfHJRriVT5A=
Received: from taiga (mx.freebitcoin.gay [92.65.121.143])
	by mail.freebitcoin.gay (OpenSMTPD) with ESMTPSA id 36d022d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Aug 2025 10:51:07 +0200 (CEST)
Received: by taiga (Postfix, from userid 1000)
	id 6E50B70206FB; Thu, 21 Aug 2025 10:52:16 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e89601a6e9be5fbae7e1277c8481bf1fb8de6343330e56ebdf72728cebb5;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 21 Aug 2025 10:52:14 +0200
Message-Id: <DC7Z7YVT66NC.3RUJ7HXX2HSLW@ddevault.org>
Cc: "Remo Senekowitsch" <remo@buenzli.dev>, <git@vger.kernel.org>, "Martin
 von Zweigbergk" <martinvonz@google.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Andy Koppe" <andy.koppe@gmail.com>
Subject: Re: [PATCH v2 1/2] pretty: add X-Change-ID to mail formats
From: "Drew DeVault" <drew@ddevault.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc 0.20.1-112-gd31995f1e20b-dirty
References: <20250703113505.11889-1-drew@ddevault.org>
 <DC6LB8FINRXH.1TMZPB1XKPQWQ@buenzli.dev>
 <DC72UF1IMIUF.2F7CNYOHYDGVJ@ddevault.org> <xmqq4iu17b1y.fsf@gitster.g>
In-Reply-To: <xmqq4iu17b1y.fsf@gitster.g>

--e89601a6e9be5fbae7e1277c8481bf1fb8de6343330e56ebdf72728cebb5
Content-Type: multipart/mixed;
 boundary=ddabda2fd67ae83b1f589606720c1f0797fdb443b738efdda5d01391b015

--ddabda2fd67ae83b1f589606720c1f0797fdb443b738efdda5d01391b015
Content-Type: multipart/alternative;
 boundary=bc46b4a07fc0d2da5a281fd14abcca183988d340138f8ce1fa0a33d0e8db

--bc46b4a07fc0d2da5a281fd14abcca183988d340138f8ce1fa0a33d0e8db
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Thu Aug 21, 2025 at 2:50 AM CEST, Junio C Hamano wrote:
> For a topic that is older than 6 weeks, I am afraid that is a losing
> strategy.  People who might have cared about the topic said all they
> wanted to say, new people are less likely to discover the topic than
> it was fresh, and unless you make an action (e.g., posting the "next
> patch version" you mentioned in [*1*]), it is highly unlikely for
> anything to happen while you are passive.  Even a small update that
> addresses all the little feedback would serve as a "ping" to reignite
> interests.
>
> You seem to have liked the approach to generalize and encode all the
> commit object headers (except for of course the object name and
> author and committer ident, which already have place to be in the
> format-patch output) on an e-mail header in [*2*].  That should be
> sufficient for a small update that tries to reignite interests.

Oh, of course. For some reason I had had the notion that I had already
written a v3 based on this feedback and it was awaiting further
comments. But in fact I have done no such thing. I'll put this back on
my todo list and get a v3 out in the foreseeable future.

--bc46b4a07fc0d2da5a281fd14abcca183988d340138f8ce1fa0a33d0e8db--

--ddabda2fd67ae83b1f589606720c1f0797fdb443b738efdda5d01391b015
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=42F3F1862E3CC4B8.asc
Content-Type: application/pgp-keys; charset=UTF-8

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptRE1FWjdZOWt4WUpLd1lCQkFI
YVJ3OEJBUWRBL3BQeTZYK25OTDVUMlFhSktFTTA4eE4vS3o3d0ZUQVpvSDVZCnJpVjl4MW0wSUVS
eVpYY2dSR1ZXWVhWc2RDQThaSEpsZDBCa1pHVjJZWFZzZEM1dmNtYytpSk1FRXhZS0FEc0MKR3dN
RkN3a0lCd0lDSWdJR0ZRb0pDQXNDQkJZQ0F3RUNIZ2NDRjRBV0lRU2Z0ZWMzM0NXeW5ZN3NScEZD
OC9HRwpManpFdUFVQ1o3WTl3d0FLQ1JCQzgvR0dManpFdU1FRUFQOURIKzFMZ3ZUcVpETFo4YmFi
QjVDZHA1eTBaVytRClR4NzhtaDFMOGpKZDZnRUFzc21nc0ltY3JadjRhZFAyVVc1UlU1QkhDZTlL
VWR4MER5VjgzUXdsRkFTNE9BUm4KdGoyVEVnb3JCZ0VFQVpkVkFRVUJBUWRBR0FIOWRsYUNPTm9Y
cG1RZ0hvUWdZSTJ0UytWTTNtelU4STJQeVZZUQoxR1VEQVFnSGlIZ0VHQllLQUNBQ0d3d1dJUVNm
dGVjMzNDV3luWTdzUnBGQzgvR0dManpFdUFVQ1o3WTkxZ0FLCkNSQkM4L0dHTGp6RXVIY25BUDR5
ak9pTTB5cWtTVDZ5WHpEVVd6ZTdCOUltMjRGOEhWeCt3TnFjRGFEdGNBRC8KZktRaHowU0NQaWJs
TzZsYzdNRlV2bGFPejJ2ODdVcFVZUmh6UGRnUXF3az0KPWVtcmIKLS0tLS1FTkQgUEdQIFBVQkxJ
QyBLRVkgQkxPQ0stLS0tLQo=
--ddabda2fd67ae83b1f589606720c1f0797fdb443b738efdda5d01391b015--

--e89601a6e9be5fbae7e1277c8481bf1fb8de6343330e56ebdf72728cebb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSftec33CWynY7sRpFC8/GGLjzEuAUCaKbePgAKCRBC8/GGLjzE
uB2cAQCWt5DjdXg7LeUchMQkAe/ID8JIuEJ2dHYbYPBnXH7ZQgD+PKSNmeGQvbvX
3UwHiZIzYe+RTQyNJkQoQHKnqPgT/AI=
=RGSn
-----END PGP SIGNATURE-----

--e89601a6e9be5fbae7e1277c8481bf1fb8de6343330e56ebdf72728cebb5--

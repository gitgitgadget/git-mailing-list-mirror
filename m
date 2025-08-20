Received: from mx.freebitcoin.gay (mx.freebitcoin.gay [92.65.121.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CE82D3A77
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.65.121.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755675402; cv=none; b=V7+lV8SptLZoB9KZJbDZxKHVMq7VKS0Vcedm6MwuToIB/0oKmCQsc81RLcMVGmu7M9XS485WyC5jvJlSFFPR1t9e+t0mauP1dYA3xAvYhWib1PSz6Y2MmEQfpu5Bdn7Erjj1w/NuXtLuchfZqxorE0IQ/B7i3+jB6eB4+uBXlpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755675402; c=relaxed/simple;
	bh=7lOqvzuUMCDbeb+fJ/VGqMtuXTO1ix2CCHvOFoSG1+Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ffDljP9/SNbRIHz/HEp3v1LbNUiEwQcfkAsLZoQRuHvl2+0d2fQqTv6G0KZA3ZR3BxRuSWjZ0unMIvYyAzdXnXdZU121SOJdm9CuYAT+GZI2dPTDhXYP1hspM2PMxxbF7nHyvohHSNBvSuRK+i4x7eNbjk1vxOiJzOh6ptdkmjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org; spf=pass smtp.mailfrom=ddevault.org; dkim=pass (1024-bit key) header.d=ddevault.org header.i=@ddevault.org header.b=uK/yxG57; arc=none smtp.client-ip=92.65.121.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddevault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddevault.org header.i=@ddevault.org header.b="uK/yxG57"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddevault.org;
	s=_bikeshed; t=1755674931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7lOqvzuUMCDbeb+fJ/VGqMtuXTO1ix2CCHvOFoSG1+Q=;
	b=uK/yxG574cSLu8zkzxElbBhWW7odMepVxF/9LBhoO597/2P2O+PhE5dqGk+SHcXAI7F3D9
	zEiAYNBpG09M40E0tnvW2ZdnVpKXMfYSGakQ8stZJVD5G4qEmAIhENvG3CiqQnZSAxmzlN
	Kq5t53nGBuToZfFegtDypPB5ykMcU0E=
Received: from taiga (mx.freebitcoin.gay [92.65.121.143])
	by mail.freebitcoin.gay (OpenSMTPD) with ESMTPSA id 002cabcd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Aug 2025 09:28:51 +0200 (CEST)
Received: by taiga (Postfix, from userid 1000)
	id 0120B70206FA; Wed, 20 Aug 2025 09:29:58 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=4d7559904e8f1420b0822895ca466becdbb12f2236cafa72b1bd907bfe9d;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 20 Aug 2025 09:29:56 +0200
Message-Id: <DC72UF1IMIUF.2F7CNYOHYDGVJ@ddevault.org>
Cc: "Martin von Zweigbergk" <martinvonz@google.com>, "Patrick Steinhardt"
 <ps@pks.im>, "Andy Koppe" <andy.koppe@gmail.com>
Subject: Re: [PATCH v2 1/2] pretty: add X-Change-ID to mail formats
From: "Drew DeVault" <drew@ddevault.org>
To: "Remo Senekowitsch" <remo@buenzli.dev>, <git@vger.kernel.org>
X-Mailer: aerc 0.20.1-112-gd31995f1e20b-dirty
References: <20250703113505.11889-1-drew@ddevault.org>
 <DC6LB8FINRXH.1TMZPB1XKPQWQ@buenzli.dev>
In-Reply-To: <DC6LB8FINRXH.1TMZPB1XKPQWQ@buenzli.dev>

--4d7559904e8f1420b0822895ca466becdbb12f2236cafa72b1bd907bfe9d
Content-Type: multipart/mixed;
 boundary=a3b0d04151a771ac6405898e0bf777c852151c2b11446527b9564f084455

--a3b0d04151a771ac6405898e0bf777c852151c2b11446527b9564f084455
Content-Type: multipart/alternative;
 boundary=1b110bd2c0228ce158e06a047eaf3b394e1409c9f7c0afd30957a7c09dce

--1b110bd2c0228ce158e06a047eaf3b394e1409c9f7c0afd30957a7c09dce
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

Hey Remo! I haven't gotten much actionable feedback on this patch yet,
so there's not much to do here but wait for more reviewers.

--1b110bd2c0228ce158e06a047eaf3b394e1409c9f7c0afd30957a7c09dce--

--a3b0d04151a771ac6405898e0bf777c852151c2b11446527b9564f084455
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
--a3b0d04151a771ac6405898e0bf777c852151c2b11446527b9564f084455--

--4d7559904e8f1420b0822895ca466becdbb12f2236cafa72b1bd907bfe9d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSftec33CWynY7sRpFC8/GGLjzEuAUCaKV5dAAKCRBC8/GGLjzE
uLFjAPsHESbjt0bAoodY8u3qP2IBqYOTzj5petRNj2pSM0G35QEAsGAuujPNucM2
0dWma9+S0ZBY+5d3yvv1DGRhv9AT9AY=
=8ENb
-----END PGP SIGNATURE-----

--4d7559904e8f1420b0822895ca466becdbb12f2236cafa72b1bd907bfe9d--

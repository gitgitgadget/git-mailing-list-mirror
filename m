Received: from mx1.ddevault.org (mx1.ddevault.org [172.233.46.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3D22DE713
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.233.46.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542370; cv=none; b=DNOVpgoJ+w+cb4xfyXtNlxUjhM/kg+ryfgHwxF9JiYt8aW9/S1pbmGwTbllWL5cKFsi7yZZwczUZK02Hvj/raSzQl2k3jLrWHbt8+FLndWfnA+pXVBkV8pgLTPVbbKTvTfsJFSpQJK/m5MjiyTSwXGvHvHVrQY0rrk6xSP+AD7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542370; c=relaxed/simple;
	bh=3Ld9HzSDoc9T9KvqZXFcansKJm0NRH/eMJbyVZgshpE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=iv2B/hpV9HrhJYDamXJlh7BS+QaxrAE9rtZoXY/uyepAU8kAsAK1xNjpraJa61c6UpGs4IqsJKY0J552UQGRg3OfRX0OZX7iW7HqTeQBT41Utk07E3v92fbKD+u7uNSZeu3b1Nbzp2gahU/Y4ldeSbkmemB5d/H2fD86jtKzxCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org; spf=pass smtp.mailfrom=ddevault.org; dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b=mbt3fRmL; arc=none smtp.client-ip=172.233.46.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddevault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b="mbt3fRmL"
DKIM-Signature: a=rsa-sha256; bh=Hf7FzL7zWH5+weZQPFdci8mkBMWHI9jqfAAdbthwZa0=;
 c=relaxed/relaxed; d=ddevault.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@ddevault.org; s=default; t=1751542354; v=1; x=1751974354;
 b=mbt3fRmLelo+m1VYR2srNZK25/o0He5rIDiLAly4YDAmjzVx7kbMRBEnZ7MN9WHmDJTNKaqp
 RPCTldh6xSIaFOEgKi+r2fAydXrFldwUPyRoEftT2aouIqqoCVBwz1lr1c9hMFKlHXmFc4f45cC
 5YEyl8EzdeoxQTm+pBSD92qKnMlzFegpfDDWDDSkbMksNCSSjikFrpwdG3GQq0TVSS8RcELmcqf
 SOA4g4l91YmaHv2WonViPJeJfMf5MwueGJMd/sqQWPlO7MQ1MVoTTwxuIqaSdHKCZmME2TXPfZO
 lltUUCTa0CMEZUiEck8kSdiCYKKc6adjc+renmduRVQOw==
Received: by mx1.ddevault.org (envelope-sender <drew@ddevault.org>) with
 ESMTPS id fb85823c; Thu, 03 Jul 2025 11:32:34 +0000
Received: by taiga (Postfix, from userid 1000)
	id E88C570206F2; Thu, 03 Jul 2025 13:32:33 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=0982028c20807ea899dd30facff606491b03d695ed11ead847147a8b48c4;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 03 Jul 2025 13:32:32 +0200
Message-Id: <DB2DY0C84G1R.3V7LEG87PHVTW@ddevault.org>
From: "Drew DeVault" <drew@ddevault.org>
To: "Remo Senekowitsch" <remo@buenzli.dev>, <git@vger.kernel.org>
Cc: "Martin von Zweigbergk" <martinvonz@google.com>, "Patrick Steinhardt"
 <ps@pks.im>, "Andy Koppe" <andy.koppe@gmail.com>
Subject: Re: [PATCH] pretty: add X-Change-ID to mail formats
X-Mailer: aerc 0.20.1-64-g7cb8e0e7ce24-dirty
References: <20250703074952.20737-1-drew@ddevault.org>
 <DB2AARC4OKR3.48T4CC70KBUC@buenzli.dev>
In-Reply-To: <DB2AARC4OKR3.48T4CC70KBUC@buenzli.dev>

--0982028c20807ea899dd30facff606491b03d695ed11ead847147a8b48c4
Content-Type: multipart/mixed;
 boundary=6aaf8d81ae687041dc51923b5f57e97b2e34749650471f6ab78c42f434e9

--6aaf8d81ae687041dc51923b5f57e97b2e34749650471f6ab78c42f434e9
Content-Type: multipart/alternative;
 boundary=403cd526ec265ad1bfd61eef0c26f7cf5a2e2c95d56df67ce508497467e3

--403cd526ec265ad1bfd61eef0c26f7cf5a2e2c95d56df67ce508497467e3
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

Sweet! I'm going to send a follow-up with git-am support.

On Thu Jul 3, 2025 at 10:41 AM CEST, Remo Senekowitsch wrote:
> This can kind of be tested already. Because Jujutsu already writes the
> change-id header and sends it via git push, it must also be able to
> import those headers from commits it hasn't seen before. Possible steps
> to verify this behavior:
>
> * Create a repo with Jujutsu, make some commits, push them to a remote.
>   (can be one on the local file system)
>
> * Clone this repo via Git.
>
> * (optional) Confirm with `git cat-file -p @` that the change-id header
>   was preserved.
>
> * Run `jj git init --colocate .` to upgrade the git repo to a jj repo.
>
> * Run `jj log` and observe that Jujutsu correctly imported the change-id
>   headers of existing commits it didn't know about previously.

I can confirm all of this works with the v2 I'm about to send, though I
have ascertained as much through a manual testing procedure that
resembles your recommendation here.

One thing I'm less certain about is how to expand the tests in t/ to
test this behavior. I'll elaborate in the timely commentary of v2.

--403cd526ec265ad1bfd61eef0c26f7cf5a2e2c95d56df67ce508497467e3--

--6aaf8d81ae687041dc51923b5f57e97b2e34749650471f6ab78c42f434e9
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
--6aaf8d81ae687041dc51923b5f57e97b2e34749650471f6ab78c42f434e9--

--0982028c20807ea899dd30facff606491b03d695ed11ead847147a8b48c4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSftec33CWynY7sRpFC8/GGLjzEuAUCaGZqUAAKCRBC8/GGLjzE
uO5HAP9GuFiIolWSsZM8olUMiN6D3/fShYRqREsStjf/AJeFLAD/cYXL+ZOZrdUE
RZVUs9kDwUEk2zBDgpTypKJ5vVUSRwQ=
=AyXk
-----END PGP SIGNATURE-----

--0982028c20807ea899dd30facff606491b03d695ed11ead847147a8b48c4--

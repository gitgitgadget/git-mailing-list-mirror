Received: from mx1.ddevault.org (mx1.ddevault.org [172.233.46.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5A82AE96
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.233.46.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751798772; cv=none; b=SRfhd7y0GtELUbeO18HPBkh9BaYv+PMf6llP1+38NhP6zK+2wgxx/RJ0hDBqNpKaFj17nMZJ9YgYgLGcG32gAKy7EwRGnYLYG+NYDZf5gDPoYcAnpafumVUtQHpciMRT+i3RC0EXWE0Hgchj+a8qEcEx8CtO9TWOpCX4LLhaPw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751798772; c=relaxed/simple;
	bh=4M5wpqS/4cFzqOpdYBgFXcniiBJSYOm6DBFCaJy8NbQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GywpAf6drn/f60Chfu9iV5ou49JX1g+h0H40VcjBo7/MMF0le7ThSpgrtnujj/8JW5W3EziwMpoFv49H66MPsrL0FPMnrj2k3uQnLkGFaLZbvPzeEf54p2LhfNMLLiNOYTDg4Z5i+iMPnQItyhtt49SHthqEyQiWj/4Yj7jWNIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org; spf=pass smtp.mailfrom=ddevault.org; dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b=qo2W8KXs; arc=none smtp.client-ip=172.233.46.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddevault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b="qo2W8KXs"
DKIM-Signature: a=rsa-sha256; bh=rY4XUiv8FdfuFeGcMfDNOzn4y971IkR/j8xg4ssltPk=;
 c=relaxed/relaxed; d=ddevault.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@ddevault.org; s=default; t=1751798761; v=1; x=1752230761;
 b=qo2W8KXsdemgNq69qaBasWc5Apei8C337bzyxT2yMIrcjWudgGaF+bsHZNO+8u916G97WfLW
 oIv+agT3UqS9K7gMllnp+/rMyrsUYQsIILSA4bWVCKi9jL/MM0AGSFkwY3yRqi77xxlQWb7xMoo
 wdP6O/zOdB+1uvXOCQ6udeC7JOnGDIFSLOGLEGLpXMAU7u/LRj5AWm1iXQkBK3tgeSr5MfLszkk
 vLkkxeAYZyB+95HxklAZrOHXGfspwePyVBvQ6U+8hDr+5WBFgYqAv4UUO2d7tpgdP4/QqqWIAiv
 KPVDI7QLMPH0++nPSmEl3MIhiLvGMFo9QVcOoZ1mH6fMA==
Received: by mx1.ddevault.org (envelope-sender <drew@ddevault.org>) with
 ESMTPS id 817528aa; Sun, 06 Jul 2025 10:46:01 +0000
Received: by taiga (Postfix, from userid 1000)
	id 8F47770206F2; Sun, 06 Jul 2025 12:46:01 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=a82e25d280c2b3ae2309f42d7a6f94296c1826afd694336e902bf54a89d5;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sun, 06 Jul 2025 12:46:01 +0200
Message-Id: <DB4WU136IYR2.3ELSGQUDD6QI8@ddevault.org>
Cc: <git@vger.kernel.org>, "Martin von Zweigbergk" <martinvonz@google.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Andy Koppe" <andy.koppe@gmail.com>,
 "Remo Senekowitsch" <remo@buenzli.dev>
Subject: Re: [PATCH v2 1/2] pretty: add X-Change-ID to mail formats
From: "Drew DeVault" <drew@ddevault.org>
To: "Jeff King" <peff@peff.net>
X-Mailer: aerc 0.20.1-64-g7cb8e0e7ce24-dirty
References: <20250703113505.11889-1-drew@ddevault.org>
 <20250706033710.GD3041790@coredump.intra.peff.net>
In-Reply-To: <20250706033710.GD3041790@coredump.intra.peff.net>

--a82e25d280c2b3ae2309f42d7a6f94296c1826afd694336e902bf54a89d5
Content-Type: multipart/mixed;
 boundary=5b89b8496594fbc05976d7877394613c9b2ed6c58a9c3d1579010b499deb

--5b89b8496594fbc05976d7877394613c9b2ed6c58a9c3d1579010b499deb
Content-Type: multipart/alternative;
 boundary=dbeade6e4ab5cfd93fd7b2891cb93126ee0ab535043852bb05e85768fbc8

--dbeade6e4ab5cfd93fd7b2891cb93126ee0ab535043852bb05e85768fbc8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Sun Jul 6, 2025 at 5:37 AM CEST, Jeff King wrote:
> I don't have any opinion on the feature itself, but the plumbing way to
> do it would perhaps be:
>
>   # make some vanilla commit...
>   git commit -m foo &&
>
>   # make a new variant with the change id
>   commit=3D$(
>     git cat-file commit HEAD |
>     perl -lpe 'print "change-id foo" unless length' |
>     git hash-object -w --stdin -t commit
>   ) &&
>
>   # replace the old one
>   git update-ref HEAD $commit

Thanks! I'll incorporate this into the tests in the next patch version
after some further discussion.

--dbeade6e4ab5cfd93fd7b2891cb93126ee0ab535043852bb05e85768fbc8--

--5b89b8496594fbc05976d7877394613c9b2ed6c58a9c3d1579010b499deb
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
--5b89b8496594fbc05976d7877394613c9b2ed6c58a9c3d1579010b499deb--

--a82e25d280c2b3ae2309f42d7a6f94296c1826afd694336e902bf54a89d5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSftec33CWynY7sRpFC8/GGLjzEuAUCaGpT6QAKCRBC8/GGLjzE
uJpqAQCYEeC+ZBapFuDoU/5Ef9m+XkbkchOQuL02uv4SccLbagEApzndjJ2DznOv
sYoxTcWaN/r/aYcSNWmAGjkvmgX7mAo=
=1Ci4
-----END PGP SIGNATURE-----

--a82e25d280c2b3ae2309f42d7a6f94296c1826afd694336e902bf54a89d5--

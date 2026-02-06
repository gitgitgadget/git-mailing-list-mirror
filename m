Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612533451B0
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770364205; cv=none; b=iW2+I6396a5MOPFVkO4a/hz8MaHRBRPERwM5TlqEzc8zMb8LS/T6O9eeXt7Rc6K0qHQmmQvM7WOteUMVbgWUeI/OR/mgKFdwkDlQbVpUxV7DuoJfdqY6B6Cg5FaAnR1XaAlrZXC+XUI/8SqpWsCcz+pN6PNlqBqudeVzXjds0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770364205; c=relaxed/simple;
	bh=gzpYlT1YQkzhZ3dj9WvxVrrZH3Gbat+9FS01Q0bSshw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RNH1uv7Lq1FaAxGcntHCS2NCdNS9Wxi70frt89uLiVGXoqySjpC0cDpOkcQ/XFxgqX61+o9GDB9UHQMcdqArf1mfvvhDcDsE+mkXPRapeBKDDN2zaPgrUb8H4PxRfdGuIw9upHuTDhBXEqSl0bpKA/wZM0wCF0VBV6fqXKi3LYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beyermatthias.de; spf=pass smtp.mailfrom=beyermatthias.de; dkim=fail (0-bit key) header.d=beyermatthias.de header.i=@beyermatthias.de header.b=R5YJ3Zgq reason="key not found in DNS"; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beyermatthias.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beyermatthias.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=beyermatthias.de header.i=@beyermatthias.de header.b="R5YJ3Zgq"
Received: from cressida.uberspace.de (cressida.uberspace.de [185.26.156.202])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 7E9DE180344
	for <git@vger.kernel.org>; Fri, 06 Feb 2026 08:43:58 +0100 (CET)
Received: (qmail 21215 invoked by uid 989); 6 Feb 2026 07:43:58 -0000
Authentication-Results: cressida.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by cressida.uberspace.de (Haraka/3.1.1) with ESMTPSA; Fri, 06 Feb 2026 08:43:58 +0100
Date: Fri, 6 Feb 2026 08:43:56 +0100
From: Matthias Beyer <mail@beyermatthias.de>
To: git@vger.kernel.org
Subject: git-am applies commit message diffs
Message-ID: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="26qcnwcrtgbsuqeg"
Content-Disposition: inline
X-Rspamd-Bar: --
X-Rspamd-Report: BAYES_HAM(-1.082338) MID_RHS_NOT_FQDN(0.5) SIGNED_PGP(-2) MIME_GOOD(-0.2)
X-Rspamd-Score: -2.782338
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=beyermatthias.de; s=uberspace;
	h=from:to:subject:date;
	bh=gzpYlT1YQkzhZ3dj9WvxVrrZH3Gbat+9FS01Q0bSshw=;
	b=R5YJ3ZgqRURyUyZhm+OBuWf3o0sATbmzzpnPy5yM3RjO5V0ajiJOh8jRwQZnRyRAp0YWGRK/XN
	7gTmaB5XBtmnBHtRO0PIS+fy3cWAZaYPgYWLXdUTjZwt9Mn1de3V7mjkuoIWXXzPPa24Ifh70QKo
	bM5w09+8A1zHhzlhkJlwBFpPhsgA3aGC2PB8Lo1SbvGcSHW3Yw4bgiVhu/foevebJykZqR81tqIw
	Y/eVMJ9Y3eFbxMovsKtxPydN5OJSVeX+nM/82cP/PAjKkwdQ/bBbPD8TjyGMqDtLaB1LznYB6dWR
	RG7U+JUIjUZeisW2wbR90OUIoMvrpHxG++OJA53LP7u2SgvyS67aPmqmJifC5Cisj9s6SwY3GpTz
	U1ffgu9WsU9512Qwf826IaBYFhPzwOYUw2cFujoQ89eqrpHtHlqh83iRTyVy4Qlhe2lR90ckKnq3
	CvviTa58X9tWtYJDtvDcW+6pNjakvsMNBpJA/R62dlXqA9LcVWP3wLmm2SXq7snoQn2AUOqniaes
	9JYpn+G2jjPcjwvRj1+uPUFLOS8KglflMnqNlC7wJUPPvZ9sQmCYiPKTBi9Z6Vn2/i5ogTTVAebt
	gk2UoX5TWvW4cd4zYe3C/EnPLgMfSWemSe4avZHkiXaLr5u7VQpkwhWaoGqbYAkaE1cXxWOA2I9A
	0=


--26qcnwcrtgbsuqeg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: git-am applies commit message diffs
MIME-Version: 1.0

Hi,

I am not sure whether this was already reported, searching the lore did
not yield anything for me, but I might have overlooked it...

This was just posted on mastodon[0]:

    PSA: Did you know that it=E2=80=99s **unsafe** to put code diffs into y=
our commit messages?

    Like https://
    github.com/i3/i3/pull/6564 for example

    Such diffs will be applied by patch(1) (also git-am(1)) as part of the =
code change!

    This is how a sleep(1) made it into i3 4.25-2 in Debian unstable.

TL;DR: If you put a diff in the commit message, that diff will be
applied by git-am.

This looks clearly like unintended and might be an attack-vector, right?

Best,
Matthias

[0]: https://mas.to/@zekjur/116022397626943871

--26qcnwcrtgbsuqeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEUJGUus1GMTrRclzcEKWX9Kitz80FAmmFm7sACgkQEKWX9Kit
z82Q4BAAgE5L0dW4IwqPspOQhh0soHP6zCUD/Z5kOL22DnjBlqs7XVSqWv6FCTeX
zw+shPpCmH9RDOW0bffhqV5pwo8khpB6gQkGcTFoE0Uis1G88+oiHSVQYd6blHsB
wxXug8nZ8PWeOQcBactAJ+wXXlyaupclD8eJNmJ9Ffs1G4kb2EweMDNR4DPmcP4C
Zp2cGTFH87No8CTskZt6/d7FSMPcEMxWkv5jQPW/X6bjyFzE5Ttd5C6FU+8QEjyY
GVn33xlUI7jqHz0obkpdKr6G5zwYCFs0mJCxGh/9UpGtPCTSsYtj4bWeHPLFte7r
qV6c0L2BeaawOQNSw6WQ+bOxtPb6A4+CNtPbz+BoayORl0LkheY9fus4rWzz8hyp
4CcBKVvp0wPBmx0unOqdXjZfgC+t4P0IWdFpdhwaJImp8+/VubBTVRnnibSlAlBp
0MaQwaoK9ZHaR6Rp4OJ+6wEa7ZDmg3gbUZHjyqZ4K0Kpp1aq+E/WwjoISxDDszpi
hI11BIwAczG21XvdGRdE7ovslnI3lW0SO1mjK5DKhyUjOXu0/J5x6G6su1gyDQtK
52yTR6rGKHlTkTIVYsPoqEnGxF+jDEY4hCtfAVzk11hTbL9iIRgJXWGoCuEtGvEx
aN3uJHZgJwMFPHCCtMcQhBPhDBkzav7Uku+Gqi8x3YoqSmv92uw=
=8vD6
-----END PGP SIGNATURE-----

--26qcnwcrtgbsuqeg--

Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39270805
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730732603; cv=none; b=WJ9FMbr6aIEl3mBRPgPhDxo4QVuwStzKcOY2vwMwLtN6AsuDZjQUTmKK0jmPyP07LgBvJvFHOpr0CpqL7nJ3SM3tCLQBv9Axmz/7kS09V8OfZXkeY1Li2U7h9Nm0YWZYIGqn/0nLxKTXGDMU8pyLiwPzuBNX8yC/66Q4IzGEJ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730732603; c=relaxed/simple;
	bh=+XVDopMtThitzcMOk28ZixeXlIbeGvF0f+PKiEkZr+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5Hh5oPwb5BbufaOffdlCRPiTikzYivG24MMZez7FhMI4ZueyxywZuxjJ93yQh4Ex/eR9D68XtR2XksHZvEcCV6vgVqFvMMeO+oLRIv6dwwVooUuRK6S/okEl7UuqQY73eX5Qrdk3wpC1MBYb0Or91Ufs5Q6QQaPgAm/4Zw6gI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <2dc3433a-4440-4216-8fd1-3776c8293674@gentoo.org>
Date: Mon, 4 Nov 2024 10:03:17 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
To: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
Content-Language: en-US
From: Eli Schwartz <eschwartz@gentoo.org>
Autocrypt: addr=eschwartz@gentoo.org; keydata=
 xjMEZmeRNBYJKwYBBAHaRw8BAQdAYNZ7pUDWhx1i2f3p6L2ZLu4FcY18UoeGC04Gq/khqwfN
 I0VsaSBTY2h3YXJ0eiA8ZXNjaHdhcnR6QGdlbnRvby5vcmc+wpYEExYKAD4WIQTvUdMIsc4j
 CIi+DYTqQj6ToWND8QUCZoRL+gIbAwUJBKKGAAULCQgHAwUVCgkICwUWAgMBAAIeBQIXgAAK
 CRDqQj6ToWND8aB5AP9r4kB691nNtNwKkdRiOdl7/k6WYzokvHvDamXxRJ0I+gEAjZqR5V8y
 mfR3fy2Z+r2Joeqdt3CIv5IwPs64spBvigLOOARmZ5E0EgorBgEEAZdVAQUBAQdATT46Z06b
 1X9xjXFCYFxmq/Tj3tSEKZInDWTpoHQp4l8DAQgHwn4EGBYKACYWIQTvUdMIsc4jCIi+DYTq
 Qj6ToWND8QUCZmeRNAIbDAUJBKKGAAAKCRDqQj6ToWND8a2RAP40KPfbfoiZAJW5boFmFJ3G
 TUBDJRh9CWHyaPqq2PN+0wD/R07oLzfnJUN209mzi9TuTuHjeZybysyqXSw4MAxkMAY=
In-Reply-To: <Zyi7PA2m2YX9MpBu@pks.im>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ia3mHAxn0G5pXIKMzTQI8KR4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ia3mHAxn0G5pXIKMzTQI8KR4
Content-Type: multipart/mixed; boundary="------------crX9MZsdvpDslL25PckV2zVC";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <2dc3433a-4440-4216-8fd1-3776c8293674@gentoo.org>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
In-Reply-To: <Zyi7PA2m2YX9MpBu@pks.im>

--------------crX9MZsdvpDslL25PckV2zVC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/4/24 7:17 AM, Patrick Steinhardt wrote:
> The solution to that problem is autoconfiguration by detecting platform=

> specific bits and pieces. And we _also_ have such a build system in the=

> form of autoconf, but now we're entering territory that is awfully hard=

> to maintain. Most people don't use it at all, the only user seems to
> really be distros. And they tend to hit many issues with autoconf
> because we devs don't use that infra in the first place, creating a bit=

> of an awkward situation. Unifying this infrastructure such that devs an=
d
> packagers use the same build infra is thus another goal of my series.


As a distro packager (not of git specifically), my understanding was
that *no* distros use the autoconf, and that at least some distros say
the reason for this is that the autoconf is so unused that it doesn't
actually work.

We tried to use the autoconf but failed.


--=20
Eli Schwartz

--------------crX9MZsdvpDslL25PckV2zVC--

--------------ia3mHAxn0G5pXIKMzTQI8KR4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZyjiNgUDAAAAAAAKCRCEp9ErcA0vV2+M
AP9qoJ0iF2pDnzM9RDFoWghomMG7yonJ3kblsFIoklXWLgEA4UNrimUBW7OhLenKvN9J2IhD7Ymt
y6tQCns+5xsarQc=
=QKMx
-----END PGP SIGNATURE-----

--------------ia3mHAxn0G5pXIKMzTQI8KR4--

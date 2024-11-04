Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8849A4A08
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733104; cv=none; b=NTsEiFSYes7vN4W0bj+oqSl1Fc3wVJPySbCOQbOuOKCfdSZSWa68QAOf4scX6lzS5/p8Td10FUBSWlzq6cF2SuqHOz9Qe670ZNkn1NzV4xxszW6xT3nvD0U/ACX901NqjkFMhaW5mK2kbqh8HW4vrOXpuFGpB9Yr2f/Dih+gpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733104; c=relaxed/simple;
	bh=0l2JX1RnNAZu7JjAwLxe2R9l6bxeoF/r48WvpHusFSs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Out0UTEGU+pPg6arOIUYOzeJkGc+5+xIc0Nl7SDh2N4BNQAdVH5HyywDm5SZ4nsxJFcMtk3MhR6EnCOBtsnI3drZ/74fYPMQqC2kvcGGCHQlBbaaorjdXOINDIobszWnOzZK5X4p43pxLO0zHTangr1OZDwsClstO9JOzeV5IFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <eb9d26be-b0c3-4120-a5ea-a8b5236277d5@gentoo.org>
Date: Mon, 4 Nov 2024 10:11:36 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
To: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
Content-Language: en-US
Autocrypt: addr=eschwartz@gentoo.org; keydata=
 xjMEZmeRNBYJKwYBBAHaRw8BAQdAYNZ7pUDWhx1i2f3p6L2ZLu4FcY18UoeGC04Gq/khqwfN
 I0VsaSBTY2h3YXJ0eiA8ZXNjaHdhcnR6QGdlbnRvby5vcmc+wpYEExYKAD4WIQTvUdMIsc4j
 CIi+DYTqQj6ToWND8QUCZoRL+gIbAwUJBKKGAAULCQgHAwUVCgkICwUWAgMBAAIeBQIXgAAK
 CRDqQj6ToWND8aB5AP9r4kB691nNtNwKkdRiOdl7/k6WYzokvHvDamXxRJ0I+gEAjZqR5V8y
 mfR3fy2Z+r2Joeqdt3CIv5IwPs64spBvigLOOARmZ5E0EgorBgEEAZdVAQUBAQdATT46Z06b
 1X9xjXFCYFxmq/Tj3tSEKZInDWTpoHQp4l8DAQgHwn4EGBYKACYWIQTvUdMIsc4jCIi+DYTq
 Qj6ToWND8QUCZmeRNAIbDAUJBKKGAAAKCRDqQj6ToWND8a2RAP40KPfbfoiZAJW5boFmFJ3G
 TUBDJRh9CWHyaPqq2PN+0wD/R07oLzfnJUN209mzi9TuTuHjeZybysyqXSw4MAxkMAY=
In-Reply-To: <Zxv4osnjmuiGzy94@nand.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Jn0x7qms2ipzu1bR1VZBL00x"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Jn0x7qms2ipzu1bR1VZBL00x
Content-Type: multipart/mixed; boundary="------------oFgXAPP03WnSe5I1Rvl6Ko7I";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <eb9d26be-b0c3-4120-a5ea-a8b5236277d5@gentoo.org>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
In-Reply-To: <Zxv4osnjmuiGzy94@nand.local>

--------------oFgXAPP03WnSe5I1Rvl6Ko7I
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/25/24 3:59 PM, Taylor Blau wrote:

> =3D=3D Conclusion
>=20
> To step back, I want to say that I appreciate your work on this series
> and am certainly not opposed[^1] to the idea that we may need to make
> significant changes to our build infrastructure to support the project'=
s
> goals.
>=20
> But I think that what I'm missing currently is a clear picture of what
> goals we *can't* achieve with the existing build system (or could, but
> only at significant cost/awkwardness), and why Meson is the right choic=
e
> to address those gaps.
>=20
> If the project can agree that pursuing Meson as a replacement for Make,=

> CMake, or both, then I think we would need further clarification on wha=
t
> we want to do with CMake (and more generally how we want to support new=

> efforts to add additional build systems to Git in the future).


One extremely big distinction is that Make is not a configuration
system, and cannot be, and git has many configuration options that are
currently underserved to the point of nonexistence. This causes a *lot*
of trouble to people attempting to build git as it's not often clear how
to do so other than by building a stock no-options build.

When you do try it, you frequently end up with broken option passing
resulting in an inconsistent git installation where some parts of the
code are built with one option, and other parts of the code are built
with its inverse, and neither of them are the third set of options that
you had finally settled on. This also affects distro maintainers.

The configure.ac tries to solve this problem and fails because it
appears no one bothers to maintain it. The CMake files try to solve this
problem but only for Windows (?). Possibly the reason people struggle
with both is because both feel quite painful to use -- the initial
premise of this patch series is, after all, "I the submitter believe
this build system is nicer than the other option".


--=20
Eli Schwartz

--------------oFgXAPP03WnSe5I1Rvl6Ko7I--

--------------Jn0x7qms2ipzu1bR1VZBL00x
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZyjkKAUDAAAAAAAKCRCEp9ErcA0vVxDP
AQC8jvIlTbwdctRYAjaXl0zy0mL6NvdKieHGakPgK60lAAD+PiSdJ34wy7lOJ4dFeHq+GsZBvywY
BJK5p2TqdEr2mAw=
=lcO3
-----END PGP SIGNATURE-----

--------------Jn0x7qms2ipzu1bR1VZBL00x--

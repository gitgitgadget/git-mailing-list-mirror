Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70916DC0E
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361156; cv=none; b=KkP5jZsepgTDcOHOxpYV/B8JWnTT0PAGRlb2euQFdvHcoEn7Ex0Jr69jhA3oveg0f7DYm8OvddIjqDMYFghcZ65MstQheEHprFaGFY02NcQzPV0BnMhfnUipQQaXyuzY7lA+fAaMIv0PiORGpfsMprRKlBlydSoDn1+w0qoP6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361156; c=relaxed/simple;
	bh=jciiRrTwOjyGMoCMYcylnMNmHocmri5Dxr8p/YO8168=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jK+GztBaFWxhhkXSLqnBCPDXoPeilak/WNhsrBdDzr3c3iBC1xuvWSMPp5ZhKf/ePLtYKRHQvsXfnbIu2bU/aOaH59ABZEH4eTu4UtcNjf0ccqPs6as5HQ7jGQK+pt0Wjs4O7dy3lYuKMiPbAIs3XygVryeyf0B92H6t33LFz9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <bfc876ea-1a90-4e78-8756-efdcd53e7525@gentoo.org>
Date: Mon, 11 Nov 2024 16:39:08 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
To: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <ZzHeLlYu8Gwk1FPj@pks.im>
 <20241111210629.GB5019@coredump.intra.peff.net>
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
In-Reply-To: <20241111210629.GB5019@coredump.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4JjFs71Cr0bw5ZRVRoS8CAZw"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------4JjFs71Cr0bw5ZRVRoS8CAZw
Content-Type: multipart/mixed; boundary="------------x05TDS0LF4Wh8bsiDCt00jqG";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <bfc876ea-1a90-4e78-8756-efdcd53e7525@gentoo.org>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <ZzHeLlYu8Gwk1FPj@pks.im>
 <20241111210629.GB5019@coredump.intra.peff.net>
In-Reply-To: <20241111210629.GB5019@coredump.intra.peff.net>

--------------x05TDS0LF4Wh8bsiDCt00jqG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/11/24 4:06 PM, Jeff King wrote:
> The number one thing I care about as a developer is that the build is
> _reliable_. Right now, if I move forwards and backwards in history and
> type "make" I will almost[1] always get a correct result based on the
> current tree, with the minimal required amount of building. This is
> important for bisecting.
>=20
> When I have worked on other projects, especially those that use
> autotools, I quite frequently run into cases where building from a dirt=
y
> state cause bizarre problems that go away with a "git clean &&
> ./configure && make". But then bisection is _much_ slower because we're=

> building from scratch (not to mention that autoconf itself is
> horrifically slow).
>=20
> How does the meson build do here? I don't have any reason to think it
> would be bad, but I am nervous of any change.


This is something that has bothered me about autoconf as well. Meson is
much more reliable about:

- forcing a buildsystem reconfigure on any changes to the buildsystem
  files

- due to using ninja, forcing any object files to be rebuilt on e.g. any
  changes to compiler flags, since the *entire* compiler command line is
  part of the key that determines staleness

- keeping your existing objects between buildsystem reconfigures, if the
  resulting reconfigure didn't change the compiler command line for that
  specific object file


>> Out of curiosity: did you try the Meson build? I personally have to sa=
y
>> that I already prefer working with it because the workflow with it is =
so
>> much nicer. It has nicer output, is faster, has out-of-tree builds,
>> makes it easier to configure and test execution feels way nicer compar=
ed
>> to my previous workflow with make.
>=20
> I hadn't tried it. I did now, checking out origin/ps/build^ (to drop th=
e
> "seen" resolution topic), but it didn't work:
>=20
>   $ meson setup build
>   [...]
>   Program msgfmt found: NO
>   po/meson.build:3: WARNING: Gettext not found, all translation (po) ta=
rgets will be ignored.
>=20
>   po/meson.build:3:20: ERROR: Can not assign void to variable.
>=20
> I guess the assignment of "translations" there needs to be made
> conditional?


Yeah, this is an interesting quirk. Many projects would tend to figure
that translation (po) targets are "optional" because if you don't have
msgfmt installed then you can just install the project without any
translations and then non-English speakers will be inconvenienced but at
least the entire project isn't completely un-buildable. So meson
automatically disables the target and logs a warning, but then this
project *also* wants to depend on the translations for the testsuite.

So this should be taken into account. Do the tests actually need
translations, though?


--=20
Eli Schwartz

--------------x05TDS0LF4Wh8bsiDCt00jqG--

--------------4JjFs71Cr0bw5ZRVRoS8CAZw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZzJ5fQUDAAAAAAAKCRCEp9ErcA0vV5/l
AQDRwmIsIt/GDW9vbqoAHFsC5s1p+lFrXesC8UyfEqB74QEAhe+1l7EXa/NS/KV/EL2y8J/fNs+j
G5lMMaqpsoOYPw0=
=RbTf
-----END PGP SIGNATURE-----

--------------4JjFs71Cr0bw5ZRVRoS8CAZw--

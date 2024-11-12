Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468C32076DF
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 02:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378993; cv=none; b=Wu2ejpwMjK1L6wvZqmqiNNLwo+i8Zbg0CQcHywyl1MvuDxYPNyD4NCq/CEfiQSu8ueoVhA0Rdul+KGXsluYVWGO44XTRpn7S463BCVNe64drlZexefjsmDbDuLpTg1gI8xqkedY9s91i6TKeDkHEHirNkscpo4xytFQcr5oiVK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378993; c=relaxed/simple;
	bh=UqUjHgXP9dC5C/ycmKLrnANZJ04ahPw1Aywau4XxeIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItyDY1KVF3r6KEJGGEak1uquSj/TKBrz6eR24EV4Ok/1Z91B4bMRc57zHwvCTq7VAAqGn3TD1DofxEhKPPZawp8yeL/5kepOY3PC394CGEX7S3Jbi9cSxYg3Pbd6zCi4vjrRN1IYRVXLr7zAhobb3guf///bUd4kvaThH4RQJgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <941bae7b-83be-43f8-aaa3-43b4d9501690@gentoo.org>
Date: Mon, 11 Nov 2024 21:36:25 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
 git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <ZzHeLlYu8Gwk1FPj@pks.im>
 <20241111210629.GB5019@coredump.intra.peff.net>
 <bfc876ea-1a90-4e78-8756-efdcd53e7525@gentoo.org>
 <20241111221320.GF5019@coredump.intra.peff.net>
 <f3b00260-ec3d-4607-aaf7-9cfd9898434f@gentoo.org>
 <20241112022104.GA77521@coredump.intra.peff.net>
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
In-Reply-To: <20241112022104.GA77521@coredump.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------d08r0TdFHKSj1o4f7COFm08S"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------d08r0TdFHKSj1o4f7COFm08S
Content-Type: multipart/mixed; boundary="------------gGmpVFokEVxv7Pkb9nC0q10z";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
 git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <941bae7b-83be-43f8-aaa3-43b4d9501690@gentoo.org>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <ZzHeLlYu8Gwk1FPj@pks.im>
 <20241111210629.GB5019@coredump.intra.peff.net>
 <bfc876ea-1a90-4e78-8756-efdcd53e7525@gentoo.org>
 <20241111221320.GF5019@coredump.intra.peff.net>
 <f3b00260-ec3d-4607-aaf7-9cfd9898434f@gentoo.org>
 <20241112022104.GA77521@coredump.intra.peff.net>
In-Reply-To: <20241112022104.GA77521@coredump.intra.peff.net>

--------------gGmpVFokEVxv7Pkb9nC0q10z
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/11/24 9:21 PM, Jeff King wrote:
> Yes, that does get "meson setup" to complete for me. That gives me two
> other questions:
>=20
>  - how would I know this option exists? I think you mentioned elsewhere=

>    in the thread the ability to ask about which options exist, but I
>    couldn't find anything via "meson -h", etc.


meson -h lists:


    configure               Change project options


Which could perhaps be reworded as it allows you to both view and change
them.

If you install meson via a linux distribution package, it probably has
nice integration with our manpage. If you install it with `pip install
meson` then not so much...

$ man meson

The configure command
       meson configure provides a way to configure a Meson project from
       the command line.  Its usage is simple:

       meson configure [ build directory ] [ options to set ]

       If build directory is omitted, the current directory is used
       instead.

       If no parameters are set, meson configure will print the value of
       all build options to the console.

       To set values, use the -D command line argument like this.

       meson configure -Dopt1=3Dvalue1 -Dopt2=3Dvalue2


>  - is there a way to put configuration like this in a file, similar to
>    our current config.mak?


https://mesonbuild.com/Machine-files.html

machine files (passed via --cross-file or --native-file) allow you to
define your toolchain, e.g. set up persistent CFLAGS and CC that you can
store as a configuration file, check into git, share with people, etc.

You can also store configuration options in them:

[project options]
gettext =3D 'disabled'
default_editor =3D 'vim'


[built-in options]
c_std =3D 'gnu17'
b_lto =3D true
b_sanitize =3D 'address,undefined'


--=20
Eli Schwartz

--------------gGmpVFokEVxv7Pkb9nC0q10z--

--------------d08r0TdFHKSj1o4f7COFm08S
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZzK/KQUDAAAAAAAKCRCEp9ErcA0vV4Ww
AQDfb7ycjHeKiXPXRUdDWEf9CRPm/QgQJLtgIvk6HhvHdgD/Sd7YFvK2hUOjDHN7+KJnuEhNbC5g
WOf0aymR4u9HfQA=
=AGyo
-----END PGP SIGNATURE-----

--------------d08r0TdFHKSj1o4f7COFm08S--

Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C68200C97
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 05:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731389369; cv=none; b=PLqFDIEwsN5qil6Y7M1puM6zzM86VZ0Cr8L0JMh2WTfB49ZYIZ80QRteaFQlql+SLiFS9WQtaeTqkiZzQ9fq7j/BOzOnlxjQ24SRE8ssQceMueAmycnDfU2eu+V9Fg80Nf+2K/I5LLgVmkZG5+a5unIupDj2MM7wr7DP3PMo00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731389369; c=relaxed/simple;
	bh=MClZ7NkU8yDciuNEetj/B1Ug4mD/P974FTi4ijjlsn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEEDdtbgC1Qe1hGm5ejkoD5tM3HOog4EV1/6dNMfyVId4jOGtn8+9a9/sigr5uCpRB7NI8wujeb3p/1TZvHKKecmzpCPsZCF2+rUUKjDnnWcAVK3SzoMDboYDpTQq5I9MAa78IYvM67zJcQPgbnhQlfUDNXiEmQjtISGKLgn4aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <8415b0c1-2cf1-4499-b031-eb6ee8e2cbf6@gentoo.org>
Date: Tue, 12 Nov 2024 00:29:23 -0500
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
References: <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <ZzHeLlYu8Gwk1FPj@pks.im>
 <20241111210629.GB5019@coredump.intra.peff.net>
 <bfc876ea-1a90-4e78-8756-efdcd53e7525@gentoo.org>
 <20241111221320.GF5019@coredump.intra.peff.net>
 <f3b00260-ec3d-4607-aaf7-9cfd9898434f@gentoo.org>
 <20241112022104.GA77521@coredump.intra.peff.net>
 <941bae7b-83be-43f8-aaa3-43b4d9501690@gentoo.org>
 <20241112045224.GA98197@coredump.intra.peff.net>
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
In-Reply-To: <20241112045224.GA98197@coredump.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5GcvB0a9CMelNhDCpSDnkYd2"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5GcvB0a9CMelNhDCpSDnkYd2
Content-Type: multipart/mixed; boundary="------------y0rgRvJZqOJN0XTe0S0moTxP";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
 git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <8415b0c1-2cf1-4499-b031-eb6ee8e2cbf6@gentoo.org>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
References: <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <ZzHeLlYu8Gwk1FPj@pks.im>
 <20241111210629.GB5019@coredump.intra.peff.net>
 <bfc876ea-1a90-4e78-8756-efdcd53e7525@gentoo.org>
 <20241111221320.GF5019@coredump.intra.peff.net>
 <f3b00260-ec3d-4607-aaf7-9cfd9898434f@gentoo.org>
 <20241112022104.GA77521@coredump.intra.peff.net>
 <941bae7b-83be-43f8-aaa3-43b4d9501690@gentoo.org>
 <20241112045224.GA98197@coredump.intra.peff.net>
In-Reply-To: <20241112045224.GA98197@coredump.intra.peff.net>

--------------y0rgRvJZqOJN0XTe0S0moTxP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/11/24 11:52 PM, Jeff King wrote:
> I think the meson equivalent is that I would "meson setup build
> --native-file /path/to/my/config.mak" once, which would copy all of the=

> values in to that environment. And then starting ninja from that "build=
"
> directory would presumably work throughout history. My config.mak does
> have some runtime logic, though (e.g., when bisecting old commits it
> relaxes the compiler options). It sounds like that would need to re-run=

> meson, and not work at the ninja level.


Well, at least to change compiler options and relax them it would need
to re-run meson once.


> I'm also not clear on how to alternatively build with different
> optimization levels, or with different sanitizers. Right now that is:
>=20
>   # normal build and test some script
>   make && cd t && ./t0000-basic.sh -v -i
>=20
>   # now with sanitizer
>   make SANITIZE=3Daddress && cd t && ./t0000-basic.sh -v -i
>=20
> If I understand correctly, the workflow here is either to have two
> separate build directories, or to "meson configure" between the two.
> And AFAICT the tests _have_ to be run via "meson test" now, if we want
> them to find the Git built in the separate directories.


Yes, and yes. Well, kind of.



meson test t0000-basic

# supports globbing and passing args
meson test t0000* --test-args=3D"-v -i"

GIT_BUILD_DIR=3D$PWD/../build ./t0000-basic.sh -v -i



are all functional. The introduction of meson doesn't change how the
tests actually work, but it does introduce an environment variable
pointing to the built git program(s) in some location other than "the
parent directory of t/ itself", and `meson test` sets that variable then
runs ./tXXXX-testname.sh itself. So you could continue to run it directly=
=2E


> [1] I think my gut feeling is that these are questions that Patrick
>     should be answering if he wants to sell the project on moving away
>     from make. I know we can't expect to be spoon-fed all parts of a
>     transition, but I am starting from the point of view of: I am
>     perfectly happy with make, why do you want me to switch?
>=20
>     Another thing I am observing about this is that "meson" is not
>     really just replacing "make". It is also replacing autoconf to some=

>     degree in probing various things (like gettext). But that is not
>     something I (or most developers) were using at all. So it is not
>     just transitioning to a different piece of software, but also
>     changing the fundamental approach. Though I imagine with the right
>     --native-file options, I could disable all of the probing entirely.=



I would say that technically you were already probing various things. It
is simply that the Makefile performed all those probes each time you ran
`make`, e.g.

ifndef CURL_LDFLAGS
    CURL_LDFLAGS =3D $(eval CURL_LDFLAGS :=3D $$(shell $$(CURL_CONFIG)
--libs))$(CURL_LDFLAGS)
endif


ran curl-config --libs every time, which is very much a probe.

Other things like NEEDS_LIBICONV were not a probe, but did require the
user to know it was necessary... possibly since conditionally checking
for -liconv -lintl in a Makefile is difficult to do automatically. :)

Really, the main difference in my view is that probing is moved to an
explicit step rather than happening "under the hood" as part of
executing `make`. And that's a definite difference, since `make` is a
single step and `meson setup build && ninja -C build/` is two steps.


--=20
Eli Schwartz

--------------y0rgRvJZqOJN0XTe0S0moTxP--

--------------5GcvB0a9CMelNhDCpSDnkYd2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZzLnswUDAAAAAAAKCRCEp9ErcA0vV4n3
AP9Ex9JNOGMYLstiXyBSIOHhOIbI4s7QgvEXoSMzkRSWZgD8CUs0w3VOcMAqEZLZudVIDv5GQvYP
MDNZMa5z7fnVTgE=
=/NwW
-----END PGP SIGNATURE-----

--------------5GcvB0a9CMelNhDCpSDnkYd2--

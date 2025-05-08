Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47781E4AE
	for <git@vger.kernel.org>; Thu,  8 May 2025 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746744665; cv=none; b=mmN5NwCsiCbejZLwpie6Vk0N4S0Aq/Dpav4B7bOzrtBj1rDO+xRfNfPmFZfjxZNpkVGWqvSz9+YR5FocNLbOsOc3J8KL851vV8KxRTJ4XI5XyDJnCZMx7z/4glJQjoq5KENnU2JLwdWiyTm0yWWnbQR6ucb/HLqrmUYCw4Rs+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746744665; c=relaxed/simple;
	bh=HxkdgwriMj/Pq2/yAIJS9rQ1iIwb2q5xF0vW5qqKQiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=taCsYlfBQnb3bthL7r/056ZUaJOGZ6EQt0y3T3SYdPFiVv9Vx3+qr3zl/eJcjJFeRTXZhfvu53H2gmimFsScmB6mKI1lnVPV+MsbSyKCtwGMVz+m/J5wFUbxDd35fyCbpMUHVcoahOJ2j505/1dBsUf+KyjkmMy1FWwskO1J1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 43E0B342FA9;
	Thu, 08 May 2025 22:51:02 +0000 (UTC)
Message-ID: <5a91094a-08d5-4bf8-a4c3-1d54cc970f67@gentoo.org>
Date: Thu, 8 May 2025 18:50:59 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] meson: correct path to system config/attribute files
To: Junio C Hamano <gitster@pobox.com>,
 Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
 <xmqqr00y4vvd.fsf@gitster.g>
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
In-Reply-To: <xmqqr00y4vvd.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hER5CWrqcP5dY0GepGZUakqp"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------hER5CWrqcP5dY0GepGZUakqp
Content-Type: multipart/mixed; boundary="------------ULZneJ2VfcTmWIQxVI0zM0d2";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>,
 Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Message-ID: <5a91094a-08d5-4bf8-a4c3-1d54cc970f67@gentoo.org>
Subject: Re: [PATCH 3/5] meson: correct path to system config/attribute files
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
 <xmqqr00y4vvd.fsf@gitster.g>
In-Reply-To: <xmqqr00y4vvd.fsf@gitster.g>

--------------ULZneJ2VfcTmWIQxVI0zM0d2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 5/8/25 5:48 PM, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>=20
>> -  '-DETC_GITATTRIBUTES=3D"' + get_option('gitattributes') + '"',
>> -  '-DETC_GITCONFIG=3D"' + get_option('gitconfig') + '"',
>> ...
>> +system_attributes =3D get_option('gitattributes')
>> +if system_attributes !=3D ''
>> +  libgit_c_args +=3D '-DETC_GITATTRIBUTES=3D"' + system_attributes + =
'"'
>> +else
>> +  libgit_c_args +=3D '-DETC_GITATTRIBUTES=3D"' + get_option('sysconfd=
ir') + '/gitattributes"'
>> +endif
>=20
> Just out of curiosity (because this cannot be a regression, since
> the original removed one used the same constructs).
>=20
> I am guessing from the presence of double quote around the value
> that these strings are not directly used to invoke the compiler
> without involving any shell (in other words, you wouldn't want these
> quotes if you are shoving these strings in argv[] yourself to feed
> execv()).
>=20
> How does the above, and get_option() in particular, cope with a
> pathname that has letters with special meanings to the shell when
> they appear inside double-quote pair (like backquote or backslash or
> even a dollar sign)?  On the Makefile side we give VAR_SQ for a raw
> variable VAR and use the latter to write something like
>=20
>         -DETC_GITATTRIBUTES=3D'"$(ETC_GITATTRIBUTES_SQ)"'
>=20
> to make sure we won't be broken by them.  Is Meson giving us an
> equivalent to us for free by simply using get_option() here?
>=20
> Thanks.


Meson uses strong implicit typing. The object type of '"' is a string
with value of double-quote-char, and the type of libgit_c_args is
"array". It's not a result of get_option() here, except inasmuch as
get_option() returned a string type.

Meson guarantees that arrays of strings e.g.

libgit_c_args =3D [
    '-Dfoo=3Dstring containing the $ (mighty dollar)',
    '-Dbar=3Dstring containing the ` soft-deprecated',
    '-Doopsies=3Dstring containing the \' (you read that right)',
]


are passed to the shell in a manner suitable for reinterpretation as an
argv array, notwithstanding other concerns (e.g. I believe there's some
mingw hack regarding doubling backslash escapes so they don't get
eaten). And of course this is conditional on the idea that it is
possible to reliably pass arguments on the Windows command line, which
doesn't have the notion of an array.

So, given that meson takes care of this, the actual value of the -D
define will be

string containing the $ (mighty dollar)


etc.

e.g. here is the ninja output:


[1/3] ccache cc -Ifoo.p -I. -I.. -fdiagnostics-color=3Dalways
-D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -O0 -g '-Dfoo=3Dstring
containing the $ (mighty dollar)' '-Dbar=3Dstring containing the `
soft-deprecated' '-Doopsies=3Dstring containing the '"'"' (you read that
right)' -MD -MQ foo.p/foo.c.o -MF foo.p/foo.c.o.d -o foo.p/foo.c.o -c
=2E./foo.c
<command-line>: warning: missing terminating ' character

Notice that the array contained a single quote using a meson string type
backslash escape, but the generated command line chose to shell-escape
it as ' ... '"'"' .... '



In this case, the Makefile does:

-DETC_GITATTRIBUTES=3D'"$(ETC_GITATTRIBUTES_SQ)"'


and if I understand correctly the _SQ is to handle single quotes in the
directory name:


-DETC_GITATTRIBUTES=3D'"/etc/git'\''s attribute file"'


Or in meson,

libgit_c_args +=3D [
    '-DETC_GITATTRIBUTES=3D"/etc/git\'s attribute file"',
]


compiles as:

[1/3] ccache cc -Ifoo.p -I. -I.. -fdiagnostics-color=3Dalways
-D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -O0 -g '-Dfoo=3Dstring
containing the $ (mighty dollar)' '-Dbar=3Dstring containing the `
soft-deprecated' '-Doopsies=3Dstring containing the '"'"' (you read that
right)' '-DETC_GITATTRIBUTES=3D"/etc/git'"'"'s attribute file"' -MD -MQ
foo.p/foo.c.o -MF foo.p/foo.c.o.d -o foo.p/foo.c.o -c ../foo.c


Meson has refrained from backslashes again:

ccache cc '-DETC_GITATTRIBUTES=3D"/etc/git'"'"'s attribute file"'

Double quotes are part of the define value, single quote gets de-escaped
via the sequence:

'"'"'

instead of the sequence

'\''


--=20
Eli Schwartz

--------------ULZneJ2VfcTmWIQxVI0zM0d2--

--------------hER5CWrqcP5dY0GepGZUakqp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaB01UwUDAAAAAAAKCRCEp9ErcA0vVy08
AP9H2oBcqmHoAeNSBb8n34gG1I+FQQXX+gFD+yqInQ0mVAD9GwgofvBJTm3rVF+jxceIk1PESoJ8
QY2KSYK2AHCEgwc=
=ssfb
-----END PGP SIGNATURE-----

--------------hER5CWrqcP5dY0GepGZUakqp--

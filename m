Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC31242D76
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099772; cv=none; b=RaL+0+JMzNHGHLjCKLexHBoEv7of2QqcNSJLCzVHM0lmetwxnwox7ONWeKqoknMlMNoLcD7Ic6rzyp4re8kmemf5FoHomzs3gT6atHzCY+F3cKqbb5G/ZGlj2IYBzivQUCsAtS1uUpNIByaS01NeuOX2tjdVliemITLUefX9N9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099772; c=relaxed/simple;
	bh=I7oZMiKYc8QcWm9bM0Dryr/Am3cvQ2lfUXEkhS7BS0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiSEe8tuQN05+cQS3Y9kci5C8iRTI3zpWBQ5nNOdSRpkXNR56Sdnk8pXvwrp+GFrlIuPEFqqOso7b3+23vtlzKrzd1anZpA8uS0Dpr7CcRWutHwVg8B786u6GdVLHpohKB/vYqXI62jm5gTfzDA0oZ+f2jCtEcQa1XYLpnnHwjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 54371341FB2;
	Wed, 09 Jul 2025 22:22:49 +0000 (UTC)
Message-ID: <1664d442-7985-41b7-9391-78f78ece7601@gentoo.org>
Date: Wed, 9 Jul 2025 18:22:46 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] meson: stop discovering native version of Python
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
 irecca.kun@gmail.com, Jeff King <peff@peff.net>,
 Justin Tobler <jltobler@gmail.com>
References: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
 <20250709-b4-pks-meson-cleanups-v3-1-29ab15b9ab85@pks.im>
 <xmqqikk1pfiz.fsf@gitster.g>
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
In-Reply-To: <xmqqikk1pfiz.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------j95jdjUi2L9cciyEiXYxuxKC"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------j95jdjUi2L9cciyEiXYxuxKC
Content-Type: multipart/mixed; boundary="------------1z0sER8caQNH3hpMBWTyALJL";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
 irecca.kun@gmail.com, Jeff King <peff@peff.net>,
 Justin Tobler <jltobler@gmail.com>
Message-ID: <1664d442-7985-41b7-9391-78f78ece7601@gentoo.org>
Subject: Re: [PATCH v3 1/8] meson: stop discovering native version of Python
References: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
 <20250709-b4-pks-meson-cleanups-v3-1-29ab15b9ab85@pks.im>
 <xmqqikk1pfiz.fsf@gitster.g>
In-Reply-To: <xmqqikk1pfiz.fsf@gitster.g>

--------------1z0sER8caQNH3hpMBWTyALJL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7/9/25 11:09 AM, Junio C Hamano wrote:

>> -python =3D import('python').find_installation('python3', required: ge=
t_option('python'))
>> -target_python =3D find_program('python3', native: false, required: py=
thon.found())
>> -if python.found()
>> +# Python is not used for our build system, but exclusively for git-p4=
=2E
>> +# Consequently we only need to determine whether Python is available =
for the
>> +# build target.
>> +target_python =3D find_program('python3', native: false, required: ge=
t_option('python'))
>> +if target_python.found()
>>    build_options_config.set('NO_PYTHON', '')
>>  else
>>    libgit_c_args +=3D '-DNO_PYTHON'
>=20
> We ask explicitly for Python 3 here.
>=20
> Does find_program() have some magic to deal with installations where
> Python3 is simply called /usr/bin/python (and worse yet, not as a
> symbolic link to /usr/bin/python3)?
>=20
> I found
>=20
>     "Since 0.50.0 if the "python3" program is requested and it is
>     not found in the system, Meson will return its current
>     interpreter",
>=20
> which I suspect refers to the path to python3 used during the build
> and is not what we want, at
>=20
> https://mesonbuild.com/Reference-manual_functions.html#find_program
>=20
> which got me a bit worried.


Well, this patch doesn't really change that. But a cross compile where
build !=3D host and thus the build meson and build python don't represent=

the host `git`, already needs a cross env setup to define the right C
compiler which can produce host binaries, and that's where you'd define
the host python too.

[binaries]
c =3D 'usr/bin/aarch64-linux-gnu-gcc'

# we have python 3.13, but our cross target is really old
python3 =3D '/usr/bin/python3.6'


> Perhaps everybody with Python3 has it at /usr/bin/python3 these
> days, and my worries are unfounded? ;-)
>=20
> Thanks.


Python installs as python3.13 or some other major.minor version.
"python3" is a symlink to that.

"python" may be a symlink to python 2.x, or 3.x, or not exist at all. I
am not aware of *any* scenario where a distributor has re-packaged
Python, "python" exists on PATH and is a real Python 3.x interpreter,
but "python3" doesn't exist.

I am not aware of this ever being an existing real world scenario in the
past, either -- it is not a "we no longer live in the bad old days"
scenario.

The only big change to how people deploy python was around the
unversioned "python" name.

Since 1996 and earlier, "python" was a symlink pointing to the "full"
name, "python1.4". The full name was created by "make altinstall".

And "make install" had a Makefile dependency on "altinstall", and then
additionally created symlinks. You could run "install" for a full
default install, or "altinstall" if you wanted to install multiple
versions side by side.

Python 3.x originally didn't create a "python" symlink, only a "python3"
symlink, because too many people would have scripts running "python" and
expect it to be version 2.x; this problem obviously never existed for
"python3", as having the major version was new for "python3" and indeed
the whole point of adding a new "prog{MAJORVERSION}" was to avoid
confusing versions 2.x and 3.x

Anyways, yes, it is in my reasonably knowledgeable opinion flat out
*impossible* for


find_program('python')

to ever be a good idea when you could do

find_program('python3')

The former will correctly work in a strict subset of cases that the
latter already works; in some cases it seems to work but returns a bad
program; in some cases it fails but using the right name would work.


--=20
Eli Schwartz

--------------1z0sER8caQNH3hpMBWTyALJL--

--------------j95jdjUi2L9cciyEiXYxuxKC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaG7rtgUDAAAAAAAKCRCEp9ErcA0vVxCU
AP4l9nAIn4ctgW6nb5rRu9JBR3KgkDF3mn1XdvU234hj7AD+JzPjx+egcK18wMx+I2taCH+UenNz
o0pDQCPblSmg2wc=
=Le2e
-----END PGP SIGNATURE-----

--------------j95jdjUi2L9cciyEiXYxuxKC--

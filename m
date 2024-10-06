Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC93189BB6
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728245680; cv=none; b=ES7vo1b/JBowMM08l/NXE62gXPtzeLOIRE+23aYUO2+UQwyhIO6lgE25HcLRKSw1kVzcDXM0lpu2eY35TSeqWABGBCRw19Vs7sv3663fsNAOB2M3zz/MVvexZVoHDPnSxyK5H5kb/ZFP7vQ+6tmMNhdJym9tNV+jgvFSJOlOV2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728245680; c=relaxed/simple;
	bh=p3WbcBj8f8wJUK+OJCasr1RUXV2BYWIll6VSJdhMh7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoH2gQJqOc9Aa8pv0+UWjy4DDp96AgqLU7jWasnPqawUK3BzLaftn90PU2NmWLiCcoDcy55K3ecPKom59zV7zhuErAlawWraYdKnJ5rg13zsIFhoMPopl6UKZg/7i8hL1ZEklMpSgMvpGzMyjqi+vOvo3oi6w4+y3guTtLRcD6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <bef4ca0f-90e8-4105-bff6-9a4dbfb07c89@gentoo.org>
Date: Sun, 6 Oct 2024 16:14:35 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/21] Documentation: add comparison of build systems
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <cover.1727881164.git.ps@pks.im>
 <508e3783d284fd2d3bd4840907ed0bdc20bc1b23.1727881164.git.ps@pks.im>
 <xmqqjzeqmkwz.fsf@gitster.g>
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
In-Reply-To: <xmqqjzeqmkwz.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VwzFngfPYk3PLn0uz5XAFXXW"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------VwzFngfPYk3PLn0uz5XAFXXW
Content-Type: multipart/mixed; boundary="------------Z1V50Qqj7i1eLHrfYrmA9yeS";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Message-ID: <bef4ca0f-90e8-4105-bff6-9a4dbfb07c89@gentoo.org>
Subject: Re: [RFC PATCH 01/21] Documentation: add comparison of build systems
References: <cover.1727881164.git.ps@pks.im>
 <508e3783d284fd2d3bd4840907ed0bdc20bc1b23.1727881164.git.ps@pks.im>
 <xmqqjzeqmkwz.fsf@gitster.g>
In-Reply-To: <xmqqjzeqmkwz.fsf@gitster.g>

--------------Z1V50Qqj7i1eLHrfYrmA9yeS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/2/24 2:14 PM, Junio C Hamano wrote:
>> +=3D=3D=3D Rust support
>> +
>> +Many long-time Git contributors are nowadays in favor of adopting Rus=
t as a
>> +second language next to C. The build system SHOULD thus support Rust =
such that
>> +we do not have to reopen the discussion once we decide to pick up Rus=
t.
>=20
> What reasons do you have in mind that, without spelling this out,
> Rust will be left behind while C is fully supported?  If the build
> system can keep track of dependencies by knowing foo.o is made from
> foo.c and turning foo.c into foo.o takes running cc, it can do the
> same for rustc.  Do you mean include file dependencies and the like?


It's actually tremendously more complicated, speaking as someone who as
reviewed and dabbled with support for rustc in meson. :)

Rust can trivially compile a single source file into a single executable
fairly easily, and it looks much like running a C compiler. Correctly
invoking rustc in any more complicated project, such as but not limited t=
o:

- building an internal rust static library ("rlib", typically in the
  form of a crate)
- linking to a C library
- exporting a C library
- cross compilation
- proc-macros=3D

quickly turns into a maze of options to ensure correct linkage, and you
also have to pass special options to do name-mangling right down the
entire dependency tree. Note also that the rust compiler driver has
decided for its own reasons to *partially* not rely on the C compiler as
a linker driver (it passes -nodefaultlibs for "ideological reasons"), so
you have to detect the correct libraries that need to be referenced by a
staticlib using rustc --print native-static-libs and then order matters
and sanitizers are broken anyway.

In short, you really need a build system for Rust, you cannot just run
rustc, which means you need to make the decision about a build system if
you ever end up using Rust.



> If the reason why we say "Language X needs to be supported" is
> because it is not enough to be able to run a compiler on source
> files written in the language, but it is also necessary to know when
> to run the compiler (i.e., by dependency tracking), it is better to
> spell it out.


Dependency tracking is tame stuff and just table stakes for build
systems. :)


> In any case, instead of singling out Rust in the title, name the
> section "languate support", and give an enumeration of compilers
> languages, processors that we care about, just like we did for
> platforms.  For exaple, we may not necessarily want to treat "C
> support, done as an afterthought of supporting C++" and "C support,
> done natively" as equivalents (of course, the latter is better).
>=20
> Shouldn't it also "support" asciidoc/asciidoctor/makeinfo for
> the documentation toolchain?


Running asciidoc is pretty simple as it doesn't involve fiddly
domain-specific compiler internals. You just run a command -- the same
command everywhere -- with an "infile" and "outfile" parameter and the
asciidoc tool is essentially well behaved and does what you want it to
do. makeinfo isn't really any different.


> Are there other things we use Makefile for in our current system
> that we are forgetting in this requirements section, like "running
> lint" or "running tests"?
>=20
> Thanks.


--=20
Eli Schwartz

--------------Z1V50Qqj7i1eLHrfYrmA9yeS--

--------------VwzFngfPYk3PLn0uz5XAFXXW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZwLvqwUDAAAAAAAKCRCEp9ErcA0vV3dD
AQDs6z88M2bfcIH3jlKNAU0WHY56tAN1LIaG9OgoSc8HDAEA900iam0Sr0C8fHVY7/5jjm6mukTp
AQZTWShUqTlgJAI=
=Y/hh
-----END PGP SIGNATURE-----

--------------VwzFngfPYk3PLn0uz5XAFXXW--

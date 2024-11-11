Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862DD1BBBE0
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361700; cv=none; b=gDjPiIGgWUZVwteaku5o0qwRWz6iSqngOH652LNLZwBgRvwdpaBBAyU6A1UIjS19/6b7eh8x9yxmsYgMKV2NGN6siqCHdanyYB75vMvI0sBWDpPW+8EzwYrWENQhHDMgtrgygRhWbgUx3MDoy048MbJ0pzht3Q0laalKB6Bc8C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361700; c=relaxed/simple;
	bh=2Ytf7PnNjyzaSM19Q+G9fW7C1iiYAUWR1gNbeQdTPMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkDfBKDerpRtzd9fcvFyK55eGiMcgZycQEyDZS/6+6WjlebC3jWi8NNmfc6XHIeKtD9P6QiKFUF8/tWTM4jFlgicUHlcPevE8blTOTk4/EKliQ8Wx+6z/Bf+A0ED4biCwKwlIhCR6ejCnipYbw9CTiysU3PZyKLZZ+H9qecXERU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <89a2621f-2c30-473b-9a0c-48135244f33a@gentoo.org>
Date: Mon, 11 Nov 2024 16:48:14 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
To: Patrick Steinhardt <ps@pks.im>, David Aguilar <davvid@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <Zy9ckDezMSKVA5Qi@gmail.com>
 <ZzHeMjqUjzWpdX-Y@pks.im>
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
In-Reply-To: <ZzHeMjqUjzWpdX-Y@pks.im>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------sN4Ej20OrZWjYdFGD1vVbTy0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------sN4Ej20OrZWjYdFGD1vVbTy0
Content-Type: multipart/mixed; boundary="------------DM6iya0yZlGA7BDtLU7qRF9V";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>, David Aguilar <davvid@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <89a2621f-2c30-473b-9a0c-48135244f33a@gentoo.org>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <Zy9ckDezMSKVA5Qi@gmail.com>
 <ZzHeMjqUjzWpdX-Y@pks.im>
In-Reply-To: <ZzHeMjqUjzWpdX-Y@pks.im>

--------------DM6iya0yZlGA7BDtLU7qRF9V
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/11/24 5:36 AM, Patrick Steinhardt wrote:
> On Sat, Nov 09, 2024 at 04:58:56AM -0800, David Aguilar wrote:
>> The one thing that no one has mentioned is dependencies.
>>
>> CMake has less dependencies. Python is arguably a liability in the bui=
ld
>> system arena, and Meson requires it.
>=20
> Eli has menitoned [muon](https://muon.build/), which is a drop-in
> replacement for Meson written in plain C99. I don't know whether it is
> currently able to compile the Git project, but if this is going to be a=

> concern for people I can try to make sure that it does.

I was wondering whether I should say something, because I don't really
feel the criticism was on-target to begin with. But...

I am delighted to be able to confirm, that muon works quite well here.

It did require two small tweaks for not yet implemented features in
muon, that meson had and which this patch series depends on:

the iconv special dependency, which I provided a patch for:

https://git.sr.ht/~lattis/muon/commit/75d33f6b6d482344d969e4ad6ce1527353f=
91cce

using fallback from gnu99 to c11 for the sake of MSVC, which I reported
and got the muon developer to implement:

https://git.sr.ht/~lattis/muon/commit/a70e9687f3bfb8b9c21baf9acdfe84f97a4=
2b11f


(Note the commit author dates by the way. I had the same general thought
about whether muon could satisfy git users such as, frankly, ones more
interesting to me than "python has too many dependencies". Such as
perhaps HPE NonStop users, and I tried muon out a month ago. Yes -- even
though I am a *meson* maintainer, I consider this a useful alternative
to have. Meson's FAQ includes discussion about whether it makes sense to
require Python, and notes that we specifically avoided providing any
"provide your own python extensions" functionality because it would
prevent being able to ever rewrite in another not-python language. We
also document muon as an alternative in our FAQ.)


With these two small changes, muon compiles git successfully, and passes
all tests but one:



running tests for project 'git'
1030/1030 f:1 s:0 j:1
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D]
finished 1030 tests, 0 expected fail, 1 fail, 0 skipped
fail    9.32s t5324-split-commit-graph
stdout: 'ok 1 - setup repo
ok 2 - tweak umask for modebit tests
ok 3 - create commits and write commit-graph
ok 4 - check normal git operations: graph exists
ok 5 - add more commits, and write a new base graph
ok 6 - fork and fail to base a chain on a commit-graph file
ok 7 - add three more commits, write a tip graph
ok 8 - check normal git operations: split commit-graph: merge 3 vs 2
ok 9 - add one commit, write a tip graph
ok 10 - check normal git operations: three-layer commit-graph: commit 11
vs 6
ok 11 - add one commit, write a merged graph
ok 12 - check normal git operations: merged commit-graph: commit 12 vs 6
ok 13 - create fork and chain across alternate
ok 14 - check normal git operations: alternate: commit 13 vs 6
ok 15 - test merge stragety constants
ok 16 - remove commit-graph-chain file after flattening
ok 17 - verify hashes along chain, even in shallow
ok 18 - verify notices chain slice which is bogus (base)
ok 19 - verify notices chain slice which is bogus (tip)
ok 20 - verify --shallow does not check base contents
ok 21 - warn on base graph chunk incorrect
ok 22 - verify after commit-graph-chain corruption (base)
ok 23 - verify after commit-graph-chain corruption (tip)
ok 24 - verify notices too-short chain file
ok 25 - verify across alternates
ok 26 - reader bounds-checks base-graph chunk
ok 27 - add octopus merge
ok 28 - check normal git operations: graph exists
ok 29 - split across alternate where alternate is not split
ok 30 - --split=3Dno-merge always writes an incremental
ok 31 - --split=3Dreplace replaces the chain
not ok 32 - handles file descriptor exhaustion
#=09
#		git init ulimit &&
#		(
#			cd ulimit &&
#			for i in $(test_seq 64)
#			do
#				test_commit $i &&
#				run_with_limited_open_files test_might_fail git commit-graph write \=

#					--split=3Dno-merge --reachable || return 1
#			done
#		)
#=09
ok 33 - split commit-graph respects core.sharedrepository 0666
ok 34 - split commit-graph respects core.sharedrepository 0600
ok 35 - --split=3Dreplace with partial Bloom data
ok 36 - prevent regression for duplicate commits across layers
ok 37 - setup repo for mixed generation commit-graph-chain
ok 38 - do not write generation data chunk if not present on existing tip=

ok 39 - do not write generation data chunk if the topmost remaining
layer does not have generation data chunk
ok 40 - write generation data chunk if topmost remaining layer has
generation data chunk
ok 41 - write generation data chunk when commit-graph chain is replaced
ok 42 - temporary graph layer is discarded upon failure
# failed 1 among 42 test(s)
1..42
'


--=20
Eli Schwartz

--------------DM6iya0yZlGA7BDtLU7qRF9V--

--------------sN4Ej20OrZWjYdFGD1vVbTy0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZzJ7ngUDAAAAAAAKCRCEp9ErcA0vV1Ny
AP9Z8qoa7/y0j08CJZ6Rml1+vL14Ll8TMtpwrf8diF6smwEA/uYgMfqk1nO76HOxTR+JpnRpQg8J
P/LuK2PiXJah4wg=
=3abW
-----END PGP SIGNATURE-----

--------------sN4Ej20OrZWjYdFGD1vVbTy0--

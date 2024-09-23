Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBA2184
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 02:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727056897; cv=none; b=PR4zq9Utz2U4TKuV1e7CaU/bWwfC/J3h5HKXUI7tBEB8MAQkchSa6XfxRlFh33hk4a8BXLv+oxgiYthBkCFqEepM3SZh5/kH5v9enJGxji9Le8+vrH2fD2eWn8F5N41zanXNL6QHV2PS//sifKoi5cmFzVuu9IziVqqKfxqsU1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727056897; c=relaxed/simple;
	bh=4ZJVOMv/I+wW4vV2bpaNx4p5x/bamvFBQ6UYc8e1Svo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YN/QKpgpfDRp1vFM1wqsiVyWfCjX1cNyY1S7gEnPpVuVl9PgQbnoMFfKL/hc/+WlU6b/vV5IZG8kJLHd1EfSYEPXwEtIF7NyaqwBbkNFhayoZSfH85cm8XSnCjVkmhh5wQYoH/7aG3U0xa1A083HnokL5vfN+TLqPgN9hPcUKd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <0864bd25-d5c4-45ac-a59e-e6f7d24002de@gentoo.org>
Date: Sun, 22 Sep 2024 22:01:32 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [TOPIC 08/11] Modern Build Systems
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <Zu2DmS30E0kKug2a@nand.local> <Zu2E3vIcTzywWOx3@nand.local>
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
In-Reply-To: <Zu2E3vIcTzywWOx3@nand.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------v008zLGQPjekQlxM42htIsv4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------v008zLGQPjekQlxM42htIsv4
Content-Type: multipart/mixed; boundary="------------jMrzUSuaVw9gMAgGSd9eg9Cy";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Message-ID: <0864bd25-d5c4-45ac-a59e-e6f7d24002de@gentoo.org>
Subject: Re: [TOPIC 08/11] Modern Build Systems
References: <Zu2DmS30E0kKug2a@nand.local> <Zu2E3vIcTzywWOx3@nand.local>
In-Reply-To: <Zu2E3vIcTzywWOx3@nand.local>

--------------jMrzUSuaVw9gMAgGSd9eg9Cy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/20/24 10:21 AM, Taylor Blau wrote:
> Modern Build System
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> (moderator: Patrick; notetaker: brian)
>=20
> * Patrick: three different build system; should get rid of at least one=

>   of them
>   * Should delete autoconf because it's not really maintained
>   * Think about a proper build system
>   * Obvious choice: cmake
> * Taylor: What's the problem with Makefiles
> * Patrick: Non-standard
>   * Meson is nicer than cmake as an alternative


I suppose I'm pretty biased but yes, I do feel we (meson) have managed
to make some great workflow improvements here. :)

Please do feel free to ask me questions about it.


> * Jonathan: xz compromise shows autoconf is a risk
> * Autoconf isn't a problem for distro
> * Taylor: distro builds that can't handle "make" without configure are =
a
>   distro problem


Anyone can handle "make" without configure without breaking a sweat,
that isn't even remotely challenging, and every distro already does it.
The problem is that "make" is stateless, which is another way of saying
it has amnesia. By that token, everyone cobbles together their own state
system on top of "make".

Admittedly, once set up it doesn't require much maintenance from version
bump to version bump.


> * Jonathan: Modern build system can reflect the structure of how your
>   code is set up
>   * Declared dependencies
> * Brian: Rust will make the decision for us: cargo


I would just like to note that this is not really true. There is one
other build system that supports rust and its name is... meson. :)

Meson supports rust as a language for creating libraries (cdylib or
rlib) and executables. You can import a crate from crates.io and meson
will synthesize the build system from the existing Cargo.toml to expose
it as an rlib dependency.

You still get full build script option parsing, system probing, control
flow etc using the meson.build DSL, you can freely mix libraries or
executables in any of meson's supported languages (C, C++, Cython, C#,
D, Fortran, java, ObjC, Rust, swift, Vala...), process custom commands
for data files, run gettext on translations, and more. Meson is designed
to be a polyglot build system in ways that cargo will probably never be.

Cargo is probably best thought of as a compiler wrapper: it can spit out
an executable if you run it on *.rs sources, but it doesn't replace most
of the interesting parts of a build system and it doesn't even provide
an "install" rule. No, `cargo install` does not count unfortunately as
it has a nasty habit of recompiling the binaries you already compiled,
but now with the wrong options.

You really want something that provides a project lifecycle workflow for
building, testing, installing, and making dist tarballs with integrated
distcheck. The current Makefiles mostly kind of work, given sufficient
care, but cargo provides exactly zero of anything so you're back to
cobbling together your entire workflow using Makefiles wrapped around
cargo. I would call that the very furthest opposite from "make the
decision for us".


>   * BSDs use Make (granted, not GNU make) for building
> * Patrick: Is anyone else in favour of a proper build system
>   * Ninja is way faster than make to build the projects


It is! Yes. Mostly because it does very, very little other than execute
a precalculated build graph, whereas the current Makefile runs a bunch
of stateless external commands each time in order to calculate top-level
Make variables.


> * Taylor: Feels odd to build with a fancy tool that might have a
>   dependency on Git
> * Dscho: --help is a autoconf feature and removed features are detected=

> * Patrick: Isn't that an argument for cmake over autoconf? Dscho: yes


cmake does not have an equivalent of ./configure --help. The best you
can get is to try to somehow successfully configure cmake once, and then
run a cmake command that prints every internal control flow variable
used by cmake, then hope that the ones you care about include description=
s.

(Say what you will about GNU autotools but they knew very well how to
write good interaction standards, as evidenced by all the Makefile
variables git.git already uses from the GNU Coding Standards docs on how
to architect a release process.) It is fundamental to the UX design of
=2E/configure that a user may query the build system to find out what
choices they can / are expected to make, before committing to those choic=
es.

cmake is actively a severe regression compared to autoconf for these
purposes.


> * Kyle: Editor integration is useful
> * brian: standard structure is helpful for LSPs


These tend to mostly be solved by compile_commands.json, which most
modern build systems can produce. In particular, anything that creates a
ninja file essentially gets you this for free, because ninja can create
one for you.

Plain Makefiles, and GNU automake, don't do very well at this at all,
since Make has too irregular a build graph to reliably compute any such
thing. Same reason why there isn't much in the way of dedicated editor
integration (both cmake and meson have introspection APIs which editor
plugins can use to directly query info from the build system, to provide
finer-grained control than what compile_commands.json can do).


> * Emily: libification has shown that makefile is cumbersome
> * Jonathan: Should we do a comparison of build systems in terms of what=

>   we need from them on the list? Similar to
>   Documentation/technical/unit-tests.txt
>   * Patrick: I can write such a thing.
> * Patrick: Are their any features we need to consider?
> * Johannes Sixt: Consider supported platforms
> * Patrick: Want to verify that cmake is up to the task by testing in CI=
?
>   * Will volunteer to post something to the list
>=20

--=20
Eli Schwartz
Gentoo Developer and Meson Build maintainer

--------------jMrzUSuaVw9gMAgGSd9eg9Cy--

--------------v008zLGQPjekQlxM42htIsv4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZvDL/AUDAAAAAAAKCRCEp9ErcA0vVym/
AP4po79kwTGhqFEyFJy/pm17mNA84YL2yTvecLPHsl7S1wD/fyU8wuS4nD99XyykU8icmMuu+cgi
voEVSDo/mZpXxQg=
=9TZO
-----END PGP SIGNATURE-----

--------------v008zLGQPjekQlxM42htIsv4--

Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9DF22615
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 01:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731200854; cv=none; b=FT7Kg4YdUJ4mdHktTz2ySHWgG4NLTFKawixqftCRJm9Y+O2bU3IJswm6Fw2mbOSaGGN9Kuz/t0cXUxdcaaoqXNZOeW4jNVfjTpLr4qhj5Ul/YEfMinIQq3ZssYj2m4deBg8HYj011R1w1ifJwkQr61NKRhN0yfO+KHwWQrESrnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731200854; c=relaxed/simple;
	bh=qfWObKawEBZo1N2ZNfBkOM9Xhg2ut7LMEsHOq7NW94o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=St+BIKPNAX2t1fRhOgxe6/qXI9Yj/ALZqYlng+J7P96J81nHokhjFz14DVgbExoopZliM6dd3gen/WFk7UiXsSWK45muIrBsrXcLH81iNHq6bpkMzgT6VKuJkWSMSgh04eVjyRibDH50sGwu1hXj6xJMIvUv8Gq+uSv34x6SzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <50d3373d-fc0c-42b6-8506-48ac03e085f2@gentoo.org>
Date: Sat, 9 Nov 2024 20:07:28 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
To: David Aguilar <davvid@gmail.com>, Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <Zy9ckDezMSKVA5Qi@gmail.com>
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
In-Reply-To: <Zy9ckDezMSKVA5Qi@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------k29bWSbHAd3X1XOutES54qNY"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------k29bWSbHAd3X1XOutES54qNY
Content-Type: multipart/mixed; boundary="------------4xiy3Nze9x0VCXU8EM6EbUzv";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: David Aguilar <davvid@gmail.com>, Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <50d3373d-fc0c-42b6-8506-48ac03e085f2@gentoo.org>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <Zy9ckDezMSKVA5Qi@gmail.com>
In-Reply-To: <Zy9ckDezMSKVA5Qi@gmail.com>

--------------4xiy3Nze9x0VCXU8EM6EbUzv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/9/24 7:58 AM, David Aguilar wrote:
>> Patrick Steinhardt wrote:
>>>   - Packagers. This is another group of people that would benefit fro=
m
>>>     my point of view. This is mostly because Meson has certain standa=
rds
>>>     for how to approach problems, and thus the packager would know fo=
r
>>>     how to handle things. They don't have to manually track build
>>>     options and changes thereof, as these can be easily discovered an=
d
>>>     because Meson will error out in case invalid options are passed.
>=20
> CMake's option() variables and its GNUInstallDirs module pretty much
> handles all of the standardization that packagers are looking for on
> this front, so this argument doesn't push the needle towards Meson over=

> CMake from my perspective.


The specific points brought by Patrick, which I guess you are disputing,
are that meson options are "easily discovered" and "will error out in
case invalid options are passed".


Obviously biased as a Meson maintainer, but

No. Absolutely not. CMake's option() variables are deeply, frustratingly
bad as a user experience, for one simple reason. They are
turing-complete and you cannot know they exist until you have
successfully configured cmake at least once. Even then, the only way to
find out about them is to execute a cmake subcommand that prints "cache
variables" rather than "options", since options are just cache variables
marked with an explanation.

In comparison, GNU autotools rigorously defined the standard GNU
interface to configuring a build. In a freshly extracted copy of the
source code, run

=2E/configure --help

It lists various options, split up by section e.g.


Installation directories:
  --prefix=3DPREFIX         install architecture-independent files in PRE=
FIX
                          [/usr/local]
  --exec-prefix=3DEPREFIX   install architecture-dependent files in EPREF=
IX
                          [PREFIX]

By default, `make install' will install all the files in
`/usr/local/bin', `/usr/local/lib' etc.  You can specify
an installation prefix other than `/usr/local' using `--prefix',
for instance `--prefix=3D$HOME'.

For better control, use the options below.

Fine tuning of the installation directories:
  --bindir=3DDIR            user executables [EPREFIX/bin]


It has additional sections for "optional features" / "optional
packages", and lists "Some influential environment variables" as well.
You do *not* need to successfully configure before seeing this help
text, and the same options always exist every time you run it.

Meson does something similar: in a freshly extracted source tree, run
"meson configure". It has some cool tricks, such as opening into a pager
if possible, and having table-formatted, colored output to make it easy
to distinguish between the option name, its default and allowed values,
and the description.

Meson splits the options table between core, base, compiler-specific,
directory standards, and project-specific options. All the options that
come from the project itself are further available in a single
meson_options.txt" / "meson.options" file at the root of the project,
you don't have to inspect thousands of lines of code to see where
option() might have been invoked, or figure out whether it was
transitively defined by including a module installed by a different
project to /usr/share/ECM/modules/ (???) that includes a third module
from /usr/share/cmake/Modules/ without which the option simply does not
exist at all.


CMake thus fails on both points raised by Patrick:

- cmake options *cannot* be easily discovered, and many people (myself
  included) would argue that they cannot be discovered at all, whether
  easily or otherwise

- since cmake options are, in fact, just cache variables, it logically
  cannot be an error to define options that don't exist. You are quite
  free to define any cache variables you want, whether they exist or
  not, and cmake is entirely unconcerned with your doing so. Define a
  "NOT_AN_OPTION" variable that doesn't exist? ok, no effect -- no part
  of the build attempts to dereference ${NOT_AN_OPTION} so it is simply
  ignored.

=2E..

GNUInstallDirs is... workable, sort of, but is also a tremendous footgun
as you have to manually set it up and most people do not. Being able to
work around the bad defaults is better than nothing, sure. No one is
forcing any given project to use the bad defaults. But I'd hardly call
that a ringing endorsement.


> As someone that was once a New Contributor, I would be more comfortable=

> with CMake (over Meson) because it's widespread and because it has
> less dependencies.


I just took a look at cmake's dependencies on my Gentoo system. It
appears to have a whole lot of them.


RDEPEND=3D"
        >=3Dapp-arch/libarchive-3.3.3:=3D
        app-crypt/rhash:0=3D
        >=3Ddev-libs/expat-2.0.1
        >=3Ddev-libs/jsoncpp-1.9.2-r2:0=3D
        >=3Ddev-libs/libuv-1.10.0:=3D
        >=3Dnet-misc/curl-7.21.5[ssl]
        sys-libs/zlib
        virtual/pkgconfig
        dap? ( dev-cpp/cppdap )
        gui? (
                !qt6? (
                        dev-qt/qtcore:5
                        dev-qt/qtgui:5
                        dev-qt/qtwidgets:5
                )
                qt6? ( dev-qt/qtbase:6[gui,widgets] )
        )
        ncurses? ( sys-libs/ncurses:=3D )
"

It also is written in C++.

meson is written in python, so it depends on that. And of course on
ninja (for unix systems). It has no other dependencies, period, end of
story.

Although like cmake, it depends on my system on virtual/pkgconfig -- for
both packages, that pkgconfig dependency is a convenience since software
has a habit of using build system functions such as "pkg_check_modules"
(cmake) or "dependency" (meson) with almost universal regularity, so
it's easier than having tens of thousands of packages all depend on
virtual/pkgconfig.

cmake is easily installed from their website as a prebuilt binary with
all dependencies bundled inside, I suppose. So that is "less
dependencies"? But meson releases a prebuilt binary redistributable as a
Windows MSI as well -- and on Linux, python is usually preinstalled.
There's no *demand* for a prebuilt binary redistributable for Linux. If
there was, we already have the packaging scripts to make one, and it's
how I test the operation of the Windows MSI.

By the way, Python 3.6 to 3.10 use C89 "with several select C99
features". There are people who consider CMake's C++ requirement an
insurmountably steep obstacle, e.g. that is why OpenSSL refuses to use
any build system other than their own custom one written in Perl.


> The one thing that no one has mentioned is dependencies.
>=20
> CMake has less dependencies. Python is arguably a liability in the buil=
d
> system arena, and Meson requires it.


Please explain more about this. I don't really understand what you mean
by "a liability", nor how it is "more dependencies" than cmake.


> Furthermore, if you must have your fast Ninja builds then CMake support=
s
> that too, but, critically, it's optional. If you don't have Ninja then
> you can use CMake's Makefile generator. Meson, OTOH, requires
> Ninja. CMake seems like a more pragmatic option in that regard.
>=20
> Sorry for derailing this thread to share my Meson vs. CMake opinion, bu=
t
> if the main con that the Meson website has to say about CMake is, "The
> scripting language is cumbersome to work with. Some simple things are
> more complicated than necessary." [1] then my general feeling is that
> it's not a very strong reason for Git's needs.
>=20
> [1] https://mesonbuild.com/Comparisons.html#cmake


Those are "some pros and cons", not all pros and cons, and it may
surprise you to hear that that page is not well maintained because a) no
one is strongly motivated to do so, b) no one feels passionately about
making an anti-cmake rant part of the core documentation.

That page was written once in 2014 and essentially never touched since,
though tree-wide formatting tweaks were made and the documentation
switched hosting and git imported into the main git repository in 2017.


> I concur with that. As someone that deals with packaging I strongly
> prefer tools that have minimal dependencies, just like Git. Meson
> brings along extra requirements (namely Python, as I mentioned before)
> whereas CMake requires just a C++ compiler and Make.


=2E.. wait, so is this or isn't this about the dependencies for building
and installing cmake, rather than merely running it?

CMake depends on projects that build with cmake, by the way. This is the
hell dimension of distro packaging.

(It also depends on jsoncpp which builds with meson, incidentally.)



--=20
Eli Schwartz

--------------4xiy3Nze9x0VCXU8EM6EbUzv--

--------------k29bWSbHAd3X1XOutES54qNY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZzAHUAUDAAAAAAAKCRCEp9ErcA0vVwud
AP9rDcSzYkDwRey0K1rN2J59m4Qyg8z+1ONVY2XlXGXDDwD+OA/415FUEwUKiA5VjH3wXu/Fk92A
GqL3oohkJsyLmA0=
=j5d9
-----END PGP SIGNATURE-----

--------------k29bWSbHAd3X1XOutES54qNY--

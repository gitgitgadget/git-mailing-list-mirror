Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7611DB128
	for <git@vger.kernel.org>; Thu, 15 May 2025 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331489; cv=none; b=AT0c5mV0XRyZDLRtGf8sgTQDd8/ks6Arsar8kf8oPx/5KNuQUp3kwiPoHwB1GSQM1/lxejshxIXxVmcStyobf3szxsCiPtS219EpcmdKD0fwdyb/dHYnZY7VEvZa5DUgueFGYFLk5TgtHfyEalvFXCNmp3/YrmIP/mcyDkSisus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331489; c=relaxed/simple;
	bh=OzfqOlbpYApaD1Swlp7PU5RsBYo9GUcINzpusaRj9vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMw+aEfT6f0GsIzydxpNEt42tCJmSIh7ZXK7Rk5vFGLkGnwd/Q6xCAGyZDBv5qNrnVkqQUQULFrD3JDbmsxX1+LfzcZf6I8cDizyhjgHef2T87euaqtIO27C+rWuArOnp4g4or/pryhgDXCHFFB353DrFzQQPxd86d92zn/Cq00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 28A5234372D;
	Thu, 15 May 2025 17:51:26 +0000 (UTC)
Message-ID: <8ca4ebd7-1058-4694-ba50-baf248b45050@gentoo.org>
Date: Thu, 15 May 2025 13:51:23 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] meson: correct path to system config/attribute
 files
To: Ramsay Jones <ramsay@ramsayjones.plus.com>, Patrick Steinhardt <ps@pks.im>
Cc: 'GIT Mailing-list ' <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-4-ramsay@ramsayjones.plus.com>
 <aCQdznsNfaIeSPDI@pks.im>
 <a163d515-2e71-4a42-b843-26d5d2ccdc59@ramsayjones.plus.com>
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
In-Reply-To: <a163d515-2e71-4a42-b843-26d5d2ccdc59@ramsayjones.plus.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZYJV3v0gzM3NtsxIZZiLQMmD"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ZYJV3v0gzM3NtsxIZZiLQMmD
Content-Type: multipart/mixed; boundary="------------8Rk6aR7L2gwMIO6fGwmCMgk0";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>, Patrick Steinhardt <ps@pks.im>
Cc: 'GIT Mailing-list ' <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Message-ID: <8ca4ebd7-1058-4694-ba50-baf248b45050@gentoo.org>
Subject: Re: [PATCH v2 3/5] meson: correct path to system config/attribute
 files
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-4-ramsay@ramsayjones.plus.com>
 <aCQdznsNfaIeSPDI@pks.im>
 <a163d515-2e71-4a42-b843-26d5d2ccdc59@ramsayjones.plus.com>
In-Reply-To: <a163d515-2e71-4a42-b843-26d5d2ccdc59@ramsayjones.plus.com>

--------------8Rk6aR7L2gwMIO6fGwmCMgk0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 5/15/25 12:42 PM, Ramsay Jones wrote:
>=20
>=20
> On 14/05/2025 05:36, Patrick Steinhardt wrote:
>> On Tue, May 13, 2025 at 08:17:24PM +0100, Ramsay Jones wrote:
>>> diff --git a/meson.build b/meson.build
>>> index 48f31157a0..7f811030bd 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -769,6 +767,20 @@ libgit_c_args =3D [
>>>    '-DSHELL_PATH=3D"' + fs.as_posix(target_shell.full_path()) + '"',
>>>  ]
>>> =20
>>> +system_attributes =3D get_option('gitattributes')
>>> +if system_attributes !=3D ''
>>> +  libgit_c_args +=3D '-DETC_GITATTRIBUTES=3D"' + system_attributes +=
 '"'
>>> +else
>>> +  libgit_c_args +=3D '-DETC_GITATTRIBUTES=3D"' + get_option('sysconf=
dir') + '/gitattributes"'
>>> +endif
>>> +
>>> +system_config =3D get_option('gitconfig')
>>> +if system_config !=3D ''
>>> +  libgit_c_args +=3D '-DETC_GITCONFIG=3D"' + system_config + '"'
>>> +else
>>> +  libgit_c_args +=3D '-DETC_GITCONFIG=3D"' + get_option('sysconfdir'=
) + '/gitconfig"'
>>> +endif
>>
>> Nit: I still think that we should use `get_option('sysconfdir') /
>> 'gitattributes'`, with the slash instead of a plus, mostly because it =
is
>> more idiomatic and reads better. But that alone doesn't warrant a
>> reroll.
>=20
> OK, if I need to re-roll, I will fix this up. (but see below)
>=20
>>>  editor_opt =3D get_option('default_editor')
>>>  if editor_opt !=3D '' and editor_opt !=3D 'vi'
>>>    libgit_c_args +=3D '-DDEFAULT_EDITOR=3D"' + editor_opt + '"'
>>> diff --git a/meson_options.txt b/meson_options.txt
>>> index 8547c0eb47..ff877e67ce 100644
>>> --- a/meson_options.txt
>>> +++ b/meson_options.txt
>>> @@ -3,9 +3,9 @@ option('default_pager', type: 'string', value: 'less'=
,
>>>    description: 'Fall-back pager.')
>>>  option('default_editor', type: 'string', value: 'vi',
>>>    description: 'Fall-back editor.')
>>> -option('gitconfig', type: 'string', value: '/etc/gitconfig',
>>> +option('gitconfig', type: 'string', # default 'etc/gitconfig'
>>>    description: 'Path to the global git configuration file.')
>>> -option('gitattributes', type: 'string', value: '/etc/gitattributes',=

>>> +option('gitattributes', type: 'string', # default 'etc/gitattributes=
'
>>>    description: 'Path to the global git attributes file.')
>>
>> I'd prefer if we documented the default value in the description.
>> Otherwise it is impossible to discover it without having a look at the=

>> sources.
>=20
> Hmm, but how do you get the description! :)
>=20
>=20
> I applied the following patch on top:
>=20
>   diff --git a/meson.build b/meson.build
>   index 28276e5305..bd14bc15a1 100644
>   --- a/meson.build
>   +++ b/meson.build
>   @@ -771,14 +771,14 @@ system_attributes =3D get_option('gitattributes=
')
>    if system_attributes !=3D ''
>      libgit_c_args +=3D '-DETC_GITATTRIBUTES=3D"' + system_attributes +=
 '"'
>    else
>   -  libgit_c_args +=3D '-DETC_GITATTRIBUTES=3D"' + get_option('sysconf=
dir') + '/gitattributes"'
>   +  libgit_c_args +=3D '-DETC_GITATTRIBUTES=3D"' + get_option('sysconf=
dir') / 'gitattributes"'
>    endif
>   =20
>    system_config =3D get_option('gitconfig')
>    if system_config !=3D ''
>      libgit_c_args +=3D '-DETC_GITCONFIG=3D"' + system_config + '"'
>    else
>   -  libgit_c_args +=3D '-DETC_GITCONFIG=3D"' + get_option('sysconfdir'=
) + '/gitconfig"'
>   +  libgit_c_args +=3D '-DETC_GITCONFIG=3D"' + get_option('sysconfdir'=
) / 'gitconfig"'
>    endif
>   =20
>    editor_opt =3D get_option('default_editor')
>   diff --git a/meson_options.txt b/meson_options.txt
>   index ff877e67ce..7a4b896f7e 100644
>   --- a/meson_options.txt
>   +++ b/meson_options.txt
>   @@ -4,9 +4,9 @@ option('default_pager', type: 'string', value: 'less'=
,
>    option('default_editor', type: 'string', value: 'vi',
>      description: 'Fall-back editor.')
>    option('gitconfig', type: 'string', # default 'etc/gitconfig'
>   -  description: 'Path to the global git configuration file.')
>   +  description: 'Path to the global git configuration file. (default:=
 etc/gitconfig)')
>    option('gitattributes', type: 'string', # default 'etc/gitattributes=
'
>   -  description: 'Path to the global git attributes file.')
>   +  description: 'Path to the global git attributes file. (default: et=
c/gitattributes)')
>    option('pager_environment', type: 'string', value: 'LESS=3DFRX LV=3D=
-c',
>      description: 'Environment used when spawning the pager')
>    option('perl_cpan_fallback', type: 'boolean', value: true,
> ----
>=20
> So, the addition of the '(default: <value>)' to the description field i=
s
> intended to mimic the setup help text for the built-in meson options:
>=20
>   $ meson help setup
>   usage: meson setup [-h] [--prefix PREFIX] [--bindir BINDIR] [--datadi=
r DATADIR]
>  =20
>   ...
>  =20
>   options:
>     -h, --help                            show this help message and ex=
it
>     --prefix PREFIX                       Installation prefix (default:=

>                                           /usr/local).
>     --bindir BINDIR                       Executable directory (default=
: bin).
>     --datadir DATADIR                     Data file directory (default:=
 share).
>     --includedir INCLUDEDIR               Header file directory (defaul=
t:
>                                           include).
>     --infodir INFODIR                     Info page directory (default:=

>                                           share/info).
>     --libdir LIBDIR                       Library directory (default:
>                                           lib/x86_64-linux-gnu).
>     --licensedir LICENSEDIR               Licenses directory (default: =
).
>     --libexecdir LIBEXECDIR               Library executable directory =
(default:
>                                           libexec).
>     --localedir LOCALEDIR                 Locale data directory (defaul=
t:
>                                           share/locale).
>     --localstatedir LOCALSTATEDIR         Localstate data directory (de=
fault:
>                                           var).
>     --mandir MANDIR                       Manual page directory (defaul=
t:
>                                           share/man).
>     --sbindir SBINDIR                     System executable directory (=
default:
>                                           sbin).
>     --sharedstatedir SHAREDSTATEDIR       Architecture-independent data=
 directory
>                                           (default: com).
>     --sysconfdir SYSCONFDIR               Sysconf data directory (defau=
lt: etc).
>  =20
>   ...
>  =20
>   $=20
>=20
> Indeed, there appears to be no way to display the project specific opti=
ons
> to the user *before* configuring a build directory.=20
>=20
>   $ pwd
>   /home/ramsay/git
>   $ meson introspect --buildoptions
>   Current directory is not a meson build directory.
>   Please specify a valid build dir or change the working directory to i=
t.
>   $=20
>=20
> Note that I don't recommend 'meson introspect --buildoptions' as a mean=
s
> for the user to inspect the available options, but it does allow me to
> check that the description field looks correct:
>=20
>   $ meson introspect --buildoptions build | jq | grep gitconfig
>       "name": "gitconfig",
>       "description": "Path to the global git configuration file. (defau=
lt: etc/gitconfig)"
>   $ meson introspect --buildoptions build | jq | grep gitattributes
>       "name": "gitattributes",
>       "description": "Path to the global git attributes file. (default:=
 etc/gitattributes)"
>   $=20
>=20
> The only way I have found to display the project options to the user (a=
fter
> configuring the project) is using 'meson configure', thus: =20
>  =20
>   $ meson configure build
>  =20
>   ...
>=20
> Note that this display shows the *current* value, not the default value=
, and
> (once again) in this case there really isn't a default value! ;) (iff p=
refix
> is exactly '/usr', then the 'default' is eg. '/etc/gitconfig').
>=20
> Of course, the current value would be the default value unless you have=

> set the value on the command-line (of which you would presumably be awa=
re).


Well, so-so.


eschwartz@acleverhostname ~/git/git $ meson configure .

meson.build:208:0: ERROR: None of values [] are supported by the C
compiler. Possible values for option "C_std" are ['none', 'c89', 'c99',
'c11', 'c17', 'c18', 'c2x', 'c23', 'gnu89', 'gnu99', 'gnu11', 'gnu17',
'gnu18', 'gnu2x', 'gnu23']


But also,

$ sed -i '/c_std=3D/d' meson.build && PAGER=3Dcat COLUMNS=3D80 meson conf=
igure .

WARNING: The source directory instead of the build directory was specifie=
d.
WARNING: Only the default values for the project are printed.

Core properties:
  Source dir /home/eschwartz/git/git

Main project options:

  Core options       Default Value        Possible Values
Description
  --------------     -------------        ---------------
-----------
  auto_features      auto                 [enabled, disabled,  Override
value of
                                           auto]               all
'auto'
                                                               features


[...]


I'm not completely certain why this evaluates as an empty node:

```(meson.version().version_compare('>=3D1.3.0') ? 'gnu99,c11' : 'gnu99')=

```


but it (meson configure) is part of the AST interpreter, not the runtime
one, which I know less about...


--=20
Eli Schwartz

--------------8Rk6aR7L2gwMIO6fGwmCMgk0--

--------------ZYJV3v0gzM3NtsxIZZiLQMmD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaCYpmwUDAAAAAAAKCRCEp9ErcA0vV7nm
AQDJRZ6VQVlQoMkNRqxbtYxvAWPA2I3Ot/z3hem5oBlw7wEAv3S/tOu3YJ1TayvST/p7NMlesv00
sDQIX/1f20Ukhw8=
=cEIR
-----END PGP SIGNATURE-----

--------------ZYJV3v0gzM3NtsxIZZiLQMmD--

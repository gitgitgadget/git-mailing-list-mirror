Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E52156228
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745619681; cv=none; b=fCcUHqwG+mUgLVFTYEKcoPCDeUAe0nkayB2950k8f/U2jHtqM1g5tu0LkvCMug1XDFzE3zz+p9XPTqYu70/VTZ9dfRskL67mChtKaeVcn+iA33N5KTpe2aL+08BF1TM8TXhfyaB1opdy8VdH7UiUU25+BgTaKje9q5DV0TZMYx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745619681; c=relaxed/simple;
	bh=M7bGRch/ohGqi9P+HG9VHkqiN8309n077SoNSZGMEYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBK2eXUobvXuPic1A2588W+ON5sUvIuWv8Cwp/0LezzJrPxVD8mCdh6pJDMiGocHiBZCBLVteuTmgNVkSOWhTMRhTrMKRkn+yPfPqx+7ZZKT9FgQNaMJw287CR1JGygYMifR1WmZEkQ45srWkfoIhludDjcb5FWCJwLpt1F9fU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 506A233FE7D;
	Fri, 25 Apr 2025 22:21:16 +0000 (UTC)
Message-ID: <27b77b6b-d696-4837-89fe-b359ce481083@gentoo.org>
Date: Fri, 25 Apr 2025 18:21:13 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] meson: prefer shell at "/bin/sh"
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Peter Seiderer <ps.report@gmx.net>, Justin Tobler <jltobler@gmail.com>
References: <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
 <20250425-pks-meson-posix-shell-v3-2-01607a2e9334@pks.im>
 <xmqqy0votbns.fsf@gitster.g>
 <06e57780-9f59-4166-81d3-9cd0c1c66b7e@gentoo.org>
 <xmqqcyd0t6qx.fsf@gitster.g>
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
In-Reply-To: <xmqqcyd0t6qx.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------RpB3S7o9xw26RJsN0ZSpknCU"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------RpB3S7o9xw26RJsN0ZSpknCU
Content-Type: multipart/mixed; boundary="------------ebiUno24Hjrdvjj0CbTl2blw";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Peter Seiderer <ps.report@gmx.net>, Justin Tobler <jltobler@gmail.com>
Message-ID: <27b77b6b-d696-4837-89fe-b359ce481083@gentoo.org>
Subject: Re: [PATCH v3 2/2] meson: prefer shell at "/bin/sh"
References: <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
 <20250425-pks-meson-posix-shell-v3-2-01607a2e9334@pks.im>
 <xmqqy0votbns.fsf@gitster.g>
 <06e57780-9f59-4166-81d3-9cd0c1c66b7e@gentoo.org>
 <xmqqcyd0t6qx.fsf@gitster.g>
In-Reply-To: <xmqqcyd0t6qx.fsf@gitster.g>

--------------ebiUno24Hjrdvjj0CbTl2blw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/25/25 2:51 PM, Junio C Hamano wrote:
> Eli Schwartz <eschwartz@gentoo.org> writes:
>> POSIX does not require a specific absolute file path for "sh", but it
>> does mandate that you have a shell and its name is "sh", whichever
>> directory it may be found in.
>> ...
>> There is (most of the time) not actually a program called "sh". Variou=
s
>> different programs may provide a symlink "sh", pointing to their own s=
hell:
>=20
> Exactly.  And with many systems being personal these days, /bin/sh
> may point at a shell that is better for interactive use (like
> "bash"), while the user may prefer another (like "dash") scripted
> use that is not pointed by that single /bin/sh symbolic link.


I would argue 100% of interactive bash users, are running "bash" to get
it. They are not running "sh" and then rewriting all scripts in /usr/bin
from

#!/bin/sh

to

#!/usr/bin/dash

for the speedup.

The point is that if users set the "non-interactive scripts" command
/bin/sh to GNU bash, they are fine with that being used everywhere (and
it will in fact run all Git's scripts well).


> In any case, we live in real world where things are not strictly
> POSIX.  Our Makefile does support with SHELL_PATH "sh", "dash", and
> "bash" just fine.  Why shouldn't I wish for feature parity in a new
> build framework that aims to at least compete and become an
> alternative?


But it's a very fair point that it's possible to need more than just
POSIX. Meson can override program lookup:

$ cat paths.ini

[binaries]
sh =3D '/usr/bin/bash'

$ meson setup builddirbash/ --native-file=3Dpaths.ini
[...]
  Runtime executable paths
    perl        : /usr/bin/perl
    python      : /usr/bin/python3
    shell       : /usr/bin/bash


A dedicated build option might be more discoverable, but it's certainly
possible to override this today. Autodetecting the right one can be
tricky...


--=20
Eli Schwartz

--------------ebiUno24Hjrdvjj0CbTl2blw--

--------------RpB3S7o9xw26RJsN0ZSpknCU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaAwK2QUDAAAAAAAKCRCEp9ErcA0vV2Te
AQDuzG5G9+9FAz1MApdfKzt9FiWaT4G2UyrXulzB7D4CdwD/TwBBT30/DEyLxEyNROb2XUXbg2lq
NLHlM/A7xyprIAM=
=QExh
-----END PGP SIGNATURE-----

--------------RpB3S7o9xw26RJsN0ZSpknCU--

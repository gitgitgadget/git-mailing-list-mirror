Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD721E3DED
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765694759; cv=none; b=qtJU/2yZ43V6V1w1LlzTgR6J2hDMg/b8E+lvrbL62nbciTPxYYKGtIIjJvDVmDYzjY39M3D5t++lu55Zltyft9vrMTqQipmefAh7wuAW0PVBOg1ddv4I49ba7X5S8OzHIFMMRaSqWdNwG7u/JujWNn0ZZ9B7/GooKXPvOLaWfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765694759; c=relaxed/simple;
	bh=qNPkEAAWajD3zUN6PjvI/VM/1s6T/6LWvaSGgQ2WbPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jISfvekIGwf6HwOQk8gRaIp5k1Y27e1k7Z74r6Yj0zmUkbZp7SDMUXqzionHFaUx7Ctb5WGGna8K7YJSU3rTx+jpdQ7Ta7GIJswZeslbeyfaOL9lCVrPRL6JoqS+UUXy/9SvoCOVM5q1ceYcjQq2xtkbONMNX0ayKDI3sQDab10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=REyVg/pN; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="REyVg/pN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765694745; x=1766299545; i=tboegi@web.de;
	bh=9mvqfP82qGPeMTEhab7GEjaECFt+EOiVYtdnTAmLJ4Q=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=REyVg/pNxQR3w2YYU/VT1RGWikmvNGyn/YhkkSG8EiLY3ne08i4cmegd8Q35TIcD
	 MtmgJAqHenisOrkjPcihdzPpZ6zYnl+Y1/2TRZoxRMMmfYH2aF6HhMAavgeB8pTtU
	 wHwDE3Jaie2KwFCUXqg9qUOdCWvSXgoXDrcMjkO46siKk3jqGLcmGx2KXg48M227r
	 1r3jdcnRGhIhmTK8QsiyOd3APoAW/8TzQ/q708Qqbmq5EgleXPmJkd9rN3FfvdpHo
	 vydO27kxRfkhoTMV7AegV1vg6EZXT/mesggsFi4osU4PuSdrqhYJeLGfFeFsSrSrT
	 i61TbN8Fa/nBDPlylA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.224.105.209]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9qhD-1vPQWy384L-000dfh; Sun, 14
 Dec 2025 07:45:45 +0100
Date: Sun, 14 Dec 2025 07:45:44 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,
	Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Koji Nakamaru <koji.nakamaru@gree.net>,
	Yee Cheng Chin <ychin.macvim@gmail.com>
Subject: Re: [PATCH v2 1/2] Makefile: add NO_HOMEBREW
Message-ID: <20251214064544.GA26358@tb-raspi4>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <fe00aa37-e929-4ca6-ac23-84a693a48bc6@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fe00aa37-e929-4ca6-ac23-84a693a48bc6@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:9+wiTZaVsgQSTQEEyZt76uPtvij6MbzjJdzCcNz6fuPHbnMc0vL
 EUawZHQfAXM4BK06GixPMLtEe1Gt2qrkjkfLGX0vX7SyZyplDSxhqgfawOy37hU38IiT1Gh
 0QFuuMpuJXo5i5eSqVbCAuV+BE4W2X7uR+N3JKCFgxn2ZXIviT8iSNzdlcdM6l9s2THR2Mq
 LMnCpJEL5Z+iOxym2QCSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KI9VRFN6ybY=;/jsJBM/FsmHF2Ks0Hrac0YgeoEZ
 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
 /3WjxA0y89H2YFM4h9h0cInJ7F6T32OnWeD62R

On Sat, Dec 13, 2025 at 07:42:38PM +0100, Ren=E9 Scharfe wrote:
> Allow disabling the use of Homebrew on macOS, or Linux for that matter,
> like we already do for other package sources, MacPorts and Fink in
> particular.  This is useful for packagers, or anyone else who wants to
> control dependencies.

Good.
>=20
> Suggested-by: Carlo Marcelo Arenas Bel=F3n <carenas@gmail.com>
> Suggested-by: Torsten B=F6gershausen <tboegi@web.de>
> Signed-off-by: Ren=E9 Scharfe <l.s.r@web.de>
> ---
>  Makefile         | 17 +++++++++++++++++
>  config.mak.uname | 11 +++++------
>  2 files changed, 22 insertions(+), 6 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 6fc322ff88..dbd2760d18 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -100,6 +100,9 @@ include shared.mak
>  # specify your own (or DarwinPort's) include directories and
>  # library directories by defining CFLAGS and LDFLAGS appropriately.
>  #
> +# Define NO_HOMEBREW if you have Homebrew and don't want Git to link
> +# against libraries installed by it.
> +#
Good
>  # Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac OS X
>  # and do not want to use Apple's CommonCrypto library.  This allows you
>  # to provide your own OpenSSL library, for example from MacPorts.
> @@ -1692,6 +1695,20 @@ ifeq ($(uname_S),Darwin)
>  	PTHREAD_LIBS =3D
>  endif
> =20
> +ifndef NO_HOMEBREW
> +        ifdef HOMEBREW_PREFIX

Question from a homebrew newbie, kind of:
Where do the HOMEBREW_PREFIX (and other HOMEBREW...) come from,
and what do they do ?

Running
git grep HOMEBREW
gives
ci/install-dependencies.sh:     export HOMEBREW_NO_AUTO_UPDATE=3D1 HOMEBRE=
W_NO_INSTALL_CLEANUP=3D1

Whould it make sense to have a few words here as a comment ?

> +		BASIC_CFLAGS +=3D -I$(HOMEBREW_PREFIX)/include
> +		BASIC_LDFLAGS +=3D -L$(HOMEBREW_PREFIX)/lib
> +        endif
> +        ifdef HOMEBREW_GETTEXT_PREFIX
> +		BASIC_CFLAGS +=3D -I$(HOMEBREW_GETTEXT_PREFIX)/include
> +		BASIC_LDFLAGS +=3D -L$(HOMEBREW_GETTEXT_PREFIX)/lib
> +        endif
> +        ifdef HOMEBREW_MSGFMT
> +		MSGFMT =3D $(HOMEBREW_MSGFMT)
> +        endif
> +endif
> +
>  ifdef NO_LIBGEN_H
>  	COMPAT_CFLAGS +=3D -DNO_LIBGEN_H
>  	COMPAT_OBJS +=3D compat/basename.o
> diff --git a/config.mak.uname b/config.mak.uname
> index 1691c6ae6e..a6521575ee 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -153,10 +153,10 @@ ifeq ($(uname_S),Darwin)
>  	# `brew link --force gettext`, should be obsolete as of
>  	# https://github.com/Homebrew/homebrew-core/pull/53489
>          ifeq ($(shell test -d /usr/local/opt/gettext/ && echo y),y)
> -		BASIC_CFLAGS +=3D -I/usr/local/include -I/usr/local/opt/gettext/inclu=
de
> -		BASIC_LDFLAGS +=3D -L/usr/local/lib -L/usr/local/opt/gettext/lib
> +		HOMEBREW_PREFIX =3D /usr/local
> +		HOMEBREW_GETTEXT_PREFIX =3D /usr/local/opt/gettext
>                  ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt=
 && echo y),y)
> -			MSGFMT =3D /usr/local/opt/gettext/bin/msgfmt
> +			HOMEBREW_MSGFMT =3D /usr/local/opt/gettext/bin/msgfmt
>                  endif
>  	# On newer ARM-based machines the default installation path has change=
d to
>  	# /opt/homebrew. Include it in our search paths so that the user does =
not
> @@ -166,10 +166,9 @@ ifeq ($(uname_S),Darwin)
>  	# add gettext. The issue was fixed more than three years ago by now, a=
nd at
>  	# that point there haven't been any ARM-based Macs yet.
>          else ifeq ($(shell test -d /opt/homebrew/ && echo y),y)
> -		BASIC_CFLAGS +=3D -I/opt/homebrew/include
> -		BASIC_LDFLAGS +=3D -L/opt/homebrew/lib
> +		HOMEBREW_PREFIX =3D /opt/homebrew
>                  ifeq ($(shell test -x /opt/homebrew/bin/msgfmt && echo =
y),y)
> -			MSGFMT =3D /opt/homebrew/bin/msgfmt
> +			HOMEBREW_MSGFMT =3D /opt/homebrew/bin/msgfmt
>                  endif
>          endif
> =20
> --=20
> 2.52.0
>=20

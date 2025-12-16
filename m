Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24F19E968
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765911204; cv=none; b=p0eH970N9U7wavVVsSs8gKlLeNnQYDZPpJzxv67y7AhTlouTd+aFkugE0p2pzjea1z87YD+ek1ECIIyzz+A2XwnMMOZNMK+AIoJ0Bjl7VqXv7/6wtWuG2oW7+cQ/UsUsLWd3jfkmoqrtJBHXOj7czw7+VPvig02nVuGyGrdGoiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765911204; c=relaxed/simple;
	bh=SKDYxNfEcBKYfY/fMdoFoRreuJhaLFyNOQqnMe/uYfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ds2SSbSaqUOAZcUzQCiErG2d1uXgsqE/mAqWYNBL0GEKdwelPQv82uwS7n9+P0Sj+FlGhC3WTsKis7akj/DsCeMzs37VzAFOp8RKctRjoEW8hDonFoVlD+wF8R+kymieliEkCw5IgF3aGhiSOC3vN/Ew1UHGVMJtUJ8aV2xskMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ZdSgP9BH; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ZdSgP9BH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765911199; x=1766515999; i=l.s.r@web.de;
	bh=nIKcCjJb6kbQCgPj/DnLPSq1M/UfgTq9Wc9x9MaPnJs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZdSgP9BHUxX7y4YTsCpxhA+1605MZ9l8rnptkiGqyMxGSlewpbvrTZzQF6f+Euh9
	 v2eWHSGQyPKTAEc2+HovbKqVHKgC6f4tR6k726aFqxIr3hAiOcO4w6bWQbNVyFSk1
	 EX2R7w/ZfmLOjbtriI736/sja9jRpMTughHPMCPSZ9i731Z9q2Mna7Zz28riUBek0
	 720E1lqLBe3ozOdKOke4Ew0SRWhIZIHuBTFQh4cWUV4XqlJYqQQoI7/u3UURL2Iy7
	 dZhqA/72AW2XuyE2lPbCD+XvPb3pPcttlKShcYPXxb+Jx6ULTLvL/OgyBd+QV5LLx
	 a5Ytqf4Ts5EDd1dSpA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mkmzr-1wGycC1KIB-00kmFL; Tue, 16
 Dec 2025 19:53:19 +0100
Message-ID: <4e1e1e07-f16e-4e6f-ba1f-325124fbe6db@web.de>
Date: Tue, 16 Dec 2025 19:53:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 2/3] Makefile: Make all darwin into config.mak.uname
To: tboegi@web.de, git@vger.kernel.org
References: <20251215204522.1946504-1-tboegi@web.de>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20251215204522.1946504-1-tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UmgN6EyQk5vCG5Ul+np7Y/xgxB0EGdbq9R40dcdC9Hj/gmXDAdc
 X4gw3VTxbDsYZYC/GIZGTHizITW1etN19/ER5ISoxUfdq/K/IgrdN8hDEqBrXswl5V5trf1
 SBaX61t07icuzJhiF00ZC54n7nih802lNKd2SwdKxXetIYqU1PaoARqklUZtzyLyZfdtVy9
 itaKVSv0WbdFCPu1t4Maw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nR4HVWLHbWk=;AEojh2698pMmcq5Ex/SAqD2KS2T
 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

On 12/15/25 9:45 PM, tboegi@web.de wrote:
> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>=20
> Move all the Darwin stuff from Makefile into config.mak.uname,
> we need it there in the next commit.
>=20
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  Makefile         | 21 ---------------------
>  config.mak.uname | 18 ++++++++++++++++++
>  2 files changed, 18 insertions(+), 21 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 6de036e4e2..2d666c26e4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1672,27 +1672,6 @@ ifneq (,$(SOCKLEN_T))
>  	BASIC_CFLAGS +=3D -Dsocklen_t=3D$(SOCKLEN_T)
>  endif
> =20
> -ifeq ($(uname_S),Darwin)
> -        ifndef NO_FINK
> -                ifeq ($(shell test -d /sw/lib && echo y),y)
> -			BASIC_CFLAGS +=3D -I/sw/include
> -			BASIC_LDFLAGS +=3D -L/sw/lib
> -                endif
> -        endif
> -        ifndef NO_DARWIN_PORTS
> -                ifeq ($(shell test -d /opt/local/lib && echo y),y)
> -			BASIC_CFLAGS +=3D -I/opt/local/include
> -			BASIC_LDFLAGS +=3D -L/opt/local/lib
> -                endif
> -        endif
> -        ifndef NO_APPLE_COMMON_CRYPTO
> -		NO_OPENSSL =3D YesPlease
> -		APPLE_COMMON_CRYPTO =3D YesPlease
> -		COMPAT_CFLAGS +=3D -DAPPLE_COMMON_CRYPTO
> -        endif
> -	PTHREAD_LIBS =3D
> -endif
> -
>  ifndef NO_HOMEBREW
>  	ifdef HOMEBREW_PREFIX
>  		BASIC_CFLAGS +=3D -I$(HOMEBREW_PREFIX)/include
> diff --git a/config.mak.uname b/config.mak.uname
> index a926943141..44252dabcc 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -189,6 +189,24 @@ ifeq ($(uname_S),Darwin)
>          endif
> =20
>  	BASIC_LDFLAGS +=3D -framework CoreServices
> +	ifndef NO_FINK
> +		ifeq ($(shell test -d /sw/lib && echo y),y)
> +			BASIC_CFLAGS +=3D -I/sw/include
> +			BASIC_LDFLAGS +=3D -L/sw/lib
> +		endif
> +	endif
> +	ifndef NO_DARWIN_PORTS
> +		ifeq ($(shell test -d /opt/local/lib && echo y),y)
> +			BASIC_CFLAGS +=3D -I/opt/local/include
> +			BASIC_LDFLAGS +=3D -L/opt/local/lib
> +		endif
> +	endif
> +	ifndef NO_APPLE_COMMON_CRYPTO
> +		NO_OPENSSL =3D YesPlease
> +		APPLE_COMMON_CRYPTO =3D YesPlease
> +		COMPAT_CFLAGS +=3D -DAPPLE_COMMON_CRYPTO
> +	endif
> +	PTHREAD_LIBS =3D
>  endif
>  ifeq ($(uname_S),SunOS)
>  	NEEDS_SOCKET =3D YesPlease

This works if you set these variables on the make command line, but it
won't work when setting them in config.mak, which is the main place for
custom make variables.  That's because it's included last in Makefile:

include config.mak.uname
-include config.mak.autogen
-include config.mak

Ren=C3=A9


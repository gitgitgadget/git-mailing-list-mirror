Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE27A20229
	for <e@80x24.org>; Wed,  9 Nov 2016 09:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753467AbcKIJ3c (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 04:29:32 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34326 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753456AbcKIJ32 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 04:29:28 -0500
Received: by mail-wm0-f65.google.com with SMTP id p190so27956854wmp.1
        for <git@vger.kernel.org>; Wed, 09 Nov 2016 01:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CHKa8HgstippCusLtKM5a5pUnWKW9pecahymQiVjR20=;
        b=COC2a+1312aldV1mhlmc9R27YF406QmYpDlpKT73uXrxkTsqrfJpJs78Yz0+j7atfA
         KAoqYJ0aCwGsdRJmIObfj1ICRnt0hIvyz0nOIqv5wsFG4SHUtWXhb0anz1gedvBGgWeZ
         yAbLj6wOf5AbrlrPog0GmuDmCf5c45pVZq/et4AJt4rpEZH6E0DLsGbZEKYruB0TyzIO
         8N1maLQsYx6iBDgAAo/v3MgD0g5xjqqlytyx6M9kgZt+/ydJDsBHNeWHGjOJ69ZWgoxG
         MStE9JtyWZnxGjqhiTq0BrXV7YTH559YtqoHAPXuc5FuRrQKgdmQb9FMi1jjxFbfs/cB
         pJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CHKa8HgstippCusLtKM5a5pUnWKW9pecahymQiVjR20=;
        b=TMtpV5IVlaJzHVdwXQkg+ZhU3kGHQ+TYGjvT43dvNjKgoM96AiINSwKx7N/Th2F4hP
         mgkx1FPyYdTdMaf56HlXaLO0BLEt8ko38zuzmRt8bdeCi1FzA0YWO/31GRbGtH6Q/eox
         KUeBHvnTrD/9EJJYJSIjui62ABr0NpqawHEhAm2ZZDERJ48UMU628ObuP28/bI5txn5L
         RHIJxKAPyPrTuEJ3j5kKuqS9zcmWX3UifzKs14Eu6RGL6u86vGa2os2pmWkpJnhvFXHf
         EIlXKz23pl56vIdDtxFSL+Qwz97qcnoepCPdydQjwRwo7JdvJ828sA+D9+jp8JM4Jgjn
         5HgA==
X-Gm-Message-State: ABUngvdcox3jFa3SdmaR0Hz/f8iiZKQvNJ+NfIv/3g81XytsvuxWbhqxMqedhuSsO+nrOA==
X-Received: by 10.28.211.71 with SMTP id k68mr18989498wmg.21.1478683767430;
        Wed, 09 Nov 2016 01:29:27 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id c187sm24341771wmd.13.2016.11.09.01.29.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Nov 2016 01:29:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1 1/2] config.mak.in: set NO_OPENSSL and APPLE_COMMON_CRYPTO for macOS >10.11
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <11cc8bbd-2e67-f53a-c8f4-2244409fd6af@web.de>
Date:   Wed, 9 Nov 2016 10:29:26 +0100
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        gitster@pobox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0966CBE3-2F08-4B89-9716-4EEE3CE2526E@gmail.com>
References: <20161017002550.88782-1-larsxschneider@gmail.com> <20161017002550.88782-2-larsxschneider@gmail.com> <20161017095002.bbqyp2hkbuyau66t@sigill.intra.peff.net> <8C67FF53-C26F-4993-908F-A5183C5E48D9@gmail.com> <20161107172617.tlcrpwbjy2w7aoyc@sigill.intra.peff.net> <11cc8bbd-2e67-f53a-c8f4-2244409fd6af@web.de>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 Nov 2016, at 09:18, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> On 07.11.16 18:26, Jeff King wrote:
>> On Sun, Nov 06, 2016 at 08:35:04PM +0100, Lars Schneider wrote:
>>=20
>>> Good point. I think I found an even easier way to achieve the same.
>>> What do you think about the patch below?
>>>=20
>>> [...]
>>>=20
>>> diff --git a/Makefile b/Makefile
>>> index 9d6c245..f53fcc9 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1047,6 +1047,7 @@ ifeq ($(uname_S),Darwin)
>>> 		endif
>>> 	endif
>>> 	ifndef NO_APPLE_COMMON_CRYPTO
>>> +		NO_OPENSSL =3D YesPlease
>>> 		APPLE_COMMON_CRYPTO =3D YesPlease
>>> 		COMPAT_CFLAGS +=3D -DAPPLE_COMMON_CRYPTO
>>> 	endif
>>=20
>> That is much simpler.
> []
> I don't know if that is a correct solution.
>=20
> If I have Mac OS 10.12 and Mac Ports installed, I may want to use
> OPENSSL from Mac Ports.

Can't you define `NO_APPLE_COMMON_CRYPTO` in that case?=20
I think if you use OpenSSL then you don't need the Apple crypto lib, =
right?

- Lars


> How about this:
>=20
>=20
> diff --git a/Makefile b/Makefile
> index ee89c06..e93511f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1038,17 +1038,22 @@ ifeq ($(uname_S),Darwin)
>                ifeq ($(shell test -d /sw/lib && echo y),y)
>                        BASIC_CFLAGS +=3D -I/sw/include
>                        BASIC_LDFLAGS +=3D -L/sw/lib
> +                       HAS_OPENSSL =3D Yes
>                endif
>        endif
>        ifndef NO_DARWIN_PORTS
>                ifeq ($(shell test -d /opt/local/lib && echo y),y)
>                        BASIC_CFLAGS +=3D -I/opt/local/include
>                        BASIC_LDFLAGS +=3D -L/opt/local/lib
> +                       HAS_OPENSSL =3D Yes
>                endif
>        endif
>        ifndef NO_APPLE_COMMON_CRYPTO
>                APPLE_COMMON_CRYPTO =3D YesPlease
>                COMPAT_CFLAGS +=3D -DAPPLE_COMMON_CRYPTO
> +               ifndef HAS_OPENSSL
> +                       NO_OPENSSL =3D YesPlease
> +               endif
>        endif
>        NO_REGEX =3D YesPlease
>        PTHREAD_LIBS =3D
>=20


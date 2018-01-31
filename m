Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85511F404
	for <e@80x24.org>; Wed, 31 Jan 2018 17:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeAaRjA (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 12:39:00 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41428 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753158AbeAaRi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 12:38:59 -0500
Received: by mail-pg0-f68.google.com with SMTP id 141so5564pgd.8
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 09:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=Eoa7YoG+7SLImzp+34MCZOAsFlnjTaWWY/UAgtIB5cA=;
        b=sju/wiGC45hwGodYI/6IEG1t2F3OdeJocJZXlI8JRvE0lh+aRCIIlWIGUbvmbi0HCO
         pKkN0rrN5G9d5tdhzp5tlkA1Jg4P84rEO7RDFIc6dLpe0ZLhRPBdeWV4GxiNe8lTHPy5
         uzksLLqU3qt3Gf1WUNuyVaPSwFVl1gF+55nGPDnMCmjCzOhOsoJdlC8ai26f/0xGjgIi
         eW3flagWqBWW00XWEaqTSfdyOMrtyoULb95UCXEKwUYZX8CpN/9V3bWIz+FctklQsLe9
         sBd9J2yhkeIjcGJ/NF67Q2lq962rIE1i/RT8Iuyy0Sew4HpLeh1Ss8Y0c5ao+HLuk0c7
         otfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=Eoa7YoG+7SLImzp+34MCZOAsFlnjTaWWY/UAgtIB5cA=;
        b=azdqHF4N67fSJ4D7H5Qib5WixtRQQHCXkqfvV7XHu7VEN9GgKwhBkzDFvXib65aeSP
         Hb8UrffYcP4psIcFZrqwy4oT2FfwfEJzVuAW7seywO2SOHORJpYsHGTC6Wfb5dBMPw9e
         vf7Mmj5AKrVIG670tZ6T0pzh/otae6ggbxvp/MuADyyWuXru0sfARGBSIXIbNyLdmgZ1
         lbBIvhfE0SzFass97+WCwNV2zmbBhoNQEszaZJiq+cgZQmUvgZVibP7UXWi/Xhrtabg8
         oz1sn/fbRSvtwtzxdDreJ0C9CCClXSiLAyNCMSyd4pF4BoKC9yzrN1guXN0x5SFv5+Bx
         +hWA==
X-Gm-Message-State: AKwxyteZlGnDd+iXCcndXckZg0LFZaR6onxUqF5qaAd8cLvPQ4rrZDFm
        oyJ77hIKJY53l81mEbPQMNihovQ8
X-Google-Smtp-Source: AH8x226lOgT0c2EdvELGvg+VwXgwEH8ptbVPYD+AIirE9ltDIUbJrngOlX1MiP+/fCgpeO1Xg8VL4g==
X-Received: by 10.101.96.132 with SMTP id t4mr26441921pgu.58.1517420338524;
        Wed, 31 Jan 2018 09:38:58 -0800 (PST)
Received: from [192.168.206.100] ([117.246.176.158])
        by smtp.gmail.com with ESMTPSA id r3sm26570532pgf.46.2018.01.31.09.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 09:38:56 -0800 (PST)
Subject: Re: Bug/comment
To:     Andrew Ardill <andrew.ardill@gmail.com>,
        Ilija Pecelj <pecelj@gmail.com>
Cc:     git@vger.kernel.org
References: <2df7b921-6fe2-d55f-4ef0-3f4f0bd69261@gmail.com>
 <CAH5451=Xdotsk-t56ZPdybuAURYbHYe8xzD7uU+ZZjSu3YtyWQ@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <c5b7b176-6814-66ac-fdd8-f90b0cc67649@gmail.com>
Date:   Wed, 31 Jan 2018 23:08:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAH5451=Xdotsk-t56ZPdybuAURYbHYe8xzD7uU+ZZjSu3YtyWQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="l6OMxYClwJkdZOsB0YNQ6jEsymIsk1oWl"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l6OMxYClwJkdZOsB0YNQ6jEsymIsk1oWl
Content-Type: multipart/mixed; boundary="cf4iukjDSpqJ6lkRGRbsG9aZ4ILyzVSAv";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Andrew Ardill <andrew.ardill@gmail.com>, Ilija Pecelj <pecelj@gmail.com>
Cc: git@vger.kernel.org
Message-ID: <c5b7b176-6814-66ac-fdd8-f90b0cc67649@gmail.com>
Subject: Re: Bug/comment
References: <2df7b921-6fe2-d55f-4ef0-3f4f0bd69261@gmail.com>
 <CAH5451=Xdotsk-t56ZPdybuAURYbHYe8xzD7uU+ZZjSu3YtyWQ@mail.gmail.com>
In-Reply-To: <CAH5451=Xdotsk-t56ZPdybuAURYbHYe8xzD7uU+ZZjSu3YtyWQ@mail.gmail.com>

--cf4iukjDSpqJ6lkRGRbsG9aZ4ILyzVSAv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Tuesday 30 January 2018 05:32 AM, Andrew Ardill wrote:
> Hi Ilija,
>=20
> On 30 January 2018 at 10:21, Ilija Pecelj <pecelj@gmail.com> wrote:
>> Though it might not be considered a bug 'per se' it is definitely wire=
d.
>> Namely, when you type 'yes' word and hit enter in git bash for widnows=
, the
>> process enters infinite loop and just prints 'y' letter in new line.
>
> ...
>
> I agree it's a little weird if you have no idea what it's doing, but
> it is very useful and very old, used by many many different scripts
> etc, and so unlikely to change.
>

Just to make things more clear, 'yes' is an UNIX utility (as hinted in
the Wikipedia article link) that might come as part of Cygwin and is not
a part of Git itself.


--=20
Kaartic

QUOTE

=E2=80=9CIt is impossible to live without failing at something, unless yo=
u live
so cautiously that you might as well not have lived at all =E2=80=93 in w=
hich
case, you fail by default.=E2=80=9D

      - J. K. Rowling


WIKIPEDIA: DID YOU KNOW?

Only 33% of internet users in India have heard of Wikipedia !!

* What do you think could be the reason behind this?

* What are ways in which the awareness about Wikipedia in India and
other countries be increased ?

Reference:

* Give your ideas for increasing the awareness of Wikipedia in India and
in other countries and get a Grant from the Wikimedia Foundation to
bring your idea to life.

  https://meta.wikimedia.org/wiki/Grants:IdeaLab/Inspire

* Know more about the awareness problem of Wikipedia

  https://meta.wikimedia.org/wiki/New_Readers/Awareness

  https://meta.wikimedia.org/wiki/New_Readers/Next_steps/Raising_awarenes=
s


--cf4iukjDSpqJ6lkRGRbsG9aZ4ILyzVSAv--

--l6OMxYClwJkdZOsB0YNQ6jEsymIsk1oWl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlpx/ykbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlpdoUP/jxhFYQzGcfeSeAZGhUm
rL4vvxh8HAdHFVSL5xWB2S+zS4NK/d95Xunz6wI5HV0x5yMDBeSp4PtLU5uabJZM
02U2AB0L0Ol84RUtVJbgfnB+QwcFPKkEybBGj6tYB/lvQ/6PPXihm+s+Z7tyazsE
4ggTeqpR6viKtgoX2+UE80Gfo+c2nY3F0IaftHZvELbqTrfKeZ+CGek76ar0oaR6
Z5btANQq7N56Jo+6aaB6EFDxS4Euxc47dypW5hWflyJJ2Hvq87k8D21hkGNK2Osz
ETYlKfZ9IEhrGqbmJY9mWpomVCXiUnxh2sRcUjXX75TPSBfjlJuuviXq1nkFjH3F
w+gWWl2MJ3W+/IVKIa7sMdJQXmaRMj1O7SKZteU6gVig1wn8xY6MYtr6Enro12eM
zb+m+UC7j6Ag1r8/JKxlFDaofPCngB5e8HW0tsnaIcxtBmR8suAUF7QgpT7ZMbf6
f1TDmFQo9ssFewqzfuU/XM2JDkEHGEhoS1ZbYqq+O0jJU9XgpnVpJc4rXYA0hT6W
6sqY9inBe477ChKulWI+JqM5S61w9Rvrmz4RQmJO75bFpevr5J85+FjTnMOYMc3y
VvpFoGEbwEbscI8xoh3wAG8dAK1ixwF1MFT0tJcG0G1ruieeYVJEW34OkN4Y7D8j
19uxrUcv1gDXjOn6P5N259TC
=ednA
-----END PGP SIGNATURE-----

--l6OMxYClwJkdZOsB0YNQ6jEsymIsk1oWl--

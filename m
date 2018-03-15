Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 330C41F404
	for <e@80x24.org>; Thu, 15 Mar 2018 23:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932967AbeCOXfK (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 19:35:10 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45481 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932673AbeCOXfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 19:35:09 -0400
Received: by mail-pg0-f66.google.com with SMTP id s13so3380543pgn.12
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 16:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/VpveCXAi3jqB/7VjsNThOUPqe+C5i1hrkPFT86xsx4=;
        b=oj3hFjKHIU1VKQgR7la/hTJekZu5gyNiN3wWZoZjkXnuqo6LAcnIHIrOAE9rfMKrZm
         vrnyVLGBFbRjb8el9f6l8GEPAX01RX/OQx6g+2OofBpi4rrQqvTAb3W/0LnretCZPP0f
         lE0GCZlXqQ1pl9VD+Rj7bPHC16Vqn0rbnIuONzKn6Qhos1J3ZCBR2lqnxv8s/920jCXC
         m26VLOV3DmA8EOSIZWKTThUhY4RP9S/hgLv9Mh3D2CEi+15HmEaS+NUjKtvrKFB9Dozd
         7VwHSXTqzugTP1T9Dsv9TFO94oPLFAolvgShYKV34vp5FyX8RAIvrovKxKu6aE+IVlOh
         qgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/VpveCXAi3jqB/7VjsNThOUPqe+C5i1hrkPFT86xsx4=;
        b=DqGFFfQ0gN7RkQLy9sawFgOi02gA9EWOJJ8HJdUOZ8Cly/5/OBUmJAeSpPAzQp8lfr
         kuT3/91Lg2gRTDqrLRac/0iIRvWXh7xsij/riJ8htI3TNAZCmoGQclF/7E6Lj4mR6HQk
         66305UCrjFqtvWWD56wk2r5wKb2hZAlJOIte0p11dhOVLhe4z1VKZ+hwhc70+XqxGVji
         p5QSH0I8Hcu+N5MiY5mqWmxhsh3F3T4nZ6hsn9d25oTZL+OPRZjj5lQpAf71GzMJ47zw
         JqP+iqIkYhiojaKJHlwr5zYE43b9gf0v+ahlR74yowi9OUwWjhF04pRSy3OjyIxmsCBV
         dImQ==
X-Gm-Message-State: AElRT7FwNlEsbW4MVOrborzKG/KxPFUaaDWwKkyeoRQO5auWUCq7yqdw
        ILoNakK8R0cq5+Nb+o2+D/0=
X-Google-Smtp-Source: AG47ELu2J4qyLvDrZ6tbCTol38YpmM5N7B1i8lYDnDz3nviOQPcaUCy5FYGLasxWJZs8ErtjMFWz1Q==
X-Received: by 10.99.119.9 with SMTP id s9mr7235056pgc.276.1521156909411;
        Thu, 15 Mar 2018 16:35:09 -0700 (PDT)
Received: from rem2ua0031cfw.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 73sm13317256pfz.165.2018.03.15.16.35.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Mar 2018 16:35:08 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v12 04/10] utf8: teach same_encoding() alternative UTF encoding names
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPig+cSvBi1pJYC-DND1_x9rHhmoAPs90B_3Fg53-X5FjtCQhA@mail.gmail.com>
Date:   Fri, 16 Mar 2018 00:35:03 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <328BE614-1927-450A-85D1-7391D0BB5C47@gmail.com>
References: <20180315225746.18119-1-lars.schneider@autodesk.com> <20180315225746.18119-5-lars.schneider@autodesk.com> <CAPig+cSvBi1pJYC-DND1_x9rHhmoAPs90B_3Fg53-X5FjtCQhA@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Mar 2018, at 00:25, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> On Thu, Mar 15, 2018 at 6:57 PM,  <lars.schneider@autodesk.com> wrote:
>> The function same_encoding() checked only for alternative UTF-8 =
encoding
>> names. Teach it to check for all kinds of alternative UTF encoding
>> names.
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/utf8.c b/utf8.c
>> @@ -401,11 +401,27 @@ void strbuf_utf8_replace(struct strbuf *sb_src, =
int pos, int width,
>> +static int same_utf_encoding(const char *src, const char *dst)
>> +{
>> +       if (istarts_with(src, "utf") && istarts_with(dst, "utf")) {
>> +               /* src[3] or dst[3] might be '\0' */
>> +               int i =3D (src[3] =3D=3D '-' ? 4 : 3);
>> +               int j =3D (dst[3] =3D=3D '-' ? 4 : 3);
>> +               return !strcasecmp(src+i, dst+j);
>> +       }
>> +       return 0;
>> +}
>=20
> Alternate implementation without magic numbers:
>=20
>    if (iskip_prefix(src, "utf", &src) &&
>        iskip_prefix(dst, "utf", &dst)) {
>        if (*src =3D=3D '-')
>            src++;
>        if (*dst =3D=3D '-')
>            dst++;
>        return !strcasecmp(src, dst);
>    }
>    return 0;
>=20
> ... assuming you add an iskip_prefix() function (patterned after =
skip_prefix()).

If a reroll is necessary, then I can do this.


>> int is_encoding_utf8(const char *name)
>> {
>>        if (!name)
>>                return 1;
>> -       if (!strcasecmp(name, "utf-8") || !strcasecmp(name, "utf8"))
>> +       if (same_utf_encoding("utf-8", name))
>>                return 1;
>>        return 0;
>> }
>> @@ -414,6 +430,8 @@ int same_encoding(const char *src, const char =
*dst)
>> {
>>        if (is_encoding_utf8(src) && is_encoding_utf8(dst))
>>                return 1;
>> +       if (same_utf_encoding(src, dst))
>> +               return 1;
>>        return !strcasecmp(src, dst);
>> }
>=20
> This seems odd. I would have expected the newly-added generalized
> conditional to replace the original UTF-8-specific conditional, not
> supplement it. That is, shouldn't the entire function body be:
>=20
>    if (same_utf_encoding(src, dst))
>        return 1;
>    return !strcasecmp(src, dst);

No, because is_encoding_utf8() returns "true" (=3D1) if the encoding
is NULL. That is not the case for UTF-16 et al. The caller of
same_encoding() might expect that behavior.

I could have moved the "UTF-8" =3D=3D NULL assumption into=20
same_utf_encoding() but that did not feel right.

Does this make sense?

- Lars=

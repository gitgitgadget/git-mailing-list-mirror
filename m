Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C77351FCCA
	for <e@80x24.org>; Tue, 27 Jun 2017 06:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbdF0G26 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 02:28:58 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34996 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbdF0G2y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 02:28:54 -0400
Received: by mail-vk0-f42.google.com with SMTP id 191so11219964vko.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 23:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=egcr/gW1t4dRlnGccqM3W+4isclCLOcmpiCjztkfzvI=;
        b=qspjmddh5B5Wg8nXWfsLzL8dOPOQtcocX82EbauGDt3Ai4cn1Y74Tz58tLV8art2VX
         4oIfXTs3UCYwgjG0mi3sbLwTRdDdlfSBFqrPj4Tb29ulVPlcD0rLyignJDvpFgHHLHLd
         KQ2kYpMDwwQ+a/UTLQndSjyKMuWwMz4/3/OeTw0RoCPBN0U2v0lCijR9gIvjoo4hXJn8
         th7rvTtBuhUl6v6D5/P6pV1yhFFMp00+xS9qPQUowFGGpUHPEP64tFg1XBZhfiFpEXMi
         dpB/8claob7NlRHSHVd3Ri4msT2klyZ3JMk0AzlTlBtuvKSQiBCyFlewqHnOmlCgPb3q
         Y+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=egcr/gW1t4dRlnGccqM3W+4isclCLOcmpiCjztkfzvI=;
        b=sJLrwZXhcRkng8leEiDdb7VHxyRx8dGQOm+sRBoQFUdvBTNQ5HToT8p1cNQD8BVsQI
         0FBMereFEUCGay6VIy+8WDpyTPMgX3uzXp0Zt3Pw3Xl5KoBysziE3FMqyZg+LzBpK3vH
         5pqGJVTyeabtZJ688RI9l19ojcN/OfYy9ux9vGeGxJqC/pN6Wte9k3QuaZUbwtWM8FIQ
         sqhJuMjwtyQUuLKB0l5TRTV8YcH5aBcoJ/G4wnkZdcgU3Pi6XgGbilOwXtngyj7uj1fa
         s5dUG6zIE1eya2VsU1qR9weydqQDrGO252b3NieW9lK4gIGXLkR5r1/OP8Nfz7jIPATG
         74lA==
X-Gm-Message-State: AKS2vOyfBdXc5mCI3aN26Yj6sWk7VNEF02fEbB19fcBdyJXlyNC2irlT
        539WHkSBzfPfmSbga/MId9NiKAEfRQ==
X-Received: by 10.31.209.134 with SMTP id i128mr1944297vkg.125.1498544933356;
 Mon, 26 Jun 2017 23:28:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.23.13 with HTTP; Mon, 26 Jun 2017 23:28:32 -0700 (PDT)
In-Reply-To: <CAKKM46vr2Y_Zs+EJX-nxw7XH0nbpmTyubR1jibYoiieNCDns4Q@mail.gmail.com>
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
 <87fuem7aw2.fsf@gmail.com> <CAKKM46vr2Y_Zs+EJX-nxw7XH0nbpmTyubR1jibYoiieNCDns4Q@mail.gmail.com>
From:   Michael Kebe <michael.kebe@gmail.com>
Date:   Tue, 27 Jun 2017 08:28:32 +0200
Message-ID: <CAKKM46sBVyTMGNwU6E9s7gq8wiBfAxrKzBFVgU=zfwj+YdAjcQ@mail.gmail.com>
Subject: Re: Compile Error v2.13.2 on Solaris SPARC
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Marc Stevens <marc@marc-stevens.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On the Solaris system here __BYTE_ORDER__ set to 4321 and _BIG_ENDIAN
is defined, but has no value.

The problem is the not short circuiting macro...

-------------------------8<------------------------------
#undef _FOO1
#undef _FOO2
#undef _FOO2

#undef _BAR1
#undef _BAR2
#undef _BAR3

#define _FOO3 42

//comment out this line or give it a value to make the preprocesser happy
#define _BAR1

#if (defined(_FOO1) || defined(_FOO2) || defined(_FOO3))

// not short circuiting... preprocesser tries to evaluate (_FOO1 &&
_BAR1) but _BAR1 has no value...
#if ((defined(_FOO1) && (_FOO1 =3D=3D _BAR1)) || \
          (defined(_FOO2) && (_FOO2 =3D=3D _BAR2)) || \
          (defined(_FOO3) && (_FOO3 =3D=3D BAR3)) )
#define SHA1DC_BIGENDIAN
#endif

#endif
-------------------------8<------------------------------
https://gist.github.com/michaelkebe/c963c7478b7b55ad197f0665986870d4

What do you think?

2017-06-27 7:41 GMT+02:00 Michael Kebe <michael.kebe@gmail.com>:
> 2017-06-26 22:27 GMT+02:00 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com>:
>> Could you (or anyone else for that matter) please test it with:
>>
>>     git clone --branch bigend-detect-solaris-again https://github.com/av=
ar/sha1collisiondetection.git &&
>>     cd sha1collisiondetection &&
>>     make test
>
> Still no luck.
>
> ~/sha1collisiondetection (bigend-detect-solaris-again *)$ CC=3Dgcc gmake =
test
> mkdir -p dep_lib && gcc -O2 -Wall -Werror -Wextra -pedantic -std=3Dc90
> -Ilib  -M -MF dep_lib/sha1.d lib/sha1.c
> lib/sha1.c:63:58: error: operator '=3D=3D' has no right operand
>  #if ((defined(_BYTE_ORDER) && (_BYTE_ORDER =3D=3D _BIG_ENDIAN)) || \
>                                                           ^
>
> Running Solaris on sparc:
> $ uname -a
> SunOS er202 5.11 11.3 sun4v sparc sun4v
>
>
> The isa_defs.h is available here:
> https://gist.github.com/michaelkebe/472720cd684b5b2a504b8eeb24049870
>
>
> Greetings
> Michael

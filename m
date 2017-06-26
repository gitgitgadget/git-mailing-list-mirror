Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA12A207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 14:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbdFZOAz (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 10:00:55 -0400
Received: from mail-ua0-f173.google.com ([209.85.217.173]:33350 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdFZOAW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 10:00:22 -0400
Received: by mail-ua0-f173.google.com with SMTP id 70so1389338uau.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 07:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BlsGkLiASLZ8gDCB8+3LJr/tL0ru4HWkAgXJptWx+hg=;
        b=DVAOWByVDhcVa2G82S3x5XCuqSZ5YVdsu5PphFR4fplXjA3bJimDfzOfrRM6pPd6uP
         uqGR2pwYCxCAdS0FtClsXLuWntrUHPY/+IyrjCOexrjRxTMILTQmhfIKlwjOJSuM0bMB
         4GQd2Kq4HRnmqilH/s+V5tFTITS1JKngP1JMXocVFQ8mEqmHdYziV7xRtaTljRsGuu+a
         R3tV/0avL5XX1yg4ju02cRs9IyAtrqPkEN+c46loiMtcPKzdopoRjhGASJ87ITtAVz+t
         Ymn9dudTzE44z+Q+EGSnVtdz6iXew2+9fr+tNb4PKX4jJ8r6YYMTFlTNTJIa9IdQg2ve
         rplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BlsGkLiASLZ8gDCB8+3LJr/tL0ru4HWkAgXJptWx+hg=;
        b=Xpi+RvTKM3xX/Eb2u1qfenN7t6NXZnbhvWV7DiQjPcaorpQ40ylBgPYZCrRnqvVThk
         MYoJXqTsMivR9AlWU3JvUM+sSAfD/UzdGsGdWgpTkpYso5Sl0yxLCXsokQ6w0FSXovPJ
         1istiDa61TRnwSPV+rk7/PGIzVWNC50zCQ/To95Bs1ZwP00na6p+icEJQ3lNPuabsf+z
         QuWVekwj4FVQhJA9J18H8jVFY/P4FS/EDU+5nvBC8OQNy8X2TzfAOTLmoa5aHuFOZFQp
         6Wjh2+/AIWPAexSUGdrKExu8DMT+GpKFaRke7o7hlJXRkR/3CyxShU3gMlypOdxIYV3j
         WwMQ==
X-Gm-Message-State: AKS2vOx8fFE5l1QkjTBLhLdThQevvPGA472w8nOWYJXO7MpTKPO9l1HO
        uejZ0SFOheZQqJ8VQntgqqu2xi91yg==
X-Received: by 10.159.60.162 with SMTP id s34mr184717uai.89.1498485621545;
 Mon, 26 Jun 2017 07:00:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.23.13 with HTTP; Mon, 26 Jun 2017 07:00:01 -0700 (PDT)
In-Reply-To: <87h8z2dig8.fsf@gmail.com>
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
 <87lgofcf7r.fsf@gmail.com> <CAKKM46syoE90y-+5okxtk7A982ztaDFem8aL6GrxWhS4gGSGqg@mail.gmail.com>
 <87h8z2dig8.fsf@gmail.com>
From:   Michael Kebe <michael.kebe@gmail.com>
Date:   Mon, 26 Jun 2017 16:00:01 +0200
Message-ID: <CAKKM46s25LA+ywu_W5fyTaZ-r+3VyURptaa6whZsonzggQV-+g@mail.gmail.com>
Subject: Re: Compile Error v2.13.2 on Solaris SPARC
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Still no luck, with one or both patches.

Greetings
Michael

2017-06-26 14:47 GMT+02:00 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>:
>
> On Mon, Jun 26 2017, Michael Kebe jotted:
>
>> No luck with the patch.
>>
>> Still got:
>>
>>     CC sha1dc/sha1.o
>> sha1dc/sha1.c:43:58: error: operator '=3D=3D' has no right operand
>>       (defined(_BYTE_ORDER) && (_BYTE_ORDER =3D=3D _BIG_ENDIAN)) ||   \
>>                                                           ^
>> gmake: *** [sha1dc/sha1.o] Error 1
>
> Does this patch change anything, with or without the previous patch:
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 047172d173..1327aea229 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -131,6 +131,14 @@
>  # else
>  # define _XOPEN_SOURCE 500
>  # endif
> +
> +/*
> + * Bring in macros defining _BIG_ENDIAN etc. Should be brought in by
> + * the likes of stdio.h, but include it here in case it hasn't been
> + * included already.
> + */
> +#include <sys/isa_defs.h>
> +
>  #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__)=
 && \
>        !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) &&=
 \
>        !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__) &&=
 \
>
>>
>> Greetings
>> Michael
>>
>> 2017-06-26 10:42 GMT+02:00 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com>:
>>>
>>> On Mon, Jun 26 2017, Michael Kebe jotted:
>>>
>>>> When compiling 2.13.2 on Solaris SPARC I get this error:
>>>>
>>>>     CC sha1dc/sha1.o
>>>> sha1dc/sha1.c:41:58: error: operator '=3D=3D' has no right operand
>>>>  #if ((defined(_BYTE_ORDER) && (_BYTE_ORDER =3D=3D _BIG_ENDIAN)) || \
>>>>                                                           ^
>>>> gmake: *** [sha1dc/sha1.o] Error 1
>>>>
>>>> The define _BIG_ENDIAN is set by Solaris on SPARC systems. So the
>>>> check in line 41 gives this error.
>>>>
>>>> The _BIG_ENDIAN define is used few line below for defining
>>>> SHA1DC_BIGENDIAN. This is needed for Solaris SPARC systems.
>>>> See
>>>> https://github.com/cr-marcstevens/sha1collisiondetection/commit/33a694=
a9ee1b79c24be45f9eab5ac0e1aeeaf271
>>>
>>> I can see why this would error out. In sys/isa_defs.h on SPARC there's
>>> just `#define _BIG_ENDIAN`
>>> (http://src.illumos.org/source/xref/illumos-gate/usr/src/uts/common/sys=
/isa_defs.h),
>>> and (on Linux):
>>>
>>>     $ cat /tmp/test.c
>>>     #define _FOO
>>>     #define _BAR 1
>>>     #if (_BAR =3D=3D _FOO)
>>>     #endif
>>>     $ gcc -E /tmp/test.c
>>>     # 1 "/tmp/test.c"
>>>     # 1 "<built-in>"
>>>     # 1 "<command-line>"
>>>     # 31 "<command-line>"
>>>     # 1 "/usr/include/stdc-predef.h" 1 3 4
>>>     # 32 "<command-line>" 2
>>>     # 1 "/tmp/test.c"
>>>     /tmp/test.c:3:18: error: operator '=3D=3D' has no right operand
>>>      #if (_BAR =3D=3D _FOO)
>>>
>>> What I don't get is how this would have worked for Liam then (see
>>> 20170613020939.gemh3m5z6czgwmzp@oracle.com). Differences in Solaris
>>> versions and how their headers look like?
>>>
>>> Does this patch fix it for you?
>>>
>>> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
>>> index facea1bb56..0b75b31b67 100644
>>> --- a/sha1dc/sha1.c
>>> +++ b/sha1dc/sha1.c
>>> @@ -36,9 +36,11 @@
>>>  #undef SHA1DC_BIGENDIAN
>>>  #endif
>>>
>>> -#if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_O=
RDER__))
>>> +#if (defined(BYTE_ORDER) || defined(_BYTE_ORDER) || defined(__BYTE_ORD=
ER) || \
>>> +     defined(__BYTE_ORDER__))
>>>
>>> -#if ((defined(_BYTE_ORDER) && (_BYTE_ORDER =3D=3D _BIG_ENDIAN)) || \
>>> +#if ((defined(BYTE_ORDER) && (BYTE_ORDER =3D=3D BIG_ENDIAN)) || \
>>> +     (defined(_BYTE_ORDER) && (_BYTE_ORDER =3D=3D _BIG_ENDIAN)) ||   \
>>>       (defined(__BYTE_ORDER) && (__BYTE_ORDER =3D=3D __BIG_ENDIAN)) || =
\
>>>       (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ =3D=3D __BIG_ENDIAN__=
)) )
>>>  #define SHA1DC_BIGENDIAN
>>>
>>> I thought maybe BYTE_ORDER would work after searching the Illumos
>>> sources a bit more:
>>> http://src.illumos.org/source/search?q=3DBYTE_ORDER&project=3Dillumos-g=
ate
>

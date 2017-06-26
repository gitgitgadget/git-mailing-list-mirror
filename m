Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99683207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 12:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbdFZMhR (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 08:37:17 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36213 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdFZMhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 08:37:16 -0400
Received: by mail-vk0-f52.google.com with SMTP id y70so38624543vky.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dEd8EzoCMnoG5IWi2jl3u+vI6XBQ6wJvfEYIoFWddjk=;
        b=IzIkpnSmmO+WMCJRzxt9iZmwstipROsXe1mO57AiW/hU7I4IbIuaKi3QDSmRB1jQjM
         JtK30ZinhP+dqaARSeQ7eIjSnhebZb6x6ZiuyciyvMTVuq9pzh6Cz+frQSg4Wgsn1I1Z
         wJYfYs6aqwCnVk3iOmxUzknJdCZWfymbvbJFTMwX7tbiobYNPmpUNl+q3x9f0WA/P9Dz
         IzRr5cgMRXww9clInFa/+wV0IDaMrw+E0iD77xVQEERkEjjzqapMR026n+PSG3xkZfx/
         xOL6bZ3mEcAVICFv89zaGGSazbwLXmJV7at+qr0K5SzXn+/AQPYiw0SnVmT4792ufKJX
         H+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dEd8EzoCMnoG5IWi2jl3u+vI6XBQ6wJvfEYIoFWddjk=;
        b=NxIJFUTZHVmwqGUC7AUGg2QJaygJI5v4/GL1VNEg5RgM8pUu0sqJ50sP0FSfEC8Tei
         fys8C4hbhVt6xHVZk7Qh2i8z9jgHkdMsu9ziD31Nvymn6n0BWbIixrzIaQCuogCj1ChJ
         2wJ9s90h8laalho9O6DUqF/JttuD2sY2te0/ReOfJSyMoKsZUoITyBJwgfKB1XUrdYGF
         3RjM3duzZsSR0IGbt1MeiQBxiLdOQXICCJLd3AqM8gmSySxpzLLTAYHkLL9oiRP8VDhJ
         lBUXkZFtOkfXpmOddD9AQWuOKKoRFWV1LnmOH8rFwtys42tAzhOVAPJUrVJ8KBHpZ3NC
         /cFQ==
X-Gm-Message-State: AKS2vOxD+y9HZ4Z4gOErw6ZrAOP4/SqyPV0V5NSEkTemzVevG6hnb7I+
        sRyfFJWCxkwzy9+bLdZvoH3jakmh9r52U0M=
X-Received: by 10.31.41.213 with SMTP id p204mr3568184vkp.80.1498480635005;
 Mon, 26 Jun 2017 05:37:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.23.13 with HTTP; Mon, 26 Jun 2017 05:36:54 -0700 (PDT)
In-Reply-To: <87lgofcf7r.fsf@gmail.com>
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
 <87lgofcf7r.fsf@gmail.com>
From:   Michael Kebe <michael.kebe@gmail.com>
Date:   Mon, 26 Jun 2017 14:36:54 +0200
Message-ID: <CAKKM46syoE90y-+5okxtk7A982ztaDFem8aL6GrxWhS4gGSGqg@mail.gmail.com>
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

No luck with the patch.

Still got:

    CC sha1dc/sha1.o
sha1dc/sha1.c:43:58: error: operator '=3D=3D' has no right operand
      (defined(_BYTE_ORDER) && (_BYTE_ORDER =3D=3D _BIG_ENDIAN)) ||   \
                                                          ^
gmake: *** [sha1dc/sha1.o] Error 1

Greetings
Michael

2017-06-26 10:42 GMT+02:00 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>:
>
> On Mon, Jun 26 2017, Michael Kebe jotted:
>
>> When compiling 2.13.2 on Solaris SPARC I get this error:
>>
>>     CC sha1dc/sha1.o
>> sha1dc/sha1.c:41:58: error: operator '=3D=3D' has no right operand
>>  #if ((defined(_BYTE_ORDER) && (_BYTE_ORDER =3D=3D _BIG_ENDIAN)) || \
>>                                                           ^
>> gmake: *** [sha1dc/sha1.o] Error 1
>>
>> The define _BIG_ENDIAN is set by Solaris on SPARC systems. So the
>> check in line 41 gives this error.
>>
>> The _BIG_ENDIAN define is used few line below for defining
>> SHA1DC_BIGENDIAN. This is needed for Solaris SPARC systems.
>> See
>> https://github.com/cr-marcstevens/sha1collisiondetection/commit/33a694a9=
ee1b79c24be45f9eab5ac0e1aeeaf271
>
> I can see why this would error out. In sys/isa_defs.h on SPARC there's
> just `#define _BIG_ENDIAN`
> (http://src.illumos.org/source/xref/illumos-gate/usr/src/uts/common/sys/i=
sa_defs.h),
> and (on Linux):
>
>     $ cat /tmp/test.c
>     #define _FOO
>     #define _BAR 1
>     #if (_BAR =3D=3D _FOO)
>     #endif
>     $ gcc -E /tmp/test.c
>     # 1 "/tmp/test.c"
>     # 1 "<built-in>"
>     # 1 "<command-line>"
>     # 31 "<command-line>"
>     # 1 "/usr/include/stdc-predef.h" 1 3 4
>     # 32 "<command-line>" 2
>     # 1 "/tmp/test.c"
>     /tmp/test.c:3:18: error: operator '=3D=3D' has no right operand
>      #if (_BAR =3D=3D _FOO)
>
> What I don't get is how this would have worked for Liam then (see
> 20170613020939.gemh3m5z6czgwmzp@oracle.com). Differences in Solaris
> versions and how their headers look like?
>
> Does this patch fix it for you?
>
> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
> index facea1bb56..0b75b31b67 100644
> --- a/sha1dc/sha1.c
> +++ b/sha1dc/sha1.c
> @@ -36,9 +36,11 @@
>  #undef SHA1DC_BIGENDIAN
>  #endif
>
> -#if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORD=
ER__))
> +#if (defined(BYTE_ORDER) || defined(_BYTE_ORDER) || defined(__BYTE_ORDER=
) || \
> +     defined(__BYTE_ORDER__))
>
> -#if ((defined(_BYTE_ORDER) && (_BYTE_ORDER =3D=3D _BIG_ENDIAN)) || \
> +#if ((defined(BYTE_ORDER) && (BYTE_ORDER =3D=3D BIG_ENDIAN)) || \
> +     (defined(_BYTE_ORDER) && (_BYTE_ORDER =3D=3D _BIG_ENDIAN)) ||   \
>       (defined(__BYTE_ORDER) && (__BYTE_ORDER =3D=3D __BIG_ENDIAN)) || \
>       (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ =3D=3D __BIG_ENDIAN__))=
 )
>  #define SHA1DC_BIGENDIAN
>
> I thought maybe BYTE_ORDER would work after searching the Illumos
> sources a bit more:
> http://src.illumos.org/source/search?q=3DBYTE_ORDER&project=3Dillumos-gat=
e

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6125D1F461
	for <e@80x24.org>; Wed, 15 May 2019 11:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfEOLsd (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 07:48:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38285 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730946AbfEOLsc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 07:48:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id w11so3695751edl.5
        for <git@vger.kernel.org>; Wed, 15 May 2019 04:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3WJjsnM7bjN9nXnL7UENDqwmDFORUmFtAkTiwJAlNs0=;
        b=IMx7Nfvw/0vDuX7VloQ6k9d9dw01mVrBAkmCUDbWCILqez3MuHj6k8V24oEDKKb4EB
         FbDPS8QTFp36tOj1BP01w1xMjzszUGr8corurBbW0s1J7J28Xia4l/JiKdU8SFrRyi1w
         pzopac+E7BcAbGfbb/6yVVeqqaCtHBtx40hoRUgY3n/7qHc1A3uzH4EJWiAym7tddp3z
         ZrHg/jafDX5mG52GBA4VWAtPcoH3LAoX5D6jW/fQM+KyaQtuBBc73MPLFgYfVvV31tmC
         dMPj+6+Qz8uiMZ/2ikGiz+oJSieW6AI4yPxjIaGEFGnurrNsBDqn7DpfNqZY2Qyh3B73
         Rg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=3WJjsnM7bjN9nXnL7UENDqwmDFORUmFtAkTiwJAlNs0=;
        b=NouRnqCLSipVHQfZRJy3W0XomTePfeKjASAbsgz+fVWw3aJ6sSGiBUzKyP5rwGvaKX
         NsgSUIulfNlPVWtrLRRrbNgZa3E+3TPS1DFfPme7hmTR68n92GdySZc08xrTASLixvL/
         fAjs0484CaXF5ziAm7eSeKIku+o2rQO63GHYgsJHbfmMKow9nHNFbnwdXL4dHnFvGvVm
         jGutZ5VUkGrZ1tPvnS6kqQOel4d0s1iQe5BB8eLHhp7e8Umjbt2h5nkw2+enVZWG+GhT
         w2q8hXyzo8716Jjw+fLxXm/HPS32CZQJ6g2eJzqSzkpSWP5JCe4WkagRl2R7UXVJSCzi
         WGdw==
X-Gm-Message-State: APjAAAV9OF44osyRjePL3V2flQjYmJfYnYPseDlzwuQeSzmtRbCT77Vu
        6djEGmp5fL5xJoS0+KkhynposNVo
X-Google-Smtp-Source: APXvYqwdZkn0gzI0LE9KoHAF5qXrXLh7gvPRS740BH0UIE1RaI6onYctwhXD5X5LFt/zsIw79PILTQ==
X-Received: by 2002:a17:906:9601:: with SMTP id s1mr2963176ejx.26.1557920910052;
        Wed, 15 May 2019 04:48:30 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id b4sm702719edf.7.2019.05.15.04.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 04:48:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Osipov\, Michael" <michael.osipov@siemens.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1dc: update from upstream
References: <3cabed9e-3949-93cc-2c9c-500a9cd9d4cd@siemens.com> <20190513221701.1837-1-avarab@gmail.com> <09f64da1-b8aa-3cd7-89d7-475b8722e176@siemens.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <09f64da1-b8aa-3cd7-89d7-475b8722e176@siemens.com>
Date:   Wed, 15 May 2019 13:48:27 +0200
Message-ID: <87a7fovsz8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 14 2019, Osipov, Michael wrote:

> Hi,
>
> Am 2019-05-14 um 00:17 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Update sha1dc from the latest version by the upstream
>> maintainer[1]. See 07a20f569b ("Makefile: fix unaligned loads in
>> sha1dc with UBSan", 2019-03-12) for the last update.
>>
>> This fixes an issue where HP-UX IA64 was wrongly detected as a
>> Little-endian instead of a Big-endian system, see [2] and [3].
>>
>> 1. https://github.com/cr-marcstevens/sha1collisiondetection/commit/85582=
7c583bc30645ba427885caa40c5b81764d2
>> 2. https://public-inbox.org/git/603989bd-f86d-c61d-c6f5-fb6748a65ba9@sie=
mens.com/
>> 3. https://github.com/cr-marcstevens/sha1collisiondetection/pull/50
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>
>> n Thu, May 09 2019, Osipov, Michael wrote:
>>
>>> Hey there,
>>>
>>> Am 2019-05-09 um 09:32 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>>
>>>> On Wed, May 08 2019, Osipov, Michael wrote:
>>>>
>>>>> Hi folks,
>>>>
>>>> Hi see Documentation/SubmittingPatches for how to submit patches inline
>>>> instead of as attachments.
>>>
>>> Do you want me to resend the configure.ac change as per wiki article?
>>> I can also create a PR on GitHub. I am happy with both as long as I
>>> don't have to retain the patch for myself only ;-)
>>
>> Yeah that patch to git.git should be done separately. I see your PR
>> went in upstream, here's a patch to update our code to match.
>
> To avoid misunderstandings, I have factored out the Git patch and
> created a PR: https://github.com/git/git/pull/608

Thanks. If you want to submit it for inclusion you'll need to submit it
as a patch here to the ML as described here:
https://github.com/git/git/blob/master/Documentation/SubmittingPatches

Or you can use this pull-request-by-proxy thing:
https://gitgitgadget.github.io/

Or if you don't want to deal with any of that crap just say and I'll
E-Mail this to the list for you. Just want to give you a chance to do it
:)

> Looks good to me now:
>> osipovmi@deblndw024v:~/git
>> $ uname -a
>> HP-UX deblndw0 B.11.31 U ia64 HP-UX
>> osipovmi@deblndw024v:~/git
>> $ ./git --version
>> git version 2.22.0.rc0.dirty
>> osipovmi@deblndw024v:~/git
>> $ ldd ./git
>>
>> ./git:
>>         libz.so =3D>      /opt/ports/lib/hpux32/libz.so
>>         libiconv.so.8 =3D>        /opt/ports/lib/hpux32/libiconv.so.8
>>         libintl.so.9 =3D> /opt/ports/lib/hpux32/libintl.so.9
>>         libc.so.1 =3D>    /usr/lib/hpux32/libc.so.1
>>         libc.so.1 =3D>    /usr/lib/hpux32/libc.so.1
>>         libc.so.1 =3D>    /usr/lib/hpux32/libc.so.1
>>         libc.so.1 =3D>    /usr/lib/hpux32/libc.so.1
>>         libdl.so.1 =3D>   /usr/lib/hpux32/libdl.so.1
>
> Looking forward for a merge.
>
> Regards,
>
> Michael

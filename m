Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD72820248
	for <e@80x24.org>; Wed, 27 Mar 2019 14:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfC0OKr (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 10:10:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55238 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfC0OKr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 10:10:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id f3so179389wmj.4
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 07:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=miJY2Q4IjNuOlqoMdaqmw7sOkK/Swa/u+l9ciQOZQxE=;
        b=W7gBO2ZQZah5C/L9Z0yE64pn9sB0UAXzylxamDtW79hqYK7VP7aJAwKrbSzbB8vDyr
         bSh+jK/yxeH/Iwj2i/b2XlQdkevqwZv3OqbXEfC5M2Vp2l5Un6J2E4G+W/YESD4xlBLD
         CjlMjBVsBAH2IxVsoL8ecRpP0F430ySgaxNq+e0l7Y2srr8Ko3hxLGwyya2YOpwrRV7v
         O4oA9lbMZ8mK+xr59QKz8sPjOHfSv/3nQbfR969tXv4F9p//dsNv4qdNoLpOXMASQxjb
         v8I8UQvXdl8bw6n8CrDqUoGaIc+WOABxxUYyI4oFBXVigHjHG2jhyEbxC+PkaY1I69v+
         CLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=miJY2Q4IjNuOlqoMdaqmw7sOkK/Swa/u+l9ciQOZQxE=;
        b=ls4pAHynMpgnhkt2ohnQusq8t0XS2KloLjdWjiM3UTuiV1OumBssNsCtbWwr/MYwC5
         jSve2OgGuNUbkiDCMNM55/Zdt9T4FEdMwlzYOJJ71R5Wl+Pek7lHFu2js3++vcmMs24N
         5gdOSiHpwl+X5UXoSqp7bbtiNgzzhJqXBsiXqkvjS9caHD+cin2HdABAYyI0Tq/s3ThJ
         Zfch+ZaM/qkBebTb/F4NmlvXKgP8NVeghd5/3TKVfnmKPMoy4hI8TGGAxa/VVPz3CSqT
         caPT9uIMAC65Gm2UIe+oNxp0oIeT2tH7C36lsk76XvHOLLpoOIvGSCSeb/8gXLgMOboS
         h1lw==
X-Gm-Message-State: APjAAAWTFAhjODYyMzXGJgavNyG8R063PijaI/W27Eers8zUzUsVMIVL
        wJoLbHZuF/EpkQ4z567LZL4=
X-Google-Smtp-Source: APXvYqzYrPcdnglMoXsVegEtpHK7tl0tPnnBUBdqsUQgN1h7oukiOV3AaybJVnUUFU7yUgnwS1vumg==
X-Received: by 2002:a7b:c403:: with SMTP id k3mr18879036wmi.58.1553695844735;
        Wed, 27 Mar 2019 07:10:44 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id a9sm22790426wrt.29.2019.03.27.07.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 07:10:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, Mooga <contact@m-mooga.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [GSoC] microporject test_path_is_*
References: <38B8E527-2338-485E-8840-29121F259687@m-mooga.com> <CABPp-BHwUoqk79Kf=ynna5x+mCJyOLz66v6pDieyEeM7YCRS+g@mail.gmail.com> <877eckbpdd.fsf@evledraar.gmail.com> <20190327104935.GD32732@szeder.dev> <874l7obm0c.fsf@evledraar.gmail.com> <20190327121411.GE32732@szeder.dev>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190327121411.GE32732@szeder.dev>
Date:   Wed, 27 Mar 2019 15:10:42 +0100
Message-ID: <8736n8be71.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 27 2019, SZEDER G=C3=A1bor wrote:

> On Wed, Mar 27, 2019 at 12:21:55PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Wed, Mar 27 2019, SZEDER G=C3=A1bor wrote:
>>
>> > On Wed, Mar 27, 2019 at 11:09:18AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >> > There are likewise several that use one of
>> >> >    ! test -e path/to/filename
>> >> > or
>> >> >    ! test -f path/to/filename
>> >> > or
>> >> >   test ! -f path/to/filename
>> >> > which could be replaced by
>> >> >   test_path_is_missing path/to/filename
>> >>
>> >> Interesting that for some we use the 'test_is_there/test_is_not_there'
>> >> pattern and for others 'test_is_there [!]'. E.g
>> >> test_path_exist/test_path_is_missing v.s. test_i18ngrep.
>> >
>> > It's unclear what the '!' should negate in case of 'test_path_is_file
>> > ! file'.  What if 'file' does exists, but it's not a file but a
>> > directory, socket, fifo, or symlink?  'test ! -f file' returns success
>> > in these cases as well.
>> >
>> > OTOH, it's quite clear what the negation should mean in case of
>> > 'test_i18ngrep'.
>>
>> *Should* we make it better? Yeah sure, maybe. I'm just pointing out for
>> context to someone poking at this for the first time that now we
>> sometimes do "! foo <arg>" v.s. "foo <arg>" as "foo_is <arg>" and
>> "foo_not <arg>" and other times "foo [!] <arg>".
>>
>> So yeah, maybe we should improve things to disambiguate the cases you
>> mentioned, but right now e.g. "test_path_exists" and
>> "test_path_is_missing" are just "test -e" and "! test -e", respectively.
>
> I'm not sure why 'test_path_exists' exists, as I don't readily see a
> valid reason why a test should only be interested in whether the path
> exists, but but not whether it's a file or a directory.

In the general case the same reason we use "test -e". While the test
would pass in all sorts of unexpected cases, those probably aren't
plausible and we're just e.g. checking "did the thing create a file
it'll create in XYZ mode?"....

> Luckily it
> haven't caught on, and it's only used twice in the whole test suite.

Well, we have some >100 "test -e" though ... :)

> However, as shown above, the existend of 'test_path_is_missing' is
> very much justified.
>
>> The same caveats you've mentioned also apply to "test_i18ngrep" b.t.w.,
>> there we squash the 3x standard exit codes of grep[1] into a boolean,
>> and thus e.g. ignore the difference between <file> not matching an
>> <file> being a directory or whatever.
>
> I'm not sure I understand, 'test_i18ngrep' handles the missing file or
> not a file cases reasonably well:
>
>   expecting success:
>           test_i18ngrep ! foo nonexistent-file
>
>   error: bug in the test script: test_i18ngrep requires a file to read as=
 the last parameter
>
> or
>
>   expecting success:
>           mkdir dir &&
>           test_i18ngrep ! foo dir
>
>   error: bug in the test script: test_i18ngrep requires a file to read as=
 the last parameter

Yeah you're right, I didn't read it carefully enough and it does handle
*that* particular case, but e.g. a grep of "file" where we can't read it
due to a permission error is the same as "didn't contain the string".

I'm not saying that's a bad thing, but the opposite. We assume a certain
base level of sanity, e.g. we do "test_must_fail <cmd>" only for git,
but "! <cmd>" for everything else, even though e.g. the system "grep"
may be segfaulting.

>>
>> 1. http://pubs.opengroup.org/onlinepubs/009695399/utilities/grep.html

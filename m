Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F26920248
	for <e@80x24.org>; Tue, 26 Feb 2019 18:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfBZSlP (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 13:41:15 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35352 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfBZSlP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 13:41:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id t13so7336653lji.2
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 10:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2t4+80sxTUk2P8L+/caJpilN5/xkiSp0W3qr0fNgsfc=;
        b=kEOe5lc+wQIslrjQ/Ptoon/Kv3dpUu1Aw7lUPz5jSVEJ/Y//Yzh6YxbNWNc0Sdkor2
         4Rribg1G/Xl+hReifyTFuMdjalh9YrlRzXRklOdu+2KyZs6UNrRKpQWqexOd04D2xyC8
         N3bVUVCsQQ/+PEycGB2HX7jpijiE4FZFEwNiJbmtF64Wu1Ho6Hx4W9saX2JiNSm++qDU
         t3ditAb5n2OrpQvMASM+2QMWq5xzSFyHqbLQV8aWqKXhAds7P0b259C86eAabqBgTQzw
         At6faD9Ol+VYxZ1PTrHaxzH+F/gq8KrCdwNapT0cYMNRe7P6D5ne56SBZqDiWmpSrB8F
         mILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2t4+80sxTUk2P8L+/caJpilN5/xkiSp0W3qr0fNgsfc=;
        b=rjYA5CHPtcc7En9Tja3kbqkpMAHlG0sDIBXL206kLepBk67llA9aokGT4nPDKlRH6c
         eo8KDfm1jLun8jg7wUy7qpzR6Of/BIBIv3k/cZPpKi98Jm6y6mI5VRQjjzitlPp/ryGa
         w8FEkdzFf3QraNN7kZJtHlVNDvdwurOZMKpgB4TYT6oWyH2QYIpH30seBg7kcO5OQiCc
         Ump9QHx9hXQ/PIMMW1J79+6tUQ1PeZ6w3czuIhZtZbAHozfHifOmdLmQrQTUTO3GUPPj
         6aoaYrODUkwuzsuE3mHR056nFd06KyyOHs/PgJ/1pJQQ21uY2N67srQuQqjwMziSYnf0
         BZhw==
X-Gm-Message-State: AHQUAuatDlo+ij9TUUj28i06IVCcIobi6i52Eu3d0gmEZnAuTjhCM7i8
        DnYWiJDa86k/jZyAE1RQBrMeFnTLZn63R8OYNzw=
X-Google-Smtp-Source: AHgI3IbyiBWk59y5ZD/RXfkebTiSyByuuaK4nimL6cndFO4xtRKpVUF1fy5in0IVv8NIYxppe4mpEscM8vEKbQe+Kgs=
X-Received: by 2002:a2e:2c11:: with SMTP id s17mr14162348ljs.147.1551206473019;
 Tue, 26 Feb 2019 10:41:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.152.git.gitgitgadget@gmail.com> <pull.152.v2.git.gitgitgadget@gmail.com>
 <fcafc87b382dfef00d8e33e875bcb8b03d5667e4.1551191168.git.gitgitgadget@gmail.com>
 <20190226163737.GB19739@szeder.dev>
In-Reply-To: <20190226163737.GB19739@szeder.dev>
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Date:   Wed, 27 Feb 2019 00:10:14 +0530
Message-ID: <CAL7ArXocrtCBpEoCM6_aSWcKgaVDwBADMZ9WEBzxpwOfHKuHGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] t3600: use test_path_is_dir and test_path_is_file
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi SZEDER

On Tue, Feb 26, 2019 at 10:07 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>
> We prefer to use imperative mode when talking about what a patch does,
> as if the author were to give orders to the code base.  So e.g.
> instead of
>
>   This patch will ...
>
> we would usually write something like this:
>
>   Replace 'test -(d|f)' calls in t3600 with the corresponding helper
>   functions.
>

>
> >  test_expect_success 'Recursive with -r -f' '
> >       git rm -f -r frotz &&
> > -     ! test -f frotz/nitfol &&
> > -     ! test -d frotz
> > +     ! test_path_is_file frotz/nitfol &&
> > +     ! test_path_is_dir frotz
> >  '
>
> These should rather use the test_path_is_missing helper function.
>
> However, if the directory 'frotz' is missing, then surely
> 'frotz/nitfol' could not possibly exist either, could it?  I'm not
> sure why this test (and a couple of others) checks both, and wonder
> whether the redundant check for the file inside the supposedly
> non-existing directory could be removed.
>

Okay! I'll scan through the file to check for redundancy like this and fix =
them.

> Furthermore, there are a couple of place where the '!' is not in front
> of the whole 'test' command but is given as an argument, e.g.:
>
>   test ! -f file
>
> Please convert those cases as well.
>

I think since I'm modifying `test_path_is_{dir|file}` functions to
handle calls like `! test_path_is_dir` well as mentioned in this
thread[1]. I think we should replace `! test` calls with `test !`, so
that the changes are in agreement with each other. What do you say?

Thanks for advice
Rohit

[1]: https://public-inbox.org/git/CAN0heSqSp-a0zUKT5EaGLBYnRtESTnu9GKWtGARz=
2kaOAhc1HQ@mail.gmail.com/

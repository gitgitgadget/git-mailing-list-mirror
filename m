Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 362A01F42E
	for <e@80x24.org>; Mon,  7 May 2018 10:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeEGKYP (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 06:24:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34852 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeEGKYO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 06:24:14 -0400
Received: by mail-pf0-f195.google.com with SMTP id x9so3357143pfm.2
        for <git@vger.kernel.org>; Mon, 07 May 2018 03:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZGaMx5p3jCJKYEdOYMbA+Eeyy4LJGuKF+uCJhqMASqw=;
        b=cTnpseOoT9usC2R7X/GOVH55jo83vWdPoUWN7db6t3uWBRFQAbZB3Qo12GHPTM3ajb
         lGjdFfQKYUVvqXl2e7jo3SjQSQPmVIK1vqD7G8NbFlMt0ozZH/qYmjegLsXTqfD1JIrJ
         WDIQVgxKx+64GH/r5dDHXn6DAtVr/eS/+qThMxJX5oCcsNpTcNDOk2H5bTIpHkssavB9
         g9cZlbWYHxMnGKMd26+n1puRtjys5TZE4wxC/8zUsB0SjUkAxdl/XaiRon5VGktLNEwN
         IXtzsCLjoJadbDmL7YMndnYwPDy3COcjWpyNhEgfPX3Uy0fXtmNfeqDQVa3/7FqOr3ud
         A+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZGaMx5p3jCJKYEdOYMbA+Eeyy4LJGuKF+uCJhqMASqw=;
        b=nxswEcaeWK69kQjEWLIvbAWZzIM4RLv3JbeZoZTrxSFE7ooBNxUan/l76BJCl89pTc
         TaSVq4KxAu6yheh7YTydjfUQoSUEw5ziT9O4giaR4Av4/A46hQaVt42XYNeo0MwX+lkC
         tXID7YlOLpVo/I5jmzekreA15u11lsR0EX56X5cpoVd5Y6zBFNgzJMiaDI1HYi5JlhFY
         m+6jopivUS+6PXENQu2X0k1r8XqWAxdMA0swgFVFDQD9UdJmv6PeUBLF/oipJteKwloY
         Mx4qp/6X4X8sn+4c4o1Zcn5duXJqVu9LorpeolvRmSWMLHup8Od6Pq5nA92hxbKssn6b
         pvHw==
X-Gm-Message-State: ALQs6tCdjGJ7zUA0MMU/fbPx1EoeJsBTwxH2IXhrwCH37n2xfCkO4y5I
        uUTQC4dTIE8gdgMHSdfgv/rMZdI3mzSsMdhbijM=
X-Google-Smtp-Source: AB8JxZpbpXsHl6SSLbFL5/xMnB2gNSWpS6t3fT50xHjMMOFdhD/Av2FeThftNQyZ1G2SHRsDem9ki3q94+4rJWZetAk=
X-Received: by 2002:a17:902:284b:: with SMTP id e69-v6mr36554743plb.240.1525688653920;
 Mon, 07 May 2018 03:24:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Mon, 7 May 2018 03:24:13 -0700 (PDT)
In-Reply-To: <20180506231752.975110-7-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net> <20180506231752.975110-7-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 7 May 2018 12:24:13 +0200
Message-ID: <CAN0heSqu9gwsrgV0rnPe8=vANhBA+Z7fZ3UNTeG9S1QiJBsksw@mail.gmail.com>
Subject: Re: [PATCH 06/28] t0000: annotate with SHA1 prerequisite
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 May 2018 at 01:17, brian m. carlson <sandals@crustytoothpaste.net> wrote:
> Since this is a core test that tests basic functionality, annotate the
> assertions that have dependencies on SHA-1 with the appropriate
> prerequisite.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t0000-basic.sh | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 7fd87dd544..af61d083b4 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -839,7 +839,7 @@ test_expect_success 'writing tree out with git write-tree' '
>  '
>
>  # we know the shape and contents of the tree and know the object ID for it.
> -test_expect_success 'validate object ID of a known tree' '
> +test_expect_success SHA1 'validate object ID of a known tree' '
>         test "$tree" = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a
>      '
>
> @@ -882,7 +882,7 @@ test_expect_success 'showing stage with git ls-files --stage' '
>         git ls-files --stage >current
>  '
>
> -test_expect_success 'validate git ls-files output for a known tree' '
> +test_expect_success SHA1 'validate git ls-files output for a known tree' '
>         cat >expected <<-\EOF &&
>         100644 f87290f8eb2cbbea7857214459a0739927eab154 0       path0
>         120000 15a98433ae33114b085f3eb3bb03b832b3180a01 0       path0sym
> @@ -900,7 +900,7 @@ test_expect_success 'writing tree out with git write-tree' '
>         tree=$(git write-tree)
>  '
>
> -test_expect_success 'validate object ID for a known tree' '
> +test_expect_success SHA1 'validate object ID for a known tree' '
>         test "$tree" = 087704a96baf1c2d1c869a8b084481e121c88b5b
>  '
>
> @@ -908,7 +908,7 @@ test_expect_success 'showing tree with git ls-tree' '
>      git ls-tree $tree >current
>  '
>
> -test_expect_success 'git ls-tree output for a known tree' '
> +test_expect_success SHA1 'git ls-tree output for a known tree' '
>         cat >expected <<-\EOF &&
>         100644 blob f87290f8eb2cbbea7857214459a0739927eab154    path0
>         120000 blob 15a98433ae33114b085f3eb3bb03b832b3180a01    path0sym
> @@ -924,7 +924,7 @@ test_expect_success 'showing tree with git ls-tree -r' '
>         git ls-tree -r $tree >current
>  '

[snip]

This could be more centralized at the top of the file, more likely to be
noticed during a `make test` and easier to adapt in the future. Maybe
something like this at the top of the file:

if hash for storage is SHA-1 then
        knowntree=7bb943559a305bdd6bdee2cef6e5df2413c3d30a
        path0=f87290f8eb2cbbea7857214459a0739927eab154
        ....
else
        skip_all='unknown hash, but you really need to expand this test'
        # or even error out!
fi

When we add NewHash, we get to add an "else if". Otherwise, we'd be
plugging in NewHash without testing some very basic stuff.

Ok, so `skip_all` is quite hard, but skipping certain basic tests also
feels really shaky. Adding a new hash algo without adapting this test
should be a no-go, IMHO.

Martin

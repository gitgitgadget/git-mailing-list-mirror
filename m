Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB2F1F790
	for <e@80x24.org>; Tue,  2 May 2017 13:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbdEBNWp (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 09:22:45 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35798 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdEBNWo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 09:22:44 -0400
Received: by mail-it0-f65.google.com with SMTP id 131so2209804itz.2
        for <git@vger.kernel.org>; Tue, 02 May 2017 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6VVVuBkoxnlrHrjS+QmMo2OpGgr5hKynobmAidseI6I=;
        b=SS/SitCMYPA8LBV4Lvdx4wjnd9HV6BNWi98yewafIKh3GsCfsk3/5pHQbL3Mzbk4x0
         dmoP/U+9SPrfo2xhhc+YMQabvkmcT1o0iY6nC9EVOJb1+OzT6KCMUKBMM36vxgu2HnBd
         WA+ehaSVffdKnhrh22bE4qSUIU4UI7LI2OfJOy2Ai0eAYH0Au5yHePM/okED21fLQGef
         m7A/s5QrGEoKYD/r+KV2YsCoZuw2qYcju87by2+PnULS/jQ6ZEpULAtN+qDnHgD4HN62
         VmQJtEEd54CQzeZgXYNLM56ZE6A4CacTQmmbCMZqrRZhbEskSQUWvm0s/NYYvALbi2ZP
         /7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6VVVuBkoxnlrHrjS+QmMo2OpGgr5hKynobmAidseI6I=;
        b=d5K5zoEQDw0+6qATT1ty1tZdk2cfXKkIIe1ZnLeWFM6FHmHAs5RYJmXcv5QnblVDQH
         gF9ws8AF3W889ieWcK97Z1QjuWd0+TsbShZTTTCJ+IWIyoI6XDd6d9bWoB61WAoVkHTY
         GuJ5DUQD7dGoY5PQRtl5VEkEYKtG2gP59XgYXhc86UBKngXC7R7FSr2pedpixnc3PoXT
         97iUx2AXWgd0Ba6fLe10pd5jmuba/Tk5l9rEUoY/wijscYNDo0KCeAKJeeWFaM/O1WEo
         fv6pQQ1KwrYDqNVw7eNfZ23N4AcY8QCNZdzxrkmwevyj2bC8uZIZnYg5skD0bT+zOjT4
         vyxw==
X-Gm-Message-State: AN3rC/5AK88a46Rg7iseAvN2I2x0ERS36hVtvPOerhCAmdlM16Ea/HD5
        7lYWl1VyfAZX/oGjCU0TZweksS6Cag==
X-Received: by 10.36.138.131 with SMTP id v125mr10208764itd.66.1493731363860;
 Tue, 02 May 2017 06:22:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 2 May 2017 06:22:23 -0700 (PDT)
In-Reply-To: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com>
References: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 2 May 2017 15:22:23 +0200
Message-ID: <CACBZZX4=QePHqDFnxvTSJ4siNv6TVzUvhCpA91aY8APZTpGEfQ@mail.gmail.com>
Subject: Re: [PATCH v2] add DEVELOPER makefile knob to check for acknowledged warnings
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2016 at 9:42 AM,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> We assume Git developers have a reasonably modern compiler and recommend
> them to enable the DEVELOPER makefile knob to ensure their patches are
> clear of all compiler warnings the Git core project cares about.
>
> Enable the DEVELOPER makefile knob in the Travis-CI build.
>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>
> This patch is the successor of "[PATCH v1] travis-ci: override CFLAGS properly,
> add -Wdeclaration-after-statement" [1] which enables compiler warnings for the
> Travis-CI build.
>
> Peff suggested to codify the knowledge about the compiler warnings the Git
> project cares about [2] which I have done here.
>
> The only problem is the "-Wold-style-declaration" compiler warning as this is
> only supported by GCC and not Clang. Should we ignore that warning or would you
> prefer to detect the GCC compiler and add the warning? The Linux kernel project
> does a similar thing [3].
>
>
> Thanks,
> Lars
>
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/285752
> [2] http://article.gmane.org/gmane.comp.version-control.git/285761
> [3] https://github.com/torvalds/linux/blob/6dc390ad61ac8dfca5fa9b0823981fb6f7ec17a0/Makefile#L303-L306
>
>
>  .travis.yml                    |  2 +-
>  Documentation/CodingGuidelines |  4 ++++
>  Makefile                       | 12 ++++++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index c3bf9c6..168ae21 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -15,12 +15,12 @@ addons:
>
>  env:
>    global:
> +    - DEVELOPER=1
>      - P4_VERSION="15.2"
>      - GIT_LFS_VERSION="1.1.0"
>      - DEFAULT_TEST_TARGET=prove
>      - GIT_PROVE_OPTS="--timer --jobs 3"
>      - GIT_TEST_OPTS="--verbose --tee"
> -    - CFLAGS="-g -O2 -Wall -Werror"
>      - GIT_TEST_CLONE_2GB=YesPlease
>      # t9810 occasionally fails on Travis CI OS X
>      # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index c6e536f..1c676c2 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -171,6 +171,10 @@ For C programs:
>
>   - We try to keep to at most 80 characters per line.
>
> + - As a Git developer we assume you have a reasonably modern compiler
> +   and we recommend you to enable the DEVELOPER makefile knob to
> +   ensure your patch is clear of all compiler warnings we care about.
> +
>   - We try to support a wide range of C compilers to compile Git with,
>     including old ones. That means that you should not use C99
>     initializers, even if a lot of compilers grok it.
> diff --git a/Makefile b/Makefile
> index fd19b54..9d4614d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -380,6 +380,18 @@ ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
>  STRIP ?= strip
>
> +ifdef DEVELOPER
> +       CFLAGS +=       -Werror \
> +                               -Wdeclaration-after-statement \
> +                               -Wno-format-zero-length \
> +                               -Wold-style-definition \
> +                               -Woverflow \
> +                               -Wpointer-arith \
> +                               -Wstrict-prototypes \
> +                               -Wunused \
> +                               -Wvla
> +endif
> +
>  # Create as necessary, replace existing, make ranlib unneeded.
>  ARFLAGS = rcs
>
> --
> 2.5.1

[I realize this patch has long since been integrated]

Is there any way with this to both supply CFLAGS & DEVELOPER=1 on the
command-line, to get my custom -O<whatever> & these -W flags? I.e.:

$ make DEVELOPER=1 V=1
[...] -g -O2 -Wall -Werror -Wdeclaration-after-statement
-Wno-format-zero-length -Wold-style-definition -Woverflow
-Wpointer-arith -Wstrict-prototypes -Wunused -Wvla -I. [...]
$ make DEVELOPER=1 CFLAGS="-g -O0 -Wall" V=1
[...] -g -O0 -Wall -I. [...]

I thought the second case would prepend my "-g -O0 -Wall" but then be
followed by the various -W developer flags, but it isn't, am I just
doing something stupid, or is there no way to combine these two?

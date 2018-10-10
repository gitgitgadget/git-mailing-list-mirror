Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29C2B1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 14:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJJVai (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 17:30:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55517 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJJVai (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 17:30:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id 206-v6so5646647wmb.5
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 07:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=TTwNGyJv/eGDYzd5za95XWZ4a6trOgrQ8Fz4/lbgGcE=;
        b=ikwj88C70hbJFT+ssANx+adRn36SbahKwOCSm0MtNLxRzwlOkC1/pIOBCe+KJgF9hF
         tMkzRz7x8D4rmZdotGbp7wG4okwKb+8B4b3BSza/PLAY3Nlk5ySmVKgtdJVJLsdCXM3C
         6Rt2+lhZ04/mI/xO8vHbMtmkaDEblNkOd45MDOz0izj1sih+xPSxS6saYZ1kOiQ+7/9O
         je4h7IqotneDyEnWXQ3Dwaq6SwDUndePn7aU3gkwLl8+TNX4YTEeVQIAS1SGbn4Zkd2I
         bgCJ4syaZv5nz+j7PIwF8kutOTy45bqI8K2yPMlSA6CmivpAF3r0z4M7Wxd3C4ll2WuB
         tExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=TTwNGyJv/eGDYzd5za95XWZ4a6trOgrQ8Fz4/lbgGcE=;
        b=Q5XACEOOZFCELgyncm9B7oOfcL2zMwSuHSeKJK1NjtODTF62RJLIkK05xqReDQQ49o
         xKi/4Ce2jUu5otgzS0slCLHs7LQbdzaQZTyiHKhSppgYSj+iSJVp7/2RKJy3g80yVNvA
         wc/tgxVBk++4TaZW+j6jY9B0D+wcR0N5G14cgE5y1tmSzlAv2+dkcLcZ6W7rD/0J3lJ3
         5R9IYmlNHcZcEoFVFtg8EZh0M2CFSwabNt3EgWgtRv8bmYufL7HFvs55cOM0z3fg+dAR
         s29bn7MNCve2c+2XdxBQKwehE6Miz3zM2Q4d2RUzmKbDQskfm4K9Xpe4rHxjEg9oyJ1F
         7TqA==
X-Gm-Message-State: ABuFfojZ1QELhnJMhxDrUeBlxsrzGFjOtbX6xe5FB0wqypWBNX4m2igY
        iNRsya7Br+WWlTRSKYRXerk=
X-Google-Smtp-Source: ACcGV63WD99wThwqSfsxeR+VaxgTz6zoubVOSuPdqJxkWSTuge2NX2NA58Q78RGp2g7WhYyn+OfRLA==
X-Received: by 2002:a1c:c012:: with SMTP id q18-v6mr1041665wmf.150.1539180496583;
        Wed, 10 Oct 2018 07:08:16 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id y65-v6sm13881069wmg.40.2018.10.10.07.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 07:08:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] mingw: bump the minimum Windows version to Vista
References: <pull.44.git.gitgitgadget@gmail.com> <2b127d9669aa7b73ced7611b6e77044f5efed11d.1538595818.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <2b127d9669aa7b73ced7611b6e77044f5efed11d.1538595818.git.gitgitgadget@gmail.com>
Date:   Wed, 10 Oct 2018 16:08:14 +0200
Message-ID: <87zhvlevxt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 03 2018, Johannes Schindelin via GitGitGadget wrote:

> Quite some time ago, a last plea to the XP users out there who want to
> see Windows XP support in Git for Windows, asking them to get engaged
> and help, vanished into the depths of the universe.
>
> We tried for a long time to play nice with the last remaining XP users
> who somehow manage to build Git from source, but a recent update of
> mingw-w64 (7.0.0.5233.e0c09544 -> 7.0.0.5245.edf66197) finally dropped
> the last sign of XP support, and Git for Windows' SDK is no longer able
> to build core Git's `master` branch as a consequence. (Git for Windows'
> `master` branch already bumped the minimum Windows version to Vista a
> while ago, so it is fine.)
>
> It is time to require Windows Vista or later to build Git from source.
> This, incidentally, lets us use quite a few nice new APIs.
>
> It also means that we no longer need the inet_pton() and inet_ntop()
> emulation, which is nice.

Earlier in this series you add a:

#if defined(_WIN32_WINNT) && _WIN32_WINNT >= 0x600
...
#endif

Shouldn't that now be something like:

#if defined(_WIN32_WINNT)
#if _WIN32_WINNT >= 0x600
...
#else
#error "You need at least Windows Vista to build Git!"
#endif
#endif

Or do we catch users building on non-supported versions earlier somehow
(i.e. not just with a flood of compilation errors).

> diff --git a/config.mak.uname b/config.mak.uname
> index e47af72e01..8acdeb71fd 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -381,8 +381,6 @@ ifeq ($(uname_S),Windows)
>  	NO_PYTHON = YesPlease
>  	BLK_SHA1 = YesPlease
>  	ETAGS_TARGET = ETAGS
> -	NO_INET_PTON = YesPlease
> -	NO_INET_NTOP = YesPlease
>  	NO_POSIX_GOODIES = UnfortunatelyYes
>  	NATIVE_CRLF = YesPlease
>  	DEFAULT_HELP_FORMAT = html
> @@ -529,8 +527,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	NO_REGEX = YesPlease
>  	NO_PYTHON = YesPlease
>  	ETAGS_TARGET = ETAGS
> -	NO_INET_PTON = YesPlease
> -	NO_INET_NTOP = YesPlease
>  	NO_POSIX_GOODIES = UnfortunatelyYes
>  	DEFAULT_HELP_FORMAT = html
>  	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32

So before we were defining NO_INET_{PTON,NTOP} because XP needed it, but
doing so on all Windows versions, is there other compat stuff there
that's just catering to the lowest common denominator, and if so
shouldn't that be version checked against the NT version?

Both of the above are just questions I was curious about since I saw
your <nycvar.QRO.7.76.6.1810101502220.2034@tvgsbejvaqbjf.bet>, and
shouldn't bee seen as bumping this to "this needs a re-roll" or it
should be delayed in getting to master.

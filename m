Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 585C21F732
	for <e@80x24.org>; Sun,  4 Aug 2019 02:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfHDCXK (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 22:23:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45815 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbfHDCXK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 22:23:10 -0400
Received: by mail-io1-f68.google.com with SMTP id g20so160484628ioc.12
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 19:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lufia-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=EzGE/SzyOn8o1o53ql2y7ifQrKNonHiwIzoLDCqwroA=;
        b=yKppEBC9kPnssSgNRZpEZHm2pzySF2wIkZPGDmrVxeyDmFrz6ZCHtgFzThu1xEqtFp
         +dxdoST1rkcrnITGwhJaciI5mc36pENnxQRnn4EsGAzf5FRSeva79Z8Lksr/TTcLEKfL
         KmubjPirvvNjYpRc1Do8y7Y9SdoNWbstnOJOqQOD80YNrIWraaZI64d2Pww+T1wWBQIf
         HbG8s2yxMgRdnuA82Kuai/c66QJz/Q6vO+Kkn6CACyJa9snC1tjpGv188T6eHh0FCh/l
         G4pmpfYq+tucFDv6bfIjYv90P8sTemEMMlktudn7LYozo7RvnyGYDj0SJJyAP4c0Wq55
         AKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=EzGE/SzyOn8o1o53ql2y7ifQrKNonHiwIzoLDCqwroA=;
        b=W1Y57WffRatq1lc3kHqdK3J99boRYIq/cN7T9k/SrHNtZTsJKmG8o2I3GF337hkvgR
         Vyr1Awa+IgdvtodhACtV6kqfE9gIpkPOihDgcQnvB5m6la5ljHxaqi50AucN7EVQVRMf
         VqZUKjPr+OgI+DSMIQ5dMR112852nx+GKexrEIMMXGhQoqzt4eyP7BlN9siOnAgZ8Vic
         d1yDTKyFyO09OVntfG0UbKR88KIKZ7O+aWwJRRmarK5LiAvhPxmu8t1ZYeB5bXkzs437
         T/slAXPLnXlAUr1wPQ0T8Fajzu8Ju/eRm8QeXDXb+YlR7KQy/dcixxXTlOG8yrBjZHwg
         twqw==
X-Gm-Message-State: APjAAAUJGG2fkZ9OED8pB+jtbM3bmmeWKtSfcSAy+mVzvySHzXb9p+Mf
        Xdo7M0MpCXtU9YyWWISCaObMCh+O6WZA/j44JhU=
X-Google-Smtp-Source: APXvYqwq+K9HSP2yhMgySDFyaG79PF8Sn0gACOpBW9gw2RWUXGuxmgeaLlM4FaujpJc+BlKL+p0p9OdihQ6JNeCr2qc=
X-Received: by 2002:a6b:f816:: with SMTP id o22mr41455533ioh.166.1564885389498;
 Sat, 03 Aug 2019 19:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.305.git.gitgitgadget@gmail.com> <20190804003816.GE118825@genre.crustytoothpaste.net>
In-Reply-To: <20190804003816.GE118825@genre.crustytoothpaste.net>
From:   Kyohei Kadota <lufia@lufia.org>
Date:   Sun, 4 Aug 2019 11:22:58 +0900
Message-ID: <CAFMepcm6QVH+5H6on2hoWiMXd=Zoyi5MYP1GAt0WwixZN9oE_Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] Port git to Plan 9
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "KADOTA, Kyohei via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2019-08-04(Sun) 9:38 brian m. carlson <sandals@crustytoothpaste.net>:
>
> On 2019-08-03 at 23:52:08, KADOTA, Kyohei via GitGitGadget wrote:
> > I ported git, and git subcommands only written in C to Plan 9. This pull
> > request contains patches for existing codes, and new files to build git in
> > Plan 9.
> >
> > All build options such as NO_PERL are not supported yet, and also some git
> > subcommands written not in C is not available yet. But git can synchronize
> > to remote repository with git pull and git push via HTTPS.
> >
> > This pull request don't contain a part of Git toolchain for example
> > git-credential-store, etc. So I'm going to port other parts of Git toolchain
> > too in the future.
>
> This series seems to build a whole new build system that uses Plan 9
> tools. Typically the way ports to non-POSIX platforms (such as Windows)
> have been handled is that the Unix tools, including GNU make, have been
> ported to those platforms, and the POSIX (or POSIX-ish) environment used
> there.
>
> I'm concerned that by introducing a whole bunch of new, Plan 9-specific
> build code, we're going to have it fall behind with features or bug
> fixes, because none of the main developers test on Plan 9, and most
> contributors will not have the Plan 9 skills or systems to maintain the
> code.
>
> In addition, the editor used by git commit and other commands invokes
> "sh", but you've set this to "rc". That's completely different from the
> way that all other environments work, and it means that Git on Plan 9
> operates in a totally different, incompatible way there. We also use a
> POSIX shell for the testsuite, and we rely on it quite heavily. rc is
> not going to cut it there.
>
> Plan 9 has a POSIX environment, and I think it might be a better idea to
> require that as a condition for building and running Git. It will likely
> be a lot easier, at least.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204

I think it is possible to replace rc with ape/sh, ape/sh is POSIX
shell in Plan 9.

However Plan 9 don't have recent versions of Unix tools,
such as gcc, g++, autotools, gmake or perl,
so it is VERY hard to use Makefile instead of mkfile.

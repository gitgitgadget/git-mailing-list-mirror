Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65E471FAE2
	for <e@80x24.org>; Mon,  8 Jan 2018 18:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756169AbeAHS5K (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 13:57:10 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43078 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755418AbeAHS5J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 13:57:09 -0500
Received: by mail-qk0-f195.google.com with SMTP id j137so15467965qke.10
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 10:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WLHq1A3gMa8fJi5f5nlMrcZV3J8MVOKzQzlQpuYKcAo=;
        b=pR/m44ugIedNV6/kL7y5xpe/BkRhzCUVL+2Rf2pdjUvYpV+MGF5iDvNZS7ztxNmmUw
         CRsFYXNpSfCfo5RgcrVFbAZz2scPHGOolgn/JoU5TwES1STuLTA28BGMi434ETjEQVcH
         gdsEPG/wD0iqaM64RPtHtY+c6hYeKdH0R4gx6y3Oe0yGI3MPqARQi3iNjldY68lTRil7
         KLBSXXGSZ6f41Nf7Z5TxUgIO4hIP3kuoDcIReF4cx0tJCKtPf6wgGDen8W2DZCR58Yub
         S6SDt2CrgTYwc9Q7cZ8mO31ryBJ5SrvI2qsvELGwwXU2AmjYDCc/cfB3hOQvZrRzu5vs
         jpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WLHq1A3gMa8fJi5f5nlMrcZV3J8MVOKzQzlQpuYKcAo=;
        b=sKi6azTmKZwFcMsxBlsuiCfe7Xdcnm3cASCivZuKZHlxDroWLYbAQWWcEpdPcj1/6L
         gG6LV+6o3qzn0QUKK3UbZ7lH3UcmtZ3BVCait+YnghJRErDTJJgoEBkAusY06PRW/Onj
         qiOn3ZbjtQGlnJhlmrUHiW5EvZ3GVWYGxsZcTEUuXB9nJr1g/D35SMrLCQjROhMSZkMQ
         R8x80Zv92Eh9PBQiFBf7dg5Gpk5CUpz2TLqL7xs+etBElIOjEMdzWOHruOS8IXjANm+G
         kiEfD836Xb1gXzX6ssBMIYjekCTLVT5MBEyccd9/xuRXU4BBCkr2z+I1NOl/zrHTg94/
         r8zA==
X-Gm-Message-State: AKwxytesBNQ8dkGegLZB4KlgBXeFvVdvGZcCGBXJTHDuGZhjBQT80SiC
        GJ76tYGYtwH2rtXbKKWmjM1HHnBQ3zMjx9+std/Vt4s3
X-Google-Smtp-Source: ACJfBosceWlMjw6K2zGKGTl/egFxuFLghTG+NvMeMASZB5U4mXv+d/J8zvgRT7s+rS+BismVG7EHx/DUDCcTPQIibKM=
X-Received: by 10.55.19.162 with SMTP id 34mr17646962qkt.40.1515437828238;
 Mon, 08 Jan 2018 10:57:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 8 Jan 2018 10:57:07 -0800 (PST)
In-Reply-To: <20180106184614.20115-8-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com> <20180106184614.20115-8-kaartic.sivaraam@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Jan 2018 10:57:07 -0800
Message-ID: <CAGZ79kbiyA7g3dqxydBgN_q=NkudbgATUru+01Pi6ujSk9dVHA@mail.gmail.com>
Subject: Re: [PATCH 7/8] Doc/git-submodule: improve readability and grammar of
 a sentence
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 6, 2018 at 10:46 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
>  Documentation/git-submodule.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index ff612001d..befbccde6 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -132,9 +132,9 @@ expects by cloning missing submodules and updating the working tree of
>  the submodules. The "updating" can be done in several ways depending
>  on command line options and the value of `submodule.<name>.update`
>  configuration variable. The command line option takes precedence over
> -the configuration variable. if neither is given, a checkout is performed.
> -update procedures supported both from the command line as well as setting
> -`submodule.<name>.update`:
> +the configuration variable. If neither is given, a checkout is performed.
> +The update procedures supported both from the command line as well as
> +through the `submodule.<name>.update` configuration are:

Makes sense!
Thanks,
Stefan

>
>         checkout;; the commit recorded in the superproject will be
>             checked out in the submodule on a detached HEAD.
> --
> 2.16.0.rc0.223.g4a4ac8367
>

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CA1220437
	for <e@80x24.org>; Fri, 13 Oct 2017 12:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758400AbdJMMtW (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 08:49:22 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:54732 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758378AbdJMMtU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 08:49:20 -0400
Received: by mail-qk0-f178.google.com with SMTP id n5so4829326qke.11
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+qSVt6DwAcUAdU1hyhFwNHbppSmgBrUZF03VOQxcpdo=;
        b=BFD8aw4V17HaWg54ki+2zxO+dv832Lkx1owD4UVKoF6ph0nOWaub8/Z9UPaaNCuR0D
         aO6NBdqg9XBvxuV8Cy669uR4lN2Uwp0dn2BBmJbm3Gz8SaZlAbJiLHSkc3LejUkb4c4+
         iuJjtBVjshy+6yvGU/boEIpVtmYNagIU3Gkgd26bvq3RI47vODvWOn+A+ysQQf2NMDQU
         UzcHI6pEPQ553GI9pJe7iAmtvsSbvZUZkJF2ks3ysKD7hLcI1HamjNtGNnxVRd8NNa9k
         ZZSkBZ+E6EQwYTRqI3EPtDB2nqrXc5w/CBJIOIEn3EzVQnx4Q+SfDu9MGiatPcQzIMob
         ObXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+qSVt6DwAcUAdU1hyhFwNHbppSmgBrUZF03VOQxcpdo=;
        b=E26KwD30Q4CQ+G62YzQS6HsdGUJH1wbzNJ5D8Ps6YKdsLYObawmsMXM7qCxWXMKg5H
         3N26vi4H4Fcaw4zEL68c8FMdRqd/fKqvrws0Frk7VjfR+/SAkcYKlIeHT7iqpEAoIwHz
         snqtzKmj+qzNdDk4UKq2uCGkgdoDEPTqweCp5KctHkwYRA/f38I02oep+ud2Hva9Roxn
         6Z72YqUL+Slw75Wjc4XK9426r8J1zqtWLAN2EcqEZjATL3kQs4YpO2vtaYn/Crx4C1N7
         g1OSqOHYB6mzZM4mMNWWsgbBj5CUFGegeyP//NBJ+h7rYxq/rTi/oRhh89fMWtOD3uly
         IcJQ==
X-Gm-Message-State: AMCzsaWPVJo2FsZPwEZJngtUBUzvjUBxoGbwpY42g3hZsGocz6G4eQSd
        Jsak02oe2F8l9wZ4Z+jT7Y7Tpli7bfD25tIzeHE=
X-Google-Smtp-Source: ABhQp+TsLtpgBaL+LwN53KjYEPXI6Xyv16cZQH4JQDlCohHJkq4gOQWYmgQczqshLL+0S6yxgEItlIOxUzQKKefloqM=
X-Received: by 10.55.215.93 with SMTP id m90mr1717607qki.197.1507898959417;
 Fri, 13 Oct 2017 05:49:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.47.238 with HTTP; Fri, 13 Oct 2017 05:48:58 -0700 (PDT)
In-Reply-To: <20171012225339.2808-1-johannes.schindelin@gmx.de>
References: <20171012225339.2808-1-johannes.schindelin@gmx.de>
From:   Steve Hoelzer <shoelzer@gmail.com>
Date:   Fri, 13 Oct 2017 07:48:58 -0500
Message-ID: <CACbrTHfnph8Cp9G7LrspPa4s-E2ATHWkLqj7WDPFSiLXzOSz7g@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git for Windows 2.14.2(3)
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes,

On Thu, Oct 12, 2017 at 5:53 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Dear Git users,
>
> It is my pleasure to announce that Git for Windows 2.14.2(3) is available from:
>
>         https://git-for-windows.github.io/
>
> Changes since Git for Windows v2.14.2(2) (October 5th 2017)
>
> New Features
>
>   * Comes with Git LFS v2.3.3.

I just ran "git update" and afterward "git version" reported
2.14.2(3), but "git lfs version" still said 2.3.2.

I also uninstalled/reinstalled Git for Windows and LFS is still 2.3.2.

Steve

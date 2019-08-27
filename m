Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3121F461
	for <e@80x24.org>; Tue, 27 Aug 2019 17:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfH0Rz7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 13:55:59 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:34917 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbfH0Rz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 13:55:58 -0400
Received: by mail-ua1-f46.google.com with SMTP id m8so4495587uap.2
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/SptfAL6kDnGrLP5l53pIV2c+e3id0NRQotdjYjcnY=;
        b=tYNobd9ACN3uBt2OJ18w4qCIUND3i8AOnDMKrly8dhjx8hU6rT5lYqT8wG6RaNcprv
         zO18bvQ0K3+f9HyXoDfSJBJFeUAoHjrVIqwqSm6lPpWc+eZvbeaD9urwpS4/b0Rj/Snb
         iQK5lTt6ZX34MsabicWPZB9V7elICNdbAPsKGrWEFUgaJQeLTgPFQxtK4eTsVXvdj8K6
         w0zyQrDsuqRoQgM1aLc+CFMbAxp7pV9LpXhT87FmE08eGwXLNlcSBW1+9F1ZcS2jaBWV
         TFH2cloDEj69Dqmmh27S+O0Rft6YT4HeXmeNklMcJ6VkrbtOyk8FtIMBghh4qRkJKQQd
         x+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/SptfAL6kDnGrLP5l53pIV2c+e3id0NRQotdjYjcnY=;
        b=g4v8B0OphHTD1/Fb6ZTl8LgVCfnTNDaFRcvJ56LRP5UNH02gHfw8+sHMGkoG/b9il/
         JRVNGBU+P6X+FJllSNve9aZWE6alANS+kLGICmhhUloGDbSaSmnXllPDJLLAQzP5jyHZ
         6NDtlYLp3QDCE8cwOYgf5bq9PKg5OvrBEowKYocb8n5M+exAAYlr03mVyuJ+hlhZmdUf
         Whe+RSGLE+JvcaUTbqWhHorcLpF2UVgj8V1m+D/aVUXiiDFyZ9Th+THh4g1QomNuGk0m
         vIpOGNbOWkupBPV9xMpvvqR8s8x6sBSWmCAPrLQJonhx9svRI4YjGIl1Br5rPhhNlxXn
         Pf5A==
X-Gm-Message-State: APjAAAUR/7ICYg5r0n/s1v/vETBdx6iDKmHowPZEJBOHRL7xW8gxLioF
        CQP4WvpVRpmpWxRNu1BsR8QebiMnGKWBNpMAsXsiyw==
X-Google-Smtp-Source: APXvYqxOVL6VVm/0uu+j/J1nvjs1wyp4VlazXKWAOStJJANfmiHmsehwaK6JuyP5lvUjTxIH9RcNuRZRvvZL/dDRywk=
X-Received: by 2002:ab0:7393:: with SMTP id l19mr11397928uap.102.1566928557252;
 Tue, 27 Aug 2019 10:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190827162725.GA29263@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
In-Reply-To: <20190827162725.GA29263@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 27 Aug 2019 14:55:46 -0300
Message-ID: <CAHd-oW6MtoYAwv36_Jsx5qQzvLguXdvrA6NRA+D3ayHGmfVSqw@mail.gmail.com>
Subject: Re: How to build to debug with gdb?
To:     "Giuseppe Crino'" <giuscri@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 1:27 PM Giuseppe Crino' <giuscri@gmail.com> wrote:
>
> Hello, to debug some issues I built and installed git via
>
> $ make prefix=/usr/local DEVELOPER=1 CFLAGS="-O0 -g"
> $ sudo make install
> $ git --version # git version 2.23.0.40.g4d8aada92f

Hmm, could it be perhaps that CFLAGS is being overwritten? To debug
Git with GDB I always add this to my config.mak file:

CFLAGS += -g3 -O0
LDFLAGS += -g3 -O0

And then just compile with `make`. Maybe give it a try?

> But it seems there's still some optimization going on that prevents gdb from working correctly.
>
> For example
>
> (gdb) b builtin/config.c:752
> Breakpoint 1 at 0x43942: file builtin/config.c, line 752.
> (gdb) r config --global --edit
> Starting program: /usr/local/bin/git config --global --edit
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libth
> read_db.so.1".
>
> Breakpoint 1, cmd_config (argc=0, argv=<optimized out>,
>     prefix=<optimized out>) at builtin/config.c:753
>     753                             if (fd >= 0) {
>     (gdb) p fd
>     $1 = <optimized out>
>
>  What am I missing?
>
>  -Giuseppe

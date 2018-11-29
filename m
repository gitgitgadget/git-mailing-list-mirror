Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8125211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 13:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeK3AK7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 19:10:59 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46488 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeK3AK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 19:10:59 -0500
Received: by mail-oi1-f196.google.com with SMTP id x202so1490103oif.13
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 05:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GApdzFgEn7Bf3ueqlfgnl68lnYe/ZhgGw/hZcOgv33s=;
        b=GkeCdOwXxcmcUz96F2hqfTTty9iCBQpTXNGgv6gcLfMfBTmBXsSt+Xee/v1jrkFbJ8
         0oBWV6EijnyK7Nv7sXLOy3/Ffe6TMntT89hwQtMPD5AMPVjHcy4qe2xugwQgpBXAyM0W
         dWeyrdxnFNPB9SBNmCtQJPmSRsSv9rnrHOLllWckAyQzwQVcWpopJhKQbOMx+l5qC9uf
         4tQ2j0UG4GuApmEYIlXuOC8LMpDe9pwT85tziB2QpmBiyHlYz+j5Y3cm4CMZPdcI1sMk
         SRPfx8xXeG9mXxgFeq5InoI/vWQ8db99iuHgFLKus3bYWXLVSdxk/kwS2e+bu+8AdqKy
         np3Q==
X-Gm-Message-State: AA+aEWZ5TYlag3jY/U4NF24MiM4sDzCvwZrWKxXFh3vTv5Dg+Q5Vu+4V
        WcuB0HaA5wWqsdCWu4/Qnd1it1nNr7s3dEw/ttY=
X-Google-Smtp-Source: AFSGD/XjEUrPf3hT0/SQShwqVij6kBWJH2CTvGRtNtz8LD5xy5PgXZsKEqflUIdXieS79olz0UKBU8/Xovglt39dbZs=
X-Received: by 2002:aca:de03:: with SMTP id v3mr823541oig.152.1543496740269;
 Thu, 29 Nov 2018 05:05:40 -0800 (PST)
MIME-Version: 1.0
References: <CAABTFJPpmThrrwP6pb5gZ82fb8yKteLpDcXTCQS8p_7WZ0Ne5Q@mail.gmail.com>
 <CAGZ79kZtrj-Gg8P-xJmn8TYjgXuUmj8pJUXU+Vf89F0tKHuYBg@mail.gmail.com> <CAPig+cRU5pxZr50UpDwA2044dbX_jKZP1rhm4JQPB_yjgSTmgA@mail.gmail.com>
In-Reply-To: <CAPig+cRU5pxZr50UpDwA2044dbX_jKZP1rhm4JQPB_yjgSTmgA@mail.gmail.com>
From:   Kenn Sebesta <kenn@eissq.com>
Date:   Thu, 29 Nov 2018 08:05:13 -0500
Message-ID: <CAABTFJMGL5oD7ddJAedx7LzFPoTP6071qOE1K0p+xce7LQm4dw@mail.gmail.com>
Subject: Re: [bug report] git-gui child windows are blank
To:     sunshine@sunshineco.com
Cc:     sbeller@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just checked gitk, it seems to work fine including children windows.
This problem seems to affect git-gui only.
On Thu, Nov 29, 2018 at 5:16 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Nov 28, 2018 at 2:29 PM Stefan Beller <sbeller@google.com> wrote:
> > On Wed, Nov 28, 2018 at 6:13 AM Kenn Sebesta <kenn@eissq.com> wrote:
> > > v2.19.2, installed from brew on macOS Mojave 14.2.1.
> > >
> > > `git-gui` is my much beloved go-to tool for everything git.
> > > Unfortunately, on my new Macbook Air it seems to have a bug. When I
> > > first load the program, the parent window populates normally with the
> > > stage/unstaged and diff panes. However, when I click Push, the child
> > > window is completely blank. The frame is there, but there is no
> > > content.
> >
> > Looking through the mailing list archive, this
> > seemed to be one of the last relevant messges
> > https://public-inbox.org/git/20180724065120.7664-1-sunshine@sunshineco.com/
>
> I was hoping that Junio would patch-monkey that one since that
> crash-at-launch makes gitk unusable for Mojave users, but apparently
> it never got picked up.
>
> Anyhow, the issue fixed by that patch has to do with 'osascript' on
> Apple, and it's the only such invocation in the source code of
> gitk/git-gui. The 'osascript' invocation merely attempts to foreground
> the application at launch, so is almost certainly unrelated to the
> above reported behavior. Somebody running Mojave will likely need to
> spend some time debugging it. (Unfortunately, I'm a couple major
> releases behind and don't plan on upgrading.)

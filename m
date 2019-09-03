Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 355CD1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 19:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbfICT4H (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 15:56:07 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43999 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfICT4H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 15:56:07 -0400
Received: by mail-yw1-f67.google.com with SMTP id n205so6312160ywb.10
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 12:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YyKtxmgYgNZPhxGZHoZIGn9lYp3aBu9qaT/YoAj5tVU=;
        b=St4I1Ly3InjEpzv3jZmtFk1X6TV50sH/lmUhVbHagnDNXSVbG1Sa3YAq4dINKuXj5D
         2ggqow66ZiLPv89OdBlFq9phfSaCJ7QXEZBAXo8nSaPRBPVe/BXVuRQpnYMHhrFXdMmK
         PrLhzFT/k4NuPVnNmHHFqPsUCCjw701CrmDs2u8fWqNw0KjG3lpcVbLVB+RyxW+Yxx0K
         lgtAx+TPsQDZt1G9s+aEdcXnapYEqzQRtXvRFyhGtdEE5oNNLrTZf16jhhcFtMPmL8oG
         7QoZFDgfAKcuSq6n+Oy+VgAUGObCi69fMHrUmLhAJXS2AySkh1G6k9ghigG35F0quaU2
         9Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YyKtxmgYgNZPhxGZHoZIGn9lYp3aBu9qaT/YoAj5tVU=;
        b=suoVprtDM4bPKJtMTcE3hHk418l9H64YvP5X1LDSuEJiYVxW0d5YrYIs/ygiC53C26
         XwSIT0YPoZn75jI8ot9lNT6ofLXH71PWTtLICL4RNY8PRhM7jO2KMcP6m2kR/Q2QuO9P
         HLpZgTxpEXwz1DZy+E2K6h95m1YIu0QNX2U24ei363bs2gDfWzfHeiW5duvdaSvgCHJo
         z266HEtVzmlopsrwbtCzDvIW8YrI0/4tjik45keG4NdU2A70uf1KGAo+KtPGyy/vLLnc
         ko98RogUQD3jJv4xe55mW2xWBIDcqypKMdqPnJRmlNeQx/mIGi99YTmTE2bit2acObR5
         4EWg==
X-Gm-Message-State: APjAAAXmKvVmVbUQlBDeg06tfSY0SSRiPPkJH+9o8+gYHYUcPGrJNEcn
        ncLVwWUyH74geO9I7ozsvB7aOxs38k6axfsXR3h8M2uV+QQ=
X-Google-Smtp-Source: APXvYqxfnvBqwaqpNVIsBzGP3Yw26uqDsuufrRQfEiXfQ19ggm/v+TXUMRqSz0cp0tnbjoOAnl3VE7fdb3iBbUuB4vA=
X-Received: by 2002:a81:53d6:: with SMTP id h205mr3046051ywb.423.1567540565704;
 Tue, 03 Sep 2019 12:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHMHMxW4-6AZEDaJU8KOy2kRSLXjdC_RTH528=nnhVLXh=ADUA@mail.gmail.com>
 <20190903133422.GA51158@syl.lan> <xmqqa7bltcyu.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7bltcyu.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Tue, 3 Sep 2019 22:55:25 +0300
Message-ID: <CAHMHMxX192aM5owHjvi3s06ZykcQAHsVneBsfv9YvbeYM-XTXA@mail.gmail.com>
Subject: Re: Git does not recognise directory named '${sys:DATA_ROOT_DIR}'
To:     git <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Makes me wonder if git status could maybe warn about empty trees as 'untracked'?

Well, I "suppose" git-add could warn you that you are adding an empty
tree (and I'd like if that happened, implicit vs explicit action i.e.
ignoring).
However, I assume the no-empty-tree case was a design decision; hence,
it's been 2.2# versions without such warning.

I doubt it would be considered to be added now.


On Tue, Sep 3, 2019 at 10:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Taylor Blau <me@ttaylorr.com> writes:
>
> > If you wish to keep this directory "empty", but stored in Git, a common
> > convention is to create an empty '.gitkeep' file in the directory. This
> > file is not special in any way to Git, rather it serves as _a_ file to
> > keep the directory non-empty.
>
> Hmph, I thought the common convention was to create a ".gitignore"
> file in the directory with catch-all pattern, so that no matter what
> cruft you had there "git add" will not add anything from it, if you
> wish to keep this directory "empty".

I believe Taylor is talking about explicitly keeping a directory
empty, that may or may not, in the future, contain files (that will be
tracked) [1].
You are infering that, regardless if there are files or will be added
in the future, you don't want to check anything in.

While [1] is a very niche corner case (and maybe it doesn't make sense
to the most of us, true), there is a "debian-equivalent" behavior
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=812223

(I cannot find the definition of this behavior, but you can see an
example usecase)

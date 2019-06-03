Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15D01F462
	for <e@80x24.org>; Mon,  3 Jun 2019 09:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfFCJrR (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 05:47:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37571 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfFCJrR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 05:47:17 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so13774725iok.4
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 02:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+wuhR+iOeUfoXW6zUiWzN9ZP3if6K2hgBEqYaJCmZI=;
        b=On89LJxQbKFNzBMm8GPFIsERgOPrgWtyz0qDkKT4pAr+RI1xUstfYv9pF7TS24+TA5
         3qhHs/1ENZtg27UgvHNRv6p4wtqRiNWLNhPwTLsGvHy3Zv8hWwkA+Y88KtWYbjHAjSBO
         eAEbywEsCE1TJzhGdZwerM8BV7KGQeyUlMcGyqeA5vPja7nHWOPt8wFntdYAc1mtKsfD
         pSrRDh1IEcyBq//S6YxhzDonyAXNuZPNJ7bYAKsdm0pujRZUHbQR6WwmosZgJQSOMP4M
         qZhRftBElWi2jX9TvhNZuGU1WjYQCNehYl3kks+t+jZ6e1IQcptwcVHXJBB6dyQ16shZ
         pgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+wuhR+iOeUfoXW6zUiWzN9ZP3if6K2hgBEqYaJCmZI=;
        b=cC/c5ybapXoPSR04I+GAwmxtU6FxCG3kUM90LHTY147JIvP/BprT+KFS8L+B9o6aWf
         3ycb5LC/K6U/w0wdLVY6cKBghUwkglaQe2Zj00B/WYTMpv4RHuq8G6UKkkNy1xSXJ5Nt
         F2Kre0Fur7QTs2v0dA5jThPbaMfg2rlUHDqRpzO2chr6x0v7qgyR6D3IG/to43s68Fby
         CQjCXgJ2JbUo3wzE8ro2NXY0qX9VXdy1xF4vtIqQ+6sN5pf79cvqakX/bgerS7txVzMT
         0k23yVVxy4sI27vlOJYtPrM1LvxiLicT6Z/emrdMnInedFlvqVVdns2XNW7yehDc45J1
         Y3Tg==
X-Gm-Message-State: APjAAAUsLm2aypqq+rsdAAgYKONg9aUwofWbqbMYyTy3vyTPRWor/4ZB
        EwcLKU7a/R5IE6aYcsOp7UOX5odt+/PfQtYpV7tr8g==
X-Google-Smtp-Source: APXvYqyv+cJtaa4NEaaf7ITLed1iPGqwJ7ZescyJ9lMm0B3wnxnQ5Rz8ZFJrkTeyxGCXE1I/JmZiejtXhIfp2jKrYnU=
X-Received: by 2002:a6b:fa04:: with SMTP id p4mr1813422ioh.273.1559555236786;
 Mon, 03 Jun 2019 02:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <ad2ff81a-d75e-1ac4-07d0-c807a2ed9e36@gmx.de> <CAPig+cSsNQDe-3GLnmvA+EPior=RSPETJDjkCc7X1qi6gWSGDQ@mail.gmail.com>
In-Reply-To: <CAPig+cSsNQDe-3GLnmvA+EPior=RSPETJDjkCc7X1qi6gWSGDQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 3 Jun 2019 16:46:50 +0700
Message-ID: <CACsJy8CxSN90-EfTpkd6RUHFVp2iGjZXokpMqw7Tf0EMXT5LfQ@mail.gmail.com>
Subject: Re: worktree add already exists
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Ingo Wolf <ingo.wolf@gmx.de>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 2, 2019 at 2:11 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, May 27, 2019 at 11:32 AM Ingo Wolf <ingo.wolf@gmx.de> wrote:
> > $ ls -a barework
> > ./  ../  test.txt
> > $ git -C bare worktree add --no-checkout ../barework
> > Preparing worktree (new branch 'barework')
> > fatal: '../barework' already exists
> > $ git -C bare branch
> >    barework
> > * master
> > Why this doesn't just work and if not why is barework branch made then,
> > why at all ?
>
> It is by design that "git worktree add" (in general) fails if the
> target directory already exists and is non-empty. This is consistent
> with how "git clone" behaves. As for why your particular use-case
> isn't directly supported, it's likely that nobody has yet asked for
> it, and nobody thought about this particular case when --no-checkout
> was added (which came some time after basic "git worktree add" itself
> was implemented).
>
> It is an accident of implementation that the new branch gets created
> before "git worktree add" errors out due to the existing non-empty
> directory (and, likely, nobody complained about it, so it went
> unnoticed). This particular issue probably can be easily fixed now
> that the logic for checking if the target directory can be a valid
> worktree has been factored out of the code which actually creates the
> new directory[1].
>
> [1]: 45059e6468 (worktree: prepare for more checks of whether path can
> become worktree, 2018-08-28)
>
> > I would like to attach an existing dir to git (make it a workdir) and
> > then update the index with git reset and checkin the differences.
>
> I haven't thought through the possible ramifications, but the actual
> implementation might be as simple as changing this code in
> builtin/worktree.c:validate_worktree_add():
>
>     if (file_exists(path) && !is_empty_dir(path))
>         die(_("'%s' already exists"), path);
>
> to:
>
>     if (opts->checkout && file_exists(path) && !is_empty_dir(path))
>         die(_("'%s' already exists"), path);
>
> or something.

Coming from "git clone" background I would still expect --no-checkout
to abort on non-empty directory (i.e. we always start at a good known
state). Maybe another option can be used in combination with
--no-checkout for this. And do we want the same option in "git clone"?
-- 
Duy

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 357D621422
	for <e@80x24.org>; Thu, 10 Jan 2019 16:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfAJQQj (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 11:16:39 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:52168 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfAJQQj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 11:16:39 -0500
Received: by mail-wm1-f43.google.com with SMTP id b11so11836537wmj.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 08:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=So4TkgPN5dWOvWw057h+9vjZK/N1IKoCAuf5DflIofE=;
        b=aFvZ8jfJibatiUJPual8YxjoFrSzNlt+3l1NgKv3MBlt6bebSlg0VRaq/Ga7pDYrO8
         ddSe4a1XonRj6JsQUjFXDP6PU4F16f7N9uTKAmF9Gndd9KfbTy+okiTNQDeVNIqz5OG0
         y118EMaCUWCn/7XS5jiEMzNbMWCq3i0ExYv5Ki3+ss9vAKVSsTI8q4z17v8fSUKPnmrP
         BRSddb307XMx/3/I8PjvIVdquSdUFd3T7iojC0okOfCgjT1Y53fNUUa9x/97EDoWp6Rh
         pLccmNbCuq4hsb+3U2vd/GusAlLVwY/2H9EiyvoxyIieGfQ9fV0aYa4zqx+b1bM69Kts
         HAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=So4TkgPN5dWOvWw057h+9vjZK/N1IKoCAuf5DflIofE=;
        b=scKRY7ZphZhjPqFbZV05LHIXoRlUXUpgyRyaVk8EYrZPk2LaP3R0d8pOJjTj2u/6OL
         Q67GAPTjQflKgEU5Qj8F85gUE0jiMSknBrVxPJMKFyUymBG2F6E5d/1XsNFzyeyq9JYN
         fzjDbCnsJDj/cxJn0YdzsirZpwFiZRUvy5gd3+D45hyW61rLyg09YCPzr0yWVVLLLJ1H
         xP1TnHSAR51H3CaGmGLg924ERxLjPvDNfq1z2zlW62kpqHnAIjmemOfiESfk9cSrLNPF
         1mNKX09IrzhG8tRfqSPiB96n4VoWfe2aO1UPtoAhj/WtobXzmshV1majn46ZTz9MkJGZ
         DfTA==
X-Gm-Message-State: AJcUukdGCzzhZbScwwOyhE7IU08lrj+WEkVajC7/WMp+sFbMlYxULLy9
        rHlZs3gJbLaHXDaBpog7utXpoDk0Tho1+yHMxTLvN7/kxNg=
X-Google-Smtp-Source: ALg8bN5jXAxIwcfM9y8wGyO1EgYLMMLJYoMX8TkKyr3zZkjLEUDCiFPvYg+bAqPzDnGWhx2iVCAzN67k4EhZGwK9r5o=
X-Received: by 2002:a1c:8791:: with SMTP id j139mr10063590wmd.86.1547136996090;
 Thu, 10 Jan 2019 08:16:36 -0800 (PST)
MIME-Version: 1.0
References: <CA+dzEBmh4LdN-XFS9y9YKrDMzV_7+QpDzBA2uv9Xi80PgR5NTQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1901091922300.41@tvgsbejvaqbjf.bet> <CA+dzEBn_-=77ZzfOaS8nVnQkf4rh0Y6TbEknZe6c02cwktrTJg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1901101620470.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901101620470.41@tvgsbejvaqbjf.bet>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Thu, 10 Jan 2019 08:16:24 -0800
Message-ID: <CA+dzEBnUTybrK-V3xQJmDoNU8wDtuDKhDzKEtCBhFdP=5x3G5Q@mail.gmail.com>
Subject: Re: git add --intent-to-add + git stash "Cannot save the current
 worktree state"
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 10, 2019 at 7:21 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Anthony,
>
> On Wed, 9 Jan 2019, Anthony Sottile wrote:
>
> > On Wed, Jan 9, 2019 at 10:25 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Thu, 3 Jan 2019, Anthony Sottile wrote:
> > >
> > > > Minimal reproduction
> > > >
> > > > ```
> > > > git init t
> > > > git -C t commit --allow-empty -m 'initial commit'
> > > > touch t/a
> > > > git -C t add --intent-to-add a
> > > > git -C t stash
> > > > ```
> > > >
> > > > ```
> > > > + git init t
> > > > Initialized empty Git repository in /private/tmp/t/t/.git/
> > > > + git -C t commit --allow-empty -m 'initial commit'
> > > > [master (root-commit) 858132e] initial commit
> > > > + touch t/a
> > > > + git -C t add --intent-to-add a
> > > > + git -C t stash
> > > > error: Entry 'a' not uptodate. Cannot merge.
> > > > Cannot save the current worktree state
> > > > ```
> > >
> > > Apparently it is even worse. On Windows, this reportedly resulted in a
> > > segmentation fault:
> > >
> > > https://github.com/git-for-windows/git/issues/2006
> > >
> > > Could you cherry-pick the fix of
> > > https://github.com/git-for-windows/git/pull/2008 and see whether it fixes
> > > your use case, too?
> > >
> > > P.S.: Obviously, if this PR fixes the issue, the corresponding change
> > > should be squashed into the appropriate commit in ps/stash-in-c.
> >
> > I don't see a `stash.c` in ecbdaf0899161c067986e9d9d564586d4b045d62 --
> > the patch doesn't appear to apply
> >
> > `stash` appears to be implemented as `git-stash.sh`
>
> Whoops. I thought that you were on a different Git version, one that
> already has the built-in stash. My mistake.
>
> Sorry,
> Johannes

Oh, is there a more recent version than the one mirrored at
https://github.com/git/git

Anthony

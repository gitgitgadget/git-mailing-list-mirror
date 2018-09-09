Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A741A1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 15:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeIIUSk (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 16:18:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41361 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeIIUSk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 16:18:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id h79-v6so9206030pfk.8
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 08:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silentorbit.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WqpKZq186OBhHIiDh7nJOTSsgPKEldTNFQFmCujvKgw=;
        b=nDKRuPLNv2MdCXpypwW/rH3kxC/q4WdjIiShigikGy9ld1GIUvOf0HawLxDfelHnGk
         fEnCDaKS+Os0PZV9UfRPyVqEpeWLa4Gy+eMv8JlLznLeEnY+Iwpy8WBYp/1+CTNs+sP1
         NLzLEyVgfIClqdPQCPuFV2989fwNdCgQV5F4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WqpKZq186OBhHIiDh7nJOTSsgPKEldTNFQFmCujvKgw=;
        b=M9JW0USnIcJpdnRjGxV7yP0C0BG9lFC07cJHJqkzpfa4ZdzoszedrDANcuJDSw147d
         f8tDGg2X8zxDuHTHZw0I56qK6UdLzWIuvvkF8r6uwGEBF/EjFp9t/ig7uUWlZuvPHlww
         ezeNYfAYf3QufmvUAz6N6i1IdqdnD8QvZHD2YVWbiomBNuqxu0zZkgL8oFXpheVxYsgJ
         mqH9uUCTBFEm1nSPxxpvB5/ev4n+dZoKdywthbZVQSZnRGPaC3dg9Be++MLP2A5TCb/e
         C849ao9nku3FLIA6FeLP8xk1MUErhoaqX8i5s9IGP6ZuMuqBP+yH01EW+yr5lWYmrVWV
         nkdA==
X-Gm-Message-State: APzg51DGy9HrX0KEm1uWJk/57Wa1lh3tVpmnx3ojPG2545jBbc0fF68h
        iR7lRhgGeA+l1U0od5uBfSCZfxoLptHVxrHRFYFprg==
X-Google-Smtp-Source: ANB0VdbXptCu/CDMnddnX06p87dhdS7HBWAFTOPMWSOqIQSuulikzby/8JWAi0NRwiSj5KTKCLV9Atj072R3sLEXoHY=
X-Received: by 2002:a63:b44c:: with SMTP id n12-v6mr18120067pgu.337.1536506918172;
 Sun, 09 Sep 2018 08:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAJmnt9Yfed1W7F=C+dzac3AEe7nRq2cNP335MepTczboKJNoEg@mail.gmail.com>
 <xmqqbm99xngs.fsf@gitster-ct.c.googlers.com> <CACsJy8DymnKk+Xo6UPQyAsToNpkSX4Ae+jzc04+0qXrZ6bmb3w@mail.gmail.com>
 <CAJmnt9ZOCJfGFJ98xD17BYU1P=nRZ=eG16Oj5DjTMaF7H6WTvg@mail.gmail.com>
 <CACsJy8AMaUmWO2zi9+Dpr9_ZHE7A0rSs63h646w4uokyKRAdUg@mail.gmail.com> <CACsJy8DdxmVd_jBG7Tp1e7k-BUc6R1=oWzPZ3z6xUZs2XU9rMA@mail.gmail.com>
In-Reply-To: <CACsJy8DdxmVd_jBG7Tp1e7k-BUc6R1=oWzPZ3z6xUZs2XU9rMA@mail.gmail.com>
From:   Hultqvist <hultqvist@silentorbit.com>
Date:   Sun, 9 Sep 2018 17:30:57 +0200
Message-ID: <CAJmnt9YxGoQO40GNQY=nTjGGaGB5X079koZ0QvCOZ4wd7ubkaA@mail.gmail.com>
Subject: Re: Temporary git files for the gitdir created on a separate drive in workdir
To:     pclouds@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since this thread started I haven't seen a single file mentioned being crea=
ted,
Usually they appear during work days when there is more activity.
I've never seen the files created directly, only a larger amount of
them once in a while.

I will run process monitor and get back once I find out more.
Den l=C3=B6r 8 sep. 2018 kl 15:44 skrev Duy Nguyen <pclouds@gmail.com>:
>
> On Sat, Sep 8, 2018 at 3:09 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Sat, Sep 8, 2018 at 11:28 AM Hultqvist <hultqvist@silentorbit.com> w=
rote:
> > >
> > > The bash commands are using a git and bash bundle that was installed
> > > in parallel with gitextensions(a gui for git)
> > >
> > > G:\Min enhet> set GIT_TRACE_SETUP=3D1
> > > G:\Min enhet> git st
> > > 10:40:28.881927 trace.c:318             setup: git_dir:
> > > C:/Users/hultqvist/Drive.git
> > > 10:40:28.881927 trace.c:319             setup: git_common_dir:
> > > C:/Users/hultqvist/Drive.git
> > > 10:40:28.881927 trace.c:320             setup: worktree: G:/Min enhet
> > > 10:40:28.881927 trace.c:321             setup: cwd: G:/Min enhet
> > > 10:40:28.881927 trace.c:322             setup: prefix: (null)
> > > 10:40:28.882930 chdir-notify.c:67       setup: chdir from 'G:/Min
> > > enhet' to 'G:/Min enhet'
> >
> > Unfortunately this looks good. Whenever those files 'index',
> > 'config'... are created, they should always be created in
> > C:\Users\hultqvist\Drive.git, not G:\Min enhet, including their
> > temporary versions. I don't know if there are any more changes on the
> > windows fork that could affect this though, I only checked git.git.
>
> BTW do you notice these files showing up after any particular command
> or they're always there after cloning? Perhaps some command got the
> ".git" directory discovery wrong and assumed $GIT_DIR=3D$GIT_WORK_TREE.
> We have a much bigger problem then.
> --
> Duy

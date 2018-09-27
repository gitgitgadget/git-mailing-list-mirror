Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA4A51F453
	for <e@80x24.org>; Thu, 27 Sep 2018 17:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeI0Xo2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 19:44:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37034 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeI0Xo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 19:44:28 -0400
Received: by mail-io1-f66.google.com with SMTP id v14-v6so2489891iob.4
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 10:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H/OM1o8AMY4GohgeJiylNC0tzmJZ8t8YTAySN+WIXGo=;
        b=FhBEEr8ntEOs2Rh2vU649I2gMrQUwO2NvwpLKl4lWfT+1DSJsn1zJedLyAL+9OjLqx
         sH9HmUyoHfsoKwgmG/oYjtUXPXhgiB8H0tEyuhEnagH5meAJyPliLLCbrmwjdXvvre7k
         uwTvNVD4bzzCiChhFnZy2MS/WfjGeO3JpuzW+83SVvk102AkwBQc4PhG2mLEdhNh/3jx
         NVTpkl30BcdZ64iqApaGHrLkd8KYiHGR2dnRfsSyOQ2M/z0BDkBarLipeh7x4nUdXmSa
         /Z2j5Epi0q64WqZbYK3sGOIFxdxRWDiLfuBRJYKY8ck91uskmNwZOQJp58QY07EdCK+W
         i5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H/OM1o8AMY4GohgeJiylNC0tzmJZ8t8YTAySN+WIXGo=;
        b=IICpHOEUMzMREMTliwwllrjhSdUqjAARortj87vH6eijJr9VUynBfxJOfj7SPO7++a
         Ofg+onCmNdW9SziKEcMMxQKZXgohNsAoImfhZqmqDHt0GsNmLZOMyeAvh2nfzyWVI0aE
         Xs01airVcFedL23amduUWqakJqQux5CZiU0QOLZCzGx4DTMIXIWNcBePkVHlEZYCzCXr
         yMIRrDyPzKzZnW13OlmCkvLcf+ha7VWYw7WvynlUjAaDeRKSZZaTmthj8hZpkMDEp2tP
         TJNU3fWhZH3dF2hgnyMx1hLyj6y89qkLrcUqu6TX5CD3DFQJFMEnJPjH08CfGflOgWc9
         F5UQ==
X-Gm-Message-State: ABuFfoh0LKQRXFt5cNugprzDCv8UkVHLhHykreEg8f9lF/yOJCKdYc9Q
        wTSQnuYpna+VC0rCgVVkfJAKt3rwR0wn01EvQgoxjg==
X-Google-Smtp-Source: ACcGV63zOhaEFtkU0SfgqAlzf4nD7NU010t84QMu19BMz9luYBhOckPlN96q1tm+8uOUwJC0RY+4chwd/P0S86wz04I=
X-Received: by 2002:a6b:8f93:: with SMTP id r141-v6mr9113440iod.118.1538069109096;
 Thu, 27 Sep 2018 10:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180923170438.23610-1-pclouds@gmail.com> <87bm8kjeu5.fsf@evledraar.gmail.com>
In-Reply-To: <87bm8kjeu5.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Sep 2018 19:24:42 +0200
Message-ID: <CACsJy8Dwo_cBEQeqttj3G=RGaJT7bmVb=ABnV2916swgYQnyrw@mail.gmail.com>
Subject: Re: [PATCH] worktree: add per-worktree config files
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 8:25 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Sun, Sep 23 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> > +extensions.worktreeConfig::
> > +     If set, by default "git config" reads from both "config" and
> > +     "config.worktree" file in that order.
>
> How does this interact with config that's now only used if it's in
> .git/config? E.g. you can't set remote.<remote>.<url> in ~/.gitconfig,
> will that be inherited across the two of these?

Er... we can't? If I remember correctly we don't have any enforcement
on where what config vars must or must not go. The only exception is
core.bare and core.worktree which is only read from $GIT_DIR/config
because of the way they are involved in .git directory discovery. If I
put remote "foo" in ~/.gitconfig, "git remote" happily reports remote
"foo" to me.

To sum up, we always inherit config from higher levels, with
/etc/gitconfig being the highest and $GIT_DIR/config the lowest. It's
up to the user to share config between repos responsibly. This patch
only adds one more level, $GIT_DIR/config.worktree which is now the
lowest level.

> > In multiple working
> > +     directory mode, "config" file is shared while
> > +     "config.worktree" is per-working directory.
>
> "But then how will it work with more than one?" I found myself thinking
> before reading some more and remembering .git/worktree. Shouldn't we
> consistently say:
>
>     [...]"config" and "worktrees/<worktree name>/config"[...]
>
> Or something like that?

Point taken. Maybe I'm trying to hide implementation details too much.
--=20
Duy

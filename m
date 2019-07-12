Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 077ED1F461
	for <e@80x24.org>; Fri, 12 Jul 2019 06:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfGLGju (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 02:39:50 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:36503 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfGLGju (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 02:39:50 -0400
Received: by mail-pl1-f175.google.com with SMTP id k8so4300778plt.3
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 23:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=6DoVg9gSn4qE9DTU1oL/KPD5tRXPSz+PILr/Mae4yrE=;
        b=r88vgLWmm8u+sbJMjWD9khnqhmL4iCLPElXUEhJW4sMxuDFmUP725gWJ6g8KmKA19V
         9+P3Sf5T1nqQEuVPvFy/rF/Zif5PYA1nuDkw+Nz/Z0XY1uH1yIpInltGFeszIIl33LsX
         GjWdPENX1eRbS5W6+kjjQweETjVvvvyKMWdwlP9RZNHvmeQ/jDeAt+KGRKKoNC8AmSkU
         A+Rnu/w75gyrHR/99ky7lsy0aLqaxFDjm+mK0LjFyWa3WcIdDbzITYYHEUzDIz0XTuiS
         38I8hWU1VnAiaY7a73oC6/fqu6IpQ05QDXtbvDXhGEtuPq5XeZj2PTvpPv+Y7mt9Pqzv
         qdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6DoVg9gSn4qE9DTU1oL/KPD5tRXPSz+PILr/Mae4yrE=;
        b=k0DwG/D8Gqd1zovae9vJvyuAxLcRovwZrpO8W2E/REWWrwXU76xJTHWyNd731+J9dz
         NWOs+rpo6u0vTcUZgiIsrb21RNTlL9Lq6VrkpPyTDnd3BRHEGk8BlpzlwJ2X14nuAOze
         M0JGLo00Om7jwEnMRKgs5uJU82MKp7+am645k9mCEk2yZGJKTNgp7lNUG01gmC9R9p0M
         URU0S6sZup6f71NtPxhzHDiFwYdK2zGNSpoAy9z/eKdssjdR27rcF5mQdAaKPUbL5Ycw
         XXSMZJmkS9eqzIerZdW95ElljnE2pjOAAXUXOpbjpXgsrgVX8bUxkiQipyEG+v7uflxA
         aG8Q==
X-Gm-Message-State: APjAAAUVBuAUeYQcuEP7O9jyGBof+G8Onlrqzs+6GmtHQRKdYAZcE2G8
        Ll033He/H8kk61Ov8f9bzakk81LRwzE1VcdUfIcEesvf
X-Google-Smtp-Source: APXvYqwV5XOu++5K99qb83lcuL9VNAQ1HI6WMIF23q/LjQP6BtP/q/Z1dMtA3yzeLjKpIoYwTUOqVO85hwfOQ7wWBTU=
X-Received: by 2002:a17:902:204:: with SMTP id 4mr9257332plc.178.1562913589717;
 Thu, 11 Jul 2019 23:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <CACf0ZibKt-mpqpavmK3SVMC-Lqm9KB9kUvPj-KFkvT_LVRyOZw@mail.gmail.com>
 <20190711220118.GL9224@genre.crustytoothpaste.net>
In-Reply-To: <20190711220118.GL9224@genre.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 12 Jul 2019 08:39:36 +0200
Message-ID: <CAN0heSp9ZsEkxNReV8EMpNzTWJCLqL2hjQir+oA8bkEE6zv5uA@mail.gmail.com>
Subject: Re: Pull vs push messages
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Kielstra <pmkielstra@college.harvard.edu>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 12 Jul 2019 at 00:16, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2019-07-11 at 21:36:50, Michael Kielstra wrote:
> > Hi all,
> >
> > I noticed that git pull reports "Already up to date." but git push
> > reports "Everything up-to-date".  (I'm using git 2.20.1, the latest in
> > the Ubuntu repos.)  Just for a consistent user experience, would it be
> > worth standardizing on:
> >
> > Hyphenation (up-to-date vs up to date)?
> > Periods at the end of one-sentence messages?
> > Colloquialisms and tone of voice?  "Already up to date." sounds like a
> > terse error message but "Everything up-to-date" sounds like a chatty
> > friend.
>
> I'd be happy to review a patch that changes this, if you think it's
> worth changing. Generally the way things work here is that except for
> obvious bugs, people send patches for things they care about, and then
> other folks will review and make suggestions, or sometimes there won't
> be any interest in a change, and the patch is dropped.
>
> We'd probably want to standardize on "up to date", since that's the
> correct form here according to the Chicago Manual of Style, and drop the
> period, since this isn't a complete sentence.

There's 7560f547e6 ('treewide: correct several "up-to-date" to "up to
date"', 2017-08-23), which changed a few of these, but also explains why
it leaves "Everything up-to-date" unchanged. Whether that assessment is
the One True Way now 2 years later, I'm not the right person to say.

Michael, you can perhaps find some discussion leading up to / about that
patch on https://public-archive.org/git/

Martin

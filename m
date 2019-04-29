Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543271F453
	for <e@80x24.org>; Mon, 29 Apr 2019 21:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfD2VeF (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 17:34:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40321 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbfD2VeF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 17:34:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id y49so8090919qta.7
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 14:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JbPTncw3p1wTd1SwVx7HZ6UwfOVLD3hlLiIko9ka6oI=;
        b=Fq0RlXYBerTcyQF13DXVU1HGAnkjYFN41y2V5ehalsNnM/HjLQqpdHrx44LrXPAl0L
         0sv/BlBZTZmRihNesWWNskdFoDQVmFUJPPscdybvGpUzBX7sHgJjh52IDMHQ21mbs175
         kjAJVqJ7PwrAHxl7CJMJ2WuttiIKKN7hvQeaIPtXz1fOjgNwEftX5vzxwqqGqX92o3Vo
         3efRfrc4d1Jtj0EqctHrBUUuV/+kxwHnpBjd/BqRQZNUyza9CQovs/L05YWuBMwm6xwK
         XaT4ERSbdOxU6QIcZYRAN1P6XWmJWLA2B9NDN4TGgLTK7BMC8po3hhIR6dsXqbUzqj2f
         +sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbPTncw3p1wTd1SwVx7HZ6UwfOVLD3hlLiIko9ka6oI=;
        b=RGf9Ev7PTsL5vhR0heJY6P+lLaikggRCK0wlOSRBObzCNznez9+8LFyusjzTraDRpr
         aLjsK18/K7NfjVrKcLo/bk/DEMQ7x4Yec9uXeEqUQB2GIlmzv/Fr2b5iquWwz+S8A1xJ
         bUrTTNEx2fxj1aapaiR5NoLUNEXNddsv06ycdtzW0lpt2HKhEUpYfC7/iVa71PLMlwxs
         h70pLGxRNb6SF/uMDxWsJU7T8OjrJqIsXXzsBSwUVOmUyelIC4chj9DYsbDCKmP2FQuD
         kTVyspIO/m986tAKUjxTNwt18zhSyclyjnD1qj1BJ+3AmZRZy+uaMLAkZzSfS57Z9N3k
         tW8w==
X-Gm-Message-State: APjAAAU8u3N8/5SuypxLdra555QvQ0hyU+7TwnRryAs8uy04lcNiDz1q
        akpGvkf05pWIujtuOOXJbzO9+cCiCD6/q+N891I=
X-Google-Smtp-Source: APXvYqxxG9nWih5R8ccSElUoRUzWzhpnrgJHonSM05tCXhNn8MjkWi0RvjPPTR871pbfhgZAOakUGnnFA56RojTutOA=
X-Received: by 2002:ac8:1c76:: with SMTP id j51mr42811042qtk.365.1556573643859;
 Mon, 29 Apr 2019 14:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190429051944.77164-1-nbelakovski@gmail.com> <nycvar.QRO.7.76.6.1904291656550.45@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1904291656550.45@tvgsbejvaqbjf.bet>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Mon, 29 Apr 2019 14:33:37 -0700
Message-ID: <CAC05384E9Unm8qzjbXAsvn01xzbAPqg84vC=V90AGscA2cPOog@mail.gmail.com>
Subject: Re: [PATCH v10 0/3]
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I'm not very accustomed to mailing list development. I had
assumed that this was being threaded with the other messages in the
series, hence leaving the subject blank and only putting new info in
the body.

In the future I'll add in an appropriate subject and brief re-hash in
the body. Thanks for bringing it up.

Nickolai

On Mon, Apr 29, 2019 at 1:57 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> am I the only person who is puzzled every time this patch series with a
> completely empty subject and without any further explanation about the
> intent in the mail body is sent?
>
> Ciao,
> Johannes
>
>
> On Sun, 28 Apr 2019, nbelakovski@gmail.com wrote:
>
> > From: Nickolai Belakovski <nbelakovski@gmail.com>
> >
> > Added test_i18ncmp per instructions from Szeder
> >
> > Is there some other part of the infrastructure that's testing for this? Because it did not fail in any of my Travis CI builds.
> >
> > Travis CI results: https://travis-ci.org/nbelakovski/git/builds/525801210
> >
> > Nickolai Belakovski (3):
> >   ref-filter: add worktreepath atom
> >   branch: update output to include worktree info
> >   branch: add worktree info on verbose output
> >
> >  Documentation/git-branch.txt       | 12 ++++--
> >  Documentation/git-for-each-ref.txt |  5 +++
> >  builtin/branch.c                   | 16 ++++++--
> >  ref-filter.c                       | 78 ++++++++++++++++++++++++++++++++++++++
> >  t/t3200-branch.sh                  | 16 +++++---
> >  t/t3203-branch-output.sh           | 43 ++++++++++++++++++++-
> >  t/t6302-for-each-ref-filter.sh     | 13 +++++++
> >  7 files changed, 168 insertions(+), 15 deletions(-)
> >
> > --
> > 2.14.2
> >
> >

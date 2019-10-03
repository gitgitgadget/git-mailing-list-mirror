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
	by dcvr.yhbt.net (Postfix) with ESMTP id E86BB1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 16:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403862AbfJCQfK (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 12:35:10 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41823 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392206AbfJCQfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 12:35:09 -0400
Received: by mail-vs1-f68.google.com with SMTP id l2so2155104vsr.8
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 09:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aYMM8A3Qw/YsB5j0nd3xZG5V5KqnETNUhlrxMhMWYuw=;
        b=C6eu1cHgK6LQkFXO7V0RwjhexM+EAVHHsOWbes5ra3CyoYbMBrL3VbPjc7zmp+omi+
         oVR3H2er0eS3o1XAUHo9iL/YidmEcBOEIiT/sFKZf6U6Kqn4jX4aD44Bd4Ag/jR52h6h
         TF004zoecT4zb40Ya7gAsAhqjpuwJo1BK3HHc08OWduxJtLe47R0zz80WY4x1KyDF3Kr
         lEs64FBV/6okHIQ5h1GeYOyaYnJo4AWuSTlvF7FMvPx35r5UAvALGJD2ubc0lVO1Bkd9
         fEnbDI5CX+me0IEntpLsW7eCPil35rqvINmjtsUrFaOiEvoqMrV3b/MbDpREPp6BuKQU
         gZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYMM8A3Qw/YsB5j0nd3xZG5V5KqnETNUhlrxMhMWYuw=;
        b=fLvn52y9PLt4nR0xkKfxpar4YFdPRpJ9K8GN3OjKNQblKUGfLX/9+Av7NURNK+qjKu
         Gg9Ol+kRX3rnH+XM+ytYjeODOvXsStUneU0I7vMIVI/yy43l0R01XRINoW1oT9lFH30r
         uZxFrcLMOmCi8PDbbawobdTqQnIw2GH3+2k3OUD4J0tK5/KLjx7VHKFabr59BpD5hxXr
         j2RfSt41S1cmo01A8UkM+THrGxy20uvtZEYAIzZqvf+H2KF9y7Vqlxx9Nt3u5PRSd8hn
         ghtvDokDAzo4sYlJ6yiO43bFuSoBo8g4zxsg7VAsuKM5b3I1DNsG40LXi/wJ/XCLqG6R
         pqgQ==
X-Gm-Message-State: APjAAAWHmgtEpBg8iZvS9IDgW3hfD79GTAYjh2e3mm8d2bryOOEUjmE2
        2uqYVIjtinN/2SX2LXtCWO1oPzR6eSS9LTBQy6o=
X-Google-Smtp-Source: APXvYqzV4fe8Eg12YT5L2ICkgKtsiRyJk1e0DgKBysfSzFtvtJzMmUcSmc5RuXzfjxT9EDF1R2nBjx32IQp31piLtGI=
X-Received: by 2002:a67:c297:: with SMTP id k23mr5361469vsj.31.1570120508366;
 Thu, 03 Oct 2019 09:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <1aeacd8af4b83142f160c63be4746554e823cfc3.1570051490.git.bert.wesarg@googlemail.com>
 <20191002214709.GA51809@generichostname>
In-Reply-To: <20191002214709.GA51809@generichostname>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Thu, 3 Oct 2019 18:34:57 +0200
Message-ID: <CAKPyHN0xqis9_Apwi4LmNuhO9aGQdZ4qRs_hcm2YUVLK391W_Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] format-patch: document and exercise that -o does only
 create the trailing directory
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton,

On Wed, Oct 2, 2019 at 11:47 PM Denton Liu <liu.denton@gmail.com> wrote:
>
> Hi Bert,
>
> > Subject: format-patch: document and exercise that -o does only create the trailing directory
>
> s/does only create/only creates/ ?
>
> Anyway, as a prepatory patch, I don't think that it's necessary. Maybe
> it's just me but I assume that most tools create at most one directory
> deep. Even mkdir won't created nested dirs unless you pass `-p`. I
> dunno.
>
> On Wed, Oct 02, 2019 at 11:26:11PM +0200, Bert Wesarg wrote:
> > Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> > ---
> >  Documentation/config/format.txt    |  3 ++-
> >  Documentation/git-format-patch.txt |  4 +++-
> >  t/t4014-format-patch.sh            | 16 ++++++++++++++++
> >  3 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
> > index 414a5a8a9d..e17c5d6b0f 100644
> > --- a/Documentation/config/format.txt
> > +++ b/Documentation/config/format.txt
> > @@ -80,7 +80,8 @@ format.coverLetter::
> >
> >  format.outputDirectory::
> >       Set a custom directory to store the resulting files instead of the
> > -     current working directory.
> > +     current working directory. Only the trailing directory will be created
> > +     though.
> >
> >  format.useAutoBase::
> >       A boolean value which lets you enable the `--base=auto` option of
> > diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> > index b9b97e63ae..fe7492353e 100644
> > --- a/Documentation/git-format-patch.txt
> > +++ b/Documentation/git-format-patch.txt
> > @@ -66,7 +66,9 @@ they are created in the current working directory. The default path
> >  can be set with the `format.outputDirectory` configuration option.
> >  The `-o` option takes precedence over `format.outputDirectory`.
> >  To store patches in the current working directory even when
> > -`format.outputDirectory` points elsewhere, use `-o .`.
> > +`format.outputDirectory` points elsewhere, use `-o .`. Note that only
> > +the trailing directory will be created by Git, leading directories must
> > +already exists.
> >
> >  By default, the subject of a single patch is "[PATCH] " followed by
> >  the concatenation of lines from the commit message up to the first blank
> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > index ca7debf1d4..bf2715a503 100755
> > --- a/t/t4014-format-patch.sh
> > +++ b/t/t4014-format-patch.sh
> > @@ -1632,6 +1632,22 @@ test_expect_success 'From line has expected format' '
> >       test_cmp from filtered
> >  '
> >
> > +test_expect_success 'format-patch -o with no leading directories' '
> > +     rm -fr patches &&
> > +     git format-patch -o patches master..side &&
> > +     test $(git rev-list master..side | wc -l) -eq $(ls patches | wc -l)
>
> For test case you write, please use the following pattern:
>
>         git rev-list master..side >list &&
>         test_line_count = $(ls patches | wc -l) list
>
> The first benefit is that we get to take advantage of the
> test_line_count function that's already written for us. The second is
> that when we write tests, we shouldn't put Git commands in the upstream
> of a pipe because if they fail, their return codes will be lost and we
> won't be able to fail the test properly.

thanks. I will ensure, that this follows your
dl/format-patch-doc-test-cleanup topic.

Bert

>
> > +'
> > +
> > +test_expect_success 'format-patch -o with leading existing directories' '
> > +     git format-patch -o patches/side master..side &&
> > +     test $(git rev-list master..side | wc -l) -eq $(ls patches/side | wc -l)
> > +'
> > +
> > +test_expect_failure 'format-patch -o with leading non-existing directories' '
> > +     rm -fr patches &&
> > +     git format-patch -o patches/side master..side
> > +'
>
> As above, I wouldn't really call this a bug in Git. I think we should
> leave this test case off until the next patch.
>
> > +
> >  test_expect_success 'format-patch format.outputDirectory option' '
> >       test_config format.outputDirectory patches &&
> >       rm -fr patches &&
> > --
> > 2.23.0.11.g242cf7f110
> >

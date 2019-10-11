Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0781E1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 20:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfJKUjr (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 16:39:47 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:35442 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbfJKUjr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 16:39:47 -0400
Received: by mail-vs1-f54.google.com with SMTP id s7so7092224vsl.2
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 13:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R98CQHJsw2wqVh2T2b6QbnussWSj8waH37OHbPF1iXQ=;
        b=X87C546NM8GralBiElgoBSAo8OJM4v7yTwFq+kMgo43o63rrh33Jv8ootNIsTREmp8
         8Y4f9MufzOm1Lr1JLSAbbE3L5jkFfWHNomJgdODDeo68sdP/aWgYHf6gmTS83at+9eRC
         wymA1j9b2fFzxvSRBsbgKqZLEZWGZfeC6ZbOBWAqlNpu25TBOtKdHWg9uJ8Xy/GYEvoe
         jc76lbD0609DjOgsKJQUHWkBq3s5XQGpTCfzZ3ilKtlH5o4TQ7EDPIjHnAxWDrwIWigH
         jjtOSD5JJdFb/kms8GtMM+Z+nk3X7R/+0AekLY5/UqrcEEZ4ERVBaVyfLbzjATY6ce3+
         A6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R98CQHJsw2wqVh2T2b6QbnussWSj8waH37OHbPF1iXQ=;
        b=MGo72Ni7DEYX5dpjSVqg3oNoh45bR91KAMLp287b6VgQ2ezxGWBXIwf7XW7QFRoNU5
         yjVxhMD5OwdyxRc4PPLQbZ5ERH0TPiFJrAxF90fmcnhIkzlcItdINR6cvmgxfTw59BSz
         m8ZAOTyjDRsm3IErmh7FGNFITHHB7e1Jjb5aRjXzEJJfv9Nwwn2YAcFrr4SaiSbc6mHT
         GfDMj7+taIbMtfk81JpOUPZWxgQE0vusnCrJ2BgQtLlBqfdAL5G/V3CR2OukKFoC3Y2+
         G4EkFMvGh9Igyem1LE1KLPDKR1By1p3f5PRZp8tpxBF8AaT7I4B8N+RDPPGG7sZyEL/8
         fE6g==
X-Gm-Message-State: APjAAAWBE/g9BZlPSs1tot2bSHCIs0eTmOpVggW7IxunBujuBHc0syys
        Ldf+Au+KgGZHlwNeNMN6msRkH0xcOdJNlV7XQF8=
X-Google-Smtp-Source: APXvYqx8Mt92cvez/XqNDEl8CLulnP0CvSVkvmFVkT5ROTx/KOW3Uxp/3orpzzKhq75YpYj/w3vqB3TtDDCqrHxoYJ8=
X-Received: by 2002:a67:f84d:: with SMTP id b13mr9681748vsp.136.1570826385721;
 Fri, 11 Oct 2019 13:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8sprhgzc.fsf@gitster-ct.c.googlers.com> <CABPp-BE4f5f3HyZu9wOyq599JN-n0EMF08di+2V51uxDMEwuGQ@mail.gmail.com>
 <xmqq4l0fgroj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l0fgroj.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Oct 2019 13:39:32 -0700
Message-ID: <CABPp-BF346QbjCyWP7HSP9Lh7mDRgtwtPC8b4mqNv4znUHoGFw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2019, #03; Fri, 11)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 9:42 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> * en/fast-imexport-nested-tags (2019-10-04) 8 commits
> >>   (merged to 'next' on 2019-10-07 at 3e75779e10)
> >>  + fast-export: handle nested tags
> >>  ...
> >>  + fast-export: fix exporting a tag and nothing else
> >>
> >>  Updates to fast-import/export.
> >>
> >>  Will merge to 'master'.
> >
> > Any chance this will merge down before 2.24.0?  I'd really like to see
> > and use it within filter-repo.
>
> A few general guidelines I use are that a typical topic spends 1
> week in 'next' (a trivial one-liner may be there for much shorter
> time, an involved multi-patch topic that touches the core part of
> the system may have to spend more), that an involved topic that is
> not in 'master' by rc0 would not appear in the next release, and
> that any topic that is not in 'master' by rc1 needs compelling
> reason to be in the next release.  So it is cutting a bit too close
> for this topic, it seems, but we'll see.

:-(

Did I shoot myself in the foot by being quick to jump on Rene's couple
of cosmetic touch-up suggestions he posted over a week after the
series was originally posted?  In other words, if I hadn't stopped you
from merging the series down to next to incorporate those
clean-ups[1], would the story have been different?

[1] https://public-inbox.org/git/CABPp-BHvzyLf=Wwhv45qKdKjiTVwHtsMdfA0hd5Ejf5fmhHyPg@mail.gmail.com/

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA64F20248
	for <e@80x24.org>; Sun, 17 Mar 2019 14:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfCQOCF (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 10:02:05 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53203 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfCQOCF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 10:02:05 -0400
Received: by mail-it1-f195.google.com with SMTP id g17so16697234ita.2
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4iHMfmth9dNLYFtqZrK9r0MjcNA1V1rFLqHwJCw5DdI=;
        b=O1ENkIcAohw92rkbV1bsyvQyDhkuN+20wNKeQEkWuQFYkGD3CCh6mlz773inOKJmYa
         xEUUwjeDfN8BHlweNWxpEvmQrttsHStzP3rtwgV2pk8xwiaeuL9N23g2CjEqDVHJndLg
         yyhXilwkXOLvHgiyhSIvIoer36Ey3xWA1ICfakiMZKYlAYJ0RqcOAh0GyUVpnrj0byXV
         Z5dUIctVvlUUQyWXB9bQ8OUXFGzYY8VuLllL+j5qgcIGL9wQ+8BS39L5fJYb45na51ic
         SgV0MBPF9zURIqGyNWK46mBrHFZ/bTMGyjo0Yz+Kt+SHJekRNLHzZjyCdFuHpquc0ALr
         VSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4iHMfmth9dNLYFtqZrK9r0MjcNA1V1rFLqHwJCw5DdI=;
        b=bMVQ/pzFLAyrtXIKlbwhHn5zEfQMTOJMGRhAwZnvETq1ZuDDfZptAcD9oCrWGZ2YcR
         vqpfQ1ADbh1N9k5UGqOmyU81ofAK3d/BByVVXrHYq/yYyQyBT8XhbbI6UPA/GgScrwTq
         zu853Sh6wPdwN5rpuWCrgADz7hn2x1eVlSplx2lDi09IWNprccgz/oNXh6XST7Uu6S9B
         2pIt9/IoJFRmQOndsScKVm+cEtf68od/55JWHv5qXq02fvi1+aCXcI984GjT/ZBYZLY4
         xNCMZxz4fi8GR2jMYmoxxNge3hkNheUXkELtKIJYwCS3gmWwi10rOnKUdqjLv4t94Omd
         s7HA==
X-Gm-Message-State: APjAAAWW3x9KNoFKHY1aga4ae9qOW/ifyPZRxccYSB0t7s+RXszW6Dfz
        FB0LYqXgaOy9wgwUxBVyOKCXaHRB/UxkeXA2zNs=
X-Google-Smtp-Source: APXvYqz7R7IdErXAVQ36PkNicAjEvS9ZlOC8Mouw/aLkaiJT7Oz1hO0I9mqeN1N0b8N+DIGu9wng0KOPBqrtNSV+jcA=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr6860448ita.10.1552831324131;
 Sun, 17 Mar 2019 07:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com>
 <87multaaac.fsf@evledraar.gmail.com>
In-Reply-To: <87multaaac.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 17 Mar 2019 21:01:38 +0700
Message-ID: <CACsJy8C3P93896fP8BStmYd1WMNukYV6u8gB0zgC3rKLqxgzyQ@mail.gmail.com>
Subject: Re: [PATCH] git-diff.txt: prefer not using <commit>..<commit>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 17, 2019 at 8:41 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sun, Mar 17 2019, Denton Liu wrote:
>
> > The documentation used to consider
> >
> >       git diff <commit> <commit>
> >
> > and
> >
> >       git diff <commit>..<commit>
> >
> > to be equal counterparts. However, rev-list-ish commands also use the
> > <commit>..<commit> notation, but in a logically conflicting manner whic=
h
> > was confusing for some users (including me!).
> >
> > Deprecating the notation entirely is not really an option because it
> > would be an arduous process without much end-value. In addition, there
> > are some valid use-cases that we don't want to break.
> >
> > Document the preference of the first form so that future confusion can
> > be minimised.
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >
> > Thanks all on your feedback on the discussion thread[1]! I opted for
> > just the documentation-only route so we don't break any valid use-cases=
.
> >
> > [1]: https://public-inbox.org/git/20190311093751.GA31092@archbookpro.lo=
caldomain/
> >
> >  Documentation/git-diff.txt | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> > index 72179d993c..10c7a2220c 100644
> > --- a/Documentation/git-diff.txt
> > +++ b/Documentation/git-diff.txt
> > @@ -63,7 +63,11 @@ two blob objects, or changes between two files on di=
sk.
> >
> >  'git diff' [<options>] <commit>..<commit> [--] [<path>...]::
> >
> > -     This is synonymous to the previous form.  If <commit> on
> > +     This is synonymous to the previous form.  However,
> > +     users should prefer the previous form over this form
> > +     as this form may be more confusing due to the same
> > +     notation having a logically conflicting meaning in
> > +     linkgit:git-rev-list[1]-ish commands.  If <commit> on
> >       one side is omitted, it will have the same effect as
> >       using HEAD instead.
>
> I think we're better off just consistently recommending "A..B" instead
> of "A B" and "fixing" any occurrence of the latter to the
> former. I.e. not taking this patch & going in the other direction.
>
> As noted in the thread you linked we'll always need ".." when one side
> is "HEAD" implicitly, and that's a really common case.

You could just type " @" instead of "..". And that one is easier to explain=
.

> So as confusing as the whole ".." v.s. "..." is in diff v.s. log I think
> we're worse off with "A B", since we'll *still* need to document the
> likes of "A.." and how that differs from log "A.." or "A...".
>
> So sometimes using the whitespace form for two revs and then the ".."
> when we just have one side makes things more confusing, not less. The
> reader will be left having to juggle more complexity in their head, not
> less.
--=20
Duy

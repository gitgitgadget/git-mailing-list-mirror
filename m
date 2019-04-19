Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58AE420248
	for <e@80x24.org>; Fri, 19 Apr 2019 18:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfDSS10 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 14:27:26 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55243 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfDSS1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 14:27:25 -0400
Received: by mail-it1-f195.google.com with SMTP id a190so9471566ite.4
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 11:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gaITZsZdCSs8s60pOZLLviwZkid6hQlAJppYHzU7YyQ=;
        b=gWDkMrL+AMCO5kGclMQciHTXJhKs1a2RZYFCxEHZ/9u9tS025f+e7v22lCYTgAZ0LD
         sQAb7I6vSCHZ/rIW7rE6DtKYXM/5KFvij4L8j/ZI9niVOHyAWQs9kVH81ShGYLYRP+Px
         qZY62hCoO7IBQJwyJyR/a5/cUS874ENlkD7NIaau5aBEeJYHbH64FCR01wiyKpahxcyg
         wXmQCbUTRF69q8pqaHGlQC5stMogrZPDaH6xqvc7bz9ensTW8tYeQRUSkPh6kNsTfCT8
         QHirMyHxDMeD32Fckyysxc+e0/55rIJ3H6NLAOi7cTqpf8hNb6w4zTDeJz6Ly5Ov9BqB
         64tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gaITZsZdCSs8s60pOZLLviwZkid6hQlAJppYHzU7YyQ=;
        b=tF2iWcod947duT/NeMi0CVlt+WAqJBomoKxnbuj8s5iY4HWdQWsslYxqr+fxY9i4tq
         UHt6iO4+vzdf6WkkBsc84LvoHBYOTQsE9+2LIoFHyqLfFbeo963NewQm6av79TAl0yLV
         I0K+w8gUilZ3XIG7B5rSbOWtNdvC4MC6ScqUhRRfwh6YNDvbQRR72qxW9zfgIH11/Px5
         0c3V8amhoIfC7YAh4Uu6AdtIJQZecdo9zpiiqdnsA+Lld+/q6O78cZE/X3f6ZMWl7xmZ
         UrYq/zg7VmoWIRmKWg1XYiKPttvqvfh2GAR6gtZVyfsuwzaJvqDo+vLhkZLZJAAzonIP
         lZxg==
X-Gm-Message-State: APjAAAXFWN2WLDG/zPLn5nBEH/NVWQxY1HFBVFFYDs27N/7oNegIdaQj
        5FLlCpuSHbUFGwRD2tzzn1/XBQFxXMEdHQxQJY5Xgw==
X-Google-Smtp-Source: APXvYqwSwLFoAGelwEr2kIy3Df5vvdknrvQGm9ZDaCGpwVmw5pqsmqVph+TVHDqjaSN3emYcLYEjQgaIu8mHo9ryWDU=
X-Received: by 2002:a24:4d8a:: with SMTP id l132mr2068498itb.70.1555665531925;
 Fri, 19 Apr 2019 02:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.178.git.gitgitgadget@gmail.com> <a7f75cefb682546862be4dd8b48f91c4034c5d5a.1554901006.git.gitgitgadget@gmail.com>
 <20190410162029.GA30818@sigill.intra.peff.net> <xmqq7ec00z9t.fsf@gitster-ct.c.googlers.com>
 <20190418211408.GA18011@sigill.intra.peff.net> <20190418212405.GA18623@sigill.intra.peff.net>
In-Reply-To: <20190418212405.GA18623@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 19 Apr 2019 16:18:25 +0700
Message-ID: <CACsJy8BHwM5dUqa-FOjr3smxJT6kW4z7vLUJvsHuhjxwUjvkBw@mail.gmail.com>
Subject: Re: [PATCH 4/3] untracked-cache: use FLEX_ALLOC to create internal structs
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 19, 2019 at 4:24 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Apr 18, 2019 at 05:14:08PM -0400, Jeff King wrote:
>
> > Just so we don't forget about it, I wrote this fix up as a patch. And in
> > fact it led to a few other cleanups. I think the first one is definitely
> > worth doing now, even if there are other similar cases lurking in the
> > rest of the index code.
> >
> > The other two are optional, though I think they are worth it (and not
> > too hard to verify that they are doing the right thing).
> >
> > These are on top of js/untracked-cache-allocfix (though they could
> > easily be ported to a separate topic if we want).
> >
> >   [1/3]: untracked-cache: be defensive about missing NULs in index
> >   [2/3]: untracked-cache: simplify parsing by dropping "next"
> >   [3/3]: untracked-cache: simplify parsing by dropping "len"
>
> I also wondered if we could just accept the cost of calloc() here and
> use FLEX_ALLOC to simplify things. That resulted in the patch below, but
> I didn't include it with the initial 3, because I think it's too
> subtle/gross for my tastes.

It's probably ok. If I remember correctly, reading UNTR extension (on
a huge repo) took the longest time after Ben added support for reading
the index with multiple threads. So performance is a concern, but I
don't think calloc() would be the problem. malloc() itself without the
memory pool could probably slow down more when we have lots and lots
of directories.

> -- >8 --
> Subject: untracked-cache: use FLEX_ALLOC to create internal structs
>
> The untracked_cache_dir struct has a FLEX_ARRAY in it. Let's use
> FLEX_ALLOC_MEM to allocate it, which saves us having to compute the
> length ourselves.
>
> In theory this could be slightly slower, since the FLEX_ALLOC macros use
> calloc (and we just memcpy over most of the contents anyway). But in
> practice this distinction is not generally measurable.
>
> Note that because we then fill in the pre-flex elements of the struct
> using a memcpy, we need to take care to use the exact size of that
> space and _not_ "sizeof(ud)", since the latter may include padding (or
> even an extra byte on systems where FLEX_ARRAY is 1).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> If we wanted to go this route, I think it would make sense to provide a
> FLEX_ALLOC macro that takes a "template" set of bytes as a ptr/len pair,
> and writes it before we fill in the flex portion.
>
> Then we could do something like:
>
>   FLEX_ALLOC_COPY(untracked, &ud, sizeof(ud), name, data, eos - data);
>
> If this is the only such case, it's probably not worth it (I didn't
> really look around for more, though).
>
>  dir.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 60438b2cdc..7cd4eec198 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2757,9 +2757,9 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
>         if (!eos || eos == end)
>                 return -1;
>
> -       *untracked_ = untracked = xmalloc(st_add3(sizeof(*untracked), eos - data, 1));
> -       memcpy(untracked, &ud, sizeof(ud));
> -       memcpy(untracked->name, data, eos - data + 1);
> +       FLEX_ALLOC_MEM(untracked, name, data, eos - data);
> +       memcpy(untracked, &ud, offsetof(struct untracked_cache_dir, name));
> +       *untracked_ = untracked;
>         data = eos + 1;
>
>         for (i = 0; i < untracked->untracked_nr; i++) {
> --
> 2.21.0.1092.g8b0302e9c4
>


-- 
Duy

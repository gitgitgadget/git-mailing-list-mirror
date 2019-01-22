Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5EF1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 09:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfAVJfN (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 04:35:13 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55321 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfAVJfM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 04:35:12 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so20380500ith.5
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 01:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YigLcBOGpY8qc9toGYjuARISpsXUShRCVfwLnyNuzXc=;
        b=jj04UrX7kq/SeKLCf5x8XJMsgyiGoR6h6prxBXw9iMmWfH4S8lkT4v0E2sdjgiZas3
         jE8nEa+rpPgnflLdfm1TZmSP8Ozlqa8bbbU5ep/lHEFiIzofsPHaVK8/YMP2zuTvXsbn
         NudYQrfW8ruvaRDXXhdiPK5Y3EmqPGvgQoDTJh2CGma9fp18q/0OZofZo50OZUpaNsqB
         HiStbhhQxYE/aeaRrMfMjq6fTgDJpHD/OpEnJ8UfBekEROSGETKI83c0hQpeewAmEQ03
         AD9O9zZGXpgHbsXkvNBQFplnyUV9+rAQwoE+juuy41Io2kKLm7ZeSVvou4cJokVjOFAP
         ay2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YigLcBOGpY8qc9toGYjuARISpsXUShRCVfwLnyNuzXc=;
        b=VVgT3s1XchJKrar6uhc7Cvv82DDGmNN0PPRrhAQSBGoepJuYKZf9WbOOJnxqVkGHME
         7JTQIdO+n6PQQQKsIL9O4wWzYuQQjk+Fn2IuWU1xp6fKqvKoXEOKyqEyY+7zFRTwRb7P
         egTgOEeZEf09LYHhYFc1VBeLt8DEwv2lrNPLlMrAKnqSAHKSAIXYCYrRftAJmrfuA6kM
         afpYPAykrHsT8vYU9f6+blKTEvFqdVW9HeAR1YzAATz8ZepAH0LOA8RFYqEBFOGKRSvG
         8MCLkb/L8ZJ+mGkjg/rVu81/CwQiRioWio22jR+4iS8+EN6ZnywslewWcMrdcQMGVbLA
         Chpw==
X-Gm-Message-State: AJcUukdHDrdftEooS4IIxcj6WF/d+EYsW2fWr0Z6ZfKZ51THAljk84Bw
        beaviklv7rzHKHe2+nTqB7kaZB/NVH7zw3GawaE=
X-Google-Smtp-Source: AHgI3IYYo3JBfGkgjIaqlHQHe4SJPuTmNop4GfX/Lo6D2QHcSbWcil0oINpvUjWgI2s35KgCp3AHK3WWS8jhXKFaw6o=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr1700886itk.70.1548149711459;
 Tue, 22 Jan 2019 01:35:11 -0800 (PST)
MIME-Version: 1.0
References: <CAK3b1G+88a=xfO=6wfRi1SMy3xtca2NcFyxuBLKwSifb_L9xwA@mail.gmail.com>
 <20190117160752.GA29375@sigill.intra.peff.net> <CAK3b1GJPZ5X3uEP1a-NF9PZkE0tTKVLda5hM32jExVz_OD2E=g@mail.gmail.com>
 <20190118165800.GA9956@sigill.intra.peff.net> <20190118213458.GB28808@sigill.intra.peff.net>
In-Reply-To: <20190118213458.GB28808@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 22 Jan 2019 16:34:45 +0700
Message-ID: <CACsJy8A2PVY_f7mSLwraroUEtSy8ZgSksAyqqiHgm+HXFC2=uw@mail.gmail.com>
Subject: Re: [PATCH] attr: do not mark queried macros as unset
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?S=C3=A9rgio_Peixoto?= <sergio.peixoto@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 19, 2019 at 4:35 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jan 18, 2019 at 11:58:01AM -0500, Jeff King wrote:
>
> > Now, on to the actual bug. The simplest reproduction is:
> >
> >   (echo "[attr]foo bar"; echo "* foo") >.gitattributes
> >   git check-attr foo file
>
> Actually, even simpler is to just "binary", which is pre-defined as a
> macro. :)
>
> > which should report "foo" as set. This bisects to 60a12722ac (attr:
> > remove maybe-real, maybe-macro from git_attr, 2017-01-27), and it seems
> > like an unintentional regression there. I haven't yet poked into that
> > commit to see what the fix will look like.
>
> So here's the fix I came up with. +cc Duy, as this is really tangled
> with his older 06a604e670.
>
> -- >8 --
> Subject: [PATCH] attr: do not mark queried macros as unset
>
> Since 60a12722ac (attr: remove maybe-real, maybe-macro from git_attr,
> 2017-01-27), we will always mark an attribute macro (e.g., "binary")
> that is specifically queried for as "unspecified", even though listing
> _all_ attributes would display it at set. E.g.:
>
>   $ echo "* binary" >.gitattributes
>
>   $ git check-attr -a file
>   file: binary: set
>   file: diff: unset
>   file: merge: unset
>   file: text: unset
>
>   $ git check-attr binary file
>   file: binary: unspecified
>
> The problem stems from an incorrect conversion of the optimization from
> 06a604e670 (attr: avoid heavy work when we know the specified attr is
> not defined, 2014-12-28). There we tried in collect_some_attrs() to
> avoid even looking at the attr_stack when the user has asked for "foo"
> and we know that "foo" did not ever appear in any .gitattributes file.
>
> It used a flag "maybe_real" in each attribute struct, where "real" meant
> that the attribute appeared in an actual file (we have to make this
> distinction because we also create an attribute struct for any names
> that are being queried). But as explained in that commit message, the
> meaning of "real" was tangled with some special cases around macros.
>
> When 06a604e670 later refactored the macro code, it dropped maybe_real

60a12722ac or 06a604e670? I'm guessing the former.

> entirely. This missed the fact that "maybe_real" could be unset for two
> reasons: because of a macro, or because it was never found during
> parsing. This had two results:
>
>   - the optimization in collect_some_attrs() ceased doing anything
>     meaningful, since it no longer kept track of "was it found during
>     parsing"
>
>   - worse, it actually kicked in when the caller _did_ ask about a macro
>     by name, causing us to mark it as unspecified
>
> It should be possible to salvage this optimization, but let's start with
> just removing the remnants. It hasn't been doing anything (except
> creating bugs) since 60a12722ac, and nobody seems to have noticed the
> performance regression. It's more important to fix the correctness
> problem clearly first.
>
> I've added two tests here. The second one actually shows off the bug.
> The test of "check-attr -a" is not strictly necessary, but we currently
> do not test attribute macros much, and the builtin "binary" not at all.
> So this increases our general test coverage, as well as making sure we
> didn't mess up this related case.
>
> Signed-off-by: Jeff King <peff@peff.net>

Reviewed-by: me.

> ---
>  attr.c                | 16 +---------------
>  t/t0003-attributes.sh | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index eaece6658d..57ced792f8 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -1092,7 +1092,7 @@ static void collect_some_attrs(const struct index_state *istate,
>                                const char *path,
>                                struct attr_check *check)
>  {
> -       int i, pathlen, rem, dirlen;
> +       int pathlen, rem, dirlen;
>         const char *cp, *last_slash = NULL;
>         int basename_offset;
>
> @@ -1113,20 +1113,6 @@ static void collect_some_attrs(const struct index_state *istate,
>         all_attrs_init(&g_attr_hashmap, check);
>         determine_macros(check->all_attrs, check->stack);
>
> -       if (check->nr) {
> -               rem = 0;
> -               for (i = 0; i < check->nr; i++) {
> -                       int n = check->items[i].attr->attr_nr;
> -                       struct all_attrs_item *item = &check->all_attrs[n];
> -                       if (item->macro) {
> -                               item->value = ATTR__UNSET;
> -                               rem++;
> -                       }
> -               }
> -               if (rem == check->nr)
> -                       return;
> -       }
> -
>         rem = check->all_attrs_nr;
>         fill(path, pathlen, basename_offset, check->stack, check->all_attrs, rem);
>  }
> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index 22499bce5f..71e63d8b50 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -322,4 +322,24 @@ test_expect_success 'bare repository: test info/attributes' '
>         )
>  '
>
> +test_expect_success 'binary macro expanded by -a' '
> +       echo "file binary" >.gitattributes &&
> +       cat >expect <<-\EOF &&
> +       file: binary: set
> +       file: diff: unset
> +       file: merge: unset
> +       file: text: unset
> +       EOF
> +       git check-attr -a file >actual &&
> +       test_cmp expect actual
> +'
> +
> +
> +test_expect_success 'query binary macro directly' '
> +       echo "file binary" >.gitattributes &&
> +       echo file: binary: set >expect &&
> +       git check-attr binary file >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.20.1.691.ge06e0a624f
>


-- 
Duy

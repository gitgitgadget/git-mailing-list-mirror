Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A6EC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 15:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A7361350
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 15:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhFNPGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 11:06:33 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:36499 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbhFNPGb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 11:06:31 -0400
Received: by mail-oi1-f170.google.com with SMTP id r16so14267558oiw.3
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUdJd9SDTRZ47kt8IOUwreBiynK2TAGxDebhJqzzsVw=;
        b=l6Iu7EXTz4LopVd1M8jIQndHORNUkMA2lQqe+K2IIv8/n92CfFhY3DmMHuENCruLDb
         X43v1zmir+U3FBWpiOwy7ILJ9r2adFNlF6tgTTtxxW0ng6ImB49XRA8lSgPqgYpAAg4i
         hHlOwHgZo/iqmiNMcs7uqroz17Zl3w/P9ALpGYOsW9tx6sIeJQZV0UxNFGJOPWHUE6hH
         C7FGFqZe3xfhK1XZGlg3J8PpxC/7JNqsv56llgJxhyXRDiLwtpvbYFTEacHevoF81IrJ
         OqETXBY5q5bW+TfIQk2iQKrPtND+nuna5H51h7ZNwXDZjbf4aXJT8PyLUCcm8nwiq33k
         umew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUdJd9SDTRZ47kt8IOUwreBiynK2TAGxDebhJqzzsVw=;
        b=CIQUmaR/Onz0VxRWWXgVazs/UOuyuw4jfXyg3dzPWyZCn7VKvrYEfEYp8C3hR28IzB
         ucM9Ebu0pUftV+O9LfWWQRynvJQ/dDioYTLYYDNMX2aZgo/hhegnMTp/qC1ttnyE0JI8
         ulEwXkIyWvhdFG9LBmKhADXSY72gS1V7cQXj8H+chTkm8Ka2uOsIdJUXkOpD+1NUpUEn
         AhuQ74bfH5feI28as+5LGdRaSe4P1lL7R5TkmYyZRDcbVFxAkr5CF9mgzEf2UKnpyHZB
         hVipTuFlV+mpuXKQZwFpO8uGl+fEtybi4VlyHXgGuceG/5lWVD9JW+65AGfR57ROsHyb
         yf+g==
X-Gm-Message-State: AOAM533TTrHBxV8ZbK2i20Y0t5Nd1x7wJd86GjpcBmkzyVH2Q9ftbAfz
        /CYqQF1SevKmoW5rlYwaRYTTvW3nphp3VFBL4Gw=
X-Google-Smtp-Source: ABdhPJwwx1RhJVuVHR6B8IVjrWryrnEyEJKKTjOKaTYGRTAm4o2mY/W88BjGtQgZVDpACAZJx/nY/ltwJckRulJADSE=
X-Received: by 2002:aca:4e92:: with SMTP id c140mr21783202oib.39.1623683008381;
 Mon, 14 Jun 2021 08:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210613045949.255090-1-felipe.contreras@gmail.com> <20210613045949.255090-4-felipe.contreras@gmail.com>
In-Reply-To: <20210613045949.255090-4-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Jun 2021 08:03:17 -0700
Message-ID: <CABPp-BFEHcX0CRgbYr4Y_hqiAzM=YUp-wzdtwRdOxcZ-jPWyow@mail.gmail.com>
Subject: Re: [PATCH 3/3] pull: trivial whitespace style fix
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 12, 2021 at 9:59 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Two spaces unaligned to anything is not part of the coding-style. A
> single tab is.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/pull.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 80e2f55cbc..3e13f81084 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -126,9 +126,9 @@ static struct option pull_options[] = {
>         /* Options passed to git-merge or git-rebase */
>         OPT_GROUP(N_("Options related to merging")),
>         OPT_CALLBACK_F('r', "rebase", &opt_rebase,
> -         "(false|true|merges|preserve|interactive)",
> -         N_("incorporate changes by rebasing rather than merging"),
> -         PARSE_OPT_OPTARG, parse_opt_rebase),
> +               "(false|true|merges|preserve|interactive)",
> +               N_("incorporate changes by rebasing rather than merging"),
> +               PARSE_OPT_OPTARG, parse_opt_rebase),
>         OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
>                 N_("do not show a diffstat at the end of the merge"),
>                 PARSE_OPT_NOARG | PARSE_OPT_NONEG),
> --
> 2.32.0

Not only does this change bring this code in alignment with the coding
style, it also makes it more consistent with the other code around it.
None of the other options parsing in this file used a
tab-and-two-space indent, so it's curious why this one was added this
way.  Anyway, thanks for fixing.

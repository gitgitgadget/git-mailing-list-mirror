Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155BF1F597
	for <e@80x24.org>; Sun, 22 Jul 2018 04:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeGVFrX (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 01:47:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55542 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbeGVFrW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 01:47:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so12856051wmc.5
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 21:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zq1Q3L/OjE6pzPsSgOx4mpTs94SGOXmXXtlXFaVU9ug=;
        b=YvAmmx26syORBad5dKCYE6M8ygykGik5fukNqE6xRG2pwLX2ha/Sh/NomY9QScgOb4
         xr9efG8KJHS73BQGU/au3+IZegghiuQT19jGTu7esN7a7pVmE+UCG55GYN/xhwcYd0vd
         NAPFo6v6FNwy6FxnoCjjJeJAp8vjOq85aEpfn0t5xD6ZEJiyScjm5sXDoqMZi7l+P0kZ
         wWiPJhMQfpgPD6ad9RZbnQziBGZjSHRsCcVCkhNo3VNCghI8HJ1l4oUjkT3GPrKREgUk
         mxNuo0VJvS9VBVkRbg/jQE5pYVWlFDTGXEFRP32CocY/mNQZzcNCX68Ta9tz/ORoLhvw
         5Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zq1Q3L/OjE6pzPsSgOx4mpTs94SGOXmXXtlXFaVU9ug=;
        b=M9oDadS/o+DkZKmHlSnn3AoCawofiLLPalhKtyZGFbbPGZv0s3BxEjjySd+ptoVjS+
         RaEcrK8mspPIYS+Zcjv1K9WMQrvVQ+h8c/6wC+eg/TxeuWqsbwDctW7aUxX/a7xnP9ak
         /lA8VtHqxyrreMnSrpbdWhRdXL9IUxQtX9XZ7Nny0h+jsFPf2775zFh66uxvapUWS3H3
         +N6Cd/ORTR/W+oiIvm88QFvWewBACtuXmCOjSvR3xScP1aH1YAkcKXaYKNALNP9lnmkP
         F4Y8yqKbYvw144rTjf84A0eESjdNpF2w0vDWP+67m85IH5zi99O5lsj+MlPcsLycHRmw
         EF1Q==
X-Gm-Message-State: AOUpUlEI6KRPBz79PGgHBh6oMor82MOXJrcV0ObSLA3T7qdJPWORXpQ9
        nxXn6ROKDYXTlPkcciVstIz0nesAEH1gcDoIxLA=
X-Google-Smtp-Source: AAOMgpcL386g5Fg6H6ziapIJ2PqzUvdP75qUJs5F7TirqcZTShKQzsOLqdVzAieS+HMFld29Cxl8DYd9mwQThDfLuX4=
X-Received: by 2002:a1c:3b05:: with SMTP id i5-v6mr4986535wma.57.1532235124061;
 Sat, 21 Jul 2018 21:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180721124952.26347-1-dev+git@drbeat.li>
In-Reply-To: <20180721124952.26347-1-dev+git@drbeat.li>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Sun, 22 Jul 2018 10:36:53 +0545
Message-ID: <CAOZc8M_yXok6sPWw5CeptKTDsems4HAMWzNyRDTj9dCNivQ0SA@mail.gmail.com>
Subject: Re: [PATCH] fixup! builtin/rebase: support running "git rebase <upstream>"
To:     dev+git@drbeat.li
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Jul 21, 2018 at 6:36 PM Beat Bolli <dev+git@drbeat.li> wrote:
>
> The macro GIT_PATH_FUNC expands to a function definition that ends with
> a closing brace. The extra semicolon produces a warning when compiling
> with -pedantic.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>
> Junio, this applies on top of pk/rebase-in-c.
>
> Thanks, Beat
>
>  builtin/rebase.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index e38ea80874..6aaae2436f 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -14,8 +14,8 @@
>  #include "refs.h"
>  #include "quote.h"
>
> -static GIT_PATH_FUNC(apply_dir, "rebase-apply");
> -static GIT_PATH_FUNC(merge_dir, "rebase-merge");
> +static GIT_PATH_FUNC(apply_dir, "rebase-apply")
> +static GIT_PATH_FUNC(merge_dir, "rebase-merge")
>

First of all, I apologize for not replying earlier to your review.
I have already fixed this macro in my local repository.

The new iteration of my patches was being held due to fixup of
`detach_head_to()` and I will soon submit a new iteration of patch
within a day or two.
Thank you for pointing this out.

Cheers,
Pratik Karki

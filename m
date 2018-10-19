Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CA951F453
	for <e@80x24.org>; Fri, 19 Oct 2018 17:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeJTCFl (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 22:05:41 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:43831 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbeJTCFl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 22:05:41 -0400
Received: by mail-vs1-f41.google.com with SMTP id w85so25806204vsa.10
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSAZV86HSJuq1wwP2ZMY858f0L9gYMP4Djol6TL261E=;
        b=Xo7NzW9Pevk2wtC6MVpIl/EHZfbfDFXxQP7ozf5idVj4hect74WT8IIpfLKw3WIOyP
         7MK6enviydRYxtdyUEXs+qvCO0Yn0an5dw+CZQunhGSzN0gXu7Gh7IewdNUyLFdziCKy
         keDYobwcdtN5/sca6mUp/fpQ1xtvKhJZEneaHdSiH9oMg/H30gGUcoCJnuQSAgu4fLGO
         tDiAd8GI/7w1FW3Q6aC0v5y1tGOpjLTgFbwRVJqgyqgdPEwVsDgmG/Kz/WL1Tw0X23s/
         L/cScyeUHY51n1XC4SYjTkv46OfsM7+F47M4k6ep7PHPR0ZpHU9BCYwUljCiNJhK3k8F
         YJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSAZV86HSJuq1wwP2ZMY858f0L9gYMP4Djol6TL261E=;
        b=lmYRUtakHh9hFWWyoxuO3xOwXnsmr02FOg0QoQCoGVaXYjnMBOu3GXGfSiSG4fhs5M
         2MQLJvAzmlMiJV2Moh8xA8R6IonsR9L/UvbwdxfcuMk4f5J2ZqtY5DeaTbKqM1nLumLj
         qmxyAj7B0vfu1h0KgmMX+s+mDhoQ2DaDaeWiX2qoMdcHqTozb7eIavUacCloJN9zvFs3
         RnJIOklrv1Dmz5UCb10lHaxWEwaDVJ88TNkkjZXgCmE1G5WvaIkcCBcaSqNkBmgmwm/w
         0gGkGpyEIOrdBrc8dOara2Lu/LEBYeAod+lD/0a+8Ot+nFCRpRGDUtZ5DelTc8mZJJ03
         CPDQ==
X-Gm-Message-State: ABuFfogAPIySsm7TGGrfaWnHA66tFrj26XZ36HtXxsuefaELYZ/5vo20
        u9V+QAskSPZEgnITzI0RDVxQZYFOKXBzUJFeGzZPMw==
X-Google-Smtp-Source: ACcGV63sBYBIrIw0+VkJBtYSidh9u0IN/YpvM10GHJvjNWKJxUfsy9e1iaT8T4bMm8X0xJPrUIQKE4Sv8sAtzAXGXdM=
X-Received: by 2002:a67:3e81:: with SMTP id a1mr14758479vsi.136.1539971912055;
 Fri, 19 Oct 2018 10:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181019171827.GA21091@sigill.intra.peff.net>
In-Reply-To: <20181019171827.GA21091@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 19 Oct 2018 10:58:19 -0700
Message-ID: <CABPp-BHobf8wbBsXF97scNQCzkxQukziODRXq6JOOWq61cAd9g@mail.gmail.com>
Subject: Re: unused parameters in merge-recursive.c
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, Oct 19, 2018 at 10:18 AM Jeff King <peff@peff.net> wrote:
>
> Hi Elijah,
>
> Playing with -Wunused-parameters, I notice there are several functions
> with unused parameters in merge-recursive.c. The patch below drops them
> all. We know they're not being used, so it can't make anything _worse_,
> but this is a good opportunity to confirm that they don't represent some
> latent bug.
>
> In most cases I've been trying to determine the "bug versus cruft" thing
> myself, but I fear that merge-recursive exceeds my abilities here. ;)

These ones all look like cruft to me.  I dug through them and tried
looking through history and old submissions for my guesses and how
they ended up here; details below.

> ---
>  merge-recursive.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index c0fb83d285..f6d634c3a2 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1369,8 +1369,7 @@ static int merge_mode_and_contents(struct merge_options *o,
>
>  static int handle_rename_via_dir(struct merge_options *o,
>                                  struct diff_filepair *pair,
> -                                const char *rename_branch,
> -                                const char *other_branch)
> +                                const char *rename_branch)

Given the similarity in function signature to handle_rename_delete(),
it's possible I copied the function and then started editing.  Whether
I was lazily doing that, or if I really added that parameter because I
thought I was going to add an informational message to the user that
used it, or something else, I don't know.  But I agree, it's just not
needed and could be added back later if someone did find a use for it.

> @@ -2071,8 +2070,7 @@ static void handle_directory_level_conflicts(struct merge_options *o,
> -static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
> -                                            struct tree *tree)
> +static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs)

Yeah, nuke it.  I don't remember full details here (it's been over a
year), but my best guess is that I started with (at least part of the)
code for handle_directory_level_conflicts() inside of
get_directory_renames() and then broke it out into a separate function
when it got bigger, but forgot to remove the extra argument.

>  {
>         struct hashmap *dir_renames;
>         struct hashmap_iter iter;
> @@ -2318,8 +2316,7 @@ static void apply_directory_rename_modifications(struct merge_options *o,
>                                                  struct tree *o_tree,
>                                                  struct tree *a_tree,
>                                                  struct tree *b_tree,
> -                                                struct string_list *entries,
> -                                                int *clean)
> +                                                struct string_list *entries)

Yeah, there's several other functions with such a flag; I probably
added it thinking this function would need it too and then just forgot
to remove it when it turned out to not be necessary.


The remaining chunks in the patch you emailed are just modifying
callers to not pass the extra non-unnecessary args, so they're all
good.

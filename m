Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA602042F
	for <e@80x24.org>; Wed, 16 Nov 2016 13:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753215AbcKPNLh (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 08:11:37 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:32842 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbcKPNLg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 08:11:36 -0500
Received: by mail-yw0-f193.google.com with SMTP id s68so14761282ywg.0
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 05:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=znqnWT5Y+tDLkSkQ4qNJQKFGVF1d7tQBN3ZXVv4i6ZA=;
        b=XGnCeaDCVOSu5TzmgsWX3YwA/NTD3FIaYSFtgOXnfLr/EYF05AHoBanm3SrrpEw7hc
         T1hwGpeDAzeL1pvVDPPPVaKVc7W3yXCvfrHkhq9FVqxn97o9ZbNhF8yhpxLNJ+bIjrGJ
         fO38vNN3GS7z8zVXPcBccw+yutklZEFQJ6z++ff3QhE3u08p/E77zY78FhCZNX9j7XDX
         8klIdV6lPbUVcSYgJFmgXJXngU75zjvx8ipR8JHSk1ggCNGLDjg7T/EThC/JlKvPk/PT
         G/iBY1aRkSTbea8+WuQx+EgkfFA7SeqAaiNvqphRfIHFkeadNEna9gpED9WXHYv7nsH1
         cJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=znqnWT5Y+tDLkSkQ4qNJQKFGVF1d7tQBN3ZXVv4i6ZA=;
        b=FSVwNvpknN+bQuLFin06nnuulLf6RqK4ZFDoZULWR+kGDCXWE7LZEIIbm6Xk5BRq7a
         4L5RIVxRCobOAdrRhv20XppIqXLpvQtywIA9Xz3hfesMdDzcpn9oPVoU5TWeAnkSTgaP
         pgYPcHOjZ1tOvOSWKLxxiiQJIyhUwmjUFKyx9kHKrGQPG+TlFF2XNjUCw2AhjfWhZ3a8
         l3LfZyLXXZx0BO9dn2eSwDVg742nNyhA2MQchBX1S46OKufYH0EbZO/z5Xenjy66ZuTw
         DjXo7jaWkCaaDaL5Ar7LCkfgp2cWR4Ebxpd1TR4gBOPk5stg2gVrz6QgMDeeFIMvbQpA
         iOwA==
X-Gm-Message-State: ABUngvejGaT/Lk+Udgu6kYef+13RP50Vk/wgcy16oEqBgtrvQAFU06c9CdgGwdiYb7fWOv/CAbZHly1niniR0A==
X-Received: by 10.13.219.205 with SMTP id d196mr2341000ywe.118.1479301895257;
 Wed, 16 Nov 2016 05:11:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.211.9 with HTTP; Wed, 16 Nov 2016 05:11:04 -0800 (PST)
In-Reply-To: <20161116130533.GA5393@ash>
References: <20161112022337.13317-1-pclouds@gmail.com> <xmqqeg2gyv1v.fsf@gitster.mtv.corp.google.com>
 <xmqqa8d4yts7.fsf@gitster.mtv.corp.google.com> <20161116130533.GA5393@ash>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 16 Nov 2016 20:11:04 +0700
Message-ID: <CACsJy8DOT_4N_48UaoYK61G_8JUaXbEs7N=n24CH2q1GN=++5g@mail.gmail.com>
Subject: Re: [PATCH 00/11] git worktree (re)move
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2016 at 8:05 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> diff --git a/worktree.c b/worktree.c
> index f7869f8..fe92d6f 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -173,6 +173,13 @@ static void mark_current_worktree(struct worktree **worktrees)
>         free(git_dir);
>  }
>
> +static int compare_worktree(const void *a_, const void *b_)
> +{
> +       const struct worktree *const *a = a_;
> +       const struct worktree *const *b = b_;
> +       return fspathcmp((*a)->path, (*b)->path);
> +}
> +
>  struct worktree **get_worktrees(void)
>  {
>         struct worktree **list = NULL;
> @@ -205,6 +212,11 @@ struct worktree **get_worktrees(void)
>         ALLOC_GROW(list, counter + 1, alloc);
>         list[counter] = NULL;
>
> +       /*
> +        * don't sort the first item (main worktree), which will
> +        * always be the first
> +        */

Urgh.. I should review my patches more carefully before sending out :(
The main worktree could be missing (failing to parse HEAD) so I need a
better trick than simply assuming the first item is the main worktree
here. Tests did not catch this, naturally..

> +       qsort(list + 1, counter - 1, sizeof(*list), compare_worktree);
>         mark_current_worktree(list);
>         return list;
>  }
-- 
Duy

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE96A1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 13:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeDON7T (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 09:59:19 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:41005 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbeDON7S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 09:59:18 -0400
Received: by mail-pf0-f181.google.com with SMTP id a2so9332585pff.8
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LYfxmaSmzO34FRfnMKi7lE2AyBDk05tX7eQll2SYfjE=;
        b=uGF8G+eK1dI60LOGx4Z4Ua5UPXmYnEOZA2kTJKEHbRhZ+re1BcW/u1F1leSiArYOXM
         9FZEAlpRv3JRKNwniRBwTgGXG4SGnOmF4g6tyVoz7GC9NgblyxPYZUiL/FyRYsQe+pcY
         dVOgZtjR7QvDNzoCNnNLhVByq05R0fk7PjiQfArGjBkCbDfsMVTtXyXQlTtLMPJxQQe6
         aFoS3pg49+aNHg5tkCNoFMQOq9HYQ/Gq1EbPD5H0fOynahXnE4WTTimBQKKpqEDiV6ao
         PlhDkg0Vd3vo056xfrF6rSlLWjhp45cBrl8gtUvgGX9NKJ9q1KOXv5+Be66HWsPo6uoU
         JHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LYfxmaSmzO34FRfnMKi7lE2AyBDk05tX7eQll2SYfjE=;
        b=onDoam62YHYND3n0IWKmvBMZT2e5uLHxWA6NeGLrdfAmSdcayUJxepz0jeYNLZFmhx
         Dsj7PCSTu9/oFwFb0V2MN80NYF+ubrsbsmgmJpjUw9OEOcCAT4pMwBvbRKYNFKf4v4xz
         eXT12iEwWdieDvbjV8YVb2P/RCTLm2PawRw0IX6Lemd3RKS7p9mM7oBjx4UJFcYP6NxE
         c68C4Wcr2A6PJYkZZl3viUhzBjfF+841G+LNwX5LZg7AYSn7EnnpghCiC72olNtDmjPV
         myQeT1gVTBKMI8Rw8YkXUNQWU1G6BUR5SVeqrat84XI5qsFsTTwfuBccYArTu3vLST2m
         Fpuw==
X-Gm-Message-State: ALQs6tDLZY/H4QxaE/4uTIEK7WFXJvDQoa+n9Oye2wRB5kacu2sNvwUB
        IK5ja0iaCUAQX5Sb6IYFKNYzKZUtozf7J7wCwTs=
X-Google-Smtp-Source: AIpwx49ypDAWzXEaUj32iZi2HCOUzRucq5+UpPqOMZbZ4mTqno0WysRNZ6PAdwBkchI8RvAqAOlQGig5eXRt2IaDHIM=
X-Received: by 10.101.88.140 with SMTP id d12mr9910833pgu.408.1523800757924;
 Sun, 15 Apr 2018 06:59:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.178.66 with HTTP; Sun, 15 Apr 2018 06:59:17 -0700 (PDT)
In-Reply-To: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
References: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 15 Apr 2018 15:59:17 +0200
Message-ID: <CAN0heSqCZWR1OD4k+-_OBdtCjCNW-UexLo4P-C5XyBqfU6KBEA@mail.gmail.com>
Subject: Re: Regression in patch add?
To:     mqudsi@neosmart.net
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mahmoud

On 15 April 2018 at 14:21,  <mqudsi@neosmart.net> wrote:
> I first run `git add -p`, then manually edit a chunk (after hitting `s`
> once, if it matters). The chunk originally contains the following:

[...]

> Under git 2.7.4, I can edit it to the following, which is accepted
> without a problem:
>
> ```diff
> # Manual hunk edit mode -- see bottom for a quick guide
> @@ -20,7 +20,7 @@
>         "call dein#add('Shougo/dein.vim', {'rev': 'master'})
>
>         " Add or remove your plugins here:
> -       " call dein#add('flazz/vim-colorschemes')
> -       call dein#add('Haron-Prime/evening_vim')
> +       call dein#add('flazz/vim-colorschemes')
> +       call dein#add('Haron-Prime/evening_vim')
>
>         "core plugins that change the behavior of vim and how we use it globally
> ```
>
> All I did here was remove one `+` line and manually add another (which
> is a variant of the second `-` line).

So the line is identical (sans s/^-/+/). Interesting.

> Under git 2.17.0.252.gfe0a9ea, the same piece is opened in $VISUAL for
> editing (and if left unmodified applies OK), but when modified in the
> to the same exact value, after exiting the editor I receive the
> following error from git:
>
>     error: patch fragment without header at line 15: @@ -25,7 +25,8 @@

I can't seem to reproduce this with some very simple testing. Are you
able to share your files? Or even better, derive a minimal reproduction
recipe?

What happens if you do not do a "remove this line, then add it again",
but instead turn that unchanged line into context? That is, you edit the
hunk into something like this (but without white-space damage):

...
-       " call dein#add('flazz/vim-colorschemes')
+       call dein#add('flazz/vim-colorschemes')
        call dein#add('Haron-Prime/evening_vim')
...

Adding Phillip to cc, since he was recently working in this area and
might have an idea.

Martin

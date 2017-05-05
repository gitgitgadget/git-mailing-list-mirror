Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6262207B3
	for <e@80x24.org>; Fri,  5 May 2017 14:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbdEEOZX (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 10:25:23 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35180 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbdEEOZW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 10:25:22 -0400
Received: by mail-io0-f181.google.com with SMTP id f102so10094577ioi.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U4AU1liJy9c+DeJiTq5l4h2gQ3E//m1bdgcduw595P4=;
        b=PXb43BrC7Tfw5YFkQjIcq75smN9nbToPDM6pLcEGe1cfrKQaKLlEXRv8jsI+UfKtS4
         0oeUwiTvHA+zrfd7XFEWp0o9zBrO2raNDP7wgUbagEXgPk7S4NNc7wA7tgHs4L+5+8kc
         EveftX3mGkbxzuuMeKrSmwzOIOqhRv5vF3J3/knlCF0A+/b+bl6nv4CiVt9sOXho2cc8
         2+zHXpWwkslLOkpHG2gTT+drCOdQZUF8KAT7uG5Z3vswWcMg1+BTm9KacVkpZqZKBkcB
         O/7xtXugjeNvgCCRqN+yco+u+yNZoyCXC78/se8ggB1Ti3RwOU7AmvcWTJejRen/k2Mf
         d5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U4AU1liJy9c+DeJiTq5l4h2gQ3E//m1bdgcduw595P4=;
        b=q7KEcb9iL8InPRkSjVVpntG19gUm/cE29bx09uxACyDubwoOI9U/6I08xTXHk6UrwP
         5lA0/z9WbDWxPzDvtto5DqfqngPI0eN4g0jf3lwrABzG4IJc6RHdeggDvqyFfz6FkdiP
         obJAliqcgsmdIRNu6Nulqwl7wS2HunChiG7p0Dh1IeQEcc/eBZKZpMiHoRLBZxaTeMDz
         yuVtb9SrD1lcwKVBDD9BzyWLaAPEuIAoLA/omOpzH+w93XaiUQ8q8MyYSVyrfyy6sFCn
         6xuryXRG55pP9JLN+3C9FVtEZPr7Y5qJA3JPFBkQJwV13ruBRCtzjPk/ULt3WObv044N
         y9LQ==
X-Gm-Message-State: AN3rC/5WjZWpb2MoCn364vvmu//H3TVt1VsWAvKgQNtur8VKFi7MGMB3
        b6mKmM/PQFJy5O6y9VwKOvbGob5fR94R2ss=
X-Received: by 10.107.138.9 with SMTP id m9mr44795856iod.80.1493994311390;
 Fri, 05 May 2017 07:25:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 5 May 2017 07:24:50 -0700 (PDT)
In-Reply-To: <86bmr7xuy9.fsf@local.lan>
References: <86bmr7xuy9.fsf@local.lan>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 5 May 2017 16:24:50 +0200
Message-ID: <CACBZZX7Q36rFiO9SwBCzM2M3ae=vOPJ2dfaVQ6=geZLgkLAuWA@mail.gmail.com>
Subject: Re: How to `git status' without scrambling modified with new, etc
To:     Harry Putnam <reader@newsguy.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2017 at 4:02 PM, Harry Putnam <reader@newsguy.com> wrote:
> This is probably what everyone sees:
>
> When I run `git status'; I see  modified and newfiles scrambled together
>
> Is there a trick or technique to make that output show each category
> separately?
>
> Or do folks just a throw a `sort' in there (git status|sort) and lose
> the color ouput?

If you set color.ui=auto it'll disable coloring when it detects that
the output isn't to a terminal, i.e. being piped.

It sounds like you want:

    git -c color.ui=always status --short|sort

But there's no native option to sort the status output, but that'll do
it for you.

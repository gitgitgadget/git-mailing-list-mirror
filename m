Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D001C202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 23:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbdKTXO0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 18:14:26 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38972 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbdKTXOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 18:14:25 -0500
Received: by mail-qk0-f194.google.com with SMTP id w125so9639265qkb.6
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 15:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=X73uRo4h85rWmNKt0J3LrqoI+bxs+QJNFBFFvvlxAKs=;
        b=edqiiwNr7PO3Vv1U6tuYfC+/07S407SEcQSObLA2VYHgO2UYyAz3in3s3oOdQDiloh
         Fb+Zgc6/R2Gd+NGhdyg2ve0A7H9pOntr6crr0MAWKjLydwyiVOJzEeNQjzkR2wh6GVt/
         CninvXRb423TT7qjlm24T+3VsWA6P2HyS1NiadLRw/Sin+KZCfCEpwWS4i78kSi6iMbG
         CIinnux4ICxPkSqajjIfzPP9wqwIBC+0a8t4Lmr+xtWYzbU7Ub/5wJGKL095ZQGZvfIT
         SKXaXgCYdq+2NKoFmVmtU4DinlA8blA8SEbkquZ10L+p+Gj5yrPkm4LKOb6f3iWcYcQ3
         g4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=X73uRo4h85rWmNKt0J3LrqoI+bxs+QJNFBFFvvlxAKs=;
        b=COawRxalZuLzaaagWBlD9nrnf2gj0Wo0VB0Cr1+qhzL9lEoH2+TXoPo6ou6WolcRFu
         CLZLbjOMRogmMte4J4L8h04rLQSUyXtt64pWwidCAybzGCDx1EqDakVd3MP3AKxANvyi
         jOOINO3FVNPKgoD8VE9Jg8twy5cQTBzL73jIjjk0GhMbCmhzRlPxSI4GSuXvVoisiog7
         y+5lN4v7Hk0JFLX6Nvc6Cy3s6zFY8u3nMOI4pSU2NgaWQuOivb8h5DTrjiN8n42VRBes
         85+USle+xkZ7F73DBnmoGannXXcrykeRLnzgo5Ufl7y+JQWvGh9DjgkYsUWjBdBTlNCK
         fK7A==
X-Gm-Message-State: AJaThX7yrIuJyNsG29FGyPj16yi2mX/NScekRClv+kRLgWbVt59sdZ4n
        Ae+1YzENBiKwma0L7CHGyePnsLZRQFCszP2+fO0=
X-Google-Smtp-Source: AGs4zMaSwR0MwJmikeSe9L5mliP3iFnyzMsmB2C2ALjibVbnxX5vRETXgNVa1fQZIQGDSUciq75NHkJO98+rB8/+cgo=
X-Received: by 10.55.42.75 with SMTP id q72mr23912840qkh.57.1511219664728;
 Mon, 20 Nov 2017 15:14:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Mon, 20 Nov 2017 15:14:24 -0800 (PST)
In-Reply-To: <3893514.emzqGSqeDI@yoga>
References: <3893514.emzqGSqeDI@yoga>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Nov 2017 18:14:24 -0500
X-Google-Sender-Auth: 7D2EAXMci69iFLF9_Wa9ERrJUiE
Message-ID: <CAPig+cTncgDToo0=zHsBHfCPMPTYNumNAhTgOnhceLHpse3wuw@mail.gmail.com>
Subject: Re: [PATCH] bash completion: Add --autostash and --no-autostash to pull
To:     Albert Astals Cid <albert.astals.cid@kdab.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 10:07 AM, Albert Astals Cid
<albert.astals.cid@kdab.com> wrote:
> Ideally we should only autocomplete if pull has --rebase since
> they only work with it but could not figure out how to do that
> and the error message of doing git pull --autostash points out
> that you need --rebase so i guess it's good enough

Missing Signed-off-by:. See Documentation/SubmittingPatches. Thanks.

> ---
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-
> completion.bash
> index 539d7f84f..7ded58f38 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1923,6 +1923,7 @@ _git_pull ()
>         --*)
>                 __gitcomp "
>                         --rebase --no-rebase
> +                       --autostash --no-autostash
>                         $__git_merge_options
>                         $__git_fetch_options
>                 "

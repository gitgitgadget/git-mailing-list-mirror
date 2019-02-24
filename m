Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32AE220248
	for <e@80x24.org>; Sun, 24 Feb 2019 05:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbfBXFYG (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 00:24:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42018 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfBXFYG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 00:24:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id r5so6379662wrg.9
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 21:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8QDftMJHLtQMy9rBHwVGbCmb7wdmXDbRJ7stU5hT92I=;
        b=NbfFuzFDahgwenoBc1CKWQkeUdablsi3j6BUHA/q7zQLTuX3RsnRw/dL8Y/0vgvUJ7
         nlgmPdoV9fwp810GccB3Ztq12RoYC+zJtl9hToaFFBn4a8qVgm/2736G4XrkLMqkaKB3
         wNC4LcGLw6HEe7EAdFg4qEWqAGzvN9LOWWsS0z44xKais8M1nG9uaPMZklKjG3aQRz43
         GpnDXGA760KqEZx8Tys4+IkPmP6xmairOqysZuLiknBiuWg9WCT3qe8oeypje5GauD/E
         w89YNqLvsbLw9X+pphUQHB0bdZsbOYA0yBoSniVSSUnX9xs9VyrJGGv3ygPT1UGOOskl
         UUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8QDftMJHLtQMy9rBHwVGbCmb7wdmXDbRJ7stU5hT92I=;
        b=DWv0FI492VkA3cFwqs61SItVLhLe7H7vc86egaAL9/746SLg920aFl755eUgQEgeCx
         eh9e3jLzRbJU6jiqGCEdYV3NcSBnJWZL0wVb0KiczV08L8b382bqKJNtUwg1jxAcv0yf
         SSDiLcs/bnZJvAtSgMqUZFVnfrmJs+Dl3nRO1edotodvjXB//9V9o+uPoDQQyq9otX8s
         Z+URMHmZhMa3rpWnc3jx/WiZ8PyVJe/mE49sxE/Aw80F8K4c3XK7GFp6FVOfO/ip0bFe
         6bFRHyvwQT5RaWWYyE8JS4fxNVkAFmogzJwVhBgIfy2Ukd6y8EUDFdbq/EuRu1k356Nf
         EcSw==
X-Gm-Message-State: AHQUAuZuNvYrx/z7Yhz9Fk0Zshxf36aBMEz5HQP+Y68baeD7phC8KiFu
        vuBILwTT2SpczwVmqWP/g18=
X-Google-Smtp-Source: AHgI3IZj+jkNxGyY2wWBVYnXL1I3LBeRFWwFGZqgRLQjBTkOGC6xVGkuLo79RdOPjitpdt/FfpvzTA==
X-Received: by 2002:adf:ed11:: with SMTP id a17mr8217342wro.283.1550985843838;
        Sat, 23 Feb 2019 21:24:03 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l10sm11621857wrx.45.2019.02.23.21.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 21:24:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yoichi Nakayama <yoichi.nakayama@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Fix the quotation mark in the explanation of "git checkout -".
References: <CAF5D8-tHxFyFD-ZvdYRauT_Egz8RWzF_TDL487SmuwTVO-oyhQ@mail.gmail.com>
Date:   Sat, 23 Feb 2019 21:24:01 -0800
In-Reply-To: <CAF5D8-tHxFyFD-ZvdYRauT_Egz8RWzF_TDL487SmuwTVO-oyhQ@mail.gmail.com>
        (Yoichi Nakayama's message of "Sat, 23 Feb 2019 15:33:40 +0900")
Message-ID: <xmqqef7xoj2m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yoichi Nakayama <yoichi.nakayama@gmail.com> writes:

> Subject: Re: [PATCH] Fix the quotation mark in the explanation of "git checkout -".

I'd retitle it to something like

    Subject: [PATCH] checkout doc: fix an unmatched double-quote pair

> Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
> ---
>  Documentation/git-checkout.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index 801de2f764..55eb39a897 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -285,7 +285,7 @@ section of linkgit:git-add[1] to learn how to
> operate the `--patch` mode.

Patch is line-wrapped here and won't apply.  I can fix up manually
(or rather, type from scratch) for a tiny patch like this, so no
need to resend, but if you are planning to help us with more
substantial contributions in the future, please get your tools to
send out patch e-mails behave better.

Thanks.

>  +
>  You can use the `"@{-N}"` syntax to refer to the N-th last
>  branch/commit checked out using "git checkout" operation. You may
> -also specify `-` which is synonymous to `"@{-1}`.
> +also specify `-` which is synonymous to `"@{-1}"`.
>  +
>  As a special case, you may use `"A...B"` as a shortcut for the
>  merge base of `A` and `B` if there is exactly one merge base. You can

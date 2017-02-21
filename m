Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B3B4201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 20:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbdBUUsJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 15:48:09 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35857 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbdBUUsH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 15:48:07 -0500
Received: by mail-pg0-f65.google.com with SMTP id z128so1183805pgb.3
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 12:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sw5D1DQmm313yP6v4PPCc3wYzdQEW36G8nH4FTU6w4c=;
        b=mBPOsvz0F4Mk81pOrhq3pZVWoCDEGJirRgYy7CWNRUJBiSig5OvlDf9GEEqtCiJv9g
         lweXiWx14hGh79GV4qO7rGvOfM1L/FNMFZe+a//fqJA0zVmYBOjpRWJLy/PEcIIAr4ds
         a5h39RaB3zBvh65QokFOeoBKk+DFrsB6PQfLJi+1VIn5GXFKIJzzpS5j3ujoh7JPEQKM
         F0zPFoDF2a0N020DHiV1yTrZTgIW+T7hwZVfZfOonRcT+J5AiwzuqXXj1d2EpeBOBW5w
         86q585RB65x+4SYskpzFSrxyUon0bL9lFdlONzNxzhd+uw0ILC4cj+5qgBiss/RJWics
         1k8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sw5D1DQmm313yP6v4PPCc3wYzdQEW36G8nH4FTU6w4c=;
        b=cFOufYl/Il0LL6ijxC9MuIVBeyPkzZfcwWTtRl47BzNZkpaMMLRpo0rx38HjSMPb12
         AyRNJn/s6E/nm6PdrUgqUu2DICuluxZr1iHKJ6kA7M+bz7XKoHXG8icCrVpcq9rN0fJY
         HuVsw02Ze4jWZ9StpaoVwuKPtUKqr6AZPnPjCfqjQ9437Noar2oAxRXq45GQDjGEVWvw
         /vntr/dKKGJa11jB3AddlEEW5kQvl6x6fMEUZfdX1ZLXM+kGokgnip0XKuuhiDctvkg5
         +iPrnZx+E7TfxiE13CRJY2fCEhRhZ8M+/oxQjAMCGOTG3/UZ5J2rx+D0oIJKVftiXXOj
         10Hg==
X-Gm-Message-State: AMke39mDzBkRHT7a9lsfvlHWhflCKYlycgTY6ep8FpqrrRfkDQXgy80Gyl+DNpBSZ72LuA==
X-Received: by 10.84.229.76 with SMTP id d12mr42740645pln.21.1487710086631;
        Tue, 21 Feb 2017 12:48:06 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d997:8b5d:f579:2a90])
        by smtp.gmail.com with ESMTPSA id n80sm970214pfb.111.2017.02.21.12.48.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 12:48:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: Link git-ls-files to core.quotePath variable.
References: <2b0ce702-60de-534b-8a86-5c7ae84060de@gmail.com>
Date:   Tue, 21 Feb 2017 12:48:04 -0800
In-Reply-To: <2b0ce702-60de-534b-8a86-5c7ae84060de@gmail.com> (Andreas
        Heiduk's message of "Sun, 19 Feb 2017 23:05:59 +0100")
Message-ID: <xmqqh93nfeyj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> Add a hint for script writers where additional quoting can be configured.
>
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
>  Documentation/git-ls-files.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 446209e..19e0636 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -198,7 +198,8 @@ path. (see linkgit:git-read-tree[1] for more information on state)
>  
>  When `-z` option is not used, TAB, LF, and backslash characters
>  in pathnames are represented as `\t`, `\n`, and `\\`,
> -respectively.
> +respectively. The path is also quoted according to the
> +configuration variable `core.quotePath` (see linkgit:git-config[1]).

I was waiting for others to comment on this patch but nobody seems
to be interested.  Which is a bit sad, as this may not be a bad
idea.

If we refer to core.quotePath, the mention of control characters
being quoted can also be omitted, I think, as that is part of what
appears in the description of core.quotePath variable.

Alternatively, instead of referring to another page, we can spend
the additional lines to say what is more interesting to most of the
readers from that page, e.g.

    When `-z` option is not used, a pathname with "unusual" characters
    in it is quoted by enclosing it in a double-quote pair and with
    backslashes the same way strings in C source code are quoted.  By
    setting core.quotePath configuration to false, the bytes whose
    values are higher than 0x80 are output verbatim.


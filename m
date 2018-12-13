Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79CC720A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 02:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeLMCkr (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 21:40:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41357 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbeLMCkr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 21:40:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so399746wrs.8
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 18:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DeW5uPxuTEiVeX2MC02Ecs48FAO5H68eo+eoayXvpQ0=;
        b=UZaQbYTuVnFwe98RZAuX1s7GDSn/bmUxegH9dOoZbHS196FCCco1dSG0/r7JpduX9n
         zHkGlq7Nm857WcfJudiOZpu+gieOZwugXdxoCVpvdU8KBS+tocezlM+4FPDv/qn/OwEP
         4VVOBdD5MOGktArj42CIZ9+2r5vYiR/NyZhlcXLxuFxnez9molj0IXmXozqruAsRXpqo
         lioD4VwJkn9C4WH/ZnIO2u7WSY/fAL8mNk6dTxcupoPUGNLkbD3SXjMNkdakn3XZmxOJ
         Im3m1ofOhbSmMnEBFSoYMP+ieirxEBzqM0a6jRJz0FMOL1YTGeCfF5TYBbs7V1ClfqlM
         wWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DeW5uPxuTEiVeX2MC02Ecs48FAO5H68eo+eoayXvpQ0=;
        b=SYS2G2Jk2EmGQfke7koKyLF43X6j7VlMjl0sHp/RSlC0QFi4hf6zsk3AMFXaFy4Z8C
         ydv5nnF9srw5eT5y5ENC35LwW71bEEoOqJ4bt9LZa78rVJAKRMq++aNRqU6Cp7rusoZM
         7BwNd04u+jTmtTEdtxIWVKh9u5yfrOO86Vuv6/U8ouCsZb3uTJ0g1IRfFY/9B6zMBymd
         K/XdG9855QZYkKrYO/5YhoYth1Zm5oPL7lbJQDT0ffcPvPrx5kqmGEEXVXeyfNuqFbwV
         X5A97k78Yt9ePmmjStk7l4BQ/FP//DhZssmd11sCgxM/YF0HBngc5p+YTBo0nDowPlSU
         nBgQ==
X-Gm-Message-State: AA+aEWYIN06Fs/3YRs7Mml9yXjm6Zieixu18w806oD1TLSVQAqP0V22Z
        aUH8RETHSSeoSiQOmO3aWWU=
X-Google-Smtp-Source: AFSGD/WuOIqL0a4hFRke31ujhKCMwyu55i+kVK46PGmRWkCeXfV9NePPsOncbdNauaJhd8DA0NQ5FQ==
X-Received: by 2002:adf:ae41:: with SMTP id u1mr18289732wrd.20.1544668845098;
        Wed, 12 Dec 2018 18:40:45 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a12sm512660wro.18.2018.12.12.18.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 18:40:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] t4256: mark support files as LF-only
References: <pull.98.git.gitgitgadget@gmail.com>
        <pull.98.v2.git.gitgitgadget@gmail.com>
        <4275b8a5812b7108aecfc027fd6ace9b470a7c88.1544638490.git.gitgitgadget@gmail.com>
Date:   Thu, 13 Dec 2018 11:40:43 +0900
In-Reply-To: <4275b8a5812b7108aecfc027fd6ace9b470a7c88.1544638490.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 12 Dec 2018
        10:14:54 -0800 (PST)")
Message-ID: <xmqqr2emgndg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The test t4256-am-format-flowed.sh requires carefully applying a
> patch after ignoring padding whitespace. This breaks if the file
> is munged to include CRLF line endings instead of LF.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---

Thanks, will queue.

>  t/.gitattributes | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/.gitattributes b/t/.gitattributes
> index e7acedabe1..df05434d32 100644
> --- a/t/.gitattributes
> +++ b/t/.gitattributes
> @@ -16,6 +16,7 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
>  /t4135/* eol=lf
>  /t4211/* eol=lf
>  /t4252/* eol=lf
> +/t4256/1/* eol=lf
>  /t5100/* eol=lf
>  /t5515/* eol=lf
>  /t556x_common eol=lf

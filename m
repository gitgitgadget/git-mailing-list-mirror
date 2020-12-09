Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D26DC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 07:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B4CA206D5
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 07:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgLIHFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 02:05:53 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:39024 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLIHFx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 02:05:53 -0500
Received: by mail-ej1-f67.google.com with SMTP id n26so572026eju.6
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 23:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvBQJMMzR5DCcdjEcygWimmGumA7DUjMTtnjzpIysHE=;
        b=n8QtWMvFo29B3tZ/jh2OBIz1msdz4d1+NUhwVEsw+GdVbkaupcwb2ij9H0uN9v3b4C
         1wafteOJqLrFXMbPG9sUncpyRcdtecZQu8bo2XLqAAzGbcMa6SWmDaz58uY7fer2Vqau
         2ArHgU0k3kiqbI7d+NwTeiyo0HkAFKaoql74RMAsKk+0HbhDZAyFmxzlBuwNYNGEIxEM
         hfrMkd8PjE7kGbXlnuJiks9I1qPGMj6fWm2e2hLC3/56mPpa4w6WXuFU6+wNFKyhEu1G
         qNlcCA6DluqPXLHkaWM4yYcXL/nrWsp4klA78+DAOX514T4Sa4w14tNtCsAYEuHV9ljG
         u/NQ==
X-Gm-Message-State: AOAM5333fgNPCXfDEPxFj9WQo1Gtzw65dWhhjFgS/Ea9zmZDX9FIAt4P
        p2Fh665SOgJm30zkXRIr4FYr8vRk88TjcEI0OhA=
X-Google-Smtp-Source: ABdhPJx1V5EvniNjGjnQOOtLxaOUyl8VRGOE7xVysdEPlbmLEdgwqMmyrVM5ooTnL7d0H0OQHW20rTsrMlJGLfr6oCc=
X-Received: by 2002:a17:906:608:: with SMTP id s8mr875444ejb.371.1607497511915;
 Tue, 08 Dec 2020 23:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20201209065537.48802-1-felipe.contreras@gmail.com> <20201209065537.48802-3-felipe.contreras@gmail.com>
In-Reply-To: <20201209065537.48802-3-felipe.contreras@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 9 Dec 2020 02:05:01 -0500
Message-ID: <CAPig+cRmCV23BjN0t3jF+VtxNS2a=E3Tr=x53DPn46qM15uMng@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] contrib: vim: add sharness syntax file
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 1:56 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> It gets a bit tedious to see all the tests in the same color, so I
> wrote a vim syntax file to relax my eyes.
>
> I've tried to make it work in as many situations as possible, yet there
> are still some issues with HEREDOC strings.
>
> Much better than nothing though.
>
> This can be enabled with the following pattern:
>
>   au BufRead,BufNewFile */t/*.sh set filetype=sh.sharness
>
> Whoever, that's already added to the project .vimrc.

s/Whoever/However/

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

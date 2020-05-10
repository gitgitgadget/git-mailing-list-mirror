Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F14C38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 22:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9A820746
	for <git@archiver.kernel.org>; Sun, 10 May 2020 22:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgEJWmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 18:42:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35307 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbgEJWmR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 18:42:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id n5so2190553wmd.0
        for <git@vger.kernel.org>; Sun, 10 May 2020 15:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/ez+vbaLGXM1f2QTiSurfFszJgauUBRrR9x3qaPdG4=;
        b=E7AwRtntjI00FqhqoLLI9OF0s3DoIuucAC849i7GM5lr45TctHotQFkrGS1MbWpXgA
         KwhbNYaVEam7j09VgBAtDYw6DHhigmwZL+K8Ogk2P3ItrGby3bq19iATKOec7zcErZr/
         pZNYG2qVGg5tu7TTWcUv8XMzd3MJNCOKAnZQBxdq2rosMYz9Fiy+SA4i0Udwu+UEfvAu
         w04l3tz+ApSbJK+qlWPnfDdkI96XoN5j/h7sCgEej3wRTzMJ9caVYcDLSpOLIlDTj47d
         RJuUsTx7rHo7xD8uwYH5ZFI4IpOOCdsi/SlepH5gyIJ0J8xmpAKGe1xnJvjdnKXzTMWw
         TMnQ==
X-Gm-Message-State: AGi0PubnPZ3g2k0BpDolcVKKfPxwSwSBSrCGcG51VUONIUOppHZHuVmn
        oHxZzGLxLONQxc9iUtSFyW34xVBXtzDvXRBoyURwSQ==
X-Google-Smtp-Source: APiQypLtP0YKZlDxBAR53qCohF1D6uFRHakFa1W+I/QToy8V/V9WGoTFejZz6MWS5g1nGyNU/Cbs93DGtaUyTjWgZR0=
X-Received: by 2002:a1c:df46:: with SMTP id w67mr20043960wmg.130.1589150532490;
 Sun, 10 May 2020 15:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
 <20200510164424.GA11784@konoha> <CAOEXN9yyL8T8kDmpHKTjjaG9tVS1kh34B-=PuH1hRaA7jF_K6A@mail.gmail.com>
In-Reply-To: <CAOEXN9yyL8T8kDmpHKTjjaG9tVS1kh34B-=PuH1hRaA7jF_K6A@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 May 2020 18:42:01 -0400
Message-ID: <CAPig+cRX+M5qhCuKtsCpw8ySdW358utNOiMR7dwYwR4S4aMT7A@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper.c: add only-active to foreach
To:     Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 10, 2020 at 5:53 PM Guillaume Galeazzi
<guillaume.galeazzi@gmail.com> wrote:
> > Yes, maybe renaming the flag to `--is-active` would make it a tad bit
> > simpler?
> is-active sound more like a question to me but I can change it.

I'm not a submodule user nor have I been following this discussion,
but perhaps the name --active-only would be better?

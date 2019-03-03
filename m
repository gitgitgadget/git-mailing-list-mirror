Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9AC20248
	for <e@80x24.org>; Sun,  3 Mar 2019 01:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfCCBTG (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:19:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34238 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCCBTF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:19:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id f14so1712665wrg.1
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 17:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=9IkNsP4aKTMkxwJea9O9PJ05jPS/bXwEN76vg+EAyb4=;
        b=MXrY1e0ZHakG9bSee4X8t4PNLMCgek4O2BbmpJIk1yRBEmDEwa+VL9rbXX+Tv5S1ac
         IT/xAnbq6ryR6NeAk8lfdkcDd8w3XMtJh6EoQ2lQwjkj9lod6RaS/lQ/Ey7rSvC6Ev5a
         szhwGNN0v52mwluHIVwxJRbUsLT5x353AfnnOWFXkFR2I/0p21XtddVIfg1RRIUbhecE
         2NorkTtwVMYA933Ens6/Qv52OkHRVWPSZRDurTLwHpsu6SLVa2ohKAQh8nYFsrpYzcv5
         KVsNmKH20RfsIIuqt1v93/NrHfU5pleOUx0KMkyXoqJWwAdMU+GWGO4i6qIk3a69xBU9
         gDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=9IkNsP4aKTMkxwJea9O9PJ05jPS/bXwEN76vg+EAyb4=;
        b=IICFS3aK8DlImWxIcCjZlyBTI46nchxxIWVsCEKf9JGSTEIGgNiymmbGgye8rGcRaZ
         GWRNaxBmKv4hX2neqHK6K3YE2xTMlnAoPXrdH0+uz3Kj0VaAyKqRdfSHCMLjMP/5dN4A
         0DmvhAWd/ABEKkfaiTZK3vzQu346McDworLZiuUnCEyybg2UEu18pPO6r7GtcFiyd95H
         hFHUiNw8Bt8ZIllwq7y9yeuxSw3LLok4L0oQ0QvUgQmopXueJVzr3r+P48neQD/8jVdd
         E4VDBvVtKe9vodtGYRS/THjUgfX8TRjRpdYgGXWjEtMkX8ICp85BgG9nQZEOYc6+Peo0
         aQ/g==
X-Gm-Message-State: APjAAAXrPP56G+CarVCbHQUZRlqpv2eE69LI4uf4p1au1/g/67bvNcbt
        Fdf3ef3W3/zrBt4RnqW84XCgKQvpWQM=
X-Google-Smtp-Source: APXvYqxgRhSL5XsSgRAEyiMKALOYVhoLN2BJtmZ77IsZPITP8zQndzOsU3ZxGp0n49rh9MS9ji22qg==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr8365283wrn.276.1551575943847;
        Sat, 02 Mar 2019 17:19:03 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d21sm9065901wrc.44.2019.03.02.17.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:19:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Drop last MakeMaker reference
References: <pull.146.git.gitgitgadget@gmail.com>
Date:   Sun, 03 Mar 2019 10:19:02 +0900
Message-ID: <xmqqfts469h5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Back when we stopped using MakeMaker, we forgot one reference...
>
> Johannes Schindelin (1):
>   mingw: drop MakeMaker reference
>
>  config.mak.uname | 1 -
>  1 file changed, 1 deletion(-)
>
>
> base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-146%2Fdscho%2Fno-perl-makemaker-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-146/dscho/no-perl-makemaker-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/146

Good ;-)
Thanks.

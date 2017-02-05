Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC561FAFC
	for <e@80x24.org>; Sun,  5 Feb 2017 10:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbdBEKSa (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 05:18:30 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36357 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbdBEKS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 05:18:29 -0500
Received: by mail-pg0-f65.google.com with SMTP id 75so6293401pgf.3
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 02:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3MM0JqnXmHX64NqpVSITCEiasbmTPZY1SAwxSvn5JBo=;
        b=mXwvs5KQ7poMc7rUMwjMkPeyrvCGsTAk3cuJ5sCHPYvvmcEIIvz5/Uhq+pG8H3zrYn
         rfNylscC5kh17hbJXp+iioCFI0pNyc2khlBt95WPNvounSKFbgS4Lw1oSbIL4cCBDQ1L
         HqfQ8PFGGDh2Z7aaHNOWqjL7ui7WfujdP8DoTohqcnvvy4cY6XKM+mBQxuQioNqb3/mm
         DFbUzD8FTpeEfD2NBWFAGOzD0d+4umGs/GhSDp9Vp26LN9P6zlNzD7cxFygsymbV37Jt
         54JTy3T5Efo+UvADy/KJFXt2pRGIEg5gqS4R+xmpS5wRgN44Hn7KGtgBl1EoDCdYUg+m
         Nwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3MM0JqnXmHX64NqpVSITCEiasbmTPZY1SAwxSvn5JBo=;
        b=cnWqWpHCG+h5D5s8n0ARshhuOXxcSGehMk99P6ByrgBhO2TE88xkQL2uO7QnE19HEh
         NGNtilfSNnNq6vLpnl3+8KmeR5gBTyUYpvdQT3rbDDDeXhyVjjbRw6lyL8rgWrY4LNwx
         bg8Voh66mmt/I0gY2dCa4VCaZeVtAzYMKVpibXQHSxfLeZHEL9dqf1oQbFsogb5dGC+A
         ZZ/wPWL4WOo7L/F4CYLb7Otan7FHCb2rVvITYpYP20BRdm/aGZTSxEPdVysSNfMIZTox
         eFTgf+JeQAH57DlZ6cq3yD+lcFe57jLUKlM5vEjGYvUHXEZqDlwEoW0AB8qplPAGok9v
         TLWg==
X-Gm-Message-State: AIkVDXIkmJKoYPWG3934ROKOdLBontQ+iPpb+xCz3DxljSD6JDWVBKEjM5YlTqEwciCoLQ==
X-Received: by 10.99.160.84 with SMTP id u20mr6952165pgn.141.1486289909048;
        Sun, 05 Feb 2017 02:18:29 -0800 (PST)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id q22sm80405720pfj.77.2017.02.05.02.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2017 02:18:27 -0800 (PST)
Date:   Sun, 5 Feb 2017 02:18:25 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Add --gui option to mergetool
Message-ID: <20170205101825.jdhklpoadt4ingcf@gmail.com>
References: <20170204064303.GA14990@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170204064303.GA14990@arch-attack.localdomain>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 03, 2017 at 10:43:03PM -0800, Denton Liu wrote:
> * fix the discrepancy between difftool and mergetool where
>   the former has the --gui flag and the latter does not by adding the
>   functionality to mergetool

Please avoid bullet points in commit messages when a simple
paragraph will suffice.

The implementation of this feature seems ok, but tests are
needed in t/t7610-mergetool.sh.

> * make difftool read 'merge.guitool' as a fallback, in accordance to the
>   manpage for difftool: "git difftool falls back to git mergetool
>   config variables when the difftool equivalents have not been defined"

I did not spot this change in the code.

Nonetheless, this should be split off as a separate patch, and
tests should be added.

> * add guitool-related completions

This should be split off as a separate patch as well.

Generally, 3 bullet points suggests there should be 3 patches in
this series.

Thanks,
-- 
David

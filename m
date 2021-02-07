Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8E2C433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 672A764DF6
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhBGSuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 13:50:50 -0500
Received: from mail-ej1-f45.google.com ([209.85.218.45]:43609 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBGSuk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 13:50:40 -0500
Received: by mail-ej1-f45.google.com with SMTP id y9so21190198ejp.10
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 10:50:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fj+iOQEr0Oh8naTEH/Q60jYOf+jyRQLZvYo4EfA5+YM=;
        b=SRIcvPHrVI+ga0C89qWdYQuBLV7pQi4ylY8ychnymBUv92xs1wW6pfYzoYDDDGo+Yp
         7Mnzg19RF16RpkAQeoSn28EuPNDm0m0IrFPq0hfw2KVMXhn7ntd7Fq7kdLOXMRE+OTFf
         POGqTkqaqO1ZKFOU+Uz51Jp6Ywr+Arg/OBStKyx/oWIxB9T6eJMKUtytHRSRLAeDzwTk
         VtZ6soPi/5z5gdNOBPFSgOjJMr1naWe0edVBOsVsLwm7VLwquhSCMhZ4DRLxEa15hCAh
         6wEegZ0CC1sroinosq2pH9a0A3VCzO39nInNbNtPSLVJm1CKSkQUFY8ZKnzojhikEFKw
         ksSQ==
X-Gm-Message-State: AOAM530gb/G4S1Ks9YKZyFPjtJ1ShKFqPf+lggO/FCCd7ZNk3+G0iY3l
        UEQNbGyYCUjDjQQIGTeit6XZheFRjXX5BAHjZQ4=
X-Google-Smtp-Source: ABdhPJzYL8Mv3f2L4hwv3NjBd+SSxrLUsgj39+a7knYE37nhH6eqfJpYlZ0AenKOBpo54/rySbmbvT0Av2J0wu+PaRw=
X-Received: by 2002:a17:906:a1c2:: with SMTP id bx2mr14081114ejb.138.1612723798472;
 Sun, 07 Feb 2021 10:49:58 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <20210207181439.1178-4-charvi077@gmail.com>
In-Reply-To: <20210207181439.1178-4-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 7 Feb 2021 13:49:47 -0500
Message-ID: <CAPig+cS-QK7dZ63NfEY8S2z+wveY43dHkQWV3krNDP_dYSfyJw@mail.gmail.com>
Subject: Re: [PATCH 3/7] rebase -i: clarify and fix 'fixup -c' rebase-todo help
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 7, 2021 at 1:19 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> When `-c` says "edit the commit message" it's not clear what will be
> edited. The original's commit message or the replacement's message or a
> combination of the two. Word it such that it states more precisely what
> exactly will be edited and also remove the use of a period and
> capitalized word in the to-do help text.

If you happen to re-roll for some reason, it might be a good idea to
explain why you are removing the period and capitalization since the
reason is not otherwise clear to the casual reader. So, perhaps:

    ... exactly will be edited. While at it, also drop the jarring
    period and capitalization, neither of which is otherwise present
    in the message.

or something like that.

> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>

Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311E2C2D0C8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1343D2082E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfLTSPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:15:54 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33756 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfLTSPx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:15:53 -0500
Received: by mail-io1-f65.google.com with SMTP id z8so10316347ioh.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IpGKEOPcv39kT87rr3G2khvKUAEFncKAiWEQ9ngxIrw=;
        b=OhGfmU/FmJSM8iWCu40eNZ20WaQiaizcjn0pTFXtI1QQ08ymUnwUSDLJfXUxMtXriX
         LrKcT1uJTZM3141WTp7vwLPZvkP1x9q6v5y74VzrdIysEpXoD75yiseEMogim5GXdp12
         08DIH6MUz2tOxN2FwoK2ChO3T3l9IlVFXU5a8Wvx87cArobh4bCxZj9ZtI6V/dtZudi0
         0v0ye5dgFaE4EKULLTINtbN2tUWJe3S4Q9IfhfnjrzEem8lUmRZoIc+R4NY5ttXPIBte
         BlWX6sfW5AhBzwx/vJdwCIp7BCyd6T7CC28Yk+H2jUchyhpm3yyLE05hbH2/B57vjou2
         O98Q==
X-Gm-Message-State: APjAAAVlQ6XUqA6ew0gl6mIy7hpu3cgOvTZd83YXXldUv9GKKnlV447R
        hv31UH69m6q40iR9VmSx97lgWRhy/i7lBieonipWCWK8
X-Google-Smtp-Source: APXvYqw7SOvOQtUodB4UeA0btzSXRrTOB9KgPLXG44rgt0pvGzd8c2wLCYCoybc9469h4eLvbMxppz26KnsXxVU1BGM=
X-Received: by 2002:a02:ba91:: with SMTP id g17mr13576331jao.106.1576865752690;
 Fri, 20 Dec 2019 10:15:52 -0800 (PST)
MIME-Version: 1.0
References: <20191219015833.49314-1-emaste@FreeBSD.org> <20191220153814.54899-1-emaste@FreeBSD.org>
 <CAPig+cS6XPc9KZo3ytEHLFjMxEFqCk5OJMUjZyFBP0cA95u9Lw@mail.gmail.com>
In-Reply-To: <CAPig+cS6XPc9KZo3ytEHLFjMxEFqCk5OJMUjZyFBP0cA95u9Lw@mail.gmail.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Fri, 20 Dec 2019 13:15:40 -0500
Message-ID: <CAPyFy2D25M2O1M_kaAYH_SzoJ2BW-K4470ybOSZPrQLMnHFB3Q@mail.gmail.com>
Subject: Re: [PATCH v3] sparse-checkout: improve OS ls compatibility
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git mailing list <git@vger.kernel.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 20 Dec 2019 at 12:55, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> It would be helpful, therefore,
> to mention such an implementation by name:
>
>     ...some 'ls' implementations, such as on FreeBSD, include...
>
> (One can, of course, always argue that the commit message can be
> consulted to learn about a particular 'ls' implementation, but then
> why have an in-code comment at all?)

It could serve as a hint to check the commit history, but fair enough
- I agree including the specific example is an improvement. I can
resend if necessary but probably that change can just be folded in?

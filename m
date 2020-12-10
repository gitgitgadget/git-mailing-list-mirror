Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB9DC4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8042233EF
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgLJAuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:50:25 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:37193 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgLJAuU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 19:50:20 -0500
Received: by mail-ej1-f66.google.com with SMTP id ga15so4899668ejb.4
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 16:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8978hYwiTylwTKbdq5kYmQSYJO6a1SPIB8nLu4ts23U=;
        b=iT9NRb89ILqT78trWjFRJ+TjdYWS3ml5rG2corVKWXKX/Tr48BA/iOB1bkEW19zUiH
         mabFmCpmtHUqj8o2JKq3tz4PPO06ezpZK1u+yrwLHv2Mql3676pHDtVLM9RAKQQ4w7xe
         Hc2VO9lw1ke7Z0iNPI9gy4b76LELPOGhR/Ye27826Q4tNbXS5ueRijQrdNa+YVr9tjGt
         cYnfp8lGM9fbdOT10PdGlnlotEDJ0dEdmtDiLrxLxk+r8W9ot5z2yixPKchD8zT9r7Pg
         G9i4qRBKGeSzvsQ97OcC0kuLqDrI6Kks4zXTnbpJ8aSZUZ7W4/n5uw9ZdoXhFEDB6Rcb
         5yyw==
X-Gm-Message-State: AOAM5307b0J74y58smx8v8opY4kfVEZwYwCclhMIXBhSDot2YzbzmgSl
        lXvazvvV6A3YR2DwWijBoEMI2pH40MrXIZ6UptM=
X-Google-Smtp-Source: ABdhPJy/YGzhyOhNytwp3LFzoCQgfTPJ24mL3PF8xzLtm5JRTinTRaDIM31OGLpLevZjf146Hplb5dCXEro3nJC2WhA=
X-Received: by 2002:a17:906:c7d9:: with SMTP id dc25mr4392744ejb.138.1607561378439;
 Wed, 09 Dec 2020 16:49:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.v5.git.1606191405.gitgitgadget@gmail.com>
 <pull.776.v6.git.1607542142.gitgitgadget@gmail.com> <xmqqpn3izeit.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn3izeit.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 9 Dec 2020 19:49:27 -0500
Message-ID: <CAPig+cSciupmmupdgynfBO98EFke5fneC5W+k2vCo9Zkh3KF5w@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Maintenance IV: Platform-specific background maintenance
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 7:33 PM Junio C Hamano <gitster@pobox.com> wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > Update in V6
> > ============
> >
> >  * The Windows platform uses the tempfile API a bit better, including using
> >    the frequency in the filename to make the test simpler.
>
> Are two fix-up patches from Eric that have been queued near the top
> of ds/maintenance-part-4 still relevant?

Both of the patches from Sunshine are still relevant atop Stolee's
latest (v6), and they should apply cleanly (I would think) since v6
didn't change anything related to those patches.

Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576C1C4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 13:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 064EA206F4
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 13:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgJGNMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 09:12:30 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:32816 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgJGNM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 09:12:29 -0400
Received: by mail-il1-f194.google.com with SMTP id o9so2241001ilo.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 06:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnfHBV4Vhfr1kCv/vM4r0OVxvCdVSE79Fn1bgfrA7I8=;
        b=oyANF0YT1jhnynBFxdFgxxUBspMWzvAdVn9aWMBPswdXDf+UZpKmn8/mL9XLGBwKMk
         QMAcoQdWdb3X8lrZmoQk3r1/V85/YQb8Uu4TLiwE0u2Png6L/CrpfcGHSZzRW8+UJ2LD
         bqMoPu/YEivDYiTMWcoOFkzf8PhNmltCK+51LRNgg8f5T2QrGSGGoZckhONM8mQTGlhV
         VVJ4MOnytJzkN5+FDudi1+neHN+2HDzTf9m4BKylOjq9khp/ugRBXL6wuVDPOy+S2HoU
         EnA3mnWlhlSHKwiCUb1S2m5FAU1w9f9lXWrVZpkENZfHHMngghF/a6VFkKeNe9kcsG3z
         SdAg==
X-Gm-Message-State: AOAM533Sk0aYggvYmIPmvFV1gWaEF8BcqvgJb89ZD+OJoIbc5mqa7lXd
        tZJdKu2esIih+ZeR890mVIb6DMo2RbjiInPV4vKKMciz
X-Google-Smtp-Source: ABdhPJyRQxSezUGmYSZn1I/1qWIj5xlClTedwQT6LouC0Wu8r+ogs2Y4MYKJ/aThbZguDaFhO8H7k7afwsD8VMmtVU4=
X-Received: by 2002:a92:d742:: with SMTP id e2mr2605146ilq.11.1602076348018;
 Wed, 07 Oct 2020 06:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
 <pull.493.v2.git.1602021913.gitgitgadget@gmail.com> <9cff2a0cf66f037bf10866b7787496c6cf02ad94.1602021913.git.gitgitgadget@gmail.com>
In-Reply-To: <9cff2a0cf66f037bf10866b7787496c6cf02ad94.1602021913.git.gitgitgadget@gmail.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Wed, 7 Oct 2020 09:12:15 -0400
Message-ID: <CAPyFy2DmZdWGe8VUAEtWrJEBMWZJfQ4VC0BzjFkQT3cmdrDf+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] subtree: handle multiple parents passed to cache_miss
To:     Tom Clarkson via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git mailing list <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tom Clarkson <tom@tqclarkson.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 6 Oct 2020 at 18:05, Tom Clarkson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Tom Clarkson <tom@tqclarkson.com>
>
> Signed-off-by: Tom Clarkson <tom@tqclarkson.com>
Reviewed-by: Ed Maste <emaste@FreeBSD.org>

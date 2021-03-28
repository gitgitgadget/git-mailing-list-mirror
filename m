Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3721C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B9F6196B
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhC1Cdg convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 27 Mar 2021 22:33:36 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:39913 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhC1CdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:33:16 -0400
Received: by mail-ed1-f42.google.com with SMTP id bf3so10497333edb.6
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dv/z7MHnD9d5gFFELHU4bbexY2d8G2EfdV0U/J5Q9Uc=;
        b=PBbqT+f4Mn4PsppMNSKDCvpI3mGEXbDXbKr+Nbr9gHOruyf0C6Nyfoz4o85CFNOdhW
         hx+fYmpEUDsFpg5hoqQ9Hws3U3HEyN1b6rtUfWfalQA39dAJdPsgLB57CF7FaijWYR3q
         khd2cZWeo1IB5LvoMX9GGwEGuMXdM3HIDKWICbbOT5QCASEYZ/oLJdDyah1dG9r6V7yT
         ufgSGoYsl6dlBuVrgayYV4wv+6S/bv/6SG18qtydG/jWoALVo35EO7++H2zt9+idINxU
         Aro+mrmpqJImWvHcfPj9XqFNJxdyEOH4YaJKnDJehqweqSjTMGJSCXicpW0ZMd3ZWgW0
         irnA==
X-Gm-Message-State: AOAM530LtcTvIPDGZ6ih9nISCBQDYt29rjJveVosAujavHv694rXZj8S
        Uzns5t6/TNvMnfvD7b2z0gs10ysg8veDphNOS6w=
X-Google-Smtp-Source: ABdhPJz8kBMmfPquXQi9VxCbvamEQQMFt2/zsZymxNR8Vt480VaOgz/bHJdzAbmKJz5Y7D8QAOjqpamDIzeEsn8oV5g=
X-Received: by 2002:aa7:d0cb:: with SMTP id u11mr22580243edo.163.1616898784321;
 Sat, 27 Mar 2021 19:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com> <patch-1.5-a7b329c21cf-20210328T022343Z-avarab@gmail.com>
In-Reply-To: <patch-1.5-a7b329c21cf-20210328T022343Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 27 Mar 2021 22:32:52 -0400
Message-ID: <CAPig+cQxhTVG_sG-LxSc4ZKEQDZTK5HZEXaHM-1G_12aGutJFQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] usage.c: don't copy/paste the same comment three times
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 27, 2021 at 10:28 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> In gee4512ed481 (trace2: create new combined trace facility,

s/gee/ee/

> 2019-02-22) we started with two copies of this comment,
> 0ee10fd1296 (usage: add trace2 entry upon warning(), 2020-11-23) added
> a third. Let's instead add an earlier comment that applies to all
> these mostly-the-same functions.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

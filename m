Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA6EC4741F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F21A6206D4
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgIYUdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 16:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgIYU2l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 16:28:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361EFC0613BB
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 12:53:22 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id n22so3723198edt.4
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 12:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nK8X9W5AgZuNax8j68S5d9lcKLGqjl1xbKrQIr876V4=;
        b=ULlPIR6wgH/I4MublEY1sixvg5lOKn+G9DHLsip+EmUAy0P8leWzfCwgv1jXmBB8Hs
         qHpRxAR4oUpAjPYiGBGeUWzVeJcPR1pirAL77VR+DzjTtjRhtF7xir8T4ozvfL6gW3I4
         QHJra+JaoDn9aYcwLzz2E6VWh3Y87t/IXlOu1GOboD1Dpib7KBfps8vR2VDOfMKdS/NY
         Sf/UUu4CbuxZVzF3E2RE2R1FPEBDFNukcn260PYQEPMCscQj4EQdw8CbzLeKSEztYVCn
         ShsV1INB70WpkQu2+JaaazSV3vdC+9CLzDTLuMo1Gukk3R41JVvcjkkjJ2aR1ZzssMXb
         B/Ow==
X-Gm-Message-State: AOAM533hvi1/3+vamPRJYDCGA8MJGlCOVFv+XusqRHeh7syFePu9vpVU
        84diUVlCzw/o9MAfi9tJ9szpSFRjs7rZbPrkVqU=
X-Google-Smtp-Source: ABdhPJy5NCeC0psaGK0mL+hMrn6GLRQ7fBj751IlNhEedIAKib8kL6Eo0zKvgHf9z/Lk+F1KXjcCcsEMY/IrY1e6IbA=
X-Received: by 2002:a05:6402:17da:: with SMTP id s26mr3072456edy.221.1601063299714;
 Fri, 25 Sep 2020 12:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.738.git.1601044118.gitgitgadget@gmail.com> <bb8f122cdec94e1ec77b37ed16a7151f5e35a93a.1601044118.git.gitgitgadget@gmail.com>
In-Reply-To: <bb8f122cdec94e1ec77b37ed16a7151f5e35a93a.1601044118.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 Sep 2020 15:48:08 -0400
Message-ID: <CAPig+cTPi1yi7WQf_eWa+bFRJEdtULFO3yYqJh3nm=_CtEe6CQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] cmake (Windows): let the `.dll` files are found
 when running the tests
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 10:28 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> cmake (Windows): let the `.dll` files are found when running the tests

I'm having trouble parsing this. Maybe you want s/let/ensure/ ?

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA7BC43219
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 17:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356458AbiAYReq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 12:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350624AbiAYRd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 12:33:29 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AAAC061744
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 09:33:28 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z22so64418920edd.12
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 09:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNArb2Cpq2MFOf8nZFWMSE/h8+WM9cwfpEbGcO9+ZAQ=;
        b=LSqphwLbSnLNBb+MS6wGjkU4afcn4QtJFoYPu3uMjnFyfLx/+9Rby/R7R3//QHH+AS
         ayro+8/7VXmSW+m44sZJfmM/p7QmuBFDF7OouzkEy+i3rEbETRsLCReMKiO4ifS+joxI
         rrJ3MhY63vfNVBNsK/6/X4Ewzk7io0xCG3tk2bFGbnyanBL1i3x9y7ePSWyT3kb28440
         6Ax/s2iQz8LvWgEDQgxeJR6mnyXNpxoF6n1VLzWP9KuSvFgBbU1vTydLcB+OPBUbSHC/
         7gL5zBAYwfEyFpmCRFDhnDllMCs6vFxmG6ulqytNqRvm6Yx63ZLvdvLNrvKhP1sM4wmc
         Qd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNArb2Cpq2MFOf8nZFWMSE/h8+WM9cwfpEbGcO9+ZAQ=;
        b=0Qh2Bsg7b0zh7yUUO+uzYY2N0FIV1oD7Qw0QmvyMw7FLS7yr5lQWPjzKk2rAA66WzD
         jUMySjhsnIPoH2IbBHE0sfx9DRM0OHNs+xLHdJLufPZ1VZJDyPyGMdXGXfVCAVhkhH4i
         mzT/fqBW8/wqaqLNhgvQxIT+cDaFkeMSDuLiqEPf/vJmnpqX5rAcH8uLCGgAOcSuv0lq
         I+reUsPVc3vpc4SKYFN36OXQkRLMM/jEAbQJ/ZpaKq8ls47R7yR1j5nvEiW3ON8JFWBv
         txGOwIcIeekcTgU10Kjfbw/IzTyZZaTs/l//6rXcHYZkBzD8AQnLwmPjXZ2YhLLrgzlM
         o6Zw==
X-Gm-Message-State: AOAM5315RjWf1qqVkiAYhIBaeFImw7yQHZHIh6rJUaAYp/LReb0qoUd0
        kdfOA4SBWXay1R8hjknwlnCoh0cmkP/122MXOQE=
X-Google-Smtp-Source: ABdhPJy+wojvDFByWxr50HzjjhURqsveAw1qnGueFjGjbJQmrK8F/7cpSlHGIKeA5uQZhx7UIiGF3GwcSQJauhqFEEc=
X-Received: by 2002:aa7:cd17:: with SMTP id b23mr17485000edw.141.1643132007244;
 Tue, 25 Jan 2022 09:33:27 -0800 (PST)
MIME-Version: 1.0
References: <e5a0448a-4606-7ed1-78d9-b06520688616@gmail.com> <nycvar.QRO.7.76.6.2201251639540.2121@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201251639540.2121@tvgsbejvaqbjf.bet>
From:   Jonathan Bressat <git.jonathan.bressat@gmail.com>
Date:   Tue, 25 Jan 2022 18:33:15 +0100
Message-ID: <CANteD_wEoOdbDoqh=U6zdPOBk1UAymp148cN2tjf7CX19NhGMA@mail.gmail.com>
Subject: Re: [Newcomer] Any ideas for microprojects ?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Cogoni Guillaume <cogoni.guillaume@gmail.com>, git@vger.kernel.org,
        guillaume.cogoni@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On tue, 25 Jan 2022 - 16:43, Johannes Schindelin wrote :

> If you need ideas, you could look for tickets at
> https://github.com/gitgitgadget/git/issues (an inofficial bug tracker for
> the Git project). You might want to look for the label "good first issue",
> e.g. https://github.com/gitgitgadget/git/issues/1125

Thanks, That would help us a lot !
we will look at it soon.

Glad to start contributing to the project.

BRESSAT Jonathan and COGONI Guillaume

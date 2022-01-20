Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75337C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 10:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376383AbiATKow (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 05:44:52 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:37750 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376372AbiATKou (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 05:44:50 -0500
Received: by mail-lf1-f44.google.com with SMTP id m1so20001437lfq.4
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 02:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJ7i5jSGAV6UA6rYEmNeGk907pFhhSazuI9ahKzu2UU=;
        b=k1YnCzEegJ1akbcK7bHD1JUvkZjlseX15GLJIG8AVNVNcUadKUiaJLeub6Z95W3mut
         zs0QAVsBAyVWfdDm0PW0Fcl29xY9kfd+JuOymdX60Du+yR8YS6oaEhtYCsgtsquUgD3g
         kN0rtzNVP2wv9TgN4oi/F2M8+SeKPgfJhx1oInxz7rPjhGIVJjBIRkIwzVAgdDrV36pR
         0+AEJ3vvGNIWsl14+YkyWE8RhqZ3K4YGnCWjWvT2PHrZsyDnbq2ABQMOP4ztTD87a+yh
         KH5ZqDIlX/KfllT35phsw2Kxru5mrW/ZoqUcoEsCWEWQ/BtDTWxAhK4qszHNkFDVe1hf
         Gavg==
X-Gm-Message-State: AOAM531aI2L0uNAVBWvu22zqz6Ku1S7jibmmO1GjmIE4e1QN6jn+7tdw
        rzLo/R9B0CSKgsqNPV5546+7kUAz7+Kyz4P6iOMg+7hw65E=
X-Google-Smtp-Source: ABdhPJxB+LIPxPKCUgcJ3N0dTvFypHB+2ZCJbV9eRdaxJO7uZ+eWX0DXk55WSjXwxKy39BnUrYp69/4pB2pNkSHyO5E=
X-Received: by 2002:a2e:7205:: with SMTP id n5mr22227055ljc.409.1642675488659;
 Thu, 20 Jan 2022 02:44:48 -0800 (PST)
MIME-Version: 1.0
References: <xmqqwnivjgtg.fsf@gitster.g> <CAFQ2z_PA4zHV8xc1f+sMW9DnaF1E4AQrvkCav_Sx-bKRkgDLtw@mail.gmail.com>
In-Reply-To: <CAFQ2z_PA4zHV8xc1f+sMW9DnaF1E4AQrvkCav_Sx-bKRkgDLtw@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Thu, 20 Jan 2022 02:44:36 -0800
Message-ID: <CAPc5daVFUoK1UQUO5jdsLSUQ8XfkiEk+MoWKg2CZB0=N6N9XXg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2022, #05; Wed, 19)
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > * hn/reftable-coverity-fixes (2021-12-22) 18 commits
> >  - reftable: be more paranoid about 0-length memcpy calls
> >  - reftable: add print functions to the record types
> ..
> >  Expecting a reroll.
>
> The reroll was sent on Jan 12. I dropped the "reftable: be more
> paranoid about 0-length memcpy calls" from the series.

The last time you mentioned "Jan 12", I went back to the lore archive
for the original thread [1] and didn't find anything but a few comment
messages on that day.

The Message-ID or lore URL would help locate them.

Thanks.

[1] https://lore.kernel.org/git/pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com/

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D6471F428
	for <e@80x24.org>; Sat, 28 Apr 2018 15:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753214AbeD1PAq (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 11:00:46 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:44873 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbeD1PAp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 11:00:45 -0400
Received: by mail-yb0-f181.google.com with SMTP id v63-v6so1706352ybi.11
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jJCBEGWewZcDAIFRPOxg5fS4V59HG9E5oLIczXn0goE=;
        b=U2hMhz9kGwY0yZiFxBIqD/Oe9Q9+KyOeMlIXN9dOM/vipCBiTY9YBKX1+LlNWA8m0t
         izIno7Gh3P0cBITpmEmMUI8U3v2E4Id8bmtNT7q3bkzqfmFexo2IzVd2svu9sHH78lio
         k3/nZX6PGTFgdg9DGcxlsuPDEX1mB0znnZkHez+CeO4bcUC5YWaeBlojlH2WIopPrYTU
         P38jk4tjoj0NVC2YdM7bYVmdBmBlfGc8bYs49SZleTN2iwff8N2IUiVwSUKvx5p15oxy
         bB5R32JAAZ6PW6/9eMfYUQF0WxGsFCgtr9/rJ+qmzgDEd0ivqP/TP4uDueYr059Ofyzg
         ehwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jJCBEGWewZcDAIFRPOxg5fS4V59HG9E5oLIczXn0goE=;
        b=Zk0rbW6iWTq3U9AFNFiYOIxXeRjrKIgOeU5skv8R3Y9Db54iMv+J+sfmJDbYkLb2Dx
         yfuf6/qLp9b1Nc9ZNvsINezVh+Z+XWsq74l+kGiA1E2E07Y4FUX1hHcnP0hWqmePt+k4
         gHsyv8cmrNRkSU4ewFrPdcCJ/Q6zh7SafCCrlPYVUqhOteFodUrfAzRYltm2GkeR+JEU
         siI5pK/Fxi6LyP05SN1cfD4pHEYq5pgQ5Ni6aI2yXmBizX00wYMSiTTjhSdFXLw/QOMO
         V9smEpKdmOxSZ3TczuEl6xJ0gST5jRPPKfWwH2tblAnlAKjnU1lAA3N31fKdw04LgRzt
         EoSw==
X-Gm-Message-State: ALQs6tDrJqUbvttNNsj/cQlI0Mj+HH/0WiheYb0CbpleYWzFo+pGdaXk
        h7WL9cABL1UPL6swEcY0qYZN7rR1f5wMiiu76XRZFw==
X-Google-Smtp-Source: AB8JxZqnl8JBxGwIfqLDQPg/xcA12RSrK3OagXwLVIBkwRju4PdjlqAPnX0nhoHmR6BErgK6X5gas9Z5gpWMBFw4gaM=
X-Received: by 2002:a25:a567:: with SMTP id h94-v6mr1027764ybi.515.1524927644150;
 Sat, 28 Apr 2018 08:00:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Sat, 28 Apr 2018 08:00:43
 -0700 (PDT)
In-Reply-To: <A37AE6B64CF7414ABE41697663B2BEC4@PhilipOakley>
References: <cover.1524650028.git.johannes.schindelin@gmx.de>
 <cover.1524865158.git.johannes.schindelin@gmx.de> <b321979f88589e7b006466159c470800db948d66.1524865158.git.johannes.schindelin@gmx.de>
 <A37AE6B64CF7414ABE41697663B2BEC4@PhilipOakley>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 28 Apr 2018 08:00:43 -0700
Message-ID: <CAGZ79kb3+TvdHhPkb-PuZFX1RzUq3O2NNVZqa3r5BmOmOXaHdw@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] Remove obsolete script to convert grafts to
 replace refs
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Sat, Apr 28, 2018 at 2:04 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
>>
>> The functionality is now implemented as `git replace
>> --convert-graft-file`.
>
>
> A rather late in the day thought: Should this go through the same
> deprecation dance?

I think contrib/ has other rules than the core
(c.f. `git log --oneline --no-merges --grep "contrib: remove"`)
which is why I'd consider the deprecation dance unneeded.

> At least it will catch those who arrive via random web advice!

Good point, unlike the other removals, this is not a dormant
project.

I would still think it is ok to remove it. Those who are looking
for this script, surely will look at the man page of git-replace
or are looking for the grafts. `man gitglossary` is already
sufficient:

grafts
           Grafts enables [...]

           Note that the grafts mechanism is outdated and can
           lead to problems transferring objects between
           repositories; see git-replace(1) for a more flexible
           and robust system to do the same thing.

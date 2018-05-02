Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5DB21847
	for <e@80x24.org>; Wed,  2 May 2018 17:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbeEBRUJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 13:20:09 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36175 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbeEBRUI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 13:20:08 -0400
Received: by mail-vk0-f65.google.com with SMTP id i185-v6so4333385vkg.3
        for <git@vger.kernel.org>; Wed, 02 May 2018 10:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pz0NuOW+KHqZHwjPMFXn+90g9jKQnJbT2zDS3N3T2ak=;
        b=sJcKj8mJ+O3GWoCzGO74CwmMvNlz4y9039o3IFSgW7vYj9szl1WPrLNJd8B4WHoDIn
         y0fpeoHBAr17X28JT5VRPmuOqzkv7wuGrEAfBVEet4FgaiH83clk/qsLS/xNFUEsAlRh
         WcNyaFKJZjmSAB8Oy7/FYk36IygkhqklfjjgdJl4EMF0HMo10T3EL5v+7v/Qu2g57cib
         sxF0UVxLRbOvQvV05Og7Ax5wOG36griLKyqdKFepqelJJICX2R6a8BlmCC4TLwaByXXu
         nh01V5YlQeDWvffd9doK495iR2vyTLHy5AmjK0x+IVCvf0hYbrFRwt2ldkio0Zt+jF2W
         0TYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pz0NuOW+KHqZHwjPMFXn+90g9jKQnJbT2zDS3N3T2ak=;
        b=PVKgTtYLzliQhj92rwP8afjXiCihiu8ERpnL7kYmOsS8rymbPFMxhvHp596AyBnfHI
         BI+hzuswdtqNNJQfqOMzcB0M99LngPMAmPb4EMtGCqDJLYT5y87PPL70Up1p9kSI2cQn
         V5/GwurxDhyepbX+S93hrAbeR5/ibhAUO4oA2y7vIEC4UPeBQaHInghhPrr1OrSvcz9X
         17Lqn9RcGLeKgVGlbOj7jxZvaFiIUAlJkBEKcCW7nrIecEHhKgxfvMATLyM1hJ106zsH
         78CYKaI/7h4eO61zXWlBU1d262l71a5kUYQz/vRQ8A+bHI/T381u0BLk0/sEXwSh+2+W
         7inA==
X-Gm-Message-State: ALQs6tAzx32/qNYiGtrmaYLwAHc0nhoyhEboJ/f+jOGmO5Di4OeBrnXn
        nQkZ0vV344WN1V2BNkQS7QBjM9q1a7hvvWL1qZM=
X-Google-Smtp-Source: AB8JxZoUzwp7uRWbzkVlac3/9VBiziX6qXOeRa9uKdpNuzxnN4N2uS6fwhKbzzHSVTKhewd6nwJd6AAuJai4wj6hZZI=
X-Received: by 2002:a1f:a54:: with SMTP id 81-v6mr17071391vkk.184.1525281607619;
 Wed, 02 May 2018 10:20:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Wed, 2 May 2018 10:20:07 -0700 (PDT)
In-Reply-To: <20180502160056.5836-1-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com> <20180502160056.5836-1-benpeart@microsoft.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 May 2018 10:20:07 -0700
Message-ID: <CABPp-BEvJdLt-GvGYCo-XrafHDDTm0Sb5AWfrbffqo8vF=8Y0Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] add additional config settings for merge
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

Thanks for your persistence.

On Wed, May 2, 2018 at 9:01 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> This version incorporates Elijah's fixup patch and is now based on
> en/rename-directory-detection in next.

en/rename-directory-detection was in master but reverted.
en/rename-directory-detection-reboot is the new series, and isn't
quite in next yet; Junio just said in the last "What's cooking" that
he intends to merge it down.  However, the two series are obviously
similar, so your rebasing even onto the old one does cut down on the
conflicts considerably.  Rebasing this latest series onto
en/rename-directory-detection-reboot leaves just one minor conflict.

Anyway, I've looked over this latest re-roll and it looks good to me:
Reviewed-by: Elijah Newren <newren@gmail.com>

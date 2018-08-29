Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235441F404
	for <e@80x24.org>; Wed, 29 Aug 2018 16:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeH2Uxb (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 16:53:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40969 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeH2Uxb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 16:53:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id s15-v6so2578592pgv.8
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 09:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VkL+eh7RvglPUuzBbcWX7KqL7hP/QvsgIJYJ1w9YKZU=;
        b=HFO0Vz3Lo4AodYoK32X5FPQIfshfDhT/qhft8L3WuGTBrtGMcnc94oa6Bi1sTJPuSe
         y+uTP6u78NHuXEgpHkqQ15KvH/QxLL5YZSR8M247usk/Ay6cI82z7P9+76/3GMbbeBj3
         f3YK+yLe/XjruOPAvekldes69lZmkEyDVtCfWv+8/sDdRygV+82YPz9CCj2Sl5M0ANH1
         gSnrHXGfwruPVwrImpNp0m5EWRS2CGQF7+TB0t0kXa8tKN/4R+2p+ptv/48q7eoZTna9
         DPx4rXuVk61uyhgH23LQrlFcu1qRLwsd1RFSnXGbelg6LmVahikf19IhxGP0XFX/Gjhf
         u8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VkL+eh7RvglPUuzBbcWX7KqL7hP/QvsgIJYJ1w9YKZU=;
        b=hwR5CcMCLPFci9Lvu48jKbZfXQ87r1WXYylVjZruFW5OzHlqHb4uZ7X56LX9a96A80
         myXNETKy1oZ3uEkQFODR05k7yWcZ5PagOg9gy52dlTjDgqyiKHSdtgaDn9+a4qZtQTmW
         6RLWy3QUQ50S2HmaHEG/s37ACUumj2S1a6/rmMd7CSQQUDOxEVakW0HEIZ0D+WjJzAoR
         JzZlOhbibuKwpqYa0lI0fBwlvMlHhMy88HdZcxQxpAWuM/alOg4NHEFjnqNoxXFYUK1S
         XRYEdaKDrWP4ybQ/DYPN4ut/AQpEgoy5atgKihXlCZc7j22zSNEY9FU2vvzuDU4CoqHM
         vvfw==
X-Gm-Message-State: APzg51CDY4W6JT9p6V3Yt3IC7gXNVGDLR1XzSCgKJGOYletQI8G7xkvW
        /985qHul5wxZtZZRhYRobHo=
X-Google-Smtp-Source: ANB0VdZnmsFiwni+Ks60FdpbMHIPn2Hz00PjwdGlseixLLlxtfd+kIt8SlN8AY+D8lcb/KhEGrl3Zg==
X-Received: by 2002:a63:5660:: with SMTP id g32-v6mr6260533pgm.227.1535561742581;
        Wed, 29 Aug 2018 09:55:42 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n79-v6sm14262568pfh.2.2018.08.29.09.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 09:55:41 -0700 (PDT)
Date:   Wed, 29 Aug 2018 09:55:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Tim Schumacher <timschumi@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v3] doc: Don't echo sed command for manpage-base-url.xsl
Message-ID: <20180829165540.GB170940@aiede.svl.corp.google.com>
References: <20180829134334.14619-1-timschumi@gmx.de>
 <20180829154720.20297-1-timschumi@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829154720.20297-1-timschumi@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tim Schumacher wrote:

> Subject: doc: Don't echo sed command for manpage-base-url.xsl

Cribbing from my review of v2: a description like

	Documentation/Makefile: make manpage-base-url.xsl generation quieter

would make it more obvious what this does when viewed in "git log
--oneline".

> Previously, the sed command for generating manpage-base-url.xsl
> was printed to the console when being run.
>
> Make the console output for this rule similiar to all the
> other rules by printing a short status message instead of
> the whole command.
>
> Signed-off-by: Tim Schumacher <timschumi@gmx.de>
> ---
>  Documentation/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Oh!  Ignore my reply to v2; looks like you anticipated what I was
going to suggest already.  For next time, if you include a note about
what changed between versions after the --- delimiter, that can help
save some time.

With or without the suggested commit message tweak,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thank you.

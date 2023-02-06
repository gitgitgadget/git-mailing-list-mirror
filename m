Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECBDC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 21:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBFVlK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 16:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFVlI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 16:41:08 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5027510F3
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 13:41:04 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h24so14679685qtr.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 13:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUvqcNAtRVgxM4PbdBsf4gKqNKBYrX7LRtU/MEx2tqc=;
        b=LTQd1Y9pv39vdbZfifjCZA84nuNfJkWpVwPt8CitKFObTtCoHZQRZRlp5jvkk9l9Eh
         qWsriLD77bR7GynaPdYIFeAwTFenNPojsQyRfwskWc5gcrtWKXMhU3yVzJvuXXPIdKcQ
         AJMqRlOFuN4ZaQzw+2E7SHILP9x4oHNWG7NoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUvqcNAtRVgxM4PbdBsf4gKqNKBYrX7LRtU/MEx2tqc=;
        b=ixAhakBRtWE8UFOgVvP1GmNpGn9+FqpIO+dxTYsh7PKJHPvAtsBjRKdmkd2KwdFL8D
         Wr1XAxEuv6PhyCoiQ+/ZblUTb5y4RQwbX9jEAn0sW/P0XdEut4JBP9lZdS6VpiO1SkhF
         kx/6BtTqeh8V2vBSXWJ51JQNOfyBu51bp4uSAKUm19h22QIryyV4lvuH/yqc4qPtwAtZ
         9xAFiuMTOTVnet+TqhuRQ/mOR4ueS2+GwqN9BMNh2s/BUil/+Q2TCmxSlPMk0K8u6gzS
         y5vzs8n2RmXVkcK0N94SPrsAtqCAVqVPyGYZFlVmI/0/fLMDtZSPDp2wSLXMSgBeis0d
         +Ijg==
X-Gm-Message-State: AO0yUKW0WxA0MiT9eqScX+N1GZnxCK1MDI0ZsX3cZSLHt968bN+Pmslj
        BN/N2YHH0Siw1uD7axjX4s/csg==
X-Google-Smtp-Source: AK7set8jfPnZNexl4kTZ0AsHfpsFvzzCoBGS68jfXRWnbrEYCG5Y/rwV5B6gOBEyp46Ua502h8yKJQ==
X-Received: by 2002:a05:622a:13cf:b0:3b9:a4ae:9d17 with SMTP id p15-20020a05622a13cf00b003b9a4ae9d17mr1908353qtk.3.1675719663403;
        Mon, 06 Feb 2023 13:41:03 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id u31-20020a05622a199f00b003b0b903720esm8093366qtc.13.2023.02.06.13.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:41:03 -0800 (PST)
Date:   Mon, 6 Feb 2023 16:41:01 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: The sad state of git.wiki.kernel.org
Message-ID: <20230206214101.fe6rismtfzv4k75n@meerkat.local>
References: <20230203182255.lqla3hsme6riy4w7@meerkat.local>
 <Y95BEaOGJy9uBHkG@coredump.intra.peff.net>
 <CAP8UFD1q7-XbX4C_NjyL7A-6n6Nc4MgSbUKnzQOiRyKRMtLv_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1q7-XbX4C_NjyL7A-6n6Nc4MgSbUKnzQOiRyKRMtLv_w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 04, 2023 at 03:03:16PM +0100, Christian Couder wrote:
> > > # Should it be archived as a static site?
> > >
> > > It's possible to turn git.wiki.kernel.org into a static site with a large
> > > header on every page that it contains historical archival information, with a
> > > link to https://git-scm.com/doc
> >
> > This would be my preference, just because some of the old content may
> > still have value. Some pages (like old gsoc stuff) would better redirect
> > to git.github.io, but it is probably not worth the time to even try to
> > classify pages.
> 
> This would be my preference too. I agree that some old content might
> still have some value. We could also move or redirect some old content
> to git.github.io, but I am not sure it's worth the time either.

Okay, here's what I have:

https://archive.kernel.org/oldwiki/git.wiki.kernel.org/

It's just a static scrape excluding all Special: and User: pages, and carrying
a very large "OBSOLETE CONTENT" warning.

The idea is that requests to git.wiki.kernel.org will be redirected to the
archive pages and thus hopefully preserve the content for historical reasons.

Unless someone objects within the next few days, I'll proceed with this plan.

-K

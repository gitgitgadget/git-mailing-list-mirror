Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE4B51F453
	for <e@80x24.org>; Tue, 22 Jan 2019 18:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfAVSXn (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 13:23:43 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:39516 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAVSXn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 13:23:43 -0500
Received: by mail-qt1-f178.google.com with SMTP id u47so28702114qtj.6
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 10:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=cZPjeUI2Plr6TtI9LICkn9SlORndtSklW3uTcHvkkKk=;
        b=LS9VcYxdHsGxPab4ixQ3IjUZ5LJFkPEfj6+Aef0tDdcmRcyghKlOaJ51n9ddwcYM92
         LRFE3NAM51kD6EnYRhLywF4PI2s8K+EdxturQ9NnEMH+tFyIxprgPmKdyB5bzYgtFCrd
         7Qka3/LJ+JfOQidfD7CJuEd8FIZfZoMSXkGTpSFv6RtXBaLVsYdpVA4LMJCzA8F51myN
         KPEAsEYU0BR1dkk6VoeM1AaX6LsK3oSh+vQF60erNRbU09Ur0QJ0VPWspasNwyMfHnOi
         Ez5mkguPaOHpkK6WAaOnSS7IKsccz0RZUXIU/6iEziLzQUdDpXBc+t3mGM5ALx7sqgMd
         mh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cZPjeUI2Plr6TtI9LICkn9SlORndtSklW3uTcHvkkKk=;
        b=f4x5zk2cOpfVpUJrWdffKJls5rEXa1+lea8oC3gt20DeIvJeKWAjgr5tPZDi7yisnm
         cxebvDKZx38f2D/YVx1dgazvUSmSsUABzHPZUlg0yMFfRLgz5hz6m1Kra/yDBpBOV4sE
         1Uw1SSRgpUIP4XUghgZn261TQ3tgzgj9NnBq823RRWljb+volxgINNBLGfubfJ5wPsMg
         tg1+yrgI0fP8djUMdLgIVmMM/H2vA3m+zGvcULk3kWGJJCOWm1FSi8Yx1T1BytipAeHp
         rFXLwMMOw2/NCdm3MEalmQ1WyI/t2HmZ0jVVnz4LZ71hD/WoKzuHT4f+lglnsRU6Gii4
         3zsg==
X-Gm-Message-State: AJcUukf8HHf6kDeQXQ2mQTrbXWDWwPb9bkIQTv0cPMDO18CUEe9aHgcL
        lbrdmPhQfVgd44Y+5zrFvzGYTGh7
X-Google-Smtp-Source: ALg8bN43SK5kvY6C3ZDy6sPDVN+ezeq2JkvxhaOPluKf9ue3F7kFacx5yMPv7N5x6Xn4bSa+kiQg/g==
X-Received: by 2002:ac8:95:: with SMTP id c21mr15851320qtg.201.1548181422107;
        Tue, 22 Jan 2019 10:23:42 -0800 (PST)
Received: from [10.0.1.23] ([98.122.160.2])
        by smtp.gmail.com with ESMTPSA id c202sm60150287qkb.19.2019.01.22.10.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:23:41 -0800 (PST)
Subject: Re: Contributor Summit Topics and Logistics
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190122075027.GA29441@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4dbbdd75-e71b-d6e4-123d-dddc7a9d8a67@gmail.com>
Date:   Tue, 22 Jan 2019 13:23:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190122075027.GA29441@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/22/2019 2:50 AM, Jeff King wrote:
> For people who want to try to join remotely, I don't think we're going
> to have a particularly fancy AV setup. But there should at least be a
> big screen (which we typically do not really use for presenting), and I
> hope we can provide some connectivity. I'll be visiting the venue the
> day before (Jan 30th) in the late afternoon (Brussels time) and I'll try
> to do a test run. If anybody wants to volunteer to be the guinea pig on
> the other end of the line, I'd welcome it.

I would like to join remotely, so I volunteer to do a test run. I'll 
need to wake up early, so let's set an exact time privately.


Topics I would like to hear about:

- commit-graph status report (I can lead, if I'm able to join)

- multi-pack-index status report (same)

- reftable

- partial clone

- test coverage report, usefulness or improvements


Thanks,

-Stolee


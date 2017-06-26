Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32AB207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 23:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbdFZXYX (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 19:24:23 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33708 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdFZXYW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 19:24:22 -0400
Received: by mail-vk0-f46.google.com with SMTP id r126so8395132vkg.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 16:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AFsjOAI3tzoes1wSprt+7t4vK70bqlSMi0pZXl2SQXY=;
        b=Pa0yELqLlCfeBo2WT02PalRtBUNGOYrEVoSfjIiM7gb5nkWxmAKVap1znieONjN6lT
         5JASgaawfwBt5oTDASe4oaTlYjdnh/woy1UzXawB0VQbqhzf2bRkNFI+hstjJMWcrjce
         k2OyxyUghRaqNRqg9Of6qpn5vZGzgTLR5XcrAd2G8ZI8iOVHahL5of3xOcrb1jjQzAsZ
         jt+0REqOt20kgvacImkpejmy0WX/OfgF2qOKTtj09Cw4fy88m+6481AuLQzqCwCwbVcL
         hPkmkmiKVBWQsmgLe6ibN9MWGheg37hIS1RMrsLcdpDaarLJNXTnDtjsPFh4hijt7OZz
         drug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AFsjOAI3tzoes1wSprt+7t4vK70bqlSMi0pZXl2SQXY=;
        b=J/rghqYsJ/5dfoKmotZcBTVbXB6gQUJWinPb4PTO4j+15zGzyDJGUhQmapv6nsMPil
         Rxqu2v9XRy6e+N+W3H0PnZlNYZI0ms3QL496us1uZLJerLJ0W3mtKlgQud5uuQamrdyI
         uvxITAjyojFrtaJbkDsI0fYu9jFFls40tjwXGnSbp+hyWhxXznymFN/8bs1vaRFIWVSE
         xKcU0diO+ae84U8zW2rfJtd1FTTtVY4gvX/FryNosDOTknWOK/zKL7HxUhg8CDUlvbjR
         MYoP9Y+O6aAp9SL1aPPhhEANeiifONoXGS/TAdgZu+mxYloEROjtQcLVRixQSfw84y2C
         8Ehw==
X-Gm-Message-State: AKS2vOwzE7lRWvHaekVlr45jFz3xT53PL4gNIVvxGXmPAFjRTe/cU55d
        TCLjwxT3tWvPudQZrgwuSQmKDbFxoA==
X-Received: by 10.31.234.3 with SMTP id i3mr1363858vkh.115.1498519461308; Mon,
 26 Jun 2017 16:24:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.77.139 with HTTP; Mon, 26 Jun 2017 16:24:21 -0700 (PDT)
In-Reply-To: <CAH5451n4XDdeAz4T7aAsaSC00hnZ53Gb7j0CSiTg4QLUZKvxXw@mail.gmail.com>
References: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
 <CAH5451n4XDdeAz4T7aAsaSC00hnZ53Gb7j0CSiTg4QLUZKvxXw@mail.gmail.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Tue, 27 Jun 2017 04:54:21 +0530
Message-ID: <CAME+mvXpjZUoKqfuLyQ_p9MLh1UJFpqhAWZBwi2qEM5kHHWwcA@mail.gmail.com>
Subject: Re: [GSoC] Update: Week 5
To:     Andrew Ardill <andrew.ardill@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2017 at 5:31 AM, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> On 20 June 2017 at 07:41, Prathamesh Chavan <pc44800@gmail.com> wrote:
>
>>    But as communicating between child_process is still an issue
>>    and so there was no simple was to current carry out the
>>    porting. And hence, a hack was used instead. But after
>>    discussing it, instead using the repository-object patch
>>    series will help to resolve these issues in this situation.
>
> Just wondering, does that mean that your patch series is dependent on
> the repository-object one? I saw some discussion around it recently
> but couldn't see it in the latest whats cooking so maybe I missed what
> has happened to it.

Sorry for such a late reply. In this update, and even in the latest update[1],
the patches aren't dependent on the 'repository-object' series.
But there are certain issues encountered which I aim to resolve
using them.

>
> Really enjoying your updates, by the way, they are very clear and show
> what looks like great progress!

Thanks a lot for this, and I hope to keep improving it. :)

Thanks,
Prathamesh Chavan

[1]: https://public-inbox.org/git/CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com/

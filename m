Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AED51F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeHMTmA (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 15:42:00 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34276 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbeHMTl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 15:41:59 -0400
Received: by mail-qk0-f181.google.com with SMTP id b66-v6so11463518qkj.1
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=g7TtNUtY7ZTp1xidsXOKHzs8FRoz0P6HIZ/6IaM/c2k=;
        b=QD0gUx7x2JvAnwmuYaxLFyu4bm5dqcua+8ApoJPHb/A/euIsBfg12txyOfAiK1bJpH
         kmesocTdbWkKPOfkdpEo/ejHkAaxAAdbgMXGTVaFhi5A1AjvwLHEh0spWXVnXg3BoOEI
         nZzJtdkxv9CIW049rkDE8nQmmm2LYiMWQkSp76H2qjZ9152Ck2OTVea/iqYsNWI9P/GT
         GVFv4BJM8CyZcg0T74Xm09tcblQa9HpYE0FLWyA8Tg0RMoYkFB0WpWBBVSU+mnn2rtpm
         WFKzZdviJ8ZLEbBfpaTp7f8HLi8LRkM4sqByIxolH+DaeZnhhpcC377foz2oSpODEt+Z
         3l9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=g7TtNUtY7ZTp1xidsXOKHzs8FRoz0P6HIZ/6IaM/c2k=;
        b=QY87xLa+sRzOfPVcy0Y4QvNpMoA0WjcXve5yV5Ce1+2xSV+/vXJvhiAwvvk+Tf4Hsr
         zH+rgM9rRhe7BRnLqJaNoJO7Jn+1HIWB7gTkUNR8+Qnikthklk0qE44CHk+dOxVHSrv8
         qUBa/T8y+AKsq3A4cLSeXqtYIs3f/78w8WL85yx6KzvBp+ZmsV4T2RNTkwLWbYRR6TW+
         P0XU4zZBH0NQaSLwAjOPMOm7NNbUO2KeaH9sA+ktICwUyUMPYY+P03V8WiGfYMR8bOaq
         4/erQVA/aoJGK3VfM8/mSqT+L/Hi44/Ts1+ZQ/Z4ZC4LfpGuIIEgnaAY414nyBlo+YVf
         XDIg==
X-Gm-Message-State: AOUpUlG+6re5GSsWgYs8VKGDY9QVgA9RCXw9QPfdrhotwld36QhKbyOH
        ZG4l6axoASfRBfFvE6dK6KvqrvkY
X-Google-Smtp-Source: AA+uWPx5vtlxXZhoFiPshCNzjO+rJb2XGRt+fFawEPL0tg5qmHk2DexxymmMU5q4ifa7elkPt9rJEQ==
X-Received: by 2002:a37:c0c:: with SMTP id 12-v6mr15938783qkm.59.1534179536101;
        Mon, 13 Aug 2018 09:58:56 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:e157:f8c9:3f38:e60? ([2001:4898:8010:0:ca8d:f8c9:3f38:e60])
        by smtp.gmail.com with ESMTPSA id r1-v6sm7838016qkl.85.2018.08.13.09.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:58:55 -0700 (PDT)
Subject: Re: Contributor Summit planning
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20180813163108.GA6731@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d5d3fe71-d52b-ac9b-d48d-d288b6569e5a@gmail.com>
Date:   Mon, 13 Aug 2018 12:58:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180813163108.GA6731@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/13/2018 12:31 PM, Jeff King wrote:
> For the past several years, we've held a Git Contributor Summit as part
> of the Git Merge conference. I'd like to get opinions from the community
> to help plan future installments. Any feedback or opinion is welcome,
> but some obvious things to think about:
>
>    - where, when, and how often?
>
>      Plans are shaping up to have Git Merge 2019 in Brussels right after
>      FOSDEM in February (like it was two years ago), with a contributor
>      summit attached.
>
>      Are there people who would be more likely to attend a contributor
>      summit if it were held elsewhere (e.g., in North America, probably
>      in the Bay Area)? Are people interested in attending a separate
>      contributor summit not attached to the larger Git Merge (and if so,
>      is there any other event it might be worth connecting it with,
>      time-wise)?  Are people interested in going to two summits in a year
>      (e.g., Brussels in February, and then maybe some in North America
>      later in the year), or is that diminishing returns?

I've only been to one contributor summit, but found it extremely useful 
in meeting community members face-to-face. I think the time spent was 
very productive.

I would be up for two meetings a year. I would expect that the variety 
of locations would allow a larger set of contributors to make at least 
one meeting a year. This may come at a cost of a smaller group in each 
summit.

>
>    - format
>
>      For those who haven't attended before, it's basically 25-ish Git
>      (and associated project) developers sitting in a room for a day
>      chatting about the project. Topics go on a whiteboard in the
>      morning, and then we discuss each for 30-60 minutes.
>
>      We could do multiple days (which might give more room for actually
>      working collaboratively instead of just discussing). We could do
>      something more formal (like actual talks). We could do something
>      less formal (like an all-day spaghetti buffet, where conversation
>      happens only between mouthfuls). The sky is the limit. Some of those
>      ideas may be better than others.

The one thing I found missing that could be good is to have a remote 
option. Not everyone can travel or can afford to do so. I wonder if a 
simple Google Hangout could allow more participation from the community, 
even in a passive sense (those still at their day jobs listening in). It 
could even facilitate remote presenters, if applicable.

> I hope this can stimulate a discussion on the list, but of course if
> anybody has private feedback about past events or future planning, feel
> free to email me off-list.

Thanks for starting the discussion early!

-Stolee


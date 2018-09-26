Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 636A41F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbeI0A5a (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 20:57:30 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:39500 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeI0A53 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 20:57:29 -0400
Received: by mail-wm1-f47.google.com with SMTP id q8-v6so3457856wmq.4
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 11:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JFro+3/nhcNf73TXMw3IOSGgHWpDZWic6SiTVV8XWCA=;
        b=NTmj8N3ou4KMOeaYhxT+zDNb7/eNqJT+OynW2hsW9gv2XjolVvJGx4Oy/Gg7IxNglE
         uvIylT2XP/R6Yl3YxEHiPdUj61Jju0zSPTQRaDXqlThdvSOlsuwvR0cEdym26yS/xokx
         6cdhpJ1tlqct2zZVWwrZp6CYgJEA8yDOUwm3ta8zYxNUqIEZcHfKWMriJ+cWmYaWBJGF
         5+YTfGeY1U1wW/PVOASpLj7ZXv9He6kw5un3Ow7o56kDnfT7blrd1Trn8KAjXNmekHxy
         acvuoafxnt6jG04UBj+tPdOkf5NKn4ZDftgrHiVr+7Nga0uEtEub0xvh2TSIm794pknE
         aQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JFro+3/nhcNf73TXMw3IOSGgHWpDZWic6SiTVV8XWCA=;
        b=czVRR7rlWEuFx9Rdzvf8HAREkuAYnq1YuLZOx4vx3wYxabWaieEUoKwOufzHniFn8M
         rSOqNjWBIO+T5aGSRGr9nb/RChvg8lX8RbNmpBswJgX/kGVEXxM1bdyEwGRkP8NDuFyc
         IJDVnhwfjvYlteTaMpTfClo8So160RRlnELbvUoJXrmdr8qgx0qFvILYRZ3mySHXy8Dh
         bH0eVAWlowJ4FtsKGwSSChS2cZr/XpU1BFQeNmPuwlcDJh5HlWH/gA5doVknYuGCgfXC
         2oAPWVbKBDvpyd5Hb8lTuqaaqCO/JkZQMrad/5HCi5Ypf1o8mXtJRvZO/OAfPkogh0i2
         6sRA==
X-Gm-Message-State: ABuFfojjK21evHMQRScD30W/N/MSue164g9VSy2HbWXA0mprk30IkHVA
        jCClqIxDQ735NIVITpvXIN0Ch11M
X-Google-Smtp-Source: ACcGV62iZ3M+Dlv6tSztgv/ijQ96xF7mo2z5BRWXqHSLBxRYiQ6/DgHB+L63V8f16SzJgmpc3jSWdQ==
X-Received: by 2002:a1c:4b08:: with SMTP id y8-v6mr5133595wma.89.1537987391180;
        Wed, 26 Sep 2018 11:43:11 -0700 (PDT)
Received: from localhost ([2.28.194.193])
        by smtp.gmail.com with ESMTPSA id c12-v6sm6027493wrr.6.2018.09.26.11.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 11:43:10 -0700 (PDT)
Date:   Wed, 26 Sep 2018 19:43:08 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Tuesday, Sept 25)
Message-ID: <20180926184308.GA2253@hank.intra.tgummerer.com>
References: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com>
 <d92f18e2-0bbc-e36b-123a-3ed3f44cf418@gmail.com>
 <b46d6363-1709-968e-105a-3f4e8a77155e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b46d6363-1709-968e-105a-3f4e8a77155e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/26, Derrick Stolee wrote:
> This is a bit tricky to do, but I will investigate. For some things, the
> values can conflict with each other (GIT_TEST_SPLIT_INDEX doesn't play
> nicely with other index options, I think).

Just commenting on this point.  I think all the index options should
be playing nicely with eachother.  I occasionally run the test suite
with some of them turned on, and if something failed that was always
an actual bug.  The different modes can be used in different
combinations in the wild as well, so we should get them to interact
nicely in the test suite.

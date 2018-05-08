Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D98E200B9
	for <e@80x24.org>; Tue,  8 May 2018 04:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750794AbeEHEAn (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 00:00:43 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:42178 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeEHEAm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 00:00:42 -0400
Received: by mail-pg0-f50.google.com with SMTP id p9-v6so17664592pgc.9
        for <git@vger.kernel.org>; Mon, 07 May 2018 21:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5eT9OGaEO7U1hYD1XAtPQnaKdd/GXTjJc5xe7nHzqMQ=;
        b=15SMB1o540nw5ERaQbRm92Lo6XtlW4bD+z0lweP+dQT+SYT86eiEFXcBZp/aPVYiZW
         zJq+2ztkwJ44xZHt9ImHGQiCvDvZoIb7GKKoUR40USRoAPzQNzPkWQoVZc32ncmwJoV8
         Ypy0f+W48vDJBCmUQqgX3ddb878ls928sd5ZBKCKwt9M+XksBhPEFPW700il0aLDXa2X
         VxH3i+R6Xxs6sD98sfQzpQc0AfVSQ4aVfFAYqi5caqa4WCorT7xTs1ji5O++igwqQIYs
         DNfDkMXi7G343kGMWxwQwh3PUuT69HD5LxNgce+w8ITa+tZCiPiyUwyz05L/Pn/sJ5Ae
         SdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5eT9OGaEO7U1hYD1XAtPQnaKdd/GXTjJc5xe7nHzqMQ=;
        b=IDxfc51n/O+IZWe9rFwv/cxMMe953qFG4P1qkI785zLKE8oK95DUJQ4tNSgYKnkzUn
         kQqEPCrB69RQwVH/D7vPHATPNKJnFl9A5gQMRxaWXxJMMLJ7ZXhaqwN/r7jkB2YNwo4f
         UhhN8ExwKlm+rJAcGsdlzTfoUZSIH/ePGpDLjY5GHfXkwNEOm0W3mHyBgftrHUko37jr
         +BktBKqFX4ZJc6NnVzTSWzNUCPWYPkqSgz8gMEINiNMjQ/e5WAZyttjErDK42ZC7RcG8
         Oqwrht2yhcgxS5NkJxIgPPJGV6NSRzSdiLlzEIApu6EO8b3jYkfphNqNhzU9TLCYYEVI
         EVKg==
X-Gm-Message-State: ALQs6tBsKRzgUwAHaDVRtWT4jIMzrJTeUnPSOvLu63lWDnTqqiAGp6bj
        2ZW07tWZdBDVHgmfqUAZnLo5WA==
X-Google-Smtp-Source: AB8JxZr5g80HTJznP826xXWp+qayGbUQU8xztm76GoG3HCLhC4euKKuNmb9E9OblW0egkM5zYyvatQ==
X-Received: by 10.98.12.202 with SMTP id 71mr38306780pfm.61.1525752039664;
        Mon, 07 May 2018 21:00:39 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:5812:c442:1cf0:dde1])
        by smtp.gmail.com with ESMTPSA id b26sm51258922pfn.73.2018.05.07.21.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 21:00:38 -0700 (PDT)
Date:   Mon, 7 May 2018 21:00:37 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GSoC] A blog about 'git stash' project
Message-ID: <20180508040037.GA2816@syl.local>
References: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 04, 2018 at 12:48:21AM +0300, Paul-Sebastian Ungureanu wrote:
> Hello everybody,
>
> The community bonding period started. It is well known that for a greater
> rate of success, it is recommended to send weekly reports regarding project
> status. But, what would be a good form for such a report? I, for one, think
> that starting a blog is one of the best options because all the content will
> be stored in one place. Without further ado, I would like you to present my
> blog [1].

Hi Paul, and welcome to Git! I am looking forward to reading your
patches and any additional writing posted on your blog.

> Any feedback is greatly appreciated! Thank you!

Do you have a RSS feed that I can consume in a feed reader?

> [1]
> https://ungps.github.io/
>
> Best regards,
> Paul Ungureanu

Thanks,
Taylor

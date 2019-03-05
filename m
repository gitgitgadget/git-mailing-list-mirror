Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7880C20248
	for <e@80x24.org>; Tue,  5 Mar 2019 21:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfCEV3E (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 16:29:04 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:38232 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfCEV3E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 16:29:04 -0500
Received: by mail-wm1-f52.google.com with SMTP id a188so3929954wmf.3
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 13:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p7fJue+VxJyOad9CkWRQj16oK+OBGJX2ZgJaMTpgGiE=;
        b=JfxuKK3PlmsqieIBci1+SkCT9K7hby0VDIicwEVK5cdhYJl0O3RYyfL7W3Qx788cIN
         xArJUDuk+5tlbBHGBENrC5AYDLbsjZzvXxQxn0pZUA6Ha5bopRqjtCbRmvCUxZgaRQFc
         iFDn08tFmN0+/KS6RAdMF8FQgwffKmWDH1cVF3Fpi8DyVdzPfiUJc4v81MLqXEBv4lbW
         br9lJLWYaGnm7tgH9EUHfM1NVyfEDjh4PuCUh3YG77G5UwIfVFwB4SO4RKCoyNvfE7UL
         Gjn3AwfmJUMTIrySNzpPvrG6EqA0VHYHOGiaP7tb4U9dsxw7ot9Uada70EGEB2bIzv0l
         w4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7fJue+VxJyOad9CkWRQj16oK+OBGJX2ZgJaMTpgGiE=;
        b=DcR3qJeFKfQ56Uuc6X0IdOHK4IhTj7hBhUx+wNSKQTOH6MgxdHDppAS7lS2RVxjVZK
         vCkzeQcgbIYY699GP0UNsRyTdgrU+G/yZhuk6peSzHiPU6oFzksuLVyRcjfx6VjsW1LC
         NZJXNNQeZnyKVQBLdPItNrQ/+jkST9RQ/sIDcLzC1hDuTOFFLuSKXPzAo+D/JBwlR/Ux
         Zx/Uv3Lp/TkZXLFHFU/6iGgyxdcJfm5i23dg3PdPneIuNN64vxOzhsTqjeh9+LwDeTnD
         o7LClow4uSVlDQUjCC1r9XxaL8kHGIUsRRZ5Z+kO5u4F80WVZEl7dfYBobtzYnxZVGaj
         UuOw==
X-Gm-Message-State: APjAAAWfy2nWmXVY+ZFpHVlEAoVeFz6dTjIHDD2QYNFr+/BQv3tTSJEH
        PAtd7bkdfkSyhUnZGYcAKgQ=
X-Google-Smtp-Source: APXvYqzIedXMF4N/x1/9s2K679jzES1qiW7XFC2HcaQlFew8J1rxf9FtS4AO2tZLxrZvs6mqFgC++g==
X-Received: by 2002:a1c:6684:: with SMTP id a126mr304306wmc.47.1551821342299;
        Tue, 05 Mar 2019 13:29:02 -0800 (PST)
Received: from localhost ([2.28.70.135])
        by smtp.gmail.com with ESMTPSA id a9sm767557wmm.10.2019.03.05.13.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 13:29:01 -0800 (PST)
Date:   Tue, 5 Mar 2019 21:29:00 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Sushma Unnibhavi <sushmaunnibhavi425@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSOC]:query regarding microproject
Message-ID: <20190305212900.GY6085@hank.intra.tgummerer.com>
References: <20190305080521.GB9308@hacker-queen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305080521.GB9308@hacker-queen>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 03/05, Sushma Unnibhavi wrote:
> I am planning to do a microproject on using unsigned integral type
> for collection of bits.If anyone else has not taken it up,I would
> like to work on it.

Welcome to the Git project!

We generally do not assign micro-projects to someone in particular.
If nobody has taken it yet feel free to work on it.  Reading through
the page for micro-projects [*1*], there's the following bullet point:

"Select a microproject and check that it has not yet been taken or
discussed by searching the mailing list. Public Inbox is your
friend."

Public Inbox is at https://public-inbox.org/git/, and you should
search through the archive there to see if anyone has started on the
project yet.

*1*: https://git.github.io/SoC-2019-Microprojects/

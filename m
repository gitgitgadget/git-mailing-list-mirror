Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B6212021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964840AbcKOXUx (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:20:53 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33706 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933957AbcKOXUw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:20:52 -0500
Received: by mail-pf0-f176.google.com with SMTP id d2so38636177pfd.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nETZWNu+US6GHOfsOjbmvzFCACIOe+7uo3aVFVad9Hk=;
        b=Q2/y0V3yh60THByfAtifB0k/Psj7Ucz+Gd7f5rdSzHdeKXuW7G9mwipvFnIFkXWA2k
         wdi5jHS3ItzEmc+muvCFHI4NbtvI9LzaVobs417FGuIV/vaMorQP9EKggAyK9wnW0S0q
         zA1DhfzPQDWPV4BwclHSuAuIDUrC3ndRJqBuLLbu9R7xviuEUk0H1UJsfPz33aAzYOpu
         ToVRCms3uJ0rV0LG5TYAmhe/MDHvUEfnNeCK07V1U3BUUF//ftdcSz58zyhm/stwyuSr
         RmV6yLDJKWHuoCO52IKjGjyXk8Hru2YJ5N+IxEVOctijAak1orLdcBZT2yMYE+AZgZGK
         3Qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nETZWNu+US6GHOfsOjbmvzFCACIOe+7uo3aVFVad9Hk=;
        b=Fckoiew6A75SMAkxjfX/MMTqo0NYWphscFaPCB8J2C3fRezYyyAJxWdpsUmC5nKSon
         42klXo233vs3qvFECMSRnocTX5xVYHdYoe6I7ukgABLjE+qUpqZb3V/bgZxXKPMwfF52
         UwtInCBNTICZDcHmD1AS+HfWcBEZPUPeIHtEcQaN9adWXfpxFgehbv7UVFB9jIRVAIsU
         /pgLMga6WmlkLZ1n785PzPvzpBAccGl47vK6UX6o1ifeh8xKWj+4VJJnDrnNAwesMHxU
         pmPpxHp2LbopzUyBYBcO0EZb6bkQZefVsKM6WXdg/EftXO4v8v6RqVY/CFIJYEakpsbR
         Z4oA==
X-Gm-Message-State: ABUngvcJptrvj/pF9RaeIp7SNaFo4ng04/DqxfDxYpubOh6nBQVZ8jxyp6L0z7fafJEdprSL
X-Received: by 10.98.166.136 with SMTP id r8mr131347pfl.113.1479252051793;
        Tue, 15 Nov 2016 15:20:51 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:f0a8:aad3:5a98:9829])
        by smtp.gmail.com with ESMTPSA id d29sm29963507pfk.78.2016.11.15.15.20.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:20:50 -0800 (PST)
Date:   Tue, 15 Nov 2016 15:20:49 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        mogulguy10@gmail.com, David.Turner@twosigma.com
Subject: Re: [PATCH 04/16] update submodules: add is_submodule_populated
Message-ID: <20161115232049.GC66382@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
 <20161115230651.23953-5-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161115230651.23953-5-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15, Stefan Beller wrote:
> This is nearly same as Brandon sent out.
> (First patch of origin/bw/grep-recurse-submodules,
> will drop this patch once Brandons series is stable
> enough to build on).

I would be thrilled to see more reviews on that series :D

-- 
Brandon Williams

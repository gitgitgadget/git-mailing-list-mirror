Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B5B62013E
	for <e@80x24.org>; Sat,  4 Mar 2017 11:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbdCDLpC (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 06:45:02 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36797 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdCDLpB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 06:45:01 -0500
Received: by mail-wm0-f51.google.com with SMTP id n11so32625995wma.1
        for <git@vger.kernel.org>; Sat, 04 Mar 2017 03:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iYpWiv54aHFWTrq5vNA4J+FLuOPfU9J2mkNayASW1+s=;
        b=ihMQM8kx2/Oktb6STVgpPjO/kEHsLZ6hU61WHNd6LjQtjmwIdHrvhsjyFx0qiAaWiC
         AsSHvx3v0LslqH8KB6U/o9L/0K9njL1K4nzbBWze3dQ/7pKGfbzMEEFJpLNcXIYc9DRp
         jVDOWcXhjAipYekYjGvh95unW5HMuQiYBNMhf7c/nkWdGsPOX7MSlSChYABtvsjtbMIt
         xR9UhovYLYgsZl/5o/pXMhD3DqYm7NVEK29u3MH5Kwz2hnTy1jItNqSeBwMCQCBRwbfY
         SY/KwAQbOeTZFQS76XqcomvubziwwcQOksQkNYmRHgEDCzc7Xd1gLDUuqRT5X+Drw3LA
         u+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iYpWiv54aHFWTrq5vNA4J+FLuOPfU9J2mkNayASW1+s=;
        b=NtEa1dX6B3kkPryvsEflgOAHNViXL5HM6D8EF2+kdyZ0WW6evdXW2ra9GDVTzwSbP/
         oPTGd0SDosFUaST1Zn5s7XO+wPpgHFxUFvfTCM6NxZNu9wB61771K/5+u/aYw54GHOpN
         TJpE/prVsVux5+JYVcCCecsqTswxkTbjxIiMiayse0W+0VUyjp567w3w0L8X6Kg+n3pQ
         4Zkmi6mEKSwizSQ2JS5y+voqh4t8504gkobA86kXwHIndX56pfPStvGS1XHAPbLB1Bmv
         eDDsLRTdwe0yLchOZ6mJcsbsICUDBKAti6jHQsmQw1iXCgay80T69xJd4+9Qat3lXbw3
         Fung==
X-Gm-Message-State: AMke39kTaX/JhhdNj5hUc/OHTWhORCfkM5bQ9W8xK1TOH4aFO9GSnm0hl6lL2mOjspm7sQ==
X-Received: by 10.28.51.140 with SMTP id z134mr6788551wmz.55.1488627899511;
        Sat, 04 Mar 2017 03:44:59 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 198sm6771256wmn.11.2017.03.04.03.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Mar 2017 03:44:58 -0800 (PST)
Date:   Sat, 4 Mar 2017 11:45:04 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Valery Tolstov <me@vtolstov.org>
Cc:     git <git@vger.kernel.org>
Subject: Re: GSoC 2017
Message-ID: <20170304114504.GA27158@hank>
References: <5334661488625223@web28h.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5334661488625223@web28h.yandex.ru>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 03/04, Valery Tolstov wrote:
> Hi.
> 
> Want to participate in GSoC 2017 with Git.
> Can I choose "Make 'git tag --contains <id>' less chatty" as my microproject?

Feel free to choose any microproject from the list.  A good way to
start is to check whether other students already attempted the same
microproject before starting with it so you don't duplicate any
work. You can check for that in the mailing list archives, available
at [1].

[1]: https://public-inbox.org/git/

> Thanks.

Good luck!

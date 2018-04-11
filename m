Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41EF81F404
	for <e@80x24.org>; Wed, 11 Apr 2018 01:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeDKBhF (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 21:37:05 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:44388 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeDKBhE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 21:37:04 -0400
Received: by mail-pl0-f42.google.com with SMTP id b6-v6so167443pla.11
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 18:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hcmAY4ewsLpsg5tflOIRqNpAUhiKV+CIbR0Pnh3x0hY=;
        b=y7Dc8jOCb+lH4inpSO6Pu0JjuQw7naPN/UCPi2FWQ90iQf64WIjsN8ayjVU5JLNSQZ
         gTX3f9dOHzzzTJfOUWoqeEmJXl/iteCUaV8vKEPZFFvNnS05ih6HFt+/Qt6xEB27wUCk
         J12VwZ3lFOKO/lQ7cgnzEen8VRF7ORbvJ8LShSIV8yfppd1mbipSJ+TG4bb0tV51x74W
         Fdsnj1P7U5VBjAgNCseHfyZ5Vk42NhzkE7Z7eqzd5zI6Teg83FvFfmxnDJaek7X6IWGo
         3dUXZ0rrlYFs+1kyGE8bVISz3MeXplySaa33YBWoDYkojd3Yyw3ZvVHw/qsruOlVZr0X
         hIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hcmAY4ewsLpsg5tflOIRqNpAUhiKV+CIbR0Pnh3x0hY=;
        b=Z8V7SlZnU1Ccb1jRtDQQvQxa4V+LMLzbnmZEKheiWEOMLh29bDRiUbV/o9VL7MZnZl
         v8UW6rYOl34Zay2d8hc63OSS90usromjIZWfbClavZYom5TvcdAuGIoMDofib/60dNdt
         5XkkN2Se0cpvRC6Lm9An92aSUmvjIP6Q4Csp4YhxV545UqrfR83dPUaWswsxeQtBZ9dm
         2jSGaWpQRRtBwg1L81DnRmauZl5nclY3SVtBhj1wy7CaKkcBvTdahBXs/1tUtnBODQEu
         /yvuJx7MMuWD5xPl1Udw2YKN5q8N3US7AW/tcosQ6B5V7Ae6VxahXhDZVJSgVo11rprz
         N7rw==
X-Gm-Message-State: ALQs6tAnjjcETecPay/C3+CwqS9ayfZsc1ZdSL7kq/L17zPPUkZV0JLc
        MzIwe2sDxQLjWedCsZoxGJZHuA==
X-Google-Smtp-Source: AIpwx49hIK0drgdb7tKPmoUhQbdyCdZNpT7cL0mRJI/N5yZA5waZVJ6aNstHwNiF2VUU7y17plX7cQ==
X-Received: by 2002:a17:902:a9c2:: with SMTP id b2-v6mr2813420plr.181.1523410624013;
        Tue, 10 Apr 2018 18:37:04 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:1d0e:5efd:b490:f1b1])
        by smtp.gmail.com with ESMTPSA id r76sm56103pfl.24.2018.04.10.18.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 18:37:03 -0700 (PDT)
Date:   Tue, 10 Apr 2018 18:37:02 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     John Sullivan <john.sullivan@seeq.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes.Schindelin@gmx.de
Subject: Re: git-lfs question
Message-ID: <20180411013702.GA36736@syl.local>
References: <SN6PR06MB3824DE625D893166EEE35D358CBD0@SN6PR06MB3824.namprd06.prod.outlook.com>
 <SN6PR06MB382452FA81CAD6654E40EEB58CBD0@SN6PR06MB3824.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR06MB382452FA81CAD6654E40EEB58CBD0@SN6PR06MB3824.namprd06.prod.outlook.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 11, 2018 at 01:16:42AM +0000, John Sullivan wrote:
> Hello - I've seen instructions that say after installing git to also install git-lfs.
>
> But today when installing git I noticed that in the install options
> there was a default selected options stating "Git LFS (Large File
> Support)".
>
> Does this mean git is automatically adding git-LFS or just adding
> support for it and I'll still need to install git-lfs afterwards?

If you're using Git for Windows, it will install Git LFS as well by
default. Of course, you can opt-out of this if it's not something that
you want :-).

This is not the case on other platforms, to the best of my knowledge.


Thanks,
Taylor

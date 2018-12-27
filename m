Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62975211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 12:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbeL0MM4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 07:12:56 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35270 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730960AbeL0MM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 07:12:56 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so19937780qtc.2
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 04:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=r+KHc9GqqrY+lkpn0bSut/m3IXm2gsRGQDAnu3kkmKs=;
        b=PyO+0XAviQeVPQYRt8k3xe2MYpY+1CG4+KIQfqmWkdOvQ7GewD71K6rjaC8k6j1qlq
         hozxLoWnLtLNuO3DeThXv2CBlD/kSxDyT0fQoBbozm7tedFuNfWsU3buQIo1iRLOVxFU
         i4PuG2oZWhQDuAvYSMpPyHyeBv/nAo30ASUZpOhZ0y2SI+SYkdGMfpSn9AXYulXqnE1/
         b7XR5VvwwZnP4R6G4V84KDeucR9SBitOsbnhce/GYBaYSFvw17ey6yGQkVQbqHRmvv0q
         nUiqdr+EO24aVP2duL19yhi8QI77D4plCsw8Cr3M4dNgC+dp7nYElRjCOquIZ1Tf8JGB
         MTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=r+KHc9GqqrY+lkpn0bSut/m3IXm2gsRGQDAnu3kkmKs=;
        b=RJW4sCAw/y2J/f1HlOHhaqheQw2vQtcYiDOfl1n0kafsFyET0yyuK7MUs+XrGwCHax
         ze1lDLmDLr4xD5llVnn3SiaY9LK1ddf9yfwcFecPti+ZK2iBdkIfX5p2PIQmka6fnWPx
         5zHcFd9A04qJcayZwJKGWzwN9UFIAqtFEDk6+x9KrsY5iBZolCJ0Hiw+LdHbik+LKl5g
         1RsKvXcNP4gTHujBy/vUeJGkzKX2aZCxl6Ey4RgkHVma3rKCIcuJ0DxmBcqhVOC3koZ2
         CiippGsMxBTr6fSYPAc/fwtWch76puTpQSMQaOwE/Fp1DaJip44/tUS+Sj75C/ZEgXdk
         0rSA==
X-Gm-Message-State: AJcUukfC4k0PExQoZ2it6ZuCQJKnbw3qVw5ZYjkStLIcg2uj2kcUX//T
        O3eWeHUlbLhGdq724mKgh7E=
X-Google-Smtp-Source: AFSGD/WJaOGhWdJ8cIVQ5l9EgjqmO3hPJ6mkaCxdeDvPa8uc4V2XbOBWQAMWPV9iWbCYc9hU1y5DZA==
X-Received: by 2002:ac8:788:: with SMTP id l8mr21851525qth.384.1545912775111;
        Thu, 27 Dec 2018 04:12:55 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id 21sm21186087qkr.89.2018.12.27.04.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 04:12:54 -0800 (PST)
Subject: Re: [PATCH v1 0/4] HPE NonStop Port Commits
To:     randall.s.becker@rogers.com, git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
References: <20181226230523.16572-1-randall.s.becker@rogers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <efa03ee9-b84f-5221-d811-1ccda9132007@gmail.com>
Date:   Thu, 27 Dec 2018 07:12:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181226230523.16572-1-randall.s.becker@rogers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/26/2018 6:05 PM, randall.s.becker@rogers.com wrote:
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> This set of patches is a distilled version of the minimal
> set of changes to git that will allow it to run as client
> and server on HPE NonStop NSE and NSX systems. NSR systems
> are no longer under support so references to them have
> been removed. Each patch in this set is independent but
> required for correctness.
>
> Randall S. Becker (4):
>    transport-helper: use xread instead of read
>    config.mak.uname: support for modern HPE NonStop config.
>    git-compat-util.h: add FLOSS headers for HPE NonStop
>    compat/regex/regcomp.c: define intptr_t and uintptr_t on NonStop

These patches look correct to me. Just one question on patch 3 
(git-compat-util.h: add FLOSS headers for HPE NonStop).

I'm not able to comment on patch 2 (config.mak.uname: support for modern 
HPE NonStop config.), but it looks to be wrapped in a platform-specific 
'if', so should be fine if you are happy with it.

Thanks,

-Stolee


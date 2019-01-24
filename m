Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5C011F453
	for <e@80x24.org>; Thu, 24 Jan 2019 14:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfAXOJl (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 09:09:41 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42646 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbfAXOJl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 09:09:41 -0500
Received: by mail-qt1-f193.google.com with SMTP id d19so6594470qtq.9
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 06:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=IOTanWA1crD75phCa4ypnrVdpcx/erkPYMYwQNQJpS4=;
        b=gOsI43XXgzHpktVZKhnqhqzzSdcDJ5sRUnCfx0A0mAWwZBnaohxioz07JK0TOWPBWb
         ia7TvsI02pIT3sC6LM50LUhwkkUXSCGnFmqjkwvl64bAnbdaWEsSwtvEb1YVlcUHAaR+
         YcHZO1QIB1oaPBzNdYLHMCjvsu44V4MFSt7hvTB3MPUqytxxbnFRtopMAd6eSHEOK9db
         kCyc2k+Rz2Y6QoUr0dFQzQdaqOiISgm7FnmNOH5vi30JM88cYmA00g9zyHOUf/AqDl8P
         oeGiub6IBn9VlWvday1dmZSEHVdIRJAizJxk8e7mV9V9OaL0y+5az8H5DM5J3IzGMmDt
         JLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IOTanWA1crD75phCa4ypnrVdpcx/erkPYMYwQNQJpS4=;
        b=nYZxvFqXKLR86NdSe3rAu0hezaYn6J8Vge/95j54/HaBBXZ5P4FLbogzzf1Gev7Ksv
         frSca5ug9YuKepj7hPddPD+2gAXgMsIibjxa2+XiWwUGjzw/8IIq7+TamZNh4RCWBMHT
         W+gf8MQe9akzVfrDo1iiNV+GIFgxlMq2j+wDIDaVdhs1YIGs0CiDFabwIHyKJhP8g5Mt
         lwdkrnAiSfsOWwyN+sjMePsG9MB7qOOkaX43YG6OrFeClIaxgspES5zPudBh4hXDXHlB
         CFjDFhREynuMFgtnjNSMaRDZoLdix5JNYqtT0ITmUpk9Bfyr6EXMTUL7XZGvoovNHsHo
         04yg==
X-Gm-Message-State: AJcUukdR1NlWVgf3vcridHuyoLzLxcVkCGGLdMV72YJAphsgv6RvtyQi
        mBdbuPlaUpGK2TKIQSU/iTcb2DGE
X-Google-Smtp-Source: ALg8bN7xqxt64J1DbOm2mp0Air6F5UbzAFgL6vn/5KtwEL7nUDud0R1c78ab4/zcC8Hwh2TTiZs64A==
X-Received: by 2002:ac8:1c17:: with SMTP id a23mr7010493qtk.16.1548338980353;
        Thu, 24 Jan 2019 06:09:40 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:a010:321f:4bbb:82c4? ([2001:4898:8010:2:8944:321f:4bbb:82c4])
        by smtp.gmail.com with ESMTPSA id n11sm34500796qke.82.2019.01.24.06.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 06:09:39 -0800 (PST)
Subject: Re: [PATCH 0/9] drop some unused parameters
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190124131104.GA24017@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6a77030b-2101-8cbf-b5f8-aa8e9ec69687@gmail.com>
Date:   Thu, 24 Jan 2019 09:09:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190124131104.GA24017@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/24/2019 8:11 AM, Jeff King wrote:
>    2. Patches that drop unused parameters (i.e., code cleanup).
I've read the patches and they do exactly this, along with explanations 
of why they don't fit in the first category.

Thanks,
-Stolee

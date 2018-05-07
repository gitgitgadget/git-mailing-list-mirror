Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69AC200B9
	for <e@80x24.org>; Mon,  7 May 2018 16:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeEGQhN (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 12:37:13 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:36069 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeEGQhM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 12:37:12 -0400
Received: by mail-wr0-f170.google.com with SMTP id f2-v6so17596692wrm.3
        for <git@vger.kernel.org>; Mon, 07 May 2018 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XxPRc7vMqb88uBMLpOibyp0H3P33ZznF8bZQ717IWg0=;
        b=dUd32LzCoV7Z5cgy7s8cD3SmF0O47+bfgcM4ONkwmSblvi4JKEOrxoPcGV+ywmgP3i
         VLlu6SYb0GOxRG82a7BliIUDtdhQAw6t3oYsOe4v9QmarcgIOe0nX51BYU5LxRQp3uHx
         izxfJEoYtCdG7Ln9hqYGNWrapeT7kEh6K3v1ks52c9XRCeY6HMUXM8vVbFT5jJOr0EA1
         FWqgaWAYiG4cZIuEGoqy3iR2V9qhp8rFLo3iwe+SB3rexpRiUNpQkJjC3b/lQ09ha9au
         a6dVky5gNpDV3nupiUqfwHriXHKR7DGvqIFndaRZuz2DgweW6CGamg1/me7sHx7J2Z5r
         WBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XxPRc7vMqb88uBMLpOibyp0H3P33ZznF8bZQ717IWg0=;
        b=TDJEBa2A76nqXmOl72/RsiMJXAjalfGrn2UmDUw4Sj4byuvdveojMFF/MzEBg2LLUi
         Eb1vnkJf1ClcoGt2RuoeXXJJtZFPu+Hm035cECw+sIPHdWyO1bwRxL1fGDcDEnGrf9jH
         bkLXCVDpVIPHkX4uGYvshgNv/hQmRmWEc5do5JKuqM7P6icrRgfrwAlOwXsWjZtIIw/o
         1mn16iCs6Wqyv3mIpZjr2eBjmy56p4iFlq7sz/b0Su9gfXg8SiyhcSbbVCWvFZuhCIIZ
         O3uGBZJSQDb38ucZU3MqWCcDOztPACstcemEXqsWjIIQ8qFt1G7ENx3rUXZ6OAtL7S+Y
         5UJw==
X-Gm-Message-State: ALQs6tAydN4aLmEcCPnSuQ2d2BYuybdi0Gme4oi5ET4A4dkYupd+kYM6
        4/avTcOjBdrhgN0TEW2Mv2w=
X-Google-Smtp-Source: AB8JxZpaPpENtXX3otJhPoUGFDQyp1lWPrEIaateJiPNjs26OuAP0yq2cZcHGvc58SXPbUKIqKZskg==
X-Received: by 2002:adf:9bcd:: with SMTP id e13-v6mr33070935wrc.240.1525711031267;
        Mon, 07 May 2018 09:37:11 -0700 (PDT)
Received: from [192.168.0.103] ([92.55.154.57])
        by smtp.gmail.com with ESMTPSA id i30-v6sm45939577wra.38.2018.05.07.09.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 09:37:10 -0700 (PDT)
Subject: Re: [GSoC] A blog about 'git stash' project
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
 <ef15b063-c0e3-a5e9-7418-35d2d6b954f3@gmail.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <e8a81d38-57d7-2974-b5c7-3489e8ceb1fc@gmail.com>
Date:   Mon, 7 May 2018 19:37:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ef15b063-c0e3-a5e9-7418-35d2d6b954f3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 06.05.2018 16:22, Kaartic Sivaraam wrote:
> The blog looks pretty well written. I also read your proposal. It also
> seems to be pretty much well written. I like the way you explain things.
> Particularly, you seem to be explaining the problem and the way you're
> about to approach it well. The plan seems pretty good.

Thank you a lot!

> I just thought of suggesting one thing which might possibly be
> redundant. I think you're aware of the fact that the Git project has
> Travis-CI builds enabled[1] which you could take advantage of to ensure
> your changes pass in various text environments.
> 
> If you're interested in testing your changes (which I suspect you are),
> you might also be interested in 'git-test'[2], a tool built by Michael
> Haggerty. Unlike the Travis-CI tests which test only the tip of the
> change, 'git-test' would help you ensure that every single commit you
> make doesn't break the test suite (which is both a nice thing and is
> expected here).

I heard of it and used it a couple of times (for the micro-project and 
some other patch).

> Sorry for the off-topic info about the tests in this mail :-)

You shouldn't be sorry. Nothing was off-topic; I found everything you 
said to be helpful! Every feedback is welcomed!

> Hope you're able to achieve your goal as planned and have a great time
> during this summer of code!

Thank you one more time! I know it will be a good summer.

Best,
Paul Ungureanu

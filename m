Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD51C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 09:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C2176113B
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 09:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFWJ4B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 05:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJ4A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 05:56:00 -0400
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84a3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC0CC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 02:53:43 -0700 (PDT)
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lvzZl-0005fd-Mu; Wed, 23 Jun 2021 11:53:41 +0200
Subject: Re: Windows: GIT STATUS unreadable because the usage of RED textcolor
 on BLACK background
To:     Mirco Babin | Trip Software <mirco@tripsoftware.nl>,
        git@vger.kernel.org
References: <emb173d90c-68d0-44ac-9d8d-faf6aaa85444@mirconb>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <c74e78f7-a6d3-1c56-a3bd-f7981a672437@virtuell-zuhause.de>
Date:   Wed, 23 Jun 2021 11:53:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <emb173d90c-68d0-44ac-9d8d-faf6aaa85444@mirconb>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1624442023;a16ba019;
X-HE-SMSGID: 1lvzZl-0005fd-Mu
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23.06.2021 09:48, Mirco Babin | Trip Software wrote:

Hi Mirco,

> Whenever I use GIT STATUS in a Windows cmd.exe dosbox the output is
> unreadable. Because of the usage of RED textcolor on a BLACK background.

you can tweak the global default for having colors on/off via the
setting color.ui.

So for example doing

git config --global color.ui off

will turn colors globally off.

You can also tweak which colors are used, see color.status.<slot>. All
the git config options can be seen with git help config.

I've checked here and here the red is quite a bit brighter compared to
your screenshot, so I would not claim it is unreadable but that is of
course heavily subjective.

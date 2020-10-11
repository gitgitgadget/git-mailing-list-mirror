Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BE4C433DF
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 11:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53E82076E
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 11:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387714AbgJKLzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 07:55:08 -0400
Received: from mx009.vodafonemail.xion.oxcs.net ([153.92.174.39]:56170 "EHLO
        mx009.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387690AbgJKLzI (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Oct 2020 07:55:08 -0400
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Oct 2020 07:55:07 EDT
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])
        by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id 744BF607E31;
        Sun, 11 Oct 2020 11:47:22 +0000 (UTC)
Received: from [192.168.0.27] (unknown [86.56.168.15])
        by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 11FBC607DD1;
        Sun, 11 Oct 2020 11:47:17 +0000 (UTC)
Subject: Re: bug report: gitk crashes on git commit with emoji (utf-8)
To:     Tomek Mrugalski <tomasz.mrugalski@gmail.com>, git@vger.kernel.org
References: <1e06bde8-ae70-2653-5112-c97c9ee021da@gmail.com>
From:   Peter Oberndorfer <kumbayo84@arcor.de>
Message-ID: <3318fdd6-5709-1d3c-64d8-01d029803635@arcor.de>
Date:   Sun, 11 Oct 2020 13:47:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1e06bde8-ae70-2653-5112-c97c9ee021da@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-VADE-STATUS: LEGIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05.10.20 13:33, Tomek Mrugalski wrote:
> Hi there,
> 
Hi Tomek,

> $ ~/devel-ssd/git/gitk-git/gitk
> X Error of failed request:  BadLength (poly request too large or
> internal Xlib length error)
>   Major opcode of failed request:  139 (RENDER)
>   Minor opcode of failed request:  20 (RenderAddGlyphs)
>   Serial number of failed request:  3065
>   Current serial number in output stream:  3148

> 
> Is there a workaround I could try?
> 
I managed to work around this problem
by installing the Ubuntu package 'fonts-symbola'.

Testing with your repository, the Emoji is still not displayed correctly
but gitk does not crash anymore.

This issue (and the workaround) seems to be tracked at
https://bugs.launchpad.net/ubuntu/+source/git/+bug/1852985

> I'm willing to help with debugging the problem or testing patches.
> I'm not sure how long I'll be able to remain subscribed to this list
> due to the traffic volume.
> 
> Other than that, gitk has been rock solid stable for me and I've been
> using it for years. Thanks a lot for providing this great tool.
> 
> Tomek Mrugalski
> 
Greetings Peter


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2EDC38A2D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 16:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiJXQFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 12:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbiJXQFA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 12:05:00 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985F85AA19
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 07:57:44 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1E88ACA123F;
        Mon, 24 Oct 2022 10:55:27 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A7C5CCC831B;
        Mon, 24 Oct 2022 10:55:26 -0400 (EDT)
Subject: Re: [PATCH] fsmonitor: long status advice adapted to the fsmonitor
 use case
To:     Rudy Rigot <rudy.rigot@gmail.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
 <087d3fca-d01e-f36a-85f5-7e861e4d11ca@jeffhostetler.com>
 <CANaDLWKcF07=FQgT7ZTKmcgworH45YdNy8hy2faMBg3CGYEf+w@mail.gmail.com>
 <d696b07f-cfa9-be45-b6d2-adb72811a205@jeffhostetler.com>
 <CANaDLWJrBHAD4gu-h1sRgHXPbhf6YneJDF_+rhcRVDueKZfpLA@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <09b566b7-bdaa-af52-eb4f-63b2dbedcd89@jeffhostetler.com>
Date:   Mon, 24 Oct 2022 10:55:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CANaDLWJrBHAD4gu-h1sRgHXPbhf6YneJDF_+rhcRVDueKZfpLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/20/22 4:17 PM, Rudy Rigot wrote:
> Oooh, I definitely like where your mind is with this. I think it makes a
> lot of sense, there used to be one way to act upon a slow status, now there
> are a few, so I can see how any in-depth explanation here would add to the
> confusion for a user in a terminal who is just trying to get things done.
> And I see how the current messaging already kinda infringes on that.
> 
> Alright, I can write the first draft of the documentation changes you were
> mentioning. Heads up though: I'm going to need your tight review of it,
> because I'm not as completely comfortable with what each option does as I
> wish I was, so I worry I may write something accidentally inaccurate. I'll
> take the time to read up on it though, and then I'll try my hand at it and
> update it here, and let's take it from there if that sounds good.
 > [...]

yeah, i'm happy to help.  just let me know when you have a first draft.

Jeff

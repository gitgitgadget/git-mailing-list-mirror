Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59730C433E9
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 263D464E7B
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbhBDUfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 15:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240249AbhBDUfm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 15:35:42 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B8FC06178A
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 12:35:02 -0800 (PST)
Received: from [IPv6:2a01:c846:1980:2500:501a:5222:a7bf:779] (unknown [IPv6:2a01:c846:1980:2500:501a:5222:a7bf:779])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: andrewsh)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 528CF1F463A8;
        Thu,  4 Feb 2021 20:35:00 +0000 (GMT)
Subject: Re: [PATCH 1/2] gitk: refresh the colour scheme
From:   Andrej Shadura <andrew.shadura@collabora.co.uk>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     git@vger.kernel.org
References: <20190226110535.29172-1-andrew.shadura@collabora.co.uk>
 <20190302230228.GA26937@blackberry>
 <7e696805-4b80-cd26-aaaa-261a05ead964@collabora.co.uk>
Organization: Collabora
Message-ID: <9e3cef09-b98a-cd8a-ecba-fcb059137088@collabora.co.uk>
Date:   Thu, 4 Feb 2021 21:34:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <7e696805-4b80-cd26-aaaa-261a05ead964@collabora.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 04/03/2019 10:35, Andrej Shadura wrote:
> On 03/03/2019 00:02, Paul Mackerras wrote:
>> On Tue, Feb 26, 2019 at 12:05:34PM +0100, Andrej Shadura wrote:
>>> The colours gitk is currently using are from the basic 16 colour
>>> palette, and are a bit too intensive to be comfortable or pleasant
>>> to work with.
>>>
>>> Adjust the main colours (commit nodes, remotes, tags and one branch
>>> colour) to be slightly softer.
>>>
>>> Signed-off-by: Andrej Shadura <andrew.shadura@collabora.co.uk>
>>
>> Thanks for the patch, but I disagree.  I do like the change you made
>> to the tag colours, but the blue you have for the commit node circles
>> is pretty blah.  That needs a more definite colour.
> 
> I see.
> 
> 1) Would you accept the patch without that change?
> 2) What colour would you prefer (except the already existing one)?

>> Also, the "too intensive to be comfortable or pleasant" in the commit
>> message reflect a personal preference, and the way it is put seems to
>> me to be too intensive to be comfortable or pleasant.
> 
> Hmm, sorry if that came across not the way I intended. I was trying to
> formulate the thought in a way that would not be emotional or
> subjective, but I guess the end result was exactly opposite.

I’d be happy to resubmit the patch adjusted to your preference, only if
you gave me some more ideas on how you’d like to see it.

Thanks in advance.

-- 
Cheers,
  Andrej

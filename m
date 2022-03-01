Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B789C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 19:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbiCATiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbiCATiA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 14:38:00 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F2D6C1C3
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 11:37:18 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D90543F412C;
        Tue,  1 Mar 2022 14:37:17 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A742A3F4090;
        Tue,  1 Mar 2022 14:37:17 -0500 (EST)
Subject: Re: [PATCH 04/23] t/helper/fsmonitor-client: create stress test
To:     Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <9efdbe28223e371dc22b4ba32fc791729af5577a.1644940773.git.gitgitgadget@gmail.com>
 <ab3d1fc7-e63a-dff4-f373-a6ac32b8294a@github.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0baa2939-bf3c-b08b-2cfc-5a96be760b1c@jeffhostetler.com>
Date:   Tue, 1 Mar 2022 14:37:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ab3d1fc7-e63a-dff4-f373-a6ac32b8294a@github.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/24/22 9:58 AM, Derrick Stolee wrote:
> On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Create a stress test to hammer on the fsmonitor daemon.
>> Create a client-side thread pool of n threads and have
>> each of them make m requests as fast as they can.
>>
>> NEEDSWORK: This is just the client-side thread pool and
>> is useful for interactive testing and experimentation.
>> We need to add a script test to drive this.
> 
> I haven't gotten far enough in the series to know if you
> _do_ use this in a test eventually. If so, this NEEDSWORK
> could be replaced with a mention of a future change.

Right. I mainly use this test helper to hammer on the
daemon during interactive tests.  I don't have a script
to actually use.  I'm currently not sure what that would
look like given our test script framework.

> 
>> +	/*
>> +	 * TODO Decide if/when to return an error or call die().
>> +	 */
>> +	return 0;
> 
> This TODO could be cleaned up.

good catch.  thanks!

Jeff


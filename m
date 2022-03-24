Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDB7C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 20:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354267AbiCXUr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 16:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354259AbiCXUr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 16:47:27 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3519089CD6
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 13:45:55 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8E1FA3F491B;
        Thu, 24 Mar 2022 16:45:54 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0CC2D3F4836;
        Thu, 24 Mar 2022 16:45:54 -0400 (EDT)
Subject: Re: [PATCH v8 21/30] t7527: create test for fsmonitor--daemon
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
 <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
 <c8709da9457eb303132b5cad6a204a1de27aabc0.1648140586.git.gitgitgadget@gmail.com>
 <xmqqils3gort.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8c9e30be-5138-ecfe-5c37-4f91b4d3002f@jeffhostetler.com>
Date:   Thu, 24 Mar 2022 16:45:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqils3gort.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/24/22 2:59 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> I hadn't signed off on this one yet ;-)

Sorry, I started a recent rebase based upon your version
of the commits and it had your signoff in it.

> 
>> +is_value () {
>> +	test -n "$1" && test "${1::1}" != "-"
>> +}
> 
> ${var:ofs:len} is a bash-ism.  If you run this test under /bin/dash
> instead of /bin/dash, you'll likely see it fail.
[...]

I'll simplify the function as you suggested and send a V9 in
the morning after GGG's CI finishes.

Thanks
Jeff


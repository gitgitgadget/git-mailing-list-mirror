Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B50AC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 20:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244107AbiCXU3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 16:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbiCXU3K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 16:29:10 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FB3B82C7
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 13:27:37 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AE1BC3F47EE;
        Thu, 24 Mar 2022 16:27:36 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 37FBD3F4165;
        Thu, 24 Mar 2022 16:27:36 -0400 (EDT)
Subject: Re: [PATCH v8 21/30] t7527: create test for fsmonitor--daemon
To:     rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
        'Jeff Hostetler via GitGitGadget' <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, 'Bagas Sanjaya' <bagasdotme@gmail.com>,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>, 'Eric Sunshine' <sunshine@sunshineco.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
        'Tao Klerks' <tao@klerks.biz>,
        'Jeff Hostetler' <jeffhost@microsoft.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
 <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
 <c8709da9457eb303132b5cad6a204a1de27aabc0.1648140586.git.gitgitgadget@gmail.com>
 <xmqqils3gort.fsf@gitster.g> <075d01d83fb2$1506ded0$3f149c70$@nexbridge.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0deea44e-b919-81cb-d8bf-ebea4c9ba426@jeffhostetler.com>
Date:   Thu, 24 Mar 2022 16:27:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <075d01d83fb2$1506ded0$3f149c70$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/24/22 3:05 PM, rsbecker@nexbridge.com wrote:
> On March 24, 2022 3:00 PM, Junio C Hamano wrote:
>> Subject: Re: [PATCH v8 21/30] t7527: create test for fsmonitor--daemon
>>
>> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
[...]
> 
> May I request a bit of extra time on the -rc0 to -rc1 cycle for this? I have a feeling that while testing this is probably going to go well, I would like to have a bit of extra time for anything that might come up. There are a lot of moving parts to this series. Not being critical, but debugging scripts on my platforms can be a bit rough at times.
> 
> Thanks,
> Randall
> 

I'll simplify the `start_daemon()` function as Junio suggests,
so hopefully that'll reduce the amount of debugging that you need.

BTW, which platforms are you worried about?

Jeff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B77C4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 18:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLASxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 13:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiLASxp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 13:53:45 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE47BA7A8A
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 10:53:43 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 09F0BCA1253;
        Thu,  1 Dec 2022 13:53:42 -0500 (EST)
Received: from [192.168.4.22] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BC272CC8325;
        Thu,  1 Dec 2022 13:53:41 -0500 (EST)
Message-ID: <7ef9ed2b-101d-ab00-3126-3b23990b9b19@jeffhostetler.com>
Date:   Thu, 1 Dec 2022 13:53:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] Makefile: suppress macOS deprecation warning
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Stefan Sundin <git@stefansundin.com>, git@vger.kernel.org
Cc:     Stefan Sundin via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1422.git.1668888407433.gitgitgadget@gmail.com>
 <a3cfe081-1e68-edda-b797-e68356988046@gmail.com>
 <CAMDaVWGFi6CD+MMbWG=N57yyb8=k6AouB5h33NkKvs2q4UxRmQ@mail.gmail.com>
 <4e0ecd76-8bd3-c1c4-69ca-a2de4886f491@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <4e0ecd76-8bd3-c1c4-69ca-a2de4886f491@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/20/22 7:29 AM, Bagas Sanjaya wrote:
> On 11/20/22 09:14, Stefan Sundin wrote:
>> You are right, Bagas. I assumed, without actually looking it up, that
>> the new function had a higher-than-acceptable minimum macOS version
>> requirement. It turns out that the new function was added in 10.6
>> which is far better than requiring 10.13.
>>
>> Please disregard this patch and I will attempt to update the code to
>> use the new function instead.
> 
> OK. But unfortunately, I don't have any macOS machines handy, so I can't
> test your future patch.
> 
> Thanks.
> 

As I mentioned in another thread, I'm working on a solution
for this deprecated function.  As soon the CI builds finish
I'll submit it.

Jeff

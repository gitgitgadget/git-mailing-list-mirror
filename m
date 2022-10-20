Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8676C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJTUPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJTUPK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:15:10 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1E4C96CF
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:15:06 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 152F9CA123B;
        Thu, 20 Oct 2022 16:15:06 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B1367CC833A;
        Thu, 20 Oct 2022 16:15:05 -0400 (EDT)
Subject: Re: [PATCH v3 5/8] trace2: improve thread-name documentation in the
 thread-context
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
 <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
 <8cb206b76323e14d8e07f6cfb5aa482a47eb54c5.1666290489.git.gitgitgadget@gmail.com>
 <221020.86y1tafhjo.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <728716c7-15e2-00f6-e249-e8bb31142d34@jeffhostetler.com>
Date:   Thu, 20 Oct 2022 16:15:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <221020.86y1tafhjo.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/20/22 2:57 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Oct 20 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Improve the documentation of the tr2tls_thread_ctx.thread_name field
>> and its relation to the tr2tls_thread_ctx.thread_id field.
> 
> Good to see this split off, thanks!
> 
[...]
>> + * the name of the thread-proc function).  For example:
>> + *     { .thread_id=10, .thread_name="th10fsm-listen" }
> 
> I think the example is missing a ":" after the "th10", i.e. it should be
> "th10:fsm-listen" per the code in 6/8:
> 
> 	strbuf_addf(&buf, "th%02d:", ctx->thread_id);
>          [...]
> 

oops.  :-)
good catch.

i'll fix up and resend, but will wait a bit for any other comments.

Jeff

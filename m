Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC74C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 13:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbiEYNpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiEYNpt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 09:45:49 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA2560D86
        for <git@vger.kernel.org>; Wed, 25 May 2022 06:45:48 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 98C1C3F4118;
        Wed, 25 May 2022 09:45:47 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 32F5B3F4114;
        Wed, 25 May 2022 09:45:47 -0400 (EDT)
Subject: Re: [PATCH v7 26/30] t/helper/hexdump: add helper to print hexdump of
 stdin
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
 <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
 <6f2e935f148e826609153378751c04807858e76c.1653336765.git.gitgitgadget@gmail.com>
 <xmqqk0acosks.fsf@gitster.g>
 <1fe2e843-20d1-4ea9-7ea2-c05330da17c2@jeffhostetler.com>
 <xmqq7d6ahfl3.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <bb500f0f-7608-e965-1616-6d23d81ab7c9@jeffhostetler.com>
Date:   Wed, 25 May 2022 09:45:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq7d6ahfl3.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/24/22 3:54 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> Would you prefer a send a V8 or would you be willing
>> to push a fixup commit on top?
> 
> If "test-tool hexgrep" does not turn out to be a better solution,
> and if there is no other changes needed, then I do not mind locally
> amending, but I'd rather avoid touching a middle step in multi dozen
> patch series myself if I can.
> 
> Thanks.
> 

That's fine. I'll fix it and send V8.
Thanks
Jeff

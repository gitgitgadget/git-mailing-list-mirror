Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45448C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 19:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbiLNTJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 14:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238625AbiLNTJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 14:09:28 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E782A96E
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:09:27 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F41DACA128D;
        Wed, 14 Dec 2022 14:09:26 -0500 (EST)
Received: from [192.168.4.22] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D0713CC82F6;
        Wed, 14 Dec 2022 14:09:26 -0500 (EST)
Message-ID: <3fc9fa4f-9904-61a5-2b06-465e184d7c15@jeffhostetler.com>
Date:   Wed, 14 Dec 2022 14:09:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: What's cooking in git.git (Dec 2022, #05; Wed, 14)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqiliewbje.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqiliewbje.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/14/22 4:59 AM, Junio C Hamano wrote:
> * jh/fsmonitor-darwin-modernize (2022-12-05) 1 commit
>   - fsmonitor: eliminate call to deprecated FSEventStream function
> 
>   Stop using deprecated macOS API in fsmonitor.
> 
>   Will merge back to 'next'.
>   source:<pull.1436.git.1669991072393.gitgitgadget@gmail.com>


Stefan Sundin noticed a typo in my commit message:
 >Typo here, MacOS 13 is Ventura not Ventana.

I'll send a V2 shortly (and it will include your paragraph
about Apple and deprecated APIs).

Thanks,
Jeff

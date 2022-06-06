Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169A0C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 17:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiFFRbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiFFRbj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 13:31:39 -0400
Received: from nmsh7.e.nsc.no (nmsh7.e.nsc.no [148.123.160.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAF01A45E6
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 10:31:38 -0700 (PDT)
Received: from [192.168.1.110] (unknown [194.19.73.58])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: joak-pet)
        by nmsh7.e.nsc.no (smtp.online.no) with ESMTPSA id A41EEE609A;
        Mon,  6 Jun 2022 19:31:35 +0200 (CEST)
Message-ID: <592c0133-d6f3-3376-0fe7-3633f3a91377@online.no>
Date:   Mon, 6 Jun 2022 19:31:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5] git-prompt: make colourization consistent
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
References: <20220604161333.54627-1-joak-pet@online.no>
 <20220604192606.176023-1-joak-pet@online.no> <xmqqzgipah7n.fsf@gitster.g>
From:   Joakim Petersen <joak-pet@online.no>
In-Reply-To: <xmqqzgipah7n.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.201
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/06/2022 18:29, Junio C Hamano wrote:
> Joakim Petersen <joak-pet@online.no> writes:
>>   * If the local tree has new, untracked files and there is nothing in
>>     the stash, both the '%' and the    short upstream state indicator
> 
> looong space?
> 

That is quite the long space indeed, I'll get that fixed.

>> If the user is in a sparse checkout, the sparsity state indicator
>> follows a similar pattern to the short upstream state indicator.
>> However, clearing colour of the colourized indicators changes how the
>> sparsity state indicator is colourized , as it currently inherits (and
>> before the change referenced also inherited) the colour of the last
>> short state indicator before it. Reading the commit message of the
>> change that introduced the sparsity state indicator, afda36dbf3b
>> (git-prompt: include sparsity state as well, 2020-06-21), it appears
>> this colourization also was unintended, so clearing the colour for said
>> indicator further increases consistency.
> 
> Here, after explaining how bad the current situation is, like the
> above, is a good place to say what we do, i.e. "teach indicators to
> clear after themselves".

I'll add a clear statement of what this patch does as well.

> 
> Nicely written.
> 
> Will queue.
> 
> Thanks.
> 
Alright, great!

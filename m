Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB707C6FA8F
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 12:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjH2Mpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 08:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjH2MpI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 08:45:08 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23640EC
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 05:45:04 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 36AF4CA1285;
        Tue, 29 Aug 2023 08:45:03 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:b47d:7e31:21b3:e66c] (unknown [IPv6:2600:1700:840:e768:b47d:7e31:21b3:e66c])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D7E29CC838C;
        Tue, 29 Aug 2023 08:45:02 -0400 (EDT)
Message-ID: <2ea5c2aa-64bb-adc0-4145-470321a5c8d8@jeffhostetler.com>
Date:   Tue, 29 Aug 2023 08:45:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Strange diff-index with fsmonitor, submodules
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
References: <20230829005606.136615-1-jonathantanmy@google.com>
 <xmqqcyz6fxvf.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqcyz6fxvf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/28/23 9:20 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>> There is a strange interaction where diff-index not only produces
>> different results when run with and without fsmonitor, but produces
>> different results for 2 entries that as far as I can tell, should behave
>> identically (sibling files in the same directory - file_11 and file_12,
>> and both of these filenames are only mentioned once each in the entire
>> test).
...
>> I'll continue investigating this myself, but does anyone know what is
>> going on?

Just a quick ACK. I'll take a look.

Thanks
Jeff

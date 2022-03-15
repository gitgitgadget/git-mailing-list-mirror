Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97B4C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 18:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343893AbiCOS1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 14:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiCOS1U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 14:27:20 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD1E583AB
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 11:26:07 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B51DF3F414B;
        Tue, 15 Mar 2022 14:26:06 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1003:b8de:e273:b0e7:6a1e:4c01:1162])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8709A3F40F3;
        Tue, 15 Mar 2022 14:26:05 -0400 (EDT)
Subject: Re: [PATCH 16/16] fsmonitor-settings: simplify initialization of
 settings data
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
 <432f9ff9d92ff55216555864cb3571c94a2c6db9.1647033303.git.gitgitgadget@gmail.com>
 <xmqqpmmoqpp5.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <33a9f751-6254-9b3e-6eb7-7844ac664e00@jeffhostetler.com>
Date:   Tue, 15 Mar 2022 14:26:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqpmmoqpp5.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/14/22 3:49 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> fixup! fsmonitor: config settings are repository-specific
> 
> 
> Let's kick part2 out of 'next', and replace it with a corrected set
> of patches and have people review them, this time for real, before
> merging it back to 'next'.  I just do not get the good feel that the
> series was adequately reviewed---if we have this many "oops" fixups
> needed after getting merged to 'next'.

Yeah if you haven't merged part2 to master yet, wait and i'll
send a V7 of part2 that squashes in these fixups.

and addresses any other comments on part2.5 itself.

Thanks and sorry.
Jeff


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DE2A1F51C
	for <e@80x24.org>; Tue, 22 May 2018 00:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbeEVAIr (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 20:08:47 -0400
Received: from avasout01.plus.net ([84.93.230.227]:57233 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeEVAIp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 20:08:45 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id Kur5fUtFsV3GyKur6fvtJL; Tue, 22 May 2018 01:08:44 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=EIQoLWRC c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=uYPabTyhkuUQBGZ3TPwA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: symbol string_list_appendf() unused
To:     Junio C Hamano <gitster@pobox.com>
Cc:     martin.agren@gmail.com, GIT Mailing-list <git@vger.kernel.org>
References: <d203f6ef-f684-cf6b-07b0-553b6b79e189@ramsayjones.plus.com>
 <xmqqvabgzhjr.fsf@gitster-ct.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <50d629b9-bf89-77af-a1ee-6175745c5e42@ramsayjones.plus.com>
Date:   Tue, 22 May 2018 01:08:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqvabgzhjr.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCjqshwLvLC6Vj69efiQ6KteX9704ZmS7Bdri0NJICa7w3T5nrmqww7EGG5TEFGyZFR5TGmFU8o7IkablEH1vcpwXCwSzbi0YMAIBZZJk9W4V8CI/nl7
 9RLgdkI8KPnw4umIC0ewYZ98fe9NIOP7EO1bL9ff+DDAZ0VpeNeYn1PhfBDBMRnntvowwSfsG46l2g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/05/18 00:59, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> I strongly suspect that I haven't followed the discussion on
>> the list closely enough, but your 'ma/unpack-trees-free-msgs'
>> branch in 'pu', seems to define string_list_appendf() but then
>> never call it. This is despite commit 40ebd6c7b0 ("string-list:
>> provide `string_list_appendf()`", 2018-05-20) claiming that:
>> 'The next commit will add a user'. ;-)
>>
>> Have I missed something?
> 
> Yes, I pushed out a tentative "how about doing it this way" update
> that goes alongside his version, making some solutions (including
> the function you found) he had obsoleted, yet without removing
> them.  That is what you saw on 'pu'.
> 
> There is a reroll by Martin that ties all the loose ends.

Ah, OK, sorry for the noise.

Thanks!

ATB,
Ramsay Jones


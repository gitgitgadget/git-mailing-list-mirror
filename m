Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49FB41F453
	for <e@80x24.org>; Thu, 27 Sep 2018 15:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeI0Vfk (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 17:35:40 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:41052 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeI0Vfk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 17:35:40 -0400
Received: by mail-qt1-f181.google.com with SMTP id m15-v6so3117577qtp.8
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 08:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=szBOIpPyf1Jp7lSz8QNFldEEDU8qrhXiP2QABaEVM/M=;
        b=TomSsk0w3yxoivCCGRHSAi5F24pZqb2QjhEGgNU6ovzAb2Npe54myj1yreY56PGflm
         gTq8jVTHcqpYuR7hILbuJke3kwABptyoPgD8WrvCUGQfrIcb0iDLvCHiZv/kmDikwBbO
         hRrMDYi0BmfX+tYodW89+deFlyC2EbvlEacpZZYgVRJ+DzmlMzcWqEM6fiRujoVzDce9
         Vrz6wvCD/X158x+p9UJ4QeetBKC/+bbujfkbal3dddnLVgPWXdgImu0T/31bTeLQl4BB
         tL4ei5evbLzhoszDWD96XKpV05ZXZY66TWlvpUhvANMscJSn5EUV5RB44HvNEgmLRvzj
         Gk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=szBOIpPyf1Jp7lSz8QNFldEEDU8qrhXiP2QABaEVM/M=;
        b=W8c2qXRLUMpuSIjOlRfJiWiZhcRQVaYWzbhJMrw3r1bN3wJetAOO4UA98hko14EO1h
         aC/CcrmCrSOE4x+qQ1uSkFJXnW3ZT0jzYOEd6FcxHLSUpHHG4YS7uQfZrGS+dnW+XXGn
         xM0B1K3CrKqxDK1sDNdXgd5OW7wEI9Yug+TO8FGQAvq1hMl06Ilkj8qJNUFy8kH5/HGM
         CDPj7uiH6GKM0KZy4fmo4Bt7gq6/xmUAa3666MSjW3pAwT0sAouGon3D4Cm+2TAZzS+0
         3A1OO2/C2LUNYMCuBQeSyg3R4Vmsc8w7ov6XwUzgjrRxI3FhmRCruQjrYTRuWLuOg9s+
         uUIw==
X-Gm-Message-State: ABuFfoh4JOiNRJcev2Lgfj4mgHTakvs31O8Bx3RonAlgxkjQbsEsc0Hs
        4bF4+Jyy6Lw79CpUYBQIZQ+h0l4M
X-Google-Smtp-Source: ACcGV61PxQzuQUN2TiWeoXRtopjcImu9yqjEY5c9QydrU6CsATotEvJUdU+qyDgMIi1MFppcyfG+Rw==
X-Received: by 2002:a0c:f1cd:: with SMTP id u13-v6mr8342967qvl.114.1538061415036;
        Thu, 27 Sep 2018 08:16:55 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1455:e436:6b50:1b07? ([2001:4898:8010:0:fd8a:e436:6b50:1b07])
        by smtp.gmail.com with ESMTPSA id f184-v6sm1300185qkc.23.2018.09.27.08.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 08:16:54 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Tuesday, Sept 25)
To:     Ben Peart <peartben@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com>
 <xmqqtvmckum8.fsf@gitster-ct.c.googlers.com>
 <c805d8c5-e605-3db8-9e57-0988c635c3df@gmail.com>
 <6e9e1cb6-8c26-b996-dd6b-411592458f20@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ff1d5836-c8a1-69a6-0f7a-815187ec16a7@gmail.com>
Date:   Thu, 27 Sep 2018 11:16:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <6e9e1cb6-8c26-b996-dd6b-411592458f20@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/27/2018 11:14 AM, Ben Peart wrote:
>
>
> On 9/26/2018 2:44 PM, Derrick Stolee wrote:
>> On 9/26/2018 1:59 PM, Junio C Hamano wrote:
>>> Derrick Stolee <stolee@gmail.com> writes:
>>>
>>
>> Perhaps removing the middle columns of data and just "<sha> <num>) 
>> <line>" would be easier? We could also remove tabs to save space. For 
>> example:
>>
>> builtin/remote.c
>> 5025425dfff  864) return error(_("No such remote: '%s'"), name);
>>
>> commit-reach.c
>> b67f6b26e35 559) continue;
>> b67f6b26e35 569) from->objects[i].item->flags |= assign_flag;
>> b67f6b26e35 570) continue;
>> b67f6b26e35 576) result = 0;
>> b67f6b26e35 577) goto cleanup;
>>
>> ll-merge.c
>> d64324cb60e 379) marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
>>
>> remote-curl.c
>> c3b9bc94b9b  181) options.filter = xstrdup(value);
>>
>> This does still pad the data by a bit, but should be more readable. 
>> Most "uncovered" code will be indented at least one level.
>>
>> We do lose the author information, but keen readers could identify 
>> code they are interested in by filename and then look up the commit 
>> by OID later.
>>
>
> I personally find the author data very useful as it makes it trivial 
> for me to scan for and find changes I'm responsible for. Just scanning 
> the output of the mail and looking for file names I may have changed 
> lately is much more laborious - meaning I'm much less likely to 
> actually do it :-).
>
> Perhaps a reasonable compromise would be to put the author name once 
> with the block of changes (like you are doing for the file name) 
> rather than on every line that changed and wasn't executed.
>
I've been playing with an extra footer that gives the 'git log 
--oneline' output for all commits mentioned in the line-by-line summary. 
While it isn't right next to the code, it would be something to look at 
if you only have time to check "Are any of these lines mine?"

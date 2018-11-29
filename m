Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7785211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 14:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeK3BOf (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 20:14:35 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35424 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeK3BOf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 20:14:35 -0500
Received: by mail-qk1-f194.google.com with SMTP id w204so1102493qka.2
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 06:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1qijSN9/ZuC80S2WtV25CXEOurW0iEmujhFIyre0d2k=;
        b=uX8oS3fLkstZGmp8mtIEYPAc76hmUe66Bu+/C4mX/KmNn2C68bSZUS9o/hZhRjJOiV
         JuAUeFXJ7TRxNsLPwr+IOGcazH3Whq8FSRwiXsi0UAuIznMm3xmef6HNC4d+GJTyG3us
         W8CltGXkAFpqgcCgrB3d1Xy+2J1QH3r1QnlTf8+qENC/glC7nkDJTJ+ztp/aTqope5Uw
         GfN7yjz/r5ulTPtpQEeOrDIKG3K4bQwjryo8wAbQsDnQrZP7qaRtZ/gdDuxOkvMIW6DH
         7qna21YfoYCRa3LdhaJ2GcNlQIWf2nApgzsN2nzdk3vajf+jl7/wjpNQNCwFK29aPjIA
         SxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1qijSN9/ZuC80S2WtV25CXEOurW0iEmujhFIyre0d2k=;
        b=oa0CsHX3rUd1bv1iWZVBoXoB62PCKsg2rRx5lwg3vMhWqaqJHq0hQKnsJRvviG/ein
         Kv/6CY3owKhbHB640PzxfTH03Fxe/D4NXFsDZ2xISNQr9261tX86xNrsFkFM0rg4s+f8
         AGpGoTxC2YmouTZVgbVa2s7S21NfYp88+GVDIg7qzofUM+R7nCuntbLrbjoKbQDvie7I
         7q1mwbbUeaVaokkiQYso+J3A9JVjZNqAZ2N/9GB/r7CZAiB/XDT0SUsu4yUVI5VxGKBq
         yEY1ySNmCqoCYJy61HqAFSdZN6ht8zybjc/uab5ZJhwyCjEkSjU2Css8XI/J9YaT6gsL
         5N2A==
X-Gm-Message-State: AA+aEWZIARCOt7FZVRJccWlipQgH5SSVZWroJ8+C9XT3dHSguEBUmJZ6
        +4Il5+3Vxc7OOMxcDN00Z5A=
X-Google-Smtp-Source: AFSGD/UUlXUiclVk9BBloYtuP+pWd5Yb2sJIdAAaQ5Wltwx0fjogUnfozIuiSl8O8ncUY5KbkgcKcw==
X-Received: by 2002:a37:a44e:: with SMTP id n75mr1476498qke.244.1543500545727;
        Thu, 29 Nov 2018 06:09:05 -0800 (PST)
Received: from ?IPv6:2001:4898:4070:37:c8c1:fce7:80c6:13be? ([2001:4898:8010:3:8955:fce7:80c6:13be])
        by smtp.gmail.com with ESMTPSA id v186sm906199qkd.13.2018.11.29.06.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 06:09:04 -0800 (PST)
Subject: Re: [PATCH v1] mem_pool: add GIT_TRACE_MEMPOOL support
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, benpeart@microsoft.com
References: <20181127195337.3264-1-peartben@gmail.com>
 <nycvar.QRO.7.76.6.1811281036300.41@tvgsbejvaqbjf.bet>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <9ce2df67-d698-0372-4770-32659668ab7e@gmail.com>
Date:   Thu, 29 Nov 2018 09:09:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1811281036300.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 11/28/2018 4:37 AM, Johannes Schindelin wrote:
> Hi Ben,
>
> On Tue, 27 Nov 2018, Ben Peart wrote:
>
>> From: Ben Peart <benpeart@microsoft.com>
>>
>> Add tracing around initializing and discarding mempools. In discard report
>> on the amount of memory unused in the current block to help tune setting
>> the initial_size.
>>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>> ---
> Looks good.
>
> My only question: should we also trace calls to _alloc(), _calloc() and
> _combine()?

I was trying to tune the initial size in my use of the mem_pool and so 
found this tracing useful to see how much memory was actually being 
used.  I'm inclined to only add tracing as it is needed rather that 
proactively because we think it _might_ be needed.  I suspect _alloc() 
and _calloc() would get very noisy and not add much value.

>
> Ciao,
> Johannes
>
>> Notes:
>>      Base Ref: * git-trace-mempool
>>      Web-Diff: https://github.com/benpeart/git/commit/9ac84bbca2
>>      Checkout: git fetch https://github.com/benpeart/git git-trace-mempool-v1 && git checkout 9ac84bbca2
>>
>>   mem-pool.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/mem-pool.c b/mem-pool.c
>> index a2841a4a9a..065389aaec 100644
>> --- a/mem-pool.c
>> +++ b/mem-pool.c
>> @@ -5,6 +5,7 @@
>>   #include "cache.h"
>>   #include "mem-pool.h"
>>   
>> +static struct trace_key trace_mem_pool = TRACE_KEY_INIT(MEMPOOL);
>>   #define BLOCK_GROWTH_SIZE 1024*1024 - sizeof(struct mp_block);
>>   
>>   /*
>> @@ -48,12 +49,16 @@ void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size)
>>   		mem_pool_alloc_block(pool, initial_size, NULL);
>>   
>>   	*mem_pool = pool;
>> +	trace_printf_key(&trace_mem_pool, "mem_pool (%p): init (%"PRIuMAX") initial size\n",
>> +		pool, (uintmax_t)initial_size);
>>   }
>>   
>>   void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
>>   {
>>   	struct mp_block *block, *block_to_free;
>>   
>> +	trace_printf_key(&trace_mem_pool, "mem_pool (%p): discard (%"PRIuMAX") unused\n",
>> +		mem_pool, (uintmax_t)(mem_pool->mp_block->end - mem_pool->mp_block->next_free));
>>   	block = mem_pool->mp_block;
>>   	while (block)
>>   	{
>>
>> base-commit: bb75be6cb916297f271c846f2f9caa3daaaec718
>> -- 
>> 2.18.0.windows.1
>>
>>

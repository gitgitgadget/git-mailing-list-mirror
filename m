Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 451991F453
	for <e@80x24.org>; Fri, 28 Sep 2018 14:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeI1Uph (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 16:45:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37226 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1Uph (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 16:45:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id n6-v6so6806059qtl.4
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=20pVwesw+KnUP97TH4nFLgElGM1FwfMMalos1N55tgU=;
        b=Wc9rU2FKfeJcfJNo0V/NmnlTacWOqhGi/MrB6iMmv4Q3LWkJSAeXs/7SQSN/LjLska
         FICFnSgNj7ZU4T9nKFx3HYLwRUG3bwX34q5V7jNavEddGiqg0TU1lmRdxjZu3eq0TIQC
         KBgzBtJ0O5e9yBFTPdURVMESPBHJlN/L6X8wzpCkUy3dc8X/xdjKL3iQu3o5uMTkQYpk
         HWKhHEAWWz9Z8/mIwMEM0QtOYSi7RoOS0wc1vEvOw+hqE4P1h4xENSsMasCqY6pc64l+
         PK40cOAxVifxTLoL5nEdV6vp1a9jHkdfVxKNDlwbMvI+Nh6tZCAN3Nb9qQencvrNfvDN
         3FHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=20pVwesw+KnUP97TH4nFLgElGM1FwfMMalos1N55tgU=;
        b=q12MKENiCvgvGWcC4fuEULsoIpcIRqpCeMaL71eSoX6cLFdNGe3OAfXJxTOKB5ngO/
         ptWqcFZLwHTLn9cj1SsHu+YYvov16J05cXACM4b7i12v7GwhABWpkblSckkXDquvYfDt
         P5K9UUUXTeiD2cque04lpi/tviDlW7o3YoCTgiMkmpfjlhIrfj3Mx965oEbncRt+G+6R
         D6pOlvvwzjvxwvo6xQOoo8dhMEetmGZoAkkBAaIDw9Gh3iLlhWvJHtj7WLXoFOKR+q21
         e319z2Mpefk6Yw1NjCaToq9BgSnSdz7FJl//g/5fQInWSgnwYIgZuoday/H68fJ1Jo68
         4ZzA==
X-Gm-Message-State: ABuFfohFyq6pH1xoUMIGIt9KeO5aVSwrTlmOAbn+LRX4JIbwR7E27Bel
        iac17+STa1KhXYQ5ggLu6vY=
X-Google-Smtp-Source: ACcGV61bmBWklxhqWSHjkqFPQYr4P7tDHGr11DB/Csy+qKR6pMuehSb/uuVxDYEL23Eg/2NRg2DcXg==
X-Received: by 2002:ac8:1c89:: with SMTP id f9-v6mr12833923qtl.265.1538144495184;
        Fri, 28 Sep 2018 07:21:35 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id m61-v6sm720414qte.30.2018.09.28.07.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 07:21:34 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] fsmonitor: update GIT_TEST_FSMONITOR support
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180914143708.63024-1-benpeart@microsoft.com>
 <20180918232916.57736-1-benpeart@microsoft.com>
 <20180918232916.57736-4-benpeart@microsoft.com>
 <20180928100143.GA23446@localhost>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <653f4fbd-ed32-4cf8-b1bb-9cfef4f8deaa@gmail.com>
Date:   Fri, 28 Sep 2018 10:21:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928100143.GA23446@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/28/2018 6:01 AM, SZEDER Gábor wrote:
> On Tue, Sep 18, 2018 at 11:29:35PM +0000, Ben Peart wrote:
>> diff --git a/t/README b/t/README
>> index 56a417439c..47165f7eab 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -319,6 +319,10 @@ GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncommon pack-objects code
>>   path where deltas larger than this limit require extra memory
>>   allocation for bookkeeping.
>>   
>> +GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all exercises the fsmonitor
>> +code path for utilizing a file system monitor to speed up detecting
>> +new or changed files.
> 
> Here you tell us to set GIT_TEST_FSMONITOR to an absolute path, and we
> are good to go.
> 
>> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
>> index 756beb0d8e..d77012ea6d 100755
>> --- a/t/t7519-status-fsmonitor.sh
>> +++ b/t/t7519-status-fsmonitor.sh
>> @@ -8,7 +8,7 @@ test_description='git status with file system watcher'
>>   # To run the entire git test suite using fsmonitor:
>>   #
>>   # copy t/t7519/fsmonitor-all to a location in your path and then set
>> -# GIT_FSMONITOR_TEST=fsmonitor-all and run your tests.
>> +# GIT_TEST_FSMONITOR=fsmonitor-all and run your tests.
> 
> But this old comment is different, suggesting copying that script to
> our $PATH.
> 
> I prefer your instructions above, because it's only a single step,
> and, more importantly, it won't pollute my $PATH.  I think this
> comment should be updated to make the advices in both places
> consistent.  Or perhaps even removed, now that all GIT_TEST variables
> are documented in the same place?
> 

I prefer the suggestion to simply remove this text from the test script 
now that there is documentation for it in the t/README file.

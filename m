Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8159D1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 13:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeINSYE (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 14:24:04 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41034 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbeINSYE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 14:24:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id h138-v6so5096844qke.8
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 06:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L4kbnth7aRaWYVMGlbydj9xQc/vLfaGo3MMbKs6ofTw=;
        b=sXyB9ikVAgAncOLwVEXH+s9EwAVECaE5vMWQ+N03vmuGUkkkXfwT1xODpmNWM+ZgX4
         q5svmmmxWaFhBNGsT7gefOJC8MH53EqOfFgZJkm/9ChQ3WChth6KE/JzrShFgMXtr1en
         Nx+w2G8nijXpc/xLfo8PoVquj9ldCbGPmIpR4TJXV+JAOMUl/FvdXO55xJdWjatrjAry
         NnyTEYMks04b6CcWHnpRzZgltrIyZkULBW1ZT7+NFzWCq1NTjs/3t7pze6h1k35JECrJ
         kB53k3qP86ROZ5jKhmU70M1XlYECizRJvdZW64qs10lu5oNZMrWsMdkKGlOgMii1KEL1
         /RNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L4kbnth7aRaWYVMGlbydj9xQc/vLfaGo3MMbKs6ofTw=;
        b=LnHN6T1hSY8RE6ls+5zNdh9g1zFm2aqSYX3DG082I6gWhNU0WPwGRn7vYdb96S39FP
         eYvipv1eAySAzv+ersY9cbyPOK2iclM0gTjJs7/CggKh92CLY7NksXc5dPFDCv5Rhe9Q
         CaQeb7MAv0PigwLNgzGU33qQixH1QOBk3kyR2Oq1favcMElY58lmeaBf+uk9GZegbHDc
         mQq1SYr8rDMp4vCnPG4Sou5xgJa9CBOQp4s4lrrmxax9ScdQttcZMQiw1Lp854u2aMZi
         NSiyGscrh1TkjwudsWKCi5nbzGUq70jHuXdhc7603VwcfkqtsnfzMcbPN5cb/S1qoWRp
         AMLw==
X-Gm-Message-State: APzg51DXUXs+8F1GUbGE/crjFYtkc4+V3AdY6VA21LeShPlt7EenvOIW
        vfY+vwTGOmXTD5mfKqrF6zg=
X-Google-Smtp-Source: ANB0VdalLooBj4PtrknX1FkNAri95YzAHVvgVR6dktv5/gz5RxpfRLbCkLz54iWF2y9hkrJpOLDSng==
X-Received: by 2002:a37:c987:: with SMTP id m7-v6mr8794036qkl.324.1536930577265;
        Fri, 14 Sep 2018 06:09:37 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id m9-v6sm4580926qta.55.2018.09.14.06.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 06:09:36 -0700 (PDT)
Subject: Re: [PATCH v1] fsmonitor: update GIT_TEST_FSMONITOR support
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180913174522.53872-1-benpeart@microsoft.com>
 <87h8itkz2h.fsf@evledraar.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <90c3d391-a10c-0fd5-4c76-96e547b8bd64@gmail.com>
Date:   Fri, 14 Sep 2018 09:09:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87h8itkz2h.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/13/2018 2:54 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Sep 13 2018, Ben Peart wrote:
> 
>> diff --git a/config.c b/config.c
>> index 3461993f0a..3555c63f28 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -2278,7 +2278,7 @@ int git_config_get_max_percent_split_change(void)
>>   int git_config_get_fsmonitor(void)
>>   {
>>   	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
>> -		core_fsmonitor = getenv("GIT_FSMONITOR_TEST");
>> +		core_fsmonitor = getenv("GIT_TEST_FSMONITOR");
>>
>>   	if (core_fsmonitor && !*core_fsmonitor)
>>   		core_fsmonitor = NULL;
>> diff --git a/t/README b/t/README
>> index 9028b47d92..545438c820 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -319,6 +319,10 @@ GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncomon pack-objects code
>>   path where deltas larger than this limit require extra memory
>>   allocation for bookkeeping.
>>
>> +GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all exercises the fsmonitor
>> +code path for utilizing a file system monitor to speed up detecting
>> +new or changed files.
>> +
>>   Naming Tests
>>   ------------
> 
> I've seen this & will watch out for it, but still, when I'm updating to
> "next" in a couple of months I may not be tracking the exact state of
> the integration of this patch, and then running with
> GIT_FSMONITOR_TEST=... will suddenly be a noop.
> 
> So maybe something like this to test-lib.sh as well (or directly in
> config.c):
> 
>      if test -n "$GIT_FSMONITOR_TEST"
>      then
>          echo "The GIT_FSMONITOR_TEST variable has been renamed to GIT_TEST_FSMONITOR"
>          exit 1
>      fi
> 
> Maybe I'm being too nitpicky and there's only two of us who run the test
> with this anyway, and we can deal with it.
> 

I agree that there are probably only 2 people in the world who ever used 
this but I'm happy to add the additional test to make it obvious it has 
been renamed.

> It just rubs me the wrong way that we have a test mode that silently
> stops being picked up because a command-line option or env variable got
> renamed, especially since we've had it for 4 stable releases, especially
> since it's so easy for us to avoid that confusion (just die),
> v.s. potential time wasted downstream (wondering why fsmonitor stuff
> broke on $SOME_OS even though we're testing for it during package
> build...).
> 

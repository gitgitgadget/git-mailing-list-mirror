Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E6E51F453
	for <e@80x24.org>; Wed, 26 Sep 2018 11:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeIZRPx (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 13:15:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41888 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeIZRPx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 13:15:53 -0400
Received: by mail-qk1-f195.google.com with SMTP id n3-v6so14879356qkn.8
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 04:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=KA7e1UPAVuWP8V0oUcE5U9AAdSG65FlBPaJ3zEkOfbQ=;
        b=SrofY2WdCyXoktA7iDfvTj4jb7O3OibjauzCE7MT0c8G4PWLwbtvxUp6uLo3VSA914
         a5eXqgCgtheDKw/G5ft0pLUVUIV7gPMLZekp2ej8YuV5+aHqFHTQKDWU8Ds3Ig1vLwQA
         WlIbpH8+E7QqyWyZtvfCx999LqsZ/YET1bN74/0ZwEJJABtz7fgrziqFhC5qJ1JmV0nf
         gyGRO7F7HAfJymK2kH0Xb/5rChRLkaylXEXScKM54CzRmmOTenzu4OgmYr3a/uuXtFFh
         jb4UM0l6hw1SPM8lOkhEd5Ona6cUBt3xdAmk+ElfqNINBJ8k/QHCpeT9m7HVyIN3NuLv
         BW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KA7e1UPAVuWP8V0oUcE5U9AAdSG65FlBPaJ3zEkOfbQ=;
        b=H+8WeVGZ73B7WTjcwi/JmwrYNBUn1odRifdovBupr6+PxS9+GWtPRsp7BuJ0XMYfYJ
         JBiLrNDiv7KG4CEa9OUE14p+R42g/PxDliumcu07GrD9x/bWiox11gSB9WTiiWZZDvn8
         XNF6tNHG6JD/29A4RXIBCRfhrjVqjOx7z+PHG43EW+fWfXI6XSh6xXHp5p0/ZmpxOkmY
         /YOHee7cjwSP8ywSBmh1b1oXu1rKNX+TrBqeJq6Q+fu466VQuCkk3GZr1d5UIzYSbuUv
         RfFxEs2yqVJruYoG17cgZnO7AExcSTpG0lnUSmX2dB4C5IYlDtNdJCx0cGiVDyZYbaEv
         IuOw==
X-Gm-Message-State: ABuFfohZEvxOT5QiMuGaiAmKMFlLUN+jglzs7R51DE8V0KKb+ELWyJg7
        0GVAOKdXlWAw4o5qqou/98RBwSz5/Cs=
X-Google-Smtp-Source: ACcGV61KUlM++K97IIS3w2ORXPspGNeoTP8d+LxR1xgiJL+9jrKxPxa7Riv+DOhsayBIMWa0cvD4pw==
X-Received: by 2002:a37:2c84:: with SMTP id s126-v6mr3616409qkh.311.1537959807207;
        Wed, 26 Sep 2018 04:03:27 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id v187-v6sm2577238qka.73.2018.09.26.04.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 04:03:26 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Tuesday, Sept 25)
To:     Ben Peart <peartben@gmail.com>, Git List <git@vger.kernel.org>
References: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com>
 <d92f18e2-0bbc-e36b-123a-3ed3f44cf418@gmail.com>
 <b46d6363-1709-968e-105a-3f4e8a77155e@gmail.com>
 <551b01d45587$90b27f30$b2177d90$@pdinc.us>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <39fbf022-a136-7d8a-a149-ef9aeeffc491@gmail.com>
Date:   Wed, 26 Sep 2018 07:03:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <551b01d45587$90b27f30$b2177d90$@pdinc.us>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/26/2018 6:56 AM, Jason Pyeron wrote:
>> -----Original Message-----
>> From: Derrick Stolee
>> Sent: Wednesday, September 26, 2018 6:43 AM
>>
>> On 9/25/2018 5:12 PM, Ben Peart wrote:
>>>
>>> On 9/25/2018 2:42 PM, Derrick Stolee wrote:
>>>> In an effort to ensure new code is reasonably covered by the test
>>>> suite, we now have contrib/coverage-diff.sh to combine the gcov
>>>> output from 'make coverage-test ; make coverage-report' with the
>>>> output from 'git diff A B' to discover _new_ lines of code that are
>>>> not covered.
>>>>
> <snip/>
>>> I looked at the lines that came from my patches and most if not all of
>>> them are only going to be executed by the test suite if the correct
>>> "special setup" option is enabled.  In my particular case, that is the
>>> option "GIT_TEST_INDEX_THREADS=<n>" as documented in t/README.
>>>
>>> I suspect this will be the case for other code as well so I wonder if
>>> the tests should be run with each the GIT_TEST_* options that exist to
>>> exercise uncommon code paths with the test suite.  This should prevent
>>> false positives on code paths that are actually covered by the test
>>> suite as long as it is run with the appropriate option set.
>> This is a bit tricky to do, but I will investigate. For some things, the
>> values can conflict with each other (GIT_TEST_SPLIT_INDEX doesn't play
>> nicely with other index options, I think). For others, we don't have the
>> environment variables in all versions yet, as they are still merging down.
> Remember that the code coverage is cumulative, on one of my projects where I have similar special cases the automated build will run through a sequence of different build options (including architectures) and executions - then generate the final report.
For Git, I'm just using "make coverage-test" and "make coverage-report". 
To make the results cumulative, I'd need to remove the 
"coverage-clean-results" as a dependency to "coverage-test". This may be 
a good thing to do, so I can run the test suite with multiple options. 
Perhaps I'll just add a new "coverage-test-with-options" step that just 
runs the tests in "default" mode and then "enhanced" mode.
> Another thought would be to weight the report for "new lines of code" - which is the same we do for our Fortify scans. We take the git blame for the change range and de-prioritize the findings for lines outside of the changed lines. This could give a tighter focus on the newly change code's test coverage.
This is what the contrib/coverage-diff.sh script does. I'd love your 
input, as it is still under review [1].

[1] 
https://public-inbox.org/git/21214cc321f80cf2e9eb0cdb1ec3ebb869ea496d.1537542952.git.gitgitgadget@gmail.com/
     [PATCH v3 1/1] contrib: add coverage-diff script

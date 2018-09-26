Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CE921F453
	for <e@80x24.org>; Wed, 26 Sep 2018 10:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeIZQzn (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 12:55:43 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:44081 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeIZQzn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 12:55:43 -0400
Received: by mail-qt1-f180.google.com with SMTP id k38-v6so16645811qtk.11
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 03:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=OnTG2Emyz51WKSztu9bqSCFLkYFnfzYlz7jnDdGwGhs=;
        b=SgfOB8RWQoJCKiT9EqShF7hHYex4uTdSvox1CvTWpDVbq7NRznXwTOiVFGYD8hT+aP
         wbpi9Zv1umFzKEWP2sD/qbRpTu91EOG9+8cypQXo+tlOPl/Te2XxrXbeFPkyEUD3wgnH
         vH511WiZEXf6BGVbgGbAFO9h81to5+VdEUeevnUMSMyoIHNxYKo3jXBa9fODAxQ9ZMmC
         D+kK+090zW8qqhfCGTsu6QSm9HD4o3d8N8lTf1ZeERCUPd4eC+PFN+XFd8ckYcC74NGe
         QWI55+dJcQKGCZSxg5LBnLsNlofTOxCPDxZRMo/jev+xYTjgWFAdmMHNGAXqNTERHUH/
         lBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OnTG2Emyz51WKSztu9bqSCFLkYFnfzYlz7jnDdGwGhs=;
        b=qku46ov2BsehVgtAVkmrEW/Jc8SMYpqhzkMDAOzckrSpFfwjjU5stLUoAtg37P1Kta
         xsExAMcZBRvWkTYMyRKE9FZVmP2nit8oIJfHC6qxXXf8KIP3seOpNWkEQxzVnvsToXd1
         gIdhpleLXvffykZD/hznXn77FJwnAzb2qE2VP2u4SeXsy7wetWmjP8MRo0dWJnoEqKSO
         mlzjr1z31pq19B01ua33K04ucqvPMv3eAt8SZ/BasGBA/MXNZf5yaQB2poEta9W4jDOZ
         69WiV8fNRiUQ5IZKvKS0vSiec8e5WDCCVlFuTf8+yn/Ap+Bi0F7Bykg4/zF4LaCbSRdg
         n2cA==
X-Gm-Message-State: ABuFfogaSUKRZW19PE67/JMzDweMtzUGB+3if0jyhbThwMn6eH6gZQWZ
        JTjd5nX7hMMTzlXAgPGIGjJZb/kuUqI=
X-Google-Smtp-Source: ACcGV60zqtU8fhC7mDfTiwhngXjOnc38lJqJFsuMeiEg74rVyZeOc0vKW8Wsf2BUEbMVLqVacwPyIw==
X-Received: by 2002:a0c:c181:: with SMTP id n1-v6mr3844676qvh.73.1537958601345;
        Wed, 26 Sep 2018 03:43:21 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id n71-v6sm2707483qke.61.2018.09.26.03.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 03:43:20 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Tuesday, Sept 25)
To:     Ben Peart <peartben@gmail.com>, Git List <git@vger.kernel.org>
References: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com>
 <d92f18e2-0bbc-e36b-123a-3ed3f44cf418@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b46d6363-1709-968e-105a-3f4e8a77155e@gmail.com>
Date:   Wed, 26 Sep 2018 06:43:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <d92f18e2-0bbc-e36b-123a-3ed3f44cf418@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/25/2018 5:12 PM, Ben Peart wrote:
>
>
> On 9/25/2018 2:42 PM, Derrick Stolee wrote:
>> In an effort to ensure new code is reasonably covered by the test 
>> suite, we now have contrib/coverage-diff.sh to combine the gcov 
>> output from 'make coverage-test ; make coverage-report' with the 
>> output from 'git diff A B' to discover _new_ lines of code that are 
>> not covered.
>>
>> This report takes the output of these results after running on four 
>> branches:
>>
>>          pu: 80e728fa913dc3a1165b6dec9a7afa6052a86325
>>
>>         jch: 0c10634844314ab89666ed0a1c7d36dde7ac9689
>>
>>        next: 76f2f5c1e34c4dbef1029e2984c2892894c444ce
>>
>>      master: fe8321ec057f9231c26c29b364721568e58040f7
>>
>> master@{1}: 2d3b1c576c85b7f5db1f418907af00ab88e0c303
>>
>> I ran the test suite on each of these branches on an Ubuntu Linux VM, 
>> and I'm missing some dependencies (like apache, svn, and perforce) so 
>> not all tests are run.
>>
>> I submit this output without comment. I'm taking a look especially at 
>> my own lines to see where coverage can be improved.
>>
>
> Thanks for driving this.  I think it provides an interesting view into 
> new code and how well it is being tested.  In an effort to make this 
> as useful as possible, we should be looking to eliminate as much noise 
> as possible otherwise people will stop looking at it.
Thanks for helping identifying the noise.
>
> I looked at the lines that came from my patches and most if not all of 
> them are only going to be executed by the test suite if the correct 
> "special setup" option is enabled.  In my particular case, that is the 
> option "GIT_TEST_INDEX_THREADS=<n>" as documented in t/README.
>
> I suspect this will be the case for other code as well so I wonder if 
> the tests should be run with each the GIT_TEST_* options that exist to 
> exercise uncommon code paths with the test suite.  This should prevent 
> false positives on code paths that are actually covered by the test 
> suite as long as it is run with the appropriate option set.
This is a bit tricky to do, but I will investigate. For some things, the 
values can conflict with each other (GIT_TEST_SPLIT_INDEX doesn't play 
nicely with other index options, I think). For others, we don't have the 
environment variables in all versions yet, as they are still merging down.
>
> I realize it would take a long time to run the entire test suite with 
> all GIT_TEST_* variables so perhaps they can only be tested "as 
> needed" (ie when patches add new variables in the "special setups" 
> section of t/README).  This should reduce the number of combinations 
> that need to be run while still eliminating many of the false positive 
> hits.

This is something to think about. For my own thoughts, I was thinking of 
trying to run it when we see large blocks of code that are uncovered and 
obviously because of environment variables. This is what I was thinking 
when I saw your and Duy's commits in the output. I'll see if I can 
re-run the suite using GIT_TEST_INDEX_THREADS=2 and 
GIT_TEST_INDEX_VERSION=4.

Thanks,
-Stolee

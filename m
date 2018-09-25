Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15B21F453
	for <e@80x24.org>; Tue, 25 Sep 2018 21:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeIZDWH (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 23:22:07 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:37766 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbeIZDWH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 23:22:07 -0400
Received: by mail-qk1-f176.google.com with SMTP id c13-v6so14227026qkm.4
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 14:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3DYLsw4rco5HQeNDvG3dwmbKvGxdThNYpSDizdTDmLM=;
        b=abotp/AoUXVb/jRNH7t7+pY81hBvkV2PBN2mArXt+xNc9cumUkQhskA4j0WadZKqbd
         QVcWrn8hgWRhzk3UbZDqMi+OoOU29dDPimcZh+6u5WGtGh1dYMgpxd7hVTK81//mrklW
         sopYqfXXCriiFCUfI/Re1oyl+zjcCGyuN+3+iGHzbsqf9SfsqZsXDSfz8sKQ8wtCqe0a
         EFUUg3+3HvN6pbR4f10kLjF8cJF/CX6pSkSbB6ZBB0qQW2DW4IW7uMkTuYhExwUO7UBM
         gam2BhX4fVC4Xqwtu+Xc7eFuX8CcjFB5K4zJlOFYJhusm/37YOqJW6ZbPtiddOWX2nC2
         WoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3DYLsw4rco5HQeNDvG3dwmbKvGxdThNYpSDizdTDmLM=;
        b=TIDmA8JF2sT30xYvSthM5uYHAB9tTRYPBWfcZRnVucltunVh2c7MAOSsuIdkSRSRTm
         kNqjl6VuRFANF944XTHYabO1AWm500shG2iFBkkH/AhAJKRR0ykqEtVcacZnQEiTfL93
         gvp7fOCeTKflB+xqoH6gQU01LV4ADwK4pysTC+q7eMoXFm8sTN4RcmunqI/E5C6b1k4d
         hYSvvWLPs1iJ4C/KvlDmlOmW+9RTGeFwRuWeTtMD2FfHQWkBH0AGO1Q5g/P2UbQl6RS9
         DLdEDz0L5dyUZpz69mXAz2RYHKPOd+Rvisa1u9CpY67ziClp8v0A/n2Pxgmkbgu9J2M8
         uSOQ==
X-Gm-Message-State: ABuFfoju6rKQh+X+y+ZgbtIr01gDsjOx9q2RDol3QVhQ2gC+W3vREwrX
        M8V+7y5kDYxV0Jn73ADcHgWtHQ8c
X-Google-Smtp-Source: ACcGV60sZCiLEEGwp5uIRdTMNzM9Xymbu45L4vVB8D6aqjsch93zfUK3dHnaBNtR25lN3dg5H5o1Hg==
X-Received: by 2002:a37:b842:: with SMTP id i63-v6mr2054649qkf.187.1537909957633;
        Tue, 25 Sep 2018 14:12:37 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id u15-v6sm1996589qke.36.2018.09.25.14.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 14:12:36 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Tuesday, Sept 25)
To:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
References: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <d92f18e2-0bbc-e36b-123a-3ed3f44cf418@gmail.com>
Date:   Tue, 25 Sep 2018 17:12:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/25/2018 2:42 PM, Derrick Stolee wrote:
> In an effort to ensure new code is reasonably covered by the test suite, 
> we now have contrib/coverage-diff.sh to combine the gcov output from 
> 'make coverage-test ; make coverage-report' with the output from 'git 
> diff A B' to discover _new_ lines of code that are not covered.
> 
> This report takes the output of these results after running on four 
> branches:
> 
>          pu: 80e728fa913dc3a1165b6dec9a7afa6052a86325
> 
>         jch: 0c10634844314ab89666ed0a1c7d36dde7ac9689
> 
>        next: 76f2f5c1e34c4dbef1029e2984c2892894c444ce
> 
>      master: fe8321ec057f9231c26c29b364721568e58040f7
> 
> master@{1}: 2d3b1c576c85b7f5db1f418907af00ab88e0c303
> 
> I ran the test suite on each of these branches on an Ubuntu Linux VM, 
> and I'm missing some dependencies (like apache, svn, and perforce) so 
> not all tests are run.
> 
> I submit this output without comment. I'm taking a look especially at my 
> own lines to see where coverage can be improved.
> 

Thanks for driving this.  I think it provides an interesting view into 
new code and how well it is being tested.  In an effort to make this as 
useful as possible, we should be looking to eliminate as much noise as 
possible otherwise people will stop looking at it.

I looked at the lines that came from my patches and most if not all of 
them are only going to be executed by the test suite if the correct 
"special setup" option is enabled.  In my particular case, that is the 
option "GIT_TEST_INDEX_THREADS=<n>" as documented in t/README.

I suspect this will be the case for other code as well so I wonder if 
the tests should be run with each the GIT_TEST_* options that exist to 
exercise uncommon code paths with the test suite.  This should prevent 
false positives on code paths that are actually covered by the test 
suite as long as it is run with the appropriate option set.

I realize it would take a long time to run the entire test suite with 
all GIT_TEST_* variables so perhaps they can only be tested "as needed" 
(ie when patches add new variables in the "special setups" section of 
t/README).  This should reduce the number of combinations that need to 
be run while still eliminating many of the false positive hits.


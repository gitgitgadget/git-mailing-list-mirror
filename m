Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 696FA1F461
	for <e@80x24.org>; Sat, 29 Jun 2019 01:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfF2BgS (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 21:36:18 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:46588 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfF2BgS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 21:36:18 -0400
Received: by mail-qt1-f173.google.com with SMTP id h21so8433064qtn.13
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 18:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wKQEcnN9wRCCwsnhnjYOu3A6RhnKKd2Ccm4HEQbJXT8=;
        b=GGg6WYMM0pckAgtaZIgYmOKPMUcBcKogGtmWt1mSXdEbvJgxdXQTHyPlJJPtEPw2m7
         xjbtdSqt2HnZ+gfSau8c5JrJCEWd8L+dS/p7wbj/a6MEilEAZwMN/nnq9lBy6hjuS86E
         3KHDCgkqAM0eKnAlqRvd399mGVUcCa4l5mwoEeLSj0lEJjslFO6FzUV/G1O2ONdEExsV
         bnw0tzglr4llcZZ3RQIUp0h04Fg85WACpJBhXs0JkhfKyyIKscTVx2st+QmOs/6AraIy
         rnZPH5/UVZXvh8RMXwqyj83Xy+RpM3zS0LQ5PTJKiF+C3Wy18atAYl7U3PUz966wU0rH
         iwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wKQEcnN9wRCCwsnhnjYOu3A6RhnKKd2Ccm4HEQbJXT8=;
        b=mzUcWal0fe/4/5IDzt802k5Sy5m7yek34ad1PCsrWtGzi/T37q2bYPRcXCdGPBzk03
         QG4Moop74vGsh9MADcs9lFQg+w4hFmtx30vgktzU2PDYMaTMA0rRzj9j4FCL9T09WCgQ
         C31uYVJCuM+197f0EXqbRvSMw7hEIBq0PNXGt0Rr0gR/EWYL6Z5T2RN3TBKXQ1UvWzal
         rpyke4Oi6oS5VLT9xC3qJZiBT4OcO12ajURLyy0dcug84MAlCfgYTbhaFnvr/I9i9Zup
         XXTC5QRbz7SxCsuZCT1UshHM3wx979yyUQZIma9FRV+YxsCf96An3xKL9DTml1B7DrZA
         e8qA==
X-Gm-Message-State: APjAAAXKC4As9ckCWJRSmuBH/hU8rAkAVUDGq/z7ULV1K9hPv5tGxpKi
        EKd44yxMaZcfhCtZRU6pkKQonk/6
X-Google-Smtp-Source: APXvYqzSfuae+H76mkKfKcpZz4Hwfm8aooIkTwVoMCNJUcGRdTZp1fkO6NmMB9wVD+rDIcUjKlpSoA==
X-Received: by 2002:ac8:7555:: with SMTP id b21mr7399646qtr.292.1561772177054;
        Fri, 28 Jun 2019 18:36:17 -0700 (PDT)
Received: from [10.0.1.15] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id s79sm637442qka.85.2019.06.28.18.36.15
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 18:36:16 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Thurs. June 27)
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com>
 <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com>
 <20190628064520.GB19777@sigill.intra.peff.net>
 <ddf13a6b-42f4-57ae-49f1-8cc758b1dc4b@gmail.com>
 <20190628235903.GB2625@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c2e0ceef-c14d-ea1d-7522-eab0bf2e48ce@gmail.com>
Date:   Fri, 28 Jun 2019 21:36:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190628235903.GB2625@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2019 7:59 PM, Jeff King wrote:
> On Fri, Jun 28, 2019 at 08:23:49AM -0400, Derrick Stolee wrote:
> 
>> On 6/28/2019 2:45 AM, Jeff King wrote:
>>> On Thu, Jun 27, 2019 at 01:35:17PM -0400, Derrick Stolee wrote:
>>>
>>>>> t/helper/test-example-decorate.c
>>>>> 0ebbcf70 29) one = lookup_unknown_object(&one_oid);
>>>>> 0ebbcf70 30) two = lookup_unknown_object(&two_oid);
>>>>> 0ebbcf70 59) three = lookup_unknown_object(&three_oid);
>>>>
>>>> Peff: again interesting that these lines you refactored were not covered, especially
>>>> because they are part of a test helper. Perhaps the tests they were intended for are
>>>> now defunct?
>>>
>>> They should be run by t9004 (and if I replace them with a `die`, they
>>> clearly are). Are you sure your coverage script is not mistaken?
>>
>> It looks like I'm missing the 9000+ tests. The following line was in the script
>> I adapted from another CI job:
>>
>> 	rm -f t/t9*.sh
>>
>> This was probably because the job I adapted from needed to run quickly, but for
>> this coverage report we should do the hard work of running whatever t9*.sh tests
>> we can.
> 
> I suspect most of those _are_ low-value. The git-p4 tests, for instance,
> are mostly exercising the p4 script and not our C code, and the same
> with git-svn. However I wouldn't be surprised if there are a few dusty
> corners they manage to hit that aren't covered elsewhere.
> 
> Still, if it's not too painful to add them in time-wise, it probably
> makes sense for the coverage tests to be as exhaustive as possible.

Unfortunately, even running the t9*.sh tests once (among the two runs:
first with default options and then with several GIT_TEST_* options)
causes the build to go beyond the three hour limit, and the builds time
out.

I'll just need to keep this in mind and do some more diligence myself
to check if things are covered in the 9000 tests before bugging people
about coverage.

Thanks,
-Stolee
 

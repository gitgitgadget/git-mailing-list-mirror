Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78BC81F453
	for <e@80x24.org>; Thu, 27 Sep 2018 15:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeI0V5V (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 17:57:21 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:53551 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbeI0V5V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 17:57:21 -0400
Received: by mail-wm1-f52.google.com with SMTP id b19-v6so6395940wme.3
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 08:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=9owH9fN8Nc4treJbbl4RxcFFMUW1k9sg2+FXszAhvTI=;
        b=rEC3Y3ginCrRnpB4YLQsqgmudmrBwwfInPHWDZSfFx2Ib1oa3+Xq288HQagL2Ev3LE
         hulSnH7OxRfDB3Wxj+EGyOmAPVqeG488eNhUHZMw5vpguCdsOTTK2PcSChZRemQq2YX2
         oxzXpjuj5QfqUoYzPU5LXZlVkN7GJjjLxAPcw4Z1BY7l4ddr+o6jyPVNAoIXGTOMt1PP
         TCnXC0CVTg8+NArU9Uo6m/1fNVj5/VzHF5Nb6unWuO4miozFEUVZuRDv1kq1Kc6JsiwS
         oxa9nbEYmXgJeW080BS3H5lMKmI7yYbpyTpcR1ZglaVUWFF8LLhQFq2/RIdGwV2NXVUF
         Wwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=9owH9fN8Nc4treJbbl4RxcFFMUW1k9sg2+FXszAhvTI=;
        b=cbWy5BHZbNnoECIo0CeHrQ1ZSHmg0tl2cuU2gmaXb6dpkURNyKXzWqHkBwGgN97SGt
         M2EB5l+vjfbJnddpWsaJpBakGwNADllFVbB9CnGX4FQ5QVnwZu2kKCEc5YZvrgEXcNYt
         YYW9+sElTKfc4U7EXc3O+gEihEOzkT2I5OBDeCbPp0nIubkE4pGxV+bYHi7pRBqhSVcR
         B+TNtzf3ajJ7zLmtWbOuZ1m4n4DaOjGUnVEbKXZTlAUS9L2JefR2rrr4bA2jWGnsDcWc
         HIR9Ly5TtSqjvaonctLkuBgSWz7mCPU9oirUuVI5isVT+Q6LifqqtW1LK9Bf2xzICjkO
         3M/g==
X-Gm-Message-State: ABuFfoiR6Dk9ufwDn9eA8RMsel73k1TcTUva92BlvBonwi2I0CqTwvvZ
        FtJI5Z4cI+fP8Ujn2o10NaaPcsx29kg=
X-Google-Smtp-Source: ACcGV62K91ReUb4dN4/kirwsHR6wAGBX8yOaavqaOU2qsvjpoduWrvshAQYKDXK5zfvZx3/zVgNDSA==
X-Received: by 2002:a1c:6c0a:: with SMTP id h10-v6mr8673350wmc.47.1538062709053;
        Thu, 27 Sep 2018 08:38:29 -0700 (PDT)
Received: from evledraar (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id x132-v6sm8918859wmg.3.2018.09.27.08.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 08:38:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Tuesday, Sept 25)
References: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com> <d92f18e2-0bbc-e36b-123a-3ed3f44cf418@gmail.com> <b46d6363-1709-968e-105a-3f4e8a77155e@gmail.com> <20180926184308.GA2253@hank.intra.tgummerer.com> <a7228cb5-5085-e1c7-0731-d37b19cdc3bf@gmail.com> <225dc2e3-1aa0-ac19-26e6-59b54dfe871c@gmail.com> <07ab14bb-766b-e375-989b-73974ef7fece@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <07ab14bb-766b-e375-989b-73974ef7fece@gmail.com>
Date:   Thu, 27 Sep 2018 17:38:26 +0200
Message-ID: <87wor7hrwt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 27 2018, Derrick Stolee wrote:

> On 9/27/2018 11:21 AM, Ben Peart wrote:
>>
>>
>> On 9/26/2018 2:54 PM, Derrick Stolee wrote:
>>>
>>> GIT_TEST_INDEX_THREADS=1
>>>
>>
>> Because the test repos are so small (ie smaller than 10K files), the
>> test suite already executes as if GIT_TEST_INDEX_THREADS=1 is set
>> (ie single threaded). I added the test variable so that the
>> multi-threading code could be forced to execute in spite of the
>> default minimum number of files logic.
>>
>> I'd recommend you set GIT_TEST_INDEX_THREADS=3 instead. (3 because 1
>> thread is used for loading the index extensions and we need 2 or
>> more threads available to exercise multi-threaded loading of the
>> index entries).
>
> According to t/README, GIT_TEST_INDEX_THREADS is a boolean and setting
> it to 1 causes us to use 3 threads:
>
>  GIT_TEST_INDEX_THREADS=<boolean> forces multi-threaded loading of
>  the index cache entries and extensions for the whole test suite.
>
> Here is the only consumption of the variable in the product code (in
> read-cache.c):
>
>  /* enable testing with fewer than default minimum of entries */
>  if (istate->cache_nr > 1 && nr_threads < 3 &&
> git_env_bool("GIT_TEST_INDEX_THREADS", 0))
>  nr_threads = 3;
>
> This was non-obvious to me, and I had originally set it to a larger
> number. I happened to notice the boolean nature while I was looking up
> the rest of the GIT_TEST_* variables.

I didn't know it worked like that. Would be neat if we had some "strict
bool" function in config.c that would accept on/true/1 off/false/0 but
barf on e.g. 12345 instead of treating it as just another synonym for 1,
I'd say we could even enable it by default, but maybe not, but
definitely for all this GIT_TEST_* stuff.

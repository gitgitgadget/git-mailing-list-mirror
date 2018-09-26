Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB8E1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbeI0BIZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 21:08:25 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:36354 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeI0BIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 21:08:25 -0400
Received: by mail-qk1-f171.google.com with SMTP id a85-v6so26945qkg.3
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GBQfJi4MT6+Mtfflwn4/Uq6+1mDiJMGLR/yJJ0cFpLg=;
        b=Re4bUx6zzfqFBQs5wttMYi7mvwd/64YB/HH/fzU1TUZ9FCzMCgcE/UEl0OSmtp42CW
         73grS54cPhGBXzDYGDv68tfSMZ7skDqNgz4xm/3FwtrwbEQ56JEUkeKphuhbDSNOfdxq
         1ye5kauOQpBh4Vh5Slj7Z2gLAWmmn066c6vPhdFK97FS1G716Ypqsbg4C3uB137yoawy
         rWmBpEpFZ5AAHWfl+97noN8R8wD7FynZfJEUabGuTwjs9wXI3rhqfnhbzS6v2NoUnRni
         HNcXLRfNOdcJnTGv2IVxWzFLT7HPGBvaeCqDoMc4Sqp1gGemDeaKsJCpwST09V9PACCL
         AgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GBQfJi4MT6+Mtfflwn4/Uq6+1mDiJMGLR/yJJ0cFpLg=;
        b=PvaGIDR1SzKKLkiqFiydi1cqNc5yrksvTxeEai3PgpXi5ilcKfyJOzexGP1/sn6uGN
         wZpdnP49mHb41Q0N3XW6b6OGArqIWavgI81R/gE21F4WJYMz+Nw2ECxLmnQ5pBOLYWMl
         NeKcKEV6k9kzVSPkicqHmZZ2Bc+Lkz/OJn1WUvQDU0/E5GpXt5/2aRf7Ewi7N9kTzwjd
         42uav6HQ8aYs0/yq+Qt5phiXG29rvcKvt8GJIx3CnUeZ4ctkTr7UFxzt3JbrgBJL0Gdh
         exRiUMld2Jf+LxZxRxFg1/vuGJuvjTENWiRWWw2hbfmd81PF7TERYFozsolcuuMQ/9L/
         ELEw==
X-Gm-Message-State: ABuFfoiE15Kxuc0IUZznUECkD6HHpC6ANFnpQUC9Lp3hgBkBh3P8sGTc
        AVvU8DULitoX4DGADD5/aUJ0lyE2
X-Google-Smtp-Source: ACcGV61ysZEkLF8AgddBu0w3EiR/XMQbc8KG8j+kVW6jT4rNQXOHhmKFLZ1pT2CrSzMw3Zk7GUTqJw==
X-Received: by 2002:a37:8346:: with SMTP id f67-v6mr5361515qkd.18.1537988044485;
        Wed, 26 Sep 2018 11:54:04 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:51a9:99b0:a00a:e3c? ([2001:4898:8010:0:3adf:99b0:a00a:e3c])
        by smtp.gmail.com with ESMTPSA id b7-v6sm3539594qtt.24.2018.09.26.11.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:54:03 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Tuesday, Sept 25)
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, Git List <git@vger.kernel.org>
References: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com>
 <d92f18e2-0bbc-e36b-123a-3ed3f44cf418@gmail.com>
 <b46d6363-1709-968e-105a-3f4e8a77155e@gmail.com>
 <20180926184308.GA2253@hank.intra.tgummerer.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a7228cb5-5085-e1c7-0731-d37b19cdc3bf@gmail.com>
Date:   Wed, 26 Sep 2018 14:54:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180926184308.GA2253@hank.intra.tgummerer.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/26/2018 2:43 PM, Thomas Gummerer wrote:
> On 09/26, Derrick Stolee wrote:
>> This is a bit tricky to do, but I will investigate. For some things, the
>> values can conflict with each other (GIT_TEST_SPLIT_INDEX doesn't play
>> nicely with other index options, I think).
> Just commenting on this point.  I think all the index options should
> be playing nicely with eachother.  I occasionally run the test suite
> with some of them turned on, and if something failed that was always
> an actual bug.  The different modes can be used in different
> combinations in the wild as well, so we should get them to interact
> nicely in the test suite.

Thanks! I'm still working out details on this, since the test suite is 
broken with GIT_TEST_COMMIT_GRAPH due to a verbosity issue [1], which I 
forgot until I ran the tests with the variable on.

I'll re-run with these variables:

GIT_TEST_SPLIT_INDEX=1

GIT_TEST_FULL_IN_PACK_ARRAY=1

GIT_TEST_OE_SIZE=128

GIT_TEST_OE_DELTA_SIZE=128

GIT_TEST_VALIDATE_INDEX_CACHE_ENTRIES=1

GIT_TEST_FSMONITOR=$PWD/t/t7519/fsmonitor-all

GIT_TEST_INDEX_VERSION=4

GIT_TEST_PRELOAD_INDEX=1

GIT_TEST_DISABLE_EOIE=1

GIT_TEST_INDEX_THREADS=1

Thanks,

-Stolee

[1] 
https://public-inbox.org/git/60aae3d6-35b2-94fb-afd7-6978e935a4f7@gmail.com/


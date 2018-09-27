Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099E41F453
	for <e@80x24.org>; Thu, 27 Sep 2018 15:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeI0Vjy (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 17:39:54 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:44789 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeI0Vjy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 17:39:54 -0400
Received: by mail-qk1-f178.google.com with SMTP id g184-v6so1795200qkc.11
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=699Qb3mR4UWRN1taihsgw3r3wLyWvObLi2YXfhyvEbY=;
        b=L3M/TQLjXvWn/XZZhUfpFBK/6qdthnqGZk+qvR4L3ChkuXyXpZ0ecGoLh0lnSw/HFs
         /euZ4An8cXOa03NXltxh/TVK0G4OoR/gKExlQtAv++mqLKn3Pl/TXF75kacLeCmTr4sp
         2h2R3OS5o9yeKjLlAhoR36rkW7ctZxoukixKAaaTJf2MOcYpUquP1vEkxJ8zkdz6oCJe
         MIdlfcdlOpVF6FCO6jLkDXxZCv1v8Iuavw8YyHQESTdcYzplVJTZ2rUBntiI2Ff4dcSi
         V3IqA3+HTFIzSK2n9SmOBbytcdFBjZ9U5/dMaaEyrGhe8mKd+StS4LL3EcyB8eSGy8ER
         IlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=699Qb3mR4UWRN1taihsgw3r3wLyWvObLi2YXfhyvEbY=;
        b=sLpUNAsRwaThTQpLKW9sr0qQmPl3oCx+uskrg1WH2MQs0kM9Td74ytnRksDhULXQy0
         LXEUh6nWynMTlFNXvafwOug6YmbtoiULi4W/K4tbxYU4jMbDTerUq122eWbKPv15WUTL
         rMHY7nZt3nXv7Lcj1Dy0N6z6Yy7fiajXSpOpnNgGLpJeo25wwri2hjXwj+8TSi2igamf
         SHU9GNUGRAZXjVRx6L6gsC5uJSutLZU9YPVe/vFsX+r5yyGEBl6UXzOz9SxLZpt5TW9p
         Ucsh7NE/qzYUdNvgwZmWmgFSUSl55PjQRZq5ybNi6IFiP4+I7vb49rioU3TxCtUYSWKX
         Vgog==
X-Gm-Message-State: ABuFfog9nM/ay061tu2byScGoZ6oGyrb8nfhTEa6zHWPvWSLbQ5L12QK
        He2pSWA1Tch/wQU2bRIYZVll34k+wfw=
X-Google-Smtp-Source: ACcGV62muIQyntQr5uGN5za4dzBTX0wjOtM7nqDfTQeBx24N8Y/7FvfVohr2KsQMVxJ2y/MuTqavWg==
X-Received: by 2002:a37:6396:: with SMTP id x144-v6mr8175042qkb.340.1538061667726;
        Thu, 27 Sep 2018 08:21:07 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n83-v6sm1011666qki.60.2018.09.27.08.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 08:21:06 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Tuesday, Sept 25)
To:     Derrick Stolee <stolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com>
 <d92f18e2-0bbc-e36b-123a-3ed3f44cf418@gmail.com>
 <b46d6363-1709-968e-105a-3f4e8a77155e@gmail.com>
 <20180926184308.GA2253@hank.intra.tgummerer.com>
 <a7228cb5-5085-e1c7-0731-d37b19cdc3bf@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <225dc2e3-1aa0-ac19-26e6-59b54dfe871c@gmail.com>
Date:   Thu, 27 Sep 2018 11:21:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a7228cb5-5085-e1c7-0731-d37b19cdc3bf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/26/2018 2:54 PM, Derrick Stolee wrote:
> On 9/26/2018 2:43 PM, Thomas Gummerer wrote:
>> On 09/26, Derrick Stolee wrote:
>>> This is a bit tricky to do, but I will investigate. For some things, the
>>> values can conflict with each other (GIT_TEST_SPLIT_INDEX doesn't play
>>> nicely with other index options, I think).
>> Just commenting on this point.  I think all the index options should
>> be playing nicely with eachother.  I occasionally run the test suite
>> with some of them turned on, and if something failed that was always
>> an actual bug.  The different modes can be used in different
>> combinations in the wild as well, so we should get them to interact
>> nicely in the test suite.
> 
> Thanks! I'm still working out details on this, since the test suite is 
> broken with GIT_TEST_COMMIT_GRAPH due to a verbosity issue [1], which I 
> forgot until I ran the tests with the variable on.
> 
> I'll re-run with these variables:
> 
> GIT_TEST_SPLIT_INDEX=1
> 
> GIT_TEST_FULL_IN_PACK_ARRAY=1
> 
> GIT_TEST_OE_SIZE=128
> 
> GIT_TEST_OE_DELTA_SIZE=128
> 
> GIT_TEST_VALIDATE_INDEX_CACHE_ENTRIES=1
> 
> GIT_TEST_FSMONITOR=$PWD/t/t7519/fsmonitor-all
> 
> GIT_TEST_INDEX_VERSION=4
> 
> GIT_TEST_PRELOAD_INDEX=1
> 
> GIT_TEST_DISABLE_EOIE=1
> 
> GIT_TEST_INDEX_THREADS=1
> 

Because the test repos are so small (ie smaller than 10K files), the 
test suite already executes as if GIT_TEST_INDEX_THREADS=1 is set (ie 
single threaded).  I added the test variable so that the multi-threading 
code could be forced to execute in spite of the default minimum number 
of files logic.

I'd recommend you set GIT_TEST_INDEX_THREADS=3 instead. (3 because 1 
thread is used for loading the index extensions and we need 2 or more 
threads available to exercise multi-threaded loading of the index entries).

> Thanks,
> 
> -Stolee
> 
> [1] 
> https://public-inbox.org/git/60aae3d6-35b2-94fb-afd7-6978e935a4f7@gmail.com/ 
> 
> 

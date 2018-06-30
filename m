Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADC261F516
	for <e@80x24.org>; Sat, 30 Jun 2018 01:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935211AbeF3BkZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 21:40:25 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40151 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932658AbeF3BkY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 21:40:24 -0400
Received: by mail-qt0-f195.google.com with SMTP id s47-v6so9501885qth.7
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 18:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nV4CjXRTAFvL/aOKG1i8DvUWv58LGg6BpQtaW67+JQs=;
        b=Jw7jTn962Yt/fTXcTqo8Gj2hnu9xRkm5DgnQVxXT3A5NaNKZIui9qvrUNswfJSL1iw
         Js+XWmNk4PtAMhRACFH/i4J/00FlPR+nkx0WnbZzllaahiL9vK2Qi+piWQQNsCRJEj67
         qzBa+MMeY1vf1xtgPawYT3/DH5spn52LS5XPIsGq22LrStYp+BVccNtTxlGGwzPPDp76
         SLh6CRvYf+d0pGZzeyXs3cnKEC9So3uvqbrtn3Ifqsyzwzufs5/g/QH3wz6AEjxWHTaF
         Qro+PoH8Y375AUigIr3XhdWccOLllPgwj/QC/HIbCoLBJX29QAZh46R9foh7SqhhSNT3
         AaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nV4CjXRTAFvL/aOKG1i8DvUWv58LGg6BpQtaW67+JQs=;
        b=Wh6olsVxJ9juWkJCvzSWY3mpbXySqGYwEBGrpfrWeNsYFP84UOO4tnmttCSuDEKRNl
         kaQkQ0sKhT6f66QZb+JPQiKxVUeEJltdFPPw1lGAMebJJuwwc5yoMgjjkDhF6uI7GS6c
         3z8ttICpxFSGB+EZPDcgMOfFZbrPSK5bIjJe2cH3m37VGjpzr8p7JFSj4ArN5hRWHKXE
         RHrSOCrRpwlQNFkd9QLJ6uA9iEoHLkYaMZz16XbaqSXA5sgMTJO/wPT9wEDGURxdiNmb
         e3eTuLhTP8AbWgfjOEFV5Q/bGse3yVKqxHh20egDxyX5/YgcyG9hLlPccJA6vWtg+X9w
         VRKQ==
X-Gm-Message-State: APt69E0DaSsSZEQL28vlMZ9W6fUcF8zeZlUtnWJC6iCLbM/aevVAPPCm
        1E0Lq6wZEoHkt8vGhTQcnj0=
X-Google-Smtp-Source: AAOMgpeZxN41KNoS7SiL8TgK2iWDdFJNvwMAXWTPP8y3yVJ3sh47M1qMyUo5cUVWaoBA+mBzpv/NFw==
X-Received: by 2002:ac8:42b:: with SMTP id v43-v6mr15130062qtg.319.1530322823956;
        Fri, 29 Jun 2018 18:40:23 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id x8-v6sm4712568qth.73.2018.06.29.18.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 18:40:23 -0700 (PDT)
Subject: Re: [RFC PATCH 07/13] test-reach
To:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <20180629161223.229661-1-dstolee@microsoft.com>
 <20180629161223.229661-8-dstolee@microsoft.com>
 <CAGZ79kZpZvaX7Jh7hXPWV+KPffx4m+5W-3Baqd6ggoNnq2Y9hw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3fe0c247-3680-946d-b1d4-f30f85eb78a8@gmail.com>
Date:   Fri, 29 Jun 2018 21:40:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZpZvaX7Jh7hXPWV+KPffx4m+5W-3Baqd6ggoNnq2Y9hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/29/2018 5:54 PM, Stefan Beller wrote:
> On Fri, Jun 29, 2018 at 9:13 AM Derrick Stolee <dstolee@microsoft.com> wrote:
>
>> +# Construct a grid-like commit graph with points (x,y)
>> +# with 1 <= x <= 10, 1 <= y <= 10, where (x,y) has
>> +# parents (x-1, y) and (x, y-1), keeping in mind that
>> +# we drop a parent if a coordinate is nonpositive.
>> +#
>> +#             (10,10)
>> +#            /       \
>> +#         (10,9)    (9,10)
>> +#        /     \   /      \
>> +#    (10,8)    (9,9)      (8,10)
>> +#   /     \    /   \      /    \
>> +#         ( continued...)
>> +#   \     /    \   /      \    /
>> +#    (3,1)     (2,2)      (1,3)
>> +#        \     /    \     /
>> +#         (2,1)      (2,1)
>> +#              \    /
>> +#              (1,1)
>> +#
>> +# We use branch 'comit-x-y' to refer to (x,y).
>> +# This grid allows interesting reachability and
>> +# non-reachability queries: (x,y) can reach (x',y')
>> +# if and only if x' <= x and y' <= y.
> This is an interesting DAG, though not very common
> in reality (81 merges, 18 single parent commits,
> one root with a depth of at most 10).
>
> It reminds me of FELINE as that also has 2 independent numbers :)

The design of this graph is exactly so you (the test writer) can know if 
two commits can reach exactly by whether the two-dimensional keys are 
comparable. It's wide enough that we can come up with interesting test 
cases for some of these walks, especially the have/wants negotiation.

>
> I guess it is easy to make up artificial test cases for that,
> but I wonder if we want more variety for a generic reachability
> test tool (e.g. long chains of parallel histories, octopus,
> disconnected parts of the graph)
>
>> +test_expect_success 'setup' '
> [...]
>> +       git commit-graph write --reachable
> Is this only to test the full commit-graph?, maybe we'd
> want to write out the commit graph at (5,10) or so, such
> that half the walking is tested without graph.
> What about author/commit dates?

There are a lot of ways we can get strange edge cases for commit-graph 
walks, especially when we start being clever. This test case is only a 
start to feeling like we have good coverage, but having a non-trivial 
walk include both outputs (yes/no) for each method is a good start.

I think after we get a basic coverage for these methods on this example, 
we can add examples as necessary when we find tricky code paths that 
need coverage.

Thanks,
-Stolee

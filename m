Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152F31F404
	for <e@80x24.org>; Wed, 29 Aug 2018 12:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeH2QLF (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 12:11:05 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45072 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeH2QLF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 12:11:05 -0400
Received: by mail-qk0-f193.google.com with SMTP id z125-v6so3138249qkb.12
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 05:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dy+5qSyYWXLu+7/4q7qMCqrk6PsmEeceEZuwZan3tG0=;
        b=tKfyWrbL9F5OjGnGNZCbZW52YKi4lpYedb2uFH7dNwK9yiisICxrT6uH+xe58/T9KA
         iKtbp54MD0kyqxkwby9kRdD7qoGRNxgjxdQupAlbFSKbewthANRpKY07cNWoaMl+qALe
         0Cx3IpaeyPiPEZCJvQpMWfbgB8KPiujys6sEXlrSGcyn3i6IqepWYB5MquCmCMj7qB1I
         j26Nmghcc4rgmnUPfsXGiT3zup5/k3Cpa3e07tDEuJIlRpiPLpJX6LwHQzGgZlatNX+L
         hrZpkNa5KNHOkUbcLUYMxEr/lA2Q47q+wNn/n5J5yT/Id/t/d29ZyEmX0i43MJ3UO6aI
         z3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dy+5qSyYWXLu+7/4q7qMCqrk6PsmEeceEZuwZan3tG0=;
        b=WKZC5Sb0oyZmwQDB/esKk5puWctOS/8ogryk6+MUQmnafOewEf0N4MAWon5pQ/8hs8
         TVRurTkjLbKV33AGpmpm5dQROCB9nEH+Hrl7iLCKmJbZaCMeWHKElvc3cc7+3Cay9j6P
         V01O4nrE0MiSOF8ogjvA2nwSl9K/1n6gKURf9nlfvUTSkDPwQ2xrB0y79A+mucoiupsA
         /ScQVL5R1fqnn/Lvrlh2UT0jQSsmPC/c9mu8AEIrimezskk57Najxf56/Slb4/wipCMK
         E5us8zIT2M9E8QTATHwOPwsnhwrSTUQMfPZinDY4ave+wij6QhabLB9rgnblGKkUDm9S
         vwyg==
X-Gm-Message-State: APzg51D1J+67MKmnNlRY7tOYPiNZuAkkzIjgF12kuL+xWjPh7AqzI+38
        Q9O859G+Z9am87qrp2oI3k4=
X-Google-Smtp-Source: ANB0VdbmozlhaRhQDAGwSsGTePkrOj1kWwwCirW/s+JGASnCkPTad9FcUBOlYpZIiFdn1fY8cZp1fg==
X-Received: by 2002:a37:7ac5:: with SMTP id v188-v6mr6061887qkc.262.1535544866801;
        Wed, 29 Aug 2018 05:14:26 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f86b:1660:ae35:a1de? ([2001:4898:8010:0:e1a1:1660:ae35:a1de])
        by smtp.gmail.com with ESMTPSA id n24-v6sm2344268qtf.0.2018.08.29.05.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 05:14:25 -0700 (PDT)
Subject: Re: [PATCH 1/1] commit-graph: define GIT_TEST_COMMIT_GRAPH
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.26.git.gitgitgadget@gmail.com>
 <85d02ac8d8c9a8950ce1a9760a541ff506945de0.1535488400.git.gitgitgadget@gmail.com>
 <CAGZ79kbsJXF=X7tzpdogAY7LdLd87YkPY0euiYaa3uQKQPoZuQ@mail.gmail.com>
 <3bb1d527-87ae-5fdb-be9a-b83f6a68d3a0@gmail.com>
 <CAPig+cSjanDi=jV75PdzYpAjwVgd4Suh3UyvY+Vy7yeHAuY8RA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <42329f9c-c4b5-f5fd-54cc-6b94b74574dc@gmail.com>
Date:   Wed, 29 Aug 2018 08:14:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSjanDi=jV75PdzYpAjwVgd4Suh3UyvY+Vy7yeHAuY8RA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/2018 5:59 PM, Eric Sunshine wrote:
> On Tue, Aug 28, 2018 at 5:31 PM Derrick Stolee <stolee@gmail.com> wrote:
>> On 8/28/2018 4:41 PM, Stefan Beller wrote:
>>> On Tue, Aug 28, 2018 at 1:33 PM Derrick Stolee via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>>>> +               GIT_TEST_COMMIT_GRAPH=0 &&
>>>> +               test_must_fail git merge -m final G
>>> This could go on the same line without the && in between, setting the
>>> variable as a prefix.
>> It cannot! The Linux build I ran complained that you can't put
>> environment variables through test_must_fail.
> Is GIT_TEST_COMMIT_GRAPH exported? If not, it won't have an impact on
> git-merge anyhow.

In my testing this changed the behavior from fail to pass when passing 
GIT_TEST_COMMIT_GRAPH=1 from the command.


> As for the special case of one-shot environment variable and
> test_must_fail(), you'll find "env" used as a workaround in a number
> of tests:
>
>      test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git merge ... &&

Thanks for this! This is clearly the better solution.

-Stolee


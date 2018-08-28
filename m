Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F521F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeH2BZQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:25:16 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:43605 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbeH2BZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:25:16 -0400
Received: by mail-qt0-f173.google.com with SMTP id g53-v6so3484256qtg.10
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Tm1nudEJ74lf3zQRdpcCoHvY/2EblVHy7btvdszEO9U=;
        b=eB7RPBbFY5S5wz70RTe7MyPeuzmUWAf7fl8OwutN82H0Vw9l3VaBUfWXxSIk6QEkWt
         OIH1lWfCF2+ql6CDcg5A/jtJp16w6AKh/7BCYts/9R0S4JReGnWZifUpUA6azGe6poVH
         zuUTthzFMlFJohlLnRNOYhkjxkY6V2fR+1dRDsm33ydZdOCo08lHlH7ZPriYhp+4qVNb
         Q/mLIMwjL+JApeNW/HKJCuYFI1yLQ3juLNgo32XI3gboWLsBnyR13akgk32rON+I5MFH
         x75FUJljdbWq16NpdjnrqCA0GPoh5/IcuOfjbBCSTQTHPYy94bWvNGkbOe2h7ntIOvJQ
         Tmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Tm1nudEJ74lf3zQRdpcCoHvY/2EblVHy7btvdszEO9U=;
        b=BXg+ogZh5UFfQeQpD20mYepS6d/Gxbb6PL0bJ2sGqOmrIt30sJfBXIInagLZFLyE9y
         7TO7XLyk+2zJgfFWmmeEe6Jk8DRNDq+sdSP9bCVho0VtEu0MStK7iu84DLogv5nC1T4l
         4UOWVgKrsp3XZjqYnIagej3NT6RclWFHK/5lP0NBzOs5l40CWKdBrBtumK4PK9YExo8m
         1S2d1WreLxvUM6g/Ocy01WtkOq7IIh0IRDo72lXm6/dfO8YLxnWDchKJngmvTnStI0HR
         qDbJtQ2FffsaAesJ0Xtss/GclZA4LQoOdwQVGxTSY85peOSbwTGPXHMlceCugocU1x3N
         hp6w==
X-Gm-Message-State: APzg51CH3JyzBozg7IpldjDXiTGb40WF07Jt+GXwmeeGweloRTDAia6/
        9zuGBd7VRwJOIU8JLSxrTZY=
X-Google-Smtp-Source: ANB0VdZBDZddggSC2G9sjgQzJA9eceRUI1hELboGKCASY7+AnHL/URxHD7qGx2fYVvH38DOqR7RF4g==
X-Received: by 2002:ac8:1b5b:: with SMTP id p27-v6mr3712402qtk.99.1535491902991;
        Tue, 28 Aug 2018 14:31:42 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id m5-v6sm1443863qkh.30.2018.08.28.14.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 14:31:42 -0700 (PDT)
Subject: Re: [PATCH 1/1] commit-graph: define GIT_TEST_COMMIT_GRAPH
To:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.26.git.gitgitgadget@gmail.com>
 <85d02ac8d8c9a8950ce1a9760a541ff506945de0.1535488400.git.gitgitgadget@gmail.com>
 <CAGZ79kbsJXF=X7tzpdogAY7LdLd87YkPY0euiYaa3uQKQPoZuQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3bb1d527-87ae-5fdb-be9a-b83f6a68d3a0@gmail.com>
Date:   Tue, 28 Aug 2018 17:31:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbsJXF=X7tzpdogAY7LdLd87YkPY0euiYaa3uQKQPoZuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/2018 4:41 PM, Stefan Beller wrote:
> On Tue, Aug 28, 2018 at 1:33 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The commit-graph feature is tested in isolation by
>> t5318-commit-graph.sh and t6600-test-reach.sh, but there are many
>> more interesting scenarios involving commit walks. Many of these
>> scenarios are covered by the existing test suite, but we need to
>> maintain coverage when the optional commit-graph structure is not
>> present.
>>
>> To allow running the full test suite with the commit-graph present,
>> add a new test environment variable, GIT_TEST_COMMIT_GRAPH. Similar
>> to GIT_TEST_SPLIT_INDEX, this variable makes every Git command try
>> to load the commit-graph when parsing commits, and writes the
>> commit-graph file after every 'git commit' command.
>>
>> There are a few tests that rely on commits not existing in
>> pack-files to trigger important events, so manually set
>> GIT_TEST_COMMIT_GRAPH to false for the necessary commands.
> So the plan is to turn on the commit graph for the whole test suite
> excluding these selected tests?
Excluding these specific _steps_, but yes.
>
>> +               GIT_TEST_COMMIT_GRAPH=0 &&
>> +               test_must_fail git merge -m final G
> This could go on the same line without the && in between, setting the
> variable as a prefix.

It cannot! The Linux build I ran complained that you can't put 
environment variables through test_must_fail.

-Stolee


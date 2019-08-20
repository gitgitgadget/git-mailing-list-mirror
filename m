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
	by dcvr.yhbt.net (Postfix) with ESMTP id 922A61F461
	for <e@80x24.org>; Tue, 20 Aug 2019 12:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfHTMyX (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 08:54:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43269 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTMyX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 08:54:23 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so4345880qkd.10
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 05:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=omJzIIcpWVAIy9hQibS5MkKm0az0A5z2jWbF2YqUDJQ=;
        b=DrH4fQBQrkslYuS1mN9wmG7Rd9TjCmmfcrgVXKQBVC4xUrl084bNCLRDc85YFj0gIm
         3m5exRimmwII6q0ML9ji7TM/7U0RFr0FD9c6Ca+3V/L+ufFdWZDDwkKQhYgYpBUMMtQj
         eeqMrCPvbzqvi0UNy/0/sbfJC1BSdtmhgHfi/G5ANt+HBd7uaAfRGr00/AcN/epJQUFe
         i3i9ibt30hL6IaXGRWW3ns496mjRHc4+HsRpPrTKZeTB07ydgWOuGWPKD/493D3H4vYh
         06L8UoOY9/ZjgVvSZHTSuRFcrAc/2iTCC43JJgqu3MalUydS8yBaxnQePw4DsgGSbfZa
         N/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=omJzIIcpWVAIy9hQibS5MkKm0az0A5z2jWbF2YqUDJQ=;
        b=UfBcoJDHazMbu0PfZvULnmQUEMfGcQt1jXLrvMWRnLt7XEoRCZAFX7h9CwN2Uc11dq
         20AWMq4HDWvxYJnABxmItpe8p5wWG8zd2j+pHhBkYgVdy+n3+j7c1u1jBp4b7b1Gxt82
         YOm4irTHlEW9oiTEFAY/nFK96VzMxzysZ4kM1nhCkfQoOFiRjEB1kYLOMvbcwA20BNLz
         wmV+6BKuLIrsRoPO6eArIQE1OUENFMGSrLwgXOylOIA1YQRBS3YFx4xqEMiRFVn+Ipry
         tYGqjypcG/LF9TBOihCLmWhaKykf4F9eW9/ZDJvqJDgOPyXzgYd+Ui+6oeDyXxDu7Fms
         Mgwg==
X-Gm-Message-State: APjAAAWNOoL+Pdvynd2NMomaXU3ymSpXAVUS4n1mQjIQVX2sI5BH1E2T
        fdaSa9GcZUdHJeGzJfY1RFFV90xJoKM=
X-Google-Smtp-Source: APXvYqzBZbQBHIGW6SNRvVaTAqHXiX5hEl+hysWoQzDjHnZ3T4SbQcDjLsBFHtM96Kp0aQ4iTlN3UQ==
X-Received: by 2002:a37:445:: with SMTP id 66mr25046805qke.156.1566305661749;
        Tue, 20 Aug 2019 05:54:21 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:5ff:3a8e:8e40:6517? ([2001:4898:a800:1012:b732:3a8e:8e40:6517])
        by smtp.gmail.com with ESMTPSA id o27sm8344905qkm.37.2019.08.20.05.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 05:54:21 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Thursday, Aug 15)
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <6dd8797a-289d-cabb-d4c3-761b9f9d3ca0@gmail.com>
 <20190816181103.GA13894@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a081ccdb-bb0d-00a1-136a-c8fa54296639@gmail.com>
Date:   Tue, 20 Aug 2019 08:54:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190816181103.GA13894@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/16/2019 2:11 PM, Jeff King wrote:
> On Thu, Aug 15, 2019 at 10:01:04PM -0400, Derrick Stolee wrote:
> 
>> Here is today's test coverage report.
> 
> Are the scripts you use to generate these available somewhere?

The scripts I originally used are available in contrib/coverage-diff.sh.

However, to allow for some more advanced workflows, I created the following
C# project: https://github.com/derrickstolee/git-test-coverage/tree/master/TestCoverageReport

The runs are done via the following Azure Pipelines build:
https://dev.azure.com/git/git/_build/results?buildId=879

There, you can see how the code is built, tested, and the gcov output
is collected in the TestCoverageReport tool to generate the .txt and .htm
files.
 
> I think it's useful to look at uncovered code, but I often struggle to
> figure out whether the parts attached to my name are relevant. In
> particular, I think two changes to the report format might help:
> 
>   1. Include names alongside commit ids when listing uncovered lines. I
>      know that will end up with some overly-long lines, but it makes it
>      easy to grep for one's name to find relevant sections of the file
>      (as opposed to finding your name at the bottom and
>      cross-referencing with actual content lines).
> 
>      Seeing that an uncovered line is a BUG(), for example, makes it
>      easy to know that it's not really an interesting uncovered case in
>      the code.

The HTML reports [1] have the following feature: click on a commit in the
commit summary and it highlights the lines from that commit.

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-08-15.htm

However, the plain-text report _could_ add names. Maybe instead the report
should just group the output by commit instead of branch.

>   2. Include more context. Just taking a random example from this email:
> 
>> builtin/rebase.c
>> e191cc8b 129) strbuf_addstr(&buf, strategy_opts);
> 
> We know what the uncovered line was trying to do, but more interesting
> is likely the conditional that causes it to be uncovered. In this case
> the surrounding code is:
> 
>           if (opts->ignore_whitespace) {
>                   struct strbuf buf = STRBUF_INIT;
>   
>                   if (strategy_opts)
>                           strbuf_addstr(&buf, strategy_opts);
>   
>                   strbuf_addstr(&buf, " --ignore-space-change");
>                   free(strategy_opts);
>                   strategy_opts = strbuf_detach(&buf, NULL);
>           }
> 
> even the usual 3 lines of diff context would make it a lot quicker to
> understand what's going on (it only kicks in when multiple strategy
> options are used).

In this case, the additional context helps, but only if you expand by
several lines. In other cases, the necessary context could be dozens of
lines.

Perhaps a deeper report could include something like "git format-patch
--function-context" to naturally extend to the appropriate context. It
may be better to have a "block context" for these conditionals. In such
a case, it would be important to mark the "new" lines explicitly so the
context lines don't become too noisy.

> (As an aside, this code leaks the newly allocated buffer and leaves a
> dangling pointer in opts->strategy_opts, but that's all orthogonal to
> the uncovered line; I'll send a separate message to the original
> author).
> 
> 
> Anyway, I wonder if we could adjust the output of the script to make
> reading it that way a bit easier.

I'll think about this, for sure. When I have time to go deep into the
report (not just the code I wrote) I look for lines that seem to be
non-trivial, then go find their context by looking at the commit.
Here is another example of why the HTML report is helpful: it will
link to the commit diff view [2] or the exact line of the file [3].
(Note: the exact line link only works if we point to the branch that
was tested, not the commit that made the change.)

[2] https://github.com/git/git/commit/e191cc8b8080f63a0080031bf1276269c6bf42dd
[3] https://github.com/git/git/blob/6cf2e4a04610efe882eb663cd36436b80b343fa0/builtin/rebase.c#L129

Thanks,
-Stolee

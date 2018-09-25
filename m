Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24D31F453
	for <e@80x24.org>; Tue, 25 Sep 2018 00:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeIYGil (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 02:38:41 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:38895 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbeIYGil (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 02:38:41 -0400
Received: by mail-qt1-f173.google.com with SMTP id z13-v6so11588244qts.5
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 17:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=BNSCRIJSeBu0JRgz6ajGp1QTPRm3F1fbY4Ih3JyGsKI=;
        b=kCbz5O/Oyvw6CWzTapIMN5pBtQhaPXTZeZsd0V9eqv/z8QkAk9ijEiC78Qnx2H6Qw+
         WsmpN7ivsFpbrts6nE16usWxGzO75Q1MPQhDpAfl+26/WTeJz5KJat7zpYxpuLeHZOp6
         qy2bWgIpFFHhI6eU8IbXAK0+NtYcKLPUHoOrQ2iPJVnCH68QPPcq32RnnrCeHewkTsXl
         aIpjIFhN5CBphjq6h749MSsklMzbJZ1sgONO7dX9F3uOFNdDSCu2wBnKvu6PDaZFoAaI
         UKzEYytKH4XXzrGQaggE6nFPMdyNMreZepU0r92fia7v5PKf5LMA0/kFOovrMPtde+MD
         gAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BNSCRIJSeBu0JRgz6ajGp1QTPRm3F1fbY4Ih3JyGsKI=;
        b=k2Zr/3rNAXj5m7b6H514a98ar5NJ0BgfD6WL7CfIMY0aGGj9wZ+uNlshllteO/5tFU
         eAQTclRiKjwgClMfx8fR+QuPDmevrlfnyCkbjvsSqih6JEpvANaG2jpYbfuL3Sx7iYgC
         TBHdPwM1+jf26Wd5VjvJb9QGI5uJXFGK3ZwfWFBb5EKyib6MKWV/mqpvslnOk8a0Rnmm
         TKrXhsX3li1X1QtPOB2O/3Y9PWFaJbsFT83p1zS8loVJxPcoz1S6SSRSPJ40w6qNAoqu
         SXozgHy2UF4tV+1Ug7M+JMnFEFfaBDBy3/hCa3wBH/nqirhNetybAWUFf5n718+eBmeV
         Wtsg==
X-Gm-Message-State: ABuFfojMcpE4zX+vlDf+6waVxw7igYylE8OM9xQBYQ2F4EEfg3672pZE
        rBFTk0nCNZxHiUBOPf6ozQ2nvx1UEF8=
X-Google-Smtp-Source: ACcGV63JfCfu1+BzgV5oFcAPZvu7xjNk5p4KPWHhrz7DGiyVSuiL+Pb3R1Y60Dvh/kltT9wMZ12kbw==
X-Received: by 2002:ac8:3790:: with SMTP id d16-v6mr1100580qtc.128.1537835630909;
        Mon, 24 Sep 2018 17:33:50 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id 80-v6sm449368qkj.75.2018.09.24.17.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 17:33:50 -0700 (PDT)
Subject: Re: What's cooking in git.git (Sep 2018, #05; Mon, 24)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqmus6r1ml.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4768f982-51bd-aeec-9b6b-fc36f2f512f3@gmail.com>
Date:   Mon, 24 Sep 2018 20:33:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqmus6r1ml.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/24/2018 6:06 PM, Junio C Hamano wrote:
> * ds/reachable (2018-09-21) 2 commits
>    (merged to 'next' on 2018-09-21 at d4cd62108e)
>   + commit-reach: fix memory and flag leaks
>   + commit-reach: properly peel tags
>
>   Recent update broke the reachability algorithm when refs (e.g.
>   tags) that point at objects that are not commit were involved,
>   which has been fixed.
>   Hotfix for a topic already in 'master'.

Sorry that I took so long to reroll a v4. The changes from v3 to v4 are 
mostly cleanup, so I'll send those as a single commit later, and they 
don't need to be rushed to master as nothing is broken in the version 
you merged.


> * ds/reachable-topo-order (2018-09-21) 7 commits
>   - revision.c: refactor basic topo-order logic
>   - revision.h: add whitespace in flag definitions
>   - commit/revisions: bookkeeping before refactoring
>   - revision.c: begin refactoring --topo-order logic
>   - test-reach: add rev-list tests
>   - test-reach: add run_three_modes method
>   - prio-queue: add 'peek' operation
>
>   The revision walker machinery learned to take advantage of the
>   commit generation numbers stored in the commit-graph file.

I've had limited review of this topic that is very exciting (to me). I 
know that last commit is a bit daunting, but I'd love someone to take a 
look.


> * ds/format-commit-graph-docs (2018-08-21) 2 commits
>   - commit-graph.txt: improve formatting for asciidoc
>   - Docs: Add commit-graph tech docs to Makefile
>
>   Design docs for the commit-graph machinery is now made into HTML as
>   well as text.
>
>   Will discard.
>   I am inclined to drop these, as I do not see much clarity in HTML
>   output over the text source.  Opinions?

Just a reminder that we agreed to drop this series.

Thanks,

-Stolee


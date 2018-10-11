Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E9641F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 11:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeJKSm7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 14:42:59 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:45464 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbeJKSm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 14:42:59 -0400
Received: by mail-qt1-f178.google.com with SMTP id e10-v6so9280370qtq.12
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 04:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=DsUN14i60rOX4ufgCG2LCvaiFhBNPrM9HnvOLVnveNE=;
        b=PxcoHEzQJB7ScecylD9Mw8cSTJO0R65jgvdTuXASTNWg9Du95rBzDKCiWp8VuVl3oH
         hHOUs9jw3GoA9DFqQDksiephuXZBbvDTXvHVpdSx3TiKCSI74Iun2lAryxyDmCsI4MbU
         YBn1pFCieKvjr91m8w9c5FN0sX3TnkmcHQ2T5wZgd6NU0G9M5wLJ7JV7y5xIImHxrvBl
         FVyFMv5jtMoMQovSJKPXEHjDupRDyhA6lOIcpQ6w63XjdH0x3k2gExbXwKUB+gLLMGKy
         DMYZt2RAyCbZher1IX29wbG9gH1XGqolFiMoSfXQS/V0Npb3SmNfjQb/CQCtZmY595hJ
         sILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DsUN14i60rOX4ufgCG2LCvaiFhBNPrM9HnvOLVnveNE=;
        b=doWPCyjE+IZ1Ix1LVCHhNF1UhIHcCoDa/y/1CFU2IdgWkC3UwQmeXphMxSIcFcW9ah
         nkR5/Pw5LGDjIuJGSIfja6/KW9SZUEPObCJup+sXZ04nAgMCrtr0KecHvNkExKiU93DF
         a3GM1QmqcTS9gidfr2ykpTZaxG7oyIGyS0HFvl+BJhLDMYPh/N3Zq7UaqnfAxKAqy47f
         d9NxUfJsLo2lGR3z+vSweodpPfIy+TMi6QX6SOxS/e904IqLipjwi9iMVKP20M63E+JB
         pdN7JjJmoxidrTcPz4DIjbyxgtqJoNKQDaMIK3A/eg08PbpGWSrYcRZEIsKVIV0mjsXX
         uVvw==
X-Gm-Message-State: ABuFfoiXH05UG3TYyZmVeFb/mx4qg7z3NHkWsKQEjV5nAwzV2TLw8MHd
        vVwHhxC2gsphJ5fpvzCsiYnrPr1W
X-Google-Smtp-Source: ACcGV60I0zU9Ohx8+WWkwnBAkWyIEywLtqwjuV4LAB5luBxFH1GPO1Qj+Rn4cHexUfD+yPVo21RtOA==
X-Received: by 2002:aed:2dc6:: with SMTP id i64-v6mr991911qtd.229.1539256571944;
        Thu, 11 Oct 2018 04:16:11 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id f11-v6sm10310543qkb.47.2018.10.11.04.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 04:16:11 -0700 (PDT)
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <dfa79ba2-0dba-1d74-1a81-543902d20bef@gmail.com>
Date:   Thu, 11 Oct 2018 07:16:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2018 1:43 AM, Junio C Hamano wrote:
>
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
>
>   What's the status of this topic?
I've reached out for review, especially on the rather large patch 
"revision.c: refactor basic topo-order logic" but have received no 
messages about it. I don't think anyone has even done a cursory style 
review.

I really think that this is a valuable topic, and it would be nice to 
have in 2.20, but I'm not pushing to merge something that no one has 
reviewed.

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
These have been marked for discard for a few weeks. I agree they should 
be discarded.

Thanks,
-Stolee

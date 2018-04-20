Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F821F404
	for <e@80x24.org>; Fri, 20 Apr 2018 18:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753623AbeDTSTO (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 14:19:14 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:44072 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbeDTSTN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 14:19:13 -0400
Received: by mail-qt0-f175.google.com with SMTP id j26-v6so10787682qtl.11
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 11:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p2aEbzuyXZZ+roRnrh3+lkDsrMQC63x2wFNQgvPGkro=;
        b=OyTqkdn9oY9/5gAwNqj5mRM62Mwh8UkSPJG8CIUHuoB2yfMD3Lm0jBqb9Mg9Y271VW
         jUY7YU7BRC7tgMdZAnRSeZc8L3Vw6jk+f4MDytdrzkQielcON4QAs+l5l6kbSwpeNkp6
         SYPd61KfcBb9SgDx0+wzNmj+JtXq5xrx+1WmD8UlNh4yGFq5EhvW9nDdWH76JTy5byHk
         YHemOFNhG/IMYPYASFqsBsuEQIDux/mLehmxidw1LRzLNSPnTxCApOVtit7SN+zOqE5H
         RAXUIRFsaipfpByOOI+bmb2kPrpsscYNslAgli+S8wXrF8zzkxf0FrvCFJCPffQrFWRm
         x7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p2aEbzuyXZZ+roRnrh3+lkDsrMQC63x2wFNQgvPGkro=;
        b=s2qZtCt5EebZKQpqD1O8I+/JJIAyv2kYF4t6uVdfR9Pbns3BGhK2TdmQacP5vBlARw
         bzKOpYVSq41DUxf4lt3RtK/6uTQ9aYtI1pdREj1uFTj4T53yVpEA+m9DoLGEdZ/KaPV9
         3nCDd9lE+nBNHVvR00cEig8x6VYo+TC4y2UJhUmlVCv6bamspKX1hPz6M5GfM1z0W0G+
         khAn1W9HyuB7a4OiACM3/bw8q7gIMhElUQk5fFgFE6OCujj6eqEH9X1yiSsm5xs16NrK
         4rtxzcARh7LdFgSfS3zrgNgOI1g0/9o/vsF9fNU61u6LwaDUNAXPxhbFjGu/ujqc7A3Y
         6oFQ==
X-Gm-Message-State: ALQs6tAkWkyCX6eE8hu9G8WS7CN6noW7zAz2nJNCXWA54u5v5joFyE0Q
        bu+k5vFt+3pXJ+wnpcxIMuA=
X-Google-Smtp-Source: AIpwx4+e/zR9/Pq3YqyqnX6a/IvuROr3TI90R8aoIYjsxDUJ/tkbo2mwhq1WnjBIkzwMjpVLiuOIrw==
X-Received: by 2002:ac8:4293:: with SMTP id o19-v6mr12171890qtl.321.1524248351942;
        Fri, 20 Apr 2018 11:19:11 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id o3-v6sm5342090qtp.72.2018.04.20.11.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Apr 2018 11:19:11 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] add additional config settings for merge
To:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <CABPp-BEwwn+NwOEtWOKOdUKxoXfq6YwWeoH6OwkPjSwVtTm5=Q@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <e580712c-b375-c07e-a02e-5bb63a914611@gmail.com>
Date:   Fri, 20 Apr 2018 14:19:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEwwn+NwOEtWOKOdUKxoXfq6YwWeoH6OwkPjSwVtTm5=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/20/2018 1:34 PM, Elijah Newren wrote:
> On Fri, Apr 20, 2018 at 6:36 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
>> This enables the user to set a couple of additional options for merge.
>>
>> 1. merge.aggressive - this is to try to resolve a few more trivial
>>     merge cases.  It is documented in read-tree and is not something you
>>     can pass into merge itself.
>>
>> 2. merge.renames - this is to save git from having to go through the entire
>>     3 trees to see if there were any renames that happened.
>>
>> For the work item repro that I have been using this drops the merge time
>> from ~1 hour to ~5 minutes and the unmerged entries goes down from
>> ~40,000 to 1.
> 
> Ooh, this is *very* interesting.  Is there any chance I could also get
> you to test performing the same merge with the version of git at
> https://github.com/newren/git/tree/big-repo-small-cherry-pick and
> report on your timings?
> 

Unfortunately, it isn't quite that simple.  My repo is _really_ big 
(3.2M files and ~100K commits per week) and requires me to use a custom 
fork of git that works with our GVFS solution for it to work at all.

I've been watching your work in this area and am hoping it pays off for 
us if/when we have users that want to do rename detection and override 
our defaults.

> The 'big-repo-small-cherry-pick' name could be improved, but that
> branch has a number of performance fixes for really poor rename
> detection performance during merges.  From your description, I'm
> pretty sure it'll apply to your case.  For my specific testcase,  I
> got a speedup factor of 30.  Someone else on the list saw a factor of
> 24[1].  Results are highly dependent on the specific repo, but it's
> certainly possible that it gets much of your factor of 12 speedup that
> you saw with these new config settings you added.
> 
> However, what makes this case even more interesting to me is that my
> branch may not be quite as effective as your workarounds.  There are
> other other performance issues in merge that I am aware of, but for
> which I haven't had the time to write the patches yet (I've been
> waiting for the directory rename detection stuff to land and settle
> down before working more on the performance aspects).  I do not know
> how big a factor those other performance issues are, but your
> workarounds (namely the aggressive setting) may get around some of
> those other issues as well, so I'm very interested to see how my
> current branch compares to the speedups you got with these settings.
> 
> Thanks,
> Elijah
> 
> 
> [1] https://public-inbox.org/git/alpine.DEB.2.00.1711211303290.20686@ds9.cixit.se/
> 

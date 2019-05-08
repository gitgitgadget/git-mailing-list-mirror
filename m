Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C03321F45F
	for <e@80x24.org>; Wed,  8 May 2019 19:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfEHTAO (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 15:00:14 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37380 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfEHTAO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 15:00:14 -0400
Received: by mail-qk1-f196.google.com with SMTP id c1so3821082qkk.4
        for <git@vger.kernel.org>; Wed, 08 May 2019 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s7dQ1XwYR3JvfIL85pdKWBYBU0822GjiC1POfwk0fm4=;
        b=AyUTCXveGh7UxS/gZd4o1s7r5QiEEqKtZ1Wmb40MQTAJ5q4rfOnkJw8FOe2dqmyxg9
         bdzRaGMSUpQZj8zVEFiDVl7vCybsj87Q6AcT0Kl2ylykE3huqKJifYTCK82qLVAZ4f8H
         J/okJA4yphCh4BRtzRCOYbJaljf7r4t2/YgqjgA8xPLfTlqvYNhJgTfgRbLpRN+kIIUT
         /r7C3glan/61ygY4nu01S68B+7iMue/pvTcUTzG0JQ+Kb58mic/0HYZgSADcQTIa13SN
         IF8w5VjO6revq8qF/LrSTNKB6ImW6Dc81CwKtNyd2SShfTsZdZ/PTlzlhJMz2oHxzFzm
         dkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s7dQ1XwYR3JvfIL85pdKWBYBU0822GjiC1POfwk0fm4=;
        b=EK8GcwwDdwcXfp9l/RvgKA1HWFqzRevQoUwNPoEuXmTq5PMh0uivIzbF3GkSuQAyWI
         x9gz+FQTKTfS4/3rBS7wONj0jdX69FBDdh/nU8bl34Z2+V8Jj8dJ4It2xSMbjxCm6q44
         xKdjAqpPBeX6SjAS9527k9DYyzBtf5b9J1uD1ykzUa5VLk/hkkCCsoxzMkynu7GMf8Qo
         bVZsqgFyDJ/d4x3zlT313pmGKgmeu5M/pgXb0YPb5hJ2nlq9yn92vIaTtEXjEKApHv33
         shakeWLkhbZ+ZhofvhAvAt5wIoq1u/ortHh7US0sqz98nuwickclcpK1oOtzITCu25bz
         dGTw==
X-Gm-Message-State: APjAAAXm344VHK/+0KHWGf869dujKiz+rWgU/GR7xfIF6/iqSyl+M0Wf
        5fglP9qljYOUiL9+qBQZmNA=
X-Google-Smtp-Source: APXvYqzRc5+vGNK6tuJz+R+hngpiqFNEbYr9tUY+TadJAbE7jhpZWRDowhLrz6/U52/K5pN3wplVqA==
X-Received: by 2002:a37:9103:: with SMTP id t3mr32127936qkd.78.1557342013417;
        Wed, 08 May 2019 12:00:13 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d14c:17a3:d28e:9336? ([2001:4898:8010:2:ba80:17a3:d28e:9336])
        by smtp.gmail.com with ESMTPSA id e131sm9707582qkb.80.2019.05.08.12.00.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 12:00:12 -0700 (PDT)
Subject: Re: [PATCH 12/17] Documentation: describe split commit-graphs
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.git.gitgitgadget@gmail.com>
 <7bbe8d9150a623ea684c94d129eda1607dd32a79.1557330827.git.gitgitgadget@gmail.com>
 <20190508172029.GP14763@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d5ef1bcb-a910-295f-fc95-e461d34f3883@gmail.com>
Date:   Wed, 8 May 2019 15:00:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190508172029.GP14763@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/8/2019 1:20 PM, SZEDER Gábor wrote:
> On Wed, May 08, 2019 at 08:53:57AM -0700, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
> Consider the following sequence of events:
> 
>   1. There are three commit-graph files in the repository.
> 
>   2. A git process opens the base commit-graph and commit-graph-1 for
>      reading.  It doesn't yet open commit-graph-2, because the (for
>      arguments sake not very fair) scheduler takes the CPU away.
> 
>   3. Meanwhile, a 'git fetch', well, fetches from a remote, and
>      upon noticing that it got a lot of commits it decides to collapse
>      commit-graph-1 and -2 and the new commits, writing a brand new
>      commit-graph-1.
> 
>   4. A second fetch fetches from a second remote, and writes
>      commit-graph-2 (no collapsing this time).
> 
>   5. Now the crappy scheduler finally decides that it's time to wake
>      up the waiting git process from step 2, which then finds the new
>      commit-graph-2 file and opens it for reading.
> 
>   6. At this point this poor git process has file handles for:
>   
>      - the base commit-graph file, which is unchanged.
> 
>      - the old commit-graph-1 which has since been replaced, and does
>        not yet contain info about the old commit-graph-2 or the
>        commits received in the first fetch.
> 
>      - the new commit-graph-2, containing info only about commits
>        received in the second fetch, and whose parents' graph
>        positions point either to the base commitg-graph (good, since
>        unchanged) or to the new commit-graph-1 (uh-oh).
> 
> What happens next?  If this process tries to access the parent of a
> commit from commit-graph-2, and the metadata about this parent is in
> the new commit-graph-1, then I expect all kinds of weird bugs.
> 
> But will a git process ever try to access a commit that didn't yet
> existed in the repository when it started opening the commit-graph
> files?

I'll ignore the improbability of this turn of events (two writes happening
during the span of trying to read two files) and focus on the fact that
we can prevent issues here using the 4th TODO item in my cover letter:

 4. It would be helpful to add a new optional chunk that contains the
    trailing hash for the lower level of the commit-graph stack. This chunk
    would only be for the commit-graph-N files, and would provide a simple
    way to check that the stack is valid on read, in case we are still
    worried about other processes reading/writing in the wrong order.

If we have this chunk -- you have convinced me that we need it -- then we
could ignore the "new" commit-graph-2 because its base graph hash does not
match. We can continue without dying because we can always parse the "missing"
commits from the packs.

Thanks,
-Stolee

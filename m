Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC42B1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 16:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeGIQNe (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 12:13:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41154 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932770AbeGIQNd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 12:13:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so5064515wrr.8
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0tSE5wwpoLjAKfkeN462Icf7QMUJz7/mV5foXq3SvvM=;
        b=XK/y4U3pRi7TkuAT8RnyNmI60vAAdzpufys63E1a/j5pGUEKCenp0iEsjCC30JdO20
         Hy3UfRVlIzP+NOfg1sfUA8tz8jqy6f/97xeKjUgogCAiL7To4mFHl2CDNF65aq3Gp3Qf
         doN2EJN2/DH5aJ42O52Hj+ojSp0Eqe1SltktE26F/iRnm1vP6GoOSNiAtVscv3gq0x8G
         iTgfMEgDaXy8WNmcMG503IDfLBYidTTyuf6q5aXMEMyQZox33T2uLsqloK4ofXzcfRI5
         10EfBUahypjymUc3XIamlCd0t35FFgez9eJcVojErsFOpjC85V0JkSKq0Mb4P0uCshOb
         6SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0tSE5wwpoLjAKfkeN462Icf7QMUJz7/mV5foXq3SvvM=;
        b=buoiHetOQ1Eo2sbjGWJSuQYYnOwaT0cV7dUSjyKpS+8/4qsGHZakmzvfvLjidFygAT
         xKtUDtJYMIRX2N6vqvAkI5wYbCpwVl0XncMpTdh/CIqUsqz9DacbO5UhSdL6rQqiwceu
         By5m34BerZnLkTknVScSH32Y9zeXWK9R2Sq/ro8TtCatU72KVvejD6nV6kRpIVcYG960
         +MsHArCMfZr8dDYMrsJXOco4cfWEHFZNp+WzchXDPvQE46nIvkLCGPr49t3bB1UIPqWY
         49jeyDdAGrhVeMK/PxAaiPRPzZVjHcwVVsD5GWIzNz3kIEMMJRKIlxyOnfyidL7cA77z
         g3Yg==
X-Gm-Message-State: APt69E15uBHLTrDFaKSW/LgQi9KJSnDsMTjlYVnRNlGoAbD6kc/OOprJ
        VauVisRyMJ0ZPh4M8mWfh6c=
X-Google-Smtp-Source: AAOMgpcL2/b30LY2w7Y/Oo6p9NryokU/LGWOk8BlkfWaCvAmUnTvag1xYLi5DzjAlTakRUSTR1vGBg==
X-Received: by 2002:adf:b002:: with SMTP id f2-v6mr15964369wra.75.1531152812473;
        Mon, 09 Jul 2018 09:13:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w24-v6sm13263142wmc.15.2018.07.09.09.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 09:13:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's (not) cooking
References: <xmqqlgaogeff.fsf@gitster-ct.c.googlers.com>
        <3d8bc7b8-b7be-4583-469e-6b962607b3a7@gmail.com>
Date:   Mon, 09 Jul 2018 09:13:31 -0700
In-Reply-To: <3d8bc7b8-b7be-4583-469e-6b962607b3a7@gmail.com> (Derrick
        Stolee's message of "Mon, 9 Jul 2018 09:50:24 -0400")
Message-ID: <xmqqlgakfkus.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 7/6/2018 6:57 PM, Junio C Hamano wrote:
>> I'll be pushing out the integration branches with some updates, but
>> there is no change in 'next' and below.  The following topics I gave
>> a quick look and gave them topic branches, but I had trouble merging
>> them in 'pu' and making them work correctly or pass the tests, so
>> they are not part of 'pu' in today's pushout.
>>
>>      pk/rebase-in-c
>>      en/dirty-merge-fixes
>>      en/t6036-merge-recursive-tests
>>      en/t6042-insane-merge-rename-testcases
>>      ds/multi-pack-index
>
> I tested merging ds/multi-pack-index against the latest pu and the
> only issue I had was with header files being added to 'packfile.c' and
> 'building/repack.c'. Both were that I added "#include <midx.h>" and
> cc/remote-odb added "#include <remote-odb.h>".

I think ds/multi-pack-index didn't have any difficult textual merge
conflicts.  I ran out of time making 'pu' build with new topics and
listed the ones that were left behind.  As Elijah already
identified, there was a bad apple not listed above that was in 'pu'
that made the tests fail, so the above is not even a complete list
of "bad" topics.  It was merely an "I have them but 'pu' doesn't
include them" list.

Thanks.

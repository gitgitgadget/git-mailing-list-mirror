Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1CA1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 13:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJOVIg (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 17:08:36 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:44746 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeJOVIg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 17:08:36 -0400
Received: by mail-qk1-f177.google.com with SMTP id y8-v6so11759667qka.11
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GKoCtNHPnOD023vXkECrdJRyfW2QLPSb0USAQ19oV0o=;
        b=lLBZS0ygIrG4evCX6vxL6h2fmZNsXom9XlBzCefRld57E3roFJBaInCevGjBe3bawr
         pkib//f+67ixVTzgeza/T8spBciMsDscem5z6XaMydBWFY4HS/irr/Ts4p2XoncBtDnw
         AcGe9oNByL1/axAaO5CMhbE5uDeLTRCofe0O8PY9a5+0kRq7mTslfrqU5fH/FvKYDuN0
         uxXPepKuKFHGxcvhhFCHfqXu66juaDGQBlnd42oVwoJNEEHRf9nvjtzfNolBpg3gXBr0
         JO9Tl1Wx0kD24ZiR9OiLJFIjb26GrbmWXO4TIiqh9c32UpoTEl+Ple+ixFdP8VP/g3RT
         xAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GKoCtNHPnOD023vXkECrdJRyfW2QLPSb0USAQ19oV0o=;
        b=HuYcneMdMWcDUd+4rhSTsvfSjS0YkEzaH0R56eMVqX/Y2G+dpXpy6XKoBY+oninQm8
         47E5tdb6NGG0We+CwPOV+yeOSqZLnT9KmzGHFqFgka+/oShPSu1CrZu6KB1zGJXQ9LHz
         JOJ4Pj7Y9fEgZ/a5SSDuGGcsL1HE1W7Me972nn9MnrW4YZz/T60noFqTQ9wRhRGTEilb
         aRwvwTbM9YFYNhYCW3WRvQUKpJZEdi3whTkmnx8ViQd5pC6hg9sokwLTIeGhnDWB5rKa
         VSSbfYlDlLd59Z3YXI0ndUCwMhN9IjsvKkIThRSL066tzs7n2Lnj8wanRdltbJQRI2p8
         7muw==
X-Gm-Message-State: ABuFfoiZ5yPB/Fm8BvJREZLYF/5aR/dBHUaopBhAFfFWrNDj6pjXhbLa
        o4mY8+PKVVI++LfN7p4QNBE0QW8+
X-Google-Smtp-Source: ACcGV626Z8QJjsgCRLymMFTMg5+dbxO+/G489RJx1Kf4MY5vNVq2Y48sQT2yywM9mVSef7Hfnp/gIQ==
X-Received: by 2002:a37:12d1:: with SMTP id 78-v6mr16222333qks.147.1539609797608;
        Mon, 15 Oct 2018 06:23:17 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a017:1942:43e1:ced3? ([2001:4898:8010:0:894d:1942:43e1:ced3])
        by smtp.gmail.com with ESMTPSA id e195-v6sm7370223qka.2.2018.10.15.06.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 06:23:16 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Friday, Oct 12)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>
References: <e30a9c05-87d8-1f2b-182c-6d6a5fefe43c@gmail.com>
 <nycvar.QRO.7.76.6.1810151007430.561@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <41a53f74-9b40-c71a-d521-94dcc6e2abe9@gmail.com>
Date:   Mon, 15 Oct 2018 09:23:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1810151007430.561@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/15/2018 4:09 AM, Johannes Schindelin wrote:
> Hi Stolee,
>
> On Fri, 12 Oct 2018, Derrick Stolee wrote:
>
>> In an effort to ensure new code is reasonably covered by the test suite, we
>> now have contrib/coverage-diff.sh to combine the gcov output from 'make
>> coverage-test ; make coverage-report' with the output from 'git diff A B' to
>> discover _new_ lines of code that are not covered.
> Thanks for doing this. I do notice, though, that there are a few mentions
> of BUG() lines, e.g.
>
>> 0af129b2ed builtin/rebase--interactive2.c 267) BUG("invalid command '%d'",
>> command);
> I do not think that we will ever want to ensure that all of these lines
> get code coverage ;-) Maybe it would be possible to exclude those lines
> from the analysis?
I'll incorporate that into my build script, but leave it out of 
contrib/coverage-diff.sh in case people really want to see those lines 
when the inspect a single topic.

Thanks,
-Stolee

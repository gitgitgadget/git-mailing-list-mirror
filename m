Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D0AA1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 14:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407216AbfIYOCX (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 10:02:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45957 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405102AbfIYOCX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 10:02:23 -0400
Received: by mail-qk1-f195.google.com with SMTP id z67so5303474qkb.12
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=paVf2EQ8yy/Owvyk2JeNzFPSGcUyh3QTO/SBqTKzKdo=;
        b=XjAFgjbUp7MfV/s/hSyaSlhk2xuBZDrY+ACD5sgK+Vsuo4DkbecmJbIckRO1Iierfi
         ZxfDZHH9pe0x374xXzd44rsIn0uZnFyO1SUPdedY68SQ2Rwm//IROpOf0u3Mva8VXaPV
         0lfeqIwjixMY6t2cNFnCtLOrq9ZtFLUVFmsLecAVEIKqlBzDZSibYASWitoLC9tAmAZz
         +9JiFlQ6HJC5wCmHTt+4PXjWqidVLTq8BAXyB0YcpFzlXlPI74FdkkMAS3GtDfKbQCwf
         JqaIgqU0F/oo2t/jW4lQaMBILL9jbOohRM5y1t//tUqnmIH/qfjkdXOlJzblE50Wh61G
         kEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=paVf2EQ8yy/Owvyk2JeNzFPSGcUyh3QTO/SBqTKzKdo=;
        b=Y5geQkaOW0MxgpX3fHM4E74ge3NPYRPKJbJLgCZ4NMYPTk/PjQA1MTP75lFvnIU+3g
         aGw9VXdg0DowTrApPRPM1xD5Dg4ZJSoCnEHKehpIKAZ6RuRwNrwqgfn5DwHC+ESjhIq9
         OwGHmuz2TbgXNmeSUrx6YlQ4bmgRxXttbIzRNWpErJzTOtaiCmDHLhf/K3UnYrX/Uk16
         Ao/oZ9auZcyMN5/w8F0fGYTog14ba6N0ovS2rAzYe/3vM7zXtN6imsB0MCBk3uRH++wL
         ihP4fDEpJyMDEP6gSk7Vabnu37Ldn3YqFIcuTdkNuuCiQpSy4ni4VCSwfDAYgxjn/RX6
         8+qg==
X-Gm-Message-State: APjAAAXydzXuRPI1VdSSoSq4cSsfJAlkxm0SxGU8xVx8tejtfNrr+Y4R
        mowCcqQ/prdMMI4re/iOONo=
X-Google-Smtp-Source: APXvYqyj13Zn0blM245meNsup4j3Pl+j1flcGQn2qchvMzw7wUGa06RbjxL/V5YtxTDV0x9iLZ98ag==
X-Received: by 2002:a05:620a:133a:: with SMTP id p26mr3727678qkj.317.1569420140606;
        Wed, 25 Sep 2019 07:02:20 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4cc1:b74:5d5b:b0b0? ([2001:4898:a800:1012:fdf4:b74:5d5b:b0b0])
        by smtp.gmail.com with ESMTPSA id 22sm2506398qkj.0.2019.09.25.07.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 07:02:18 -0700 (PDT)
Subject: Re: [DISCUSSION] Growing the Git community
To:     Pierre Tardy <tardyp@gmail.com>, Elijah Newren <newren@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
 <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com>
 <CAJ+soVcmMwy7GgLcV-m1kNEsHYirHMQQeFuEYZanbCNUK4_zHg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1b988670-381b-1c92-069b-3cb66254861c@gmail.com>
Date:   Wed, 25 Sep 2019 10:02:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <CAJ+soVcmMwy7GgLcV-m1kNEsHYirHMQQeFuEYZanbCNUK4_zHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/25/2019 9:36 AM, Pierre Tardy wrote:
>>> As a community, our number one goal is for Git to continue to be the best
>>> distributed version control system. At minimum, it should continue to be
>>> the most widely-used DVCS.
>>
>> I'd rather we stated our goal in terms of what problems we are trying
>> to address rather than accolades we want sent our way.  E.g. "Our goal
>> is to make developers more productive by providing them increasingly
>> useful version control software".

I'll repeat my appreciation for this redirection of focus.
 
> Agreed.
> And why restrict on DVCS?
> Isn't it admitted that the distributed version control is nowadays
> much better in term of software productivity?
> Is there some use cases that "traditional" centralized VCS are better
> on, and on which we gave up as a goal?

My intention was "let's be the best at what  Git is good at: distributed
version control." There are some legitimate reasons why someone would
pick something like Perforce instead.

Some things, like file locking, are just easier in centralized systems.
I know that Git-LFS created a locking mechanism that pushes even further
toward a centralized system. However, it relies on users following a
very careful pattern (lock, pull, edit, push, merge, unlock) to avoid
conflicts. Further, that only works if you are on a common trunk.
Release branches or forks do not have this concept.

Other extensions (like VFS for Git) remove a lot of the truly
distributed parts and focus instead on a central source of truth.
This works well for some organizations.

Getting on my personal soapbox: I think that we are improving Git
so much that people will have few strong reasons to choose other
DVCSs. Maybe "hg evolve" is why someone really loves Mercurial, and
we can work to build similar features. Maybe there is some repo
shapes where another tool is faster, but we could probably make Git
faster, too.

Thanks,
-Stolee

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F32D20248
	for <e@80x24.org>; Wed, 17 Apr 2019 09:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbfDQJxB (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 05:53:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43628 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfDQJxA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 05:53:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so26394825wrx.10
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YepB+CQjXqdKlxBJN6gO9C236z/uXHtcuRVUdfUJ/oo=;
        b=u9fn30sCAeTjlbpXzcnh477HIrVargpn9mHRAoEYHvFFJ26+DyFl5vejCOZfw3F+ts
         kiNtOEW6OpbXmvIdLXPE/TZqvqJdS5QsBCCRk7Ct7tKHnmFpOd0cQqCy8C6MZnGrD82b
         13gGPJmFH+on8h1gJlSbVlQN+zm0QrPoY/goz2z/YKsTsDJe/DCdUqlHbpIvncuiIT4B
         mSzj56TQwg+lRSKorqyDbU5y0zEg8XFl43yZhhjqKqEcwcYkNsqmICpU8rYR2TBzpKgn
         SFbiaEweFG7ME3fNRyNN70VNVUpfOKfAi1vcBWrsRboGgsQ2yZtx0cEOQUWWDQ0nqZkT
         eBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YepB+CQjXqdKlxBJN6gO9C236z/uXHtcuRVUdfUJ/oo=;
        b=sWWfQn3PXLCyVr/kwvK4kHZry1aaTAc3tRGIL/yHLCqm+lZuAeUc6REfd+AaN/rYgs
         dyorA1p8efxM59SBWTO4h+N2TmdCkUK3Ed9lREkmLftubt4oCk3C3eQluaj5YgfV1N7V
         5cfRwOssv8hKsjJCAIJh4ijGgyTy2Vq2nUMV2ZYJVUsqbY7g/+BskcudtOcX4OMB4KFj
         PM2qVdnfp8UkyNLMXgJ1XKrys256aXW/xEwMVzSNfGa9mJ+DagZhVHk+3l9Py/fcUuDN
         rzC1tym+KCjcd93zvqoBm3GOj36uYo9Ii3VParuup2jpdU/glm6EXR7qecjn+I5jgD5I
         zlsw==
X-Gm-Message-State: APjAAAVv3tpsbE7TbAnBndCGlkWIqmXX/bsuxzBHNU6VAvSIy2y+xucF
        9irVJJt8XobyY2q1i/mbpyQ=
X-Google-Smtp-Source: APXvYqxksSGxoZ6LB0ixQC45952znFvH2xcAZoM+zmEULrbcaNXbpm4nQ+WKL27u5lAz/8fKHFUQpQ==
X-Received: by 2002:adf:ef8e:: with SMTP id d14mr52410364wro.81.1555494779178;
        Wed, 17 Apr 2019 02:52:59 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id d7sm2691742wmf.31.2019.04.17.02.52.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 02:52:58 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Apr 2019, #03; Tue, 16)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee <dstolee@microsoft.com>, Eric Wong <e@80x24.org>
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
 <87d0lmatr1.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <adb4a578-9bc6-f017-5817-cd045dcb0a32@gmail.com>
Date:   Wed, 17 Apr 2019 10:52:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87d0lmatr1.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/04/2019 15:51, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Apr 16 2019, Junio C Hamano wrote:
> 
>> * pw/rebase-i-internal-rfc (2019-03-21) 12 commits
>>   - rebase -i: run without forking rebase--interactive
>>   - rebase: use a common action enum
>>   - rebase -i: use struct rebase_options in do_interactive_rebase()
>>   - rebase -i: use struct rebase_options to parse args
>>   - rebase -i: use struct object_id for squash_onto
>>   - rebase -i: use struct commit when parsing options
>>   - rebase -i: remove duplication
>>   - rebase -i: combine rebase--interactive.c with rebase.c
>>   - rebase: use OPT_RERERE_AUTOUPDATE()
>>   - rebase: rename write_basic_state()
>>   - sequencer: always discard index after checkout
>>   - Merge branch 'ag/sequencer-reduce-rewriting-todo' into pw/rebase-i-internal-rfc
>>   (this branch uses ag/sequencer-reduce-rewriting-todo.)
>>
>>   The internal implementation of "git rebase -i" has been updated to
>>   avoid forking a separate "rebase--interactive" process.
>>
>>   Comments?  Is this ready?
> 
> I gave this some stress testing/review in your infra, works for me so
> far, and a good performance improvement.
> 
> My only problem with it is that the commit message doesn't note just
> quite how awesome it is, but I can live with that :)

Thanks for testing this, I'll send a re-roll that mentions the 
performance improvement. I'm still surprised by it, are you seeing an 
improvement in production as well as on the perf test you mentioned 
before? I wonder if some of the improvement is due to 
ag/sequencer-reduce-rewriting-todo if that wasn't in master when you ran 
the benchmarks but I haven't had time to investigate.

Best Wishes

Phillip

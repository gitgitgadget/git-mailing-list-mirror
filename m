Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAFFC20281
	for <e@80x24.org>; Fri, 29 Sep 2017 13:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbdI2NIt (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 09:08:49 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:47426 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdI2NIs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 09:08:48 -0400
Received: by mail-qk0-f176.google.com with SMTP id b82so1089028qkc.4
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 06:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1hZMjxrwsdAxKemfTIplkCEH8omYVb6jZUxsF/1bxyM=;
        b=pg8vxcwcA1ve4B+yRxn0nu47TRy0bvkiNCYK3jxc1RL+t7wzZ3oy6w4zQmVA033bu0
         PypUFWryXxoMXZZixG0NEzy8g50bZz2xrgY/EKep0kUQue686yjeVAVcj7X+4ri5k76s
         2z3Xz9OYzYWhrsA8A8tiCfLpKDeQXltVEOS5M+ohwRYOhFSOLuC0I+4XcBawC+3LRZ93
         M6vr2OD3H9+iCcsDToLaN5ccwWaWU8QSrr3VEzH1L25/GWiek4MX3+GU0KejORD55jX1
         6GQCKYqHKkOQdVihB/atj/SbBsVqMPpTVCXOPZfoMe5Zcl0IkJXPkt4SzXr4MWXPYZvx
         1AxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1hZMjxrwsdAxKemfTIplkCEH8omYVb6jZUxsF/1bxyM=;
        b=QfxHps0yeDCMxidjP6FLfS2aexjLRckmA5VJniZk6dRxic0FfxI3JoOB41RxWHmzNt
         oFhFWW/ZBaSDCfQQ7x81YFI37ED3HxV8k87vNdHEf3F9VmeMNYCDN2pZXTd5fTi1DNCb
         wYR/TpshkdGQMsHMiuhzAXNY913yVNuuk6SUATwzCtfMefJqdsYNB4DvXa/dcEaEHJ3o
         9ERKWXP/HJ4GuRyweTWzaXqfURKOVycTMuJ1+d549r0j5R+Xia6GQqEUvWqrYpbkHlXH
         JZeUThfPG0AFgPTlyRpuvFP4VCcWthD4ladk2jZyj8NoyIe7d/DhuNJ04LtFVPvrHQyI
         Q8rw==
X-Gm-Message-State: AMCzsaUQgdH7n48DW39TCItnLhhnz+BsgXOti6IL14C65gmWef5JOMwz
        frVUuJ3dezYpR93Bs8EawqFgo23j
X-Google-Smtp-Source: AOwi7QDH6RwLuP1ByyMLzcmJ/3K4TBNTDI+qeH4qDrSfzJCTyoL9XohZttrggmNlI0FS6e7I+vUf1g==
X-Received: by 10.55.20.72 with SMTP id e69mr2495153qkh.194.1506690527446;
        Fri, 29 Sep 2017 06:08:47 -0700 (PDT)
Received: from [10.0.1.24] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id w199sm530151qkw.80.2017.09.29.06.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Sep 2017 06:08:46 -0700 (PDT)
Subject: Re: What's cooking in git.git (Sep 2017, #06; Fri, 29)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqlgkyxgvq.fsf@gitster.mtv.corp.google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5f7dbd81-ae27-c3a2-a14d-2832f71db1e9@gmail.com>
Date:   Fri, 29 Sep 2017 09:08:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <xmqqlgkyxgvq.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 9/29/2017 12:34 AM, Junio C Hamano wrote:
> * ds/find-unique-abbrev-optim (2017-09-19) 4 commits
>   - SQUASH???
>   - sha1_name: parse less while finding common prefix
>   - sha1_name: unroll len loop in find_unique_abbrev_r()
>   - sha1_name: create perf test for find_unique_abbrev()

I'll re-roll my patch on Monday if reviews have stabilized. I think I 
understand your comments this time (especially around 32-bit ints).
Since I'm new to the list, I'm not sure what the change in messages
means here.

What does "SQUASH???" mean? Is that why there are three meaningful 
commits in this note, despite my five-commit patch? Would you like me to 
squash the commits in v3?

Thanks,
-Stolee

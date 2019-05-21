Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F289B1F462
	for <e@80x24.org>; Tue, 21 May 2019 01:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfEUBUs (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 21:20:48 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:46178 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfEUBUs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 21:20:48 -0400
Received: by mail-qt1-f176.google.com with SMTP id z19so18558328qtz.13
        for <git@vger.kernel.org>; Mon, 20 May 2019 18:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M5u4aA4Iphs6DqlAdQLY7i/HTcsB7tBGk1i++syX/vs=;
        b=nnJRSrQuNtLA87dPfp7OhrJ6VjUB9ZJrkfNlDa25ln+yTBMYm0RCaM9C3RqJm/wbDZ
         0DsENNN7HPr28aLi7+aMw+jsl1+MrF4ORc2QTW2DyceWHzp5eLLUHIJ+1rlXW3hIDfRH
         ScNC2txOz5o3k5R48VqHFQUfXjvEIluGPrXfZ9K9QVE8l0qYm0Ltr/ZE5HkfSnRuqUQv
         ebqLBgmtWZCkm1bRuekIuNvfTZ5BjQZLm1Tfg1jNqZXrpCJM7QxbmLYzmLbtR9r7ZT8s
         Nw6kKpfdRHQL8Xn1can2z5wgzXGi/oWcdzNYz06cvcVlREuILscA2Gmgp5S0V0ZPflkM
         ONFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M5u4aA4Iphs6DqlAdQLY7i/HTcsB7tBGk1i++syX/vs=;
        b=CQuD29gf11EMY+B5tZmITUsn25401Ue9RosAXg2zfz3OscgH7L6YfEpMId2YCjvCOW
         r9x7Lp+4dwRPKyz9sDBrqryWvSrnX/IXKL4AnCTY1y+Ni7TuSMjaeeO6n24ChsGliAce
         /+6EsCYKg7kh24XOX96tN4UasQRriWhbCm921n93o4IBUlIsYa4Dhc8Fx2jUoJq8eKGG
         FwjMRc8EKoVd8+Ukf0/1Rp/XUBFLrdMK+Slb4IbRdKRIAnIqfjRalPK0UrJRWuNVk8WY
         YwrYyHSA57aeU4BIWUBz9ljmHRon8CMrquCMcSl5dhco68XxZ+zW77Vd/fNgh9wdwPq+
         kfVw==
X-Gm-Message-State: APjAAAXblKbX/LmpojO95lsxb74pYUAaebBZUHaFcNFV3lBhsIpcwzHX
        KxA9XxS3QNVsmz27AqoB3pV85oO5c/0=
X-Google-Smtp-Source: APXvYqzO559yPrnyIr/ZfuP2F1OkkiGpqAl6l2Ao7JacVSYqt4ka8xYUUwIwDdjNEMWv2MsSvGyH8Q==
X-Received: by 2002:a0c:fca6:: with SMTP id h6mr4711334qvq.41.1558401646700;
        Mon, 20 May 2019 18:20:46 -0700 (PDT)
Received: from [10.0.1.7] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id t47sm10126156qtb.43.2019.05.20.18.20.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 18:20:46 -0700 (PDT)
Subject: Re: Revision walking, commit dates, slop
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
References: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
 <20190518015005.GA951@szeder.dev>
 <20190518035828.pjaqfrkkvldhri6v@glandium.org>
 <20190518041706.ct6ie5trvxgdhjar@glandium.org>
 <f14799c3-e343-eb41-3536-65de7e38fbd9@gmail.com> <86mujhpewj.fsf@gmail.com>
 <cfa2c367-5cd7-add5-0293-caa75b103f34@gmail.com> <86ftp9p7i8.fsf@gmail.com>
 <864l5opuz1.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <88662e18-db51-cb48-3307-0ea2a91c4ebe@gmail.com>
Date:   Mon, 20 May 2019 21:20:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <864l5opuz1.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/20/2019 7:27 PM, Jakub Narebski wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Derrick Stolee <stolee@gmail.com> writes:
>>> On 5/20/2019 7:02 AM, Jakub Narebski wrote:
>>>>
>>>> Are there any blockers that prevent the switch to this
>>>> "generation number v2"?
> [...]
> 
>>>                      Using the generation number column for the corrected
>>> commit-date offsets (assuming we also guarantee the offset is strictly
>>> increasing from parent to child), these new values will be backwards-
>>> compatible _except_ for 'git commit-graph verify'.
>>
>> O.K., so the "generation number v2 (legacy)" would be incremental and
>> backward-compatibile in use (though not in generation and validation).
>>
>> Do I understand it correctly how it is calculated:
>>
>>   corrected_date(C) = max(committer_date(C),
>>                           max_{P ∈ parents(C)}(corrected_date(P)) + 1)
> 
> This should probably read
> 
>     offset_date(P) = committer_date(P) + gen_v2(P)
>     corrected_date(C) = max(committer_date(C),
>                             max_{P ∈ parents(C)}(offset_date(P)) + 1)  

The final definition needs two conditions on the offset of a commit C for
every parent P:

 1. committer_date(C) + offset(C) > committer_date(P) + offset(P)
 2. offset(C) > offset(P)

Condition (1) will give us the performance benefits related to the
committer-date heuristic. Condition (2) will give us backwards-compatibility
with generation numbers.

Thanks,
-Stolee

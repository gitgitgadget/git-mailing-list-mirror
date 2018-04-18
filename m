Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 148451F404
	for <e@80x24.org>; Wed, 18 Apr 2018 12:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbeDRMuO (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 08:50:14 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36226 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeDRMuN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 08:50:13 -0400
Received: by mail-qk0-f193.google.com with SMTP id a202so1597755qkg.3
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 05:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uctS5Mnum7VwZoZny08B+B/zKgx4vLi97hr9wFjG1gI=;
        b=cpTjgMrzif8RcnIF9//wj/iIgnMsc5wKZgCO7PBLvouzdguDMeLjzJ8/QQArK5sQ75
         QkZQ3gWXe27uH4s4RGihuU4w+z/rfSDuVlYlCYsBhFAlDtfnUAAKapx7AouhkP+EwNZT
         X1tNba3OEin+JmsM6uk+kJypqU1P//zSn0sHYW6QgpzBdxBJIeWZqJXeVEH6dci0Fe7A
         TtbkIiodBoii7WIQotWh+qjmlahr0ssnPZvhKW5Wim0B9kBScWcwg73aIDZbYBwFyZAy
         JAoNEWRDCvF6sNe84gaG64G0CzuBS4JkeUdJoNntBAJX95dDuSbdpXA+fJTtvrXY9/86
         kluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uctS5Mnum7VwZoZny08B+B/zKgx4vLi97hr9wFjG1gI=;
        b=UDEQcLffmz1ybxKBHqFNHXj2cNmS7SkrnGYf3yAxNtdQchrKXmoY1EupjVjLBStzJ1
         H3Pbql0nDh2NGUehak/PhHKb4unhsqYvZrrz5RCJVEWndps0dmghdkwGMAFYZujgu19j
         1ZbAiTBy1FVR1Z7K3BfBwIvA9l9jnRB2y7lernBG3ptCD6UdAuZ/m8k9bC/nKP5u/ZiY
         SYMLoTPOUC9D5VOcserj2MPXxmJm4EPrdN7smyIf4FNonyu+aPI+ptbqaNyWXG2qQbxx
         5pkX7K90pKgLl2uAtFovQByavZNwx+KSOU97v+hsqSfJ7XLn9+ZSmKm/Bz6RTnGTpeS3
         AVag==
X-Gm-Message-State: ALQs6tBfHdTgY2eFiKuVJOpn9WeT4RiKQZ9xeVAPeQmGoixgpMBMD1Y7
        daVYkDTRBiR+YV1W2f0JiCWMyOnM
X-Google-Smtp-Source: AB8JxZooZIDkM0GjuHmvL4egIMdEcZrjqBdLNSRl7DAbZQuBLjx0ELI+6/Q3UKITpGN+e5r3WGsf3A==
X-Received: by 10.55.92.198 with SMTP id q189mr1929242qkb.63.1524055812027;
        Wed, 18 Apr 2018 05:50:12 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id p63sm867047qki.37.2018.04.18.05.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Apr 2018 05:50:11 -0700 (PDT)
Subject: Re: What's cooking in git.git (Apr 2018, #02; Tue, 17)
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
References: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kb=A6BsdrtH=2F0634+r5ejG9Ce9U0mry65jkNnscu1nA@mail.gmail.com>
 <xmqqpo2xjpf6.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <287d6c83-2c7e-3138-def4-fee5d9cb9e48@gmail.com>
Date:   Wed, 18 Apr 2018 08:50:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqpo2xjpf6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/17/2018 9:04 PM, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>>   What's the doneness of this thing?  I didn't recall seeing any
>>>   response, especially ones that demonstrated the reviewer carefully
>>>   read and thought about the issues surrounding the code.  Not that I
>>>   spotted any problems in these patches myself, though.
>> Stolee and Brandon provided a "quick LGTM" type of review
>> https://public-inbox.org/git/20180409232536.GB102627@google.com/
>> https://public-inbox.org/git/9ddfee7e-025a-79c9-8d6b-700c65a14067@gmail.com/
> Yup.  Giving positive reviews is harder than giving constructive
> criticism.  Much harder.
>
> As readers cannot tell from a "quick LGTM" between "I didn't read it
> but it did not smell foul" and "I read it thoroughly, understood how
> the solution works, it was presented well, and agree with the design
> and implementation---there is nothing to add", the reviewers need to
> come up with some way to express that it is the latter case rather
> than the former.
>
> I would not claim that I've perfected my technique to do so, but
> when responding to such a "good" series, I rephrase the main idea in
> the series in my own words to show that I as a reviewer read the
> series well enough to be able to do so, perhaps with comparison with
> possible alternatives I could think of and dicussion to argue that
> the solution presented in the series is better, in an attempt to
> demonstrate that I am qualified to say "this one is good" with good
> enough understanding of both the issue the series addresses and the
> solution in the series.

I'm sorry that my second message was terse. My response to v1 [1] was

 > I looked through these patches and only found one set of whitespace > 
errors. Compiles and tests fine on my machine. > > Reviewed-by: Derrick 
Stolee <dstolee@microsoft.com> So, I pulled the code, went through it 
patch-by-patch, and saw that the transformations were made using the 
established pattern. The second review was to chime in that my v1 
comments had been addressed. Thanks, -Stolee
[1] 
https://public-inbox.org/git/6c319100-df47-3b8d-8661-24e4643ada09@gmail.com/

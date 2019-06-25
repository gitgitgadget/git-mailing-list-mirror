Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D99391F461
	for <e@80x24.org>; Tue, 25 Jun 2019 10:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732155AbfFYKyd (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 06:54:33 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42166 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbfFYKyd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 06:54:33 -0400
Received: by mail-yw1-f66.google.com with SMTP id s5so7294708ywd.9
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=26o+FyRKzJnl3Rw9K5Qfp2lxztX2OqCgVbfmtZN2t58=;
        b=tpvgzzGMSFqLnBxOz+e1y9siJ9qf1YyLZpQydCYmUH4NprCzNtL+M5h98dfbgFxtis
         xgaQS/tNmpWSFzMjLPl61GVQ0tmnNnE1NKRyOwcHkgbKTLX+m4VdgKw66grKvTkLVj8o
         +n+Pm2pw3QzSue/pUUfo8cQmwwCoEdENFKNHkojgic1mr//KzQQjhP/xNOC7040HUGwL
         hx02jZcB3PxWuqDIxoEg42v5GCcfwrDbuduSS8VNCoreRlboINxd57XiUEM0p0onOkfx
         aGwNRkgKFMOlw63xthm7VofWQL2hgBkFP6xo0DyH6vDTs0/FWuoGblGbrCNZwP0B38+X
         sT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=26o+FyRKzJnl3Rw9K5Qfp2lxztX2OqCgVbfmtZN2t58=;
        b=QNXlPoAxKl0MOnOz/4Ph5S/sbvEQ15QSkcjrGBVH9m7/Vr41Ys3KaGRcftsgyd0VDO
         UUyYS03caulZk9ztFNA5DEoz753Oy7Fll6Oy4rRH8OtLSvYaqwhCHYx/6AHMl/J6+Y8m
         2GCTDAZU74QYTP3lv3SkCwXeh68V6odgLfSzFwPCHSi1ZaDQzBwdHQO7wpZXfvAS0u3M
         xLrl6WypHicKSvYOPmLwmi9Cc19zPh9TRPz9QDovguwJJPx7QM/o1IcmAaim+Y2JtJT7
         zKKmUqNQ+UDsR5bzzZHMSoeqX854Md9lcAr6bnyHLNVYsvxJSO6p61RRu0Im5zj3jl3K
         VWoA==
X-Gm-Message-State: APjAAAV35iDebf5mOgwIbZ6agrKtjV3rZXNLFNQdM+I1ucrLT4oGOphg
        ThePCRX1cIxmziEXlF6wDTJv1Str
X-Google-Smtp-Source: APXvYqztxaF/UpsI9rsGYBPlYMqoB416bYtcNesghzRu0HqbqDyDlfAn5yzaMPxg8nB4d+KbDGAd4Q==
X-Received: by 2002:a81:25d1:: with SMTP id l200mr55141243ywl.11.1561460072145;
        Tue, 25 Jun 2019 03:54:32 -0700 (PDT)
Received: from [192.168.1.16] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id a82sm3575612ywh.42.2019.06.25.03.54.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 03:54:31 -0700 (PDT)
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
 <86mui63xwr.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <55fad895-2c18-5a91-79b9-7b958fe280c6@gmail.com>
Date:   Tue, 25 Jun 2019 06:54:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <86mui63xwr.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/25/2019 3:51 AM, Jakub Narebski wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Derrick Stolee <stolee@gmail.com> writes:
>>> On 5/20/2019 7:02 AM, Jakub Narebski wrote:
>>>>
>>>> Are there any blockers that prevent the switch to this
>>>> "generation number v2"?
>>>>
>>>> - Is it a problem with insufficient data to choose the correct numbering
>>>>   as "generation number v2' (there can be only one)?
>>>> - Is it a problem with selected "generation number v2" being
>>>>   incompatibile with gen v2, and Git failing when new version of
>>>>   commit-graph is used instead of softly just not using commit-graph?
>>>> - Or is it something else?
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
>>   offset(C) = corrected_date(C) - committer_date(C)
>>   gen_v2(C) = max(offset(C), max_{P ∈ parents(C)}(gen_v2(P)) + 1) 
> 
> Do you remember who first came up with this idea for backward
> compatibile corrected commit date offsets (monotonically offset
> corrected date)?

I remember saying that the "corrected commit date" that I had suggested
was weak because it was not backwards-compatible with generation numbers
if you are only looking at the offsets. I don't remember who suggested
simply increasing the offset so they do become backwards-compatible.
 
>> Do you have benchmark for this "monotonically offset corrected commit
>> date" generation number in https://github.com/derrickstolee/git/commits/reach-perf
>> and https://github.com/derrickstolee/gen-test ?
> 
> I guess this will have to wait...

I have not had time to revisit this topic and re-run performance
numbers, sorry.

-Stolee

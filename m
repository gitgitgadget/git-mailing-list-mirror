Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 828491F462
	for <e@80x24.org>; Tue,  4 Jun 2019 16:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfFDQiG (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 12:38:06 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:34404 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfFDQiG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 12:38:06 -0400
Received: by mail-pf1-f182.google.com with SMTP id c85so4228566pfc.1
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8sQyGp4dFIQww70Nay+47++BpOFVy/vfdIDMzaJuYEY=;
        b=TPvPhnDEp0/Ivlzt6b2tB/DgdyhReLnhHzEg3gVfC8m1TGxQV6Nq/hzLmOAqasHWUQ
         CPJBn+rsH74zbKqsWVEO39bh1Iwcwqodpc6myJ3QBHHgzXGMPZCUmFAJcRV3CoVucrNb
         v/NNYfQNarmi2MWzNEN2R/7W4ys0IU5UvRkMU7jl/Fn9DaBDi6ZMSrWgE1FzyB6LEu/8
         KEdnsXWhguSuzcYkl4PiMedhNfnvCfO9RZcc5CIKvO+1Z3V5Gj3+EnqcTQL5bONYllKs
         +Mn5g1K/U0E0Mp+c4ZwuAMKSMkieETd0iwUQ0/PYbEC8u9HpVZF5lRqidgUE06JBdHNl
         YJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8sQyGp4dFIQww70Nay+47++BpOFVy/vfdIDMzaJuYEY=;
        b=e00x1CZzNMwLxTdS2NLTWlV835XfzZpHBMZNqcLjvVFroyVfrA4SwdP2GbuXLLVz1r
         dQQ3Rcusp0daJZ6h50+No0B8TpSlehhggStpbCs/RaM68rUco0IDfdMG7WNO2+4/SKRW
         ZE3824H6vXGkAaJlnQSeks2Nynvga5pM+TdTtVl7JQRh6aHE2WmSF7nsAycX7e8zdnc4
         bOMjUG+95dmqcnLo4lUaaLTDwYowCdVjsQMamf8GoRQ2+jP4ldwHbmc6PFZH5jyMzmtx
         A2esmb96f1keJcuRdaIlK3u5zwTM7GXaCMq07lE1URj62kKDOrij23GAoXY6c600VhTr
         zDlA==
X-Gm-Message-State: APjAAAWLwYZp/dbtHwMvuPvg3CPsk94GXUShbdJ9i17cmPXLHNJSQvEx
        T44737A+dwM0fbJ42wUC7A/PKusqPK8=
X-Google-Smtp-Source: APXvYqziIh/w5nZlZf7nzWZzplhrLumXdm5naVsmQApP2QmpR5bThCaOM4pKuaqjPSVH5yRX/OFOZg==
X-Received: by 2002:aa7:8dc3:: with SMTP id j3mr40725884pfr.141.1559666284769;
        Tue, 04 Jun 2019 09:38:04 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id g8sm16480685pjs.23.2019.06.04.09.38.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 09:38:04 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Thursday, May 30th)
To:     Derrick Stolee <stolee@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Cc:     michael@platin.gs, Jonathan Tan <jonathantanmy@google.com>
References: <2fb43bd3-71a7-fd92-e9b8-43e4eeed34cd@gmail.com>
 <e18e4391-a574-1f4b-88c7-890ada116f51@gmail.com>
 <b4ce9cbc-71d3-4d7f-1ee2-e4e3fc23b015@google.com>
 <80a23fb8-5ea8-dba3-ce7d-f6f5d4c02310@gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <9ab619bb-9deb-4e57-a3ad-9e996425b783@google.com>
Date:   Tue, 4 Jun 2019 12:38:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <80a23fb8-5ea8-dba3-ce7d-f6f5d4c02310@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/3/19 2:40 PM, Derrick Stolee wrote:
> On 6/3/2019 2:11 PM, Barret Rhoden wrote:
>> Hi -
>>
>> On 5/30/19 2:24 PM, Derrick Stolee wrote:
>>>> 8934ac8c 1190)     ent->ignored == next->ignored &&
>>>> 8934ac8c 1191)     ent->unblamable == next->unblamable) {
>>> These lines are part of this diff:
>>>
>>> --- a/blame.c
>>> +++ b/blame.c
>>> @@ -479,7 +479,9 @@ void blame_coalesce(struct blame_scoreboard *sb)
>>>
>>>           for (ent = sb->ent; ent && (next = ent->next); ent = next) {
>>>                   if (ent->suspect == next->suspect &&
>>> -                   ent->s_lno + ent->num_lines == next->s_lno) {
>>> +                   ent->s_lno + ent->num_lines == next->s_lno &&
>>> +                   ent->ignored == next->ignored &&
>>> +                   ent->unblamable == next->unblamable) {
>>>                           ent->num_lines += next->num_lines;
>>>                           ent->next = next->next;
>>>                           blame_origin_decref(next->suspect);
>>>
>>> The fact that they are uncovered means that the && chain is short-circuited at
>>> "ent->s_lno + ent->num_lines == next->s_lno" before the new conditions can be
>>> checked. So, the block inside is never covered. It includes a call to
>>> blame_origin_decref() and free(), so it would be good to try and exercise this region.
>>
>> What is your setup for determining if a line is uncovered?  Are you running something like gcov for all of the tests in t/?
>>
>> I removed this change, and none of the other blame tests appeared to trigger this code block either, independently of this change.  (I put an assert(0) inside the block).
>>
>> However, two of our blame-ignore tests do get past the first two checks in the if clause, (the suspects are equal and the s_lno chunks are adjacent) and we do check the ignored/unblamable conditions.
>>
>> Specifically, if I undo this change and put an assert(0) in that block, two of our tests hit that code, and one of our tests fails if I don't do the check for ignored/unblamable.
> 
> The tests use gcov while running the tests in t/. Here is the build [1].
> 
> There are some i/o errors happening in the build, which I have not
> full diagnosed. It is entirely possible that you actually are covered,
> but there was an error collecting the coverage statistics. The simplest
> thing to do is to insert a die() statement and re-run the tests.

It looks like no existing tests cover that block in blame_coalesce(), 
regardless of my commit.  That's based on putting die() in there and 
running make in t/.  So at the worst, my patch isn't decreasing 
coverage.  That's a pretty low bar.  =)

I'll try to come up with a test, independent of my blame-ignore work, 
that can get in that block.

Thanks,

Barret



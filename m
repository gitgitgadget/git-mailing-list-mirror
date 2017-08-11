Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41FD920899
	for <e@80x24.org>; Fri, 11 Aug 2017 20:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753413AbdHKUG6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 16:06:58 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:38286 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753343AbdHKUG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 16:06:58 -0400
Received: by mail-qk0-f170.google.com with SMTP id x191so26071504qka.5
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 13:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CVg9hiqOOH5meb5Z87K48LJtTj67DzBFQ5I04PRopYA=;
        b=KC0MfEiP4/p2jIHxR6p0RpXVhvMJgJ+gaTikGwFNyEx+5O5crBXMXDhJ1ZpZwfpK9c
         9CTaqmEVysOthhxHfNgh0tkt9s+5EGUMBOXA0nHkYdWZB5KR1h31HSQRpoVbAPPqv84P
         GRtP7cGy9G/lRliJ2ES4tAAKIW1+LDqoIhHHuUFV5Adw/EzZkPT9rsRMxsneQGysPN+l
         WxP31B1JmDIT/djQnCdmJTqYRLi8slL2YgAqGLSlQoHkfB+j5em35jkWh8YPL79Zdl9k
         J151uEKgEaX0xDdXEdRVo4kvJw0ZPkWqcSFWLW0QEilNJTb5C4RNW2jfaVnYDD3fqJJW
         oouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CVg9hiqOOH5meb5Z87K48LJtTj67DzBFQ5I04PRopYA=;
        b=URJUYOGGwEaHO07JKFbU7lFVlbe5AA7uYugOaejKsMJpX5eW1ABq1O08F5PdugpDhd
         xCnKrAbsndHVO4vSCy5kS1NgaNDy8vCJioimHSUtlc3jtp/Oz+B77iTRj/8+jse/q2GN
         buc2Eaw6WilLLUwnpY2aOLP4cPKYVrEKbrI2fYQ1d0T2upkDOig0l0olSZBBsHatd7Zy
         AzodJQDIE9/p3X2JsZ063qfHC7HK3RATSjESg1bno5b4HgHIvi1g2krqDINuolQ7t1Wu
         TbKa/pvj2b50y7/w+YoEnmRBc+DKcmDxhEsbQN7lno0YbBEGyUMOXTzXNSWd9ohM+viz
         eisQ==
X-Gm-Message-State: AHYfb5iFQyTPzRlEuxK8mJWNqztImBGGCsW5A+cW2gJp73tABSYXDVAC
        IJOvWmMvispK2CALews=
X-Received: by 10.55.91.135 with SMTP id p129mr20125942qkb.32.1502482016715;
        Fri, 11 Aug 2017 13:06:56 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id y10sm1128040qtb.57.2017.08.11.13.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Aug 2017 13:06:55 -0700 (PDT)
Subject: Re: [RFC] clang-format: outline the git project's coding style
To:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20170808012554.186051-1-bmwill@google.com>
 <alpine.DEB.2.21.1.1708081404200.4271@virtualbox>
 <CAGZ79kb2860nUs46bP=x-gAx9Ao6DxnvXQv3x387Wxw+kEyxJw@mail.gmail.com>
 <20170808182324.GB73298@google.com>
 <alpine.DEB.2.21.1.1708100032050.11175@virtualbox>
 <CAGZ79kb6Ljk8brLN1bbOnBLfm=Q=aCnkZ=ZBtDPzf7MZionmSw@mail.gmail.com>
 <alpine.DEB.2.21.1.1708101137190.11175@virtualbox>
 <xmqqk22b5q9m.fsf@gitster.mtv.corp.google.com>
 <20170810171545.GC73298@google.com>
 <xmqqzib749ix.fsf@gitster.mtv.corp.google.com>
 <20170810213013.GD73298@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0378b54f-7332-7a39-23b1-40886c97c596@gmail.com>
Date:   Fri, 11 Aug 2017 16:06:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170810213013.GD73298@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/10/2017 5:30 PM, Brandon Williams wrote:
> On 08/10, Junio C Hamano wrote:
>> Brandon Williams <bmwill@google.com> writes:
>>
>>> On 08/10, Junio C Hamano wrote:
>>>
>>>> I vaguely recall that there was a discussion to have SubmitGit wait
>>>> for success from Travis CI; if that is already in place, then I can
>>>> sort of see how it would help individual contributors to have the
>>>> style checker in that pipeline as well.
>>>>
>>>> I have a mixed feelings about "fixing" styles automatically, though.
>>>
>>> I still think we are far away from a world where we can fix style
>>> automatically.  If we do want to keep pursuing this there are a number
>>> steps we'd want to take first.
>>>
>>> 1. Settle on a concrete style and document it using a formatter's rules
>>>     (in say a .clang-format file).  This style would most likely need to
>>>     be tuned a little bit, at least the 'Penalty' configuration would
>>>     need to be tuned which (as far as I understand it) is used to
>>>     determine which rule to break first to ensure a line isn't too long.
>>
>> Yes.  I think this is what you started to get the ball rolling.
>> Together with what checkpatch.pl already diagnoses, I think we can
>> get a guideline that is more or less reasonable.
>>
>>> 2. Start getting contributors to use the tool to format their patches.
>>>     This would include having some script or hook that a contributor
>>>     could run to only format the sections of code that they touched.
>>
>> This, too.  Running checkpatch.pl (possibly combined with a bit of
>> tweaking it to match our needs) already catches many of the issues,
>> so a tool with a similar interface would be easy to use, I would
>> imagine.
>>
>>> 3. Slowly the code base would begin to have a uniform style.  At
>>>     some point we may want to then reformat the remaining sections of the
>>>     code base.  At this point we could have some automated bot that fixes
>>>     style.
>>
>> I suspect I am discussing this based on a different assumption.
>>
>> I think the primary goal of this effort is to make it easier to
>> cleanse the new patches that appear on the list of trivial style
>> issues, so that contributors and reviewers do not have to spend
>> bandwidth and brain cycles during the review.  And I have been
>> assuming that we can do so even without waiting for a "tree wide"
>> code churn on existing code to complete.
> 
> Yes that's one of the steps I missed we can call it 2.5 ;)  (3) could be
> a long term goal which is what I was trying to get at by saying:
> 
>>> 3. Slowly the code base would begin to have a uniform style.
> 

Just adding my "Yes!" vote.

Consistent formatting makes the code easier to read and maintain.  I've 
been in religious wars debating whether the opening brace should be on 
the same line or the next line and while I have my personal preferences, 
I can work with just about anything as long as it is consistent. When it 
comes to dealing with a tool, I am willing to live with some "I would 
have wrapped that differently" if I can stop spending so much time 
manually wrapping code.

I think the goals should be to 1) increase readability of the code 2) 
reduce the time spent by reviewers and 3) reduce the time spent by 
contributors.  A pre-commit hook that checked for errors (and gave the 
instructions on how to automatically have the tool correct them) would 
be very helpful.

Please continue to push this forward!

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8256207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933472AbcI3SWK (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 14:22:10 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34856 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932698AbcI3SWI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 14:22:08 -0400
Received: by mail-pf0-f170.google.com with SMTP id s13so42664334pfd.2
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=pErGhC533nKmCQL2iNYCrIiorp7ZieVkwocdraRaY7g=;
        b=SYwWM86hT9nh8meWVbItYmhEffMRupnOoqldk59ylyE1tiVBmX5mHJf1CV5AEd1+Xn
         2hCMbtungJnePX9wU7VKX4glhrTSSfVSrqRCT8TzA+a7obmOQZ+b3wOSD7B7lN9jVMzj
         tzszzqDf22kxZp3GkpHWpzn6hTpjs2y1kc0S3LFNg78eimnN9gy8EZVaPXLasME4v1M7
         TJ2tVQs9HjM14Doe+20AB8U0CnmowRRbNomT9PeFKT6YJj4a5h3c0rNkPKkxzlP/GYIf
         2vplKAywhW7Ghk1zoMj+J92RfJ+bJTcsozl/NqGvxOf5PqtOERY4QHpD+Nn3+V+35P2o
         +4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=pErGhC533nKmCQL2iNYCrIiorp7ZieVkwocdraRaY7g=;
        b=mOqN4nAGcxox7YWEE4x1tn7ukIukYV5HNq6X5Usu4Iqy7cVgmtajkYsT0bqsVEIg3W
         7lHW2k1hhY/nQsuTCz7pgjQ5afX1p8Kp3xniuFJd3GiJWjQj8LBZvo33/+GsAxSFlF74
         boWnx6x4JPT85D82umM4bPl96Kol/H5fB0qnOlrjemqS+cUQEqEkNHQFBOc2lPdm+QAL
         xWi+UCjNMbwiNf/DQ7lEU0CVHXOAN/9VU3zuZ6qc/WnS5DrtDcgeUJE93J50WI/o6aZN
         S4bjp+G09a0m1S8O0oFkcP8JTG5zJcu4MiGFIs61ecua28+YJIYRqo4hIHhi18O4lqXB
         FoHQ==
X-Gm-Message-State: AA6/9RnOCMVfHQMRZxZHbBOXd8E+kj3g7xu1/CeFQ3qgk928ucge9rjQ8Sb2lJsIWEmdSCV4
X-Received: by 10.98.17.148 with SMTP id 20mr5876601pfr.13.1475259727827;
        Fri, 30 Sep 2016 11:22:07 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:35e6:5cc4:12d6:7ce1])
        by smtp.gmail.com with ESMTPSA id fi6sm11912311pac.20.2016.09.30.11.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2016 11:22:06 -0700 (PDT)
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1475176070.git.jonathantanmy@google.com>
 <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com>
Date:   Fri, 30 Sep 2016 11:22:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/29/2016 02:56 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> This is somewhat of a follow-up to my previous e-mail with subject
>> "[PATCH] sequencer: support folding in rfc2822 footer" [1], in which I
>> proposed relaxing the definition of a commit message footer to allow
>> multiple-line field bodies (as described in RFC2822), but its strictness
>> was deemed deliberate.
>
> It does not necessarily mean we can never change it when we did
> something deliberately, though.  With a good enough justification,
> and with a transitition plan if the backward incompatibility is
> severe enough to warrant one, we can change things.
>
> I vaguely recall that there were some discussion on the definition
> of "what's a trailer line" with folks from the kernel land, perhaps
> while discussing the interpret-trailers topic.  IIRC, when somebody
> passes an improved version along, the resulting message's trailer
> block may look like this:
>
>     Signed-off-by: Original Author <original@author.xz>
>     [fixed typo in the variable names]
>     Signed-off-by: Somebhody Else <somebody@else.xz>
>
> and an obvious "wish" of theirs was to treat not just RFC2822-like
> "a line that begins with token followed by a colon" but also these
> short comments as part of the trailer block.  Your original wish in
> [*1*] is to also treat "a line that begin with a whitespace that
> follows a line that begins with token followed by a colon" as part
> of the trailer block and I personally think that is a reasonable
> thing to wish for, too.

If we allowed arbitrary lines in the trailer block, this would solve my 
original problem, yes.

> I recall that I was somewhat surprised and dissapointed to see no
> change to interpret-trailers when you tried [*1*], which was really
> about improving the definition of what the trailer block is, by the
> way.

Sorry, I had missed that.

Looking at that, it seems that sequencer.c started interpreting the last 
paragraph of the commit message as a footer and adding an exception for 
"cherry picked from" in commit b971e04 ("sequencer.c: always separate 
"(cherry picked from" from commit body", 2013-02-12). So the 
interpretations of sequencer.c and interpret-trailers were already 
divergent, but I should have probably at least discussed that.

>> Below is a patch set that allows placing the "cherry picked from" line
>> without taking into account the definition of a commit message footer.
>> For example, "git cherry-pick -x" (with the appropriate configuration
>> variable or argument) would, to this commit message:
>>
>>   commit title
>>
>>   This is an explanatory paragraph.
>>
>>   Footer: foo
>>
>> place the "(cherry picked from ...)" line below "commit title".
>>
>> Would this be better?
>
> It is not immediately obvious what such a change buys us.  Wouldn't
> the current code place that line below "Footer: foo"?  I cannot
> think of any reason why anybody would want to place "cherry-picked
> from" immediately below the title and before the first line of the
> body.

Yes, the current code would place it below "Footer: foo" without a blank 
line before it, but if it thinks that the so-called footer is not 
actually a footer, it would insert a blank line before that line.

As for a reason:

1) I do not have a specific reason for placing it in that exact 
position, but I would like to be able to place the "cherry picked from" 
line without affecting the last paragraph (specifically, without making 
the "cherry picked from" line the only line in the last paragraph). It 
seems to me that placing it below the title was the most straightforward 
way to do that - this way, Git can have its own idea of what a footer 
constitutes, and the user can treat it as completely separate from the 
"cherry picked from" line mechanism.

1a) (Avoiding the footer might also be a good way of more clearly 
defining what the footer is. For example, currently, "cherry picked 
from" is treated as a special case in sequencer.c but not in trailer.c, 
as far as I can tell. If we consistently avoided the footer, we wouldn't 
need such a special case anywhere.)

2) The Linux kernel's repository has some "commit ... upstream." lines 
in this position (below the commit title) - for example, in commit 
dacc0987fd2e.

[1] 
https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable/+/dacc0987fd2e25a8b4b8c19778862ba12ce76d0a

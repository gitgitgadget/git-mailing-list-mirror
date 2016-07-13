Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C899E2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 17:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbcGMRxk (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 13:53:40 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:35234 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbcGMRxj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 13:53:39 -0400
Received: by mail-it0-f47.google.com with SMTP id u186so27478982ita.0
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 10:53:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xcDxJF6qDDCT7YX7UAGMGeGV2ruFl4Ksqj0sUwnKQFA=;
        b=bXaYGQTgWzlU1kWVUewhnOwqjf3WSemyzsdu8oE9pAFaFuxSygVmJBZE7Oo+Qe3LNM
         GS/EKgM44P89i7cfwcN5gQlwvRGBrBhhm3LxyinmFT9hZ8b4qV0gF4KqtSZEJ6oCcajt
         QAcT6mh9M/mij9xPsoR1rsRiy6BhYxK3cZGna8nUaNwy5NloN0TIm6gJftdz84Gh8EmK
         pBFF6PX1vMgL6IwH1KO5+f2oLOaWODg1NTc8l5LzrP2CzChohX7dkDvxAtFRGiBEMAcE
         8BQ+u4OInm4o882KLoK//m+E5MOMAFvB51iuBdRCwLpkZSprpJNQv74eFaGKnq7egiHb
         7q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xcDxJF6qDDCT7YX7UAGMGeGV2ruFl4Ksqj0sUwnKQFA=;
        b=bc2PyxSblD4BI43d+v/enllwLM8OPuN3pS8AnSNHr5ZClyZ9OWxW7ZnUEYm0AQhtiG
         Gvrj3lkJ1WVxnU8bGnr2OLGropCZUxYiWTuhu+aU/3wpP/6fHFgdy+F5+p3eYb4yNSha
         t/3oXcSEwos4ODnykvs5wuyIGhDvhf+Tv5drrExb8w/eq5MoUWRha+MIjaHMAOrFJk85
         OYEO3/qd5MlEhwobEzESJ7EErBVDYXqR6qspSFF4InuFNG3AFhOKnbuW9vaqRCAGGDoA
         Rzf16ILntnGmPMN5FaBr3ZKCJKZLFRvu7qjlZOXif4dApdp9lqU0jaHKn07uVqyXVD7F
         +gdg==
X-Gm-Message-State: ALyK8tKAdKkdF7GapppgaJfXQ250tOi0qwrIGtzSV9N8Ol/ipEAthTn/olLD4AkuEJNeGZClVhVUUhEL12MIyVs0
X-Received: by 10.36.95.146 with SMTP id r140mr10331974itb.49.1468432380421;
 Wed, 13 Jul 2016 10:53:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 13 Jul 2016 10:52:59 -0700 (PDT)
In-Reply-To: <xmqqpoqh1m0o.fsf@gitster.mtv.corp.google.com>
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com> <CAGZ79kY7pWUG7Q0fDhieHCBCpR5RCongzHth6DWOJaEkcGqMEA@mail.gmail.com>
 <xmqqpoqh1m0o.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 13 Jul 2016 10:52:59 -0700
Message-ID: <CAGZ79kYUMX7wewo2QEWQGU9sGR76XjrKJ3uJxpLnyWoZeZ6WXA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2016, #05; Wed, 13)
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Shawn Pearce <sop@google.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 13, 2016 at 10:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> * sb/push-options (2016-07-12) 5 commits
>>>  - add a test for push options
>>>  - push: accept push options
>>>  - SQUASH???
>>
>> Squash? I do not find a squashable commit in what you pushed,
>> do you intend to squash the first 2 patches instead?

Oh I pulled a few minutes before you sent this email, and forgot
that you likely have pushed again when sending this email. :/
Thanks!

>> Yeah there were some late comments, so I did not reroll right away.
>> I think Shawns proposal to have a receive.maxCommandBytes is a
>> good way for an overall upper bound, but how does it stop us from
>> going forward with this series?
>
> If we were to do maxcommandbytes, then max_options would become
> irrelevant, no?

Maybe?

I do not know what kind of safety measures we want in place here, and
if we want to go for overlapping things?

Currently there are none at all in your upstream code, although you cannot
push arbitrary large things to either Shawns or Peffs $Dayjob servers, so
I wonder if we want to either agree on one format or on many overlapping
things, as some different hosts may perceive different things as DoS threats,
so they can fine tune as they want?

In the Gerrit world, you have a ref per code review, such that it is easy to
have 50k refs or more, similar to the repo Jeff pointed out [1], that has 40k
tags (and getting a new tag every 2 hours apparently).

So I could understand if different services care about the different loads
(refs vs push options) differently (one would want to allow unlimited refs
pushing for mirroring such repos as pointed out above, while another
one might care about the total load of the server for a single rogue user)

Thanks,
Stefan

[1] https://github.com/JetBrains/intellij-community

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FD70202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752983AbdGMTUM (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:20:12 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:32904 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753188AbdGMTUL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:20:11 -0400
Received: by mail-pf0-f169.google.com with SMTP id e7so33958859pfk.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/uz9VUR/k2EWNzse1l7Oqm/gitTO1eQICpT1LqwZ4+c=;
        b=eeKaM6cTzJYspJc8swnyEplzo/UkC76bbHYcIIqiRZ2lY8z12SvLxITxtaeT9agudC
         7SZ4MHL8fb1qoqTEKSERTd1AnbsYwULUuY4K+ho3P3jNRjGa+vTfY4m/phksU7EvGjHN
         5YOwWmNO6LyF0z7AyCRH337/w8mDkGHNguO4mXwdBa3whedDWpY2+OURw7qJgzbzsF8L
         1CpJFHQ1r4NhzMOUBGK6t4OVcoj8Y4korC6Kxu2OEKv4vK/DCwLDgNqHGfA41e2t5e+x
         JAcAFz9rsWkJqQlGyxvFqc/dxYLpSev+pHakyhlcdawWlqJHbOAx9LTJe0NvWOelxzb0
         8Htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/uz9VUR/k2EWNzse1l7Oqm/gitTO1eQICpT1LqwZ4+c=;
        b=jTzAQgmCB2Qs1YLAj0q3DYDgOhbYOz6uSil8+hYrbIc54bRzPc0piHEywIsOrx1NeJ
         CzdCE1kkLMutIxxwcDfcHADGYzBdthWvLLsdDZhtaDBdmCzcm4+tg+/T/v4p/4Hfj6wq
         qTlN5/+0C3ILw0YdeGbl4rI9SLWr+5ofO6smMrnJqheKraZne38z+I9OmnQuPqQsZUUC
         kK3Xq9wAfu7N9uR44GEYCK6387468SM1aBCuniZfN185jh5IObhzNI7rz8hUdJSz9t1h
         Mq3tQefZVWu1Cdaoj7gh2qqhjGYMsfuV6Nncrm6tpWfylzYZPe7dhGNGuBD3yGO9A4lW
         trug==
X-Gm-Message-State: AIVw1108AUuv4cSnhwVhRkAORKnI4zt66oDm9PFQWDWIpHcSE6lOPC6J
        bEuVAjECKZtEAGBUCFMUeRNDjPvGbU36+ltbNQ==
X-Received: by 10.84.232.74 with SMTP id f10mr11685460pln.154.1499973610266;
 Thu, 13 Jul 2017 12:20:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 13 Jul 2017 12:20:09 -0700 (PDT)
In-Reply-To: <xmqqr2xkw3qt.fsf@gitster.mtv.corp.google.com>
References: <20170711233827.23486-1-sbeller@google.com> <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
 <20170712205734.h77fgbbkavwpkr4h@sigill.intra.peff.net> <CAGZ79kYYg6-UMrKRPeJTbHdGR0juZ2OwFZmkuYgeYe5X+cm_sQ@mail.gmail.com>
 <20170713155923.a2nissoyczvewoh3@sigill.intra.peff.net> <CAGZ79kbgypimtWE32SnDrG-QWT6gF3WGxR5mi785F_rwvRPOuA@mail.gmail.com>
 <xmqqr2xkw3qt.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Jul 2017 12:20:09 -0700
Message-ID: <CAGZ79kao8=L33jqSFdmYp4NhKfCKDmoqYWvCzuMJ2+Pfq=SYEA@mail.gmail.com>
Subject: Re: [PATCH] RFC: Introduce '.gitorderfile'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 12:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Thu, Jul 13, 2017 at 8:59 AM, Jeff King <peff@peff.net> wrote:
>>>> This triggers two reactions for me:
>>>>
>>>> (a) We should totally do that.
>>>
>>>> (b) It's a rabbit hole to go down.
>>>
>>> And yes, I had both of those reactions, too. We've had the
>>> "project-level .gitconfig" discussion many times over the years. And it
>>> generally comes back to "you can ship a snippet of config and then give
>>> people a script which adds it to their repo".
>>
>> I see this "project-level .gitconfig" via the .gitmodules file.
>> See GITMODULES(5), anything except submodule.<name>.path is
>> just project-level .gitconfig,...
>
> They were from day one meant as a suggestion made by the project.
> You do not have to follow them and you are free to update them,
> i.e. after "submodule init" copied URL to point at a closer mirror,
> for example.

The URL is somewhat special as its copying into the .git/config
also marks the submodule as interesting (no matter if the URL is
changed by the user).

The point I was trying to make is best demonstrated in
t5526-fetch-submodules.sh:

> ok 7 - using fetchRecurseSubmodules=true in .gitmodules recurses into submodules
> ok 8 - --no-recurse-submodules overrides .gitmodules config
> ok 9 - using fetchRecurseSubmodules=false in .git/config overrides setting in .gitmodules

They were not suggestions, but defaults dictated by the project.

If the user did not change their config, they did as the project
said. I was not there on day one to remember if they are merely
meant as suggestions, but their behavior is asserting.

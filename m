Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4C3C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 21:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258D3207D3
	for <git@archiver.kernel.org>; Thu, 21 May 2020 21:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgEUV3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 17:29:39 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:16162 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgEUV3j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 17:29:39 -0400
Received: from [89.243.191.101] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jbsky-0004cI-DP; Thu, 21 May 2020 22:29:36 +0100
Subject: Re: How do Git on Linux users launch/read the user-manual?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <8142f64b-9b5e-3637-21a2-3671dd65a42e@iee.email>
 <xmqqtv0athz5.fsf@gitster.c.googlers.com>
 <6dd15666-1e3e-e9b2-d98b-396d58f241cd@iee.email>
 <xmqqpnaytb31.fsf@gitster.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <ecac8516-e536-80e8-fc72-098406592fd5@iee.email>
Date:   Thu, 21 May 2020 22:29:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqpnaytb31.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/05/2020 00:56, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> Hi Junio,
>>
>> On 20/05/2020 22:27, Junio C Hamano wrote:
>>> Philip Oakley <philipoakley@iee.email> writes:
>>>
>>>> I can then browse that directory to find user-manual.html and open it
>>>> from there (because I know it is there!).
>>>>
>>>> How do Git on Linux users launch/read the user-manual?
>>> Start from the same starting point
>>>
>>> $ git help -w git
>>>
>>> and then navigate to the link to "Git User Manual"?
>>>
>> And then what? Is it always some .html viewer, or viewing the raw .txt
>> file, or something else? (it isn't the man view..)
> "git help -w" is showing stuff in the web browser, and when you open
> git(1), which is rendered in HTML, and visit "Git User's Manual"
> link in it, the experience would be no different from those viewing
> via the browser on Windows---$(htmldir)/user-manual.html is where
> the rendered HTML version of the user-manual is.
>
> Or are you asking something else?
>
I was more coming at the question from the other direction, that is,
about accessing, normally, the git manuals, and discovering the desired
information, both for existing and new users.

In your example, you needed to include the extra -w option, specific to
this 'special' manual, while all the other hundreds of man pages would
be accessed without it (even on Windows, as the config is set by default).

I also get the impression that many linux users may be using 'man' just
as much as much as 'git help' but neither (without realising the need
for the extra option) would show the user-manual (.txt|.html).

We do have the advised `git help -g` to list the concept guides, but
that doesn't advise about the user-manual, which surely we should
mention to those asking for help (without them needing a long journey of
discovery). The list does include `git everyday`...

I appreciate that, for some, there is a view that new users are other
peoples problems and that knowledgable users already know, roughly, 
which command they wish to use and thus then peruse the appropriate
reference manual to confirm the correct form for their command. I'd
rather we direct uncertain users to their appropriate guide quickly,
using their expected viewer method. Hence the question.

Philip

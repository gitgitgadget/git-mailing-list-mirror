Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F94C433E1
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 156A82071A
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=whinis.com header.i=@whinis.com header.b="dGQLSk6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbgFPQJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:09:13 -0400
Received: from whinis.com ([198.205.115.165]:40724 "EHLO whinis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732422AbgFPQJL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 12:09:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by whinis.com (Postfix) with ESMTP id 8FBE47C2F17;
        Tue, 16 Jun 2020 12:09:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whinis.com; s=mail;
        t=1592323748; bh=lMv76pWQdr6O8LtHDaWdVYq9EG32dnGyUgYyyeZP8gs=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=dGQLSk6onUQQKChAdSixoEK410RES6FmjBPp13Ku+xLqZNjtn6/wN7C4t/q4FskNa
         UEvVfy7+hBcqg4oSpUifu4zE+SOAAVV1AMnOsCNVIvGhWUWwqwtYlJ1k563+6u/NPc
         mVRl4OLdC7Ouf3rV8K7AI4H4W+aEdpWpebCqV/Ow=
X-Virus-Scanned: Debian amavisd-new at whinis.com
Received: from whinis.com ([127.0.0.1])
        by localhost (asgard.whinis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LTWLGNAdTQT8; Tue, 16 Jun 2020 12:09:07 -0400 (EDT)
Received: from [192.168.1.117] (c-73-139-109-188.hsd1.fl.comcast.net [73.139.109.188])
        by whinis.com (Postfix) with ESMTPSA id ACF987C200E;
        Tue, 16 Jun 2020 12:09:06 -0400 (EDT)
Subject: Re: Rename offensive terminology (master)
To:     alexsmith@gmail.com, don@goodman-wilson.com, git@vger.kernel.org,
        gitster@pobox.com, sandals@crustytoothpaste.net,
        sergio.a.vianna@gmail.com, simon@bocoup.com
References: <20200616133054.2caiwqwp5mlmb54a@chatter.i7.local>
 <834b0165-61c7-1313-6bc9-387d8a31ef76@gmail.com>
 <20200616154942.z75uo34wsbcvphe5@chatter.i7.local>
From:   Whinis <Whinis@whinis.com>
Message-ID: <0f54e6e6-c09f-9894-ea06-812cc4f7e88b@whinis.com>
Date:   Tue, 16 Jun 2020 12:09:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616154942.z75uo34wsbcvphe5@chatter.i7.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 6/16/2020 11:49 AM, Konstantin Ryabitsev wrote:
> On Tue, Jun 16, 2020 at 09:55:29AM -0400, John Turner wrote:
>>> 1. Git is distributed software. It's not a central service and it does
>>>      not manage any code hosting platforms. It has no control over what
>>>      Github, Gitlab, whatnot or other decide to do. If you don't like what
>>>      they are doing, take it up with them and keep it off this list.
>> Being that the talk of changing the default name has been said to match up
>> with their efforts how can it be kept off the list? Even the initial start
>> to this pointed to other projects as a reason why this should happen. Seems
>> kind of an odd fence to setup whenever nearly everything about this starts
>> with github and other projects.
> Github is an equal partner in this conversation and their opinions weigh
> about as much as anyone else's. However, they are certainly one of the
> larger users of Git, so if they ask to make it possible to change the
> default branch name without any negative effects on how Git works, this
> is a valid request and a valid discussion.
This makes me highly confused because just one email earlier said to 
leave them off this list and now you are saying in one line their 
opinion weighs as much as everyone else and then say they are a larger 
user so if they ask it should happen. You have quickly jumped from their 
opinion shouldn't matter to its equal to their opinion is apparently 
worth more because they are a large user.

So which is it? Should they be left off the list or is the mere fact 
they are changing something enough to ignore what this could break?
>> My understanding is you can already delete the master branch and force-push
>> that. So back to this topic why does anything need to change?
> It doesn't work perfectly. The goal is to improve it so it does.
>
>> They may be wrong but being while Git is not a central service is is used in
>> millions of organizations and by millions of organizations through central
>> services such as Github. Through this distributed use some things are
>> assumed whenever creating new repositories and yes the master branch is one
>> of these. Nearly every tutorial on Git or using get will reference the
>> master branch and its is how many people learn.
> This is true for all technical documentation, though. 10 years ago I
> could reasonably expect "print foo" to work in Python, but now it will
> return an error. Most documentation written for the Linux kernel is
> woefully outdated a few years after its publication.
>
> Documentation has never prevented projects from implementing changes
> that would require docs to be updated.
A single project not conforming is different than changing the default 
and forcing all documentation to be updated. Not to mention this very 
well could cause a split in the community itself leading to even more 
issue. print in python is a poor example as it had obvious technical 
merit to remove items that did not match other paradigms in the 
language. Also the Linux Kernel ABI is extremely well documented and 
even items from 10 years or even 20 years ago conform to it. My argument 
is not documentation alone should never be updated its that this is a 
fundamental change invaliding essentially all current available 
resources. A change this large should require just as large a reason to 
implement.
>> Its already been shown in
>> the patch how these changes might break on existing repos due to assumption
>> of the main/master/primary/<insert word here> branch is no longer what it
>> used to be leading to a need to fix all configs on all repos.
> As this change would be made by individual repository maintainers, this
> is out of scope of this discussion. None of the changes being discussed
> would in any way force existing repositories to rename their branches.
So the effect of changes to how the default install works on users is 
out of scope? What exactly is in scope then because other services were 
out of scope earlier but now are apparently an important input. I would 
say how this change affects the majority of users is very much the exact 
reason this should not happen.
>> Requiring every organization or individual who uses Git to entirely retool
>> due to changes in a base assumption is the exact opposite you want of any
>> stable software.
> "Entirely retool" is not a fair statement for "set a single config value
> in a single file".

Kinda disagrees with the definition of default doesn't it if your fix is 
to tell everyone using current tools to change the default back to what 
it was so it continues to work? Its nearly impossible to estimate how 
many things were coded by different interns and are now technical debt 
and would need to be changed either in all future deployments defeating 
the point of a default or require significant work to rework.

Asking all users to change their methods going forward or rework all 
their technical debt are both extremely unfair to users.

>> Being that this is not a security
>> issue and as you have pointed out people can already name their branches
>> whatever they like its adding complexity to an already complex system. Being
>> that we are as you say detaching this from "emotionally charged rhetoric"
>> and being "reasonable human beings." what good reason is there to introduce
>> such complexity if users appear to overall not want it and those that do
>> already have an alternative?
> You can't avoid the following facts:
>
> 1. Projects are already renaming their branches to whatever they want
> 2. There are parts of git where this breaks internal logic
> 3. We should fix internal logic so it doesn't break
>
> The fact that Git doesn't 100% work with arbitrary branch names is a bug
> that needs to be fixed. Introducing a config variable that designates
> the primary branch name is the way to fix it.

1. If they are already renaming their branches then they have no issues

2. if there is bugs that needs to be fixed but no where have I seen 
examples where this breaks and need I remind you the title of the list 
is "Rename offensive terminology (master)" which is not saying things 
are broken but that things must change due to offense.

What is an example of Git not working with arbitrary branch names? What 
fix does changing the primary branch name fix if the issue is with 
arbitrary branch names?

>> I have seen no one in this email chain nor the one asking for what the
>> default name should be even entertain the idea that it should be left at
>> all.
> Nobody is preventing you from being that person.
Then consider me that person.
>> I leave with this, if we are to leave out the emotions what good
>> reason is there to push through this change?
> Most software development is reactive to emergent situations. In my
> view, making it possible for someone to have an arbitrary collection of
> branches in their repository is reason enough to push this change.
You yourself have admitted its already possible to have an arbitrary 
collection of branches, so what does this change?

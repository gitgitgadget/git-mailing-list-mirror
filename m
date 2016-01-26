From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 0/5] [WAS: Submodule Groups] Labels and submodule.autoInitialize
Date: Tue, 26 Jan 2016 13:50:23 -0800
Message-ID: <CAGZ79kapcGDFx+=VNCPvRMUGBJiTzJqGWv6UzPNgMOVBKgwXdw@mail.gmail.com>
References: <1453509103-16470-1-git-send-email-sbeller@google.com>
	<56A52818.8080808@web.de>
	<CAGZ79kY1Wa7kHh7GaCTAAmyaRgrT4_91XLaHZFrko9umEbNYkw@mail.gmail.com>
	<56A7DE2C.3020308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 26 22:50:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOBVP-0002ov-FK
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 22:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbcAZVu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 16:50:26 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:35735 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbcAZVuY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 16:50:24 -0500
Received: by mail-io0-f175.google.com with SMTP id 77so200965864ioc.2
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 13:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JXwB6MbdG4S9aWEmYBfAPgeJYASJ2R3WCDtZqb2R/io=;
        b=P+FKtGDB8tuJ6llK2SufvNsTm/FFaAZzmTRmPDTXv/lcHwTSBSpOt7sSWN2ACcQRwk
         Zf7UPpaAG1H6lkATrgcZNxImJ8IAlDDjNoCxrG1LJld6tmEeNv4dFAAy2lseF82O7GT1
         y9CgaZ/laVKP8lfAwhx2OZdWs0nQx6f18lEry6BPGHtY8kP4u6jeKARmoR3g9WbYNfNz
         IMtiPhNywM5PvwJuQc6DWpVVvLxwqMX3vSLO873fWrBaQ/knbAMUIRx46SwDzuJvNqwp
         2Zgc8Z2gHxmju4sdcy+yJ3HJFFjsm2Pi842u3aVgHlMTuwO7v5GpduNOD8ACkKAfD7W8
         xysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JXwB6MbdG4S9aWEmYBfAPgeJYASJ2R3WCDtZqb2R/io=;
        b=PZwEtlEzQ//qpcVm3M+NMfOTOWmvE2FmivXselHZcQ9OjzV3VRwD9ObYkDqEeG+VVP
         zxmSd8Ywm5X9l7qj7n2Wbm3j6CsRKxejjFZmSv0Qnne28PkPjCdkyHLI7NYORNp6hMoV
         /VRJJw8McG+v6bbkRU5Et/GWqqknFnTznTBDUkJhlzWSDEVO/HUldV1n6T+A80HjJqZf
         t8bWZlXeyGxFGMb3EbGIfPRWU9JiXMrThylMh3XfZw5n4saDUaK2dD41NG0tbV6kaNUG
         +xRVHVg7p8mE8EjirwGIpJroVe5UlBeDE7z/YkRztYuxEFEH+w6gxwhMmgVOVWoiRVmw
         4XZQ==
X-Gm-Message-State: AG10YOQ01fDJ6d9fukJku3Ooofhsa/kpjUK1JUdltUthKXwFfrdAmgIrfOdM3f6+JzFEIsOHBLPqRgkZkzVRZ9bK
X-Received: by 10.107.168.203 with SMTP id e72mr24327475ioj.96.1453845023102;
 Tue, 26 Jan 2016 13:50:23 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Tue, 26 Jan 2016 13:50:23 -0800 (PST)
In-Reply-To: <56A7DE2C.3020308@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284858>

On Tue, Jan 26, 2016 at 12:59 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:

>>> Ok. Though we might wanna call it submodule.autoUpdate, as initializing
>>> it is only the prerequisite for automatically updating submodules. And
>>> I believe automatically updating is the thing we're after here, right?
>>
>>
>> I am not sure here, too. I would not mind an occasional "git submodule
>> update"
>> for whenever I want upstream to come down on my disk.
>
>>
>>
>> However that's what I
>> do with "git pull" in the non-submodule case, so you'd expect git pull to
>> also run the update strategies for all submodules which are configured to
>> autoUpdate?
>>
>> That makes sense to me. Though I never use "git pull" to begin with.
>> I always use fetch and see how to go from there (merge or rebase
>> after inspecting the code I fetched). That would mean we want to
>> add the autoUpdate strategy to merge/rebase and the fetching of
>> submodules to the fetch command?
>
>
> Hmm, maybe autoUpdate promises too much.

Yes, this very much. I feel like I get burned whenever I send a large
patch series.
So I want to have this first feature be the smallest "operational
unit" that makes sense.

> After all this config is
> just about which submodules are chosen to be updated on clone and
> submodule update, not on all the other work tree manipulating
> commands.

So you'd imagine that "git submodule update" would remove the
submodule and setup an empty directory in case that submodule is
not configured ? (after switching branches or when just having cloned
that thing.)

>
> And it's similar to what sparse does. So what about calling that
> "submodule.updateSparse"? Or maybe "submodule.sparseCheckout"?
> Suggestions welcome.

I'd only suggest when it's clear to me what that option actually does. :)

>
>>> I'll try to explain why I believe we should be generous in initializing
>>> submodules: If a submodule in one branch has a label configured to be
>>> automatically updated and hasn't got the same label in another branch,
>>> we still need to initialize the submodule even when we are on the latter
>>> branch in case the user switches to the first branch, right?
>>
>>
>> No. "git checkout" ought to autoInitalize the submodule in question when
>> switching branches. I don't want to see initialized, but unused submodules
>> around (neither empty dirs nor in the .git/config ideally)?
>
>
> Why not? Empty dirs is what unpopulated submodules look like from day
> one (and they make the user aware she cannot add a file of the same
> name). And you'll see initialized, but unused submodules around every
> time you switch to a branch that doesn't contain this submodule at all.

I see. We need to keep the dir around to block that file name from being
added. That makes sense.

Mentally I am still stuck in the "very large superproject tracking all the
modules of an operating system" thing, where I'd find it annoying if you'd have
100 top level directories, but you have one populated for your work.

But the reason for name blocking makes sense, so I'll follow with that.

>
> And keeping them initialized even if they aren't currently checked out
> is the only way they can keep their settings when the user is switching
> between branches.

Right, but we could invent some non-initialized, but we keep the
settings somewhere
mode. But as I agree on having them initialized, I'll take this an an
extra point to
follow your reasoning.

>
>>> And the
>>> fetch command needs to fetch submodule changes too when they happen in
>>> a branch where this submodule is part of a label group configured to be
>>> updated automatically, no matter what is currently found in the work
>>> tree.
>>
>>
>> Right, as said above fetch needs to fetch all the submodules as well. I
>> wonder
>> if it needs to fetch all submodule sha1s only or just try to get as
>> much from the
>> submodule as possible.
>
>
> Right now we just do a simple fetch, but only fetching the SHA-1s could
> be an optimization useful for busy submodules later on.

I'd rather not call it optimisation, but a correctness thing. What if you
force-pushed other content to the submodule (the sha1 is gone and
maybe should not be reachable) or the other case where you want to
clone the submodule with depth 1 (that is a serious case, which currently
breaks). In the shallow submodule case you need to have the exact sha1
for cloning, otherwise it doesn't work correctly.

>
>>> So I'd propose to:
>>>
>>> *) Initialize every submodule present on clone or newly fetched when
>>>     the autoUpdate config is set.
>>
>>
>> What if you clone branch A and then switch to B ? B has a submodule which
>> was not initialized in A. I do not think initializing on clone/fetch
>> is the right thing
>> to do, but rather the branch switching command (checkout) shall make sure
>> all its autoUpdate/autoInitialze submodules are setup properly, no?
>
>
> I disagree. If you init all submodules on clone/fetch you might need
> to change the upstream URL right after that. You can't do that on a
> subsequent branch switch which needs to initialize the submodule again,
> as the former deinit did nuke that configuration.

So we need to keep the information around, which we do by keeping
all the modules initialized all the time.

>
>>> *) Automatically fetch only those submodules that are changed in
>>>     a commit where they have a label configured (in the commit's
>>>     .gitmodules or locally) that is to be checked out.
>>
>>
>> Not sure I follow here.
>
>
> We could restrict fetch to not fetch everything but just those changes
> needed for sparse submodule update. To be able to do that it would
> have to examine the fetched superproject commits if a submodule changed
> and if it is configured to be automatically updated in that commit.

ok, that's an optimisation for later? (not strictly needed for the first series)

>
>>> *) Let "git submodule update" update only those submodules that
>>>     have an autoupdate label configured.
>>
>>
>> Why not update all initialized submodules? (In my imagination
>> "all initialized submodules" are equal to "all submodules the user is
>> interested in", i.e. when going from branch A to B, the checkout will
>> (de-)init submodules as necessary.
>
>
> And throw away any customization the user did (to the URL or other
> configurations)?
>
> Without this sparse/label/group functionality, init is the way the
> user tells us he is interested in a submodule. But when configuring
> a label/name/path to update, the old meaning of init is obsolete
> and superseded by the new mechanism.

Or if we keep it at "--initSubmodule" only, which only initializes
a subset of new submodules, the meaning is not superseded.

By having the initSubmodule thing set, the user tells us "I am interested
in all currently initialized submodules plus some more in the future, but
these have not arrived yet. To know which submodules I mean in the future
apply this pattern."

Let's take the simplest case:

A user is interested in all the submodules. So currently they clone
and initialize all of them. When upstream adds a new submodule, their
expectation is broken that all submodules are there and checked out.
by having the autoInit option, we'd just initialize any new submodule
and the user assumption "I have all the submodules" is true after
any "submodule update".

By that point of view, we would not need to keep all submodules initialized,
but only those the user is interested in. No need to have complicated
branch switching rules, but just as now "plus some futureproof rules
to declare my interest of submodules".

>
>>> That will make switching between branches with different label
>>> configurations work fine. Or am I missing something here?
>>>
>>> And we need to teach diff and status to complain about empty work
>>> trees and missing initialization of submodules that are to be
>>> automatically updated too.
>>
>>
>> What about empty work trees?
>>
>> I'll add "git status" complaining about missing initialized submodules.
>
>
> If they are to be updated on the next "git submodule update" ;-)

right.

>
>>>
>>>>       # The prefix * denotes a label as found in .gitmodules
>>>>       # : goes before names
>>>>       # path are prefixed ./ currently
>>>>       # both path and names need work
>>>
>>>
>>>
>>> Question: how do I configure all submodules to be automatically
>>> initialized without having to give them a label? "./*"? Or just
>>> setting the option without a specific value?
>>
>>
>> I'd guess ./* should do. Path wildcard patterns are not supported in this
>> series, but I think it would be a viable way.
>
>
> Ok.
>
>>>>       # no --init necessary, partially initializes submodules (only
>>>> those
>>>> which
>>>>       # were specified by label, name or path)
>>>>       $ git submodule update
>>>
>>>
>>>
>>> Yup. Just like they will be fetched if they haven't been yet they
>>> should be initialized if they haven't been yet but are configured
>>> to be automatically updated.
>>>
>>>>       # time passes, upstream may have added new submodules and we get
>>>> them
>>>> without
>>>>       # extra commands!
>>>>       $ git submodule update
>>>>
>>>>       # The above configuration can be given to git clone directly via:
>>>>       $ git clone --init-submodule=*labelA ...
>>>
>>>
>>>
>>> Ok. Expecially nice is the ability to also give names and paths to
>>> "--init-submodule". (but maybe that option should be called
>>> "--autoupdate-submodule" for the reasons stated above?)
>>
>>
>> If I can understand the discussion above a bit further, I'd be happy
>> to rename the option.
>>
>> I think we have some different opinions on when
>> submodules are initialized (the invariant of what an initalized submodules
>> means), and resulting from that we also have different opinions on when
>> to do the (de-)init.
>
>
> Yes. But I hope my arguments will convince you ;-)

--autoupdate-submodule seems to be one step ahead of my current understanding?

Thanks,
Stefan

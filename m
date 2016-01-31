From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 0/5] [WAS: Submodule Groups] Labels and
 submodule.autoInitialize
Date: Sun, 31 Jan 2016 22:09:24 +0100
Message-ID: <56AE7804.1060609@web.de>
References: <1453509103-16470-1-git-send-email-sbeller@google.com>
 <56A52818.8080808@web.de>
 <CAGZ79kY1Wa7kHh7GaCTAAmyaRgrT4_91XLaHZFrko9umEbNYkw@mail.gmail.com>
 <56A7DE2C.3020308@web.de>
 <CAGZ79kapcGDFx+=VNCPvRMUGBJiTzJqGWv6UzPNgMOVBKgwXdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 22:09:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPzFc-0006qW-V0
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 22:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757363AbcAaVJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 16:09:37 -0500
Received: from mout.web.de ([212.227.17.12]:58362 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757294AbcAaVJf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 16:09:35 -0500
Received: from [192.168.178.41] ([79.211.111.96]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MHp8z-1aMxVd0pcD-003c4V; Sun, 31 Jan 2016 22:09:28
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <CAGZ79kapcGDFx+=VNCPvRMUGBJiTzJqGWv6UzPNgMOVBKgwXdw@mail.gmail.com>
X-Provags-ID: V03:K0:3dyWqyGICZGtlBv9Xxt4m+VHcfnNjEWp9yujsFvua3oi6DKypiw
 Z4cgc72pNZrpCyviDt37Y1EAD1n+dBTmLhVrKaOs1p+/8FDIVi+1U2ft+4vtnBzzOH8XvNU
 0VySadJgmIz3YffjkApecaG0tUb1LfxfYyuYu5Qpaosb3PIq1g898MbOKax8sEpdxDP1ttv
 Ds9JD8hYRjMMTETbxVLeg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nOS4FAXWFx0=:u1wLeMxcI4qPf65IWF92Vz
 I/O3cXNzWOqbv1VI/psYLt6kbxcfBEZtNNGYA12bTymR4TW/JqRZ3C7dX8Or80bL84Q+PfDVH
 TG9LbcxEtI7Hvz1rrWoroyEtUKm2nFPU6b1+LDc8EP+fk35I04RxevHIgBJ0THMQsXt+K2hjl
 o9P9HqivEj+eygrmDVrVJ92+JucOxqvCpoI1mVTCdQDVfpPrHP0sFdieCkj6C+eGYN4GMyJkx
 L6HwOS8CaLPkQT/sEe8gxdphiAA+Ci6QssO6p2OdvjqSEwM6AepNCBeZjgIKQWS1upcnT0TEA
 HbXHrRYoUk8ObW5S6HvptVAO8Ld5krwWkAtYH/sQTJ8fYu0W6yqzdrH6VoNbu6Q/XEFu9ez4E
 sBs+HER2rw4+A3j/49uWC+nbk9qbbPFzNNjVm65+dwSh0F2mVOaHu8Ck7JnSuYZ02PsJdrRf0
 Y+rstwwbKXsvgjQsP76zekdcoSRq0myaZC0SOFEHU4wc8RO8elur38TwQPYs6lN6S4/iJXoz5
 Hbg4C44sF0rz8gePXUwbPhwJHRbKxoholYpX1vfOxhULn62IFiBjsLCURhB7k9ne0bRTyPx1q
 Oyj8I0FfevjqkJ3qePvqF1glKsR70zYz9XERA1qlmqxENfoyOIAKkLJWoDxSPrGva+6/3ZzXB
 UoS51tmeIsFsyWvYMHqKvuTxgJ1STzEbMRAJBZMHkbnpPHfbRLOltaUsWMkGjSoqOewqf/tlp
 ooWaK3DgFUswIvjSR1smiK1VsxZDlWWJhR2QoI0zEkkhssLI/lvKFFYRxXqD743eMFvrNowM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285173>

Am 26.01.2016 um 22:50 schrieb Stefan Beller:
> On Tue, Jan 26, 2016 at 12:59 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>
>>>> Ok. Though we might wanna call it submodule.autoUpdate, as initializing
>>>> it is only the prerequisite for automatically updating submodules. And
>>>> I believe automatically updating is the thing we're after here, right?
>>>
>>>
>>> I am not sure here, too. I would not mind an occasional "git submodule
>>> update"
>>> for whenever I want upstream to come down on my disk.
>>
>>>
>>>
>>> However that's what I
>>> do with "git pull" in the non-submodule case, so you'd expect git pull to
>>> also run the update strategies for all submodules which are configured to
>>> autoUpdate?
>>>
>>> That makes sense to me. Though I never use "git pull" to begin with.
>>> I always use fetch and see how to go from there (merge or rebase
>>> after inspecting the code I fetched). That would mean we want to
>>> add the autoUpdate strategy to merge/rebase and the fetching of
>>> submodules to the fetch command?
>>
>>
>> Hmm, maybe autoUpdate promises too much.
>
> Yes, this very much. I feel like I get burned whenever I send a large
> patch series.
> So I want to have this first feature be the smallest "operational
> unit" that makes sense.

Agreed.

>> After all this config is
>> just about which submodules are chosen to be updated on clone and
>> submodule update, not on all the other work tree manipulating
>> commands.
>
> So you'd imagine that "git submodule update" would remove the
> submodule and setup an empty directory in case that submodule is
> not configured ? (after switching branches or when just having cloned
> that thing.)

Not as a result of the label feature we are talking about here,
I think that should just do what currently happens to removed
submodules: they are left populated but are ignored by status,
diff and submodule update. Removing the content is part of the
recursive submodule update topic.

>> And it's similar to what sparse does. So what about calling that
>> "submodule.updateSparse"? Or maybe "submodule.sparseCheckout"?
>> Suggestions welcome.
>
> I'd only suggest when it's clear to me what that option actually does. :)

Fair enough! ;-)

>>>> And the
>>>> fetch command needs to fetch submodule changes too when they happen in
>>>> a branch where this submodule is part of a label group configured to be
>>>> updated automatically, no matter what is currently found in the work
>>>> tree.
>>>
>>>
>>> Right, as said above fetch needs to fetch all the submodules as well. I
>>> wonder
>>> if it needs to fetch all submodule sha1s only or just try to get as
>>> much from the
>>> submodule as possible.
>>
>>
>> Right now we just do a simple fetch, but only fetching the SHA-1s could
>> be an optimization useful for busy submodules later on.
>
> I'd rather not call it optimisation, but a correctness thing. What if you
> force-pushed other content to the submodule (the sha1 is gone and
> maybe should not be reachable)or the other case where you want to
> clone the submodule with depth 1 (that is a serious case, which currently
> breaks). In the shallow submodule case you need to have the exact sha1
> for cloning, otherwise it doesn't work correctly.

I'm convinced. Correctness it is! :-)

>>>> So I'd propose to:
>>>>
>>>> *) Initialize every submodule present on clone or newly fetched when
>>>>      the autoUpdate config is set.
>>>
>>>
>>> What if you clone branch A and then switch to B ? B has a submodule which
>>> was not initialized in A. I do not think initializing on clone/fetch
>>> is the right thing
>>> to do, but rather the branch switching command (checkout) shall make sure
>>> all its autoUpdate/autoInitialze submodules are setup properly, no?
>>
>>
>> I disagree. If you init all submodules on clone/fetch you might need
>> to change the upstream URL right after that. You can't do that on a
>> subsequent branch switch which needs to initialize the submodule again,
>> as the former deinit did nuke that configuration.
>
> So we need to keep the information around, which we do by keeping
> all the modules initialized all the time.

Yup.

>>>> *) Automatically fetch only those submodules that are changed in
>>>>      a commit where they have a label configured (in the commit's
>>>>      .gitmodules or locally) that is to be checked out.
>>>
>>>
>>> Not sure I follow here.
>>
>>
>> We could restrict fetch to not fetch everything but just those changes
>> needed for sparse submodule update. To be able to do that it would
>> have to examine the fetched superproject commits if a submodule changed
>> and if it is configured to be automatically updated in that commit.
>
> ok, that's an optimisation for later? (not strictly needed for the first series)

Definitely.

>>>> *) Let "git submodule update" update only those submodules that
>>>>      have an autoupdate label configured.
>>>
>>>
>>> Why not update all initialized submodules? (In my imagination
>>> "all initialized submodules" are equal to "all submodules the user is
>>> interested in", i.e. when going from branch A to B, the checkout will
>>> (de-)init submodules as necessary.
>>
>>
>> And throw away any customization the user did (to the URL or other
>> configurations)?
>>
>> Without this sparse/label/group functionality, init is the way the
>> user tells us he is interested in a submodule. But when configuring
>> a label/name/path to update, the old meaning of init is obsolete
>> and superseded by the new mechanism.
>
> Or if we keep it at "--initSubmodule" only, which only initializes
> a subset of new submodules, the meaning is not superseded.
>
> By having the initSubmodule thing set, the user tells us "I am interested
> in all currently initialized submodules plus some more in the future, but
> these have not arrived yet. To know which submodules I mean in the future
> apply this pattern."
>
> Let's take the simplest case:
>
> A user is interested in all the submodules. So currently they clone
> and initialize all of them. When upstream adds a new submodule, their
> expectation is broken that all submodules are there and checked out.
> by having the autoInit option, we'd just initialize any new submodule
> and the user assumption "I have all the submodules" is true after
> any "submodule update".
>
> By that point of view, we would not need to keep all submodules initialized,
> but only those the user is interested in. No need to have complicated
> branch switching rules, but just as now "plus some futureproof rules
> to declare my interest of submodules".

I'm not sure what "complicated branch switching rules" you are
referring to here, as far as I can see these only happen when we do
not automatically initialize all submodules. What am I missing?

You'd have to deal with initialized but not to be updated submodules
anyway (due to the user choosing a different label or upstream
changing label assigments). So it looks to me like the approach to
initialize them all as soon as they appear is easier to grok. And
update, diff and status will just skip all submodules that don't
match the configured label(s).

Additionally this will make it easier to e.g. change the upstream
URL of the submodules in one go, as this has to be done after they
have been initialized. If you clone the android repo from a local
mirror it'd be great to just update all URL settings once right
after clone instead of having to do that again each time you choose
a different group.

So I'm not per se against a lazy submodule init like you seem to
propose it, but I believe it'd be better to just init them all as
soon as they appear.

>>>>>        # The prefix * denotes a label as found in .gitmodules
>>>>>        # : goes before names
>>>>>        # path are prefixed ./ currently
>>>>>        # both path and names need work
>>>>
>>>>
>>>>
>>>> Question: how do I configure all submodules to be automatically
>>>> initialized without having to give them a label? "./*"? Or just
>>>> setting the option without a specific value?
>>>
>>>
>>> I'd guess ./* should do. Path wildcard patterns are not supported in this
>>> series, but I think it would be a viable way.
>>
>>
>> Ok.
>>
>>>>>        # no --init necessary, partially initializes submodules (only
>>>>> those
>>>>> which
>>>>>        # were specified by label, name or path)
>>>>>        $ git submodule update
>>>>
>>>>
>>>>
>>>> Yup. Just like they will be fetched if they haven't been yet they
>>>> should be initialized if they haven't been yet but are configured
>>>> to be automatically updated.
>>>>
>>>>>        # time passes, upstream may have added new submodules and we get
>>>>> them
>>>>> without
>>>>>        # extra commands!
>>>>>        $ git submodule update
>>>>>
>>>>>        # The above configuration can be given to git clone directly via:
>>>>>        $ git clone --init-submodule=*labelA ...
>>>>
>>>>
>>>>
>>>> Ok. Expecially nice is the ability to also give names and paths to
>>>> "--init-submodule". (but maybe that option should be called
>>>> "--autoupdate-submodule" for the reasons stated above?)
>>>
>>>
>>> If I can understand the discussion above a bit further, I'd be happy
>>> to rename the option.
>>>
>>> I think we have some different opinions on when
>>> submodules are initialized (the invariant of what an initalized submodules
>>> means), and resulting from that we also have different opinions on when
>>> to do the (de-)init.
>>
>>
>> Yes. But I hope my arguments will convince you ;-)
>
> --autoupdate-submodule seems to be one step ahead of my current understanding?

Yes, sorry for the confusion.

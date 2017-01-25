Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6C361F70F
	for <e@80x24.org>; Wed, 25 Jan 2017 07:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbdAYHHk (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 02:07:40 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:33150 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbdAYHHj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 02:07:39 -0500
Received: by mail-io0-f194.google.com with SMTP id 101so1022754iom.0
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 23:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=wEJLqK9OrjnJT2E40OOYHxVNUrrMqpDKl3G9gfHXzV0=;
        b=YqakHxXCbMsgYPDWTz2zzPAXoKaOZa6tq4jjGgVzJiUXJPcS7zevogHk/t+SoZXxLA
         yP2LUOHbNbm0qTxphBwbxBMn6SS3J6Bp99lWIGyW4IFy0AioWbtQJGgvvMOSMsSWKlLj
         r1iF+gxaOPQeo7dr1bFN8e8s2IPCd0ILN89+0dl0tlYa3/U60GLVvY6ns5Xpqyy71FDz
         mvzk8Rw16K29nEvCOxpkjI1P1PkHyyOhme6D3Z4qEcu/iMteqUKrNNUSNLi6ohvO3hbX
         gkYJ0ZC3gSaVYSLkGqm4IonEY0aIi9wPGscJEpX0p3mXvB/kmhws0drgcvZ+i11wgDMz
         d0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=wEJLqK9OrjnJT2E40OOYHxVNUrrMqpDKl3G9gfHXzV0=;
        b=J1HK5O2R8/XH1U1LWdSBAQW5DsqboB4MWNhZxSOCZaIMadSr3nEsAMuOt4xvE/zwbe
         xdfhD2DcoM+RY1CpQOOMByNkzIwh/ItMEzFWhF2/V7ep5SojKl39c5xbk1PLs4Hp5Xvp
         3T3fpT96a5KPeiYVdZfd4s4h42dLjwj2/yJvFELDuGGyRq0m7qScz8DfJSNoP68PSxpq
         1UmsUoSVWeFmpOkMyUBsGJPeSBNoXbCSr4Pi6QZzrlmuQZCd/t3njjVnaCpJpT4WzJlv
         q+ymwTugvx8VlbpZ4a2h8ilUxwX4TzvP/tysJ51FaB+2H6dLc5fA8WmQXxCv8xJAjzQ2
         SEDg==
X-Gm-Message-State: AIkVDXL6gKSWOsZ6uyqKMFZbzbMVctphstg97dWfhjCS1yiGSdjXWDry2QD/HTjqMgAgLg==
X-Received: by 10.107.134.36 with SMTP id i36mr32762054iod.168.1485328058380;
        Tue, 24 Jan 2017 23:07:38 -0800 (PST)
Received: from [192.168.1.190] (h69-129-206-25.mdsnwi.broadband.dynamic.tds.net. [69.129.206.25])
        by smtp.gmail.com with ESMTPSA id i62sm9869471itb.12.2017.01.24.23.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jan 2017 23:07:37 -0800 (PST)
Subject: Re: submodule network operations [WAS: Re: [RFC/PATCH 0/4] working
 tree operations: support superprefix]
To:     Stefan Beller <sbeller@google.com>
References: <CAGZ79kZRV7x9B6SHRcHjJweHrjURxWKmN-=Wz_aNw2TPwYh_xw@mail.gmail.com>
 <ebf6c90e-044f-5538-2325-601d002a81fe@gmail.com>
 <CAGZ79kaf0BhbnJGhkjT_Ys44y4c4AaxV8U_ydWp4bbFMkGRcsQ@mail.gmail.com>
 <e6c5567a-2032-c598-97c8-08518f86b611@gmail.com>
 <CAGZ79kaS7zt3DKrRuqzzODc1HHEP-xd-8HBC0JA-HvmqAJOZfw@mail.gmail.com>
 <04fe8035-dbf0-83d2-c465-f746b99ce609@gmail.com>
 <CAGZ79kZzekMc=pUN3Q2+zmaSNo-BLJ6TxaQPN8ik1B2+ACy9dw@mail.gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
From:   "Brian J. Davis" <bitminer@gmail.com>
Message-ID: <fe03b88b-b3b2-0906-3912-2e123a4d8af9@gmail.com>
Date:   Wed, 25 Jan 2017 01:14:34 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZzekMc=pUN3Q2+zmaSNo-BLJ6TxaQPN8ik1B2+ACy9dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/24/2017 12:49 PM, Stefan Beller wrote:
> On Sat, Jan 21, 2017 at 7:53 AM, Brian J. Davis <bitminer@gmail.com> wrote:
>> On 1/19/2017 7:22 PM, Stefan Beller wrote:
>>>>> Between the init and the update step you can modify the URLs.
>>>>> These commands are just a repetition from the first email, but the
>>>>> git commands can be viewed as moving from one state to another
>>>>> for submodules; submodules itself can be seen as a state machine
>>>>> according to that proposed documentation. Maybe such a state machine
>>>>> makes it easier to understand for some people.
>>>>
>>>> "Between the init and the update step you can modify the URLs."  Yes I
>>>> can
>>>> and have to... wish it was not this way.
>>> So how would yo u rather want to do it?
>>> look at the .gitmodules file beforehand and then run a "submodule update"
>>> ?
>>> Or a thing like
>>>
>>>       git -c url.https://internal.insteadOf git://github.com/ \
>>>           -c submodule.record-rewritten-urls submodule update
>>>
>>> (no need for init there as theoretically there is not
>>> need for such an intermediate step)
>>>
>> "Yes please and thank you" ... both.
>>
>> My thought was to simply allow addition to .gitmodules.  If I understand
>> correctly you are proposing, to override these at the command line and
>> possibly rewrite them on submodule update, but maybe not save or add to
>> .gitmodules. I would then propose both.
>> 1) allow user to add to .gitmodules for those who do not care that
>> "outsiders" know the internal dev server
>> and
>> 2) allow to rewrite while not saving to .gitmodules on fresh clone and
>> submodule update for thoes that do not want ousiders to known internal dev
>> server.
>> and possibly:
>> 3) allow at command line to add remote to .gitmodules on submodule commands
>> (note add optoin in -c <name> = <value> pair)
>>
>> .gitmodules before:
>>
>> [submodule "subprojects/wrangler"]
>>          path = subprojects/wrangler
>>          url = git://github.com/
>>
>> Then your adapted command:
>>
>> git -c url.https://internal.insteadOf git://github.com/ \
>>          -c submodule.record-rewritten-urls=add,internal --add submodule
>> update
>>
>> would produce
>>
>> [submodule "subprojects/projname"]
>>          path = subprojects/projname
>>          remote.origin.url = git://github.com/
>>          remote.internal.url =https://internal.insteadOf
>>
>> Or similar support.
> I think this was avoided until now as it would rewrite/add history.
> So what if you want ot "just mirror" a large project with a lot
> of submodules? You would want to do that without touching
> the history, hence we'd need to do such a configuration in a separate
> place. IIRC there was a proposal to have a ref e.g.
> "refs/submodule/config", that can overwrite/extend the .gitmodules
> file with your own configuration. It is a ref, such that mirroring would
> work, but not part of the main history, such that yoiu can still change it.
How would this handle the hashes for the submodules tracked in the super 
project.  This gets to my earlier statement that git submodules is not 
really that well thought out.  When/if /refs/submodule/config 
overwrites/extends .gitmoduels what does git checkout for a hash code 
(version) for the subproject?  Maybe there are some simple ways of doing 
this, but it really seems to me that git submodules needs an overhaul to 
support multiple remotes.  Would the refs/submodule/config also include 
the versions hashes for the submodule for both remotes?  When switching 
between remotes would the git submodule update pull the correct hash 
version for the subproject and pull the correct version of the subproject?
> I think to get it right we need to enable a workflow that allows easy
> "multi-step" mirroring, e.g. A (source of truth) can be mirrored to B,
> who can overlay the .gitmodules to point to server-B, which then can
> be mirrored by C, who can have its own serverC.
>
> When C forgot to configure all the submodules, it should fall back to
> serverB as that was closest, and if that is unconfigured it should
> fallback to A IMO.
>
>
>
>>>>> [remote "origin"]
>>>>>      url = https://github.com/..
>>>>> [remote "inhouse"]
>>>>>      url = https://inhouse.corp/..
>>>>>
>>>>> But where do we clone it from?
>>>>> (Or do we just do a "git init" on that submodule and fetch
>>>>> from both remotes? in which order?)
>>>> origin by default and inhouse if specified. There is already a implied
>>>> default (origin). The idea was not to do both but rather what is
>>>> specified.
>>>> Origin and inhouse are just names for remotes. If one wanted a
>>>> "--all-remotes" could pull from everywhere in the Ether if feature was to
>>>> be
>>>> implemented.
>>> How is origin implied to be the default?
>>> Should there be an order (e.g. if you cannot find it at inhouse get it
>>> from github,
>>> if they are down, get it from kernel.org)
>> As it is in the Highlander series... "there can be only one" (remote).   So
>> that is what I mean by origin.  The only remote allowed is the "origin"
>> unless changed by the user... but there can still only be one *currently*.
>> Though I see your point as it is not labeled "origin".  It is not labeled at
>> all.  Apologies for confusion there.
> "origin" is just a common name for a remote, like "master" is a common name
> for branches. There is nothing inherently special about these except for
> their automatic setup after cloning/initializing a repo.
Origin is the remote from where all was derived and yes it can certainly 
be renamed or deleted (provided another remote name exists) in git.  
Sadly "master" is a term used in git which always implies another term.  
I thought term "master" was long since killed in the computer world with 
the USB 1.1 to 2.0 debate, ... but here it still lives in git.  What is 
wrong with the term trunk?  Trees don't have masters... they have 
trunks... but i digress on the term "master".  I will try and get my git 
terms right even if IMO they are at times the wrong terms.
> So you can delete the master branch (which I did in a project
> that I am not the authoritative maintainer of; I only have feature
> branches), and
> the repository just works fine.

I too have deleted the "master" branches in previous projects.


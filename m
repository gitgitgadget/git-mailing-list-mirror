Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78D2D1F406
	for <e@80x24.org>; Sun, 31 Dec 2017 20:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbdLaUo3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 15:44:29 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53123 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750923AbdLaUo2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 31 Dec 2017 15:44:28 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B0EF218D8;
        Sun, 31 Dec 2017 15:44:28 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Sun, 31 Dec 2017 15:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keith.so; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=mesmtp; bh=Qm7CiYLCz0JO4wM9pc4db58peP
        YlKQ8G2b8DSYLG02A=; b=kscdjUY2zNNGoMo1i621mi60o/x6hhHL/AAzRXGzFz
        T1Qpw/TPrar5O7jlFTWGqOemZ5oC2c2um8uFOKV/bVn0Td6YyMLcwhkR7OnxE4sk
        Bo5w30xR1t1y6s+FW1gANMPjbda5ewuSNSD0Qhn3qTXqUg7tnd9KkGT/22cHmma6
        Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Qm7CiY
        LCz0JO4wM9pc4db58pePYlKQ8G2b8DSYLG02A=; b=h7RPbT0+uWHeylbeK7T552
        ZoOgxMS8zl8N5uuUQBhObCH4PHVDQb+514TdF9huDncN6+L3N2OKA/3dWzeJpKEn
        KdhdJ7UA4RhJYQM/BNyIQxFDjToQhmAj+CZpwiuh514b3DCP04m75eWwPc5iNbHO
        keHRajguICc6vekWd0SwvP3T7U6R0FXDmmQNkNEs28Wt36euQvaVS2dcSlsAaIvc
        jdeM2f8AqpCkxiIP/OKzX/eYwjAzayrSuNE7wZrC6OGhGD7xkLkLaPytmlOXRdFZ
        fx3NdatZrUCL6GXWXxij/ai3bkpXX/230s/xYbiyGGJf42scPqJDkLvWT7OrLRdQ
        ==
X-ME-Sender: <xms:K0xJWoF-tmFPu3gO5-c0InEwHan7Lih0-KgAX7hzUIoDq9BVEidUUQ>
Received: from localhost (unknown [136.24.23.40])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8340A2465D;
        Sun, 31 Dec 2017 15:44:27 -0500 (EST)
Date:   Sun, 31 Dec 2017 12:44:26 -0800
From:   Keith Smiley <k@keith.so>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] Add shell completion for git remote rm
Message-ID: <20171231204426.GA30674@bryant.local>
References: <20171229135240.GQ3693@zaya.teonanacatl.net>
 <20171229224825.31062-1-szeder.dev@gmail.com>
 <87y3ll6s0e.fsf@evledraar.gmail.com>
 <20171230005222.GT3693@zaya.teonanacatl.net>
 <87vago76i8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87vago76i8.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm definitely happy to update this patch for now to just complete the 
remote names, and not add rm to the list of subcommand completions if 
we're all ok with that!

--
Keith Smiley

On 12/30, Ævar Arnfjörð Bjarmason wrote:
>
>On Sat, Dec 30 2017, Todd Zullinger jotted:
>
>> Ævar Arnfjörð Bjarmason wrote:
>>>> I think adding 'rm' to completion definitely counts as advertisement.
>>>> It doesn't have much practical use, after all: typing 'rm' with
>>>> completion is actually one more keystroke than without (r<TAB>m vs. rm).
>>>
>>> This is only one use of the completion interface, maybe you only use it
>>> like that, but not everyone does.
>>>
>>> The completion interface has two uses, one is to actually save you
>>> typing, the other is subcommand discovery, and maybe someone who has a
>>> use neither you or I have thought of is about to point out a third.
>>>
>>> I'll type "git $whatever $subcommand<TAB>" as *validation* that I've
>>> found the right command, not to complete it for me. This is a thing
>>> that's in my muscle memory for everything.
>>
>> Is that meant to be in favor of including rm in the
>> completion results or against? :)
>
>For.
>
>>> Since I've been typing "git remote rm<TAB>" for a while (started before
>>> this deprecation happened) I've actually been meaning to submit
>>> completion for "rm" since it works, not knowing about Duy's patch until
>>> now.
>>>
>>> Now, even if someone disagrees that we should have "rm" at all I think
>>> that in general we should not conflate two different things, one is
>>> whether:
>>>
>>>     git remote <TAB>
>>>
>>> shows both "rm" and "remove" in the list, and the other is whether:
>>>
>>>     git remote rm<TAB>
>>>
>>> Should yield:
>>>
>>>     git remote rm<SPACE>
>>>
>>> Or, as now happens:
>>>
>>>     git remote rm<NOTHING AND ÆVAR THINKS IT'S BROKEN>
>>>
>>> I can see why we'd, in general, we'd like to not advertise certain
>>> options for completion (due to deprecation, or just to avoid verbosity),
>>> but complete them once they're unambiguously typed out.
>>>
>>> I don't know whether the bash completion interface supports making that
>>> distinction, but it would be useful.
>>
>> It can be done, though I think that it's probably better to
>> subtly lead people to use 'git remote remove' going forward,
>> to keep things consistent.  I don't have a strong preference
>> for or against the rm -> remove change, but since that's
>> been done I think there's a benefit to keeping things
>> consistent in the UI.
>
>We changed it in the past, we can always change it again, it's never too
>late to fix the UI.
>
>Now whether we *should* change/fix this particular thing is another
>matter. I'm just pointing out that we shouldn't fall into the trap of
>thinking that git's UI is an established platform that can't be changed.
>
>The vast majority of people who'll ever use git will most likely start
>using a version that we're going to release many years into the future.
>
>I'm reminded of the story about the guy who decided makefiles must have
>tabs, who didn't want to change it because he already had some dozens of
>users.
>
>> And I think that should also apply to
>> not offering completion for commands/subcommands/options
>> which are only kept for backward compatibility.
>
>Yeah I think it makes sense to at some point stop completing things if
>we're going to remove stuff, if we decide to remove it.
>
>> Here's one way to make 'git remote rm <TAB>' work without
>> including it in the output of 'git remote <TAB>':
>>
>> diff --git i/contrib/completion/git-completion.bash w/contrib/completion/git-completion.bash
>> index 3683c772c5..aa63f028ab 100644
>> --- i/contrib/completion/git-completion.bash
>> +++ w/contrib/completion/git-completion.bash
>> @@ -2668,7 +2668,9 @@ _git_remote ()
>>  		add rename remove set-head set-branches
>>  		get-url set-url show prune update
>>  		"
>> -	local subcommand="$(__git_find_on_cmdline "$subcommands")"
>> +	# Don't advertise rm by including it in subcommands, but complete
>> +	# remotes if it is used.
>> +	local subcommand="$(__git_find_on_cmdline "$subcommands rm")"
>>  	if [ -z "$subcommand" ]; then
>>  		case "$cur" in
>>  		--*)
>
>Neat!
>
>> Keeping 'git remote rm' working to avoid breaking scripts is
>> one thing, but having it in the completion code makes it
>> more likely that it will continue to be seen as a
>> recommended subcommand.
>>
>> This leads to patches like this one, where it's presumed
>> that the lack of completion is simply an oversight or a bug.
>> Of course, the lack of completion hasn't caused everyone to
>> forget that 'remote rm' was changed to 'remote remove', so
>> that reasoning may be full of hot air (or worse). ;)
>>
>> The current result of 'git remote rm <TAB>' isn't so great.
>> It's arguably worse to have it pretend that no subcommand
>> was given than to list the remotes.
>>
>> $ git remote rm <TAB>
>> add            remove         set-head       update
>> get-url        rename         set-url
>> prune          set-branches   show
>
>Although that's a bug that has nothing to do with remove/rm, because you
>also get:
>
>    $ git remote blahblah <TAB>
>    $ git rebase doesntexist <TAB>
>
>etc. showing you valid subcommands, when perhaps we should show
>"warning: no such subcommand `blahblah`/`doesntexist`!" instead.
>
>> I think completing nothing or completing the remotes
>> (without offering rm in the subcommand list) would be
>> better, after looking at it a bit.
>>
>> I don't know how to disable file completion, but I'm not
>> intimately familiar with the git completion script (thanks
>> to it working so damn well).  I'm guessing there's a way to
>> do that, if there's a strong desire to not complete the
>> remotes at all.
>>
>> I don't think we should include rm in 'git remote <TAB>'
>> completion, but I don't care much either way what 'git
>> remote rm <TAB>' includes.  But it should be better than
>> including the other subcommands.

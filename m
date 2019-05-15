Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77E8A1F461
	for <e@80x24.org>; Wed, 15 May 2019 13:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfEONHL (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 09:07:11 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:55915 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfEONHL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 09:07:11 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id Qtcih7kuhgI7iQtcih5HiF; Wed, 15 May 2019 14:07:08 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=CS6mKoAcAAAA:20 a=_-0-ZW8geTAbHovl2Z0A:9
 a=QEXdDO2ut3YA:10 a=APqgjxcRD6nqXdMuohh7:22
Subject: Re: Antw: Re: Missing branches after clone
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
References: <5CDA8D37020000A100031319@gwsmtp.uni-regensburg.de>
 <CACsJy8AX9Wp3W=d1=ozF9nZXGE1muooMf7fKCtdOOi1g8QRmig@mail.gmail.com>
 <0c9ec78a-9245-e1df-7ec6-a5d77d1a5261@iee.org>
 <5CDAAB56020000A100031334@gwsmtp.uni-regensburg.de>
 <b75bd892-b216-3c7d-f9e7-4470300e02fc@iee.org>
 <5CDBD199020000A10003136F@gwsmtp.uni-regensburg.de>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <90bcfd4a-5fc3-69e2-5c7e-1abbbc03e09b@iee.org>
Date:   Wed, 15 May 2019 14:07:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5CDBD199020000A10003136F@gwsmtp.uni-regensburg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfD/C3Ap8IfXtCxKvAOxvPLUZxnPQZD7mMn4QPgwFj6NBB8Z4UjFA2dmdQoPVfq7jB8Ebxvy/DQ4CzcvkluTj3KEKFlwREhYH+kqEpyhFp5fO6epMLUN1
 1oyLREA46tglJuVL47kZ6M70A/UL/DNJQpZNK8cw7HZYkBPZYg9dYz52AVlEW6Idx7KRYA7UQukP+JSKvexqahXSXn++Man0/6Y3QfkNJR6mr2EB/RH9sDa9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/05/2019 09:45, Ulrich Windl wrote:
>> reasoning for that.
>> It's that you are missing the idea behind the "Branches that track the
>> remote", which are local copies, but not YOUR branches. see below.
>> I clone the GitHub test repo. I get (a copy of) it all (the rtb's). Git
>> _creates_ a local branch 'master' for me. Git checks out the lead remote
>> branch into it. Command prompt returns. I cd into the new repo. I ask
>> what branches _I_ have - just 'master'. I ask about all the branches the
>> repo has - voila, I see all those rtb's in _my_ repo. They are all
>> perfectly valid branch refs.
> Yes, I can mostly follow you there with one exception: In the cloned
> repository the branches are not available under the same name as in the
> original repository (unless I'm totally confused). Therefore a beginner would
> simply assume "they are missing".
> I knew that (which was my use case) git optimizes local copies by linking as
> much as possible, but I don't understand why cloned branches are "soooo
> complicated". (I could understand it as an optimization for network copies)

My use case is that I help on the Git-for-Windows development. So I have 
4 upstream repositories I need to look at:
Git, Junio-git (maintainer), Git-For-Windows, and Dscho-git (gfw 
maintainer).

All of them have a 'master' branch - so I can't have 4 different local 
'master' branches. So, because of history, and hassles Dscho et. al. had 
had to use 'develop', instead of 'master' for their lead branch name, 
but now they are all 'master'. So I just copied that for a while.

Meanwhile I more recently learned that I could simply start my new 
feature branches direct from the remote tracking branches (which are 
local!), and don't actually need a master branch at all!!  But it took a 
long time for it all to click into place in my brain. I've have 50+ 
years of the 'old masters' idea of there being a single unique master 
artefact with all other being second rate copies. Now it's all 
duplicates verified by hashes.
>> It will take a little while to appreciate this extra layer and how to
>> use it, and how Git can 'dwim' (do what I mean) the usage of shortened
>> refs and branch names, so it you try checking out 'change-the-title',
>> git will know to fall back to using the rtb if you haven't created a
>> local version.
>> Hope That Helps.
>> Philip
>>
>> phili@Philip-Win10 MINGW64 / (master)
>> $ cd usr/src
>>
>> phili@Philip-Win10 MINGW64 /usr/src (master)
>> $ git clone https://github.com/octocat/Spoon-Knife.git
>> Cloning into 'Spoon-Knife'...
>> remote: Enumerating objects: 16, done.
>> remote: Total 16 (delta 0), reused 0 (delta 0), pack-reused 16
>> Unpacking objects: 100% (16/16), done.
>>
>> phili@Philip-Win10 MINGW64 /usr/src (master)
>> $ cd Spoon-Knife/
>>
>> phili@Philip-Win10 MINGW64 /usr/src/Spoon-Knife (master)
>> $ git branch
>> * master
>>
>> phili@Philip-Win10 MINGW64 /usr/src/Spoon-Knife (master)
>> $ git branch -a
>> * master
>>     remotes/origin/HEAD -> origin/master
>>     remotes/origin/change-the-title
>>     remotes/origin/master
>>     remotes/origin/test-branch
>>
>> phili@Philip-Win10 MINGW64 /usr/src/Spoon-Knife (master)
>> $
>>
>> --
>> PS What change to the [clone?] man page would have helped you here?
> Maybe confirm this: At this state I could "checkout test-branch" (for
> example), but I could not "merge test-branch", right?
> (Another level of confusion is bash-completion which does not know those
> hidden branches)
for completion, use the remote name first. If the action may be 
ambiguous or dangerous because of Dwimming, then git tends to avoid 
doing it..
>
> OK, reading git-clone again, the following might apply:
> Explain (or refer to) what a "remote-tracking branch" is.
Interestingly, try 'git help glossary' to see the glossary of terms. 
Their are other useful guides that can be access by the same method. 
`git help -g` will list them.
>
> "checks out an initial branch that is forked from the cloned repository’s
> currently active branch" could be simplified to "checks out the active branch
> in the cloned repository"?
>
> Maybe add a paragraph at the end of the DESCRIPTION starting like: "To use
> another branch in the clones repository..."
>
> Maybe also add a pointer to the meanings of "origin" and "remote" (I know that
> the clone source becomes remote/origin)
>
> I wonder whether "This default configuration is achieved by creating
> references to the
> remote branch heads under refs/remotes/origin and by initializing
> remote.origin.url and remote.origin.fetch configuration variables." should
> become "The original repository's URL will be visible as remote/origin in the
> cloned reporitory"
>
> Maybe point out the differences between a "default clone" mand a "--mirror
> clone" in the DESCRIPTION.
>
> The example "Clone from upstream while borrowing from an existing local
> directory:" could benefit from a few explaining words (why would one want to do
> that, i.e. what's the effect?)
>
> None of the examples refers to using another branch than the default branch.
> Maybe add two examples:
> 1: checking out a different branch, 2:merging a different branch to the
> current one
>
> That's what I think.
>
> Regards,
> Ulrich
>
>
Thanks

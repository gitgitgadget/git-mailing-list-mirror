Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A38D215FB
	for <e@80x24.org>; Sun, 15 Jan 2017 20:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbdAOU4G (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 15:56:06 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:35011 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbdAOU4F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 15:56:05 -0500
Received: by mail-it0-f66.google.com with SMTP id 203so10453985ith.2
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 12:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=RvxzfKPtMdx6Rwq/MmY1QyWaZtwttqLKleEAIG9KvAQ=;
        b=G2TGsjzcIAc8Kx6s/b9jCft4TqZK/76kZ+Qq4vHMPTHZQp9+nFKb9yqaFGICXeR13z
         P0IdZY01ocwfd0GHblZG4xvmB+xl6NC785Lpxr36FvYThfZsYhNmfNf/ngRgJynSlt5u
         pMspszQETxAQakS4zSYLE8nh+pPRbk789E0HwhlAKyoOVcHZQYBQ9Tr3EMRZ89FYI8av
         dP9FOh1dQrymvRHQnBDMkm5uHKDWXJpQC4o0iv98MSPIfXA+emODD6Mj/HmZpEhIAtAC
         jHscViUcU84ztYByJ/Empeoykyv2ReWmpKSjFY4WYqUV+DUNA23MiabUIEV7ZIGHOmRy
         qfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=RvxzfKPtMdx6Rwq/MmY1QyWaZtwttqLKleEAIG9KvAQ=;
        b=BwbD8PAIVkmPZdZ691hB7MrgbokZ+hz/IdhejCXOwshr9nVNSBIfMqdepxWOdpyJy5
         wUxA4yYjcdM5hCdTqRK68g6uNkQsh8nHlWBE/uwIept+8+DjsEVGgv8iX3oyvaB6RgF6
         h6amb60T2wfmGU7+n54/4LOaqGwCzOqqbZqEuPr5mw7ZmFd9JIbTOCjSObHJeUPNKBqO
         BJRo4AXnKe1WhgjtzFNsmTKnhTy9bu23qRKxfQ2cPViTuWXfq71wZAlnsz4dLcZtd+1H
         XZzohTvgzjWP4YBLTzPqDkt/uHJOW/AWTu1zIKfvia1ejVwfCg4JydmBkKJQbLQsvmpY
         feiA==
X-Gm-Message-State: AIkVDXIzh8nk2W33EajH4ifFR3OeLRkeTkZfQw6omuxv9UXJktdN/zSNSAJ8f7jaFR2nWA==
X-Received: by 10.36.237.68 with SMTP id r65mr13196300ith.44.1484513764288;
        Sun, 15 Jan 2017 12:56:04 -0800 (PST)
Received: from [192.168.1.190] (h69-129-206-25.mdsnwi.broadband.dynamic.tds.net. [69.129.206.25])
        by smtp.gmail.com with ESMTPSA id i62sm4626028itb.12.2017.01.15.12.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jan 2017 12:56:03 -0800 (PST)
Subject: Re: submodule network operations [WAS: Re: [RFC/PATCH 0/4] working
 tree operations: support superprefix]
To:     Stefan Beller <sbeller@google.com>
References: <CAGZ79kZRV7x9B6SHRcHjJweHrjURxWKmN-=Wz_aNw2TPwYh_xw@mail.gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
From:   "Brian J. Davis" <bitminer@gmail.com>
Message-ID: <ebf6c90e-044f-5538-2325-601d002a81fe@gmail.com>
Date:   Sun, 15 Jan 2017 15:02:41 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZRV7x9B6SHRcHjJweHrjURxWKmN-=Wz_aNw2TPwYh_xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 1/13/2017 12:30 PM, Stefan Beller wrote:
> This question is about networking; the patch you originally replied to
> was strictly about local operations in the filesystem, which is quite
> a difference, so let's discuss it separately.
Yep ok look like you reclassified this and opened new topic which I hope 
I am responding to correctly now.
> On Fri, Jan 13, 2017 at 9:56 AM, Brian J. Davis <bitminer@gmail.com> wrote:
>> In response to a post at:
>>
>> https://groups.google.com/forum/#!topic/git-users/BVLcKHhSUKo
>>
>> I was asked to post here to explain a potential problem with current modules
>> implementation.  Apologies if I am posting in the wrong place... so good bad
>> or otherwise here goes:
>>
>> +-------------------------------
>> With:
>>
>> git push origin branchname
>>
>> or
>>
>> git push server2 branchname
>>
>> I can push or pull from multiple servers so no problem as git supports this.
>>
>> Now the problem with use of submodules
>>
>> submodules are listed:
>>
>> submodule.directory_to_
>> checkout/proj1_dir.url=https://git.someserver1/git/proj1_dir
>> <https://git.someserver1/git/proj1_dir>
> Technically it is submodule.<name>.url instead of
> submodule.<path>.url. The name is usually the path initially, and once
> you move the submodule, only the path changes, the name is supposed to
> be constant and stay the same.
I am not certain what is meant by this.  All I know is I can use my 
"directory_to_checkout" above to place in tree relative from root the 
project any where in the tree not already tracked by git.  You state 
name instead of path, but it allows path correct? Either that or I have 
gone off reservation with my use of git for years now. Maybe this is a 
deviation from how it is documented/should work and how it actually 
works?  It works great how I use it.
>>
>> but if say I want to pull from some server 2 and do a
>>
>> git submodule update --init --recursive
> That is why the "git submodule init" exists at all.
>
>      git submodule init
>      $EDIT .git/config # change submodule.<name>.url to server2
>      git submodule update # that uses the adapted url and
>      # creates the submodule repository.
>
>      # From now on the submodule is on its own.
>      cd <submodule> && git config --list
>      # prints an "origin" remote and a lot more
>
> For a better explanation, I started a documentation series, see
> https://github.com/gitster/git/commit/e2b51b9df618ceeff7c4ec044e20f5ce9a87241e
>
> (It is not finished, but that is supposed to explain this exact pain
> point in the
> STATES section, feel free to point out missing things or what is hard
> to understand)
I am not sure I got much out of the STATES section regarding my problem.
>> what I would get is from someserver1 not someserver2 as there is no "origin"
>> support for submodules.  Is this correct?  If so can origin support be added
>> to submodules?
> Can you explain more in detail what you mean by origin support?
Yes so when we do a:

git push origin master

origin is of course the Remote (Remotes 
https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes)

So I best use terminology "Remotes" support.  Git push supports remotes, 
but git submodules does not.  The basic idea is this:

If Git allowed multiple submodule 
(https://git-scm.com/book/en/v2/Git-Tools-Submodules) Remotes to be 
specified say as an example:

git submodule add [remote] [url]

git submodule add origin https://github.com/chaconinc/DbConnector
git submodule add indhouse https://indhouse .corp/chaconinc/DbConnector

Where:

[submodule "DbConnector"]
     path = DbConnector
     url = https://github.com/chaconinc/DbConnector

Could then change to:

[submodule "DbConnector"]
     path = DbConnector
     remote.origin.url = https://github.com/chaconinc/DbConnector
     remote.origin.url = https://indhouse .corp/chaconinc/DbConnector


Then it should be possible to get:

git submodules update --init --recursive

To support

git submodules update [remote] --init --recursive

And thus allow

git submodules update origin --init --recursive

git submodules update indhouse --init --recursive

>
>> +-------------------------------
>>
>> So above was post from google group.  Maybe above is enough to explain the
>> problem that can result, but if not here is a discussion as to why this can
>> be confusing resulting to pushing or pulling from the incorrect server.
>>
>> Lets say projects starts at origin on https://server0.org. Project is then
>> brought in house to server https://indhouse.corp by developer A.
>>
>> Developer A then changes the submodule projects to point to indhouse and
>> changes submodules in super project to point to indhouse so everything is
>> great.
>>
>> Then Developer B clones from indhouse makes changes to submodule1 and
>> submodule1 and pushes them to indhouse.  Dev A tells Dev B hey thoes changes
>> are great why don't you push to public server0 so every one can get thoes
>> changes.  Dev B then git push origin branch_name on submodule1 and push
>> origin on submodule 2 and superproject.  And everything is great ... right?
>>
>> Yes by now those who know git know what dev B  forgot or more to the point
>> what git does not support in a "clean" way.  For those who don't enter the
>> life of dev C
>>
>> So dev C clones from server0 and performs a git submodule update --init
>> --recursive.  Now Dev C is on the www and can't see indhouse.corp and ...
>> kerpow... Dev B and Dev C just experienced one of the many SW mines on the
>> battlefield.
>>
>> I ask that git devs first see if I am correct with this assessment as I
>> could be wrong... maybe there is a way of doing this... and if not add a
>> feature to git to handle submodules and multiple origins cleanly.... and yes
>> beating dev B with rubber chicken might be a solution though I am looking
>> for a slightly better option.
> Yes this is a big point that we want to solve eventually.
>
> When devA brought it inhouse, what they meant to do was this:
> "This superproject is actually from server0, but we want to work on it, which
> may have submodules diverge from server0 eventually. So if a submodule changed
> you need to get it from the inhouse server, otherwise fall back to the server0".
>
> That way developerB can just make changes to some submodules and when
> devC clones
> they get the "correct" submodule.
>
> A weak attempt to do this is to use *relative* submodule urls. When
> using relative urls, and then mirroring the supeproject inhouse, then
> Git will look for the submodules as well inhouse, but there
> is no such "or if not found look at the original superprojects
> origin", which means, you have to mirror all submodules.
Yes I don't see how *relative* urls are a good solution.
> And then about upstreaming changes. If you have a single repo (no
> submodules), you have to teach people to run "git remote add remote
> server0.org && git push upstream ...", but that you can do for each
> submodule. (This is tedious:/ but maybe ok; some submodules are free
> to sent things upstream whereas others are supersecret that you do not
> want to push upstream ever.)
So right yes there are ways and means this can fail and not be 
ultimately what the developer wants after all we all need to be aware of 
the repercussion of the commands typed at the terminal.  My goal here is 
I notice a process that Git does not seem to handle well for a 
distributed revision control system and thought it could use some 
improvements.  To your point on "supersecret" .... when pushing to 
origin git could always be allowed to notify the developer of multi 
remotes before pushing with a "freak-out" flag set by Dev A  where git 
would then ask:
git: are you sure [y/(n)] y
git: are you sure your sure [y/(n)] Y
git :you seem certain, but you might not be aware of the true 
consequences of your actions... are you sure you are sure that your are 
sure [Y/(N)] Y
git: ..... Ok committing... it's your fault if this goes pear shaped 
sideways.

> So yeah maybe we want to have more power in the superprojects push operation
>
>      (in the superproject) $ git push --recurse-submodules \
>         --only-these-submodules=subA,subB \
>         --submodule-to=upstream-as-configered-in-super-project
Sure ... Yes... plus "Remotes" support.

  git push --recurse-submodules \
        --only-these-submodules=subA,subB \
        --submodule-to=upstream-as-configered-in-super-project

Allow:

  git push [remote] --recurse-submodules \
        --only-these-submodules=subA,subB \
        --submodule-to=upstream-as-configered-in-super-project


  git push indhouse --recurse-submodules \
        --only-these-submodules=subA,subB \
        --submodule-to=upstream-as-configered-in-super-project
and

  git push origin --recurse-submodules \
        --only-these-submodules=subA,subB \
        --submodule-to=upstream-as-configered-in-super-project

> This is a lot of words but for explaining that is ok?
>
> Thanks,
> Stefan
Yep got it thanks.

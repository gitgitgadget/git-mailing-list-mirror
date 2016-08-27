Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 925121F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 15:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754145AbcH0Pql (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 11:46:41 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35691 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753511AbcH0Pqk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 11:46:40 -0400
Received: by mail-wm0-f42.google.com with SMTP id f65so27198108wmi.0
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=TIdWGyOBL9O5nO7+Phrf20s0x5UAYpiaol9IW43ZgfM=;
        b=sFmcp0a8cB26f/FQTj2PaLkpZdwam8iag0rQoNfMu9tEwNqdJRSAYjIOWvlNnrtR+b
         SV8+E5IC160CwiNDZ69WRKHoUjPwZmUasv+4n9MnDaaHESb1zJJqJH1vcf4vtom4UBxI
         kYcE8PU5J4Xq8noiOO1ayeTAsMcHtICrK3/OSjYhxvJoIQYb05OEpGzU5hJVsKfCW+yI
         ccoYdN5UR8aliuSVWIVNEIoLAit+QxRaSind8zcV39nJ1DYEWc1qhj0k1Vm539AKrkeS
         1qXrkpwlm0pvbrROQ7olHP1Pu1ABzGfVHzvWDUgX+OzVQKXTnfaxyE9kTYa9WxP6AbwK
         Nyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=TIdWGyOBL9O5nO7+Phrf20s0x5UAYpiaol9IW43ZgfM=;
        b=moPNBRNPZzm99yoLF1imdBU/bbRhjnq8/SUcOsesNAlQzt8AA119BdIRWdim4GmToO
         GkATY493frhYx2HQQuvyC3AE3iQWZUfXVowgp1TkfTzjwkaml1Zu/rz42eRwmVqRy9ia
         AqFl3yLRbknOw/JxIi787568Mw0vXeZSkQOGopS24JR3wU32/v7Vzygyts59HVu+CCzC
         x4L9BlAaxXwTZDPssk4Xz/I+xDoSKYj4tibzL+fz4wvZ3psCYMUuL4686PCeOQ6z2C7R
         Cdy2OKrvMprAj22giTih1UQu1LHmbXrrOeRKjcLWp5M3B+6Y4Ggfk/ZuzRPOTp0Ncz6J
         eFEg==
X-Gm-Message-State: AE9vXwP/d1JglGzm0aqtvjkTyt7xGAHjH2//vinXMvNQ9NE25fCKtlgLoQT2LGUfb4MDvg==
X-Received: by 10.194.110.130 with SMTP id ia2mr7798875wjb.98.1472312798449;
        Sat, 27 Aug 2016 08:46:38 -0700 (PDT)
Received: from [192.168.1.26] (dav122.neoplus.adsl.tpnet.pl. [83.23.21.122])
        by smtp.googlemail.com with ESMTPSA id 3sm4363850wms.1.2016.08.27.08.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Aug 2016 08:46:37 -0700 (PDT)
Subject: Re: stable as subset of develop
To:     Brett Porter <porter@devrts.com>, git@vger.kernel.org
References: <57C0FB1D.9070206@devrts.com>
 <1b3990a1-f9a0-f48e-239f-095b17108d0a@gmail.com>
 <57C192FC.3060107@devrts.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <36dea6c2-44b8-ada2-e2a5-9ea7ea706c3c@gmail.com>
Date:   Sat, 27 Aug 2016 17:46:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <57C192FC.3060107@devrts.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 27.08.2016 o 15:17, Brett Porter pisze:
> On 08/27/2016 03:55 AM, Jakub Narębski wrote:
>> W dniu 27.08.2016 o 04:29, Brett Porter pisze:
>>>
>>> In a small group, develop is the branch where all fixes/additions/... from topic
>>> branches are merged rather dynamically. Thorough testing of commits
>>> may lag behind, but when we think one is a pretty good commit we want
>>> to identify it as (at least relatively) the latest stable. We could
>>> tag it, but we would like these stable commits to be a branch in the
>>> sense that each commit points back to a previous commit.
>>>
>>> Merging from a development branch commit to stable isn't quite what
>>> we want. It seems more like:
>>>
>>>    checkout the new good development commit
>>>    change HEAD to the head of the stable branch
>>>    git add --all
>>>    git commit
>>>    (maybe tag the new commit with the hash of the chosen development commit)

Actually this is almost exactly equivalent (except for the commit
message template) to squash merge (you lose history, that is resulting
commit have only one parent), using 'ours' merge strategy (or rather
'theirs' - which does not exist in Git).

The visualization of history would look like this:


  1<---2<----3<----4<----5<----6<----7         <--- unstable development branch
  |\              /     /
  | \--a<----b<--/     |                       <--- topic branch 1, merged in
  \                    /
   \---x<----y<----z<-/                        <--- topic branch 2, merged in


  [1]<-------------[4]<--------------[7]       <--- stable branch

where [1]^{tree} === 1^{tree}, that is the state of repository is the same


Note: I don't see how this would be better from just having a stable
branch to be a subset of development branch, that is for example:

                   /------------------------------- stable branch
                   |
                   V
  1<---2<----3<----4<----5<----6<----7         <--- unstable development branch
  |\              /     /
  | \--a<----b<--/     |                       <--- topic branch 1, merged in
  \                    /
   \---x<----y<----z<-/                        <--- topic branch 2, merged in


> Oops - used tag in a generic sense when discussing git -- not helpful.
> Really - would put the hash of the development commit into the log message for
> the stable commit.

Well, this does not change my reasoning in any way.

>>
>> If you are really using topic branches, a better workflow would be
>> to make use of them.  That is, do the development of new features
>> on topic branches, test them in relative isolation, and when deemed
>> ready merge them into development branch, for more testing (including
>> integration testing).
>>
>> Then, those topic branches that are considered stable are merged
>> into stable branch ("trunk").  You can think of it as picking
>> features to have in stable.
> 
> Ok. There are 2 things at play.... The repository contains code for
> an embedded system with several subsystems (separate executables on
> separate processors). We will be trying to keep testing schemes up to
> date with respect to the progress on the code -- but (beyond
> unit/module tests), the scene will change over time; and, users may
> not be able to run much form their local copies. 

If there is problem with developers running tests (or at least running
them comprehensively, that is for all architectures / subsystems), why
not set up a continuous integration / continuous delivery server, that
would run all the tests after push?

> Second, only 2 of us
> have used git before (and, while trying to get up to speed - I am a
> ways from git guru-dom yet), while everyone else has been using
> visual sourcesafe for many years.

I have not used Visual SourceSafe myself (though I tried to use CVS
in times before Git), but I have heard horror stories about it...

As to mastering Git - I recommend "Pro Git" (free on-line book),
"Git for Teams" (though more about teams than about Git), or my
"Mastering Git" book.

For beginners, there is "Version Control By Example" (free online
version), or "Git: Version Control for Everyone".

> 
> I want others to merge their work into development sooner rather than
> later to minimize their and my problem of untangling conflicts (or -
> you rebased while you were sharing work with Jill and...). And,
> testing on their work may be limited before they push to our main
> repository and some integration can be done.

What the setup looks like?  Is there a central repository where everyone
publish their changes, or is there one person responsible for integrating
changes from each developer public repository?

> 
> I really want to create a linked list of the development branch
> commits that are of interest (their working sets - not the commit
> objects themselves), and using the commit object's pointer to its
> predecessor seems like it could just do the job. (it wouldn't be the
> place to go to for history / useful log entries)

That looks like abuse of the DAG of revisions...

Anyway, even if you don't have the access to individual topic
branches, and everybody uses single central repository, merging their
changes into development branch, you can still select a subset
of development-merged topic branches to merge into stable branch.

I'll try to explain it on pictures (note: ASCII-art requires
fixed width font, and preserving spaces).

Let's assume that there are two topic branches merged into
development branch (and there are no commits made directly on
the development branch):


  1<---------------2<----3        <--- unstable development branch
  |\              /     /
  | \--a<----b<--/     |          <--- topic branch 1, merged in
  \                    /
   \---x<----y<----z<-/           <--- topic branch 2, merged in

Now, you can be conservative, and say that only topic 1 is ready
to be in the stable branch

  1<---------------2              <--- stable branch
   \              /     
    \--a<----b<--/                <--- topic branch 1, merged in

Here 'stable' is subset of 'development'.

It might turn out that topic branch 1 was prematurely merged, and
is not yet ready for stable.  You could revert a merge (though
troubles lies ahead here), but you can simply select only topic
branch 2 for stable:

  1<---------------------β        <--- stable branch
  |                     /
  |                    |
  \                    /
   \---x<----y<----z<-/           <--- topic branch 2, merged in

This is simply not possible in your approach.

That is what git.git does (see e.g. "A note from the maintainer"
https://git-blame.blogspot.com/p/a-note-from-maintainer.html).

>>> Will that work (one thing beyond my current understanding is if there
>>> are index complications)? Other ideas?
>>
>> That looks a bit like reimplementation of cherry-picking.
> 
> Maybe I've misunderstood cherry-picking, but I've thought it different from the
> list view that I've been thinking could help us (with merges and multiple
> commits).

I'm sorry, it was my mistake.  Cherry-picking is different: it is used
to "copy" changes as a commit (copy a commit in a sense of copying changes
and the commit message).  Though git-cherry-pick can add a hash of an
original commit to the commit message of a commit created by cherry-pick.

>> Also, I think you would loose the ability to run git-bisect to find
>> bad commits.
> 
> Hmmm - I'm imagining a rather sparse stable, with perhaps time-consuming
> integration testing.

That's the problem.  Sparse "stable" means that if you do git-bisect on
stable, you would land on large commit, with huge changes and probably
not descriptive commit message.  I other words: not that useful.
 
>>
>>> This could help with applying successively more intense testing over
>>> time and chase down where problems arose.
>>
>> Reiterationg: if you are using topic branches, use topic-branch workflow.

Regards,
-- 
Jakub Narębski


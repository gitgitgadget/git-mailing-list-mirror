Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC99B2027C
	for <e@80x24.org>; Thu, 13 Jul 2017 22:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbdGMWja (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 18:39:30 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36752 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGMWj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 18:39:29 -0400
Received: by mail-wr0-f196.google.com with SMTP id 77so10387328wrb.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 15:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xojAaO984d18DNnmJsYhXA+oYhNCqgT9kXCcnT78tKw=;
        b=CPQm25T1bUqG+bLGhvlMAz8FjZn3QwhcNHeG8Q4tKyNKTlGVnOi0Rh97vdZYpmSbfg
         swHIzZXM3q4cgkPViZGgfJ1piaWvSz4H+RtswOU5ttS1O8ez0Pc9ez1/h1aDv/F4K50s
         +ojLembsR2+xEhFsH5P4z3dN9yNAC3VYOKvW5dhNVRa08vlIaKsKMCXcagUvSDfcLB8z
         4NTv7NJTHrHMdZwhzXPfToj2pYy34mQlYxF7Gg38RKikJuA2kATaZZunk/hF5UB7b8c7
         TInUTPB14H/flDMOkmyPHn9OXMHb91tj67Dyas8RChWJbr8lleFgvmDcNtYKFgenEQzn
         eHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xojAaO984d18DNnmJsYhXA+oYhNCqgT9kXCcnT78tKw=;
        b=Mzj3seKNrG9wcLctYgfdILlSYu3v9tHwp1HivrGe/o85q6n6r7Njty1M/XqHe6WU52
         L2lJbEKiUjHHPE4CLmt1Int//4N1yre9pShOuXWxCr0bnOYt2lAbYmy1DLrGpDRdktde
         X3wEnJEKA3F0bfjjMqo9Roou2A3qbDhwSz40LaqVEA+M8MVR25hxY1sYjQIDIzBpHoMh
         2PKJtilxqfbtRg4GSKxTmnVyhr5Vv/CPHfk0xa5xaKCC3rC8joND3T84grPaNQr2PsLJ
         Bf5ShfAuyD72iAtwnUR/tA61x/F2W5vK6TPOipMICiXfvxG50hhbo1uZZtk3y2HFUusi
         DOWw==
X-Gm-Message-State: AIVw113fiJpkOmiet8adcxA3oCNqEUc0R/YDaZ4yDQKi8P91gYzUQGIj
        y4GUGvtelXJNkb3agn8rNg==
X-Received: by 10.223.147.132 with SMTP id 4mr2759850wrp.107.1499985568105;
        Thu, 13 Jul 2017 15:39:28 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-63-71.dynamic.sbb.rs. [24.135.63.71])
        by smtp.gmail.com with ESMTPSA id 82sm749886wmt.17.2017.07.13.15.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jul 2017 15:39:27 -0700 (PDT)
Subject: Re: "groups of files" in Git?
To:     Junio C Hamano <gitster@pobox.com>,
        Nikolay Shustov <nikolay.shustov@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
 <CAGZ79kZaf7=uwCPJoPoDiAO9QS21bchaKZvDzWJi=ewPZw9PXQ@mail.gmail.com>
 <xmqqiniwxkmj.fsf@gitster.mtv.corp.google.com>
 <CAEcERAxJRnB55Ardhs7LDW8M8EG-y+YE-He8hiiQv3wDqtVD3g@mail.gmail.com>
 <xmqqzic8t4oi.fsf@gitster.mtv.corp.google.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <27a3c650-5843-d446-1f59-64fabe5434a3@gmail.com>
Date:   Fri, 14 Jul 2017 00:39:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqzic8t4oi.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/07/2017 23:20, Junio C Hamano wrote:
> Nikolay Shustov <nikolay.shustov@gmail.com> writes:
>> My question was about how to robustly handle "multiple pending
>> commits" which in Perforce are represented by concept of pending
>> changelists.
> 
> And in Git, they are represented by concept of commits that are not
> yet pushed out to the public repository to become the final history
> carved in stone.

If I may, I don`t think "multiple pending commits" is the issue here 
(as that is indeed what a private branch is), but more something like 
"multiple branches pending/live merge branch", or something.

To illustrate, let`s say this is our starting position:

(1)      o---o---o (featureA)
        /         \
    ---o---o---o---M (master, HEAD)
        \         /
         o---o---o (featureB)


We`re currently on commit "M", being a merge commit between our 
"master" and two feature branches.

Now, what seems lacking, while still possible through a series of 
steps, is an easy (single step) way to modify current state and 
commit the change to the _feature branch_, while still being on the 
"master" branch, still having everything merged in.

So after I make a "featureA" related change while on "M", to be able 
to issue a single command, for example:
 
    $ git commit --branch=featureA

... or:
 
    $ git commit -b featureA 
 
..., where "featureA" would need to be one of the parents of the 
current commit we are at (commit "M", in our case), and get a 
situation like this:

(2)      o---o---o---A (featureA)
        /             \
    ---o---o---o-------M' (master, HEAD)
        \             /
         o---o---o---/ (featureB)


Here, "A" is a new commit/change I`ve just made (while still being on 
the "master" branch), and it is automatically commited to related 
"featureA" branch, with merge commit "M" now recreated into "M'" to 
hold the new "featureA" commit "A" as well.

I guess it would be a kind of alias to doing:

    $ git checkout featureA
    $ git add ...
    $ git commit
    $ git checkout master
    $ git reset --hard HEAD^
    $ git merge featureA featureB

... or something, where last merge step would need to remember 
previous merge commit "M" parent branches and merge them again to 
produce an updated "M'" merge commit.

In the same manner, it should be possible to drop a commit from the 
feature branch in a single step, for example returning to the state 
as shown in (1), or even "port" it from one branch to the other, like
this (without a need for it to be the last commit, even):

(3)      o---o---o---\ (featureA)
        /             \
    ---o---o---o-------M' (master, HEAD)
        \             /
         o---o---A'--o (featureB)


Something like "rebase on steroids", lol, keeping the HEAD where it 
is, and its merge commit beneath updated.

This indeed seems similar to Mercurial`s patch "queues", except being 
much better as everything is still version controlled at all times, 
no additional tools needed to version control the patches (unless 
that`s already been addressed in Mercurial as well, dunno).
 
And it still seems to be following Git`s "multiple commits per 
feature, single feature per branch" spirit, just allowing for 
easier/faster branch integration testing.

p.s. Even if my short sample might be flawed in one way or the other, 
it should show the essence of the functionality we`re discussing 
here, I think.

Regards,
Buga

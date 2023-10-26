Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB08646
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 03:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+oSIHdq"
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E860A3
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 20:23:46 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d998b5f3cso2967606d6.2
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 20:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698290625; x=1698895425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7bocLMPxe2ppOpVcb0C/FT8DZK2ZdPllLeBwdq2on2E=;
        b=Q+oSIHdqTGKtEziTd7RI+aONnmeSSoGy1QVJ8ZdOuS19VPZxhY48swf3OtUum9mgc5
         6e93Y1CuTLpLrr3Sr7dXluf5nMV/d4J18p5rBMVwRF1pYuRcRKi+v1vJrkUTMPrUv2OO
         3kF5//G7ua7rC8jsfe8mVDdcj89/lQhqWhua2/ZZh5GKd3JXQq94LUDm8ZqdXNb9tfHd
         NJszXVmofv/2ZakRDgg1P016vjqm+q4KZROafUPPWbvEvLYMTm6GZgomm3BfudsIMdlh
         TGUrzHQbj8kuwwdJMAm+N8rCg4SlzdkVGT3TBKWtwCW67pqV3JHxZUl5poWtmyCBhJ6r
         8oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698290625; x=1698895425;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bocLMPxe2ppOpVcb0C/FT8DZK2ZdPllLeBwdq2on2E=;
        b=kwFOGdfVgEKT0U+LlnM0pb1OxukxaR61tANCWaWQyRx8rygb/8PltMQnSWwMfQYNza
         gAwoM3+3D4yiioIU8U4QTKtkSHJ7ULfXDJpVUU1kadcCz/tDRsq+eKKstYsRDvI1DgqT
         joqGc+XG29riOYRyTOeMCp7VAo9E0mFe4/4om1RvjM1B4xvzzNKZ7z8QiG4uJrmqDJGT
         0PmPw7PMOkL7A2TxJb9LVLbGQbP5qpxmk2pIf1+0FmKVrFPIuG7w18eh/Dq5hsL9ouBM
         eOpZwOOcRxGL4AobLZamNDY7l8xIHznYIc69Ieympcvo0jXanSnSFCIN+9ajSZ6ncwRt
         OxGg==
X-Gm-Message-State: AOJu0YwYqoV3PP1hvGJhOiNgDq+/bHRCB7/yiCJv0VjUWERPlqkfjW0f
	PGYSvqdhYKONPTmPhKUQK89XszYEFnPAnasJ
X-Google-Smtp-Source: AGHT+IHaR+gfu7u4cQri+0ZF614TqQQJF8DP8DRK4eI3hjHoKf5CwfS3C7is8hj8+iK2TRb+NBqgQQ==
X-Received: by 2002:a05:6214:248f:b0:66d:33c1:3750 with SMTP id gi15-20020a056214248f00b0066d33c13750mr19935207qvb.49.1698290625009;
        Wed, 25 Oct 2023 20:23:45 -0700 (PDT)
Received: from ?IPV6:2605:2a00:8001:dead::3ac? ([2605:2a00:8001:dead::3ac])
        by smtp.gmail.com with ESMTPSA id l1-20020ad44241000000b006516780a0a5sm4893518qvq.117.2023.10.25.20.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 20:23:44 -0700 (PDT)
Message-ID: <7e307505-3536-4671-a302-3ff13649617d@gmail.com>
Date: Wed, 25 Oct 2023 23:23:42 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why sometimes branch merging is associated with this commit:
 Merge remote-tracking branch 'remotes/p4/HEAD'
Content-Language: en-US
To: Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
References: <dd4befe1-dea7-b27d-720d-9f1616b129ee@tsoft.com>
From: Thomas Guyot <tguyot@gmail.com>
Autocrypt: addr=tguyot@gmail.com; keydata=
 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
In-Reply-To: <dd4befe1-dea7-b27d-720d-9f1616b129ee@tsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Yuri,

On 2023-10-20 15:46, Yuri wrote:
> I use git-p4 to use the perforce repository through git.
>
>
> There are 3 branches:
>
> * master
>     remotes/p4/HEAD -> p4/master
>     remotes/p4/master
>
> git-p4 syncs remotes/p4/HEAD with the perforce repository.
>
> Then the user (me) needs to merge remotes/p4/HEAD into master.
>
> Initially such merge doesn't cause "Merge remote-tracking branch
> 'remotes/p4/HEAD'" commits.
>
> But then, after several cycles of submit/sync something happens, and git
> forces me to commit with the "Merge remote-tracking branch
> 'remotes/p4/HEAD'" comment.
>
>
> What makes the merge from remotes/p4/HEAD into master to require "Merge
> remote-tracking branch 'remotes/p4/HEAD'"?

I believe what is happening is once other developers merge code in the 
same branch your master branch ends up like a topic branch that never 
merge back to the remote tracking branch.

I've worked a lot more with git-svn but both behaves somewhat similarly 
AFAIK - when you "send" your commit upstream (I'm using "send" as I 
don't recall the exact terminology for git-p4) what really happen is 
like if your commit was cherry-picked on top of the remote branch - P4 
tracks commits linearly and has an incompatible concept of merges.

When you sync later, it will get both your commits and other developer's 
commit, but because they don't have the same history anymore git has no 
choice but to merge the branches (this doesn't happen initially if 
you're the only committer as your branch remain sync with the remote).

> What does this mean?
>
> What is changed in remotes/p4/HEAD or master that later requires this?
>
> How to eliminate the need for "Merge remote-tracking branch
> 'remotes/p4/HEAD'"?
>

You probably don't "need" to eliminate this, you can just keep creating 
new commits on top and pushing them. The end result will be the same for 
other p4 users.

If you still want to re-sync with upstream all you have to do is to 
rebase on top of the remote tracking branch. You'll end up with the same 
work tree but your history will get "linearized" based on the commits in p4.
Let's take for example this branch:

A---B---C [master, remotes/p4/HEAD]

Now imagine you and another developer both work on the repo separately 
(let's assume different files, no possible conflicts) and the other 
developer commits before you in p4, you end up with:

A---B---C---E [remotes/p4/HEAD]
          \
`-D [master]

When you send *your* change, D, on the p4 repo, it cannot merge like git 
does. It will instead apply your commit on top of E - we'll call your 
commit D' as it's now a different commit hash, although it's the same 
change:

A---B---C---E---D' [remotes/p4/HEAD]
          \
           `-D [master]

Now if you sync with p4, git can't fast-forward anymore because D and D' 
are different commits (and don't even have the same parent!) therefore 
it will merge (F) with the remote tracking branch:

A---B---C---E---D' [remotes/p4/HEAD]
          \       \
           `-D-----+-F [master]

F and D' are identical, they have the same work tree contents, but have 
a different commit hash (implied by the difference in parents). If you 
rebase master to remotes/p4/HEAD git will discard the duplicate D commit 
from your branch and restore it at the tip of remotes/p4/HEAD. If you 
has any new commit after F, those would be applied after D', for ex:

A---B---C---E---D' [remotes/p4/HEAD]
          \       \
           `-D-----+-F---G [master]

Rebases to:

A---B---C---E---D' [remotes/p4/HEAD]
                  \
                   `-G' [master]


Personally I would always rebase with the remote repo, and with git-svn 
I was actually doing that systematically before pushing anything (I 
think I had no choice anyway, or maybe I just didn't want any local 
merge commits...) In any case you should be able to rebase with the p4 
remote tracking branch before or after committing into p4 and that will 
keep your history in line with p4's history.

Regards,

-
Thomas

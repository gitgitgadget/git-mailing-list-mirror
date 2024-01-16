Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2C91B7F3
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadavpratyush.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadavpratyush.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadavpratyush.com header.i=@yadavpratyush.com header.b="J/KL2DIC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TDEaTek1"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id BB2DF5C0144;
	Tue, 16 Jan 2024 06:33:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 16 Jan 2024 06:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	yadavpratyush.com; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1705404791;
	 x=1705491191; bh=EuXbWs8Ughbaay5BaiADCahaSUrqcCUYTkcEoZgi3SA=; b=
	J/KL2DICug2mYWdZe//vgXUDM+fr8B4ajP6o9pIyogpB1lKCjcU6MCx3AA1umFz7
	7A07jVtWFd3SJH3HTqkxSK2kiSVE92xjYfetz55ae0RUzFF+chNGARpvsXU+4HgB
	DYT4eRvbwwUHYEQihUSNXIc+XSUsC2AmbRzX0MS56QtlqXaomhQP7jUOqf1A5mPZ
	BAKUwQA+vimQ7TqQLD6ENti2tOtj5JURWnf+tb6nhViEtDPQUp7rMoNPByK2koZv
	l3N+U6xWnvh3sSoIwEqpo1K1pWpSQAf1YCggfvD4DvzwIBbWoiuQsJ/It+BzGo4d
	rstWyA5BqbGr+gRrfkcl1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705404791; x=1705491191; bh=EuXbWs8Ughbaay5BaiADCahaSUrq
	cCUYTkcEoZgi3SA=; b=TDEaTek1BNTCIg1qftVZqonOuhDnhQ0iJBQuPgf48VwR
	av85uE/f1V+9SXZaPXoRpozpNgKeJqf3Xpe+kfmCCj9SxA6GSKSe1aex221WzwOl
	HIz9hrRzSxql6fszQ8at2NCkQnt2AOC/Xuf6tEK0mwZJdt4EOeeigOB2wZXhhhiv
	l5XpsFvIbsliilTENoiCouVW+DEwZUWJ9Rc82vn9UQzI2PgLHb0WjloT/dYwLmNe
	NtY+p8DveiVoY6NXzKFvGld1tFC0thuI5haD22f4bHkINJPop1kQU63fVfkzNEUE
	OThk1vrluTR5xujaPH+gIfTR9vzIIyyvN4hX9IteKQ==
X-ME-Sender: <xms:d2mmZcipeX1JRLTEWyNhdodpzjoNE16glBlDIxkqNr8g_8tVQBrIHw>
    <xme:d2mmZVAWrffiq3i2nC1OMgfcNC9X5HqE7B46YLHCWL_BlwNfulL6b4TnOM20iA5hi
    cQrJrHMsx0Lg_ctDDU>
X-ME-Received: <xmr:d2mmZUG43t81eiNUY7rmZP7tKiWSOlAATs5_ntKVveoWuV7JorxR_wehheBdIr11uQDSZXbGaM0YCKyQ0T72crXMVMy2w7akQSeQimJy_0TCfAoB15l7apObFXre07WxVL81QaTW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejfedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheprfhrrght
    hihushhhucgjrggurghvuceomhgvseihrggurghvphhrrghthihushhhrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeduleejledtudejhefhvdeguedukeetgfdvueetveeiuedvffej
    tdfhjeejheefueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvseihrggurghvphhrrght
    hihushhhrdgtohhm
X-ME-Proxy: <xmx:d2mmZdRFLuoOQ1J3wnN9qznTZrQrH6_UqeEfufuAszf8zEQjhDFgAg>
    <xmx:d2mmZZz3I7xbbcp6y6cHZyF8laaynt7bVOrEkV_OL8thIYjdspB5dw>
    <xmx:d2mmZb4xfXjb-oXdr0ij9MGo-tI5pfE4PAPCUgickVwA_A5lWOR8Mw>
    <xmx:d2mmZaq3UMwR6mdB2QF5yX13EbYr9Rnq7JyU5KQTuBKCjr3ySFChQA>
Feedback-ID: i93f149c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jan 2024 06:33:10 -0500 (EST)
From: Pratyush Yadav <me@yadavpratyush.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Pratyush Yadav <me@yadavpratyush.com>,  git@vger.kernel.org
Subject: Re: Strange behaviour when pushing a commit object to remote's
 refs/HEAD
In-Reply-To: <CAOLa=ZS8YBhzaYx=9016KxErsMsazsF09rcuPs=-WpEGjV+ruw@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 16 Jan 2024 04:54:35 -0500")
References: <mafs0fryypg82.fsf@yadavpratyush.com>
	<CAOLa=ZS8YBhzaYx=9016KxErsMsazsF09rcuPs=-WpEGjV+ruw@mail.gmail.com>
Date: Tue, 16 Jan 2024 12:33:09 +0100
Message-ID: <mafs0a5p5pl6y.fsf@yadavpratyush.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 16 2024, Karthik Nayak wrote:

> Pratyush Yadav <me@yadavpratyush.com> writes:
>
>> Hi,
>>
>
> Hello,
>
>> I ran into a strange Magit bug, where when I ran magit-show-refs on a
>> particular repo it threw an error. The details of the Magit bug are not
>> very interesting, but when attempting to reproduce it, I also saw git
>> misbehaving for such repos.
>>
>> The strange behaviour happens when you push a commit object to remote's
>> refs/HEAD instead of pushing a symbolic ref. Such a repository can be
>> found at https://github.com/prati0100/magit-reproducer. I roughly used
>> the below steps to create such a repo:
>>
>>     $ git init
>>     $ echo 1 > foo && git add foo && git commit
>>     $ echo 2 > bar && git add bar && git commit
>>     $ git push
>>     $ git checkout 79264c3
>>     $ echo 2.1 > bar && git add bar && git commit
>>     $ git push origin 707a3d5:refs/heads/HEAD
>>
>
> Just to note here that pushing to "refs/heads/HEAD" is not actually
> updating the remote repositories $GIT_DIR/HEAD file, rather it creates a
> new reference $GIT_DIR/refs/heads/HEAD.

Yes, that is what I would also expect. I checked one of the Git servers
we have and this is exactly what happens. $GIT_DIR/HEAD is a symref
pointing to refs/heads/main and $GIT_DIR/refs/heads/HEAD points to the
commit. But behaviour from client side is not consistent.

>
> With this understanding you'll see that this is not a bug, because the
> remote HEAD was never updated, but only a new branch called HEAD was
> created [0].

GitHub thinks so but try opening the branch. It won't show you the
commit (707a3d5, "2.1") but instead shows you 86e1c97 ("2"). So
something is wrong _at least_ with Github.

>
>> Now with such a repo, if you do `git log --all --oneline` it would look
>> something like:
>>
>>     707a3d5 (origin/HEAD) 2.1
>>     86e1c97 (HEAD -> main, origin/main) 2
>>     79264c3 1
>>
>> And running `git for-each-ref --format='%(symref:short),%(refname:short),%(refname),%(subject)' refs/remotes/origin` gives:
>>
>>     ,origin,refs/remotes/origin/HEAD,2.1
>>     ,origin/main,refs/remotes/origin/main,2
>>
>> All well and good so far. Now delete the repo and attempt to clone it.
>> This time `git log --all --oneline` gives:
>>
>>     86e1c97 (HEAD -> main, origin/main, origin/HEAD) 2
>>     79264c3 1
>>
>
> This is expected since you cloned the repository and you got the default
> branch 'main'.

No.

First, if I clone a repo with multiple branches (say
https://github.com/prati0100/git-gui) I get _all_ the remote branches.
Yet here I clearly don't get the so called "HEAD" branch. This is not
expected behaviour.

Second, git really does misunderstand refs/remotes/origin/HEAD. For
example, when running git for-each-ref command with the clone method, I
get:

    origin/main,origin,refs/remotes/origin/HEAD,2

So it clearly thinks refs/remotes/origin/HEAD is at 86e1c97 ("2"). Or,
to be more specific, it thinks the ref points to origin/main which is at
86e1c97 ("2"). But we set it at (707a3d5, "2.1"). So it tells me the
wrong thing. Now if I do the git remote add && git remote update method,
git for-each-ref says:

    ,origin,refs/remotes/origin/HEAD,2.1

So now it thinks refs/remotes/origin/HEAD points at (707a3d5, "2.1"). I
do not see it as expected behaviour.

We can also see this when inspecting the contents of
.git/refs/remotes/origin/HEAD. With clone it says:

    ref: refs/remotes/origin/main

With git remote add && git remote update it says:

    707a3d587c61c089710e3924eb63a51763b5a4c8

The same ref points to different places based on how you pull the repo.

Looking deeper, if you clone a repo that does not have a branch called
"HEAD" (like git-gui), git creates a file in
.git/refs/remotes/origin/HEAD that says:

    ref: refs/remotes/origin/master

So it certainly seems to use refs/remotes/origin/HEAD to point to the
remote's HEAD, and not as a regular branch.

I find this to be inconsistent behaviour on git's part and do not think
it is (or should be) expected behaviour.

>
>> And running `git for-each-ref --format='%(symref:short),%(refname:short),%(refname),%(subject)' refs/remotes/origin` gives:
>>
>>     origin/main,origin,refs/remotes/origin/HEAD,2
>>     ,origin/main,refs/remotes/origin/main,2
>>
>> So suddenly the remote's HEAD becomes origin/main (symbolic ref) and the
>> commit (707a3d5, "2.1") is nowhere to be found. It neither shows up in
>> `git rev-list --all` nor in `git log --all`. The files and trees
>> associated with it also do not show up in `git rev-list --all --object`.
>
>
> Because rev-list's `--all`, iterates over all refs. Since you only
> cloned, the HEAD branch is not pulled.

Why not? When you clone all branches should get pulled.

>
> Everything else is a consequence of the subtle but important difference
> between updating $GIT_DIR/HEAD vs creating $GIT_DIR/refs/heads/HEAD.
>
> [0]: https://github.com/prati0100/magit-reproducer/branches/all

-- 
Regards,
Pratyush Yadav

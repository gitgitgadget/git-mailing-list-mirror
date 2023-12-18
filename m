Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F74989E
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeaZMP2k"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d1bcd93b0so7200785e9.0
        for <git@vger.kernel.org>; Mon, 18 Dec 2023 08:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702917774; x=1703522574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mZaYA5Z6PhkxEgefrk0meimAMkKP/awbfhLuYuiGJlM=;
        b=XeaZMP2kzkdFQ4WoUitdLbQrO7eWtPNUFeqdInd6nXDmJbZukc4ufm+9BpPTyQQ+If
         6WRcVlcf4AtaLJLj38gF/Lhshn/PKg7qca4KuX5O1d2jwC3RJYDJznPIZOWSWEZZIAB8
         NdaGVEeMuI573NNxxPUIqoBRN4NpQ59e1oZT/rqV83Z8Hj1uDLivIFCDYAr1qj738xoD
         20gqQ7l1+b7Kwgn2vKOCJcqcccl4AcqAour94Ej96ptgse7Cqu/GVv/6KtLUDU+6NJKG
         OUi4MftgexPiyUCvk+WgdmX6JzWG/GZnA4dlvKKvZSZGAc5A/CmEbmO5znA+KWhzSci+
         dGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917774; x=1703522574;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZaYA5Z6PhkxEgefrk0meimAMkKP/awbfhLuYuiGJlM=;
        b=XQdwtFiRCsd4aGACjSJJ9TRi3E6leWCXiZXebmbr0g5Q0ew3AVYe1N8dnylDlBaucK
         7XOgTlBD/UEFyVpVrzLMotyL3X03THqIldJSWHoyH09dfXiVNcx/USPupy0/UYzR9zxu
         5ASS6de0PfuK0QEc+aQ4LOgvE8u+V5+weyRKJYm+uZJJwLgqA4FogfGAJ7MjVq8bIYXg
         0x/ZsatvWnRUzQcasni4GKBFZeJXE59R/eGYOJPi6AXzpnj/OaLqMkeZdcoLk4GORZ3P
         QmxXEtVviHnISQUX+j2hyflxdBeWLiiMgADEEDgsnDpRokjZAEjRFZk1YLcxXDYeLEOe
         AWpA==
X-Gm-Message-State: AOJu0Yy+ZomDCxLkbMlUhwHgqMDVbcpsfwzavGXwAuCwZWF9NqfFTn7J
	Xn69e1kVvjzIjUx8lF4oQpIehXCBhCI=
X-Google-Smtp-Source: AGHT+IHXMBRCPhq9d9sfzdw+ot3dvdudHMeu500ED3WJ6AjIGsLioLq7DSiro0ZU6b8+nJAj7q4kiw==
X-Received: by 2002:a05:600c:4f05:b0:40c:3820:efe6 with SMTP id l5-20020a05600c4f0500b0040c3820efe6mr10209773wmq.107.1702917773796;
        Mon, 18 Dec 2023 08:42:53 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b0040c43be2e52sm35333425wmb.40.2023.12.18.08.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 08:42:53 -0800 (PST)
Message-ID: <42ff6b11-f991-4a6d-ad68-ca8c5a3cd735@gmail.com>
Date: Mon, 18 Dec 2023 16:42:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/1] revert/cherry-pick: add --show-current-patch option
Content-Language: en-US
To: Michael Lohmann <mial.lohmann@gmail.com>, git@vger.kernel.org
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,
 Elijah Newren <newren@gmail.com>
References: <20231218121048.68290-1-mi.al.lohmann@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20231218121048.68290-1-mi.al.lohmann@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michael

On 18/12/2023 12:10, Michael Lohmann wrote:
> Hi,
> I am a lead developer of a small team and quite often I have to
> cherry-pick commits (and sometimes also revert them). When
> cherry-picking multiple commits at once and there is a merge conflict it
> sometimes can be hard to understand what the current patch is trying to
> do in order to resolve the conflict properly. With `rebase` there is
> `--show-current-patch` and since that is quite helpful I would suggest
> to also add this flag also to `cherry-pick` and `revert`.

Thanks for bringing this up I agree it can be very helpful to look at 
the original commit when resolving cherry-pick and revert conflicts. I'm 
in two minds about this change though - I wonder if it'd be better to 
improve the documentation for CHERRY_PICK_HEAD and REVERT_HEAD and tell 
users to run "git show CHERRY_PICK_HEAD" instead. I think the main 
reason we have a "--show-current-patch" option for "rebase" is that 
there are two different implementations of that command and the 
patched-based one of them does not support REBASE_HEAD. That reasoning 
does not apply to "cherry-pick" and "revert" and "--show-current-patch" 
suggests a patch-based implementation which is also not the case for 
these commands.

Best Wishes

Phillip

> Since this is my first contribution to git I am not exactly sure where
> the best place for this functionality is. From my initial understanding
> there are two places where to put the actual invocation of the `show`:
> - Duplicate the code (with the needed adaptations) of builtin/rebase.c
>    in builtin/revert.c
> - Create a central function that shows the respective `*_HEAD` depending
>    on the current `action`.
> 
> In this first draft I went with the second option, since I felt that it
> reduces code duplication and the sequencer already has the action enum
> with exactly those three cases. On the other hand I don’t really have a
> good understanding of the role that this `sequencer` should play and if
> this adds additional coupling that is unwanted. My current impression
> is, that this would be the right place, since this looks to be the core
> of the commands where a user can apply a sequence of commits and in my
> opinion even if additional actions would be added, they could also fail
> and so it would be good to add the `--show-current-patch` option to that
> one as well.
> 
> Side note: my only C(++) experience was ~10 years ago and only for a
> single university course, so my perspective is much more from a general
> architecture point of view than based on any C experience, let alone in
> this code base and so I would be very grateful for criticism!
> 
> 
> Side note: The check for the `REBASE_HEAD` would not be necessary, since
> that is already taken care of in the builtin/rebase.c before.
> Nevertheless I opted for this check, because I would much rather require
> the same preconditions no matter from where I call this function. The
> whole argument parsing / option struct are very different between rebase
> and revert. Maybe it would make sense to align them a bit further?
> Initial observations: `rebase_options->type` is functionally similar to
> `replay_opts->action` (as in "what general action am I performing? -
> interactive rebase / cherry-pick / revert / ...") whereas
> `rebase_options->action` is not part of the `replay_opts` struct at all.
> Instead the role is taken over in builtin/revert.c by `int cmd = 0;`.
> I am preparing a patch converting this to an enum, so that there are
> no random chars that have to be kept in sync manually in different
> places, or is that a design decision?
> 
> I looked through the mailing list archive and did not find anything
> related on this topic. The only slightly related thread I could find was
> in [1] by Elijah Newren and that one was talking about a separate
> possible feature and how to get certain information if CHERRY_PICK_HEAD
> and REVERT_HEAD were to be replaced by a different construct. I hope I
> did not miss something...
> 
> Cheers
> Michael
> 
> [1]:
> https://lore.kernel.org/git/CABPp-BGd-W8T7EsvKYyjdi3=mfSTJ8zM-uzVsFnh1AWyV2wEzQ@mail.gmail.com
> 
> Michael Lohmann (1):
>    revert/cherry-pick: add --show-current-patch option
> 
>   Documentation/git-cherry-pick.txt      |  2 +-
>   Documentation/git-revert.txt           |  2 +-
>   Documentation/sequencer.txt            |  5 +++++
>   builtin/rebase.c                       |  7 ++----
>   builtin/revert.c                       |  9 ++++++--
>   contrib/completion/git-completion.bash |  2 +-
>   sequencer.c                            | 24 +++++++++++++++++++++
>   sequencer.h                            |  2 ++
>   t/t3507-cherry-pick-conflict.sh        | 30 ++++++++++++++++++++++++++
>   9 files changed, 73 insertions(+), 10 deletions(-)
> 

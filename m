Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F475788A
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khVo36TB"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3375a236525so4856753f8f.0
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 03:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705057284; x=1705662084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MvpGJ8SB3hZ47b+qTRJ9MTJ1XY29GSPXRaemeO2Eovg=;
        b=khVo36TBe0q4cp7BGwufQDLV+vsfTMs7tV7aUAKZww2D3lfw6i3RnV2Ru4FXcPxBH1
         WHNL9ZU4/QZuQL11Z49IpxUArDq6/gSllaqf8wyNger8BOyDpYY629QEQ5KimLv5+g0R
         VWm/K4DxzR9mEJRJNJrdPYG7L9dMRx1aJHETSGZXoYHWjOzmcFY404k9YCOWhUfy6ySh
         5bVGLsRnuPHuEFBbetywSX0mFDTuI8HMihpApzRAgpqGJFUP3HG8WA1+U8mDDDnVNtbc
         ik7wBOQQhVUjvP6NU5367Nch1hWq7VI7HYBDI7NEM1BVx1OQvqAviAJvDqsFGd9wPztK
         j1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705057284; x=1705662084;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MvpGJ8SB3hZ47b+qTRJ9MTJ1XY29GSPXRaemeO2Eovg=;
        b=vs/cNchw5hvm/wQi5PpnaXb4J+3k9c468rRQhHQAnjHx9WG/vp3goP5SxThHIkziLU
         J/MglH1XvS2h5dCaFUSeghgDKQTntm+krxZKYt5wyw8KQxEnVGIUBSVVX0/vyuTgrvRg
         vRzcoL4NPWCKUzcUpor0Xfxw7lRGanoyHSkuy67q7VirAK42L5C++fE/h4NlW8DOjXz2
         WpdJpJqQYaEJbIYzOXjHe3JB0ZK2SHqFAsZ7wRfmxK0nInmCAtGRY1FZPiJFjx9dnVPU
         w1kcSxPXj+rD8wdN6mqRJsCoL+y13XinjfeaEoBv6/Rjos5h+n8RWw46Uscq8zT5uOJa
         5WAQ==
X-Gm-Message-State: AOJu0YwVjI4w8wzKebwNm/nyWiCcJM1Q9mrKFbdVXKbYJofxuOFe6aHb
	qhMm1i4d6121wCPMzbJ6HkE=
X-Google-Smtp-Source: AGHT+IFdYMYFCnc2AWTKiuSrLhSy8WK9e5T56y3poFTMZrheXZ6Jld1vppWbPRz8KLWxgX60Bgcz/w==
X-Received: by 2002:adf:e881:0:b0:337:7caa:4b27 with SMTP id d1-20020adfe881000000b003377caa4b27mr511571wrm.109.1705057283705;
        Fri, 12 Jan 2024 03:01:23 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id d13-20020adfef8d000000b0033739c1da1dsm3536875wro.67.2024.01.12.03.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 03:01:23 -0800 (PST)
Message-ID: <47a4418b-68bf-4850-ba8b-1a5264f923e4@gmail.com>
Date: Fri, 12 Jan 2024 11:01:21 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH] `log --merge` also for rebase/cherry pick/revert
Content-Language: en-US
To: Michael Lohmann <mi.al.lohmann@gmail.com>, git@vger.kernel.org
References: <20240111233311.64734-1-mi.al.lohmann@gmail.com>
In-Reply-To: <20240111233311.64734-1-mi.al.lohmann@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael

On 11/01/2024 23:33, Michael Lohmann wrote:
> This extends the functionality of `git log --merge` to also work with
> conflicts for rebase, cherry pick and revert.
> 
> Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
> ---
> Hi everybody!
> 
> When Phillip Wood gave me some nice hints on his workflow concerning
> conflicts [1] (we discussed if `--show-current-patch` would make sense
> for cherry pick/revert). When I learned about `git log --merge` I was a
> bit sad to discover that those do not exist for rebase/revert/cherry
> pick since they look really valuable for getting an understanding on
> what was changed. It is basically the counterpart to
> `git show ${ACTION}_HEAD` for understanding the source of the conflict.
> 
> I am curious if also other people would be interested in having an easy
> way to get a log of only the relevant commits touching conflicting files
> for said actions.
> 
> With this patch I think the functionality is there, just hijacking the
> `--merge` code - maybe an alias like `git log --conflict` or similar
> might be more descriptive now?
> 
> What do you think about this idea? (Or am I maybe missing an easy way to
> achieve it with the existing code as well?)

I should start by saying that I didn't know "git log --merge" existed 
before I saw this message so please correct me if I've misunderstood 
what this patch is doing. If I understand correctly it shows the commits 
from each side of the merge and is equivalent to

     git log HEAD MERGE_HEAD ^$(git merge-base HEAD MERGE_HEAD)

When a commit is cherry-picked the merge base used is CHERRY_PICK_HEAD^ 
[*] so I'm not sure what

     git log HEAD CHERRY_PICK_HEAD ^$(git merge-base HEAD CHERRY_PICK_HEAD)

tells us. Indeed there HEAD and CHERRY_PICK_HEAD may not share a common 
ancestor. As I say I've not used "git log --merge" so maybe I'm missing 
the reason why it would be useful when cherry-picking or rebasing.

Best Wishes

Phillip

[*] assuming we're not picking a merge commit

> Michael
> 
> 
> [1] https://lore.kernel.org/git/cfba7098-3c23-4a81-933c-b7fefdedec8a@gmail.com/
> 
>   revision.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/revision.c b/revision.c
> index 2424c9bd67..2e5c00dabd 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1961,23 +1961,37 @@ static void add_pending_commit_list(struct rev_info *revs,
>   	}
>   }
>   
> +static char* get_action_head_name(struct object_id* oid)
> +{
> +	if (!repo_get_oid(the_repository, "MERGE_HEAD", oid)) {
> +		return "MERGE_HEAD";
> +	} else if (!repo_get_oid(the_repository, "REBASE_HEAD", oid)) {
> +		return "REBASE_HEAD";
> +	} else if (!repo_get_oid(the_repository, "CHERRY_PICK_HEAD", oid)) {
> +		return "CHERRY_PICK_HEAD";
> +	} else if (!repo_get_oid(the_repository, "REVERT_HEAD", oid)) {
> +		return "REVERT_HEAD";
> +	} else
> +		die("--merge without MERGE_HEAD, REBASE_HEAD, CHERRY_PICK_HEAD or REVERT_HEAD?");
> +}
> +
>   static void prepare_show_merge(struct rev_info *revs)
>   {
>   	struct commit_list *bases;
>   	struct commit *head, *other;
>   	struct object_id oid;
>   	const char **prune = NULL;
> +	const char *action_head_name;
>   	int i, prune_num = 1; /* counting terminating NULL */
>   	struct index_state *istate = revs->repo->index;
>   
>   	if (repo_get_oid(the_repository, "HEAD", &oid))
>   		die("--merge without HEAD?");
>   	head = lookup_commit_or_die(&oid, "HEAD");
> -	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
> -		die("--merge without MERGE_HEAD?");
> -	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
> +	action_head_name = get_action_head_name(&oid);
> +	other = lookup_commit_or_die(&oid, action_head_name);
>   	add_pending_object(revs, &head->object, "HEAD");
> -	add_pending_object(revs, &other->object, "MERGE_HEAD");
> +	add_pending_object(revs, &other->object, action_head_name);
>   	bases = repo_get_merge_bases(the_repository, head, other);
>   	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
>   	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);

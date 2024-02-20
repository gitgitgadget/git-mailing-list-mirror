Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D368E1D6AE
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708461303; cv=none; b=sh3gT293UpkFwGBC3zvDdJMlxxn7EDnyuuprd3kjNFpb40Z6RVa+f9df/x2CPcicq8oi3k9YD3eJ/0ehf9sEeAAxzfDPx//hNztewqlNma4xaaFPQFZ1wu9z9hVivKD9+Xjm4BfVSaeexgx1cq4sdT5w6dvcROOAbPJxFOvX9oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708461303; c=relaxed/simple;
	bh=KLjWjHO+LUHnD4bwLs2ppNoH8bNixtUZ2Kz75EVR0+Y=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HSppSsDR4lBwqHK0AlsH/2h/Wn12QuXFkOYTWgSqi2cKXQzn1Lvq/ccKiyJDVggu8wgB/COf4jFg3GBkXle2v+bq1EZAF2M5ATZPZwKyNOFQOzGXMOCiWz2oAjbu4+R8nqrRhX9OYnGqA5eEK7Tui6JYJyTm4EfQaUnlS+6+hQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rxVUGeP7; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rxVUGeP7"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708461297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5jDqeCkhAsHfK//FUYlygFQeWhWK9KBolYyqWapVIU=;
	b=rxVUGeP7t9ndCBrB2Wc0hnzq9w8unArVvtdGSDcAv71Ek0mMik+xXRxFA6xaw29F+/UwLn
	IXrEqkpzyk5lJmKR6Zwv3ZB4MQthdxVbS4vDQvxieH1SNZh5tqymsSqG89Q8/nfavuPlqJ
	RBMZj1pmB+yk1LcfvertdiT5HDJR90tmZyG9NqgrA5eoEWvIjKAzleqLazd961B2dwv1YS
	yeiZqhgOTOftnO1Yz1WHivQCvMj8wiqVUJMk6f6IE4DB/yLPTyXhkPLMqgFkVo9hUdQsq7
	qQuWJu3CLPk6hmsWGw6Qzi++QFFOBYHM3LZqZ9FaffVVbCBeeza1raLEyHo2hg==
Date: Tue, 20 Feb 2024 21:34:57 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: adjust documentation
In-Reply-To: <96f1afa6-f4ac-4593-9bf4-72dafe3cab85@gmail.com>
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
 <xmqq8r3lnzp0.fsf@gitster.g>
 <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
 <ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
 <c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
 <be91f3ad9305366c1385c2da4881537e@manjaro.org> <xmqq8r3g8caz.fsf@gitster.g>
 <35738a93f5cbace5b3235ce614b7afbf@manjaro.org> <xmqqttm3ouxy.fsf@gitster.g>
 <16c1f883-881f-4f8c-95b2-22fb4825b733@gmail.com>
 <96f1afa6-f4ac-4593-9bf4-72dafe3cab85@gmail.com>
Message-ID: <b6d22f5a66de49efc623eceddbdc6faf@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-20 21:25, Rubén Justo wrote:
> Adjust the placeholders we use in Documentation/git-branch.txt to what
> we say in CodingGuideLines:
> 
> 	If a placeholder has multiple words, they are separated by dashes:
> 	  <new-branch-name>
> 	  --template=<template-directory>
> 
> Best viewed with --word-diff.
> 
> Signed-off-by: Rubén Justo <rjusto@gmail.com>

Looking good to me!

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> 
>  Documentation/git-branch.txt | 54 +++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/git-branch.txt 
> b/Documentation/git-branch.txt
> index 0b08442932..489507e25f 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -17,13 +17,13 @@ SYNOPSIS
>  	[(-r | --remotes) | (-a | --all)]
>  	[--list] [<pattern>...]
>  'git branch' [--track[=(direct|inherit)] | --no-track] [-f]
> -	[--recurse-submodules] <branchname> [<start-point>]
> -'git branch' (--set-upstream-to=<upstream> | -u <upstream>) 
> [<branchname>]
> -'git branch' --unset-upstream [<branchname>]
> -'git branch' (-m | -M) [<oldbranch>] <newbranch>
> -'git branch' (-c | -C) [<oldbranch>] <newbranch>
> -'git branch' (-d | -D) [-r] <branchname>...
> -'git branch' --edit-description [<branchname>]
> +	[--recurse-submodules] <new-branch> [<start-point>]
> +'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branch>]
> +'git branch' --unset-upstream [<branch>]
> +'git branch' (-m | -M) [<branch>] <new-branch>
> +'git branch' (-c | -C) [<branch>] <new-branch>
> +'git branch' (-d | -D) [-r] <branch>...
> +'git branch' --edit-description [<branch>]
> 
>  DESCRIPTION
>  -----------
> @@ -53,7 +53,7 @@ branches not merged into the named commit will be
> listed.  If the <commit>
>  argument is missing it defaults to `HEAD` (i.e. the tip of the current
>  branch).
> 
> -The command's second form creates a new branch head named <branchname>
> +The command's second form creates a new branch head named <new-branch>
>  which points to the current `HEAD`, or <start-point> if given. As a
>  special case, for <start-point>, you may use `"A...B"` as a shortcut 
> for
>  the merge base of `A` and `B` if there is exactly one merge base. You
> @@ -61,7 +61,7 @@ can leave out at most one of `A` and `B`, in which
> case it defaults to
>  `HEAD`.
> 
>  Note that this will create the new branch, but it will not switch the
> -working tree to it; use "git switch <newbranch>" to switch to the
> +working tree to it; use "git switch <new-branch>" to switch to the
>  new branch.
> 
>  When a local branch is started off a remote-tracking branch, Git sets 
> up the
> @@ -72,17 +72,17 @@ the remote-tracking branch. This behavior may be
> changed via the global
>  overridden by using the `--track` and `--no-track` options, and
>  changed later using `git branch --set-upstream-to`.
> 
> -With a `-m` or `-M` option, <oldbranch> will be renamed to 
> <newbranch>.
> -If <oldbranch> had a corresponding reflog, it is renamed to match
> -<newbranch>, and a reflog entry is created to remember the branch
> -renaming. If <newbranch> exists, -M must be used to force the rename
> +With a `-m` or `-M` option, <branch> will be renamed to <new-branch>.
> +If <branch> had a corresponding reflog, it is renamed to match
> +<new-branch>, and a reflog entry is created to remember the branch
> +renaming. If <new-branch> exists, -M must be used to force the rename
>  to happen.
> 
>  The `-c` and `-C` options have the exact same semantics as `-m` and
>  `-M`, except instead of the branch being renamed, it will be copied to 
> a
>  new name, along with its config and reflog.
> 
> -With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
> +With a `-d` or `-D` option, `<branch>` will be deleted.  You may
>  specify more than one branch for deletion.  If the branch currently
>  has a reflog then the reflog will also be deleted.
> 
> @@ -107,7 +107,7 @@ OPTIONS
>  --create-reflog::
>  	Create the branch's reflog.  This activates recording of
>  	all changes made to the branch ref, enabling use of date
> -	based sha1 expressions such as "<branchname>@\{yesterday}".
> +	based sha1 expressions such as "<branch>@\{yesterday}".
>  	Note that in non-bare repositories, reflogs are usually
>  	enabled by default by the `core.logAllRefUpdates` config option.
>  	The negated form `--no-create-reflog` only overrides an earlier
> @@ -116,7 +116,7 @@ OPTIONS
> 
>  -f::
>  --force::
> -	Reset <branchname> to <start-point>, even if <branchname> exists
> +	Reset <new-branch> to <start-point>, even if <new-branch> exists
>  	already. Without `-f`, 'git branch' refuses to change an existing 
> branch.
>  	In combination with `-d` (or `--delete`), allow deleting the
>  	branch irrespective of its merged status, or whether it even
> @@ -124,8 +124,8 @@ OPTIONS
>  	`-m` (or `--move`), allow renaming the branch even if the new
>  	branch name already exists, the same applies for `-c` (or `--copy`).
>  +
> -Note that 'git branch -f <branchname> [<start-point>]', even with 
> '-f',
> -refuses to change an existing branch `<branchname>` that is checked 
> out
> +Note that 'git branch -f <new-branch> [<start-point>]', even with 
> '-f',
> +refuses to change an existing branch `<new-branch>` that is checked 
> out
>  in another worktree linked to the same repository.
> 
>  -m::
> @@ -255,7 +255,7 @@ how the `branch.<name>.remote` and
> `branch.<name>.merge` options are used.
>  	linkgit:git-config[1]. Currently, only branch creation is
>  	supported.
>  +
> -When used in branch creation, a new branch <branchname> will be 
> created
> +When used in branch creation, a new branch <new-branch> will be 
> created
>  in the superproject and all of the submodules in the superproject's
>  <start-point>. In submodules, the branch will point to the submodule
>  commit in the superproject's <start-point> but the branch's tracking
> @@ -270,12 +270,12 @@ superproject's "origin/main", but tracks the
> submodule's "origin/main".
> 
>  -u <upstream>::
>  --set-upstream-to=<upstream>::
> -	Set up <branchname>'s tracking information so <upstream> is
> -	considered <branchname>'s upstream branch. If no <branchname>
> +	Set up <branch>'s tracking information so <upstream> is
> +	considered <branch>'s upstream branch. If no <branch>
>  	is specified, then it defaults to the current branch.
> 
>  --unset-upstream::
> -	Remove the upstream information for <branchname>. If no branch
> +	Remove the upstream information for <branch>. If no branch
>  	is specified it defaults to the current branch.
> 
>  --edit-description::
> @@ -300,8 +300,8 @@ superproject's "origin/main", but tracks the
> submodule's "origin/main".
>  	Only list branches whose tips are not reachable from the
>  	specified commit (HEAD if not specified). Implies `--list`.
> 
> -<branchname>::
> -	The name of the branch to create or delete.
> +<new-branch>::
> +	The name of the branch to create.
>  	The new branch name must pass all checks defined by
>  	linkgit:git-check-ref-format[1].  Some of these checks
>  	may restrict the characters allowed in a branch name.
> @@ -311,14 +311,10 @@ superproject's "origin/main", but tracks the
> submodule's "origin/main".
>  	given as a branch name, a commit-id, or a tag.  If this
>  	option is omitted, the current HEAD will be used instead.
> 
> -<oldbranch>::
> +<branch>::
>  	The name of an existing branch.  If this option is omitted,
>  	the name of the current branch will be used instead.
> 
> -<newbranch>::
> -	The new name for an existing branch. The same restrictions as for
> -	<branchname> apply.
> -
>  --sort=<key>::
>  	Sort based on the key given. Prefix `-` to sort in descending
>  	order of the value. You may use the --sort=<key> option

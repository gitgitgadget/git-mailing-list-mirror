Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AF017AE1D
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759339881; cv=none; b=JQgzb8lnaes3Td4YeQiPyyPGYg1oU/R4oJwKTdG3ndHisaapnuHZ9rFl252A6eTgcCLBiFvJvBUGnXr2U30DjJPLXzTPSUuCw/9QtrAHTQ0so1S5iMFcgOyOGra2Vyw7Gy7AveYdlUZpotSNOa6d8ncXzxo2fM5u9uNz/A3qMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759339881; c=relaxed/simple;
	bh=kf51B6zDTuijL5ckfYO7/2iXi1Y1uox5Lbqkc79uBrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dec863l7vLLosE0sX8dKsKt9E2JtK/mixe8xOTxAuYAWAJlvkXWdXBDlM+xim8kxgAFlo6PwuLnEoMRL6DI4Xp4qkmdVXhc42pIosV3gNb705bNtBnz3i3/DkItzlEBcSm6jAwduhwSXbmiuXD/tABTJVNwjxoIq7knq+YiuwpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=pEegFDS3; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="pEegFDS3"
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 5C2BC4D24A
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 19:31:07 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:f5ae:5744:1198:6c76])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 6366B13F8CE;
	Wed,  1 Oct 2025 19:30:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1759339860;
	bh=kf51B6zDTuijL5ckfYO7/2iXi1Y1uox5Lbqkc79uBrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEegFDS3NJ72sFK5g0iGSlWwWzJHPrGu4Z4lhPSTLFb6hiLfAm2fEI/k5Wyej8zQn
	 4YaOpzIDWWKpugJcQ+jaPbWKhe8rjrHwBWvTjC2OtpPRZHyiYC3wH8MfL3AeJm1RWa
	 Msm6MepEkZMcjA9ryNhS15Fs5okwJ8XIbv6h+LqVQGA1wVDnZrgcodNwXGq7Hs/Vtx
	 wPalpbOXogqZXcb/GWn9ozvaDnsOzNPyOo1ceewaYHa6kpswgv8eclVmEyanc64Xbe
	 xVHFuZ4I3z/L1RaxvmbmqjjMl2QADQ6GRaJuHHNaYsnMRdw8Cws0YXPp5bvQOl0p3p
	 YCxic3LrTeRwA==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Julia Evans <julia@jvns.ca>, Julia Evans <julia@jvns.ca>
Subject:
 Re: [PATCH v4 2/5] doc: add an UPSTREAM BRANCHES section to pull/push/fetch
Date: Wed, 01 Oct 2025 19:30:55 +0200
Message-ID: <5044672.31r3eYUQgx@cayenne>
In-Reply-To:
 <69825d46349e55dd1b17444ab4e6d542fd44f371.1759262314.git.gitgitgadget@gmail.com>
References:
 <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
 <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
 <69825d46349e55dd1b17444ab4e6d542fd44f371.1759262314.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 30 September 2025 21:58:31 CEST Julia Evans via GitGitGadget 
wrote:
> From: Julia Evans <julia@jvns.ca>
> 
> From user feedback: one user mentioned that they don't know what the
> term "upstream branch" means. As far as I can tell, the most complete
> description is under the `--track` option in `git branch`. Upstreams
> are an important concept in Git and the `git branch` man page is not an
> obvious place for that information to live.
> 
> There's also a very terse description of "upstream branch" in the
> glossary that's missing a lot of key information, like the fact that the
> upstream is used by `git status` and `git pull`, as well as a
> description in `git-config` in `branch.<name>.remote` which doesn't
> explain the relationship to `git status` either.
> 
> Since the `git pull`, `git push`, and `git fetch` man pages already
> include sections on REMOTES and the syntax for URLs, add a section on
> UPSTREAM BRANCHES to `urls-remotes.adoc`.
> 
> In the new UPSTREAM BRANCHES section, cover the various ways that
> upstreams branches are automatically set in Git, since users may
> mistakenly think that their branch does not have an upstream branch if
> they didn't explicitly set one.
> 
> A terminology note: Git uses two terms for this concept:
> 
> - "tracking" as in "the tracking information for the 'foo' branch"
>   or the `--track` option to `git branch`
> - "upstream" or "upstream branch", as in `git push --set-upstream`.
>   This term is also used in the `git rebase` man page to refer to the
>   first argument to `git rebase`, as well as in `git pull` to refer to
>   the branch which is going to be merged into the current branch ("merge
>   the upstream branch into the current branch")
> 
> Use "upstream branch" as a heading for this concept even though the term
> "upstream branch" is not always used strictly in the sense of "the
> tracking information for the current branch". "Upstream" is used much
> more often than "tracking" in the Git docs to refer to this concept and
> the goal is to help users understand the docs.
> 
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/urls-remotes.adoc | 43 +++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/urls-remotes.adoc b/Documentation/urls-
remotes.adoc
> index 9b10151198..dba5adeb58 100644
> --- a/Documentation/urls-remotes.adoc
> +++ b/Documentation/urls-remotes.adoc
> @@ -92,5 +92,44 @@ git push uses:
>  ------------
> 
> 
> -
> -
> +UPSTREAM BRANCHES[[UPSTREAM-BRANCHES]]
> +--------------------------------------

Please do not put anchors on the same line as the paragraph. The anchor is 
attached to the paragraph (the block in asciidoc terminology) if it is not 
attached to an inline element. So it can appear just before the block with the 
same effect.

Additionally, this clears up the text from the anchor, which is safer for 
translation.

[[UPSTREAM-BRANCHES]]
UPSTREAM BRANCHES

> +
> +Branches in Git can optionally have an upstream remote branch.
> +Git defaults to using the upstream branch for remote operations, for 
example:
> +
> +* It's the default for `git pull` or `git fetch` with no arguments.
> +* It's the default for `git push` with no arguments, with some exceptions.
> +  For example, you can use the `branch.<name>.pushRemote` option to push
> +  to a different remote than you pull from, and by default with
> +  `push.default=simple` the upstream branch you configure must have
> +  the same name.
> +* Various commands, including `git checkout` and `git status`, will
> +  show you how many commits have been added to your current branch and
> +  the upstream since you forked from it, for example "Your branch and
> +  'origin/main' have diverged, and have 2 and 3 different commits each
> +  respectively".
> +
> +The upstream is stored in `.git/config`, in the "remote" and "merge"
> +fields. For example, if `main`'s upstream is `origin/main`:
> +
> +	[branch "main"]
> +	   remote = origin
> +	   merge = refs/heads/main
> +

Please mark the code block with a dedicated fence:

----
[branch "main"]
   remote = origin
   merge = refs/heads/main
----

using tabs may lead to issues if the text is modified later.

> +You can set an upstream branch explicitly with
> +`git push --set-upstream <remote> <branch>` or `git branch --track`,
> +but Git will often automatically set the upstream for you, for example:
> +
> +* When you clone a repository, Git will automatically set the upstream
> +  for the default branch.
> +* If you have the `push.autoSetupRemote` configuration option set,
> +  `git push` will automatically set the upstream the first time you push
> +  a branch.
> +* Checking out a remote-tracking branch with `git checkout <branch>`
> +  will automatically create a local branch with that name and set
> +  the upstream to the remote branch.
> +
> +[NOTE]
> +Upstream branches are sometimes referred to as "tracking information",
> +as in "set the branch's tracking information".

Thanks



Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C2E34BA4E
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759698155; cv=none; b=pbfA99Hc90HRfP131hlYFAqeNLUAeE4NYWz9B7V144j6Q3koZFLt2AnYmfzzoxSN4QiKuL+heqnhP8SyXWmkBWaK70vMAl08Zo39Zz7VhFplNMkrGJkpvXir1zqL/M+DE4eHwFKfh5TXshYbqDhgehkeXp/0k1mMPWmlMZ7yszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759698155; c=relaxed/simple;
	bh=3iwAY/wB9jqM+HczjNwOw7/v8mI8hVDoEWLpwCXanJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s44hS4hzw0j4VrLj4zdn2AAcZU1OnNPIeIw/OD7U2dbHl9DnjIrMX7mLB5kMEfOnssYwQ1e5Youy5/gcv9yqvE1g7xxVrbn2r+JJkAwfSe+i9kPeH/vNROTwCZ77c+LEl4hYfh01wXDX8p1OCvQHSw0Y3YHef/uQESWxCRbzMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 708A5DF85F2
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 22:53:07 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:6492:b72:2d5a:d6ac])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id A1ECA7803A2;
	Sun,  5 Oct 2025 22:52:51 +0200 (CEST)
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <avila.jn@gmail.com>
To: git@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>
Cc: Michal Suchanek <msuchanek@suse.de>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>, Sergey Organov <sorganov@gmail.com>,
 Ben Knoble <ben.knoble@gmail.com>, Jason Cho <jason11choca@proton.me>,
 "Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Subject: Re: [PATCH 1/2] doc: git-worktree: Link to examples
Date: Sun, 05 Oct 2025 22:52:51 +0200
Message-ID: <6043158.DvuYhMxLoT@cayenne>
In-Reply-To:
 <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
References:
 <xmqqseg1xwc1.fsf@gitster.g>
 <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 2 October 2025 17:51:34 CEST Michal Suchanek wrote:
> Also add advice to put new worktrees outside of existing ones.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  Documentation/git-worktree.adoc | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-
worktree.adoc
> index 389e669ac0..ec31863aec 100644
> --- a/Documentation/git-worktree.adoc
> +++ b/Documentation/git-worktree.adoc
> @@ -79,6 +79,9 @@ with a matching name, treat as equivalent to:
>  $ git worktree add --track -b <branch> <path> <remote>/<branch>
>  ------------
>  +
> +For best results it is advised to specify <path> outside of the repository 
and
> +existing worktrees - see <<EXAMPLES>>

Please use the form <<EXAMPLES,EXAMPLES>> in order to let the translators also 
change the cross-link text in their language.

Also, the <path> placeholder should be formatted as _<path>_. For your 
information, I'm right in the middle of pushing the conversion of git-
worktree.adoc to the new synopsis style. 

> ++
>  If the branch exists in multiple remotes and one of them is named by
>  the `checkout.defaultRemote` configuration variable, we'll use that
>  one for the purposes of disambiguation, even if the `<branch>` isn't
> @@ -502,8 +505,8 @@ locked "reason\nwhy is locked"
>  ...
>  ------------
> 
> -EXAMPLES
> ---------
> +[[EXAMPLES]]EXAMPLES
> +--------------------

As noted by others, please put the block anchors on a dedicated line, out of 
the translation scope.

Thank you.



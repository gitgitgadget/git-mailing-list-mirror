Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4C26C3BD
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781728074; cv=none; b=uosEEiaLxqoRAtazcbxEVixIG9PePFikhi7XVz3vwMLnVS6GkJ4OH91COf5mn9zEtubzuQ/9J+K2hrcji1EuqBPLrnepbQnk1VPSEinHI54PLCAqbfm38a07pI3R9vRk5lYoo3KMsUdOuo/kR9d93F1LuOSVwTFDHubYQsPCFuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781728074; c=relaxed/simple;
	bh=zRXc2Zy/fZmRMSYPZgmUQXr4RdBFZMOGfzec3V1pP5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWHLwu7h0F/THLjeOKvYIXGLvTWo8HQ4B+ibzuUou6cjF/d9pyqX5GUafFA3S7gAk8HkC/7+xCiSkGUKuFUKAU217V1xnEzADSLa9fuY0Pceq/EVq2qliwAhCMpoNInjrgWy9TAgXQUlC/LqeS9o6TPL0CbfnLPj5U17jshAkFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WykaDPH7; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WykaDPH7"
Received: (qmail 161779 invoked by uid 106); 17 Jun 2026 20:27:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zRXc2Zy/fZmRMSYPZgmUQXr4RdBFZMOGfzec3V1pP5w=; b=WykaDPH7tQA/U4b8EbHvXhRlB8rzZ8Z4KRE6acnK3fVmLRP1sHNo4uIL56JMHxHSGXvBVR5srTGqmLUIqjR5AFz9VwMuky1cgu4Og6QDeNK1RXO/9lDtk03RUZVeZltV+BRqSMg2Ps2vPYAwAsuYK2BYlib0Vcsja14dn8h8l+Sr0sAe5t9WzAVSzcUEIXNROfwZfnWgjMcvh/c3lusafAJHZy5yx5bclOL0Qfwgxgh2AWezr29pFPtaKb1NZpbXYFmLYwwLllJNsOkVmsL84MMUUEC+8AL+oiVaOEmjsnE7BP63xbhBqmfrHU8KVRA0ffKwO06avWdoFhjJ4zdPxA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Jun 2026 20:27:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 452419 invoked by uid 111); 17 Jun 2026 20:27:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Jun 2026 16:27:46 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 17 Jun 2026 16:27:44 -0400
From: Jeff King <peff@peff.net>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com, christian.couder@gmail.com,
	gitster@pobox.com, jltobler@gmail.com, karthik.188@gmail.com,
	phillip.wood@dunelm.org.uk, siddharthasthana31@gmail.com
Subject: Re: [PATCH v5 2/2] graph: indent visual root in graph
Message-ID: <20260617202744.GA3465855@coredump.intra.peff.net>
References: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
 <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
 <20260613-ps-pre-commit-indent-v5-2-8d308efea63d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613-ps-pre-commit-indent-v5-2-8d308efea63d@gmail.com>

On Sat, Jun 13, 2026 at 09:09:16PM +0200, Pablo Sabater wrote:

> +/*
> + * Iterates the commits queue searching for the next visible commit, once found
> + * sets visibleness and visual-root flags.
> + * Knowing if the next commit is also a visual root avoids redundant indentations
> + *
> + * NEEDSWORK: The queue is actively being modified by the walker, for each commit
> + * its parents and itself get simplified and their flags set, but for the next
> + * unrelated commit or the grandparents they are not simplified yet, which means
> + * that a commit whose parents are all filtered will not be marked as a visual
> + * root candidate at the lookahead.
> + * This causes the lookahead to fail, failing to set the cascade flag to avoid
> + * redundant indentations.
> + * See 'test_expect_failure' at t4218-log-graph-indentation.sh.
> + */
> +static void graph_peek_next_visible(struct git_graph *graph,
> +				    struct graph_lookahead_flags *flags)
> +{
> +	struct commit_list *cl;
> +
> +	flags->is_next_visible = 0;
> +	flags->is_next_visual_root = 0;
> +	flags->next_has_column = 0;
> +
> +	for (cl = graph->revs->commits; cl; cl = cl->next) {
> +		if (get_commit_action(graph->revs, cl->item) != commit_show)
> +			continue;
> [...]

I have a feeling this may interact badly with the prio-queue introduced
by dd4bc01c0a (revision: use priority queue for non-limited streaming
walks, 2026-05-27). In that commit, get_revision_1() sucks all of the
commits from revs->commits into revs->commit_queue, and then traversal
puts the parents into that queue, not the commits list.

So during the traversal, revs->commits does not hold the complete queue
anymore. I think it does see _some_ commits, since some get placed
directly into revs->commits and then later moved next time
get_revision() is called. But if we instrument the code like this:

diff --git a/graph.c b/graph.c
index e0d1e2a510..8a5f17a089 100644
--- a/graph.c
+++ b/graph.c
@@ -926,6 +926,10 @@ static void graph_peek_next_visible(struct git_graph *graph,
 	flags->is_next_visual_root = 0;
 	flags->next_has_column = 0;
 
+	warning("peeking at visible commits: %d in list, %d in queue",
+		commit_list_count(graph->revs->commits),
+		(int)graph->revs->commit_queue.nr);
+
 	for (cl = graph->revs->commits; cl; cl = cl->next) {
 		if (get_commit_action(graph->revs, cl->item) != commit_show)
 			continue;

and run something like:

  ./git log --graph --oneline -- Makefile

we can see that we're always considering just one commit, while there
may be dozens or hundreds in the queue.

I'm not sure what the solution is. This function wants to peek ahead in
queue order, possibly through multiple entries. But a heap-based queue
inherently only supports peeking at the first entry.

None of the tests seem to fail, but I'm not sure if that's because I'm
way off base in my analysis, or there's a gap in the test coverage, or
if this case is part of the expect_failure ones mentioned in the
comment.

I noticed because I have another topic which drops the revs->commits
list entirely (and just always uses the queue), which of course doesn't
compile when merged with this (I merge with 'jch' for my daily driver,
which now includes this patch).

-Peff

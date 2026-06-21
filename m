Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB2542050
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782065159; cv=none; b=fQnofH9kXAQ3fyc7TwUoHtIJzeqziPIxhUUetmXWf4w28UysPzUz2X9hK1ssSksQq9JZ83H6rrLL7hQ/CmCB4oGEM2UUzLs2H1WwOaJWBIaHTF7af1IUbxi9UPPzOWhA+mzKYDkPYCj7hvNbfngkmhnkAshNEB3mn1dwa3iRH3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782065159; c=relaxed/simple;
	bh=m+3IDcd7Mdf7VQVxUb91rZI3CdiKgtsA166NN63pp34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zy1CZZPOjUUMiKnUydA1EnG/BqbZzyu9JQTiajzk8fsbDoNxciNFLeCNdRruEMbOd/lDhA2hyWPSJAcsDEBHb1RKQHCEjXx/jR0fWmN1tzN+MqOkffx0AmofaYfXH+hM2FPShq/8HmKgm1PNZIyqj4TXl5LE8jNaeUZRvJNv3DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DM7A0IQE; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DM7A0IQE"
Received: (qmail 204562 invoked by uid 106); 21 Jun 2026 18:05:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=m+3IDcd7Mdf7VQVxUb91rZI3CdiKgtsA166NN63pp34=; b=DM7A0IQElBhepJfHXD1cL9C7YVpFS/FZ9r7Q3hUoAdK3m8l8npYVJp1IqW3S1DpEa5Cmznp1ohs3U4JDv63043/Nh+EoDHFKnVhjqvmGtZFc54HkyCBMnOmwDtO2Dr5VsGUmnuHo/D1KvSpa8Ni27ZSKpbFVOdxn1VCH5yF4BmtaWHlrUYjcKDfiGOKCEZs2pTcbEwPfnzY0sdP4Pls1lufvUoxdwGvUZuVtUZAhkHLCFEBkzN7aphdXMclAT9ixKJPkT5hAYC+FBo/tICpA9RY17qTu2FPGMgkKKjp44xBzGLJK+cqWbE2nVdS3nWR7zUCzYHuW9rsZ+ut9D8LpCg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 21 Jun 2026 18:05:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 521088 invoked by uid 111); 21 Jun 2026 18:05:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Jun 2026 14:05:58 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 21 Jun 2026 14:05:56 -0400
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org,
	ayu.chandekar@gmail.com, chandrapratap3519@gmail.com,
	christian.couder@gmail.com, gitster@pobox.com, jltobler@gmail.com,
	karthik.188@gmail.com, phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: Re: [PATCH v5 2/2] graph: indent visual root in graph
Message-ID: <20260621180556.GD2206349@coredump.intra.peff.net>
References: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
 <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
 <20260613-ps-pre-commit-indent-v5-2-8d308efea63d@gmail.com>
 <20260617202744.GA3465855@coredump.intra.peff.net>
 <CAN5EUNSQY2oK7BE4J9Y8APfkP6eJxta050OUu=RoJYhXOjX_OA@mail.gmail.com>
 <20260618160504.GA818042@coredump.intra.peff.net>
 <CAL71e4MAtD4MqE-22UyYaNFVYcFgYmffngihhovEChVfHLmEdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL71e4MAtD4MqE-22UyYaNFVYcFgYmffngihhovEChVfHLmEdA@mail.gmail.com>

On Fri, Jun 19, 2026 at 09:34:16AM +0200, Kristofer Karlsson wrote:

> On Thu, 18 Jun 2026 at 18:05, Jeff King <peff@peff.net> wrote:
> >
> > Thanks for looking into it. I meant to also cc the Kristofer, the author
> > of dd4bc01c0a, for any thoughts (adding him now).
> >
> 
> Thanks for the CC. I took a look at how this interacts with my
> change.
> 
> dd4bc01c0a doesn't hurt here I think, but future followup changes
> might. From what I can tell --graph triggers topo_order, so
> the walk mode is either REV_WALK_TOPO or REV_WALK_LIMITED
> and the prio_queue change only applies to REV_WALK_STREAMING.

I'm not so sure. If I merge 53967f242a (graph: indent visual root in
graph, 2026-06-13) into master (so that it has both your commit_queue
changes and Pablo's topic), and then apply this:

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

and run:

  ./git log --graph -- Makefile

then we always see exactly one commit in the list, but an
ever-increasing number in the queue (up to ~4000). We do seem to be in
REV_WALK_TOPO mode, so I think we'd never return the commits via
get_revision(), but it is weird that we are sticking them in the queue
at all.

Looks like that happens via rewrite_parents(), which always writes into
commit_queue. I guess it doesn't matter because in topo mode we are
always pulling off of the topo_walk_info queue anyway? It does make me
wonder if there is a lurking bug around history simplification and
--topo-order, though.

> That said, graph_peek_next_visible() reaching directly into
> revs->commits feels fragile -- especially if we drop revs->commits
> in the future. One option would be to add a thin abstraction in
> revision.c that dispatches per walk mode, something like:
> 
>     int revision_has_more_commits(struct rev_info *revs)
>     {
>         if (revs->topo_walk_info)
>             return revs->topo_walk_info->topo_queue.nr > 0;
>         return revs->commits != NULL;
>     }
> 
>     struct commit *revision_peek_next_commit(struct rev_info *revs)
>     {
>         if (revs->topo_walk_info)
>             return prio_queue_peek(&revs->topo_walk_info->topo_queue);
>         if (revs->commits)
>             return revs->commits->item;
>         return NULL;
>     }
> 
> That way graph.c does not need to know which data structure the
> walker uses, and if the internals change later the API adapts in
> one place.

Yeah, I agree some abstraction would help. I think it would have to be
full iteration, though; the graph code wants to know if there is any
commit that is actually going to be shown, not just a potential single
next one. So we at least need to be able to iterate in arbitrary order.

> As for the multi-element peek question, I think I would either opt
> for draining into a buffer if it's really needed, though when looking
> at the code here I think multi-element peeking is not truly needed.
> It seems like the logic just checks if there is at least another
> element after the peek, but it does not try to read the actual value,
> so we can just check the queue size instead.

We do look at some characteristics of the commit we find by peeking, but
I'm not sure how much it matters if we get the _next_ commit that will
be shown, or if any arbitrary commit is OK.

-Peff

Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FD33FE36
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798709; cv=none; b=IEQa1BglxdGoRXl+wgJmpntfq0aIsDf5BYi2/rbWtwFyNUk9L1QCiTC+OXfnRMSOcZYL8U/5MMpIhi+sptI9spF/1E3E8iyLmqClZCLdkxtiNg8puLjghOAnHrYpLYn9LUHo8kU0lXOVMFHdgBJscBVLnujj+eejf08AAbBTCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798709; c=relaxed/simple;
	bh=N2/4VqP0vH5jQBC0//PwLQZtbvwcdmr5TkFf4MWgz1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRQEbM65aQobW/Y1XhW0po13qe30uPPaSJa8WeqGYvBVJY5wUM394cLzkXYPZhVwsnZhBV0KwWJtJRlbU8ijZbFlmckEWu1TeHG0VlcVktqP0hveNTcmdUbNT2cxtrfE6Z0zqzbfeW6/8wkSIoLoWMT3w9WSvs8VY2J+pwYZVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SlaN2wMm; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SlaN2wMm"
Received: (qmail 167796 invoked by uid 106); 18 Jun 2026 16:05:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=N2/4VqP0vH5jQBC0//PwLQZtbvwcdmr5TkFf4MWgz1g=; b=SlaN2wMmiqqj+m8eTKL2+6E83QheejUKEz7NqDAvcp3NNOx2rOE9x4f6AfKZl8cCE/rwqqFN3U3LpoEPWtU0fBoGnum9BPrM/EJjgZTQirHfuR5n1MyEOvOQjmHssMfmMM9YYOF1ZeDr8jvtrZkyAOW+B6uuIzceocOf5u+vDe/xfJ98wNPbo0MJtqY55DWXrvsW0i2eI3OpWwtdeX0XUqI2K6UXEsCQ8adCkb64E1UiingeQtiCmUeOYqTWL+EBBIS9fT3C3EKENi/mYLdLx1m2l2w2cIi40pNT+FAWIRzs7UtH26IAlCYP8EmpMvdAUpzzIkI4x03Rd4nbZUKzmA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Jun 2026 16:05:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 474072 invoked by uid 111); 18 Jun 2026 16:05:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Jun 2026 12:05:06 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 18 Jun 2026 12:05:04 -0400
From: Jeff King <peff@peff.net>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Kristofer Karlsson <krka@spotify.com>, git@vger.kernel.org,
	ayu.chandekar@gmail.com, chandrapratap3519@gmail.com,
	christian.couder@gmail.com, gitster@pobox.com, jltobler@gmail.com,
	karthik.188@gmail.com, phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: Re: [PATCH v5 2/2] graph: indent visual root in graph
Message-ID: <20260618160504.GA818042@coredump.intra.peff.net>
References: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
 <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
 <20260613-ps-pre-commit-indent-v5-2-8d308efea63d@gmail.com>
 <20260617202744.GA3465855@coredump.intra.peff.net>
 <CAN5EUNSQY2oK7BE4J9Y8APfkP6eJxta050OUu=RoJYhXOjX_OA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN5EUNSQY2oK7BE4J9Y8APfkP6eJxta050OUu=RoJYhXOjX_OA@mail.gmail.com>

On Thu, Jun 18, 2026 at 02:42:16PM +0200, Pablo Sabater wrote:

> > > +     for (cl = graph->revs->commits; cl; cl = cl->next) {
> > > +             if (get_commit_action(graph->revs, cl->item) != commit_show)
> > > +                     continue;
> [...]
> > I'm not sure what the solution is. This function wants to peek ahead in
> > queue order, possibly through multiple entries. But a heap-based queue
> > inherently only supports peeking at the first entry.
> 
> Yeah, I haven't read dd4bc01c0a yet but from what you say it prob
> won't work anymore, I didn't know about that series, about the
> lookahead I think it could still work with some tweaks, the important
> part is to set the three lookahead flags.

Thanks for looking into it. I meant to also cc the Kristofer, the author
of dd4bc01c0a, for any thoughts (adding him now).

> From what I understood, we can only get the direct next commit, but no
> more reliably ordered.

Right. There are other queue implementations that could allow full
in-order traversal (e.g., a binary tree), but our prio_queue does not. I
suspect performance for other cases would suffer if we switched the
underlying data structure.

> The flags should be fine:
> 
> - 'is_next_visible' could need to traverse multiple entries, but it
> doesn't need them to be in order. We just need to know if something
> will be rendered after.

Yeah, this one seems easy. We are just setting a bit based on whether
we'd find any commit to show. So order doesn't matter.

> - 'next_has_column' only needs the first entry.

But this was the one I was worried about. Walking the linked list in
order will find us the next commit we're going to show, and the result
of the flag depends on graph_find_new_column_by_commit(). Is it OK to
find _any_ such commit?

(I'm looking at this purely based on reading the existing code, and
haven't really thought hard about the problem space).

> - 'is_next_visual_root' only needs the first entry to know if it could
> be a visual root, and also if it is not the last one (but we don't
> need them to be ordered for this last part).

This one just iterates looking for any other commit we'll show after the
next one. So finding any two entries would be equivalent to the current
code (though we only get to this loop if the first one passes the test
for graph_is_visual_root_candidate).

So if you say order doesn't matter for checking the column and the
visual-root-candidate function, I'm happy to believe you. It makes life
much easier. :)

> Should I work with 'next' as a base to have dd4bc01c0a? (Sorry I've
> just worked with master).

As Junio noted, that's already in master, so I think you're OK to just
base there.

But for future reference, no, you probably don't want to build off of
'next'. If your commit has a dependency on another topic it is best to
build directly off of that topic (and note it in the cover letter of the
series). That way you do not accidentally depend on other things in
'next' which might not ever make it to 'master' (and would thus hold
your topic hostage).

-Peff

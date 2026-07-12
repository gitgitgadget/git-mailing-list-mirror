Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF491A724C
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783861861; cv=none; b=oocQjaFjILSUmHjyNxiRQw+NqvIvZhAUvXebkiRX7ePmr93SmqWAZ/NEx5sLDQqeRnaSL9qh8pBZULblGwYhtsOyiL3w1L1dafSEq7tMW2IZDE87IDNAvapaszgxSB5HvjlJ8V56pxWga7jWwB9ZubwK7ZYFYlQ1AJNTogqyNRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783861861; c=relaxed/simple;
	bh=0yU3P9pLrimB7GRHlef72/To48gqvPlNoHaP6IVOUa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZCvibZW2Cd/5YIUGn4EOCoI46QsMobK3uxOvy8xkzoyCtE8Ty4M32V2rSlkqkGfbRHkC4uCBqtBq7Dp0Jid6Gzn1H9yfsj1Ak1mCt3fmgRZ+RQefNu6t2QnxBtn5tdfKxztQZjfDebVNq8pknBjIcElp9sp6hPUiBENCW+sE4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=hWxC5muF; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="hWxC5muF"
Date: Sun, 12 Jul 2026 15:10:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1783861851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zki7MA8qbNHlkCTKD/WLsRuFKqrWV3Dc6256+ixqi0=;
	b=hWxC5muFlhDA6QrSxclmg3vwnfS+FCSImvWExwsSjOjIwUWqIFv6zi7bJAXXAJW04GovRQ
	YkF/xJVIQTYre569COp8wDyRm27b870N9FvvF0nYY2h0oBp4SXRHrlb7nBq4NnAoM9m5+2
	vJi0t8vEgg4Cy7XTAJy1oIcls1n9ZrBDOl7VcLv3AG9Ot0gz7UdLAw+np4zzoU0iO680F/
	eFjyNt170a6sTupZR/Pdhua7PxgOAk3j/TGKJjzybHOBCVmJp2lXg2qx9JNbAd4grhADf5
	QzGckKXYo8p4+AgYTypjs65IeDrh/CpA3WP9LiRMBHREOAsabmhsj9krWqdn/g==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org, 
	ayu.chandekar@gmail.com, christian.couder@gmail.com, gitster@pobox.com, 
	jltobler@gmail.com, karthik.188@gmail.com, krka@spotify.com, peff@peff.net, 
	phillip.wood@dunelm.org.uk, siddharthasthana31@gmail.com, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v9 0/4] graph: indent visual roots in graph
Message-ID: <alOOXKGIB8BqACxR@exploit>
References: <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
 <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
 <alJOgYmAfGg37hsB@exploit>
 <DJVUU76PUXR4.2BYRTA8SEEBVC@gmail.com>
 <alJpjTXfZmYQccwk@exploit>
 <CA+J6zkQcHu-LVKE-1ypfT=59gEzo4qBzi-pmhSJNC_udCDCJZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+J6zkQcHu-LVKE-1ypfT=59gEzo4qBzi-pmhSJNC_udCDCJZg@mail.gmail.com>
X-Spamd-Bar: -

On Sun, Jul 12, 2026 at 11:26:27AM +0530, Chandra Pratap wrote:
> Tying graph-drawing logic to specific formatting flags could introduce
> inconsistencies. For example, if a user relies on a custom format like
> --format="%h %s", the output is functionally single-line and suffers
> from the exact same ambiguity, but it would miss the fix.
> 
> Even in multi-line formats, relying on the absence of a '|' character to spot
> unrelated commits requires active effort. Indentation provides an immediate
> visual cue that breaks the vertical lineage, which is helpful regardless of the
> commit message length.
> 
> I agree with Pablo: for users who strictly want the old behavior, an opt-out
> flag keeps the graph logic decoupled from the formatting logic.

In that case, together with --[no]-graph-indent, a configuration
variable like "graph.indent" could be introduced to reduce the usage of
--[no]-graph-indent for those that would like to retain the old
behaviour for most formats.

> > > Apart from having an option to disable indentation.
> > >
> > > We could have the cascading to have a limit or make it zig-zag:
> > >
> > > instead of:
> > >
> > > A
> > >   B
> > >     C
> > >       D
> > >
> > > We could do:
> > >
> > > A
> > >   B
> > > C
> > >   D
> > >
> > > This would have its own edge cases like:
> > >
> > > A
> > >   B
> > > C <- if we zig-zag here C and D become ambiguous, currently we are
> > > D    indenting only the last commits (visual roots) here we would have
> > > D    to chose between continuing cascading or indenting the first of D.
> > >
> > > I'm not so sure if I like the zig-zag solution because we need to think again
> > > if it causes an ambiguity, but I wanted to mention it.
> > >
> > > I think we need some more opinions about the design.
> >
> > I don't dislike the the current solution but I can see it degenerating
> > if someone contributes a lot of one-patch series.
> >
> > Maybe you could indent commits that are both head and tail up to two
> > levels and then on the third go back to the beginning of the line. That
> > way you kind of have a zig-zag but without ambiguity. You'd only have to
> > add a counter to keep track of the level of indentation.
> 
> Not sure about this. A zig-zag pattern visually mimics branching and
> merging, which makes unrelated commits look like a complex merge topology.
> 
> I also have a feeling that this will end up recreating the exact ambiguity this
> patch series is trying to fix.

While a zig-zag pattern might be ambiguous, what I proposed is a little
different.

What I proposed is effectively a wrapping for anything that goes beyond
two levels of indentation. I don't think it would look anything like a
fork/merge pattern.

* A
  * B
    * C
* D
  * E
    * F

The difference between two indentation levels and no indentation is very
noticeble, I don't think anyone confused this. This would fix the
staircase pattern on adjacent one-patch series.

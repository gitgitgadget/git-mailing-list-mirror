Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630ED476CE2
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199642; cv=none; b=rgcEEYvacTOskXu7OE70QBuqXpbkcY/59b39ypndAPNnEAL+2EPUJOVRpO9FjcxUrtm/tdq2jvHVKJvy4T3J9w7X9ys5dfqaucU32maKtM8GrlIejLrzuX1aKnmYcDarcdk1mJTGU6nb1itC3UxKsFTjj955NQoBi9NmSUFCKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199642; c=relaxed/simple;
	bh=sNw/kJNfq+1BlQdSjYDJyk90cFXOWkNwu7BolK5DWjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTTBG2wwWEI9viWt51uV9dAtEyXEo5sZ9UcOQ936kJGfsfEx2AsF6XFnuQtyLHWVaNwdQL9KRu6W16sjYBe5rc1OJIEnIEjuRy0bkfuawM9mBfZidUf9lmTNaEd2jTx0MAgENrK6sZpk0FcWFpsxcFmitsGXp7smZuPuqQGKqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SZFQuadd; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SZFQuadd"
Received: (qmail 38144 invoked by uid 106); 23 Sep 2026 21:40:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=sNw/kJNfq+1BlQdSjYDJyk90cFXOWkNwu7BolK5DWjk=; b=SZFQuaddO46CCgKblyGsnzPPoNwb4d1u/gvGPUiDPUvRWcw41LrBz+l0tslnVFeqddtQ0B2ck6xu41FOvONJSJmtlbpoHA09bkuiWhbi6DRWVT/Tlt7jJJpNAXSL9krlV2zDsTq7LuzDUmQY3ILuz2B91n16Xii37H7S/LDEnG1e1vIa/V95DD8qUqKIte0U/SuiEY/9n46dmx3OxI7lR2JS/2RDl8Rh++7nmqkaRACS1KKgKzDkkCSxJKxfnKxd9aRZYlZLZlqUQO6rfhKNGTnXGeyXr36fvEBTQADxdeYpKqxkaJQYXwGXlB5mBkl0aegerTHlBK+eJ/yaCUxMkA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Sep 2026 21:40:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 184430 invoked by uid 111); 23 Sep 2026 21:40:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Sep 2026 17:40:38 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 23 Sep 2026 17:40:38 -0400
From: Jeff King <peff@peff.net>
To: Julia Evans <julia@jvns.ca>
Cc: Junio C Hamano <gitster@pobox.com>,
	Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: add more AsciiDoc cross-references
Message-ID: <20260923214038.GA49087@coredump.intra.peff.net>
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
 <xmqq4ifhdon2.fsf@gitster.g>
 <665e8f8d-7bde-449b-a390-10875135cba2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <665e8f8d-7bde-449b-a390-10875135cba2@app.fastmail.com>

On Tue, Sep 22, 2026 at 04:54:17PM -0400, Julia Evans wrote:

> >> +See the <<PRUNING,PRUNING>> section below for more details.
> >
> > OK, we already see an example of the <<double,double>> reference
> > notation.  This needs to be in this form, intead of <<pruning>>,
> > because it refers to the named section of a different file, namely
> > git-fetch.adoc (I am just trying to make sure I understood your
> > explanation correctly).
> 
> The reason I explained this in a bit of a confusing way is that I'm not
> 100% sure in which exact cases we need to use <<double,double>
> instead of <<single>.
> 
> I double checked just now that if in `git-push.adoc`, I change:
> 
> 	of a remote (see the section <<REMOTES,REMOTES>> below),
> 
> to:
> 
> 	of a remote (see the section <<REMOTES>> below),
> 
> Then there's a problem where in the HTML version it displays as
> "[REMOTES]" instead of just "REMOTES".

Reading the asciidoc docs, I'm not sure how this is affected by the
location of the reference at all. AFAICT the syntax <<FOO,BAR>> just
means "link to FOO, using the text BAR".

The single-item <<FOO>> more or less means the same as "<<FOO,FOO>>",
but as you noticed, vanilla asciidoc seems to pick the text "[FOO]"
here, whereas asciidoctor uses "FOO". I'm using asciidoc 10.2.1 and
asciidoctor 2.0.26 to test, and I see it even with the PRUNING examples,
too.

Even weirder, in the manpage output both implementations actually expand
this to: the section called "FOO". So changing your patch like this:

  -See the <<PRUNING,PRUNING>> section below for more details.
  +See the <<PRUNING>> section below for more details.

gives doc-diff output like this:

  -         See the PRUNING section below for more details.
  +         See the the section called “PRUNING” section below for more details.

which is obviously nonsense.

I could very well believe that some older versions did other weird
things in the presence of includes. ;) But AFAICT the real need for the
doubled text is to control what is in the expanded text (both because of
differences between the versions, but also differences in output
backends).

Which is kind of a shame, because writing just <<PRUNING>> makes the
source a lot more readable. I wonder if we can configure these text
fallbacks, which would let us use the single-item form reliably.

Alternatively, I think this is all syntactic sugar over "xref:FOO[BAR]".
We already have our own linkgit: macro for linking to whole pages
(which, btw, is something xref could do for us, too, though maybe not
without the magic man section number). I wonder if it would be useful to
have a section-link macro that would give us more control, but again,
the syntax of <<PRUNING>> sure is nice.

> But in the <<PRUNING,PRUNING>> example, just using <<PRUNING>>
> seems to work. I started working on this way back in December 2025 
> so I assume that something in this patch was affected by this issue
> and that's how I came across this problem but I'm not sure exactly
> what it was.

So I think using <<PRUNING,PRUNING>> is probably OK for a first pass
here, rather than getting bogged down in trying to configure both
asciidoc implementations. We can shrink them later if we come up with a
good solution.

I do think the explanation in the commit message might be misleading,
though (at least from what I can gather from the asciidoc reference and
from a few experiments).

-Peff

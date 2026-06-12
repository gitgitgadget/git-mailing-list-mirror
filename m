Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD9726CE2D
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 05:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781241369; cv=none; b=KecMAG3mU3zJld7EjhkgCLCGy3x8LLNpgjTIvFOV0zIXv7uwpApQ2qSOY1r51fQAOteE7J5yLDrm5n8ex1VUUhTElqkgrpweuOCjydBwMWPDyN39Vv8enurJHTHdkZqQ7ZvCowNxtCFPQTaByJI74PKcGFIKVCdavX8I0gVrbYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781241369; c=relaxed/simple;
	bh=31aBcqoghjOygWiotfUZtSiMwiTE6Axfkg09yc0AS0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ctuk1cG2m3h9tLXIgKp9qNSLK/uT41ztWmgewNeKsF/ZaLoFMj3wX5CSr+lAc9GDgkjwpOBUtsjIAg0tkfrlfPk4KeMsZatr5duCwi9hajscVHd0GrZ7l5h1PxYXKABOC+H8s/lW+N+tSZdSSaKOruGrGzj4OWCBoHwhgV19APc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RzMkbrck; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RzMkbrck"
Received: (qmail 113865 invoked by uid 106); 12 Jun 2026 05:16:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=31aBcqoghjOygWiotfUZtSiMwiTE6Axfkg09yc0AS0Q=; b=RzMkbrcku1jO9UeiMZR7hQ+ju4hBVK00GyX9louorFJVLFM5sd9QpNtYZMGT9rIPzs4tGq9uoX6OERKgYOzoz9Dg0NqXyCAJbXizFvupPv9lC8xdX5Qn5VCTMMDHOekmQLlxQLDpUJK6GnlyQ3VOxDVYcvyGkaf48+DEKLt0VdxaNPH99eRBaAXnjjAXpKJMoUwvU4xGkviOxZttF74s4OJ2cAhldIC2O2iTZCY9mIz1dQsg5aqT5JNzG4s/Y7SABBl9Ig/0R/u2bwi7pq2qSHtkAaSm69+1MI2dJzRiX52FLprQHOxrlNR6VhLHwRVI8Qn1kTTqskcnhpohI+zPcQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Jun 2026 05:16:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 333841 invoked by uid 111); 12 Jun 2026 05:16:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Jun 2026 01:16:10 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 12 Jun 2026 01:16:05 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: Tuomas Ahola <taahol@utu.fi>, git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] doc: git-config: escape erroneous highlight markup
Message-ID: <20260612051605.GB593075@coredump.intra.peff.net>
References: <20260610185148.23920-1-taahol@utu.fi>
 <20260611062423.GA2189088@coredump.intra.peff.net>
 <20260611062525.GB2189088@coredump.intra.peff.net>
 <5106812.31r3eYUQgx@piment-oiseau>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5106812.31r3eYUQgx@piment-oiseau>

On Thu, Jun 11, 2026 at 10:43:44PM +0200, Jean-Noël AVILA wrote:

> Oh, this is the black magic regexp that is not considering # for keyword
> character. Should be solved by something like (and I really hate these .in 
> files):

Your patch looks reasonable to me, but for some reason I get this
doc-diff output when comparing before/after (what we don't see is the
improved output from bolding those chars, since doc-diff doesn't show
any markup):

diff --git a/73bccdb573fbdf3df4abf37570be486fc0f53d4a/home/peff/share/man/man1/git-config.1 b/926d9be4ab7ee1a57d4c570ec0f8aba28b3c2af5/home/peff/share/man/man1/git-config.1
index b77d79f..b2bced2 100644
--- a/73bccdb573fbdf3df4abf37570be486fc0f53d4a/home/peff/share/man/man1/git-config.1
+++ b/926d9be4ab7ee1a57d4c570ec0f8aba28b3c2af5/home/peff/share/man/man1/git-config.1
@@ -6983,7 +6983,7 @@ CONFIGURATION FILE
 
      status.displayCommentPrefix
          If set to true, git-status(1) will insert a comment prefix before each
-         output line (starting with core.commentChar, i.e. # by default). This
+         output line (starting with core.commentChar, i.e.  # by default). This
          was the behavior of git-status(1) in Git 1.8.4 and previous. Defaults
          to false.

And I can see the extra space when looking at the rendered manpage. The
XML output looks reasonable, though:

  (starting with <literal>core.commentChar</literal>, i.e. <literal>#</literal> by default

as does the HTML. So perhaps it is happening at the roff level? But that
looks like:

  will insert a comment prefix before each output line (starting with
  \fBcore\&.commentChar\fR, i\&.e\&.
  \fB#\fR
  by default)\&. This was the behavior of

So...weird. groff wants to add extra space for some reason. It happens
even if I drop the bolding, and just have "#" on a line by itself. I
guess maybe it is the trailing "." of the previous line putting groff
into "oh, I'm starting a new sentence" mode and it uses two spaces.

But I think that is all outside the scope of your fix, and this is an
existing issue that we are now just unlucky enough to hit. I'd be
tempted to ignore it and possibly fix it later.

-Peff

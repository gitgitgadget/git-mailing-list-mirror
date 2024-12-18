Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD56165F16
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734521618; cv=none; b=GpiajQh9E19/bvPMihVJiPqNlNNKUvIfPLc5qjvOj/zsda5CyvLCssNZgMeCPwf90WFIV2LByADt7mWuvUTWOtaMD8IdGZcc8Qqy8MIoL6Zfm0VHlgOio39H03QZIdPdtq2NuEeqvcyAQf7omQfq+U+YCh02h6Ijxmk7wuG6o9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734521618; c=relaxed/simple;
	bh=4AwrV6gVESuRlprmW2lApfUuLZWuPzXUmSphn0zT0h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW5q57uBkvKzLTkaAFEOng+YOnnEyYkv5KxIfHbaFJLgluBIyaQF1H0/UiPfWufToCPXifA1MYiG6xVRPAkaNR+BPgD2s34Xjo+Ohv4hXrng/rDMTsvKHgMhLhVnqoalVsTwG6qMsXKhjDI+yN+z4XYGn4ybgskxAE7X3243B0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=V+7Cs8p+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="V+7Cs8p+"
Received: (qmail 5689 invoked by uid 109); 18 Dec 2024 11:33:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4AwrV6gVESuRlprmW2lApfUuLZWuPzXUmSphn0zT0h0=; b=V+7Cs8p+b5mIwZUqhxCXaJuLbQImN7sfVTth7c7v8Mm5EFm6/Z7zCv0+6OsTurG/FqaxPWGnaSaxq3hvmHc8ZjOL8BFILcZkNP0noFZeQPEJ3PDOEGNcpQ6IsYPJ5ijfJleS+hDB/3paRKO35x/lIiw3RcV6zseEvEbts6ZukH5AoNhFqskSs3TCy3jw92ZGb4YRxme26U+dPKG3c4csWi+gcdp6cpjDnaLdlrlVjXeXUR9pKvAfJCec735CO692ry8y5Cw8Gnf1GfEuIsYzbMxWDpBv2oAZ1rDDfrrhRwtscFGt+HqpNoQV2/FXIGDGuX5zal10p7WKb+uF4H0sfg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Dec 2024 11:33:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24377 invoked by uid 111); 18 Dec 2024 11:33:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Dec 2024 06:33:25 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 18 Dec 2024 06:33:24 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Kyle Lippincott <spectral@google.com>
Subject: make GIT_VERSION=foo broken, was Re: [PATCH v2] doc: remove extra
 quotes in generated docs
Message-ID: <20241218113324.GA594795@coredump.intra.peff.net>
References: <pull.1847.git.git.1734479267736.gitgitgadget@gmail.com>
 <pull.1847.v2.git.git.1734483422181.gitgitgadget@gmail.com>
 <xmqqbjx9yedb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbjx9yedb.fsf@gitster.g>

On Tue, Dec 17, 2024 at 05:22:08PM -0800, Junio C Hamano wrote:

> > -<refmiscinfo class="source">Git 2.47.1.409.g9bb10d27e7</refmiscinfo>
> > -<refmiscinfo class="manual">Git Manual</refmiscinfo>
> > +<refmiscinfo class="source">'Git 2.47.1.410.ga38edab7c8'</refmiscinfo>^M
> > +<refmiscinfo class="manual">'Git Manual'</refmiscinfo>^M
> >  </refmeta>
> >  <refnamediv>
> >      <refname>git-bisect</refname>
> > ```
> 
> Thanks for filling the blanks in ;-)
> 
> The above differences however seem to be absorbed before these
> strings reach git-bisect.1 by the documentation toolchain;
> Running Documentation/doc-diff with --asciidoc or --asciidoctor
> options do not show the difference in single quotes.

Hmm. I thought that might be because we override the version and date
strings in doc-diff to prevent extra output. But it seems that was
broken by the same commit. Try:

  ./doc-diff a38edab7^ a38edab7

and you'll get a bunch of:

-Git omitted                        1970-01-01                        GIT-ADD(1)
+Git 2.47.1.410.ga                  2024-12-06                        GIT-ADD(1)

diffs which show the breakage starting (and after that, you get further
changes as each version changes by one commit).

The override is done by setting GIT_VERSION on the make command line.
And indeed, it seems like:

  make GIT_VERSION=foobar

no longer has any effect. That could be a problem for packagers, as
well, if they try to inject a custom version string (e.g., to represent
the upstream version plus their patches). I don't know if anybody does
that, though.

The root of the problem is that we used to generate GIT-VERSION-FILE and
source it as a Makefile snippet. That let the usual Makefile precedence
rules override what was in the file. But after that commit, we use the
script to directly generate the version _and_ replace the contents of
asciidoc.conf, etc.

I think the workaround here would be to manually override asciidoc's
config like this:

  make ASCIIDOC='asciidoc -amansource="Git omitted" -arevdate=1970-01-01'

But besides being horrible, I think that only works because asciidoc
gives us a layer of indirection. The same problem exists for the
built-in version-def.h. Try this:

  $ git checkout v2.47.0
  $ make GIT_VERSION=super-secret
  [...]
  $ bin-wrappers/git version
  git version super-secret

  $ git checkout v2.48.0-rc0
  $ make GIT_VERSION=super-secret
  [...]
  $ bin-wrappers/git version
  git version 2.48.0.rc0

I wondered if this would also leak out over the network via the agent
string, but it doesn't seem to. I think because GIT_USER_AGENT is
handled specially in the script; we accept the value from the
environment and only default it to git/$GIT_VERSION.

Perhaps the script should be doing the same for GIT_VERSION itself,
along with GIT_DATE?

-Peff

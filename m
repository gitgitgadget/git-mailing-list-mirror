Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BED262A6
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 03:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759462898; cv=none; b=rYW9Ifo4MsToZ8lD+tXlZYmN16WCJXr05txPGN4g2oPBMPKd6CQDLe8H6hDLw7OBK+cp3tIwfVM7rXburo5lp8JZIEhzp0yToM7Bydx9v8gJD8xb/aP/XLZtmztb2YGElrPb9PfILSGxI4YkyUv4qfHBVeF7wd2m1nE10RrZUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759462898; c=relaxed/simple;
	bh=yLKDKArDJnLj4m30OOJkoNmA1mCed64pb0KtjcXIaHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSSep10AxFVF0GaYAzLPwM0bog/jiFBRzGR34ThELrFHIHvsFydNnwS+ymCr5c2fKXCDeipWrADrfHTHNecJul5j1rZ0rZlg+or11I2PZtAFch/ts9jvKJrqhgixc/tDKSxA7UtA5rheTFGEJelLjUEaYblOTJAyclUFAu/ZHrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Q6+rttI8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Q6+rttI8"
Received: (qmail 112540 invoked by uid 109); 3 Oct 2025 03:41:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=yLKDKArDJnLj4m30OOJkoNmA1mCed64pb0KtjcXIaHE=; b=Q6+rttI8QWebvk87K2EUK/Zti8Gxv+Mk1yimtK9Qq14aCdR0RHMqZz1ZBv7B5GnxIoLyv7P9WmVatVK04RSidcJZf/I6VfdD3V6/joTmZ4popnb0QNRpzojjT0jifgflQvwRdDItrdP065xaRUTcHrdeMBkVfe6lZv1Ds1IHgu4GMR8Blk6wrek3c3ZGFQ/ofNCSFm7S9jNQVGoRlooFgAc4sY3n57ymBj/VTU8wvApx7IId5veLE34z1HudrDcMo2RDbmWrMD2oug2ZaupJ8hfRgRIVbc8JcDk2rwNxeSF3g2XHX8VaEg+WsAHjQXr9xh6aUhGczyCLExVp6GblHQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Oct 2025 03:41:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 161832 invoked by uid 111); 3 Oct 2025 03:41:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Oct 2025 23:41:34 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Oct 2025 23:41:34 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] doc: change the markup of paragraphs following a
 nested list item
Message-ID: <20251003034134.GA625140@coredump.intra.peff.net>
References: <xmqq5xd5aqa5.fsf@gitster.g>
 <20250927195032.37223-1-jn.avila@free.fr>
 <20251003031113.GA6381@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251003031113.GA6381@coredump.intra.peff.net>

On Thu, Oct 02, 2025 at 11:11:14PM -0400, Jeff King wrote:

> which I think is wrong? Looking at the end result with more context, it
> is:
> 
>              refStorage
>                  Specify the ref storage format to use. The acceptable
>                  values are:
>   
>                  •   files for loose files with packed-refs. This is the
>                      default.
>   
>                  •   reftable for the reftable format. This format is
>                      experimental and its internals are subject to
>                      change.
>   
>              Note that this setting should only be set by git-init(1) or
>              git-clone(1). Trying to change it after initialization will
>              not work and will produce hard-to-diagnose issues.
> 
> So that "Note that..." paragraph is attached to the refStorage
> definition, and should be indented to the same level as "Specify...".
> 
> Even more interesting, I think asciidoc gets this wrong both before and
> after your patch!

Sorry, this is incorrect. Rendering with regular asciidoc does produce
the right output already.

The patch I showed to drop the extra newline turns that final paragraph
into a continuation of the second bullet point. So it is wrong for both
asciidoc (which is already correct) and for asciidoctor (which indents
too little, but after my proposed patch indents too much).

That's a little hard to parse, so here's my attempt at showing visually.
The rendered output before that final paragraph looks something like
this, with markers 1-3 showing possible indentation levels:

  refStorage
      Specify ...

      •   files ...

      •   reftable ...

  (1) a peer of "refStorage" in the definition list
      (2) a continuation paragraph in the "refStorage" definition
          (3) a continuation paragraph in the second bullet point

The paragraph "Note that..." should be at indentation level 2, and
currently is for both asciidoc and asciidoctor. After your patch it is
unchanged in asciidoc and at indentation level 1 in asciidoctor.

My proposed patch (which is garbage) moves it to indentation level 3 in
both.

I think to appease both systems we need to put the inner bulleted list
inside a block. I think that is OK in this case because there is no
inner block marker to worry about. So:

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 49a7598ca5..aaea8c107f 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -55,8 +55,9 @@ For historical reasons, this extension is respected regardless of the
 refStorage:::
 	Specify the ref storage format to use. The acceptable values are:
 +
+--
 include::../ref-storage-format.adoc[]
-
+--
 +
 Note that this setting should only be set by linkgit:git-init[1] or
 linkgit:git-clone[1]. Trying to change it after initialization will not

on top of your patch seems to do the right thing (no change in asciidoc,
and eliminating the regression from your patch). It's a little gross
because we are reaching across the include to realize that
ref-storage-format.adoc contains a list that needs to go into its own
block. I wonder if asciidoc implicitly opens a new block for an include
but asciidoctor doesn't. But at any rate, this is the only way I could
come up with for both to render correctly.

-Peff

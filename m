Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B512CDA5
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728766517; cv=none; b=qZdlCRsbz+okPRrSEoy88DJIXv5N7g74SxAlxdWTB8E4VqxBj9Zmo/Tl5cgZwpQmAKv9ZIIE0mm6mDxouhOAAco8J/CE890aKm0DUG4tgE8hW8Lu5XG77Mj74SrS1IBQVLslrSVh3CfEYUJTCgN0cItir5pd6pA77ugEQeBMl34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728766517; c=relaxed/simple;
	bh=fSosS/p7Cej/LF+LwoPQiBOomKSdVHbvXANqEBHMCdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObdsEcMmlDlm7ZdyOYxRvubXuRlDKFmz5+G3mD1+66yq1kZynA7xjHoeOZUnT2BKTE61pgdQ77o4Qr4T/ogAMOkZFX6tBk7oXI37uJt1VSedeXTNXrzkt6Lt72WGEoXD/1gk9jXsaE8jacq4ulasduwLmCOZpZwG49KYaRBR3Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OPEBSjYW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OPEBSjYW"
Received: (qmail 11729 invoked by uid 109); 12 Oct 2024 20:55:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=fSosS/p7Cej/LF+LwoPQiBOomKSdVHbvXANqEBHMCdI=; b=OPEBSjYWUdKlATQY6755U9fDEgxHYxWDuKxvMz9mk75AzxpI9bY8f3lT+KIaSj2uXqdLAKftJbgYlY0XnZtOPiTNv4Sk2DstWN3wsHi688LW4SvQu00H5mYtIs7xgpVdISv0OuW5m/l7CIHI283t0ODFGO79qUmIWXwOKHSaZ1mLuZRZaNx3RKZruNNQWqcPXne5GXwJOITFkOVGsbKTUrMp+AHlodRONivDV4C3Ew6hrJ2dLumBEk0qlBPrv6RQ99sSjQ0UqtAFCDGHmsVCS7LK05LYkayC29+VXNJNZ4PKBSYIGpcXLCk8mn5LCKccP+BMLCrwaKDki2JQYFR18g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 12 Oct 2024 20:55:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2219 invoked by uid 111); 12 Oct 2024 20:55:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 12 Oct 2024 16:55:07 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 12 Oct 2024 16:55:06 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?Q?imme=C3=ABmosol?= via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?Q?imme=C3=ABmosol?= <will+developer@willfris.nl>
Subject: Re: [PATCH v3] diff-highlight: make install link into DESTDIR
Message-ID: <20241012205506.GA55242@coredump.intra.peff.net>
References: <pull.938.v2.git.git.1728754230466.gitgitgadget@gmail.com>
 <pull.938.v3.git.git.1728764613835.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.938.v3.git.git.1728764613835.gitgitgadget@gmail.com>

On Sat, Oct 12, 2024 at 08:23:33PM +0000, immeëmosol via GitGitGadget wrote:

> diff --git a/contrib/diff-highlight/Makefile b/contrib/diff-highlight/Makefile
> index f2be7cc9243..a53e09e0bdd 100644
> --- a/contrib/diff-highlight/Makefile
> +++ b/contrib/diff-highlight/Makefile
> @@ -10,6 +10,9 @@ diff-highlight: shebang.perl DiffHighlight.pm diff-highlight.perl
>  	chmod +x $@+
>  	mv $@+ $@
>  
> +install: diff-highlight
> +	test -w $(DESTDIR) && ln -s $(abspath $<) $(DESTDIR)
> +

I'm not opposed to having an install target here, like we do in the main
Makefile and in a few other contrib directories.

But in that case, I think it should behave more like those other
targets:

  1. Actually copy the program rather than making a symlink. Preferably
     using $(INSTALL).

  2. Respect $(prefix) in the usual way.

And also...

>  clean:
> +	test ! -L $(DESTDIR)/diff-highlight || \
> +		$(RM) -f $(DESTDIR)/diff-highlight
>  	$(RM) diff-highlight

  3. It's unusual for "clean" to reach outside of the build directory.
     What you're doing here is more like an "uninstall" target, but we
     don't usually provide one.

There are a few different approaches other contrib/ items take to
work like the rest of the Git:

  - in contrib/contacts, we source config.mak from the top-level, and
    then define a default $(prefix). This gives some repeated
    boilerplate, but is pretty independent from the top-level Makefile.

  - in contrib/credential/netrc, we piggy-back on the top-level
    Makefile's "install-perl-script", which knows where the user has
    asked us to install things. That might not be appropriate here,
    though, as I think it only puts things in libexec/, so
    "diff-highlight" wouldn't be generally available in the user's $PATH
    (though it would be enough to use as a pager within git).

-Peff

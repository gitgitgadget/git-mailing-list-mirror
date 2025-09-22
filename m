Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641FA31B117
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758572047; cv=none; b=GVVU1Qqav8Ug32yqPYRHzcymEpXjbvWhKBl7LEyhzVexoMu8OfVRzd9knYbp9KstRWBXhxuxQ9cnm6vSRai3AF7GE4WYDcP/cwuOaqylvPkYmEsiAEin2TjUS3J7SRrU50HRrW6uzVbOL0pzrhlNiTFQ73iICd4pHr1tL0WjcIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758572047; c=relaxed/simple;
	bh=6XDjta3Ds5V9l+W7retCh+Rh764QPBtwnwlfsmmUYJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxGvbcTMhDdhl8gsAIkop8pfmbIihxrAJnGtgOfxFrMnr2dI6dV/LfxxlkEl5eoK7FO1m5hZ4CdNXnWovyPu3/AMK7+MDKomKVb4uROZlr5ZlnQRf3t9tZa/xtBlgjvsEfMCktQOrySolIz6+JA4fqd+UJsN46jBH/VfIUM1JFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DGpqZadu; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DGpqZadu"
Received: (qmail 162521 invoked by uid 109); 22 Sep 2025 20:14:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=6XDjta3Ds5V9l+W7retCh+Rh764QPBtwnwlfsmmUYJw=; b=DGpqZaduUezQ5XU7AbS+CxEVyGIKtgYvsSROIBy9rWy1d92p1jePnZJNp3PGmS6FFdOs7+aawcq52iTYA6ZMnIjH+OUyTB/7KITYws8+S+LU4JQ6Wmb2fx4ak91QgU6BCjTDSuZHSKw+hAOlCZx8F7Qfdxor8cnueKO1FKvVb3z/mDM6kAMX8cZZTOl0OCVOIh9XQMQ4k+IodMnl2ufeLyfL7wUcdzW1VZdf5lrQM1ApyDwn0sZkBuTnHhngq/53DbjzliddMpFEeKLm7Q4Akw5BPHSXx9Ie77nwQoGlyFCPutodE4eZbHgD1fAMcKMvrATb8/ZD0f/tlxzxVPZ60w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Sep 2025 20:14:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 259808 invoked by uid 111); 22 Sep 2025 20:14:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Sep 2025 16:14:04 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Sep 2025 16:14:03 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?= <velocifyer@velocifyer.com>
Cc: git@vger.kernel.org
Subject: Re: How do i get news of git releases
Message-ID: <20250922201403.GD2205919@coredump.intra.peff.net>
References: <4ea9cb1e-4367-4926-a9ba-0680dd63e616@velocifyer.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ea9cb1e-4367-4926-a9ba-0680dd63e616@velocifyer.com>

On Mon, Sep 22, 2025 at 01:43:31PM -0400, 𝕍𝕖𝕝𝕠𝕔𝕚𝕗𝕪𝕖𝕣 wrote:

> How do i get changelogs for git in a convinent format (like email or RSS or
> Atom)?  I see that i can get changelogs in /Documentation/RelNotes/ but then
> i have to check the folder manually instead of it being in my email and RSS
> and Atom client (Thunderbird).

The Git project doesn't maintain any RSS feeds that I'm aware of.
However, releases are pushed to GitHub (among many other mirrors), and
they do provide feeds. So I think pointing your feed-reader at:

  https://github.com/git/git/releases.atom

would work.

The project doesn't use GitHub's Releases feature specifically, but I
think annotated tags that are pushed to the repo end up there, too. The
resulting feed entries are a little bare. Possibly they could be
populated with the release notes, but from the Git project's
perspective, the GitHub repo is really just a Git mirror. Presumably it
would require some scripting around GitHub's API for the tag pushes to
also create Release entries (and then probably somebody would want the
same for the GitLab mirror, and so on).

I think it may also be a reasonable feature for git-scm.com to have its
own RSS feed. It already has to know about all of the releases (so it
can point to the most recent one, for example). Most of the development
for that site happens at https://github.com/git/git-scm.com. So if you
or anybody is interested in adding the feature, it would probably make
sense to start a discussion there.

-Peff

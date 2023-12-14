Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D97671F8
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8927 invoked by uid 109); 14 Dec 2023 22:12:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Dec 2023 22:12:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11972 invoked by uid 111); 14 Dec 2023 22:12:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Dec 2023 17:12:39 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 14 Dec 2023 17:12:39 -0500
From: Jeff King <peff@peff.net>
To: Andreas Scholz <andr3asr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Question regarding Git updater
Message-ID: <20231214221239.GB3320432@coredump.intra.peff.net>
References: <CAHDWvZyHDbjOnnCYCkfMY+HPWobrcgP6c1kkWFrRgWV4fHED=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHDWvZyHDbjOnnCYCkfMY+HPWobrcgP6c1kkWFrRgWV4fHED=w@mail.gmail.com>

On Thu, Dec 14, 2023 at 05:44:41PM +0100, Andreas Scholz wrote:

> I hope you can help me with answering my question regarding the update
> mechanism for Git after it has been installed.

You may need to be more specific here about how you're installing Git.
The Git project itself does not ship any binary packages at all, let
alone ones that have an update mechanism.

If you're using the Git for Windows installer, it looks like it does
have an auto-update feature:

 https://github.com/git-for-windows/build-extra/blob/15b05c2399f152783d1fe9f167692dd5cd8ae1e1/installer/install.iss#L114

You might get a response on this list from Git for Windows folks, but
there is also a separate Git for Windows list:

  https://groups.google.com/g/git-for-windows

You may be more likely to get a response there, or opening an issue on
the GitHub repo:

  https://github.com/git-for-windows/git

If you're using something else, you may have to ask the specific
packager.

-Peff

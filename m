Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE216C1
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 13:38:44 -0800 (PST)
Received: (qmail 25883 invoked by uid 109); 27 Nov 2023 21:38:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Nov 2023 21:38:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3993 invoked by uid 111); 27 Nov 2023 21:38:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Nov 2023 16:38:46 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 27 Nov 2023 16:38:43 -0500
From: Jeff King <peff@peff.net>
To: "H.Merijn Brand" <linux@tux.freedom.nl>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Fix git-send-email.perl w.r.t. recent Getopt::Long update
Message-ID: <20231127213843.GC87495@coredump.intra.peff.net>
References: <20231124103932.31ca7688@pc09>
 <ZWFaZcgzwEP13geI@archie.me>
 <20231125104211.5b7fe0be@pc09>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231125104211.5b7fe0be@pc09>

On Sat, Nov 25, 2023 at 10:45:22AM +0100, H.Merijn Brand wrote:

> As I am used to PR's by now on all OSS projects I am involved in, or
> use git commits or merges directly on the repo, I *never* use
> format-patch and/or send-email.
> 
> These docs - yes I read them - do not offer a concise cut-n-paste
> example for people like me. In order to have my relative simple patch
> submitted (I already had the PR ready, but that came with a huge
> warning that PR's are not accepted) I did it the way I did it. Now I
> need to read and learn two new commands> I don't think that is very
> user-friendly, but that might be just me.

These days you can use GitGitGadget to submit a PR to the mailing list:

  https://gitgitgadget.github.io/

The PR template mentions this, as well as the "about" text for git/git,
but I won't be surprised if there are other spots that should be updated
to mention it. If you found a message that would benefit from mentioning
it, let us know so we can update it.

Thanks.

-Peff

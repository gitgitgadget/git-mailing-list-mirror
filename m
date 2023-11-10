Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053F3C694
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548464229
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 13:41:27 -0800 (PST)
Received: (qmail 14914 invoked by uid 109); 10 Nov 2023 21:41:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Nov 2023 21:41:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 787 invoked by uid 111); 10 Nov 2023 21:41:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Nov 2023 16:41:28 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Nov 2023 16:41:26 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/3] t: improve compatibility with NixOS
Message-ID: <20231110214126.GB2758295@coredump.intra.peff.net>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699596457.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1699596457.git.ps@pks.im>

On Fri, Nov 10, 2023 at 09:16:56AM +0100, Patrick Steinhardt wrote:

> this is the fourth version of my patch series to improve compatibility
> of our test suite with NixOS.
> 
> Three changes compared to v3:
> 
>     - Switched from `test <expr> -a <expr>` to `test <expr> && test
>       <expr>`.
> 
>     - Improved the commit message to explain why the new
>       runtime-detected paths are only used as a fallback.
> 
>     - Rebased on top of 0e3b67e2aa (ci: add support for GitLab CI,
>       2023-11-09), which has been merged to `next` and caused conflicts.

Thanks, these all look good to me.

-Peff

Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4053C6AF
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE214496
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 13:46:41 -0800 (PST)
Received: (qmail 14968 invoked by uid 109); 10 Nov 2023 21:46:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Nov 2023 21:46:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 838 invoked by uid 111); 10 Nov 2023 21:46:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Nov 2023 16:46:42 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Nov 2023 16:46:40 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Replace use of `test <expr> -o/a <expr>`
Message-ID: <20231110214640.GD2758295@coredump.intra.peff.net>
References: <cover.1699526999.git.ps@pks.im>
 <cover.1699609940.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1699609940.git.ps@pks.im>

On Fri, Nov 10, 2023 at 11:01:11AM +0100, Patrick Steinhardt wrote:

> this is the second version of my patch series that replaces all uses of
> `test <expr> -o/a <expr`.
> 
> Changes compared to v1:
> 
>     - I've expanded a bit on why we want to do these conversions in the
>       first place in the first commit message.
> 
>     - Dropped a needless subshell and added missing quoting while at it.
> 
>     - Explained why we need to decompose the asserts in the second patch
>       into two asserts.

These look OK to me. I mentioned a small nit on the first patch, but I
am OK with ignoring it (and we are reaching diminishing returns
polishing an otherwise trivial series).

-Peff

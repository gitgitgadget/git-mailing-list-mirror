Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7F5FBE7
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4029B2D4F
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:50:54 -0800 (PST)
Received: (qmail 26085 invoked by uid 109); 9 Nov 2023 07:50:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 07:50:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21548 invoked by uid 111); 9 Nov 2023 07:50:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 02:50:57 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 02:50:52 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (Nov 2023, #04; Thu, 9)
Message-ID: <20231109075052.GA2699557@coredump.intra.peff.net>
References: <xmqq34xg5ek3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34xg5ek3.fsf@gitster.g>

On Thu, Nov 09, 2023 at 02:40:28AM +0900, Junio C Hamano wrote:

> * tb/pair-chunk-expect-size (2023-10-14) 8 commits
>  - midx: read `OOFF` chunk with `pair_chunk_expect()`
>  - midx: read `OIDL` chunk with `pair_chunk_expect()`
>  - midx: read `OIDF` chunk with `pair_chunk_expect()`
>  - commit-graph: read `BIDX` chunk with `pair_chunk_expect()`
>  - commit-graph: read `GDAT` chunk with `pair_chunk_expect()`
>  - commit-graph: read `CDAT` chunk with `pair_chunk_expect()`
>  - commit-graph: read `OIDF` chunk with `pair_chunk_expect()`
>  - chunk-format: introduce `pair_chunk_expect()` helper
> 
>  Code clean-up for jk/chunk-bounds topic.
> 
>  Comments?
>  source: <45cac29403e63483951f7766c6da3c022c68d9f0.1697225110.git.me@ttaylorr.com>
>  source: <cover.1697225110.git.me@ttaylorr.com>

Sorry it took me a while to circle back to this topic. I posted a
competing series just now in:

  https://lore.kernel.org/git/20231109070310.GA2697602@coredump.intra.peff.net/

that I think should take precedence (and would require some reworking of
Taylor's patches, so you'd just eject them in the meantime).

-Peff

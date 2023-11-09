Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142B62032C
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447F82D57
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 10:56:44 -0800 (PST)
Received: (qmail 31576 invoked by uid 109); 9 Nov 2023 18:56:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 18:56:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9402 invoked by uid 111); 9 Nov 2023 18:56:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 13:56:44 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 13:56:42 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] contrib/subtree: convert subtree type check to use
 case statement
Message-ID: <20231109185642.GE2711684@coredump.intra.peff.net>
References: <cover.1699526999.git.ps@pks.im>
 <7c54d9070fac15b8f0504251d920d0e1fc1fb1f4.1699526999.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c54d9070fac15b8f0504251d920d0e1fc1fb1f4.1699526999.git.ps@pks.im>

On Thu, Nov 09, 2023 at 11:53:39AM +0100, Patrick Steinhardt wrote:

> The `subtree_for_commit ()` helper function asserts that the subtree
> identified by its parameters are either a commit or tree. This is done
> via the `-o` parameter of test, which is discouraged.
> 
> Refactor the code to instead use a switch statement over the type.
> Despite being aligned with our coding guidelines, the resulting code is
> arguably also easier to read.

Yes, I'd agree that the result is much easier to follow.

-Peff

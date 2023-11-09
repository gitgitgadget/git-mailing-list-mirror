Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28872DDB8
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C149D40
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:36:16 -0800 (PST)
Received: (qmail 25761 invoked by uid 109); 9 Nov 2023 07:36:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 07:36:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21158 invoked by uid 111); 9 Nov 2023 07:36:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 02:36:19 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 02:36:15 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] t: improve compatibility with NixOS
Message-ID: <20231109073615.GC2698227@coredump.intra.peff.net>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699513524.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1699513524.git.ps@pks.im>

On Thu, Nov 09, 2023 at 08:09:47AM +0100, Patrick Steinhardt wrote:

> this is the third version of my patch series to improve compatibility of
> our tests with NixOS.
> 
> Changes compared to v2:
> 
>     - Patch 1: We now check for both httpd and apache2 binaries via
>       PATH.
> 
>     - Patch 1: We're a bit more defensive and will check whether
>       variables are empty before passing them to either `test -d` or
>       `test -x`.
> 
>     - Patch 3: Clarified why PATH is unset.
> 
>     - Patch 3: Instead of writing PATH into the hook we now write it
>       into the `hook-env` configuration file read by Subversion.

Thanks. This looks good to me, modulo a minor shell nit I mentioned in
the first patch.

-Peff

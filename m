Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FAC29CF9
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D94D42
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 09:32:06 -0800 (PST)
Received: (qmail 21895 invoked by uid 109); 6 Nov 2023 17:32:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Nov 2023 17:32:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11920 invoked by uid 111); 6 Nov 2023 17:32:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Nov 2023 12:32:07 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Nov 2023 12:32:05 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] Memory leak fixes
Message-ID: <20231106173205.GD10414@coredump.intra.peff.net>
References: <cover.1699267422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1699267422.git.ps@pks.im>

On Mon, Nov 06, 2023 at 11:45:48AM +0100, Patrick Steinhardt wrote:

> this patch series fixes some memory leaks. All of these leaks have been
> found while working on the reftable backend.

All four look good to me (and the refactoring in 3/4 is very cleanly
done).

-Peff

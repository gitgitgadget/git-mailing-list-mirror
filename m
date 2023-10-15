Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CA0110A
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 03:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE85FD9
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 20:05:01 -0700 (PDT)
Received: (qmail 10292 invoked by uid 109); 15 Oct 2023 03:05:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Oct 2023 03:05:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28420 invoked by uid 111); 15 Oct 2023 03:05:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Oct 2023 23:05:01 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 14 Oct 2023 23:04:58 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH 0/8] t7900: untangle test dependencies
Message-ID: <20231015030458.GA554702@coredump.intra.peff.net>
References: <cover.1697319294.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697319294.git.code@khaugsbakk.name>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 11:45:51PM +0200, Kristoffer Haugsbakk wrote:

> § CI
> 
> The CI failed but it didn't look relevant.
> 
> https://github.com/LemmingAvalanche/git/actions/runs/6518415327/job/17703822606

From a brief look, I think it is that your branch is based on v2.42.0,
which does not contain 0763c3a2c4 (http: update curl http/2 info
matching for curl 8.3.0, 2023-09-15). And the macos CI image has since
been updated to a more recent version of curl.

So yeah, not anything to worry about for your series.

-Peff

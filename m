Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E150F9F3
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B13268D
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:48:32 -0800 (PST)
Received: (qmail 26040 invoked by uid 109); 9 Nov 2023 07:48:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 07:48:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21458 invoked by uid 111); 9 Nov 2023 07:48:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 02:48:36 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 02:48:31 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] t/lib-httpd: dynamically detect httpd and modules
 path
Message-ID: <20231109074831.GA2699305@coredump.intra.peff.net>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699513524.git.ps@pks.im>
 <e4c75c492dd89fd7464db2b3028b2bb9e6addbf8.1699513524.git.ps@pks.im>
 <20231109073250.GA2698227@coredump.intra.peff.net>
 <ZUyMFZ7c9_rlu5lk@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUyMFZ7c9_rlu5lk@tanuki>

On Thu, Nov 09, 2023 at 08:36:53AM +0100, Patrick Steinhardt wrote:

> > Sorry to be a pedant, but I'm not sure if we might have portability
> > problems with "-a". It's an XSI extension, and POSIX labels it as
> > obsolescent because it can create parsing ambiguities.
> > 
> > We do have a few instances, but only in corners of the test suite that
> > probably don't get as much exposure (t/perf and valgrind/valgrind.sh).
> > So maybe not worth worrying about, but it's easy to write it as:
> 
> Yeah, I was grepping for it in our codebase and saw other occurrences,
> so I assumed it was fair game. If we're going to convert it to the
> below, how about I send another patch on top that also converts the
> preexisting instances so that the next one grepping for it isn't going
> to repeat the same mistake?

I would be very happy with that. :)

-Peff

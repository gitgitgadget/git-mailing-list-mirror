Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8942E6101
	for <git@vger.kernel.org>; Sun,  5 Nov 2023 05:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9137F123
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 22:34:51 -0700 (PDT)
Received: (qmail 9930 invoked by uid 109); 5 Nov 2023 05:34:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 05 Nov 2023 05:34:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11318 invoked by uid 111); 5 Nov 2023 05:34:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Nov 2023 01:34:53 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 5 Nov 2023 01:34:48 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: rsbecker@nexbridge.com, Git List <git@vger.kernel.org>
Subject: Re: Request for Help - Too many perl arguments as of 2.43.0-rc0
Message-ID: <20231105051615.GA1515359@coredump.intra.peff.net>
References: <00a101da0e88$778cd3b0$66a67b10$@nexbridge.com>
 <CAPig+cTzWCpmksJm-0M1MfUSeYpWbgMaFNHRSOtAhCsNQigV-g@mail.gmail.com>
 <00c301da0e9d$0d2cb8e0$27862aa0$@nexbridge.com>
 <CAPig+cRG3VWgnwOPWvbW9boUooa6sD9d667wbSUe4_RkcR60vg@mail.gmail.com>
 <00c401da0ea1$b61899c0$2249cd40$@nexbridge.com>
 <CAPig+cQpxRQnhffR8EWWRhqJPmOeOuCE3qsuMcnDyuMLLbTH8Q@mail.gmail.com>
 <20231104134915.GA1492953@coredump.intra.peff.net>
 <CAPig+cTy7Mq1xhTtssoUDpwrCNB_65q4VjK902jOpJ4469_tLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTy7Mq1xhTtssoUDpwrCNB_65q4VjK902jOpJ4469_tLw@mail.gmail.com>

On Sat, Nov 04, 2023 at 08:11:01PM -0400, Eric Sunshine wrote:

> > Hmm. With compilation, we split the audience of "developers" vs "people
> > who just want to build the program", and we crank up the number and
> > severity of warning checks for the former. We could do the same here for
> > tests. I.e., turn off test linting by default and re-enable it for
> > DEVELOPER=1.
> 
> My knee-jerk reaction is that this would move us in the wrong
> direction since it is probable that most drive-by contributors won't
> have DEVELOPER=1 set, yet they are the ones who are likely to benefit
> most from test script linting (which is not to say that it doesn't
> help seasoned contributors, as well).

Yeah, that's a good point. If the linting is not causing frequent
headaches (and I don't think it is), then we are better to leave it on
by default.

-Peff

Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37D62117
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 03:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94881101
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 19:25:14 -0800 (PST)
Received: (qmail 27394 invoked by uid 109); 7 Nov 2023 03:25:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Nov 2023 03:25:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9414 invoked by uid 111); 7 Nov 2023 03:25:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Nov 2023 22:25:15 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Nov 2023 22:25:11 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Joanna Wang <jojwang@google.com>, git@vger.kernel.org
Subject: Re: Bug: magic-less pathspecs that start with ":" not processed as
 expected.
Message-ID: <20231107032144.GA873619@coredump.intra.peff.net>
References: <CAMmZTi-JJ6=Uw_+r50hKMYf34D0NtqXhaA=f+11+wAQBjqA7_g@mail.gmail.com>
 <20231106173133.GC10414@coredump.intra.peff.net>
 <xmqqfs1icvfl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfs1icvfl.fsf@gitster.g>

On Tue, Nov 07, 2023 at 08:29:34AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > PS It took me a while to figure out where we document pathspec syntax. I
> >    wonder if a "gitpathspecs" manpage would make sense, like we have
> >    "gitrevisions".
> 
> Yeah, I came to the same conclusion (should have saved time by
> scanning the mailing list before I started writing my response) and
> wondered where we wrote it down.  The description you found in the
> glossary, as far as I recall, is the authoritative one and looks
> readable, but I agree it is not as discoverable as it should be.
> 
> A simpler and more readable workaround than ":::file" is "./:file"
> by the way ;-)

Oh, indeed. That is much less horrible than ":(literal)". :)

-Peff

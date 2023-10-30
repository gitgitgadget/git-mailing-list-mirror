Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BB1D302
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A129D
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:10:12 -0700 (PDT)
Received: (qmail 1597 invoked by uid 109); 30 Oct 2023 09:10:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Oct 2023 09:10:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9393 invoked by uid 111); 30 Oct 2023 09:10:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Oct 2023 05:10:16 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Oct 2023 05:10:11 -0400
From: Jeff King <peff@peff.net>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: Liam Beguin <liambeguin@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
Message-ID: <20231030091011.GB84866@coredump.intra.peff.net>
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
 <20231027184357.21049-1-five231003@gmail.com>
 <xmqq7cn7obah.fsf@gitster.g>
 <20231028021301.GA35796@coredump.intra.peff.net>
 <20231028032221.GB1784118@shaak>
 <9a1e3e90-3e94-41fa-897d-5c64c4a42871@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a1e3e90-3e94-41fa-897d-5c64c4a42871@gmail.com>

On Sat, Oct 28, 2023 at 07:58:31AM +0100, Andy Koppe wrote:

> > I chose the "a" for "address", but I'm not sold on %aa either.
> > I just couldn't find anything better that wasn't already taken.
> > 
> > What about "a@"?
> 
> Makes sense, and I suppose there's "%G?" as precedent for using a symbol
> rather than letter in these.

This is pretty subjective, but I somehow find "%a@" hard to parse
visually (despite the fact that yes, "%G?" already crossed that bridge).
But I think the real nail in the coffin is your later comment that we
cannot use capitalization to make the raw/mailmap distinction.

> If that's not suitable though, how about "m" for "mail domain"? It also
> immediately follows "l" for "local-part" in the alphabet.

FWIW, that makes sense to me over "a" (though admittedly it is not
really any less vague than "a", so it really might vary from person to
person).

-Peff

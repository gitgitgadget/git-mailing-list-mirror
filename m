From: Jeff King <peff@peff.net>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 14:09:33 -0400
Message-ID: <20160421180932.GB12950@sigill.intra.peff.net>
References: <20160421113004.GA3140@aepfle.de>
 <87lh473xic.fsf@linux-m68k.org>
 <CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
 <CA+55aFzk4rZFdhOjkPDqFC3_tk4BUvx4-STsY2L_tKMH2FxCCA@mail.gmail.com>
 <xmqqvb3aswp0.fsf@gitster.mtv.corp.google.com>
 <CA+55aFwOtyW7zLHdJND=FGBWKBfhQV95RPVRG5gcoRUrtGCrAQ@mail.gmail.com>
 <CA+55aFzYWoeUq3MFgGtELaN-2sEc4j3egsAHZHVzK1CNPOqhKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:09:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atJ2s-0002SQ-9M
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 20:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbcDUSJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 14:09:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:53728 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753918AbcDUSJg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 14:09:36 -0400
Received: (qmail 22251 invoked by uid 102); 21 Apr 2016 18:09:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Apr 2016 14:09:35 -0400
Received: (qmail 11729 invoked by uid 107); 21 Apr 2016 18:09:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Apr 2016 14:09:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Apr 2016 14:09:33 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzYWoeUq3MFgGtELaN-2sEc4j3egsAHZHVzK1CNPOqhKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292139>

On Thu, Apr 21, 2016 at 10:59:52AM -0700, Linus Torvalds wrote:

> That said, I do think that a much bigger conceptual change that
> actually does full traversal and be much more complicated might be the
> only "correct" solution.
> 
> So my patch is just a "improve heuristics" small fixlet rather than
> something optimal.

Yeah, I'd agree with both points. Unless somebody is planning to work on
the bigger change in the near future, your patch is a strict improvement
to the heuristic, and is worth applying.

-Peff

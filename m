From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] doc: document error handling functions and
 conventions (Re: [PATCH 03/14] copy_fd: pass error message back through a
 strbuf)
Date: Tue, 17 Feb 2015 11:05:24 -0500
Message-ID: <20150217160524.GA11186@peff.net>
References: <20141204234147.GF16345@google.com>
 <20141204234432.GA29953@peff.net>
 <CAPc5daW3+8xjG3z3WgOMfqzWJUiPdcN1-FVgVc0fAjH7tgCa4A@mail.gmail.com>
 <20141205000128.GA30048@peff.net>
 <xmqqfvcuq8nu.fsf@gitster.dls.corp.google.com>
 <20141207100755.GB22230@peff.net>
 <xmqqk320mzo7.fsf@gitster.dls.corp.google.com>
 <xmqqd25epw24.fsf@gitster.dls.corp.google.com>
 <54E3632F.20907@alum.mit.edu>
 <xmqq1tlo4jbf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 17:05:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNkeR-0003XP-Gr
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 17:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbbBQQF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 11:05:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:49906 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751713AbbBQQF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 11:05:27 -0500
Received: (qmail 31649 invoked by uid 102); 17 Feb 2015 16:05:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Feb 2015 10:05:26 -0600
Received: (qmail 8604 invoked by uid 107); 17 Feb 2015 16:05:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Feb 2015 11:05:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Feb 2015 11:05:24 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1tlo4jbf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263951>

On Tue, Feb 17, 2015 at 08:03:00AM -0800, Junio C Hamano wrote:

> > Whether or not we decide on a different error-handling convention in the
> > future, it is a fact of life that a good bit of code already uses the
> > "strbuf" convention documented by Jonathan's patch. So I think it is OK
> > to merge it as is. If we change the preferred convention in the future,
> > one part of the change will be to update this file.
> 
> I wasn't sure about "a good bit of code already", but that settles
> it.  Let's take it as-is and see how the code evolves.

I'm not convinced myself after a quick grep. But it's certainly
non-zero, and I think I would rather have the technique documented than
not, so I withdraw my earlier complaints.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] doc: document error handling functions and
 conventions (Re: [PATCH 03/14] copy_fd: pass error message back through a
 strbuf)
Date: Thu, 4 Dec 2014 18:44:33 -0500
Message-ID: <20141204234432.GA29953@peff.net>
References: <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051344.GM6527@google.com>
 <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
 <20141204030133.GA16345@google.com>
 <xmqqy4qnq9m2.fsf@gitster.dls.corp.google.com>
 <20141204234147.GF16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:44:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwg4f-0005lK-1a
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933364AbaLDXoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:44:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:48653 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933119AbaLDXog (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 18:44:36 -0500
Received: (qmail 27044 invoked by uid 102); 4 Dec 2014 23:44:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 17:44:36 -0600
Received: (qmail 10689 invoked by uid 107); 4 Dec 2014 23:44:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 18:44:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2014 18:44:33 -0500
Content-Disposition: inline
In-Reply-To: <20141204234147.GF16345@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260841>

On Thu, Dec 04, 2014 at 03:41:47PM -0800, Jonathan Nieder wrote:

> Junio C Hamano wrote:
> > Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> >> Here's a draft for documentation on that.
> >
> > Thanks; looks reasonable; even if the discussion between you and
> > Peff took us to a slightly different direction than what you
> > described here, the earlier description of long established practice
> > is a welcome addition.
> 
> I think I see what I misunderstood.  Do you mean "even if we settle on
> a different API, this documentation of what you started with should be
> easy to adapt and will make life easier"?
> 
> In other words, did you mean to say that things are still up in the
> air (which I agree with) or that the project has already settled on a
> different direction (which I do not)?

FWIW, that is how I read it (up in the air), and where I thought our
discussion was.

-Peff

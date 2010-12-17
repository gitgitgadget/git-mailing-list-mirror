From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] completion: add missing configuration variables
Date: Fri, 17 Dec 2010 16:04:12 -0500
Message-ID: <20101217210412.GA11745@sigill.intra.peff.net>
References: <1292395613-12859-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <20101215130046.GB25647@sigill.intra.peff.net>
 <alpine.DEB.1.10.1012151931030.25560@debian>
 <20101216042304.GA886@sigill.intra.peff.net>
 <7v7hf8i0lk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 22:04:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PThTU-0006AA-5a
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 22:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199Ab0LQVET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 16:04:19 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35901 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756186Ab0LQVES (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 16:04:18 -0500
Received: (qmail 10481 invoked by uid 111); 17 Dec 2010 21:04:13 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 17 Dec 2010 21:04:13 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Dec 2010 16:04:12 -0500
Content-Disposition: inline
In-Reply-To: <7v7hf8i0lk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163891>

On Fri, Dec 17, 2010 at 12:52:07PM -0800, Junio C Hamano wrote:

> >> > We have color.diff.branch coming soon (I think it is in 'next' now).
> >
> > The "correct" thing to do from a topic branch standpoint is to submit
> > this patch without it as its own topic, submit a patch with just
> > color.diff.branch on top of the other topic, and then the merge
> > resolution will include both sets.
> 
> Perhaps, if we had color.diff.branch ;-).

Urgh. Color.status.branch is what I meant all along.

> >
> > But I'll let Junio decide how meticulous about history he wants to be.
> 
> Well, in this case, probably the right thing to do is to ignore this
> addition to completion as the lowest priority item for now, wait for other
> changes that add or modify the set of configuration variables to land on
> 'master', and then resubmit a single patch.

Sure, that is reasonable to me.

> Yes, merge is wonderful and easy, but it is merely a tool to help
> coordination between developers (the ones who add code to understand new
> variables, the others who add completion to help spell the new variables),
> not a replacement.  And orderly submission of patches that are related and
> have dependencies is a prime example of such coordination.

Well, yes. But on the other hand, they are two totally separate topics;
they just happen to both have a component of "add stuff to config
completion".  And don't you always preach about not holding one topic
hostage by introducing an unnecessary dependency on another?

I don't think it is a huge deal in this case, but Martin's patch could
theoretically be "maint" material (I say theoretically because I didn't
actually check whether any of the added completions were for things not
yet in maint).  Basing it on something in "next", even if you wait until
it's in "master", makes that impossible.

But this is all philosphical wankery. I think any of the solutions is
fine.

-Peff

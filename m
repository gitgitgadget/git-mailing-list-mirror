From: Jeff King <peff@peff.net>
Subject: Re: Fix signal handler
Date: Wed, 3 Feb 2010 05:29:16 -0500
Message-ID: <20100203102915.GA25486@coredump.intra.peff.net>
References: <4B684F5F.7020409@web.de>
 <20100202205849.GA14385@sigill.intra.peff.net>
 <4B689CC5.3000400@web.de>
 <20100202223208.GB18781@sigill.intra.peff.net>
 <4B694DEE.5030207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 03 11:29:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NccU7-0007wR-Be
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 11:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451Ab0BCK3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 05:29:18 -0500
Received: from peff.net ([208.65.91.99]:35068 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932427Ab0BCK3R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 05:29:17 -0500
Received: (qmail 25576 invoked by uid 107); 3 Feb 2010 10:29:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Feb 2010 05:29:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Feb 2010 05:29:16 -0500
Content-Disposition: inline
In-Reply-To: <4B694DEE.5030207@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138827>

On Wed, Feb 03, 2010 at 11:20:30AM +0100, Markus Elfring wrote:

> > I don't think anyone here is much interested in whether there is any
> > sort of guarantee on a particular construct working.
> 
> That is a pity. - I would expect that professional software development
> will build on working specifications instead of potentially undefined
> behaviour.

I think it is simply impractical. It's not that we're ignoring a
specification, it's that there _isn't_ a concrete specification for the
set of systems we're interested in.

> > So to answer your question, I honestly don't know. The code may well
> > be broken on common platforms and it is simply a race condition that
> > has never come up. But I do know that it has not been a common source
> > of bug reports, which makes me not want to spend time investigating
> > it when nobody has demonstrated its incorrectness beyond mentioning
> > a standards document.
> [...]
> I find that programming errors in this area might be hard to identify
> from the outside because resulting race conditions and deadlocks fall
> into the symptom category of heisenbugs, don't they?

Yes, they can be hard to identify from the outside. But if you are
interested in addressing the situation, I am suggesting that the first
step would be to demonstrate that there in fact _is_ a race condition,
and it is not simply some theoretical problem.

-Peff

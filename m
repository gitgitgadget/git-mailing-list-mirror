From: Jeff King <peff@peff.net>
Subject: Re: Has anyone written a hook to block fast forward merges to a
 branch?
Date: Wed, 21 Mar 2012 16:43:33 -0400
Message-ID: <20120321204333.GB15021@sigill.intra.peff.net>
References: <CAJ8P3RCQjh1ehjsihAmu8roC1aeRo=R0sN2Wm0Y4bVk=st4ivw@mail.gmail.com>
 <4F6A3ACA.6050100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Patti <cpatti@gmail.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 21:43:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SASNh-0000o1-AI
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 21:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760361Ab2CUUnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 16:43:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55443
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760337Ab2CUUnf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 16:43:35 -0400
Received: (qmail 26531 invoked by uid 107); 21 Mar 2012 20:43:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Mar 2012 16:43:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2012 16:43:33 -0400
Content-Disposition: inline
In-Reply-To: <4F6A3ACA.6050100@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193616>

On Wed, Mar 21, 2012 at 03:32:10PM -0500, Neal Kreitzinger wrote:

> On 3/21/2012 1:22 PM, Chris Patti wrote:
> >I know there are hooks out there to block various other kinds of
> >change, but I was wondering if anyone had specifically ever written
> >one to block fast forward merges.
> >
> Maybe git-merge --no-ff would also be helpful to "do what you want".

When I wrote my response, I assumed the intent was that people _should_
be using --no-ff, but that he wanted to enforce it via hook during a
push to a central repository.

Reading it again, I'm not sure whether that is the case or not. If not,
the disregard my original response. :)

-Peff

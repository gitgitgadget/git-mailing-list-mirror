From: Jeff King <peff@peff.net>
Subject: Re: GIT_CONFIG - what's the point?
Date: Fri, 1 Apr 2016 08:38:30 -0400
Message-ID: <20160401123830.GB12019@sigill.intra.peff.net>
References: <CAL20dLDQsti1qW7CrrEifPAhPp1snq9r5MgJL+mDwhLqhe6fyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthew Persico <matthew.persico@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 14:38:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alyLd-0003nv-Ea
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 14:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbcDAMie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 08:38:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:42307 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754859AbcDAMie (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 08:38:34 -0400
Received: (qmail 24883 invoked by uid 102); 1 Apr 2016 12:38:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Apr 2016 08:38:33 -0400
Received: (qmail 23967 invoked by uid 107); 1 Apr 2016 12:38:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Apr 2016 08:38:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2016 08:38:30 -0400
Content-Disposition: inline
In-Reply-To: <CAL20dLDQsti1qW7CrrEifPAhPp1snq9r5MgJL+mDwhLqhe6fyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290533>

On Thu, Mar 31, 2016 at 08:54:26PM -0400, Matthew Persico wrote:

> So, what's the point of GIT_CONFIG if only git-config uses it? Or did
> I miss a step?

There isn't a point to it. It's historical cruft that has been left in
to avoid breaking older scripts. The same thing is generally better
accomplished by using git-config's "--file" parameter. We should
probably do a better job of making that clear in the documentation.

Or possibly deprecate it and eventually remove it entirely, as discussed
in:

  http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/1195694/focus=257770

-Peff

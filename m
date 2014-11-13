From: Jeff King <peff@peff.net>
Subject: Re: TTY tests are unnecessarily suppressed under Mac OS
Date: Thu, 13 Nov 2014 16:10:26 -0500
Message-ID: <20141113211025.GA7402@peff.net>
References: <CAO2U3QhB6rSfJn5ODE8-n2XWuBw8BePqDpQbNdx6LyWy=OFbcg@mail.gmail.com>
 <20141113201959.GD3869@peff.net>
 <CAO2U3QjGKYLRNWOWeoxqc_kmsdvhB5yfeRwQPuxTtf8n0XjBGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:10:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp1ey-0001Vm-S9
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 22:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934041AbaKMVK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 16:10:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:40089 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933636AbaKMVK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 16:10:28 -0500
Received: (qmail 16271 invoked by uid 102); 13 Nov 2014 21:10:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 15:10:28 -0600
Received: (qmail 31498 invoked by uid 107); 13 Nov 2014 21:10:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 16:10:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 16:10:26 -0500
Content-Disposition: inline
In-Reply-To: <CAO2U3QjGKYLRNWOWeoxqc_kmsdvhB5yfeRwQPuxTtf8n0XjBGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 09:06:51PM +0000, Michael Blume wrote:

> Can do =)
> 
> uname -r spits out "14.0.0". Is there anything in git's testing library for
> comparing version strings or should I roll my own?

No, there's nothing standard for comparing version numbers. Probably

    test "$(uname -r | cut -d. -f1") -ge 14

sufficient.

-Peff

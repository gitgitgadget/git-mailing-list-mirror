From: Jeff King <peff@peff.net>
Subject: Re: Storing (hidden) per-commit metadata
Date: Sun, 21 Feb 2010 03:52:37 -0500
Message-ID: <20100221085237.GA31189@coredump.intra.peff.net>
References: <1266599485.29753.54.camel@ganieda>
 <1266687636-sup-7641@ben-laptop>
 <32541b131002201057t31fc8a6aydb0942171fe1b8c8@mail.gmail.com>
 <20100221063433.GA2840@coredump.intra.peff.net>
 <alpine.DEB.1.00.1002210945490.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Ben Gamari <bgamari@gmail.com>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 21 10:34:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj7Yb-0003eP-Ci
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 09:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473Ab0BUIwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 03:52:39 -0500
Received: from peff.net ([208.65.91.99]:47132 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579Ab0BUIwj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 03:52:39 -0500
Received: (qmail 9751 invoked by uid 107); 21 Feb 2010 08:52:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 21 Feb 2010 03:52:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Feb 2010 03:52:37 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1002210945490.20986@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140602>

On Sun, Feb 21, 2010 at 09:49:28AM +0100, Johannes Schindelin wrote:

> > If the only problem is that the data is ugly in "git show", then perhaps 
> > we need a "suppress these pseudo-headers" feature for showing logs. It 
> > keeps them easily available for inspection or for --grep, but most of 
> > the time you would not see them.
> 
> Whoa. Even more processing to do for each commit during a "git log" run? 
> You know, other people are working on _accelerating_ git log as we speak!

I think this is premature.  You would not need to pay the price for such
a feature if you were not actually using it. On top of which, as it does
not yet exist, it has not actually been benchmarked. So any complaints
should wait until it is actually implemented.

> And really, while I can understand that the OP wanted to hide the 
> information, I am really against that. For example, when I see a log with 
> git-svn footers, it gives me _additional_ information which I actually 
> like (it tells me where these commits really come from). If they do not 
> need bidirectional, they can skip those footers.

I think it depends on what the information is, which I'm still not clear
on. But most importantly, I think it makes sense to put control of
whether that information is seen in the hands of the user who is
invoking git.

-Peff

PS I tried to keep this message short. Short enough? :)

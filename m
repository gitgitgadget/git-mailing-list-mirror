From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: Learn to set up branch tracking with '--track'
Date: Fri, 6 Feb 2009 09:10:00 -0500
Message-ID: <20090206141000.GC18364@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de> <20090129223308.GB12871@coredump.intra.peff.net> <20090129231715.GA17399@coredump.intra.peff.net> <alpine.DEB.1.00.0901300127450.3586@pacific.mpi-cbg.de> <20090130050925.GA18809@coredump.intra.peff.net> <alpine.DEB.1.00.0901301656290.3586@pacific.mpi-cbg.de> <20090130162258.GA7065@sigill.intra.peff.net> <alpine.DEB.1.00.0901301804030.3586@pacific.mpi-cbg.de> <20090202131611.GB8487@sigio.peff.net> <alpine.DEB.1.00.0902021449370.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 06 15:12:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVRR7-0006vy-89
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 15:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbZBFOKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 09:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753651AbZBFOKE
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 09:10:04 -0500
Received: from peff.net ([208.65.91.99]:35879 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885AbZBFOKD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 09:10:03 -0500
Received: (qmail 22056 invoked by uid 107); 6 Feb 2009 14:10:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 06 Feb 2009 09:10:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2009 09:10:00 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902021449370.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108712>

On Mon, Feb 02, 2009 at 02:52:26PM +0100, Johannes Schindelin wrote:

> > It looks like the consensus is to add a branch.master config section 
> > even when cloning an empty repo. And that should address my concern in 
> > the 99% of cases where people use the default "master" setup. Which kind 
> > of takes away the main use case for this topic.
> 
> From where I sit, the main use would have been:
> 
> 	# <hackhackhack>
> 	$ git init
> 	$ git add .
> 	$ git commit -m initial\ revision
> 	# <hackhackhack>
> 	# <create a repository on repo.or.cz>
> 	$ git remote add origin $URL
> 	$ git push -t origin master

Hmm. True. The "clone empty" fix only affects people who use the "init;
clone empty; push" method. Push-tracking would work for the
"traditional" method you outline above.

So probably it is worth doing the steps I described earlier. I'll throw
it on my todo list, but the priority is not especially high.

> BTW I always wondered if it would make sense to introduce "git commit 
> --init" for the first 3 Git commands.  I use them way too often.

I have noticed that, too, but I think it is because I am constantly
creating test repos to debug git. Regular users don't have the same
problem. :)

-Peff

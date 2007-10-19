From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing
	objects'
Date: Thu, 18 Oct 2007 23:15:35 -0400
Message-ID: <20071019031535.GB9274@coredump.intra.peff.net>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182238470.19446@xanadu.home> <20071019025913.GA9227@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182306300.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:15:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiiKz-00073X-Bg
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756614AbXJSDPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758007AbXJSDPi
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:15:38 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4249 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756371AbXJSDPi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:15:38 -0400
Received: (qmail 8313 invoked by uid 111); 19 Oct 2007 03:15:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 23:15:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 23:15:35 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710182306300.19446@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61625>

On Thu, Oct 18, 2007 at 11:11:26PM -0400, Nicolas Pitre wrote:

> I think we might sidestep the issue entirely by remaining somewhat vague 
> and simply saying "compressing objects" for that phase.  This is the 
> part responsible for the reduction of a Git repository from 3GB down to 
> 200MB anyway.

OK. I liked it a little more specific, but perhaps users really don't
care what's going on. And it seems there is some support of simply
"compressing", so that's probably reasonable.

I think that is going to make the statistics line doubly confusing,
though, since we never even use the word "delta" (or any wacky
verbifications based on it), and then they get a line about numbers of
new and reused deltas.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing
	objects'
Date: Thu, 18 Oct 2007 23:56:47 -0400
Message-ID: <20071019035647.GA18717@coredump.intra.peff.net>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <20071019022154.GY14735@spearce.org> <20071019023425.GB8298@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182251110.19446@xanadu.home> <20071019030749.GA9274@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182312160.19446@xanadu.home> <20071019033228.GA10697@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182340550.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:57:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiiyx-0003hm-AA
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760673AbXJSD4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966505AbXJSD4w
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:56:52 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2285 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966479AbXJSD4u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:56:50 -0400
Received: (qmail 8879 invoked by uid 111); 19 Oct 2007 03:56:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 23:56:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 23:56:47 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710182340550.19446@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61642>

On Thu, Oct 18, 2007 at 11:50:39PM -0400, Nicolas Pitre wrote:

> Maybe we should have a shortcut notation for <ref>@{1}..<ref> instead?
> I end up using that all the time since the fetch result has long 
> scrolled off the screen when I want to look at what was fetched.

I must confess to never using reflogs in that case...for some reason
they just never come to mind. But now that you and Shawn mention them,
there's really no reason to leave the hash..hash for the fetch.

As for a shortcut notation, what about allowing '..' notation inside a
reflog. I.e., <ref>@{a..b} is the same as <ref>@{a}..<ref>@{b}? So you
could perhaps do origin/master@{1..}?

I'm not sure if there are syntactic issues with parsing out the '..' (or
'...') operator.

> > although that URL is almost a line by itself. :)
> It is, therefore I'd skip "Fetching from " entirely.

Yes, I was tempted to suggest that. I think it might need some context,
depending on what comes right before it.

> That looks fine for a push.  I'd say "remote foo -> local bar" for a 
> fetch.

Agreed.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing
	objects'
Date: Thu, 18 Oct 2007 23:07:49 -0400
Message-ID: <20071019030749.GA9274@coredump.intra.peff.net>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <20071019022154.GY14735@spearce.org> <20071019023425.GB8298@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182251110.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:08:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiiDT-0006Cr-HR
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102AbXJSDHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbXJSDHw
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:07:52 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3559 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbXJSDHw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:07:52 -0400
Received: (qmail 8238 invoked by uid 111); 19 Oct 2007 03:07:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 23:07:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 23:07:49 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710182251110.19446@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61623>

On Thu, Oct 18, 2007 at 11:01:02PM -0400, Nicolas Pitre wrote:

> >   - When fetching, one progress meter says "Indexing" which, while
> >     technically true, is almost certainly blocking on "Downloading". In
> 
> I have some WIP for that.

Great, I won't start work on it, then.

> Maybe the "Removing unused objects" should use the common progress 
> infrastructure?  It could even use the delayed interface, just like when 
> checking out files, so no progress at all is displayed when that 
> operation completes within a certain delay.  And the removal of unused 
> objects is usually quick.

Are you volunteering (I think you know the progress code best)?
Otherwise, I will get to it, but probably not tonight.

> But I like the statistics.  They might be pretty handy to diagnoze 
> performance issues on remote servers for example.

They are by far the most useful of the three lines I mentioned, but I
just wonder if they are a bit meaningless and cluttery for light users.
We can always cut the others and see how it looks.

-Peff

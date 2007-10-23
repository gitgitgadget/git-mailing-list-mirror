From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Mon, 22 Oct 2007 23:48:30 -0400
Message-ID: <20071023034830.GA28280@coredump.intra.peff.net>
References: <20071022063222.GS14735@spearce.org> <20071022071644.GA7290@coredump.intra.peff.net> <alpine.LFD.0.999.0710221930330.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 05:48:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkAl4-0000EF-2G
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 05:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbXJWDsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 23:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbXJWDse
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 23:48:34 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3808 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbXJWDse (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 23:48:34 -0400
Received: (qmail 31225 invoked by uid 111); 23 Oct 2007 03:48:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 22 Oct 2007 23:48:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Oct 2007 23:48:30 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710221930330.30120@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62075>

On Mon, Oct 22, 2007 at 07:32:02PM -0700, Linus Torvalds wrote:

> Your patch is better than what used to be there, but
> 
> > -			/* Already picked as a destination? */
> > +			/* Already picked as a source? */
> >  			if (!p->src_dst)
> >  				continue;
> 
> the above is wrong, the whole thing should be dropped (we *want* to be 
> able to re-use sources).

Oops, you're right. I'm not sure what I was thinking.

> Anyway, the set of fixes I sent out earlier included fixing that stupid 
> loop as one of the things.

Looks like you have made some real progress. I'll try to review your
patch tonight, and hopefully make some progress on the inexact case.

-Peff

From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Friendly refspecs
Date: Wed, 23 Apr 2008 14:15:56 +0300
Message-ID: <20080423111556.GB3291@mithlond.arda.local>
References: <alpine.LNX.1.00.0804161126280.19665@iabervon.org> <7vod89pnxx.fsf@gitster.siamese.dyndns.org> <20080422105658.GA11238@sigill.intra.peff.net> <7v63u9zva9.fsf@gitster.siamese.dyndns.org> <20080422200550.GB29313@sigill.intra.peff.net> <7vd4ohy5ym.fsf@gitster.siamese.dyndns.org> <20080423042433.GA3291@mithlond.arda.local> <7v1w4xuni1.fsf@gitster.siamese.dyndns.org> <20080423091606.GC11935@sigill.intra.peff.net> <20080423092144.GA11368@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 13:17:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JocyJ-0003zj-Va
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 13:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbYDWLQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 07:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbYDWLQV
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 07:16:21 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:44550 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750920AbYDWLQU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Apr 2008 07:16:20 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout3-sn1.fre.skanova.net (7.3.129)
        id 47A7885700489FD3; Wed, 23 Apr 2008 13:15:59 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JocxA-0003Nd-NL; Wed, 23 Apr 2008 14:15:56 +0300
Content-Disposition: inline
In-Reply-To: <20080423092144.GA11368@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80211>

Jeff King wrote (2008-04-23 05:21 -0400):

> On Wed, Apr 23, 2008 at 05:16:06AM -0400, Jeff King wrote:
> 
> > > Historically we did not favor one way or another for the general
> > > purpose syntax.  I think Jeff's proposed heuristics to favor
> > > branch if a branch tip is pushed and tag if a tag is pushed makes
> > > sense.
> > 
> > OK, here is a cleaned up patch with tests.
> 
> Oops, I forgot to mention: there is a broken test in t5516 that is
> revealed by this change. The patch below should be applied before the
> DWIM one.

I did some testing and your patches seem to work. I think push refspecs
are frendlier now. :) It's great to see you guys taking users seriously
and working on possible problems. Thanks!

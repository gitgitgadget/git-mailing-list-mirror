From: Jeff King <peff@peff.net>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git
	push --mirror" update mirrors
Date: Mon, 28 Apr 2008 05:11:51 -0400
Message-ID: <20080428091150.GA16209@sigill.intra.peff.net>
References: <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org> <20080427043014.GI29771@spearce.org> <20080427044049.GJ29771@spearce.org> <7vabjflvlh.fsf@gitster.siamese.dyndns.org> <20080427173446.GM29771@spearce.org> <7vy76zf449.fsf@gitster.siamese.dyndns.org> <4814E097.7030407@gnu.org> <20080428012613.GB15121@sigill.intra.peff.net> <48155B7F.8020202@gnu.org> <20080428090948.GC16153@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:13:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqPPf-0002rH-KK
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 11:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484AbYD1JLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 05:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755234AbYD1JLx
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 05:11:53 -0400
Received: from peff.net ([208.65.91.99]:1276 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079AbYD1JLx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 05:11:53 -0400
Received: (qmail 3496 invoked by uid 111); 28 Apr 2008 09:11:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 28 Apr 2008 05:11:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2008 05:11:51 -0400
Content-Disposition: inline
In-Reply-To: <20080428090948.GC16153@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80513>

On Mon, Apr 28, 2008 at 05:09:48AM -0400, Jeff King wrote:

> On Mon, Apr 28, 2008 at 07:07:11AM +0200, Paolo Bonzini wrote:
> 
> > Ah, to do so I always do fetch+gitk+merge (or cherry-pick instead of  
> > merge).  I use "git pull" (without arguments) only when I can blindly not 
> > care about what's on the other side, e.g. because it's Junio who assures 
> > it is good. :-)
> 
> Well, I lied a little; I also use fetch + examine + merge. But the idea
> about arguments holds true for "git fetch".

BTW, I find myself decreasingly using "git fetch" in favor of "git
remote update" which handles fetching from multiple remotes. That seems
to be analagous to what you want with "git push". IOW, maybe instead of
changing the default behavior of "git push" you would be happy with a
"git remote push" which impacted multiple remotes.

-Peff

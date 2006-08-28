From: Jeff King <peff@peff.net>
Subject: Re: Starting to think about sha-256?
Date: Mon, 28 Aug 2006 15:00:58 -0400
Message-ID: <20060828190058.GA5027@coredump.intra.peff.net>
References: <44F1DCB7.6020804@garzik.org> <m31wr1exbf.fsf@defiant.localdomain> <Pine.LNX.4.64.0608271343120.27779@g5.osdl.org> <Pine.LNX.4.63.0608272341330.28360@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0608271522390.27779@g5.osdl.org> <656C30A1EFC89F6B2082D9B6@localhost> <Pine.LNX.4.64.0608281034440.27779@g5.osdl.org> <20060828183252.GC2950@coredump.intra.peff.net> <Pine.LNX.4.64.0608281137530.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Lang <david.lang@digitalinsight.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 28 21:01:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHmM5-0008PD-6k
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 21:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWH1TBB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 15:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWH1TBB
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 15:01:01 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:27348 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750911AbWH1TBA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 15:01:00 -0400
Received: (qmail 4981 invoked from network); 28 Aug 2006 15:00:20 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 28 Aug 2006 15:00:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Aug 2006 15:00:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608281137530.27779@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26175>

On Mon, Aug 28, 2006 at 11:46:39AM -0700, Linus Torvalds wrote:

> Sure. But if you are pulling from an untrusted source, you'd better at 
> least check the result.

I completely agree; however, even discussing "earlier takes precedence"
entails that you are somehow pulling from an untrusted source. I just
wanted to point out that "earlier" does not always mean "more trusted
than the thing you're pulling now" (since it might have just been pulled
earlier, not created or verified by you).

> Anybody who just blindly accepts data from untrusted sources is screwed in 
> so many other ways that the hash attack simply isn't even on the radar.

Agreed.

-Peff

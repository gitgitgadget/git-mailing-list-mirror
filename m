From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Thu, 5 Jun 2008 11:28:53 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806051126060.21190@racer>
References: <200805232221.45406.trast@student.ethz.ch> <200805291737.53291.trast@student.ethz.ch> <20080529185808.GA2140@sigill.intra.peff.net> <200806010241.51464.trast@student.ethz.ch> <20080605014618.GA27381@sigill.intra.peff.net> <7vprqw2t64.fsf@gitster.siamese.dyndns.org>
 <20080605085605.GA16624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 12:31:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Ckm-00073g-W3
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 12:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbYFEKaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 06:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754213AbYFEKaR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 06:30:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:56865 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753223AbYFEKaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 06:30:16 -0400
Received: (qmail invoked by alias); 05 Jun 2008 10:30:14 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp003) with SMTP; 05 Jun 2008 12:30:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EWRQuDbZETburBQVboJC1TFShq3vd2CD8Tl+8Pe
	h+zexiiMCgC9EZ
X-X-Sender: gene099@racer
In-Reply-To: <20080605085605.GA16624@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83896>

Hi,

On Thu, 5 Jun 2008, Jeff King wrote:

> I think there are two extremes here:
> 
>  1. We provide a very limited interface. E.g., you pick a line to 
>     arbitrarily split the hunk.
> 
>  2. We provide a very flexible interface. You get dumped in your editor 
>     with the hunk text, and we try to apply the result. Powerful, but 
>     easy to shoot yourself in the foot.

We have a tradition of giving the users plenty of rope.

And I actually like having the power at my finger tips.  You would not 
believe how I enjoyed using "git add -e" to commit the final version of 
that very patch.

I, for one, will probably use this feature almost exclusively, 
_especially_ since I look at the diffs before committing _anyway_, and I 
cannot count the times when I had to go to another window to fix up a 
stupid debug message or typo.  Now I will do that right away, and be done 
with it.  I can even stash the debug messages for future use!

Ciao,
Dscho

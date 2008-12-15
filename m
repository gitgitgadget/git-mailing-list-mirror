From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] bash completion: remove deprecated --prune from git-gc
Date: Mon, 15 Dec 2008 10:51:46 -0600
Message-ID: <0zFE1s-V9qRpO8jkUYC05iTwrouhwDxFz3yJgo_P3R0KZaGeJ6jKSg@cipher.nrlssc.navy.mil>
References: <200812132008.08543.markus.heidelberg@web.de> <alpine.DEB.1.00.0812141137350.2014@eeepc-johanness> <20081214111213.GA6499@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 15 17:53:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCGhO-0000Lk-4W
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 17:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbYLOQwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 11:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753562AbYLOQwS
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 11:52:18 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52194 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbYLOQwR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 11:52:17 -0500
Received: by mail.nrlssc.navy.mil id mBFGpkmY022749; Mon, 15 Dec 2008 10:51:46 -0600
In-Reply-To: <20081214111213.GA6499@coredump.intra.peff.net>
X-OriginalArrivalTime: 15 Dec 2008 16:51:46.0447 (UTC) FILETIME=[6A7E31F0:01C95ED5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103181>

Jeff King wrote:
> On Sun, Dec 14, 2008 at 11:38:17AM +0100, Johannes Schindelin wrote:
> 
>>> -		__gitcomp "--prune --aggressive"
>>> +		__gitcomp "--aggressive"
>> git gc --prune is deprecated?  That's news to me.
> 
> Check out 9e7d501 (builtin-gc.c: deprecate --prune, it now really has no
> effect, 2008-05-09).
> 
> Which annoyingly has no discussion about _why_ it no longer has an
> effect. But I suspect it has something to do with 25ee973 (gc: call
> "prune --expire 2.weeks.ago" by default, 2008-03-12) by you.

I think the nail in the coffin for --prune was a37cce3b, which preceded
9e7d501. I guess the commit message for 9e7d501 made sense with a37cce3b
as a reference. There was another commit around the same time which
claimed that --prune was deprecated even though it still provided some
functionality, hence the "...really has no effect" part.

I definitely remember that Johannes implemented the gc.pruneExpire
functionality, so his "That's news to me" made me laugh. Thanks for
the chuckle Johannes. :)

-brandon

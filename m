From: Jeff King <peff@peff.net>
Subject: Re: git-fetch will leave a ref pointing to a tag
Date: Tue, 3 Jul 2007 09:59:18 -0400
Message-ID: <20070703135918.GA18597@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0707022207420.4071@racer.site> <20070703032315.7279.qmail@science.horizon.com> <20070703041859.GB4007@coredump.intra.peff.net> <Pine.LNX.4.64.0707031257590.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 15:59:25 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5iua-0007TK-JX
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 15:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbXGCN7W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 09:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754146AbXGCN7W
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 09:59:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1936 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922AbXGCN7V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 09:59:21 -0400
Received: (qmail 18455 invoked from network); 3 Jul 2007 13:59:41 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 3 Jul 2007 13:59:41 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2007 09:59:18 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707031257590.4071@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51493>

On Tue, Jul 03, 2007 at 01:01:49PM +0100, Johannes Schindelin wrote:

> If it is only the test, you can do that by
> 
> 	test $(git merge-base foo bar) = $(git rev-parse foo)

I had thought that calculating the merge base was actually slightly less
efficient in this case, since it will actually find all of the merge
bases (but I could very well be wrong). But really, either should
produce the result effectively instantaneously.

> (which tests if foo is a stricth ancestor of bar). Although in your 
> (linux@horizon.com's) place I would really look at "git log foo.." myself, 
> as peff almost suggested.

Yes. In fact, I find an even more useful operation in that case to be
"gitk foo..." to see "where I'm at" with respect to my changes and
upstream changes.

-Peff

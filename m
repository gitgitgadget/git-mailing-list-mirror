From: Jeff King <peff@peff.net>
Subject: Re: How to remove a specific hunk
Date: Fri, 26 Oct 2007 12:49:26 -0400
Message-ID: <20071026164926.GA21160@coredump.intra.peff.net>
References: <4722036E.5030204@wanadoo.fr> <472207AA.8030100@op5.se> <20071026164207.GB19673@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pascal Obry <pascal.obry@wanadoo.fr>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Oct 26 18:49:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlSNS-0002ZD-3k
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 18:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708AbXJZQt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 12:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754049AbXJZQt3
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 12:49:29 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3116 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753784AbXJZQt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 12:49:28 -0400
Received: (qmail 32098 invoked by uid 111); 26 Oct 2007 16:49:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 26 Oct 2007 12:49:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2007 12:49:26 -0400
Content-Disposition: inline
In-Reply-To: <20071026164207.GB19673@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62429>

On Fri, Oct 26, 2007 at 12:42:08PM -0400, Jeff King wrote:

> That has the side effect of changing the index state. My preferred
> method would be to just excise the hunk from the diff using an editor
> (and this actually has nothing to do with git; you could be using
> diff/patch):
> 
> git-diff file >patch
> # remove every hunk except what you want to cut out
> $EDITOR patch
> git-apply -R patch

BTW, since this is inherently a non-git operation, there are other tools
that some may find friendlier than an editor. Kompare will let you
unapply differences, for example, and I would be shocked if emacs didn't
have some tool for this.

-Peff

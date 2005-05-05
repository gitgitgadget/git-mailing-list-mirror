From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: dangling trees
Date: Thu, 5 May 2005 15:22:07 +0200
Message-ID: <20050505132207.GA18572@xi.wantstofly.org>
References: <20050505141224.A8323@flint.arm.linux.org.uk> <20050505141710.B8323@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 05 15:19:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTgCi-0004ax-2h
	for gcvg-git@gmane.org; Thu, 05 May 2005 15:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVEENWS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 09:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVEENWR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 09:22:17 -0400
Received: from alephnull.demon.nl ([212.238.201.82]:62379 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S262094AbVEENWK
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 May 2005 09:22:10 -0400
Received: by xi.wantstofly.org (Postfix, from userid 500)
	id 1448A2B0EC; Thu,  5 May 2005 15:22:08 +0200 (MEST)
To: Russell King <rmk@arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050505141710.B8323@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 05, 2005 at 02:17:10PM +0100, Russell King wrote:

> > dangling tree c39ae07f393806ccf406ef966e9a15afc43cc36a
> > 
> > The dangling commit is the current head - that's fine.  However,
> > what's this dangling tree?
> > 
> > It appears to have come in from Linus' tree on kernel.org this morning.
> > 
> > (above from cogito 0.8)
> 
> As an additional note, the ID does not correspond with any tags or
> heads:
> 
> .git/refs/heads/master:897f5ab2cd733a77a2279268262919caa8154b9d
> .git/refs/heads/origin:897f5ab2cd733a77a2279268262919caa8154b9d
> .git/refs/tags/v2.6.11:5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c

Those are tag objects.

$ git-cat-file tag 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c | head -3
object c39ae07f393806ccf406ef966e9a15afc43cc36a
type tree
tag v2.6.11-tree


--L

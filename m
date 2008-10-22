From: Fredrik Skolmli <fredrik@frsk.net>
Subject: Re: [PATCH] rebase-i-p: delay saving current-commit to REWRITTEN if squashing
Date: Wed, 22 Oct 2008 17:50:14 +0200
Message-ID: <20081022155014.GD20967@frsk.net>
References: <cover.1224055978.git.stephen@exigencecorp.com> <759654ef1f1781cd2b102e21c6f972b065560398.1224055978.git.stephen@exigencecorp.com> <20081022125149.GA17092@coredump.intra.peff.net> <alpine.DEB.1.00.0810221721370.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Stephen Haberman <stephen@exigencecorp.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 22 17:53:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksfzp-0000Bs-4q
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 17:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbYJVPu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 11:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbYJVPu2
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 11:50:28 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:42913 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbYJVPu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 11:50:27 -0400
Received: from asterix.samfundet.no
	([2001:700:300:1800::f] helo=asterix.frsk.net ident=Debian-exim)
	by cassarossa.samfundet.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1KsfyQ-0006gY-OP; Wed, 22 Oct 2008 17:50:15 +0200
Received: from fredrik by asterix.frsk.net with local (Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1KsfyQ-0007Bj-FM; Wed, 22 Oct 2008 17:50:14 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810221721370.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98881>

On Wed, Oct 22, 2008 at 05:21:53PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 22 Oct 2008, Jeff King wrote:
> 
> > On Wed, Oct 15, 2008 at 02:44:36AM -0500, Stephen Haberman wrote:
> > 
> > > +		if [ "$fast_forward" == "t" ]
> > 
> > This one even fails on my Linux box. :) "==" is a bash-ism.
> 
> Did we not also prefer "test" to "["?

We did.

Documentation/CodingGuidelines, line 51:
    - We prefer "test" over "[ ... ]".

-- 
Kind regards,
Fredrik Skolmli

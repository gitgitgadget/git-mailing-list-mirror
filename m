From: Jeff King <peff@peff.net>
Subject: Re: Adding color to git-add--interactive
Date: Wed, 10 Oct 2007 13:06:21 -0400
Message-ID: <20071010170621.GA5444@coredump.intra.peff.net>
References: <91EBB71E-BB4E-4089-8C33-6B0C4A61223A@steelskies.com> <20071009234020.GA20952@coredump.intra.peff.net> <Pine.LNX.4.64.0710101604350.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 19:07:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iff11-0001sf-LT
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 19:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096AbXJJRGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 13:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755301AbXJJRGY
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 13:06:24 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1601 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754647AbXJJRGY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 13:06:24 -0400
Received: (qmail 13427 invoked by uid 111); 10 Oct 2007 17:06:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 10 Oct 2007 13:06:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2007 13:06:21 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710101604350.4174@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60521>

On Wed, Oct 10, 2007 at 04:06:09PM +0100, Johannes Schindelin wrote:

> I think the reason git-add--interactive does not use it is that some 
> people (me included) experienced heavy problems with perl modules.  
> However, I do not recall to which extent they have been solved.  I guess 
> when git-add--interactive goes Git.pm and stops working for me, I'll do my 
> famous "aargh, I'll just make it a builtin" song.

I had thought this was the case, too (and in fact, I started to write
"we don't have a good solution for sharing perl code"), but it looks
like git-remote, git-svn, and git-send-email are all using Git.pm these
days.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 30 Jan 2009 09:35:21 -0500
Message-ID: <20090130143521.GA31673@coredump.intra.peff.net>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de> <4982A99C.6070301@viscovery.net> <20090130073415.GA27224@coredump.intra.peff.net> <alpine.DEB.1.00.0901301421170.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 15:36:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSuUH-0007gh-7y
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 15:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbZA3OfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 09:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753475AbZA3OfZ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 09:35:25 -0500
Received: from peff.net ([208.65.91.99]:53158 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609AbZA3OfY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 09:35:24 -0500
Received: (qmail 1978 invoked by uid 107); 30 Jan 2009 14:35:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Jan 2009 09:35:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2009 09:35:21 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901301421170.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107826>

On Fri, Jan 30, 2009 at 02:23:02PM +0100, Johannes Schindelin wrote:

> > On the other hand, you also missed the boat on receive.denyDeletes and
> > receive.denyNonFastForwards.
> 
> The idea with these is that they are _booleans_, and therefore
> 
> 	[receive]
> 		denyDeletes
> 
> is something natural to write, because "denyDeletes" is _not_ the default.
> 
> However, with denyCurrentBranch we wanted to change the default in the 
> long run, so I agree it was a not-so-brilliant choice.

Good point. I do agree that allowCurrentBranch would have been a better
name, but I don't know that it is worth the pain now of adding new
config plus supporting the old name forever.

-Peff

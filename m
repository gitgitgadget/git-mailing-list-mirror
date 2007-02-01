From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tone down the detached head warning
Date: Wed, 31 Jan 2007 22:00:30 -0500
Message-ID: <20070201030030.GA1979@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home> <20070131231942.GB31145@coredump.intra.peff.net> <Pine.LNX.4.64.0701311907500.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cworth@cworth.org, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 01 04:00:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCSBj-0005GU-61
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 04:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161291AbXBADAd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 22:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933385AbXBADAd
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 22:00:33 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4487 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933383AbXBADAd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 22:00:33 -0500
Received: (qmail 31800 invoked from network); 31 Jan 2007 22:00:30 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 31 Jan 2007 22:00:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Jan 2007 22:00:30 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701311907500.3021@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38320>

On Wed, Jan 31, 2007 at 07:11:34PM -0500, Nicolas Pitre wrote:

> No.  This is misleading.
> 
> You are _not_ on the remote tracking branch.  You just happen to have 
> checked out a commit that came from a tracking branch, but you are still 
> detached from any branch at that point.

Sure, but that is a very subtle distinction that I doubt will make sense
to git newbies. Having them check out what they consider to be a branch
(and which is, in fact, a line of development -- just not one that you
have locally marked as a head) and responding with "you are not on ANY
branch" is a little off-putting.

Is there some text we can use that makes more sense in all situations?

I think part of the "scariness" of the message is that git-checkout does
not _usually_ produce output. I wonder if, when switching HEAD, it
usually printed "Now on branch <foo>", and for detached printed some
special variant, it would seem more natural.

-Peff

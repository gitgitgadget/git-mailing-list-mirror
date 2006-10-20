From: Jeff King <peff@peff.net>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 10:31:11 -0400
Message-ID: <20061020143111.GB17497@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca> <8764eg2qaa.wl%cworth@cworth.org> <20061019171409.GA31671@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 16:31:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GavP6-00084U-MX
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 16:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWJTObP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 10:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWJTObP
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 10:31:15 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:58320 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750812AbWJTObO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 10:31:14 -0400
Received: (qmail 26909 invoked from network); 20 Oct 2006 10:31:12 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 20 Oct 2006 10:31:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Oct 2006 10:31:11 -0400
To: "J. Bruce Fields" <bfields@fieldses.org>
Content-Disposition: inline
In-Reply-To: <20061019171409.GA31671@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29477>

On Thu, Oct 19, 2006 at 01:14:09PM -0400, J. Bruce Fields wrote:

> > > In the second place, one must consider the "nuclear launch codes"
> > > scenario.
> > Sure. And git does provide tools that can do this.
> 
> So in this case you can certainly lose the launch codes.  But you have
> forever granted everyone a way to determine whether a given guess at the
> launch codes is correct.  (Again, assuming some stuff about SHA1).

In what sense? Yes, you can make a guess if you have stored the SHA1
that contained the launch codes. But the point is that that particular
SHA1 is no longer part of the repository. Keeping that SHA1 is no easier
than just keeping the launch codes in the first place.

-Peff

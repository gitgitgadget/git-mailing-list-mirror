From: Jeff King <peff@peff.net>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 11:43:05 -0400
Message-ID: <20061020154305.GA29966@coredump.intra.peff.net>
References: <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca> <8764eg2qaa.wl%cworth@cworth.org> <20061019171409.GA31671@fieldses.org> <20061020143111.GB17497@coredump.intra.peff.net> <20061020153323.GA12886@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 17:43:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GawWf-0005Co-S4
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 17:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946450AbWJTPnK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 11:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946452AbWJTPnK
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 11:43:10 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:28394 "HELO
	peff.net") by vger.kernel.org with SMTP id S1946450AbWJTPnI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 11:43:08 -0400
Received: (qmail 370 invoked from network); 20 Oct 2006 11:43:06 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 20 Oct 2006 11:43:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Oct 2006 11:43:05 -0400
To: "J. Bruce Fields" <bfields@fieldses.org>
Content-Disposition: inline
In-Reply-To: <20061020153323.GA12886@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29495>

On Fri, Oct 20, 2006 at 11:33:23AM -0400, J. Bruce Fields wrote:

> Well, I thought the discussion was about what meaning references have
> after branches were modified or removed.  In which case the interesting
> situation is one where an object is gone but someone somewhere still
> holds a reference (because the SHA1 was mentioned in a bug report or an
> email or whatever).

Git tries very hard to make sure you don't have a reference to something
that doesn't exist. But yes, you could have a reference to the SHA1 in
another, non-git source, and try to guess the data from it. However,
there's a bit of a two-step procedure, since the SHA1 will likely be of
the commit. You have to guess the commit author, date, message, and
the contents of the rest of the tree to make a correct guess.

In practice I think most "launch code" scenarios are less about
guessable confidentiality, and more about ceasing to publish things you
shouldn't be (like copyright or patent encumbered code).

-Peff

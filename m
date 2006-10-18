From: Jeff King <peff@peff.net>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 17:20:28 -0400
Message-ID: <20061018212028.GC24707@coredump.intra.peff.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca> <200610180057.25411.jnareb@gmail.com> <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org> <20061018053647.GA3507@coredump.intra.peff.net> <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:20:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaIqA-0006PY-2g
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422978AbWJRVUf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422979AbWJRVUf
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:20:35 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:22657 "HELO
	peff.net") by vger.kernel.org with SMTP id S1422978AbWJRVUa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 17:20:30 -0400
Received: (qmail 29425 invoked from network); 18 Oct 2006 17:20:28 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 18 Oct 2006 17:20:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Oct 2006 17:20:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29268>

On Wed, Oct 18, 2006 at 07:52:25AM -0700, Linus Torvalds wrote:

> 	git send origin..
> 
> and that "origin" is what the other end is expected to already have.
> 
> Of course, if you send an unconnected bundle (ie you give an origin that 
> the other end _doesn't_ have), you're screwed.

OK, that was how I was envisioning it, as well, but I was concerned
about the "screwed" part. But I'm not sure how often that would be an
issue in practice (after all, patches require some matchup of the base,
though not as strict as SHA1s).

Thanks for the explanation.

-Peff

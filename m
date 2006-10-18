From: Jeff King <peff@peff.net>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 02:33:08 -0400
Message-ID: <20061018063308.GB3507@coredump.intra.peff.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <Pine.LNX.4.63.0610170128350.14200@wbgn013.biozentrum.uni-wuerzburg.de> <4534656B.7080105@utoronto.ca> <20061017062341.8a5c8530.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 08:33:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga4zV-0008KL-Io
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 08:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWJRGdM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 02:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWJRGdM
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 02:33:12 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:30674 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750747AbWJRGdL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 02:33:11 -0400
Received: (qmail 30663 invoked from network); 18 Oct 2006 02:33:08 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 18 Oct 2006 02:33:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Oct 2006 02:33:08 -0400
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061017062341.8a5c8530.seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29195>

On Tue, Oct 17, 2006 at 06:23:41AM -0400, Sean wrote:

> The "bzr missing" command sounds like a handy one.  
> 
> Someone on the xorg mailing list was recently lamenting that git does not
> have an easy way to compare a local branch to a remote one.  While this
> turns out to not be a big problem in git, it might be nice to have such
> a command.

What's wrong with:

  git-fetch
  gitk master...origin

The git model is to do operations on local refs and objects, so the
fetch is a natural part of that. The only downside I see is that you
actually end up fetching the data rather than simply peeking at where
the remote is. But a useful comparison will include at least grabbing
the commit objects, and probably the tree objects (to do diffs) anyway.

-Peff

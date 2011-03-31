From: Jeff King <peff@github.com>
Subject: Re: GSoC questions
Date: Thu, 31 Mar 2011 15:31:28 -0400
Message-ID: <20110331193128.GE16981@sigill.intra.peff.net>
References: <AANLkTinTM8hQpcahGgDyB4UJvGbdN0xyp65wL5PDQGKa@mail.gmail.com>
 <20110328001152.GA11294@elie>
 <AANLkTikGb1=Rtz-T9p=u+X32KpL2AXq0AELdSJ2NMHrW@mail.gmail.com>
 <AANLkTink4wVb6O+yVm=HUh_s1GhKhyL4baqYGe=XFu04@mail.gmail.com>
 <AANLkTinZ2zbhCRAqAYkiAa1=K8aUhcAuEe6Q_gO-v2h_@mail.gmail.com>
 <AANLkTi=TOYOj2HWzy62G24Kg=NZC5X1=psA3GDhaH3Hc@mail.gmail.com>
 <AANLkTikMsQHL9RMm=uOse+OObavMNc=PJE7aOqA-WMkY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vincent van Ravesteijn <vfr@lyx.org>,
	Vicent Marti <vicent@github.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	libgit2@librelist.org
To: Alexandru Sutii <sutii.alex@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:31:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Nai-0000M0-9f
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 21:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759243Ab1CaTbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 15:31:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60687
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759051Ab1CaTba (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 15:31:30 -0400
Received: (qmail 2028 invoked by uid 107); 31 Mar 2011 19:32:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Mar 2011 15:32:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2011 15:31:28 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikMsQHL9RMm=uOse+OObavMNc=PJE7aOqA-WMkY@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170524>

On Thu, Mar 31, 2011 at 09:34:15PM +0300, Alexandru Sutii wrote:

> > Maybe I'm aiming at too much here. It could well be that it is worth
> > writing the minimal git client to just be able to test libgit2 using
> > the git tests. Does anyone want to comment ?
> 
> Hello!
> 
> There have been a lot on discussions on the mailing list regarding
> on what this client should look like and I understand that we are
> expected to come with a specific approach. Also I understand there is
> no interest for this project to become large.

It's OK if the project is large; it's inherently a big thing. But it's
important to bite off a small enough, useful chunk of it and work on
that. One, because you want something small enough to finish in the GSoC
time-frame. But two, because a small, solid start on a larger project is
much more useful to the community as a whole than a larger chunk that is
not-so-solid. Because people in the community (and you, if you want to
keep working on it!) may pick up the project from its state at the end
of the summer.

> Considering this circumstances I think we should implement the client
> with the basic commands by reusing git's high level code. I am for building
> it independently of the git's mainstream.

Yeah, I had always assumed it would build independent of git's
mainstream.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: git version statistics
Date: Fri, 1 Jun 2012 04:52:11 -0400
Message-ID: <20120601085211.GB32340@sigill.intra.peff.net>
References: <20120531114801.GA21367@sigill.intra.peff.net>
 <981b755b-ca86-4320-a4fc-8aa28caa099d@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 10:52:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaNar-0004yT-Sg
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 10:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758290Ab2FAIwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 04:52:21 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39646
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754446Ab2FAIwU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 04:52:20 -0400
Received: (qmail 30920 invoked by uid 107); 1 Jun 2012 08:52:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Jun 2012 04:52:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jun 2012 04:52:11 -0400
Content-Disposition: inline
In-Reply-To: <981b755b-ca86-4320-a4fc-8aa28caa099d@mail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198960>

On Thu, May 31, 2012 at 11:20:46AM -0400, Stephen Bash wrote:

> > The interesting thing to me is how spiky it is, and where the spikes
> > fall. I would expect to see a spike around the highest maint release
> > of each major version (so v1.7.8.6, for example, with many fewer
> > installs of v1.7.8.5, v1.7.8.4, and so forth). But that's not what
> > happens.  The most popular v1.7.8.x versions are .3 and .2, and hardly
> > anybody bothered to move to v1.7.8.6.
> 
> I wonder if the spikes correlate with time between releases?  For open
> source projects I tend to download the most recent when setting up a
> new machine (or after encountering a nasty bug), and then not upgrade
> for a while.  So in that mode of operation, releases that are "the
> newest" for the longest would get more users... (though at least on my
> Mac the homebrew project is helping me break the habit and stay more
> up-to-date)

Good point. If you assume that users pick a random day to upgrade or
install and choose the latest version, then you will get a non-uniform
distribution. Because the release dates are non-uniform, their time
spent as the latest is not even. There may also be natural variations in
installations over time (e.g., over holidays).

Here are the release dates for the v1.7.8.x series, as well as the
adjacent master releases:

  v1.7.8   2011-12-02
  v1.7.8.1 2011-12-21
  v1.7.8.2 2011-12-28
  v1.7.8.3 2012-01-06
  v1.7.8.4 2012-01-18
  v1.7.9   2012-01-27
  v1.7.8.5 2012-02-26
  v1.7.10  2012-04-06
  v1.7.8.6 2012-04-26

So .2 and .3 were latest for 9 and 12 days, respectively. However, .4
was also the latest for 9 days (until v1.7.9 came out), but does not
have as many users. So why did nobody bother upgrading to v1.7.8.4?
And why wouldn't v1.7.8 have a spike, since it was at the top for 19
days?

I can see why v1.7.8.5 and v1.7.8.6 are the way they are (they were
never latest, and most people would just install v1.7.9 or v1.7.10
instead).

So I think your theory probably explains some of the data, but not all
(and it seems that most people don't really seem to care about old maint
releases once a new master release is out).

-Peff

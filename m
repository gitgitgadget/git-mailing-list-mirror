From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: t7006 sometimes hangs in cronjobs on OS X
Date: Wed, 09 Feb 2011 13:30:37 -0500
Message-ID: <1297276090-sup-7829@pinkfloyd.chass.utoronto.ca>
References: <201102091538.46594.trast@student.ethz.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 09 20:43:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnFwj-0002yD-Px
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 20:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab1BITnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 14:43:18 -0500
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:42690 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291Ab1BITnR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 14:43:17 -0500
X-Greylist: delayed 4355 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Feb 2011 14:43:17 EST
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:52016 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1PnEoH-0003yH-KM; Wed, 09 Feb 2011 13:30:37 -0500
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1PnEoH-0002Nm-JH; Wed, 09 Feb 2011 13:30:37 -0500
In-reply-to: <201102091538.46594.trast@student.ethz.ch>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166438>

Excerpts from Thomas Rast's message of Wed Feb 09 09:38:46 -0500 2011:

> I have been running a nightly next&pu smoke tester each on RHEL5 and
> OS X.  For quite some time (at least a month), t7006 gets stuck
> randomly (i.e., not every night).  [This has been a bit of a problem
> because it keeps a lot of processes stuck on the machine and eats
> into my ulimit, but that's the case with any stuck process; I'll
> have to think about a good solution to that.]

I'm also seeing this test fail when runing the packaging tools for
OpenCSW.  I haven't had a chance to investigate yet, but manual tests
of the script have run without errors so far.  It's only during the
automated build that it fails.  The automated build is initiated
manually but is run through a Makefile wrapper that will drastically
alter the environment.  Beyond this, I have no further input.  I'm
hoping to spend some time on it in the next few days.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

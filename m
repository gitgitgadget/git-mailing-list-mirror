From: Jeff King <peff@peff.net>
Subject: Re: Subversion developer: svn is for dumb people
Date: Thu, 18 Oct 2007 14:33:53 -0400
Message-ID: <20071018183353.GD11624@sigill.intra.peff.net>
References: <47176CE0.7030609@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 'git' <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 20:34:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiaC7-0000Dc-98
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 20:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757857AbXJRSdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 14:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757206AbXJRSdy
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 14:33:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2024 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753158AbXJRSdx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 14:33:53 -0400
Received: (qmail 4279 invoked by uid 111); 18 Oct 2007 18:33:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 18 Oct 2007 14:33:50 -0400
Received: (qmail 11977 invoked by uid 1000); 18 Oct 2007 18:33:53 -0000
Content-Disposition: inline
In-Reply-To: <47176CE0.7030609@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61554>

On Thu, Oct 18, 2007 at 07:25:36AM -0700, Steven Grimm wrote:

> Okay, my summary is slightly facetious, but that's basically the gist of 
> what he's saying: you should choose Subversion rather than a DVCS because 
> most of your users won't be smart enough to use the better tool.

An interesting point he brings up (which I think is totally bogus) is
(paraphrased): "DVCS systems encourage people to work in isolation and
then patch-bomb the upstream."

But I think it's quite the opposite. He compares two scenarios: in
$DVCS, the user forks, works quietly in their cave for a few weeks, and
then produces a result. With a centralized VCS, the user gets a private
branch, and people keep up with their work as it progresses.

This isn't realistic for two reasons:

  1. Contributors to projects now using DVCS systems _weren't_ using SVN
     or CVS in this way before (presumably because the effort in getting
     private branches set up in a central repository was too much -- if
     I want to hack on a project, I want to do it _now_, not after I
     have gotten approval to use the VCS by the maintainer).  Instead,
     they sat in their cave using primitive tools like 'diff' and
     'patch' until they patch-bombed the upstream.

  2. DVCS systems (well, git, at least) focus on workflows that allow
     for quick communication and code review. Patches are a first-class
     item in git, which means that
       - every change is on the mailing list for review
       - work-in-progress patches are easy to post, easy for reviewers
         to read, easy for reviewers to apply, and, if accepted,
         easy for the maintainer to apply

-Peff

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] filter-branch: update current branch when rewritten
Date: Thu, 18 Oct 2007 20:06:04 -0400
Message-ID: <20071019000604.GM14735@spearce.org>
References: <18197.24051.863751.436705@lisa.zopyra.com> <Pine.LNX.4.64.0710170322000.25221@racer.site> <Pine.LNX.4.64.0710170322400.25221@racer.site> <18199.21729.535096.397497@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 02:06:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IifNe-0004VY-VO
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 02:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbXJSAGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 20:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757810AbXJSAGL
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 20:06:11 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38483 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbXJSAGK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 20:06:10 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IifNA-0006K8-DN; Thu, 18 Oct 2007 20:05:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DE14B20FBAE; Thu, 18 Oct 2007 20:06:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <18199.21729.535096.397497@lisa.zopyra.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61578>

Bill Lear <rael@zopyra.com> wrote:
> On Wednesday, October 17, 2007 at 03:23:10 (+0100) Johannes Schindelin writes:
> >
> >Earlier, "git filter-branch --<options> HEAD" would not update the
> >working tree after rewriting the branch.  This commit fixes it.
> >
> >Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >---
> >
> >	Bill, I hope this clarifies some things for you, too...
> 
> Thanks very much.  I hope so, too.  I'll pull this in to my tree
> when it gets into the git repository (how do I know when that happens,
> or do I just need to pull and inspect?).

This is actually already in my maint branch:

  git://repo.or.cz/git/spearce.git
  http://repo.or.cz/r/git/spearce.git

The best way to know if a given patch has been applied is to just
fetch every so often and look.  But you are also subscribed to
the mailing list and there's usually a weekly "What's in git.git"
and a "What's cooking in git.git" messages sent describing the
recent changes.  Monitoring these can also tell you when it may be
a good time for you to pull in a more recent version.

My last What's in/What's cooking messages were sent out on Monday.
I've got a lot of stuff from folks since then going into my tree
(the above is one of them) so I'll probably wrap up this week with
another set of messages tomorrow.

Of course the maintainer could send an email for every patch that
he/she applies, but the mailing list volume is already quite high.
Junio (and myself) both prefer to not bother responding to accepted
patches when they come from regular contributors, as we know the
regular contributor will be pulling in the near future anyway.

-- 
Shawn.

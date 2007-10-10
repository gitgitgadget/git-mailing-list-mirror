From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [msysGit] Re: [PATCH] git-gui: offer a list of recent repositories on startup
Date: Wed, 10 Oct 2007 04:19:54 -0400
Message-ID: <20071010081954.GT2137@spearce.org>
References: <11917925011987-git-send-email-prohaska@zib.de> <20071007233023.GE2137@spearce.org> <BE872860-40AD-4BBA-BDD5-0EC8CB9AC4B5@zib.de> <20071010073053.GQ2137@spearce.org> <B1EFFED4-1DF7-4A0A-93E2-F21812E7AF6B@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 10:20:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfWng-0007vt-Pl
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 10:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbXJJIUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 04:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbXJJIUA
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 04:20:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38852 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbXJJIT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 04:19:59 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IfWnK-0001W8-Uf; Wed, 10 Oct 2007 04:19:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 081CF20FBAE; Wed, 10 Oct 2007 04:19:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <B1EFFED4-1DF7-4A0A-93E2-F21812E7AF6B@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60482>

Steffen Prohaska <prohaska@zib.de> wrote:
> On Oct 10, 2007, at 9:30 AM, Shawn O. Pearce wrote:
> >
> >The patch below uses a text widget instead and renders each of
> >the repositories as a blue underlined link.
> 
> This is similar to what I had in mind, but was lacking tk knowledge
> to implement it.

Heh.  Tk makes some things easy, assuming you know what you are
doing.  It makes some other things damn near impossible, even if
you do know all of Tk and its internals too.  Anyway, your patches
were a really good start on this and it saved me a lot of time to
just tweak what you already had.  So I really appreciate you taking
the time to work on the first two iterations of this feature.

> I haven't applied your patch but only read through it. Looks good
> to me.

The combined result is now in my `pu` branch on repo.or.cz.
Remember that I freely rebase that branch and any topic in it,
so I might wind up rebasing this topic before I finally merge it
to master.

I have given the change some light testing tonight but want to
beat on it more and also fix the radio button issue you pointed
out before I merge this series of improvements into master.

-- 
Shawn.

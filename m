From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-p4import.py robustness changes
Date: Thu, 14 Jun 2007 23:13:39 -0400
Message-ID: <20070615031338.GB18491@spearce.org>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <200706122347.00696.simon@lst.de> <20070614053538.GA6073@spearce.org> <200706142344.29089.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Fri Jun 15 05:13:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz2Fv-0003Ut-50
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 05:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbXFODNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 23:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbXFODNq
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 23:13:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:32887 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbXFODNp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 23:13:45 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1Hz2Fd-0000dC-Fl; Thu, 14 Jun 2007 23:13:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B2C7F20FBAE; Thu, 14 Jun 2007 23:13:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200706142344.29089.simon@lst.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50233>

Simon Hausmann <simon@lst.de> wrote:
> On Thursday 14 June 2007 07:35:38 Shawn O. Pearce wrote:
> > I do appreciate you taking the time to use filter-branch to try to
> > cleanup this history a bit.  I really had originally planned on
> > pulling your tree through to my fastimport tree and then talking
> > Junio into merging with me.  But after reading through this history I
> > don't want do that, because of the oneline summaries I just pointed
> > out above, and because of the missing SBO.
...
> I have started cleaning up the history even more by reworking the log messages 
> of my commits (git-p4-enhanced-logs branch in fast-export, starting at the 
> last page). Once that is done (I expect that to take a few days) I'll add the 
> missing SOB lines with git-filter-branch and see if I can get an agreement 
> from Han-Wen and Marius for doing the same with their commits (adding the 
> missing lines).

OK.
 
> Would you be willing to reevaluate the situation regarding a merge once that's 
> done?

Absolutely.  I would like to see the git-p4 work in the main tree,
so it is more readily available to users, even though I'm not a p4
user myself.  ;-)

-- 
Shawn.

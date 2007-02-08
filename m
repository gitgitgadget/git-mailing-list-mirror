From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 18:33:24 -0500
Message-ID: <20070208233324.GA1556@spearce.org>
References: <17866.27739.701406.722074@lisa.zopyra.com> <Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org> <17867.40122.51865.575762@lisa.zopyra.com> <Pine.LNX.4.64.0702081408140.8424@woody.linux-foundation.org> <17867.45437.922483.805945@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 00:33:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFIli-0003UV-Ml
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965614AbXBHXd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbXBHXd3
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:33:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39885 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965616AbXBHXd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:33:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HFIlR-0007LM-4A; Thu, 08 Feb 2007 18:33:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DEB1120FBAE; Thu,  8 Feb 2007 18:33:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17867.45437.922483.805945@lisa.zopyra.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39123>

Bill Lear <rael@zopyra.com> wrote:
> With regard to the new version and old repos, am I correct in assuming
> that we can upgrade our old repo (a bare one) to the new git by first
> installing the new git, and then doing this:
> 
> % cd /repos/git
> % mv project project.old_git
> % git --bare clone project.old_git project
> 
> or is there something else we must do?

In the case of a bare repo, there isn't anything to do.

-- 
Shawn.

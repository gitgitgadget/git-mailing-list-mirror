From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 13:22:37 -0500
Message-ID: <20070130182237.GC26415@spearce.org>
References: <17855.35058.967318.546726@lisa.zopyra.com> <epo1tn$9sl$1@sea.gmane.org> <17855.35845.922009.364704@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 19:22:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBxd0-0008KV-Gm
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 19:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbXA3SWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 13:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbXA3SWn
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 13:22:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38070 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030194AbXA3SWm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 13:22:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBxcn-0007xP-GH; Tue, 30 Jan 2007 13:22:33 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 984EA20FBAE; Tue, 30 Jan 2007 13:22:37 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17855.35845.922009.364704@lisa.zopyra.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38182>

Bill Lear <rael@zopyra.com> wrote:
> Ok, well, I certainly did not issue git clone --bare, it was just a
> plain ol' clone:
> 
> % git clone /repos/git/project
> 
> and no checkout ensued.  Can I fix this somehow?  I've tried the clone
> several times with no success.  Is there anything I can check in the
> source repo (the above /repos/git/project) to see why it would not be
> working?

I've seen this happen if HEAD in the source repository does not point
at a branch, or points at a commit which doesn't exist.  Though I
usually also see an error about how HEAD isn't a valid object name...

-- 
Shawn.

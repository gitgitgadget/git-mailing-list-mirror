From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git push failure with update hook success
Date: Wed, 7 Mar 2007 18:09:48 -0500
Message-ID: <20070307230948.GE27922@spearce.org>
References: <17902.59497.831409.218529@lisa.zopyra.com> <17902.60536.5890.608883@lisa.zopyra.com> <20070307170904.GB27922@spearce.org> <17902.62836.920473.810183@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 00:10:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP5Gj-0000Tc-NE
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 00:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965505AbXCGXJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 18:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965731AbXCGXJz
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 18:09:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56497 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965714AbXCGXJw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 18:09:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HP5GP-0006N0-7y; Wed, 07 Mar 2007 18:09:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EE50120FBAE; Wed,  7 Mar 2007 18:09:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17902.62836.920473.810183@lisa.zopyra.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41699>

Bill Lear <rael@zopyra.com> wrote:
> Since it just gets the ref name, would one (of sufficient skill) be
> able to reconstruct the same sort of report that the "pre" update hook
> does?  That is, from the ref name can I get the old SHA-1?  If I try
> to write this, what I think I would like to do is just call the
> existing update hook from the post-update hook, with the post update
> hook figuring out the proper arguments to pass along.

For what its worth, the receive-pack patch series that I posted a
few hours ago creates a new post-receive hook that would be suitable
for generating the report you are looking for.

-- 
Shawn.

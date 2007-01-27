From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: finding earliest tags descended from a given commit
Date: Fri, 26 Jan 2007 23:22:35 -0500
Message-ID: <20070127042235.GA9966@spearce.org>
References: <20070127040618.GA14205@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 05:22:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAf5X-0006fh-OG
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 05:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbXA0EWm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 23:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbXA0EWm
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 23:22:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45948 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbXA0EWm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 23:22:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HAf59-0001A8-O1; Fri, 26 Jan 2007 23:22:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 464A620FBAE; Fri, 26 Jan 2007 23:22:36 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070127040618.GA14205@fieldses.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37916>

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> Just curious: every now and then somebody will ask me what kernel
> version they need to upgrade to to get some given fix.  I can find the
> commit with the given fix easily enough.  How do I then find the
> earliest tagged version containing that fix?

git-name-rev commit?

It should give you not only the tag, but how many commits before
that tag the fix was made.

-- 
Shawn.

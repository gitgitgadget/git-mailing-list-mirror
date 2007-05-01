From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: svn:externals using git submodules
Date: Tue, 1 May 2007 11:22:28 -0400
Message-ID: <20070501152228.GF5942@spearce.org>
References: <200705011121.17172.andyparkins@gmail.com> <20070501150724.GA20797@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Chris Shoemaker <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 17:22:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiuBf-0007ZZ-5O
	for gcvg-git@gmane.org; Tue, 01 May 2007 17:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031030AbXEAPWg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 11:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965709AbXEAPWg
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 11:22:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45840 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965687AbXEAPWf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 11:22:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HiuBM-0003f4-VK; Tue, 01 May 2007 11:22:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C8D1420FBAE; Tue,  1 May 2007 11:22:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070501150724.GA20797@pe.Belkin>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45947>

Chris Shoemaker <c.shoemaker@cox.net> wrote:
> On Tue, May 01, 2007 at 11:21:14AM +0100, Andy Parkins wrote:
> > Hello,
> > 
> > I've done this by hand as a proof of concept I suspect it would need loads of 
> > work in git-svn to do it properly.  However, I thought I'd mention as part of 
> > my "success with submodules" reports.
> 
> For my part, I wonder if it can be simplified somehow; and I suspect
> it doesn't work well with svn:externals that specify a particular
> revision.

Actually that is an interesting point that Chris makes.  Isn't the
svn:externals property revision controlled on the parent directory?
So each change to it is actually recorded in the revision history
of the parent project.  And if every svn:externals URL included the
exact version of the other project to include, aren't svn:externals
then more-or-less like the subproject link support, except they
also include the URL?

-- 
Shawn.

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 19:51:24 -0500
Message-ID: <20070112005124.GC23864@spearce.org>
References: <Pine.LNX.4.64.0701111410420.3594@woody.osdl.org> <20070111223905.GP17999@mellanox.co.il> <Pine.LNX.4.64.0701111452340.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Fri Jan 12 01:51:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Ae0-0001Nl-Ne
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 01:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbXALAvm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 19:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbXALAvm
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 19:51:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42419 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbXALAvl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 19:51:41 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5Add-0007PR-8C; Thu, 11 Jan 2007 19:51:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C03C420FBAE; Thu, 11 Jan 2007 19:51:24 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701111452340.3594@woody.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36646>

On Fri, 12 Jan 2007, Michael S. Tsirkin wrote:
> 
> Weird. I think the system where the tree got corrupted had git 1.4.4.4.

Or maybe it was 1.5.0-rc0g<something>.  git-describe has a bug (but
is patched in pu) that caused it to pick up 1.4.4.4 on master/next/pu
right now due to the 1.4.4.4 maint release being merged back into
master/next/pu after the 1.5.0rc-0 tag was created.

-- 
Shawn.

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix infinite loop when deleting multiple packed refs.
Date: Thu, 4 Jan 2007 22:04:26 -0500
Message-ID: <20070105030426.GD14042@spearce.org>
References: <20070102081709.GA28779@spearce.org> <7vy7oluthy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicholas Miell <nmiell@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 05 04:04:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2fNk-0007IL-1n
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 04:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbXAEDEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 22:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbXAEDEd
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 22:04:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52611 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030306AbXAEDEc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 22:04:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H2fNR-0001D4-2U; Thu, 04 Jan 2007 22:04:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 234E320FB65; Thu,  4 Jan 2007 22:04:27 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7oluthy.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35973>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Nicholas Miell reported that `git branch -D A B` failed if both refs
> > A and B were packed into .git/packed-refs.  This happens because the
> > same pack_lock instance was being enqueued into the lock list twice,
> 
> I do not like this, actually.
[snip]
> In other words, I am suspecting this might be a cleaner fix.

Ack'd.  I like your patch better.

-- 
Shawn.

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] A new merge stragety 'subtree'.
Date: Sat, 17 Feb 2007 04:02:28 -0500
Message-ID: <20070217090228.GG27864@spearce.org>
References: <7vfy95y2n9.fsf@assigned-by-dhcp.cox.net> <20070217084558.GE27864@spearce.org> <7vps89upyl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 10:02:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HILSo-0001E0-F1
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 10:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbXBQJCe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 04:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbXBQJCe
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 04:02:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34348 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965074AbXBQJCd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 04:02:33 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HILSf-0001W3-Fk; Sat, 17 Feb 2007 04:02:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E266920FBAE; Sat, 17 Feb 2007 04:02:28 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vps89upyl.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39978>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Really that isn't too different from a rename detection.
> 
> I know, but I am just lazy.  The match scoring part is very well
> isolated so you or anybody can plug different code there.

Is that a hint that I should code something if I think its better?  ;-)

I'll probably try to code up a competing version of the match code
based on the fun stuff you did not quote, but likely won't get
around to it for at least week.

-- 
Shawn.

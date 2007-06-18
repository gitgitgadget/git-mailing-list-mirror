From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: merging git-p4 into git/fastimport.git (second try)
Date: Mon, 18 Jun 2007 19:00:18 -0400
Message-ID: <20070618230018.GA6143@spearce.org>
References: <200706190036.01950.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 01:00:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0QD0-0008Fz-VB
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 01:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932878AbXFRXA0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 19:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbXFRXAY
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 19:00:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36792 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933226AbXFRXAW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 19:00:22 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I0QCh-0003KP-99; Mon, 18 Jun 2007 19:00:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C023720FBAE; Mon, 18 Jun 2007 19:00:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200706190036.01950.simon@lst.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50425>

Simon Hausmann <simon@lst.de> wrote:
> after reworking most of the really short commit logs and adding the missing 
> SOB lines I'd like to ask for consideration of merging git-p4 as part of 
> contrib/fastimport/ from
> 
> 	git://repo.or.cz/fast-export.git git-p4

Most of the commits look pretty good.  The effort you have put into
cleaning them up shows.

However, many of the oneline descriptions from Han-Wen Nienhuys
are still really short and not very descriptive.  They won't look
very good in Junio's "What's in git.git".  A few of yours are
also pretty long winded for a typical oneline in git.git, but I'd
rather have a descriptive-but-long oneline anytime over a short
and undescriptive one.

So I'm seriously considering merging this at this point.  I'm heading
out to dinner and will look at it more again when I get back, but
I think we should just bite the bullet and bring it into core Git.

-- 
Shawn.

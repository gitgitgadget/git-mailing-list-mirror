From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] honor GIT_REFLOG_ACTION in git-commit
Date: Fri, 19 Jan 2007 21:15:58 -0500
Message-ID: <20070120021557.GB11073@spearce.org>
References: <7vfya6bixg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 03:16:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H85m3-0006PO-Vo
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 03:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932876AbXATCQE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 21:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932874AbXATCQE
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 21:16:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42266 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932876AbXATCQC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 21:16:02 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H85lk-0003IS-KI; Fri, 19 Jan 2007 21:15:48 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 26FE620FBAE; Fri, 19 Jan 2007 21:15:58 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfya6bixg.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37251>

Junio C Hamano <junkio@cox.net> wrote:
> This allows git-cherry-pick and git-revert to properly identify
> themselves in the resulting reflog entries.  Earlier they were
> recorded as what git-commit has done.

Not sure how I missed that one when I introduced GIT_REFLOG_ACTION,
but thanks for finding and fixing it.  :-)

-- 
Shawn.

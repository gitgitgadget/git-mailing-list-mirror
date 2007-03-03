From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git pull fails to exit with non-zero status after fatal error
Date: Sat, 3 Mar 2007 16:23:48 -0500
Message-ID: <20070303212348.GA17796@spearce.org>
References: <45E9A641.8020002@lightspeed.com> <Pine.LNX.4.63.0703031913100.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vabyu9hcp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703032210010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Larry Streepy <larry@lightspeed.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 03 22:24:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNbi6-00080C-R9
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 22:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbXCCVX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 16:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbXCCVX7
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 16:23:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43474 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbXCCVX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 16:23:58 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HNbhf-0005PO-Bo; Sat, 03 Mar 2007 16:23:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5FA7620FBAE; Sat,  3 Mar 2007 16:23:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703032210010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41329>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sat, 3 Mar 2007, Junio C Hamano wrote:
> 
> > -	finish "$new_head" "Fast forward"
> > +	finish "$new_head" "Fast forward" || exit
> 
> Doesn't "exit" default to "exit 0"?

No, it carries the exit status of the prior failed command if the
prior command failed.  ;-)

For what its worth, I learned that only while hacking on git-merge.
I think it is highly non-obvious.

-- 
Shawn.

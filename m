From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Problems installing as root
Date: Sun, 25 Feb 2007 02:23:30 -0500
Message-ID: <20070225072330.GB1676@spearce.org>
References: <erpljl$ln9$1@sea.gmane.org> <20070225061258.GA1415@spearce.org> <7vabz2wxi4.fsf@assigned-by-dhcp.cox.net> <20070225070811.GA1676@spearce.org> <7vvehqvhcu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 08:23:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLDjX-0001Ly-7Q
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 08:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933672AbXBYHXg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 02:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933673AbXBYHXg
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 02:23:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33760 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933672AbXBYHXf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 02:23:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HLDjI-0002uY-K0; Sun, 25 Feb 2007 02:23:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3D97520FBAE; Sun, 25 Feb 2007 02:23:31 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vvehqvhcu.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40542>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > ..., and will
> > do the same in GIT-VERSION-GEN for git-gui.
> 
> I had an impression that GIT-VERSION-GEN in git-gui was Ok.

It is.  I just looked at it to see about fixing it too and just
realized what the `test $VN = $VC ||` chunk was all about.  :-)

> > What about the top level GIT-VERSION-GEN in git.git?
> 
> I thought it is much more careful than git-gui/CREDITS-GEN about
> avoiding unnecessary rebuilding.

Yes, it is.  I didn't realize what it was doing until just now.  :-)


Apparently I'm missing the obvious tonight.  There is a new version
of git-gui now pushed out (1 commit, your patch).  I did not bother
to tag it.   Please pull into maint.

-- 
Shawn.

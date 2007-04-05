From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Makefile: Add '+' to QUIET_SUBDIR0 to fix parallel make.
Date: Thu, 5 Apr 2007 02:19:48 -0400
Message-ID: <20070405061947.GA5436@spearce.org>
References: <20070404204233.GA14252@ferdyx.org> <7vabxnwfb4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Fernando J. Pereda" <ferdy@gentoo.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 08:20:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZLK9-0004Zr-Uz
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 08:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945916AbXDEGTz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 02:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945918AbXDEGTz
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 02:19:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54005 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945916AbXDEGTy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 02:19:54 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HZLK1-00057D-Vq; Thu, 05 Apr 2007 02:19:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A4C6C20FBAE; Thu,  5 Apr 2007 02:19:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vabxnwfb4.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43798>

Junio C Hamano <junkio@cox.net> wrote:
> "Fernando J. Pereda" <ferdy@gentoo.org> writes:
> 
> > Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>
> > ---
> >
> >   I don't know if this breaks non-gnu make, and don't have an easy way
> >   to test it right now. So someone should do that before it is applied.
> 
> I had an impression that our makefile is quite dependent on GNU
> make already.  Do people build git without gmake?

You can't build Git without GNU make.  At least not without writing
your own Makefile.  I say include Fernando's change.  ;-)

-- 
Shawn.

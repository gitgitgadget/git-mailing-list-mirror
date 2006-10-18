From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 19:22:14 -0400
Message-ID: <20061018232214.GJ19194@spearce.org>
References: <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181510510.1971@xanadu.home> <20061018191834.GA18829@spearce.org> <Pine.LNX.4.64.0610181525410.1971@xanadu.home> <20061018204626.GA19194@spearce.org> <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org> <20061018214143.GF19194@spearce.org> <7vwt6xxofi.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181542160.3962@g5.osdl.org> <7vslhlxmt3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 01:22:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaKjw-0003Iz-SH
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 01:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWJRXWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 19:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWJRXWW
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 19:22:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:32945 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750792AbWJRXWV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 19:22:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GaKjm-0008RF-2d; Wed, 18 Oct 2006 19:22:14 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0B0E120E42A; Wed, 18 Oct 2006 19:22:14 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vslhlxmt3.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29297>

Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Wed, 18 Oct 2006, Junio C Hamano wrote:
> >> 
> >> It should not be hard to write another program that generates a
> >> packfile like pack-object does but taking a thin pack as its
> >> input.  Then receive-pack can drive it instead of
> >> unpack-objects.
> >
> > Give me half an hour. It should be trivial to make "unpack-objects" write 
> > the "unpacked" objects into a pack-file instead.
> 
> Heh, three people having the same idea that goes in the same
> direction at the same time is not necessarily a good sign of
> efficient project management...

Or maybe it is just a sign of a good way to resolve the issue I
was raising.  :-)

-- 
Shawn.

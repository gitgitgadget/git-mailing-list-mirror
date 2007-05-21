From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Cross-reference the manpages for git-name-rev and git-describe
Date: Mon, 21 May 2007 03:54:13 -0400
Message-ID: <20070521075413.GQ3141@spearce.org>
References: <pan.2007.05.19.15.45.46@progsoc.org> <vpq646opzio.fsf@bauges.imag.fr> <A04FB6C2-20B2-4263-9D58-6C281C04C6C4@silverinsanity.com> <vpq8xbkoir8.fsf@bauges.imag.fr> <839C7D1E-E1D0-4EA1-8221-789C418CB242@silverinsanity.com> <7vfy5sy91f.fsf@assigned-by-dhcp.cox.net> <vpq7ir3658t.fsf_-_@bauges.imag.fr> <7vsl9rmkm0.fsf@assigned-by-dhcp.cox.net> <20070521072025.GO3141@spearce.org> <7viramfwkq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 09:54:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq2is-0003Xs-AX
	for gcvg-git@gmane.org; Mon, 21 May 2007 09:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbXEUHyX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 03:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754955AbXEUHyX
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 03:54:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58688 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545AbXEUHyW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 03:54:22 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hq2ic-0000JN-Rr; Mon, 21 May 2007 03:54:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5E2DD20FBAE; Mon, 21 May 2007 03:54:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7viramfwkq.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47988>

Junio C Hamano <junkio@cox.net> wrote:
> > Junio C Hamano <junkio@cox.net> wrote:
> >> wouldn't this be useful?
> >> 
> >> $ git-describe --contains --tags 1b600e659
> >> v1.5.0-rc3~34
> 
> Now we need to make sure that the name of the option --contains
> is sane, I guess.

I think its sane.  I wanted to do a --contains option to describe
a while back, for this reason, but just didn't get around to it.
You also suggested it.  Looks like at least two people came up with
that option independently.  That's not too bad.

Feel free to edit the patch if something else better comes up.

-- 
Shawn.

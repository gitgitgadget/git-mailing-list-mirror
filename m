From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Added support for OS X right click
Date: Sat, 4 Aug 2007 22:48:44 -0400
Message-ID: <20070805024843.GB9527@spearce.org>
References: <C4431971-A1F1-463E-B238-D351FCBB57F8@pp.inet.fi> <20070804065516.GS20052@spearce.org> <20070804071131.GA6557@coredump.intra.peff.net> <20070804073321.GU20052@spearce.org> <20070804074150.GA7738@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?VsOkaW7DtiBKw6RydmVsw6Q=?= <v@pp.inet.fi>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 05 04:49:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHWAz-0003T7-A0
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 04:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763915AbXHECst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 22:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763031AbXHECst
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 22:48:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43779 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759604AbXHECst (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 22:48:49 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IHWAT-0002Ml-BU; Sat, 04 Aug 2007 22:48:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9A4DA20FBAE; Sat,  4 Aug 2007 22:48:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070804074150.GA7738@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54925>

Jeff King <peff@peff.net> wrote:
> On Sat, Aug 04, 2007 at 03:33:21AM -0400, Shawn O. Pearce wrote:
> 
> > My mutt-foo isn't very good.  I tried to tell it utf-8, but I think
> > its ignoring me:
> 
> Try looking at the send_charset config option; by default mutt will try
> to send us-ascii if possible. Also, should it be "utf-8"?

Thanks, that actually did the trick.  This message might actually
arrive to you encoded in UTF-8.  Not that it matters.  ;-)
 
> > I just tried to reproduce it myself and I can't do whatever I did
> > before again now; it Just Works(tm).  *sigh*  No idea how I messed
> > the patch application up earlier, but I did.
> 
> OK, given that I couldn't reproduce it either, we should perhaps chalk
> it up to cosmic rays.

Or more likely the gap between the keyboard and the chair (aka me).
I may have actually done something at one point to damage that mbox.
git-am ran anyway, but gave me a garbled author name.  Always blame
the user, it probably really is his fault.  ;-)

-- 
Shawn.

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] display the subject of the commit just made
Date: Mon, 16 Apr 2007 03:11:27 -0400
Message-ID: <20070416071127.GM2229@spearce.org>
References: <7vwt0cx5jr.fsf@assigned-by-dhcp.cox.net> <20070416055111.GC23255@mellanox.co.il> <7vodlox3fx.fsf@assigned-by-dhcp.cox.net> <20070416061813.GD23255@mellanox.co.il> <20070416065119.GF23255@mellanox.co.il> <7v647wx0q3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 09:11:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdLND-0000gy-8R
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 09:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbXDPHLg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 03:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754022AbXDPHLg
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 03:11:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56724 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011AbXDPHLf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 03:11:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HdLN2-0002H0-20; Mon, 16 Apr 2007 03:11:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CB8EB20FBAE; Mon, 16 Apr 2007 03:11:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v647wx0q3.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44599>

Junio C Hamano <junkio@cox.net> wrote:
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> > Quoting Michael S. Tsirkin <mst@dev.mellanox.co.il>:
> >> > Because I *got* *rid* *of* "echo".
> >> 
> >> so I think we are stuck with echo.
> >
> > So ... is it good to go?
> 
> I am not quite convinced that giving a short summary is
> necessary yet, probably for the same reason you questioned why
> we do --shortstat.

Its not really necessary, no.

But when you have 8 terminal windows open, and you haven't looked
at one in a while, and it has a nice output from current git-reset
showing the subject of the commit you just reset to, that's handy
to jog your memory about what the shell was doing before it got
shuffled off the desk.

Now look at a git-commit output and find that's missing.  If its
cheap (and it is, reasonably so) it may be useful to some people.

Of course I'm one of those "gah, I got more shells than I know what
I'm doing with!" people.  ;-)

-- 
Shawn.

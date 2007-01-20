From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] prune: --expire=time
Date: Sat, 20 Jan 2007 12:18:32 +0100
Message-ID: <20070120111832.GA30368@moooo.ath.cx>
References: <20070118171830.GA13521@moooo.ath.cx> <20070118172408.GG15428@spearce.org> <20070118174244.GA14287@moooo.ath.cx> <20070118175134.GH15428@spearce.org> <20070118222919.GA22060@moooo.ath.cx> <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net> <20070119034404.GA17521@spearce.org> <20070119104935.GA5189@moooo.ath.cx> <7vfya6hll3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 12:18:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8EFD-0007nR-0a
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 12:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244AbXATLSh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 06:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbXATLSh
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 06:18:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:48826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965244AbXATLSg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 06:18:36 -0500
Received: (qmail invoked by alias); 20 Jan 2007 11:18:34 -0000
Received: from pD9EB9793.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.151.147]
  by mail.gmx.net (mp046) with SMTP; 20 Jan 2007 12:18:34 +0100
X-Authenticated: #5358227
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vfya6hll3.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37268>

Junio C Hamano <junkio@cox.net> wrote:
> 	git prune --expire=off
> 
> felt a bit confusing to me at the first glance.  Does it turn
> off the expiration mechanism, retaining all cruft, or turns off
> the mechanism to give grace period for recent objects?  The
> answer is obviosuly the latter as "retain all cruft" is
> meaningless, but still it somehow feels funny.  It might be
> easier to explain if it was:
> 
> 	git prune --expire=now
> 
> Maybe an alternative:
> 
> 	git prune --retain=1.day
> 	git prune --retain=off
> 
> perhaps?  I dunno.
Perhaps we could also use 'none' or 'all, e.g. --retain=none or
--expire=all.

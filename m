From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 10 Jan 2007 09:04:32 -0500
Message-ID: <20070110140432.GA20868@coredump.intra.peff.net>
References: <7virfprquo.fsf@assigned-by-dhcp.cox.net> <87odphgfzz.wl%cworth@cworth.org> <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net> <20070108131735.GA2647@coredump.intra.peff.net> <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net> <20070109142130.GA10633@coredump.intra.peff.net> <7virffkick.fsf@assigned-by-dhcp.cox.net> <20070109213117.GB25012@fieldses.org> <7vy7obj07k.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701091539050.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 15:05:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4e4M-0004fe-VQ
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 15:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbXAJOEg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 09:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbXAJOEg
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 09:04:36 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3977 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964863AbXAJOEf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 09:04:35 -0500
Received: (qmail 24360 invoked from network); 10 Jan 2007 09:04:46 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 10 Jan 2007 09:04:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jan 2007 09:04:32 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701091539050.3594@woody.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36512>

On Tue, Jan 09, 2007 at 03:46:32PM -0800, Linus Torvalds wrote:

> I would suggest a solution:
> 
>  - git checkout will refuse to switch AWAY from a detached head unless the 
>    SHA1 of the detached head exactly matches some other branch.

What about

  git checkout HEAD~20

I agree that checking out tags will be more common, but it feels like we
are discouraging this usage by presenting spurious warning messages.

-Peff

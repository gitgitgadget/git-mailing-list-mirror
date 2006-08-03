From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Wed, 02 Aug 2006 21:52:10 -0700
Message-ID: <7virlas9ol.fsf@assigned-by-dhcp.cox.net>
References: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net>
	<20060802192922.GA30539@prophet.net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 06:52:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8VBw-0002We-1W
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 06:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWHCEwN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 00:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWHCEwN
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 00:52:13 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:13526 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932085AbWHCEwM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 00:52:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060803045211.WJDH6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Aug 2006 00:52:11 -0400
To: carbonated beverage <ramune@net-ronin.org>
In-Reply-To: <20060802192922.GA30539@prophet.net-ronin.org> (carbonated
	beverage's message of "Wed, 2 Aug 2006 12:29:22 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24701>

carbonated beverage <ramune@net-ronin.org> writes:

> Any plans on a fix for:
> http://marc.theaimsgroup.com/?l=git&m=115089393505286&w=2

Unfortunately, plan needs to be drawn by somebody who sees
breakage.

> Commenting out the line mentioned in the reply lets me resize the window and
> see the bottom panel properly -- but I do have to resize it every time so it
> doesn't extend past the bottom of the screen.
>
> FYI, if it's not easy to reproduct, I'm running it on Debian/stable systems,
> i386 and x86_64, both with backports.org X servers, using tcl/tk 8.4

I am running Debian/testing+unstable on i386 and x86_64 with
tcl8.4 (8.4.12-1.1) and tk8.4 (8.4.12-1), displaying on
xserver-xorg (1:7.0.22).  I cannot get gitk to misbehave the way
the quoted post describes.  Even after resizing it to so short
that the bottom search input and commitdiff area becomes
invisible, moving the middle separator around gives the lower
panes back, and both of the scrollbars on the lower panes seem
to be behaving during that exercise.

The "workaround" to disable ".ctop conf" feels actively wrong;
this makes the command forget the dimension from the last
session, which is not so different from removing ~/.gitk every
time.

Could this be some funny interaction between window manager and
gitk perhaps?  I think my machines run metacity and the
environment is minimally Gnome.

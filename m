From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: PPC SHA-1 Updates in "pu"
Date: Sun, 25 Jun 2006 12:07:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606251202320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
 <20060624012202.4822.qmail@science.horizon.com> <7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
 <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
 <7vhd2atid1.fsf@assigned-by-dhcp.cox.net> <20060625012435.GZ21864@pasky.or.cz>
 <7vfyhtopjm.fsf@assigned-by-dhcp.cox.net> <20060625093444.GD21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 12:07:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuRWb-0003oy-0t
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 12:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWFYKHY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 06:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWFYKHY
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 06:07:24 -0400
Received: from mail.gmx.de ([213.165.64.21]:49594 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751116AbWFYKHX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 06:07:23 -0400
Received: (qmail invoked by alias); 25 Jun 2006 10:07:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 25 Jun 2006 12:07:22 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060625093444.GD21864@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22601>

Hi,

On Sun, 25 Jun 2006, Petr Baudis wrote:

> All the modules we depend on should come bundled with Perl since 5.8.1.
> Now, I'm not sure what our "cutoff" point is, and even if it is
> something like 5.6.0 whether we can just require users of Perl older
> than 5.8.1 (which should be only some rare and obscure systems anyway)
> to install the modules from CPAN.

NO! It is _wrong_ to require users to upgrade, when a little more work on 
our side would fix it. Requiring users to upgrade is a proactive way to 
get rid of new users.

And old ones. If you would require me to upgrade to Perl 5.8.1, I would 
rather stop upgrading git. Hell, something I really like about git: I just 
download the tar.gz, unpack it, and type make install. And usually that 
Just Works. (Except MinGW32, but I have already managed to see a nice 
"git-log -p" with it.)

Ciao,
Dscho

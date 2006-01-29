From: Greg KH <greg@kroah.com>
Subject: Re: [Census] So who uses git?
Date: Sun, 29 Jan 2006 10:12:40 -0800
Message-ID: <20060129181240.GA11721@kroah.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <1138529385.9919.185.camel@evo.keithp.com> <43DCA495.9040301@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Packard <keithp@keithp.com>, Junio C Hamano <junkio@cox.net>,
	cworth@cworth.org, Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 29 19:13:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3H3U-0001j5-C3
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 19:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWA2SNe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 13:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWA2SNe
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 13:13:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:41140 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751095AbWA2SNd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 13:13:33 -0500
Received: from [192.168.0.10] (dsl093-040-174.pdx1.dsl.speakeasy.net [66.93.40.174])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id k0TICuK03034;
	Sun, 29 Jan 2006 10:12:57 -0800
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1F3H2X-33F-00; Sun, 29 Jan 2006 10:12:41 -0800
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Content-Disposition: inline
In-Reply-To: <43DCA495.9040301@gorzow.mm.pl>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15224>

On Sun, Jan 29, 2006 at 12:18:45PM +0100, Radoslaw Szkodzinski wrote:
> 
> The only drawback is local cloning. This operation is like 4x slower
> than plain copying of the repository. Probably because it works like an
> ssh clone - creates a pack, copies it, then unpacks. This is just
> inefficient on a local machine.

Have you tried the "-l" option for cloneing locally?  It's _very_ fast,
even for my tiny little old laptop.

If you add a "-n" that will not checkout the source tree, so you can
compare the time of cloning with the checkout portion.

thanks,

greg k-h

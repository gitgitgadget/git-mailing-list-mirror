From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add option USE_INPLACE to Makefile
Date: Wed, 16 Nov 2005 00:36:40 -0800
Message-ID: <7vpsp19eg7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511160333460.15130@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzk5cmnd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511160903360.16063@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 09:38:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcImp-0001z8-KB
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 09:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVKPIgn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 03:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbVKPIgn
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 03:36:43 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:1004 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030229AbVKPIgm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 03:36:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116083615.CLBM15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 03:36:15 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511160903360.16063@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 16 Nov 2005 09:10:10 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12013>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now, *I* know what I have to put into config.mak, but I would hate the 
> project if I was new to it, tried to play around with it, and nothing 
> would work in spite of being compiled with just one warning, thank you.

Hmph.  That certainly sounds like what I might do.  Especially
the part "play around before installing", so I am *very*
sympathetic.

OTOH, I do not particularly want to advertise/encourage in-place
use.  Once you built today's git ;-), wouldn't you cd somewhere
else and use it for your real work?  That would mean you have
one location on your PATH that you keep the latest git build
and I am not sure why being able to run in-place is such a big
deal.  Is it because $HOME is under a tight quota?

> Just a safety measure for the price of two lines. When I check out a new 
> project, I do "make", play around with it, and then do "make install". If 
> I had to set "export USE_INPLACE=1", "make install" should barf, because 
> the compiled programs are not meant to be used anywhere else.

OK.  That's sensible.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Thu, 19 Jan 2006 10:24:27 -0800
Message-ID: <7vr774dqjo.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com>
	<7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601181233460.8678@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4q41zd1t.fsf@assigned-by-dhcp.cox.net>
	<20060118185229.GA3001@steel.home>
	<7vmzhtqakl.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0601190701g2696b1a9l14f3d288875e11ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Christopher Faylor <me@cgf.cx>
X-From: git-owner@vger.kernel.org Thu Jan 19 19:29:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzeSX-0001bx-JJ
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 19:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWASSYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 13:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWASSYb
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 13:24:31 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:54942 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030233AbWASSY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 13:24:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060119182152.JLO17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 Jan 2006 13:21:52 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14924>

Alex Riesen <raa.lkml@gmail.com> writes:

> Works if sleep is for 2 secs (I completely forgot about that stupid
> FAT granularity!)
> st_ino is always the same (it is a hash of pathname).
> Christopher, how is that supposed to work with hardlinks? (NTFS has
> hardlinks, BTW)

So the verdict is to take your patch but wait for three seconds?
I still have mild aversion about $SECONDS though...

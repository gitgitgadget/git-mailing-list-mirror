From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Sat, 24 Jun 2006 18:20:46 -0700
Message-ID: <7vzmg2rpxt.fsf@assigned-by-dhcp.cox.net>
References: <7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
	<20060623011205.GJ21864@pasky.or.cz>
	<7vejxgckq9.fsf@assigned-by-dhcp.cox.net>
	<m1k678yt6m.fsf@ebiederm.dsl.xmission.com>
	<20060622220201.19132.67536.stgit@machine.or.cz>
	<7vlkrohj9p.fsf@assigned-by-dhcp.cox.net>
	<20060622235017.GH21864@pasky.or.cz>
	<7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
	<20060623011205.GJ21864@pasky.or.cz>
	<7vejxgckq9.fsf@assigned-by-dhcp.cox.net>
	<20060623123904.GL21864@pasky.or.cz>
	<7vejxf74e3.fsf@assigned-by-dhcp.cox.net>
	<7vzmg35pkt.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606242207510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 03:20:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJIy-0001d2-8h
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWFYBUt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWFYBUt
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:20:49 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34252 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964841AbWFYBUs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 21:20:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625012048.PNKU18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 21:20:48 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606242207510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 24 Jun 2006 22:10:11 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22557>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> My original idea: on a machine where you have no accurate diff, you at 
> least want to pass the tests, and you want to ensure you can apply a diff 
> you generated on that machine.

I remember that, but I think recently we converted t4100 and
t4101 to use pregenerated test vectors so it might not be an
issue anymore?

> This patch is just compile tested, but obviously correct 

Looks sane, thanks.

I would maybe rename the option to --inaccurate-eof and default
it to off (i.e. no --accurate-eof option).  After all we are not
talking about arbitrary inaccuracy but the particular botch of
not having "\No newline at the end of file."

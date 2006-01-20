From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Thu, 19 Jan 2006 17:13:17 -0800
Message-ID: <7vbqy78zwy.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com>
	<7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601181233460.8678@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4q41zd1t.fsf@assigned-by-dhcp.cox.net>
	<20060118185229.GA3001@steel.home>
	<7vmzhtqakl.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0601190701g2696b1a9l14f3d288875e11ab@mail.gmail.com>
	<20060119182822.GA32022@trixie.casa.cgf.cx>
	<20060119221227.GB3601@steel.home>
	<20060119222553.GB7567@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 20 02:13:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzkqR-0001R3-Px
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 02:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWATBNV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 20:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030452AbWATBNU
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 20:13:20 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:36515 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030410AbWATBNU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 20:13:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060120011106.OFTS26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 Jan 2006 20:11:06 -0500
To: Christopher Faylor <me@cgf.cx>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14946>

Christopher Faylor <me@cgf.cx> writes:

> Inodes are only calculated by hashing the path name when the OS lacks
> the support to provide a "real" inode and in that case there is no hard
> link support available so it's a non-issue.

Does that mean on such filesystems "mv foo bar" would change the
i-num of the moved entity?

I am not complaining even if that is the case.  I just want to
understand what it does.

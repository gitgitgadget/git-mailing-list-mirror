From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Git.pm build: Fix quoting and missing GIT-CFLAGS dependency
Date: Sun, 25 Jun 2006 23:48:31 -0700
Message-ID: <7vk674mmyo.fsf@assigned-by-dhcp.cox.net>
References: <20060624012202.4822.qmail@science.horizon.com>
	<7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
	<7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
	<7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241338370.6483@g5.osdl.org>
	<7vd5cyt8a3.fsf@assigned-by-dhcp.cox.net>
	<20060625010202.GX21864@pasky.or.cz>
	<20060625014009.GA21864@pasky.or.cz>
	<7vac82q6mb.fsf@assigned-by-dhcp.cox.net>
	<20060625152157.GG21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 08:48:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fuktk-00009U-OQ
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 08:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWFZGsd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 02:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWFZGsd
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 02:48:33 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:19096 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751159AbWFZGsc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 02:48:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060626064832.WRBV554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Jun 2006 02:48:32 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22654>

Petr Baudis <pasky@suse.cz> writes:

> Could you please also throw in these two?
>
> [PATCH 3/7] Git.pm: Swap hash_object() parameters
> [PATCH 4/7] Git.pm: Fix Git->repository("/somewhere/totally/elsewhere")

Will take a look.

> Yes, -I is very broken. I have abandoned it in:
>
> 	Subject: Re: [PATCH 01/12] Introduce Git.pm (v4)
> 	Date:   Sat, 24 Jun 2006 13:52:27 +0200
>
> The advantage to your approach is that it works properly without
> requiring to make install even outside of the testsuite.

I remember myself getting utterly discusted when I saw the
inclusion of the build-time blib directory in the search path in
some other Perl code outside git.

Worse yet, I suspect the order you do the two directories is
wrong to prefer the freshly built one over the one you installed
the last time, but I was trying not to stare at too much for
health reasons so ... ;-).

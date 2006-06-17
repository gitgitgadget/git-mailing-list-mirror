From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-1.4.0 make problems
Date: Sat, 17 Jun 2006 15:40:05 -0700
Message-ID: <7vac8b76ey.fsf@assigned-by-dhcp.cox.net>
References: <200606170218.k5H2I0o0003192@grail.cba.csuohio.edu>
	<4493A810.6010706@lsrfire.ath.cx>
	<7vbqsra4d2.fsf@assigned-by-dhcp.cox.net>
	<44947A43.7070909@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 00:40:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrjSe-0002C6-O8
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 00:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWFQWkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 18:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWFQWkI
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 18:40:08 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:26778 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750999AbWFQWkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 18:40:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060617224006.XECM12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Jun 2006 18:40:06 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44947A43.7070909@lsrfire.ath.cx> (Rene Scharfe's message of
	"Sat, 17 Jun 2006 23:55:15 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22039>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Hrm.  Is the header really that unfriendly?  With a non-POSIX tar you
> get an extra file and a nice, if somewhat cryptic, reminder to upgrade
> your archiver. ;-)  Seriously, this is way below my annoyance-radar,
> but I'm obviously biased.

I do not mind tar-tree producing the header by default and
having to override it with ^{tree} -- actually I think it is a
good default.  I think that particular use in our Makefile,
however, is not necessary.

> What do you think about the following patch for starters?

Documentation updates are always welcome, and I think this is a
good change.  Thanks.

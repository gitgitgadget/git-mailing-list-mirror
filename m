From: Junio C Hamano <junkio@cox.net>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Sat, 30 Jul 2005 15:16:48 -0700
Message-ID: <7vfytwym5r.fsf@assigned-by-dhcp.cox.net>
References: <20050728120806.GA2391@pasky.ji.cz>
	<Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de>
	<20050728153506.GL14229@pasky.ji.cz>
	<Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de>
	<20050728161815.GC17952@pasky.ji.cz>
	<7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net>
	<20050728183904.GA24948@pasky.ji.cz>
	<7v4qaeqrh3.fsf@assigned-by-dhcp.cox.net>
	<20050729070628.GA24895@pasky.ji.cz>
	<7vmzo6jbme.fsf@assigned-by-dhcp.cox.net>
	<20050729081051.GH24895@pasky.ji.cz>
	<7vek9igfgw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 00:17:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dyzda-0005bg-CA
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 00:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbVG3WQv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 18:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbVG3WQv
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 18:16:51 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:23944 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S263101AbVG3WQu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2005 18:16:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050730221648.IWGQ3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 30 Jul 2005 18:16:48 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <7vek9igfgw.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Fri, 29 Jul 2005 01:54:07 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Having said that, I do not particulary think allowing push to
> write into different ref is an unreasonable thing.  As you
> pointed out long time ago when send-pack was first done, the
> protocol is not so easily extensible, so this may require either
> backward incompatible protocol change, or introduction of a new
> program pair send-pack-2 / receive-pack-2.  I'll take a look
> sometime this weekend.  Bedtime.

Again, what Linus designed turns out to be perfect.  It does not
appear to need a protocol level change at all.  I'll code up
something over the weekend if I am lucky.

From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PACKAGERS] Makefile: DESTDIR vs. dest
Date: Fri, 29 Jul 2005 09:42:28 -0700
Message-ID: <20050729164228.GP16618@ca-server1.us.oracle.com>
References: <20050729133015.GC21909@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 18:45:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyXxy-0004h3-Qs
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 18:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVG2Qnp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 12:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVG2Qno
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 12:43:44 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:51769 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S261385AbVG2Qmg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 12:42:36 -0400
Received: from rgmgw1.us.oracle.com (rgmgw1.us.oracle.com [138.1.191.10])
	by rgminet04.oracle.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id j6TGgTB6010002;
	Fri, 29 Jul 2005 10:42:29 -0600
Received: from rgmgw1.us.oracle.com (localhost [127.0.0.1])
	by rgmgw1.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j6TGgTVj024138;
	Fri, 29 Jul 2005 10:42:29 -0600
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmgw1.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j6TGgT4A024130;
	Fri, 29 Jul 2005 10:42:29 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.52)
	id 1DyXwK-0002yu-Tb; Fri, 29 Jul 2005 09:42:28 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050729133015.GC21909@pasky.ji.cz>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2005 at 03:30:15PM +0200, Petr Baudis wrote:
>   git has $dest in its Makefile while Cogito uses $DESTDIR. I'd like to
> ask the potential users of those variables (probably mostly distribution
> package maintainers) what's easier for them and what do they prefer, as
> I would like to unify this.

	DESTDIR is "standardized" by automake.  Doesn't make it best,
but does make it expected by a lot of folks.

Joel

-- 

"In the beginning, the universe was created. This has made a lot 
 of people very angry, and is generally considered to have been a 
 bad move."
        - Douglas Adams

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

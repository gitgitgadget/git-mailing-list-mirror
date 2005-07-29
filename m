From: Petr Baudis <pasky@suse.cz>
Subject: [PACKAGERS] Makefile: DESTDIR vs. dest
Date: Fri, 29 Jul 2005 15:30:15 +0200
Message-ID: <20050729133015.GC21909@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jul 29 15:31:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyUwW-0002Oy-P4
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 15:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVG2NaT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 09:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVG2NaT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 09:30:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13072 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262350AbVG2NaR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 09:30:17 -0400
Received: (qmail 30777 invoked by uid 2001); 29 Jul 2005 13:30:15 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  git has $dest in its Makefile while Cogito uses $DESTDIR. I'd like to
ask the potential users of those variables (probably mostly distribution
package maintainers) what's easier for them and what do they prefer, as
I would like to unify this.

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox

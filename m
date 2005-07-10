From: Petr Baudis <pasky@suse.cz>
Subject: Re: cogito Mac OS X compatibility
Date: Sun, 10 Jul 2005 16:29:16 +0200
Message-ID: <20050710142916.GA24249@pasky.ji.cz>
References: <42CF0D9F.8040909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 16:29:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrcoI-0003jq-93
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 16:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVGJO3U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 10:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVGJO3U
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 10:29:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31458 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261947AbVGJO3S (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 10:29:18 -0400
Received: (qmail 25308 invoked by uid 2001); 10 Jul 2005 14:29:16 -0000
To: Bryan Larsen <bryan.larsen@gmail.com>
Content-Disposition: inline
In-Reply-To: <42CF0D9F.8040909@gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jul 09, 2005 at 01:34:55AM CEST, I got a letter
where Bryan Larsen <bryan.larsen@gmail.com> told me that...
> On Mac OS X
> 
> $ cg-clone http://www.kernel.org/pub/scm/cogito/cogito.git
> defaulting to local storage area
> 19:11:10 
> URL:http://www.kernel.org/pub/scm/cogito/cogito.git/refs/heads/master 
> [41/41] -> "refs/heads/origin" [1]
> /Users/blarsen/bin/cg-pull: line 82: 0 + : syntax error: operand 
> expected (error token is " ")
> cg-pull: objects pull failed
> cg-init: pull failed

That's strange. I assume you don't have the stat utility, but that
shouldn't matter - Cogito has own stat stub to use in those cases. Could
you please put some debugging stuff into stat() in cg-Xlib to see what's
going on? (Beware, cg-pull calls it with 2>/dev/null.) Thanks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..

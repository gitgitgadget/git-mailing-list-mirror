From: Petr Baudis <pasky@suse.cz>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Fri, 29 Jul 2005 10:10:51 +0200
Message-ID: <20050729081051.GH24895@pasky.ji.cz>
References: <20050728120806.GA2391@pasky.ji.cz> <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728153506.GL14229@pasky.ji.cz> <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728161815.GC17952@pasky.ji.cz> <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net> <20050728183904.GA24948@pasky.ji.cz> <7v4qaeqrh3.fsf@assigned-by-dhcp.cox.net> <20050729070628.GA24895@pasky.ji.cz> <7vmzo6jbme.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 10:13:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyPyy-0007rV-KP
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 10:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVG2IMX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 04:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVG2IMX
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 04:12:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12300 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262506AbVG2IK4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 04:10:56 -0400
Received: (qmail 1496 invoked by uid 2001); 29 Jul 2005 08:10:51 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzo6jbme.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 29, 2005 at 09:48:57AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Aha, so it seems our problem is hopefully only in terminology, great.
> >
> > So, what do you mean by "clone" here? And what command should I use for
> > pushing then?
> 
> Notice I never used the word "clone" in what I said.

> > However, I happen to think that two repositories
> > you use send-pack (not _CLONE_ which uses completely different
> > protocol)

(emphasis mine ;-)

> Now, A may happen to be on my home machine and B may happen be
> on my notebook, meaning the owner of A and B are both myself.
> But even in that case I would still work by "pulling from A"
> when I am on B, and "pulling from B" when I am on A.  In other
> words, "pulling" is the only patch flow mechanism I would use.

I use cg-push on my notebook, given that the notebook might not happen
to have public IP address in some cases, or might be behind some
corporate firewall, or that I'm lazy to ssh to my home machine in order
to pull.

> Pushing is only for publication and I treat it as just a
> GIT-aware rsync/mirror, nothing more.  I have a feeling that
> your workflow is different and you plan to use both push and
> pull for normal patch flows.  This distinction is probably where
> the disagreement comes from.

Exactly. I want much more freedom in pushing, the only requirement being
that "the to-be-replaced remote head is ancestor of the to-be-pushed
local head". I think (am I wrong?) git-send-pack localhead:remotehead
would work just fine for me, the only thing I need is the support for
different local and remote head names.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox

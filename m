From: Petr Baudis <pasky@suse.cz>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Fri, 29 Jul 2005 09:11:36 +0200
Message-ID: <20050729071136.GB24895@pasky.ji.cz>
References: <20050728120806.GA2391@pasky.ji.cz> <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728153506.GL14229@pasky.ji.cz> <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728161815.GC17952@pasky.ji.cz> <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net> <20050728183904.GA24948@pasky.ji.cz> <Pine.LNX.4.58.0507282047360.30638@wgmdd8.biozentrum.uni-wuerzburg.de> <pan.2005.07.28.19.47.38.753705@smurf.noris.de> <Pine.LNX.4.58.0507282201110.3005@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 09:13:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyP37-0002Uc-5o
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 09:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVG2HMe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 03:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVG2HM3
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 03:12:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20235 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262453AbVG2HLj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 03:11:39 -0400
Received: (qmail 26873 invoked by uid 2001); 29 Jul 2005 07:11:36 -0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507282201110.3005@wgmdd8.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jul 28, 2005 at 10:14:35PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> told me that...
> Hi,

Hello,

> Naming the remote HEAD differently than the local HEAD is just *wrong*
> when you want to push back to them.

But you might not know that in advance. That's one of they key points of
the distributed systems, after all - when you are cloning, you needn't
know in advance that you will want to do local commits, and don't need
upstream approval. You also might not know in advance that you will want
to push them back. Sure, distributed systems are more complicated. If
you don't like complicated things, there's always RCS. ;-)

> The only sane way if you have to have different local and remote HEADs
> that I can think of, would be to allow only the current local active HEAD
> to be pushed to a certain remote HEAD (preferably identified by a file in
> .git/branches).

Well, but (if I understand you correctly) that was always the _point_.
It's what I was talking about all the time. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox

From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH/RFC] "Recursive Make considered harmful"
Date: Thu, 28 Jul 2005 09:51:15 +0200
Message-ID: <20050728075115.GB18907@pasky.ji.cz>
References: <20050727083910.GG19290@mythryan2.michonline.com> <7v4qafrk8w.fsf@assigned-by-dhcp.cox.net> <42E8058B.7070907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 10:32:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dy3ns-00074S-77
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 10:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVG1IbV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 04:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVG1IbV
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 04:31:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32519 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261338AbVG1HvW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 03:51:22 -0400
Received: (qmail 22237 invoked by uid 2001); 28 Jul 2005 07:51:15 -0000
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <42E8058B.7070907@gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jul 28, 2005 at 12:07:07AM CEST, I got a letter
where A Large Angry SCM <gitzilla@gmail.com> told me that...
> Junio C Hamano wrote:
> >While I do not have strong objections to make the build process
> >go faster, it is somewhat disturbing that the Makefile pieces
> >maintained in subdirectories need to name things they touch
> >using paths that include the subdirectory names.  I do not have
> >a better alternative to suggest, though...
> 
> For a project the size of Git, is there any real benefit to this change?
> 
> Besides pathing issues, you also have to aware that all identifiers in 
> the included makefile fragments will be global.
> 
> I don't object to the change but I see it as trading one maintenance 
> issue for another.

I'd also argue that generally, larger files are inherently harder to
maintain, and having all the targets for all the subdirectories in a
single file sounds nightmarish. (OTOH, by now you probably know that I'm
a keep-it-as-local-as-possible junkie.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox

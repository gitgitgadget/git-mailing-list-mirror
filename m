From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] cg-pull: summarize the number of pulled objects
Date: Mon, 30 May 2005 10:20:54 +0200
Message-ID: <20050530082054.GB1036@pasky.ji.cz>
References: <20050530015650.GB10715@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 10:19:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcfTp-0000F9-Og
	for gcvg-git@gmane.org; Mon, 30 May 2005 10:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVE3IVE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 04:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVE3IVE
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 04:21:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2700 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261557AbVE3IU7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 04:20:59 -0400
Received: (qmail 17825 invoked by uid 2001); 30 May 2005 08:20:54 -0000
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20050530015650.GB10715@diku.dk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 30, 2005 at 03:56:50AM CEST, I got a letter
where Jonas Fonseca <fonseca@diku.dk> told me that...
> Show cg-pull progress by summarizing the very verbose output of the pull
> backends into a continously updated line specifying the number of
> objects which have already been pulled.
> 		     
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> ---
> 
> Straight from the bloat department, perhaps, but it is nice to not have
> the terminal backlog ruined and the object count is quite nice too. :)
> 
> Interesting, it counts 4950 objects when pulling over rsync and 4454
> objects when pulling locally. Didn't test HTTP pulling other than to see
> if the "got <sha>" lines was matched correctly.

It is nice, but actually losing information for me. It's ok for the HTTP
and SSH "smart pulls", but if I pull over rsync, I have progress
indication based on the first two digits - assuming roughly even
distribution of hashes, I can see that when I cross 80/ I'm in the half
etc. So what about showing some percentage or something in that case?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

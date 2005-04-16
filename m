From: Petr Baudis <pasky@ucw.cz>
Subject: Re: optimize gitdiff-do script
Date: Sun, 17 Apr 2005 01:43:44 +0200
Message-ID: <20050416234344.GQ19099@pasky.ji.cz>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com> <20050416232810.23430.78712.sendpatchset@sam.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 01:40:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwtW-0005K1-5z
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVDPXnt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVDPXnt
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:43:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17031 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261204AbVDPXnp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 19:43:45 -0400
Received: (qmail 16405 invoked by uid 2001); 16 Apr 2005 23:43:44 -0000
To: Paul Jackson <pj@sgi.com>
Content-Disposition: inline
In-Reply-To: <20050416232810.23430.78712.sendpatchset@sam.engr.sgi.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 01:28:04AM CEST, I got a letter
where Paul Jackson <pj@sgi.com> told me that...
> Reduce number of subcommands execv'd by a
> third, by only calling 'rm' once, at end, not each
> loop.

The idea behind that was that diffing could take a significant portion
of disk space, especially when making large kernel diffs. Perhaps we
could make this a switch, but I would personally prefer defaulting to
the less space-consuming behaviour. I personally dislike applications
which like to pop 150M of nonsense to my /tmp.

Please don't reindent the scripts. It violates the current coding style
and the patch is unreviewable.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

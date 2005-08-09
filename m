From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Use $DESTDIR instead of $dest
Date: Tue, 9 Aug 2005 22:57:25 +0200
Message-ID: <20050809205725.GG7052@pasky.ji.cz>
References: <20050804225529.GJ24479@pasky.ji.cz> <20050804235638.GL24479@pasky.ji.cz> <7v4qa4geiq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 22:59:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2bAl-00074P-9P
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 22:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVHIU53 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 16:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbVHIU53
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 16:57:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12037 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S964962AbVHIU52 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 16:57:28 -0400
Received: (qmail 19120 invoked by uid 2001); 9 Aug 2005 20:57:26 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4qa4geiq.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Aug 06, 2005 at 01:17:17AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > $DESTDIR is more usual during the build than $dest and is what is usually
> > used in the makefiles, so let's use it too.
> 
> While I do not have much preference either way, I do not want to
> make this kind of change without making corresponding changes to
> the spec.in and debian/rules file in the same commit, or another
> commit that immediately follow it.  And I wanted to do a 0.99.4
> tomorrow, so I hope you would not mind if I placed this on
> hold...

No problem, this was just some of the last tidbits wrt. synchronization
of the makefiles with Cogito.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox

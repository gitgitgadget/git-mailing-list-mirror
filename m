From: Petr Baudis <pasky@ucw.cz>
Subject: Re: -p diff output and the 'Index:' line
Date: Sun, 29 May 2005 14:02:49 +0200
Message-ID: <20050529120248.GD1036@pasky.ji.cz>
References: <20050529071520.GC1036@pasky.ji.cz> <7vd5raqy28.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 14:00:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcMT6-0005si-DQ
	for gcvg-git@gmane.org; Sun, 29 May 2005 14:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVE2MCx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 08:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVE2MCx
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 08:02:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10985 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261196AbVE2MCv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 08:02:51 -0400
Received: (qmail 17106 invoked by uid 2001); 29 May 2005 12:02:49 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5raqy28.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 29, 2005 at 09:41:03AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> PB>   What do you think? Would you hate it to show up in the diffs, or are
> PB> you ok with it?
> 
> I cannot tell if you are asking about cg-diff or changing the
> built-in diff-* output.  The Subject: line suggests you are
> talking about the latter, but if that is the case I have to
> admit that I am not that sympathetic to Index: nor separator.

Yes, I'm talking about the latter.

> Like Linus, I do "/^diff --git .*" in my less sessions, which
> gives a very nice highlighted separator line without wasting a
> single line on the terminal.  If any of the readers on the list
> didn't know about this trick (especially the trailing .* part),
> please try it.  I'm certain everybody would love it.

When I do just cg-diff to see what I changed I usually do not pipe it to
less, and typing that / stuff seems insane (although /^d.* could give a
good approximation). OTOH I think I'll go for the diff output
colorification (at the Cogito level), so the separator indeed isn't
strictly necessary. I can live without it. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Fri, 29 Jul 2005 10:41:46 +0200
Message-ID: <20050729084144.GJ24895@pasky.ji.cz>
References: <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com> <20050722192424.GB8556@mars.ravnborg.org> <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net> <20050722205948.GE11916@pasky.ji.cz> <7vd5p73jlu.fsf@assigned-by-dhcp.cox.net> <20050728155210.GA17952@pasky.ji.cz> <7vack6mcd7.fsf@assigned-by-dhcp.cox.net> <20050729073644.GE24895@pasky.ji.cz> <7vd5p2hve1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 10:44:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyQSr-0002Hn-Ll
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 10:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVG2InH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 04:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVG2InH
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 04:43:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36108 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262531AbVG2Ilt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 04:41:49 -0400
Received: (qmail 4332 invoked by uid 2001); 29 Jul 2005 08:41:46 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5p2hve1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 29, 2005 at 10:24:54AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> In the meantime, the current one is clearly broken as you
> pointed out, so let's replace it with the updated "generic rule
> with the following exceptions" one.

That's fine by me. I would only like to ask the Porcelain authors to
keep their git-ls-files exclude parameters order matching the internal
ordering so that when we indeed change it in the future to follow the
commandline order, the Porcelains won't break.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox

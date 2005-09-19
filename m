From: Petr Baudis <pasky@suse.cz>
Subject: Re: What to expect after GIT 0.99.7
Date: Mon, 19 Sep 2005 10:36:50 +0200
Message-ID: <20050919083650.GA22269@pasky.or.cz>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> <7vwtleyml5.fsf@assigned-by-dhcp.cox.net> <7vpsr6ymg3.fsf_-_@assigned-by-dhcp.cox.net> <pan.2005.09.19.07.35.56.960375@smurf.noris.de> <7vwtldsbv2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 10:38:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHH94-0007At-OG
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 10:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVISIgx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 04:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVISIgx
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 04:36:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18084 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932376AbVISIgw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 04:36:52 -0400
Received: (qmail 22833 invoked by uid 2001); 19 Sep 2005 10:36:50 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtldsbv2.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8848>

Dear diary, on Mon, Sep 19, 2005 at 10:25:21AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Matthias Urlichs <smurf@smurf.noris.de> writes:
> 
> > Hi, Junio C Hamano wrote:
> >
> >> * Perhaps a tool to revert a single file to pre-modification
> >>   state?  git-cat-file blob `git-ls-files | grep foo` >foo or
> >>   git-cat-file blob `git-ls-tree HEAD foo` >foo?  What should
> >>   the command be called?  git-revert is taken so is
> >>   git-checkout.
> >
> > git-checkout can be extended to accept filenames, which would have the
> > additional benefit of enabling me to get any revision, not just HEAD.
> >
> > So can git-reset.
> >
> > I agree with Anton's "git clean"; with an optional -r <commit>
> > argument, that would be a better solution.
> 
> It probably is because I am BK untainted, but 'git clean' sounds
> as if it would do 'git-ls-files --others | xargs rm -f'.

FWIW, that's also what cg-clean does. It uses cg-restore -f filename to
restore files to the state of the last commit, but it's not like I'd be
terribly happy about that.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox

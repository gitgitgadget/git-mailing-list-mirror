From: Petr Baudis <pasky@suse.cz>
Subject: Re: Comments on "status -v"
Date: Fri, 10 Feb 2006 23:51:09 +0100
Message-ID: <20060210225109.GQ31278@pasky.or.cz>
References: <87slqtcr2f.wl%cworth@cworth.org> <7vfymtl43b.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602081726390.2458@g5.osdl.org> <7vmzgzy46f.fsf@assigned-by-dhcp.cox.net> <87u0b7uf91.wl%cworth@cworth.org> <7vaccyx6ne.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 23:50:45 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7h6C-0001yE-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 23:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWBJWum (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 17:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWBJWum
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 17:50:42 -0500
Received: from w241.dkm.cz ([62.24.88.241]:61580 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750759AbWBJWul (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 17:50:41 -0500
Received: (qmail 24413 invoked by uid 2001); 10 Feb 2006 23:51:09 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vaccyx6ne.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15893>

Dear diary, on Fri, Feb 10, 2006 at 10:09:41PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Carl Worth <cworth@cworth.org> writes:
> 
> > 1) I think the patch should come after the traditional status summary,
> >    not before. If something is obviously "wrong" (non-updated file,
> >    etc.) that will be more obvious in the summary, so it's good to
> >    present that up front, and not bury it after the patch, (which
> >    might make it initially invisible without scrolling).
> 
> Maybe.  A time for a quick poll.

It makes more sense to me. (Not that I'd be ever going to use the
command, though. ;)

> > 2) Using the "^---$" separator to separate the the edited contents
> >    into a commit message and ignored content seems risky to me.

We do it for the mails (and Cogito for cg-mkpatch output) and it seems
to work out just fine.

> >    Moving the patch after the summary (as discussed above) would help
> >    greatly in avoiding the clobbered separator, but wouldn't address
> >    the separator-appears-in-commit-message problem.
> 
> That is a good argument for (1).  Since the diff output never
> has '^---$' in itself,

$ echo -- >a; >b; diff -u a b

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams

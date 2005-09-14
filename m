From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Added an option to cvsimport to specify email domain
Date: Wed, 14 Sep 2005 21:34:57 +0200
Message-ID: <20050914193457.GE2936@pasky.or.cz>
References: <u5tzmqp8fzx.fsf@lysator.liu.se> <7vhdcw661g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David K?.A?Negedal" <davidk@lysator.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 21:37:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFd2C-0002kL-9n
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 21:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVINTfE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 15:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVINTfD
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 15:35:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10967 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964806AbVINTfB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 15:35:01 -0400
Received: (qmail 23003 invoked by uid 2001); 14 Sep 2005 21:34:57 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhdcw661g.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8557>

Dear diary, on Wed, Sep 07, 2005 at 09:18:03PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> David K?.A?Negedal <davidk@lysator.liu.se> writes:
> 
> > The authorship info in commits created by git-cvsimport-script
> > only contains the username of the CVS committer.  This patch
> > adds a flag -e <domain> to git-cvsimport-script that makes it
> > possible to specify an email domain that is added to all email
> > addresses in the commit "author" and "committer" fields.
> >
> > ---
> > I have stopped using cvsimport, because cvsps seems to produce bad
> > output on the repository I'm using it with, but I had already prepared
> > this patch.
> 
> Hmph.  One reason the original implementation did not do this is
> because Linus and other people wanted to have a repeatability,
> so making this an optional thing is good, but if we go this
> route, I think if it would be nicer to have a --author-map
> option that lets you feed a list of:
> 
>     <author> ==> "A U Thor <author@author.dom>"
> 
> mappings, instead of a single -e, which essentially does not add
> much information to the result.
> 
> I take that your oob comment indicates that you do not have much
> incentive/inclination to further hack on this, so I am not
> asking you to do the above even if you find my suggestion
> worthwhile.

Various tools use CVSROOT/users to map usernames to realname <email>.
I actually wanted to send a patch, looked at the cvsimport script and
got totally scared away (at least for now)... ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox

From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-cat   [was: Re: Newbie question:  equiv of:  cvs co -p <filename>  ? ]
Date: Fri, 12 Aug 2005 01:03:43 +0200
Message-ID: <20050811230343.GJ25280@pasky.ji.cz>
References: <ddb8vl$ifq$1@sea.gmane.org> <Pine.LNX.4.58.0508091725120.3258@g5.osdl.org> <42FA1150.7090506@research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 01:05:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3M5T-0007Bf-VF
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 01:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbVHKXDo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 19:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVHKXDo
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 19:03:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62218 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932534AbVHKXDo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 19:03:44 -0400
Received: (qmail 1901 invoked by uid 2001); 11 Aug 2005 23:03:43 -0000
To: John Ellson <ellson@research.att.com>
Content-Disposition: inline
In-Reply-To: <42FA1150.7090506@research.att.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Aug 10, 2005 at 04:38:08PM CEST, I got a letter
where John Ellson <ellson@research.att.com> told me that...
> Linus Torvalds wrote:
> >
> >On Tue, 9 Aug 2005, John Ellson wrote:
> >
> >>I hacked this:
> 
> >No. ...
> 
> >So you could do something like ...
> 
> >(totally untested)
> >
> >		Linus
> 
> 
> Thanks Linus, also Rene and Johannes.
> 
> I applied a bit of polish and testing and now I'm ready to offer
> my first contribution to cogito.
> 
> 	cg-cat [-r rev] FILE
> 
> I hope that this is useful to others.

Thanks, cleaned up and applied. I only renamed it to cg-admin-cat since
I think it's indeed a bit obscure. Also, note the remarkable similarity:

        cg-admin-cat       [-r TREE_ID] FILE...
        cg-admin-ls        [-t TREE_ID] [PATH]

What about joining those to cg-admin-dig or something? (Catting a
directory or ls'ing file contents just feels wrong, although the first
one would make some sense to people not acquainted with UNIX.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox

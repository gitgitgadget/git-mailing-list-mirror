From: Petr Baudis <pasky@suse.cz>
Subject: Re: as promised, docs: git for the confused
Date: Fri, 9 Dec 2005 02:45:20 +0100
Message-ID: <20051209014520.GQ22159@pasky.or.cz>
References: <20051208063409.31967.qmail@science.horizon.com> <200512090047.56754.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 02:46:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkXK9-0006qE-7Z
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 02:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVLIBpO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 20:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVLIBpO
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 20:45:14 -0500
Received: from w241.dkm.cz ([62.24.88.241]:55184 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750752AbVLIBpN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 20:45:13 -0500
Received: (qmail 29207 invoked by uid 2001); 9 Dec 2005 02:45:20 +0100
To: Alan Chandler <alan@chandlerfamily.org.uk>
Content-Disposition: inline
In-Reply-To: <200512090047.56754.alan@chandlerfamily.org.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13410>

Dear diary, on Fri, Dec 09, 2005 at 01:47:56AM CET, I got a letter
where Alan Chandler <alan@chandlerfamily.org.uk> said that...
> On Thursday 08 Dec 2005 06:34, linux@horizon.com wrote:
> > As I mentioned with all my questions, I was writing up the answers
> > I got.  Here's the current status.  If anyone would like to comment on
> > its accuracy or usefulness, feedback is appreciated.
> ...
> > * Background material.
> >
> > To start with, read "man git".  Or Documentation/git.txt in the git
> > source tree, which is the same thing.  Particularly note the description
> > of the index, which is where all the action in git happens.
> >
> > One thing that's confusing is why git allows you to have one version of
> > a file in the current HEAD, a second version in the index, and possibly a
> > third in the working directory.  Why doesn't the index just contain a copy
> > of the current HEAD until you commit a new one?  The answer is merging,
> > which does all its work in the index.  Neither the object database nor
> > the working directory let you have multiple files with the same name.
> 
> 
> If I was a complete newbie, I would be lost right here.  You start refering to 
> the term HEAD without any introduction to what it means and (as far as I 
> could see on a quick glance - which is what a newbie would do - man git 
> doesn't start out here either).

I think that the first paragraph of the background material means
"insert Documentation/git.txt here", the second one is then "now what
might've been unclear there".

That said, the "git for the confused" contains a lot of nice points, but
I don't think it's a good approach to just have extra document for
clarifying this stuff. It would be much better if the stock
documentation itself would not be confusing in the first place. Same
goes for the "commands overview" (BOUND to get out-of-date over time
since it's detached from the normal per-command documentation; we have
troubles huge enough to keep usage strings in sync, let alone the
manpages).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.

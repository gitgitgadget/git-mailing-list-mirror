From: Petr Baudis <pasky@suse.cz>
Subject: Re: git versus CVS (versus bk)
Date: Tue, 1 Nov 2005 18:35:02 +0100
Message-ID: <20051101173502.GA16528@pasky.or.cz>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg> <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org> <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com> <46a038f90510311228v50743158q80d79e963bd503ce@mail.gmail.com> <20051031213003.GN11488@ca-server1.us.oracle.com> <20051101091533.GB11618@pasky.or.cz> <20051101161730.GV11488@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 18:35:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX02R-0005Mu-63
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 18:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbVKARfH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 12:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVKARfG
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 12:35:06 -0500
Received: from w241.dkm.cz ([62.24.88.241]:3763 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751028AbVKARfF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 12:35:05 -0500
Received: (qmail 28313 invoked by uid 2001); 1 Nov 2005 18:35:02 +0100
To: Joel Becker <Joel.Becker@oracle.com>
Content-Disposition: inline
In-Reply-To: <20051101161730.GV11488@ca-server1.us.oracle.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10943>

Dear diary, on Tue, Nov 01, 2005 at 05:17:30PM CET, I got a letter
where Joel Becker <Joel.Becker@oracle.com> told me that...
> On Tue, Nov 01, 2005 at 10:15:33AM +0100, Petr Baudis wrote:
> > Personally, from my POV it is the intended mode of development only if
> > you keep strictly topical branches (a single logical change and fixes of
> > it on top of that). Otherwise, this is horrid because it loses the
> > _precious_ history and bundles us different changes to a single commit,
> > which is one of the thing that are wrong on CVS/SVN merging.
> 
> 	Here we have the "precious" history vs the "throwaway" history
> argument again.  You are correct, this does look like CVS/Subversion
> merging.  But I'm quite capable of keeping my patches single-topic.
> Anything that requires multiple patches in a logical separation still
> needs that extra love.

Well, ok, so I assume you are indeed using strictly topical branches.
.

> > That said, with a big warning, I would be willing to do something like
> > cg-merge -s and cg-update -s (s as squash), with a big warning that this
> 
> 	Wouldn't it be cg-pull?  I guess I'm not conversant enough of
> all ways to merge branches in cogito.

cg-pull just fetches stuff, no merging done.

Ok, in theory you do not actually need to fetch the intermediate history
in case you are going to squash (unless you are going to default the
final commit message to concatenation of the intermediate ones), but
arranging that would not be easy to arrange with the current git tools,
I think. And neither feasible. But actually, I would like to do
something like this later, support for CVS/SVN-like tracking by always
having only the latest tree and no intermediate states, so that people
who just want to run the latest and want to do no development are not
forced to download anything useless for them.

> > is suitable only for topical branches. And I think it'd be still much
> > better to spend the work making StGIT able to track history of changes
> > to a particular patch.
> 
> 	I like quilt for certain work, and what I read from you and
> Caitlin makes me interested in StGIT for those large changes that
> require split-out patches.  But for simple tasks, I just want to use the
> SCM, you know?

Well, if you are already going to deform the history, StGIT (able to
track patch history) is just the best tool for that.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.

From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: git versus CVS (versus bk)
Date: Tue, 1 Nov 2005 08:17:30 -0800
Message-ID: <20051101161730.GV11488@ca-server1.us.oracle.com>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg> <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org> <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com> <46a038f90510311228v50743158q80d79e963bd503ce@mail.gmail.com> <20051031213003.GN11488@ca-server1.us.oracle.com> <20051101091533.GB11618@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 17:21:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWyq4-0003jI-CT
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 17:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVKAQSB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 11:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbVKAQSB
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 11:18:01 -0500
Received: from rgminet03.oracle.com ([148.87.122.32]:25475 "EHLO
	rgminet03.oracle.com") by vger.kernel.org with ESMTP
	id S1750840AbVKAQSA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 11:18:00 -0500
Received: from rgmsgw02.us.oracle.com (rgmsgw02.us.oracle.com [138.1.186.52])
	by rgminet03.oracle.com (Switch-3.1.6/Switch-3.1.7) with ESMTP id jA1GHV7w008849;
	Tue, 1 Nov 2005 09:17:31 -0700
Received: from rgmsgw02.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id jA1GHUF9010226;
	Tue, 1 Nov 2005 09:17:30 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id jA1GHU51010218
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Tue, 1 Nov 2005 09:17:30 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.53)
	id 1EWypG-0004Pi-57; Tue, 01 Nov 2005 08:17:30 -0800
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051101091533.GB11618@pasky.or.cz>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10939>

On Tue, Nov 01, 2005 at 10:15:33AM +0100, Petr Baudis wrote:
> Personally, from my POV it is the intended mode of development only if
> you keep strictly topical branches (a single logical change and fixes of
> it on top of that). Otherwise, this is horrid because it loses the
> _precious_ history and bundles us different changes to a single commit,
> which is one of the thing that are wrong on CVS/SVN merging.

	Here we have the "precious" history vs the "throwaway" history
argument again.  You are correct, this does look like CVS/Subversion
merging.  But I'm quite capable of keeping my patches single-topic.
Anything that requires multiple patches in a logical separation still
needs that extra love.

> That said, with a big warning, I would be willing to do something like
> cg-merge -s and cg-update -s (s as squash), with a big warning that this

	Wouldn't it be cg-pull?  I guess I'm not conversant enough of
all ways to merge branches in cogito.

> is suitable only for topical branches. And I think it'd be still much
> better to spend the work making StGIT able to track history of changes
> to a particular patch.

	I like quilt for certain work, and what I read from you and
Caitlin makes me interested in StGIT for those large changes that
require split-out patches.  But for simple tasks, I just want to use the
SCM, you know?

Joel

-- 

"The cynics are right nine times out of ten."  
        - H. L. Mencken

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

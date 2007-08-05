From: Jeff King <peff@peff.net>
Subject: Re: Terminology question about remote branches.
Date: Sun, 5 Aug 2007 12:45:57 -0400
Message-ID: <20070805164557.GA20721@coredump.intra.peff.net>
References: <854pjfin68.fsf@lola.goethe.zz> <20070804092933.aaec6d52.seanlkml@sympatico.ca> <85ejijgzzg.fsf@lola.goethe.zz> <20070805100532.GG12507@coredump.intra.peff.net> <85172807-B7EB-47DD-813E-FAF5894E1190@zib.de> <20070805110200.GA18083@coredump.intra.peff.net> <85tzre8b4w.fsf@lola.goethe.zz> <20070805115208.GA19734@coredump.intra.peff.net> <85fy2y89kb.fsf@lola.goethe.zz> <20070805124050.c1345ec9.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Aug 05 18:46:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHjF9-0007v4-MU
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 18:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbXHEQqA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 12:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbXHEQqA
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 12:46:00 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1374 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538AbXHEQp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 12:45:59 -0400
Received: (qmail 20984 invoked from network); 5 Aug 2007 16:46:02 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Aug 2007 16:46:02 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Aug 2007 12:45:57 -0400
Content-Disposition: inline
In-Reply-To: <20070805124050.c1345ec9.seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55041>

On Sun, Aug 05, 2007 at 12:40:50PM -0400, Sean wrote:

> To me it's yet another example of bad UI design in Git.   Git already
> had remote-tracking branches, which conceptually were relatively easy
> to explain.  Instead of leveraging this foundation, and adding the
> ability for local branches to pick a default remote-tracking branch
> to use for merging, Git instead implemented direct remote tracking
> from local branches.  After having read the thread Jeff mentioned
> earlier i'm still at a loss as to how this decision was justified.

To be fair, the default remote-tracking branch stuff predates the thread
I pointed you to. But I do agree it makes the system that much more
confusing to have it this way.

There is a clash between users with different workflows here, I think.
For example, I almost _never_ run git-pull, but instead always fetch,
inspect, and then merge from a tracking branch. So I think of tracking
branches as a first-class item. But I suspect Linus doesn't use tracking
branches at all, since he pulls directly from a variety of different
repositories.

-Peff

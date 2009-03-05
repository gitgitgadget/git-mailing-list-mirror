From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: bug in checkout/status ?
Date: Thu, 5 Mar 2009 13:13:53 -0800
Message-ID: <20090305211353.GC16213@spearce.org>
References: <20090305204801.GA16213@spearce.org> <20090305205126.GA19800@coredump.intra.peff.net> <20090305205313.GB16213@spearce.org> <20090305210757.GA20157@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 05 22:15:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfKuZ-0000wH-LT
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 22:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbZCEVN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 16:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbZCEVNz
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 16:13:55 -0500
Received: from george.spearce.org ([209.20.77.23]:45967 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbZCEVNz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 16:13:55 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 63DF638211; Thu,  5 Mar 2009 21:13:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090305210757.GA20157@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112347>

Jeff King <peff@peff.net> wrote:
> On Thu, Mar 05, 2009 at 12:53:13PM -0800, Shawn O. Pearce wrote:
> 
> OK. I was just sort of guessing based on the similarity of the names and
> the fact that sorting is confusing (as evidenced by the fact that I had
> no idea if it was wrong or not). But that is definitely it:

I never would have guessed the sorting was wrong.  But once you
said something, it was immediately obvious to me that JGit f'd up
the tree.
 
> reveal(ed) the difference. But it looks like you have already re-pushed
> a fixed version.

Well, I rewound the repository.  We're rebasing the change onto the
current tip and pushing a fast-forward instead of letting JGit make
a merge commit here.

But JGit still has a bug that causes it to corrupt the tree sorting
here.  I have yet to understand why it produced that bad sort for
this particular merge, let alone propose a patch for it.

Thanks for the help Peff.

-- 
Shawn.

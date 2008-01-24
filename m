From: Willy Tarreau <w@1wt.eu>
Subject: Re: Multiple working trees with GIT ?
Date: Thu, 24 Jan 2008 13:59:05 +0100
Message-ID: <20080124125905.GC13247@1wt.eu>
References: <20080124074952.GA8793@1wt.eu> <Pine.LNX.4.64.0801240947230.14173@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Jan 24 14:30:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI2AP-0003rl-6j
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 14:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbYAXNaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 08:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbYAXNaX
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 08:30:23 -0500
Received: from 1wt.eu ([62.212.114.60]:1589 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbYAXNaW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 08:30:22 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0801240947230.14173@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71618>

Hi Julian,

On Thu, Jan 24, 2008 at 09:59:05AM +0000, Julian Phillips wrote:
(...)
> >This works pretty well. I can simply cd worktree/variant_a and work on a
> >file, or pull master, or even git-cherry-pick from other branches (pretty
> >convenient for this usage). But I don't know what caveats I may encounter.
> 
> You might want to have a look at the git-new-workdir script in contrib, it 
> does basically the same thing.  It's been there for about 10 months now. 
> It was based on an email from Junio:
> 
> http://article.gmane.org/gmane.comp.version-control.git/41513/

Interesting lecture, thanks for the pointer. At least now I know that it is
not too much exotic.

> However, there are some caveats about using this approach, basically about 
> the fact that there is nothing stopping you from updating refs that are 
> currently checked out in another directory and causing yourself all sorts 
> of pain ... the topic has cropped up a couple of times on the list since 
> the script was added.

hmmm good point. Given that I'm used to push into remote working dirs and
to get caught by this problem, I think I would most often escape from the
caveat, but we should take care of not trapping newbies.

> >Maybe there are other solutions too. I see that we tend to replace symlinks
> >everywhere with ref files. We might as well (in a far future version) 
> >accept
> >a file for ".git" which would contain a path to the central repo and the
> >branch's head.
> 
> There was a suggestion for something not too dissimilar even before the 
> new-workdir script:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/33755

OK, thank you for your links. I still think I will wo the easy way for now,
probably using git-new-workdir, waiting for a general consensus on the subject.

Regards,
Willy

From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git vs Monotone
Date: Fri, 1 Aug 2008 14:00:18 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808011344060.19665@iabervon.org>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <bd6139dc0808010023r5d44e7a2ke062c9c39dfb865c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Fri Aug 01 20:01:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOywN-0001UH-80
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 20:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbYHASAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 14:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbYHASAV
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 14:00:21 -0400
Received: from iabervon.org ([66.92.72.58]:51594 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbYHASAU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 14:00:20 -0400
Received: (qmail 20866 invoked by uid 1000); 1 Aug 2008 18:00:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Aug 2008 18:00:18 -0000
In-Reply-To: <bd6139dc0808010023r5d44e7a2ke062c9c39dfb865c@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91076>

On Fri, 1 Aug 2008, Sverre Rabbelier wrote:

> On Thu, Jul 31, 2008 at 20:13, Sverre Rabbelier <alturin@gmail.com> wrote:
> > I just read this blog post [0] in which one of the Pidgin devs sheds
> > his light on their 'tool choice'. In the post he mentions the
> > following figures:
> 
> > [0] http://theflamingbanker.blogspot.com/2008/07/holy-war-of-tool-choice.html
> 
> I have poked him on #pidgin, and he has added the following:
> 
> "Note: It's come to my attention that I had missed the ability to
> share a git database across multiple working copies. In that scenario,
> the total size of the database and 11 working copies is slightly under
> 750 MB, and thus a space savings in the neighborhood of 150 MB over
> monotone. It had been my understanding that I needed a copy of the
> database per working copy. I stand corrected. I don't use git on a
> daily basis, as the projects I work with currently use CVS, SVN, or
> monotone, so I am bound to miss finer details of git here and there.
> There are other reasons I prefer to stick with monotone, but I won't
> get into them here, as they're not important to the point of this
> post."

Did he retry the size calculation? I think someone on the list tried it 
and found that the clone, including the checkout, was (for them) the size 
that he thought was just the database; if you're used to having the clone 
equivalent be effectively --bare by default, it's an easy mistake, 
especially if you don't think it's possible for the entire project history 
to be smaller than a checkout.

Not that it actually matters to the comparison of monotone and SVN that 
was the actual point, but still, git is often more space-efficient than 
SVN even just on the client, even without any sharing between branches, 
just because uncompressed source is (relatively) huge. Which does, in a 
way, contribute to the point that SVN have a vast quantity of per-branch
overhead.

	-Daniel
*This .sig left intentionally blank*

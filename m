From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Common ancestor in merge diffs?
Date: Mon, 26 Jan 2009 14:52:34 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901261412110.19665@iabervon.org>
References: <alpine.LNX.1.00.0901261318030.19665@iabervon.org> <alpine.LFD.2.00.0901261100200.5284@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 26 20:54:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRXWz-0003L6-R7
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 20:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbZAZTwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 14:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbZAZTwg
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 14:52:36 -0500
Received: from iabervon.org ([66.92.72.58]:53923 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbZAZTwf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 14:52:35 -0500
Received: (qmail 30918 invoked by uid 1000); 26 Jan 2009 19:52:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Jan 2009 19:52:34 -0000
In-Reply-To: <alpine.LFD.2.00.0901261100200.5284@localhost.localdomain>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107259>

On Mon, 26 Jan 2009, Linus Torvalds wrote:

> On Mon, 26 Jan 2009, Daniel Barkalow wrote:
> >
> > I was just doing an annoying merge (I'd reorganized code while other 
> > people made changes to it), and I kept having the problem that it was hard 
> > to figure out what each side had done. Is there some way to ask git for 
> > the diffs between the common ancestor (which is unique in my case, so it's 
> > actually useful) and each of the sides of the merge? Ideally, it would 
> > give essentially the converse of the --cc diff: first column is -stage 1 
> > +stage 2; second column is -stage 1 +stage 3.
> 
> Have you tried "gitk --merge [filename]"?
> 
> That's usually even more useful - because it doesn't just give a diff, it 
> gives the actual commits that caused the conflict. That way you see what 
> both sides of a merge tried to do.. It's what I do when encountering 
> conflicts on the kernel (where I'm usually not the author of _either_ side 
> of the code that causes a conflict), and it really is very powerful.

That is really nice, and quite handy. I ended up getting approximately 
that effect with blame and show, but gitk is much easier. For some reason, 
I never think of the graphical tools. Is there an easy way of focusing on 
the changes that end up in a particular conflict? Half of the work was 
finding the right commit and finding the right part of the diff.

	-Daniel
*This .sig left intentionally blank*

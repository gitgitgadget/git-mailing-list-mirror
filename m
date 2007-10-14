From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sun, 14 Oct 2007 16:24:38 -0400
Message-ID: <20071014202438.GC31260@fieldses.org>
References: <853awepyz6.fsf@lola.goethe.zz> <20071013202713.GA2467@fieldses.org> <Pine.LNX.4.64.0710140135020.25221@racer.site> <alpine.LFD.0.999.0710131810550.6887@woody.linux-foundation.org> <20071014014445.GN27899@spearce.org> <3f4fd2640710140320h5c1e1f7gf9f43a626aaa6897@mail.gmail.com> <47125BF7.2070503@midwinter.com> <20071014184050.GB31260@fieldses.org> <471272F5.2000902@op5.se> <Pine.LNX.4.64.0710142117220.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Steven Grimm <koreth@midwinter.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 22:25:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhA1F-0004oI-Ba
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 22:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763480AbXJNUYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 16:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754684AbXJNUYt
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 16:24:49 -0400
Received: from mail.fieldses.org ([66.93.2.214]:55649 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763480AbXJNUYs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 16:24:48 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IhA0s-0004CG-F4; Sun, 14 Oct 2007 16:24:38 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710142117220.25221@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60903>

On Sun, Oct 14, 2007 at 09:18:16PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 14 Oct 2007, Andreas Ericsson wrote:
> 
> > J. Bruce Fields wrote:
> >
> > > Though actually the quickest way to checkout an arbitrary revision is 
> > > with detached heads, and that doesn't require learning git-branch 
> > > right away.
> > 
> > But the *easiest* way, where "easiest" means "involves the fewest 
> > commands with smallest risk of fscking up your own repo", is to do
> > 
> > 
> > git clone <other-devs-repo> other-devs-repo
> > cd other-devs-repo
> > git checkout -b thebug <the-bug-hash>
> 
> I'd just do
> 
> 	git checkout <the-bug>^{commit}
> 
> and be done...

The detached-HEAD approach also has the advantage that you don't leave
around stuff (new branch heads) that may have to be cleaned up or
modified in the future.  So you can tell someone about

	git clone git://url/
	git fetch origin
	git checkout <whatever>
	git remote add remotename git://other-url/
	git fetch remotename

and as long as they're not making changes, that's pretty much all
they'll ever need to do to checkout any version.

Sure, you can tell them to reclone every time, but I think they'll get
frustrated with that pretty soon.

--b.

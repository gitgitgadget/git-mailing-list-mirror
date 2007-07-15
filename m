From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: mtimes of working files
Date: Sat, 14 Jul 2007 21:46:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707142135090.14596@iabervon.org>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com>
 <Pine.LNX.4.64.0707111940080.4516@racer.site> <20070711202615.GE3069@efreet.light.src>
 <200707120857.53090.andyparkins@gmail.com> <1184261246.31598.139.camel@pmac.infradead.org>
 <20070713003700.GA21304@thunk.org> <1184367619.2785.58.camel@shinybook.infradead.org>
 <alpine.LFD.0.999.0707131617270.20061@woody.linux-foundation.org>
 <1184370414.2785.79.camel@shinybook.infradead.org> <20070714222221.GB3678@efreet.light.src>
 <Pine.LNX.4.64.0707142331380.14090@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Hudec <bulb@ucw.cz>, David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 15 03:46:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9tCF-0002T7-T5
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 03:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760534AbXGOBqt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 21:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761469AbXGOBqs
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 21:46:48 -0400
Received: from iabervon.org ([66.92.72.58]:3671 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759065AbXGOBqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 21:46:48 -0400
Received: (qmail 9491 invoked by uid 1000); 15 Jul 2007 01:46:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jul 2007 01:46:47 -0000
In-Reply-To: <Pine.LNX.4.64.0707142331380.14090@beast.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52521>

On Sat, 14 Jul 2007, Julian Phillips wrote:

> On Sun, 15 Jul 2007, Jan Hudec wrote:
> 
> > It would be IMHO possible to symlink all the stuff in .git except HEAD and
> > index, except for one problem. This is if you have two checkouts from the
> > same branch and check out of them, the other one needs to know, that it's
> > head should now be detached to stay where it was.
> 
> You basically just described what the git-new-workdir script in
> contrib/workdir does ... it doesn't address the issue of reference updating.

That's where keeping the index's parents in the index would help. Various 
people have implemented it at various times, but it's never quite become 
sufficiently important to people to have the correct behavior worked out 
and put into mainline. IIRC, not too long ago Junio had an implementation 
in pu, but ended up dropping it because almost nobody would see a difference, 
and the people who did see a difference only had it interfere with what 
they were trying to do.

	-Daniel
*This .sig left intentionally blank*

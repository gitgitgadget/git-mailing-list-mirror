From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Making git disappear when talking about my code
Date: Wed, 25 Apr 2007 17:38:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704251606470.28708@iabervon.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site>
 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704191118050.8822@racer.site>
 <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
 <4627ABBB.8060709@softax.com.pl> <alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org>
 <877is29b1l.wl%cworth@cworth.org> <7vps5ud91x.fsf@assigned-by-dhcp.cox.net>
 <87vefm7l6g.wl%cworth@cworth.org> <alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org>
 <7v1wiabbfr.fsf@assigned-by-dhcp.cox.net> <87mz0w7g3j.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0704251345220.28708@iabervon.org> <7vzm4ww7lj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 23:38:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgpBl-00013P-OA
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 23:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993127AbXDYViK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 17:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993128AbXDYViJ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 17:38:09 -0400
Received: from iabervon.org ([66.92.72.58]:3043 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993127AbXDYViI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 17:38:08 -0400
Received: (qmail 24692 invoked by uid 1000); 25 Apr 2007 21:38:06 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Apr 2007 21:38:06 -0000
In-Reply-To: <7vzm4ww7lj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45584>

On Wed, 25 Apr 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Linus has stated a preference on the lkml for being told about branches in 
> > the syntax used for anonymous pulls: URL branchname.
> >
> > That is, you say:
> >
> >   Please pull from:
> >     git://server/path branch
> >
> > And he cuts and pastes into the command line:
> >
> >   git pull git://server/path branch
> >
> > Now, this syntax isn't available for git-clone, because git-clone puts the 
> > optional directory to create after the URL. But, in an ideal world, this 
> > is how it would work; you could see a pull request, and just type "git 
> > some-command <paste>".
> 
> I think I already suggested this to Carl once, but if you 
> forget about 'git clone' in this case (or any other cases), your
> example would just work.
> 
> 	$ git init
>         $ git pull git://server/path branch

It works for Linus's usage, where he expects to get all the info again 
next time there's more useful stuff. I don't think this configures things 
so that:

	$ git init
	$ git pull git://server/path branch
	... wait a couple of weeks and forget the URL ...
	$ git pull

works. (Although I haven't actually checked, so I could be totally wrong)

	-Daniel
*This .sig left intentionally blank*

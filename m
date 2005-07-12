From: Marc Singer <elf@buici.com>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 21:43:53 -0700
Message-ID: <20050712044352.GA9919@buici.com>
References: <20050708230750.GA23847@buici.com> <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org> <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org> <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org> <20050712021004.GA27576@buici.com> <Pine.LNX.4.58.0507112005540.17536@g5.osdl.org> <Pine.LNX.4.58.0507112045420.17536@g5.osdl.org> <Pine.LNX.4.58.0507112132170.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 06:44:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsCci-0008FP-4d
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 06:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVGLEnz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 00:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVGLEnz
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 00:43:55 -0400
Received: from florence.buici.com ([206.124.142.26]:8347 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262126AbVGLEnz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 00:43:55 -0400
Received: (qmail 9974 invoked by uid 1000); 12 Jul 2005 04:43:53 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507112132170.17536@g5.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 11, 2005 at 09:34:33PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 11 Jul 2005, Linus Torvalds wrote:
> > 
> >     Of course, if you want to create a new branch "my-branch" and _not_
> >     check it out, you could have done so with just
> > 
> >         git-rev-parse v2.6.12^0 > .git/refs/heads/my-branch
> > 
> >     which I think I will codify as "git branch".
> 
> And now we have that "git branch". It's a trivial one-liner, except with
> the setup and error checking it's actually more like six lines.

Does it make sense to think about this branch as an flow of commits?
Or is it just a starting point for a line of development?  If I make a
branch, check it out, commit changes to it, and then clobber the
working directory, can I later resume that branch of development
without creating a new branch?  Do I need to set a tag to mark the
last commit on that branch?

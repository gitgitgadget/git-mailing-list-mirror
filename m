From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [3/5] Add http-pull
Date: Sun, 17 Apr 2005 21:59:00 +0200
Message-ID: <20050417195900.GH1461@pasky.ji.cz>
References: <20050417190824.GF1461@pasky.ji.cz> <Pine.LNX.4.21.0504171510120.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 21:58:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNFuR-000679-4u
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 21:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVDQUB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 16:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVDQUA1
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 16:00:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25238 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261456AbVDQT7C (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 15:59:02 -0400
Received: (qmail 12917 invoked by uid 2001); 17 Apr 2005 19:59:00 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504171510120.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 09:24:27PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> On Sun, 17 Apr 2005, Petr Baudis wrote:
> 
> > Dear diary, on Sun, Apr 17, 2005 at 08:49:11PM CEST, I got a letter
> > where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > > There's some trickiness for the history of commits thing for stopping at
> > > the point where you have everything, but also behaving appropriately if
> > > you try once, fail partway through, and then try again. It's on my queue
> > > of things to think about.
> > 
> > Can't you just stop the recursion when you hit a commit you already
> > have?
> 
> The problem is that, if you've fetched the final commit already, and then
> the server dies, and you try again later, you already have the last one,
> and so you think you've got everything.

Hmm, some kind of journaling? ;-)

> At this point, I also want to put off doing much further with recursion
> and commits until revision.h and such are sorted out.

Agreed.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

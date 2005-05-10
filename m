From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Core and Not-So Core
Date: Wed, 11 May 2005 01:08:44 +0200
Message-ID: <20050510230844.GG26384@pasky.ji.cz>
References: <2cfc40320505100800426d38ca@mail.gmail.com> <Pine.LNX.4.21.0505101743520.30848-100000@iabervon.org> <2cfc40320505101605721420@mail.gmail.com> <2cfc4032050510160578b81fa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 01:02:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVdjC-00022M-KC
	for gcvg-git@gmane.org; Wed, 11 May 2005 01:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVEJXIv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 19:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVEJXIv
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 19:08:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:14249 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261848AbVEJXIp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 19:08:45 -0400
Received: (qmail 9119 invoked by uid 2001); 10 May 2005 23:08:44 -0000
To: Jon Seymour <jon.seymour@gmail.com>
Content-Disposition: inline
In-Reply-To: <2cfc4032050510160578b81fa7@mail.gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, May 11, 2005 at 01:05:55AM CEST, I got a letter
where Jon Seymour <jon.seymour@gmail.com> told me that...
> >
> > > I think it would be worthwhile if care was taken to draw a distinction
> > > between the repository and the cache aspects of the git core, perhaps
> > > even going to the extreme of moving all knowledge of the  cache into
> > > cogito itself. By clearly drawing this distinction, we will more
> > > easily enable the creation of different kind of tools sets atop the
> > > foundation of the GIT repository format.
> >
> > I think this is nonsensical. The cache format is tied to the way in which
> > the repository accessing code is written, so a git-core separate from the
> > cache wouldn't have a useful set of code.
> >
> 
> I guess I agree it is somewhat nonsensical if one considers the
> current git toolset as a collection of programs - the exercise now
> might simply reduce to classifying git tools as
> index-using/non-index-using and nothing more. However, it might be
> worth keeping in mind when/if the "libification" of git happens so
> that there is a clean separation of layers in the API between the
> repository API and index/cache/workspace API.

In that case the repository API's input/output is data structure
equivalent to the index, and workspace API's input/output is the index
too. That is what it really is - and it is kept on the disk only since
the commands are invoked separately so it needs to keep the state around
somewhere.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

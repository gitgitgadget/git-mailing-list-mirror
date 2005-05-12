From: James Purser <purserj@ksit.dynalias.com>
Subject: Re: [RFC] Support projects including other projects
Date: Thu, 12 May 2005 16:33:50 +1000
Message-ID: <1115879630.3085.40.camel@kryten>
References: <Pine.LNX.4.21.0505120137200.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu May 12 08:24:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW773-0002fb-8W
	for gcvg-git@gmane.org; Thu, 12 May 2005 08:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVELGbk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 02:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVELGbk
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 02:31:40 -0400
Received: from dsl-202-52-56-051.nsw.veridas.net ([202.52.56.51]:62594 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261202AbVELGbg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 02:31:36 -0400
Received: from localhost.localdomain (kryten [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11) with ESMTP id j4C6Xp41005489
	for <git@vger.kernel.org>; Thu, 12 May 2005 16:33:51 +1000
Received: (from purserj@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j4C6XowM005488
	for git@vger.kernel.org; Thu, 12 May 2005 16:33:50 +1000
X-Authentication-Warning: localhost.localdomain: purserj set sender to purserj@ksit.dynalias.com using -f
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0505120137200.30848-100000@iabervon.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've really got remember that reply to all option.
On Thu, 2005-05-12 at 15:46, Daniel Barkalow wrote:
> On Thu, 12 May 2005, James Purser wrote:
> 
> > On Thu, 2005-05-12 at 15:19, Daniel Barkalow wrote:
> > > If you think about it as git and cogito being entirely separate
projects,
> > > where users would be expected to have the right version of git
most of the
> > > time (or ever), this is true. But I think that cogito is as
closely tied
> > > to git as the kernel is to kbuild or kconfig; the difference is
that git
> > > is not solely available with cogito, like kbuild is solely
available with
> > > the kernel.
> > I tend to disagree with you on this point. Cogito and Git share
> > arelationship more akin to xorg and gnome and this is something I
think
> > Linus intended so that it would be very easy to build a layer on top
of
> > the git toolset. Cogito is great and it fills a need but give it
time
> > and other implementations and tool sets will come along that may
> > supersede it.
> 
> The point of this feature is to support other implementations and tool
> sets. If there weren't other things using the git core, there would be
no
> reason to leave the current situation where cogito simply includes the
> complete contents of git-pb. The relationship between cogito and git
is,
> however, not at all like that between Gnome and x.org; gnome could not
be
> started until X was essentially completely stable for several years
(after
> which X could be reimplemented and extended, so long as it retained
the
> same API). Cogito, on the other hand, is being developed concurrently
with
> git, and substantially informs git development. The current cogito
doesn't
> work completely correctly with any mainline git, whereas the current
Gnome
> works with every x.org release as well as any XFree86 or most other X
> servers since the mid 90's.
> 
> Also, any particular user is probably only going to use one git-based
> system, but will almost certainly use many different X clients.
> 
>       -Daniel
> *This .sig left intentionally blank*
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Okay the gnome/xorg is a bad example the point I was trying to get
across was that cogito and git are not as intertwined as you say, if
development of cogito stopped tomorrow then git would keep going and
another second layer app would take its place.

Yes cogito helps with git development as it provides a great way to test
different situations in a different environment than you would normally
get by running the bare git tools your self.

The way I have been reading things (and I may be wrong about this, it
wouldn't be the first time :)) is that git is THE base line providing
the necessary tools and structure for anyone who wishes to build an
application on top. Cogito is an example of that second layer app, built
on top of the toolset and still able to talk to non cogito managed
trees. Sort of like CVS and its various client implentations (Command
Line, GCVS etc).

Again I may have gotten things arse about, if I have then I blame lack
of sleep :)
-- 
James Purser
http://ksit.dynalias.com


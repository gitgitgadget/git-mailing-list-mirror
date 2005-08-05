From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Terminology
Date: Sat, 6 Aug 2005 01:08:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508060107350.10873@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.58.0507311541340.29235@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vhdeaj05n.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508051655480.8418@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508051104510.3258@g5.osdl.org> <Pine.LNX.4.62.0508051531400.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 01:11:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1BKB-00009P-1V
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 01:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVHEXJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 19:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVHEXJQ
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 19:09:16 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:17536 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262027AbVHEXIx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2005 19:08:53 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 68ED1E1BC6; Sat,  6 Aug 2005 01:08:49 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4FD0F98DE8; Sat,  6 Aug 2005 01:08:49 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 38FDA98DBF; Sat,  6 Aug 2005 01:08:49 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F396AD857D; Sat,  6 Aug 2005 01:08:48 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: barkalow@iabervon.org
In-Reply-To: <Pine.LNX.4.62.0508051531400.23721@iabervon.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 5 Aug 2005, barkalow@iabervon.org wrote:

> On Fri, 5 Aug 2005, Linus Torvalds wrote:
> 
> > On Fri, 5 Aug 2005, Johannes Schindelin wrote:
> > 
> > >   - The files under $GIT_DIR/refs record object names, and are
> > >     called "refs".  What is under refs/heads/ are called "heads",
> > >     refs/tags/ "tags".  Typically, they are either object names
> > >     of commit objects or tag objects that resolve to commit
> > >     objects, but a tag can point at any object.
> > > 
> > > The tutorial never calls them "refs", but instead "references".
> > 
> > It might be worth saying explicitly that a reference is nothing but the 
> > same thing as a "object name" aka "sha1".
> 
> Well, it's an object name stored in a file. This adds a layer of 
> indirection and a meaningful name.

Yes.

> > So I'd vote for making the suggested definition official: "fetch" means
> > fetching the data, and "pull" means "fetch + merge". 
> 
> So what's the converse of "fetch" (to rename git-ssh-push to)? 
> Maybe "ship"?

I actually like "push". You know, not everybody agrees that "push" is the 
opposite of "pull"...

Ciao,
Dscho

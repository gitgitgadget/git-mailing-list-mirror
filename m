From: Marc Singer <elf@buici.com>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 15:20:46 -0700
Message-ID: <20050711222046.GA21376@buici.com>
References: <20050708230750.GA23847@buici.com> <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 00:42:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds6xK-0008MA-NM
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 00:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbVGKW1z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 18:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVGKWXf
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 18:23:35 -0400
Received: from florence.buici.com ([206.124.142.26]:12439 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262943AbVGKWUs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 18:20:48 -0400
Received: (qmail 21539 invoked by uid 1000); 11 Jul 2005 22:20:46 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 08, 2005 at 06:43:54PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 8 Jul 2005, Marc Singer wrote:
> >
> > In working through a usage example on my way to producing bonafide
> > patches, I've found that commit is complaining.  Here's what I've done.
> > 
> >   o Fetched and built cogito-0.12
> >   o Fetched (rsync) Linus' tree
> >   o Created a working directory, linux-2.6
> >   o linked .git in the working directory to the .git directory fetched
> >     from the net.
> >   o # git checkout -f v2.6.11
> 
> This won't work.
> 
> v2.6.11 isn't a commit, it's a tree, and things will go downhill from 
> there. 
> 
> Can you base it on 2.6.12-rc2 or later? That's the earliest with some real 
> git history.

I picked 2.6.12

  # git checkout -f v2.6.12

applied the patch and was greeted with an error about being unable to
commit telling me that I LONG_HEX_NUMBER is not a valid commit object.
Isn't 2.6.12 later than 2.6.12-rcX?

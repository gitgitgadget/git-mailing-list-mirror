From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [RFC] undo and redo
Date: Thu, 25 Aug 2005 15:42:08 -0600
Organization: Hewlett Packard
Message-ID: <20050825214208.GB3311@hpsvcnb.fc.hp.com>
References: <Pine.LNX.4.63.0508241634350.23242@iabervon.org> <20050824204736.GA13194@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508241651420.23242@iabervon.org> <7vd5o3ar4a.fsf@assigned-by-dhcp.cox.net> <20050825024134.GA31886@hpsvcnb.fc.hp.com> <7v1x4izjtm.fsf@assigned-by-dhcp.cox.net> <20050825163201.GA3944@hpsvcnb.fc.hp.com> <20050825195918.GD7461@birddog.com> <20050825203733.GA26539@hpsvcnb.fc.hp.com> <20050825210929.GF7461@birddog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 23:44:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8PUQ-00063M-5u
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 23:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVHYVmX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 17:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVHYVmX
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 17:42:23 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:53224 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S964859AbVHYVmW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2005 17:42:22 -0400
Received: from smtp1.fc.hp.com (smtp1.fc.hp.com [15.15.136.127])
	by atlrel9.hp.com (Postfix) with ESMTP id 6776E14FDC;
	Thu, 25 Aug 2005 17:42:18 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP
	id 0AE243854C; Thu, 25 Aug 2005 21:42:13 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id E5E5F2B091; Thu, 25 Aug 2005 15:42:08 -0600 (MDT)
To: "Kirby C. Bohling" <kbohling@birddog.com>
Content-Disposition: inline
In-Reply-To: <20050825210929.GF7461@birddog.com>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7768>

On Thu, Aug 25, 2005 at 04:09:29PM -0500, Kirby C. Bohling wrote:
> I guess I can see that.  I just see it as much easier to manage
> multiple undo-redo states manually.  I mean, I wouldn't make anyone
> use git directly if the difference between the two commands bothers
> them.  git seems too low a level.  I would think one of the
> procelains would be be a better level.  However, having a unified
> interface for all the porcelains seems a reasonable request.

Maybe Porcelain is the right place for it.  The question would be "Is it
important that porcelains handle undo/redo in a way that interoperates?"

> > 
> > Is there something wrong with having flexibility?  It seems most of the
> > criticism of this feature is that there is already a way to accomplish
> > what I want to do.  Tools that can't be used flexibly are not tools that
> > I like to use.  Heck, I'm on UNIX aren't I?
> > 
> > Oops, sorry for the rant.  I'm really not in a bad mood... really.  I
> > hope it didn't sound like that :-).  Oh, and I didn't mean to suggest
> > that git is not flexible in other regards.  I think its great!  Moving
> > along...
> > 
> > > Assuming your patch creation and application tools capture all the
> > > meta-data the SCM has (which I believe git does), it's pretty simple
> > > to simulate what you want manaully.  With only a handful of
> > > commands.
> > 
> > I can simulate git manually too with just a few more commands.  Where's
> > the cutoff?

This analogy *was* a bit extreme.

Cheers,
Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

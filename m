From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [RFC] undo and redo
Date: Thu, 25 Aug 2005 15:28:51 -0600
Organization: Hewlett Packard
Message-ID: <20050825212851.GA3311@hpsvcnb.fc.hp.com>
References: <Pine.LNX.4.63.0508241634350.23242@iabervon.org> <20050824204736.GA13194@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508241651420.23242@iabervon.org> <7vd5o3ar4a.fsf@assigned-by-dhcp.cox.net> <20050825024134.GA31886@hpsvcnb.fc.hp.com> <7v1x4izjtm.fsf@assigned-by-dhcp.cox.net> <20050825163201.GA3944@hpsvcnb.fc.hp.com> <20050825195918.GD7461@birddog.com> <7vmzn5vkg6.fsf@assigned-by-dhcp.cox.net> <20050825204930.GE7461@birddog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Carl Baldwin <cnb@fc.hp.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 23:30:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8PHr-0003E8-A8
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 23:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVHYV3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 17:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbVHYV3Y
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 17:29:24 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:46471 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S964773AbVHYV3Y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2005 17:29:24 -0400
Received: from smtp2.fc.hp.com (smtp2b.fc.hp.com [15.15.136.253])
	by atlrel7.hp.com (Postfix) with ESMTP id E5FE2346;
	Thu, 25 Aug 2005 17:28:56 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id 8E4CD41E629; Thu, 25 Aug 2005 21:28:51 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 7D8EA2B091; Thu, 25 Aug 2005 15:28:51 -0600 (MDT)
To: "Kirby C. Bohling" <kbohling@birddog.com>
Content-Disposition: inline
In-Reply-To: <20050825204930.GE7461@birddog.com>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7766>

On Thu, Aug 25, 2005 at 03:49:30PM -0500, Kirby C. Bohling wrote:
> On Thu, Aug 25, 2005 at 01:19:05PM -0700, Junio C Hamano wrote:
> > "Kirby C. Bohling" <kbohling@birddog.com> writes:
>     Just out of curiosity, why isn't the SHA1 of 'A' part of the
> diff or patch format?  I mean it can't be that hard to add it as a
> single line of data that git can parse to extract that piece of
> information.  Then a patch would enable you to do the 3-way merge
> you describe.  If added properly "regular" patch would just ignore
> that line.  The patch would then record that it is relative to 'A'.

Not a bad idea.  It could be ignored in most cases and used when needed.

Carl

>     Assuming git could be taught "git-merge-patch" and then take use
> the patch that's saved during the "undo" step and has the anchor for
> the patch to use as the pivot point (as described above).  Life
> should be good.  There are probably corner cases I don't understand,
> but it sure looks like if you have the pivot or anchor point for the
> patch embedded in the patch, you have all the needed information to
> pull this off.
> 
>     I would think this would be generally useful outside of the
> context of "undo/redo" also.
> 
>     Kirby
> 
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

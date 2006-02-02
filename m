From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: Two ideas for improving git's user interface
Date: Thu, 2 Feb 2006 09:30:12 -0700
Organization: Hewlett Packard
Message-ID: <20060202163012.GB10937@hpsvcnb.fc.hp.com>
References: <Pine.LNX.4.64.0601311750270.25300@iabervon.org> <7vek2oot7z.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601311623240.7301@g5.osdl.org> <7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602011125370.5397@localhost.localdomain> <7vhd7ibza2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602011307250.21884@g5.osdl.org> <7v8xsu91vf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602011433290.21884@g5.osdl.org> <87lkwupsbr.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 17:32:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4hMP-0006Dr-3e
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 17:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWBBQap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 11:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWBBQap
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 11:30:45 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:60618 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932137AbWBBQaQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 11:30:16 -0500
Received: from smtp2.fc.hp.com (smtp2-c.fc.hp.com [15.15.136.253])
	by atlrel6.hp.com (Postfix) with ESMTP id 36D1537D13;
	Thu,  2 Feb 2006 11:30:13 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id 70CB341EC6C; Thu,  2 Feb 2006 16:30:12 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 6287D9B21; Thu,  2 Feb 2006 09:30:12 -0700 (MST)
To: Carl Worth <cworth@cworth.org>
Mail-Followup-To: Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <87lkwupsbr.wl%cworth@cworth.org>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15509>

On Wed, Feb 01, 2006 at 03:33:44PM -0800, Carl Worth wrote:
> 	Is it ever useful (reasonable, desirable) to commit file
> 	contents that differ from the contents of the working
> 	directory?

What _is_ useful about the status quo is the ability to make some minor
change, update that change to the index when I've decided that it is a
good change and then use git diff to see what I've incrementally changed
in the same file since that update.  That way new incremental changes
can be viewed independantly of the change I've already decided was good.

> What I would love to have is the ability to pass the same arguments to
> git diff to get a preview of what any get commit would do. For
> example, something like:
> 
> 	git diff		# would be a preview of:
> 	git commit

'git diff --cached' does this.

> 	git diff -a		# would be a preview of:
> 	git commit -a

'git diff HEAD' does this.

> 	git diff fileA fileB	# would be a preview of:
> 	git commit fileA fileB

Paths can be specified in conjunction with the above commands.

Yes, these are idioms specific to git and are not immediately intuitive
to the new user.  However, if the user has access to a good tutorial
that walks through these scenerios its not so bad.

Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        RADCAD (R&D CAD)
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

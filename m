X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 16:59:38 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611151656300.2591@xanadu.home>
References: <87k61yt1x2.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
 <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <200611151858.51833.andyparkins@gmail.com>
 <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
 <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
 <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org>
 <Pine.LNX.4.64.0611151516360.2591@xanadu.home>
 <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org>
 <87velgs9hx.wl%cworth@cworth.org> <7virhgjt25.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611151638550.2591@xanadu.home>
 <7vac2sjs28.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 15 Nov 2006 22:00:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vac2sjs28.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31510>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkSnN-0001ut-FL for gcvg-git@gmane.org; Wed, 15 Nov
 2006 22:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161807AbWKOV7k (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 16:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161808AbWKOV7k
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 16:59:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42053 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1161807AbWKOV7j
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 16:59:39 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8S008RHL3EKL30@VL-MO-MR004.ip.videotron.ca> for git@vger.kernel.org; Wed,
 15 Nov 2006 16:59:39 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Wed, 15 Nov 2006, Junio C Hamano wrote:
> >
> >> I am wondering if that could be "git merge <committish>..."
> >> instead.  I do not care too much about the ... part (i.e. an
> >> Octopus), but I often find myself doing:
> >> 
> >> 	git checkout next
> >>         git merge "Merge early part of branch 'foo'" HEAD foo~3
> >> 
> >> when earlier part of "foo" topic are worthy to be in 'next' but
> >> not the later ones.
> >
> > Indeed !
> 
> Indeed, what?

What you propose would be excellent indeed.

> That means that updated "git merge" (not the current one) would
> not be able to assume it's parameter is a branch name, and still
> has to come up with the merge message "Merge <branch>".
> 
> Merging only within the local branch namespace already has the
> problem you need to solve to come up with a nicely formatted
> "Merge <branch> of <remote repository>" some way.  I am not
> saying that this is unsolvable (you can look at remotes/ files
> to see what remote tracking branch the branch is about), but
> something you need to keep in mind when implementing the
> improved "git merge".

Right.  But that is an _implementation_ detail, not a usability issue.



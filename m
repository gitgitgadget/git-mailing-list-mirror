X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Tue, 28 Nov 2006 23:33:59 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611282322320.9647@xanadu.home>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
 <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net> <87bqmswm1e.wl%cworth@cworth.org>
 <7vodqse90q.fsf@assigned-by-dhcp.cox.net> <87ac2cwha4.wl%cworth@cworth.org>
 <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net> <878xhwwdyj.wl%cworth@cworth.org>
 <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
 <7vd5786opj.fsf@assigned-by-dhcp.cox.net> <871wnnwi3k.wl%cworth@cworth.org>
 <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 29 Nov 2006 04:34:17 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32615>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpH92-0002Rp-U9 for gcvg-git@gmane.org; Wed, 29 Nov
 2006 05:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758775AbWK2EeA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 23:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758777AbWK2EeA
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 23:34:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49550 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1758775AbWK2EeA
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 23:34:00 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9H0083C60NPBN0@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Tue,
 28 Nov 2006 23:33:59 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tue, 28 Nov 2006, Junio C Hamano wrote:

> What you do _not_ have to worry about all the time is the local
> changes you do not want to go in your next commit but still want
> to keep in your working tree.

This argument has its converse.  What you should _not_ have to worry 
about all the time is whether your index really includes all the changes 
you want included in your next commit.

And whether wanting to leave local changes in the working directory 
without commiting them actually happen more often than wanting to commit 
every changes is arguable.

What should be pretty consensual though, is the fact that having 
experienced GIT users add an alias for "commit" actually becoming "comit 
-i" to preserve the current behavior is much easier than asking new GIT 
users do the same but with "commit -a".

So in that context I think having commit without arguments meaning 
commit -a is a pretty sensible default.  And I don't think it has any 
influence on the "learning about the index" issue.



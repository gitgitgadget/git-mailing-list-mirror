X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 17:46:22 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611301740540.9647@xanadu.home>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home>
 <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net> <87ejrlvn7r.wl%cworth@cworth.org>
 <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org>
 <20061130164046.GB17715@thunk.org>
 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org>
 <Pine.LNX.4.64.0611301229290.9647@xanadu.home>
 <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org>
 <7vac28h898.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 30 Nov 2006 22:46:57 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, Linus Torvalds <torvalds@osdl.org>,
	Theodore Tso <tytso@mit.edu>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vac28h898.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32824>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpufj-0000U9-78 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031603AbWK3WqY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031605AbWK3WqY
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:46:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21814 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1031603AbWK3WqX
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:46:23 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9K006UGF9A4Q90@VL-MO-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 30 Nov 2006 17:46:23 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thu, 30 Nov 2006, Junio C Hamano wrote:

> What this will "achieve" is:
> 
>  $ git add hello.c ;# index remembers the path
>  $ git diff ;# nothing -- it sees 0{40} and 0{40} on both sides
>  $ edit hello.c
>  $ git diff ;# still nothing
>  $ git commit ;# takes the content of 'hello.c' at this point
>  
> This is a non-trivial amount of work but not a rocket science.
> It is however of a negative value that helps the users stick to
> the "filename matters more than content" mindset.

And personally I think this bastardizes the index.

I think so far the index is not a problem.  the problem is in the UI and 
in the doc.  With a "git add" as I described it I don't think the user 
will ask for such thing.

And let's have a "git diff --commit" be a much meaningful alias for the 
appropriate diff argument (which argument I always forget about myself) 
needed to show what is going to be committed.



X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 11:27:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611301124260.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
 <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net> <87bqmswm1e.wl%cworth@cworth.org>
 <7vodqse90q.fsf@assigned-by-dhcp.cox.net> <87ac2cwha4.wl%cworth@cworth.org>
 <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net> <878xhwwdyj.wl%cworth@cworth.org>
 <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net>
 <871wnnwi3k.wl%cworth@cworth.org> <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
 <87ejrlvn7r.wl%cworth@cworth.org> <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 10:28:32 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Carl Worth <cworth@cworth.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32718>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpj96-0005UZ-Ql for gcvg-git@gmane.org; Thu, 30 Nov
 2006 11:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934487AbWK3K16 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 05:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934524AbWK3K16
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 05:27:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:6273 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S934487AbWK3K15 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 05:27:57 -0500
Received: (qmail invoked by alias); 30 Nov 2006 10:27:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp012) with SMTP; 30 Nov 2006 11:27:55 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 29 Nov 2006, Linus Torvalds wrote:

> So where doing the "git apply --index" thing is great is when you see a 
> patch that has some obvious deficiency that makes you not want to commit 
> it directly, but add some fixup of your own.

An obvious deficiency would also be the presence of hundreds of debug 
quirks I had to introduce to find the bug which I finally fixed. But I do 
not want to commit, because it is such a mess. So: into the index, ye 
files.

Now I can clean up everything I introduced to find the bug. If the result 
does not work as expected? "git diff"!

But now that I cleaned up the mess, I find that there is a more elegant 
way to solve the problem. Into the  index, ye files! Clicketyclick, if I 
mess up, I always have the state in the index!

Ciao,
Dscho

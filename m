X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 12:09:27 +0100
Message-ID: <456EBBE7.8030404@op5.se>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home> <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net> <87bqmswm1e.wl%cworth@cworth.org> <7vodqse90q.fsf@assigned-by-dhcp.cox.net> <87ac2cwha4.wl%cworth@cworth.org> <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net> <878xhwwdyj.wl%cworth@cworth.org> <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net> <871wnnwi3k.wl%cworth@cworth.org> <7virgzuf38.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net> <87ejrlvn7r.wl%cworth@cworth.org> <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net> <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 11:09:40 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32722>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpjnI-0007eW-BG for gcvg-git@gmane.org; Thu, 30 Nov
 2006 12:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936067AbWK3LJ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 06:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936068AbWK3LJ3
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 06:09:29 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:60356 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S936067AbWK3LJ2 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 06:09:28 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 5FDA96BCC2; Thu, 30 Nov 2006 12:09:27 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> That said, I have to admit that I usually (a) don't do this very often (ie 
> this is not part of my daily routine) and (b) I tend to do "git reset" 
> fairly soon afterwards (or alternatively, just "git commit -a") to get 
> back to the situation where the index will match the current HEAD 100% 
> again. So the "index doesn't match HEAD" situation is always just a 
> _temporary_ thing for me.
> 

A staging area is per definition meant to keep temporary things before 
they are committed to their designated place so there's nothing odd 
about that.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se

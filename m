X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Wed, 29 Nov 2006 12:39:56 -0800
Message-ID: <7vlkluoulf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
	<87bqmswm1e.wl%cworth@cworth.org>
	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>
	<87ac2cwha4.wl%cworth@cworth.org>
	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>
	<878xhwwdyj.wl%cworth@cworth.org>
	<7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
	<7vd5786opj.fsf@assigned-by-dhcp.cox.net>
	<871wnnwi3k.wl%cworth@cworth.org>
	<7virgzuf38.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611282322320.9647@xanadu.home>
	<7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611291234350.9647@xanadu.home>
	<7vzmaaozi8.fsf@assigned-by-dhcp.cox.net>
	<456DDADC.7030509@midwinter.com>
	<Pine.LNX.4.63.0611292059480.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 20:40:28 +0000 (UTC)
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Steven Grimm <koreth@midwinter.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611292059480.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 29 Nov 2006 21:01:11 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32664>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpWDq-0007q1-88 for gcvg-git@gmane.org; Wed, 29 Nov
 2006 21:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967662AbWK2Uj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 15:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967661AbWK2Uj6
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 15:39:58 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:23277 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S967660AbWK2Uj6
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 15:39:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061129203957.LSFJ20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Wed, 29
 Nov 2006 15:39:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id skg51V00u1kojtg0000000; Wed, 29 Nov 2006
 15:40:06 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 29 Nov 2006, Steven Grimm wrote:
>
>> More likely they will start wondering the instant you tell them to use 
>> it the first time. Or at least they'll ask, "If '-a' means commit all 
>> files, what's the default?" And then you either have to blow off the 
>> question or start telling them about the index.
>
> So what? Tell them that there is a staging area, which makes many 
> operations of git very powerful and fast. And this staging area is called 
> "the index" in git. And to put some files into it, specify those 
> files. If you want _all_ modified files there, use "-a". That's it.

Well said.

I think I have stated my preference and reasoning clearly enough
on this topic, so I won't waste my time repeating them.  My time
is better spent on _listening_ to people who might want to make
convincing arguments to influence what I will end up deciding
(the final decision will be mine anyway).

By the way, I've been having fun with the xdl_merge() stuff;
thanks for a job well done.  I will push some of it out in 'pu'
shortly.

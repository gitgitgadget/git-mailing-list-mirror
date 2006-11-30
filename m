X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 13:19:08 -0800
Message-ID: <7vhcwgiqer.fsf@assigned-by-dhcp.cox.net>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611282322320.9647@xanadu.home>
	<7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
	<87ejrlvn7r.wl%cworth@cworth.org>
	<7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
	<7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0611291859070.3513@woody.osdl.org>
	<456EBBE7.8030404@op5.se>
	<Pine.LNX.4.64.0611300749560.3513@woody.osdl.org>
	<20061130164046.GB17715@thunk.org>
	<Pine.LNX.4.64.0611300903080.3513@woody.osdl.org>
	<Pine.LNX.4.64.0611301229290.9647@xanadu.home>
	<87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611301132350.3513@woody.osdl.org>
	<Pine.LNX.4.64.0611301521320.9647@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 21:19:30 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Carl Worth <cworth@cworth.org>,
	Theodore Tso <tytso@mit.edu>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611301521320.9647@xanadu.home> (Nicolas Pitre's
	message of "Thu, 30 Nov 2006 15:47:20 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32800>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GptJK-00066i-Sc for gcvg-git@gmane.org; Thu, 30 Nov
 2006 22:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031507AbWK3VTL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 16:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031520AbWK3VTL
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 16:19:11 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:33247 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1031507AbWK3VTJ
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 16:19:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061130211909.OYOV20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Thu, 30
 Nov 2006 16:19:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id t9KH1V00e1kojtg0000000; Thu, 30 Nov 2006
 16:19:18 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> ...  But let me repeat my last question:
>
> Would it make sense for "git add" to do the same as "git update-index" 
> on already tracked files?  Given the explanation above this would make 
> 100% sense to me.

I think this makes sense and what we did in the original "git
add".

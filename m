X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 14:47:51 -0800
Message-ID: <7vy7psft60.fsf@assigned-by-dhcp.cox.net>
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
	<Pine.LNX.4.64.0611301253380.3513@woody.osdl.org>
	<eknhjr$nce$1@sea.gmane.org> <878xhsty3t.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 22:49:02 +0000 (UTC)
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Theodore Tso <tytso@mit.edu>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <878xhsty3t.wl%cworth@cworth.org> (Carl Worth's message of "Thu,
	30 Nov 2006 13:37:26 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32826>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpuhA-0000mv-9x for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031606AbWK3Wrx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031608AbWK3Wrx
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:47:53 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37597 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1031606AbWK3Wrx
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:47:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061130224752.GLGZ7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Thu, 30
 Nov 2006 17:47:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id tAo01V00m1kojtg0000000; Thu, 30 Nov 2006
 17:48:01 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

> I'm happy with the direction of having several commands that take the
> place of update-index, each with its own name oriented toward what the
> user wants to do.
>
> Obviously, "add", "mv", and "rm" have obvious places where the user
> wants to use them.
>
> There's the merge case where "resolve" and "resolved" have both been
> floated as possible names.
>
> It might even make sense to invent one more name for the case where
> the user wants to inform git that a file has been edited and that git
> should accept the new contents. It's the sort of "note that file is
> edited" operation that could be recommended to the user with "add; fix
> typo; commit" confusion.
>
> Sure, "add" could be used again, and "update-index" clearly _works_
> but it's a rather ugly name, (and already has "plumbing" functionality
> like --add and --remove that we don't want here).

checkin.

You check things into index with "git checkin" and later commit
the index with "git commit".


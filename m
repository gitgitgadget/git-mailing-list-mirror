X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 09:59:49 -0800
Message-ID: <7vfyckoaju.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org>
	<7virhhy76h.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142048350.2591@xanadu.home>
	<200611150917.23756.andyparkins@gmail.com>
	<Pine.LNX.4.64.0611151023160.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 18:00:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611151023160.2591@xanadu.home> (Nicolas Pitre's
	message of "Wed, 15 Nov 2006 10:41:34 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31454>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkP3R-0007lV-Dp for gcvg-git@gmane.org; Wed, 15 Nov
 2006 19:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030785AbWKOR7w (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 12:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030781AbWKOR7w
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 12:59:52 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:33427 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1030785AbWKOR7v
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 12:59:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115175950.MLXG27894.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 12:59:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id n5zw1V00a1kojtg0000000; Wed, 15 Nov 2006
 12:59:57 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> But again I think it is important that the URL to use must be a per 
> branch attribute i.e. attached to "default/master" and not just 
> "default".  This way someone could add all branches of interest into the 
> "default" group even if they're from different repositories, and a 
> simple  get without any argument would get them all.

I think the "one group per one remote repository" model is a lot
easier to explain.  At least when I read your first "branch
group" proposal that was I thought was going on and I found it
quite sensible (and it maps more or less straightforwardly to
the way existing .git/refs/remotes is set up by default).

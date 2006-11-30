X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Wed, 29 Nov 2006 18:12:14 -0800
Message-ID: <7vejrln0n5.fsf@assigned-by-dhcp.cox.net>
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
	<87ejrlvn7r.wl%cworth@cworth.org>
	<7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
	<7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
	<456E3AB7.1030306@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 02:12:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456E3AB7.1030306@midwinter.com> (Steven Grimm's message of "Wed,
	29 Nov 2006 17:58:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32697>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpbPP-00034d-AR for gcvg-git@gmane.org; Thu, 30 Nov
 2006 03:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936116AbWK3CMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 21:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936077AbWK3CMQ
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 21:12:16 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:34268 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S936116AbWK3CMP
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 21:12:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061130021215.QUCI4817.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Wed, 29
 Nov 2006 21:12:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id sqBi1V0091kojtg0000000; Wed, 29 Nov 2006
 21:11:42 -0500
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Steven Grimm <koreth@midwinter.com> writes:

> But I'm still a relative n00b and would appreciate knowing if I'm just
> missing some big obvious technique.

You are doing just fine.  Using commits to do snapshot is
another workflow people often use.  These people tend to do so
in a work branch and cherry-pick the resulting series of commits
onto more permanent branch while reorganizing and tidying up the
development history to be published to the outside world.


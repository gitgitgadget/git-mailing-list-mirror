X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/n] gitweb: Secure against commit-ish/tree-ish with the same name as path
Date: Fri, 03 Nov 2006 01:35:44 -0800
Message-ID: <7vlkmseutr.fsf@assigned-by-dhcp.cox.net>
References: <200610301953.01875.jnareb@gmail.com>
	<200611010140.56834.jnareb@gmail.com>
	<7vac3awtj4.fsf@assigned-by-dhcp.cox.net>
	<200611020949.34276.jnareb@gmail.com>
	<7vhcxhjbog.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 09:36:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30806>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfvSt-0006LQ-5w for gcvg-git@gmane.org; Fri, 03 Nov
 2006 10:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752719AbWKCJfv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 04:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbWKCJfv
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 04:35:51 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:57252 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1752719AbWKCJfv
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 04:35:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103093545.RLJP22409.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Fri, 3
 Nov 2006 04:35:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id i9bq1V0011kojtg0000000 Fri, 03 Nov 2006
 04:35:50 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> I'd see if I can add some constructive comments on patches 5-10
> tonight, but I'm in the middle of other things so don't hold
> your breath ;-).

7 and 9 look obviously good, so I've applied them without
others.

        gitweb: Output also empty patches in "commitdiff" view
        gitweb: Better support for non-CSS aware web browsers

5 is terminally linewrapped and rather big to comment on without
comparing pre- and post- patch outputs, so I'll refrain from
commenting on it.  8 is "oops, I made a mistake when I did 5",
which discourages me even more from looking at 5 X-<.

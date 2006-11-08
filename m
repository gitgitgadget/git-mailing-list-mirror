X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] gitweb: New improved formatting of chunk header in diff
Date: Wed, 08 Nov 2006 13:41:45 -0800
Message-ID: <7vzmb1r4yu.fsf@assigned-by-dhcp.cox.net>
References: <200611081147.52952.jnareb@gmail.com>
	<200611081800.16001.jnareb@gmail.com>
	<7vfyctsmbm.fsf@assigned-by-dhcp.cox.net>
	<200611082158.43652.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 21:42:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611082158.43652.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 8 Nov 2006 21:58:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31160>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhvB8-0000zR-Hx for gcvg-git@gmane.org; Wed, 08 Nov
 2006 22:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753523AbWKHVlr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 16:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753524AbWKHVlr
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 16:41:47 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:11217 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1753523AbWKHVlq
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 16:41:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061108214146.UAVK5575.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Wed, 8
 Nov 2006 16:41:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id kMhr1V00K1kojtg0000000; Wed, 08 Nov 2006
 16:41:51 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> O.K. This one introduced new feature, and wasn't needed for earlier 
> accepted patch (output empty patches) to have sense. And it is rc1 
> phase...

I personally do not mind minor gitweb 'feature' updates in -rc
cycle, just like I am planning to see if there are gitk updates
I haven't pulled from Paulus (I think there is at least one
patch from last month or so), unless the changes do not break it
so badly.

> By the way, where I can find proper specifiction of unified diff format? 
> Do I understand correctly that bot from and to ranges can be without 
> number of lines part if it simplifies to 0?

When Linus did apply.c and I did diff.c, we primarily worked off
of sources to GNU patch.

There is a POSIX draft proposal now.

http://www.opengroup.org/austin/mailarchives/ag-review/msg02077.html

See also updates about the proposal.

http://thread.gmane.org/gmane.comp.version-control.git/29331/focus=29389

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH 2/2] git-svn: rename 'commit' command to 'set-tree'
Date: Sat, 16 Dec 2006 05:26:03 -0800
Message-ID: <7vbqm4ezv8.fsf@assigned-by-dhcp.cox.net>
References: <m28xh8amxa.fsf@ziti.local>
	<11662558902535-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 13:26:13 +0000 (UTC)
Cc: git@vger.kernel.org, seth@hand.yhbt.net
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <11662558902535-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Fri, 15 Dec 2006 23:58:08 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34613>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvZYK-0003Zv-Gc for gcvg-git@gmane.org; Sat, 16 Dec
 2006 14:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751673AbWLPN0H (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 08:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753688AbWLPN0H
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 08:26:07 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37835 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751673AbWLPN0G (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 08:26:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216132604.SNQE7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Sat, 16
 Dec 2006 08:26:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id zRRQ1V0031kojtg0000000; Sat, 16 Dec 2006
 08:25:24 -0500
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:

> 'set-tree' probably accurately describes what the command
> formerly known as 'commit' does.
>
> I'm not entirely sure that 'dcommit' should be renamed to 'commit'
> just yet...  Perhaps 'push' or 'push-changes'?

I think Pasky did such a three-way rename to avoid breaking
people's fingers.  I thought it was a reasonable transition
strategy, but some people might say its only effect was to break
people's fingers not just once but twice, so Pasky himself
and/or Cogito users may have some input on this.

We are talking about major UI change between 1.4 series and
v1.5.0 on the core Porcelain-ish side, so if you feel confident
that things would settle down in a month or so in the git-svn
front, it may be a good idea to roll sweeping changes into the
same timeframe.

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Adapt to fuse in kernel 2.6.17
Date: Sun, 12 Nov 2006 11:43:59 -0800
Message-ID: <7vslgobgcg.fsf@assigned-by-dhcp.cox.net>
References: <20061112184519.8713.7707.stgit@lathund.dewire.com>
	<200611121956.25481.robin.rosenberg.lists@dewire.com>
	<455776A7.6050707@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 12 Nov 2006 19:44:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <455776A7.6050707@garzik.org> (Jeff Garzik's message of "Sun, 12
	Nov 2006 14:31:51 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31273>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjLFP-0006xL-4V for gcvg-git@gmane.org; Sun, 12 Nov
 2006 20:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752929AbWKLToD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 14:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752945AbWKLToD
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 14:44:03 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:51180 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1752929AbWKLToB
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 14:44:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061112194400.XYEV4817.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Sun, 12
 Nov 2006 14:44:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id lvja1V01E1kojtg0000000; Sun, 12 Nov 2006
 14:43:35 -0500
To: Jeff Garzik <jeff@garzik.org>
Sender: git-owner@vger.kernel.org

Jeff Garzik <jeff@garzik.org> writes:

> Robin Rosenberg wrote:
>> This was a patch to GITFS, which may be somewhat unclear from the
>> Subject line :)
>
> I blinked, and I missed it.  Where can I find gitfs?  I've long
> thought about doing something like that myself.

http://git.or.cz/gitwiki/InterfacesFrontendsAndTools lists it at

http://www.sfgoth.com/~mitch/linux/gitfs/

Fuse seems to be fun.

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/4] Default to displaying /all/ non-tag refs, not just locals
Date: Thu, 02 Nov 2006 18:40:29 -0800
Message-ID: <7vac39mew2.fsf@assigned-by-dhcp.cox.net>
References: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com>
	<200611021111.22604.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 02:59:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30774>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfozM-0003wO-PG for gcvg-git@gmane.org; Fri, 03 Nov
 2006 03:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752970AbWKCCkb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 21:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbWKCCkb
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 21:40:31 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:26784 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1752966AbWKCCka
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 21:40:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103024030.BUBW2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Thu, 2
 Nov 2006 21:40:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id i2g81V00T1kojtg0000000 Thu, 02 Nov 2006
 21:40:09 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> Adds support for display_mode == 2; which shows all non-tag refs.

That is a change in behaviour and given that we introduced
remotes for the explicit purpose of not to clutter the local
branch namespace, I doubt defaulting to _show_ remotes is a good
change.  See the 'bitfield' comment in my other reply.


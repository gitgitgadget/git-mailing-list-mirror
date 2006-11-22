X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Feature request: git-pull -e/--edit
Date: Wed, 22 Nov 2006 15:02:45 -0800
Message-ID: <7v3b8bozje.fsf@assigned-by-dhcp.cox.net>
References: <20061119212611.13038.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 22 Nov 2006 23:03:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32109>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gn17E-0008I5-2F for gcvg-git@gmane.org; Thu, 23 Nov
 2006 00:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757134AbWKVXCs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 18:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757140AbWKVXCs
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 18:02:48 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:20910 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1757134AbWKVXCs
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 18:02:48 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061122230245.MGCC4226.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Wed, 22
 Nov 2006 18:02:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id pz2F1V00b1kojtg0000000; Wed, 22 Nov 2006
 18:02:16 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

linux@horizon.com writes:

> But I notice that --no-commit actually changes git's merging
> technique.  If it's specified, the trivial in-index merge doesn't
> appear to be attempted.  I don't think it makes a huge difference,
> but is any difference desirable?

This was done in response to a specific request from the list
but I do not remember the details.  If I were to research the
background I would

 (1) first, look at the authordate of the commit that introduced
     the change.  For this, I would most likely use:

	git log -p -S--no-commit -- git-pull.sh

 (2) go back to the list archive and find the thread that
     predates that commit by a few days.

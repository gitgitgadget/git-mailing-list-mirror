X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Feature request: git-pull -e/--edit
Date: Sun, 19 Nov 2006 18:17:53 -0800
Message-ID: <7vy7q67tf2.fsf@assigned-by-dhcp.cox.net>
References: <20061119212611.13038.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 02:18:08 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061119212611.13038.qmail@science.horizon.com>
	(linux@horizon.com's message of "19 Nov 2006 16:26:11 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31876>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlyjO-0007B8-Qs for gcvg-git@gmane.org; Mon, 20 Nov
 2006 03:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933860AbWKTCRz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 21:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933861AbWKTCRz
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 21:17:55 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:64412 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S933860AbWKTCRy
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 21:17:54 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061120021754.ECHY21630.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Sun, 19
 Nov 2006 21:17:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id oqJ11V00A1kojtg0000000; Sun, 19 Nov 2006
 21:18:01 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

linux@horizon.com writes:

> The last end-user use I can think of for git-merge instead
> of git-pull is providing a custom commit message.
>
> Would it be possible to add -m and -e options to git-pull?
>
> The problem I can see is that the latter would have to be added to
> git-merge, and the guts there are a bit intricate; it uses git-commit-tree
> directly rather than git-commit, so I can't just pass through the
> arguments.

How often is this desired, when the merge is clean?  

If the answer is "not so often", you can already use "commit
--amend" after "pull" creates an automated merge commit.

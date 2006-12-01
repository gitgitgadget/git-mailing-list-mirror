X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: How-to revert a locally modified file
Date: Thu, 30 Nov 2006 21:51:31 -0800
Message-ID: <7v4psgduzg.fsf@assigned-by-dhcp.cox.net>
References: <456FBC63.5090609@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 1 Dec 2006 05:51:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456FBC63.5090609@saville.com> (Wink Saville's message of "Thu,
	30 Nov 2006 21:23:47 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32851>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq1J9-0005EN-Qo for gcvg-git@gmane.org; Fri, 01 Dec
 2006 06:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759113AbWLAFvd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 00:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759116AbWLAFvd
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 00:51:33 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:46240 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1759113AbWLAFvc
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 00:51:32 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061201055131.BWMU27894.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Fri, 1
 Dec 2006 00:51:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id tHrg1V00p1kojtg0000000; Fri, 01 Dec 2006
 00:51:41 -0500
To: Wink Saville <wink@saville.com>
Sender: git-owner@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> Hello,
>
> I searched the net and couldn't find the answer to how to revert a
> file to its "pre-modified" state.
>
> I did see in the 0.99.7 To Do:

Where did you find 0.99.7 ToDo?  I am curious...

> * Perhaps a tool to revert a single file to pre-modification
> state? git-cat-file blob `git-ls-files | grep foo` >foo or
> git-cat-file blob `git-ls-tree HEAD foo` >foo? What should
> the command be called? git-revert is taken so is
> git-checkout.
>
> Did such a command come to be?

commit 4aaa702794447d9b281dd22fe532fd61e02434e1
Author: Junio C Hamano <junkio@cox.net>
Date:   Tue Oct 18 01:29:27 2005 -0700

    git-checkout: revert specific paths to either index or a given tree-ish.
    
    When extra paths arguments are given, git-checkout reverts only those
    paths to either the version recorded in the index or the version
    recorded in the given tree-ish.
    
    This has been on the TODO list for quite a while.
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>

See the EXAMPLES section of git-checkout manual page.

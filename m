X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Adding a new file as if it had existed
Date: Tue, 12 Dec 2006 02:13:06 -0800
Message-ID: <7vhcw1whfx.fsf@assigned-by-dhcp.cox.net>
References: <7ac1e90c0612120205k38b2fc14jbfd8ea682406efb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 10:13:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7ac1e90c0612120205k38b2fc14jbfd8ea682406efb2@mail.gmail.com>
	(Bahadir Balban's message of "Tue, 12 Dec 2006 10:05:08 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34077>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu4dM-0007y5-Tx for gcvg-git@gmane.org; Tue, 12 Dec
 2006 11:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751061AbWLLKNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 05:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWLLKNJ
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 05:13:09 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:47122 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751061AbWLLKNH (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 05:13:07 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212101306.NXKS20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Tue, 12
 Dec 2006 05:13:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id xmDH1V00R1kojtg0000000; Tue, 12 Dec 2006
 05:13:18 -0500
To: "Bahadir Balban" <bahadir.balban@gmail.com>
Sender: git-owner@vger.kernel.org

"Bahadir Balban" <bahadir.balban@gmail.com> writes:

> Is there a good way of adding new files to git as if they had existed
> from the initial commit (or even better, since a particular commit)?
> This way I would only track the new changes I made to an existing
> file.

No.

I do not understand why not adding all the files you care about
eventually anyway in the initial commit is needed for
"performance reasons", if you do not touch majority of them for
a long time.  Care to explain?


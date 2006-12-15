X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] git-svn: convert to using Git.pm
Date: Fri, 15 Dec 2006 11:47:58 -0800
Message-ID: <7virgdvt3l.fsf@assigned-by-dhcp.cox.net>
References: <11662091941543-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 19:48:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <11662091941543-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Fri, 15 Dec 2006 10:59:54 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34543>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvJ2J-0006D5-U2 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 20:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753320AbWLOTsA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 14:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbWLOTr7
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 14:47:59 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:45840 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753320AbWLOTr7 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 14:47:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215194758.TOU16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 14:47:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id z7oA1V00S1kojtg0000000; Fri, 15 Dec 2006
 14:48:10 -0500
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:

> Thanks to Git.pm, I've been able to greatly reduce the amount
> of extra work that needs to be done to manage input/output
> pipes in Perl.
>
> chomp usage has also been greatly reduced, too.
>
> All tests (including full-svn-test) still pass, but this has
> not been tested extensively in the real-world.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>
> Junio: please don't apply this to master just yet.

Will queue for 'next'.  Thanks for the warning.

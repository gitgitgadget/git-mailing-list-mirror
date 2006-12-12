X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Move Fink and Ports check to after config file
Date: Tue, 12 Dec 2006 14:45:12 -0800
Message-ID: <7vslfkpwcn.fsf@assigned-by-dhcp.cox.net>
References: <AF891711-02C9-414F-98CC-BC53DD24EDB3@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 22:45:22 +0000 (UTC)
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <AF891711-02C9-414F-98CC-BC53DD24EDB3@silverinsanity.com> (Brian
	Gernhardt's message of "Tue, 12 Dec 2006 12:01:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34155>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuGNC-00076w-ET for gcvg-git@gmane.org; Tue, 12 Dec
 2006 23:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932524AbWLLWpP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 17:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWLLWpP
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 17:45:15 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:54427 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932498AbWLLWpN (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 17:45:13 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212224513.OXCR97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Tue, 12
 Dec 2006 17:45:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id xylP1V0121kojtg0000000; Tue, 12 Dec 2006
 17:45:24 -0500
To: Brian Gernhardt <benji@silverinsanity.com>
Sender: git-owner@vger.kernel.org

Brian Gernhardt <benji@silverinsanity.com> writes:

> Putting NO_FINK or NO_DARWIN_PORTS in config.mak is ignored because the
> checks are done before the config is included.
>
> Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>

First time I saw this today I said "I'd swear I've seen this".

http://thread.gmane.org/gmane.comp.version-control.git/26493/focus=26503

I guess after I asked for a confirmation from you I simply
forgot to apply it.  Thanks for a reminder.



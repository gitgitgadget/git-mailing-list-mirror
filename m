X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-merge-recursive segmentation error
Date: Tue, 19 Dec 2006 18:25:02 -0800
Message-ID: <7vtzzrmhhd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612191709320.6766@woody.osdl.org>
	<929899.78332.qm@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 02:25:16 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <929899.78332.qm@web31809.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Tue, 19 Dec 2006 18:15:20 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34894>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwr8o-0000Ut-G9 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 03:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964781AbWLTCZH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 21:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWLTCZG
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 21:25:06 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:53893 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964781AbWLTCZF (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 21:25:05 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220022503.MVOK20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Tue, 19
 Dec 2006 21:25:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0qQM1W00j1kojtg0000000; Tue, 19 Dec 2006
 21:24:22 -0500
To: ltuikov@yahoo.com
Sender: git-owner@vger.kernel.org

Luben Tuikov <ltuikov@yahoo.com> writes:

> I also ran git-bisect twice over two well known but overlapping
> good-bad regions and I get the same commit as being the culprit.
> It seems to be commit 1510fea781cb0517eeba8c378964f7bc4f9577ab.
>
>     Luben

Ooooooops.


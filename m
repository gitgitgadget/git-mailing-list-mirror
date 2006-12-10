X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: reexporting git repository via git-daemon
Date: Sun, 10 Dec 2006 13:39:07 -0800
Message-ID: <7vd56r4eis.fsf@assigned-by-dhcp.cox.net>
References: <200612082212.09682.arekm@maven.pl>
	<200612101742.44564.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 21:43:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612101742.44564.arekm@maven.pl> (Arkadiusz Miskiewicz's
	message of "Sun, 10 Dec 2006 17:42:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33933>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtWRE-0005kG-8O for gcvg-git@gmane.org; Sun, 10 Dec
 2006 22:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762594AbWLJVjK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 16:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762624AbWLJVjJ
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 16:39:09 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:60317 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1762594AbWLJVjI (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 16:39:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061210213908.KLAQ16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Sun, 10
 Dec 2006 16:39:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id x9eW1V00b1kojtg0000000; Sun, 10 Dec 2006
 16:38:30 -0500
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Sender: git-owner@vger.kernel.org

Arkadiusz Miskiewicz <arekm@maven.pl> writes:

>> 100% repeatable at this moment. Any ideas?
>
> after:
> $  git repack -a -d
> Generating pack...
> Done counting 33587 objects.
> Deltifying 33587 objects.
>  100% (33587/33587) done
> Writing 33587 objects.
>  100% (33587/33587) done
> Total 33587, written 33587 (delta 23205), reused 33587 (delta 23205)
> Pack pack-bc830a5d1c2efa3b727ef9af8faba13c3e719395 created.
>
> the problem disapears and I can safely reexport git repository.
>
> Does anyone care about this bug in git?

I do.  I wanted to see if it reproduced but it didn't for me.


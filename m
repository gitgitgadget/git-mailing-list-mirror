X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-cvsserver: fix breakage when calling git merge-file
Date: Tue, 19 Dec 2006 16:38:57 -0800
Message-ID: <7vodpzo0ym.fsf@assigned-by-dhcp.cox.net>
References: <20061219225820.GA6418@soma>
	<Pine.LNX.4.63.0612200058280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 00:39:08 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612200058280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 20 Dec 2006 00:59:53 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34872>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwpU7-0003Z2-0i for gcvg-git@gmane.org; Wed, 20 Dec
 2006 01:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932661AbWLTAjA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 19:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWLTAi7
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 19:38:59 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38025 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932661AbWLTAi7 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 19:38:59 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220003858.TEPA97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Tue, 19
 Dec 2006 19:38:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0oeG1W00R1kojtg0000000; Tue, 19 Dec 2006
 19:38:17 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 19 Dec 2006, Eric Wong wrote:
>
>> In the same vein as 8336afa563fbeff35e531396273065161181f04c, this fixes 
>> the the RCS merge to git-merge-file conversion in commit e2b70087.
>
> Ooops. I should have checked after reading 8336afa if there are more 
> offenders. Alas, I checked now, and there seem none to be left. But 
> everybody can see now why I try to get an all-C Git: I suck at perl.

Well, I should have been more careful to begin with.  My
apologies.

And thanks both.

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] hooks/pre-commit: add example to add Signed-off-by line to message
Date: Wed, 20 Dec 2006 09:44:13 -0800
Message-ID: <7vejqufonm.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0611291219190.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<200612201604.12498.andyparkins@gmail.com>
	<Pine.LNX.4.63.0612201717490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmz5ifpbv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612201835570.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 17:44:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612201835570.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 20 Dec 2006 18:37:45 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34952>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx5UH-0001wt-Ry for gcvg-git@gmane.org; Wed, 20 Dec
 2006 18:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030220AbWLTRoP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 12:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWLTRoP
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 12:44:15 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:57077 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030220AbWLTRoO (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 12:44:14 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220174413.PEEA2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Wed, 20
 Dec 2006 12:44:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 15jY1W00C1kojtg0000000; Wed, 20 Dec 2006
 12:43:32 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Why SQUASH_MSG?  Doesn't it confuse git-explain when it wants to
>> detect that you are in the middle of a squash merge?
>
> Yes, it confuses git-explain. Which did not existed when I concocted the 
> first (broken) version of this patch. There are only two ways to give 
> commit message templates AFAICT: misusing SQUASH_MSG and misusing 
> MERGE_MSG.

I wonder...

# An example hook script to check the commit log message.
# Called by git-commit with one argument, the name of the file
# that has the commit message.  The hook should exit with non-zero
# status after issuing an appropriate message if it wants to stop the
# commit.  The hook is allowed to edit the commit message file.


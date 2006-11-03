X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] Show the branch type after the branch name for remotes
Date: Thu, 02 Nov 2006 18:40:31 -0800
Message-ID: <7vy7qtl0bk.fsf@assigned-by-dhcp.cox.net>
References: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com>
	<200611021111.32759.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 02:59:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30772>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfp13-0003wO-Fq for gcvg-git@gmane.org; Fri, 03 Nov
 2006 03:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752971AbWKCCke (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 21:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752256AbWKCCke
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 21:40:34 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:50686 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1752965AbWKCCkc
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 21:40:32 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103024032.HRYU22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Thu, 2
 Nov 2006 21:40:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id i2gB1V0051kojtg0000000 Thu, 02 Nov 2006
 21:40:11 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> Instead of prefixing the remote branches with "remotes/" suffix them with
> "[read only]"

This is a change in UI and while I understand why you want to
say r/o instead of remotes/, I think this needs a bit more
thought and discussion.  People should not be feeding the output
of "git branch" Porcelainish to their scripts, but you'll never
know...

By the way, does "git branch -r" (without any of your patches)
even say "remotes/"?

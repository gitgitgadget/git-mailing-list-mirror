X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Bash completion support for aliases
Date: Sat, 28 Oct 2006 13:37:50 -0700
Message-ID: <7vlkn06ush.fsf@assigned-by-dhcp.cox.net>
References: <20061028121220.G3421aba@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 20:37:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30395>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GduwF-0005Rw-Dt for gcvg-git@gmane.org; Sat, 28 Oct
 2006 22:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751403AbWJ1Uhw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 16:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWJ1Uhw
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 16:37:52 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:16782 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1751403AbWJ1Uhv
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 16:37:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028203751.ZGPE28934.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Sat, 28
 Oct 2006 16:37:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id fwdv1V0071kojtg0000000 Sat, 28 Oct 2006
 16:37:55 -0400
To: Dennis Stosberg <dennis@stosberg.net>
Sender: git-owner@vger.kernel.org

Dennis Stosberg <dennis@stosberg.net> writes:

>  - Add aliases to the list of available git commands.
>  - Make completion work for aliased commands.

You are my hero.

I started to get annoyed that "git co" does not complete my
branch names and I needed to say "git checkout".  This fixes it
nicely.


X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Move git_get_last_activity subroutine earlier
Date: Sat, 28 Oct 2006 13:57:59 -0700
Message-ID: <7v3b986tuw.fsf@assigned-by-dhcp.cox.net>
References: <200610281943.40456.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 20:58:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610281943.40456.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 28 Oct 2006 19:43:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30398>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdvFm-0000sJ-5O for gcvg-git@gmane.org; Sat, 28 Oct
 2006 22:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964827AbWJ1U6B (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 16:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWJ1U6B
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 16:58:01 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36505 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S964827AbWJ1U6A
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 16:58:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028205800.IZIJ6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Sat, 28
 Oct 2006 16:58:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id fwy41V00D1kojtg0000000 Sat, 28 Oct 2006
 16:58:04 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> Good test for git-pickaxe (git-blame2).

"git pickaxe -M v1.4.3.. -- gitweb/gitweb.perl" finds copies by
you just fine (It is interesting to compare it with output
without -M), thanks.



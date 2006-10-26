X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge-recursive, was Re: What's in git.git
Date: Thu, 26 Oct 2006 02:35:42 -0700
Message-ID: <7vlkn3o1w1.fsf@assigned-by-dhcp.cox.net>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0610261114520.3286@wbgn013.biozentrum.uni-wuerzburg.de>
	<ehputm$ch2$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 09:35:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ehputm$ch2$3@sea.gmane.org> (Jakub Narebski's message of "Thu,
	26 Oct 2006 11:25:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30168>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd1eN-0002wX-Bj for gcvg-git@gmane.org; Thu, 26 Oct
 2006 11:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422960AbWJZJfo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 05:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422966AbWJZJfo
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 05:35:44 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:60905 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1422960AbWJZJfn
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 05:35:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026093542.WXUO28934.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 05:35:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id exbR1V0071kojtg0000000 Thu, 26 Oct 2006
 05:35:25 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Johannes Schindelin wrote:
>
>> BTW what happened to the builtin shortlog? It is the last Perl script I 
>> use regularly... (should make people happy who are stuck with Activision 
>> Perl...)
>
> BTW. both Perl version and builtin shorlog have email->real name translation
> table built in. In Perl script version it is in __DATA__ section, and we
> could update it using Inline::Files module, in C version it was in table.
> But in fact this list is project specific. Shouldn't we make it customizable
> (::sigh::, yet another file in $GIT_DIR...).

It already reads from .mailmap which could be tracked as part of
the sources (if it is project specific it would be better if it
can be shared among members).

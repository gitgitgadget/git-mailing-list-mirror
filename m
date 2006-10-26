X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge-recursive, was Re: What's in git.git
Date: Thu, 26 Oct 2006 02:26:31 -0700
Message-ID: <7v3b9bpgvs.fsf@assigned-by-dhcp.cox.net>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0610261114520.3286@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 09:26:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0610261114520.3286@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 26 Oct 2006 11:18:23 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30165>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd1VU-0001Rw-NG for gcvg-git@gmane.org; Thu, 26 Oct
 2006 11:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422910AbWJZJ0d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 05:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422927AbWJZJ0d
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 05:26:33 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:41351 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1422910AbWJZJ0c
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 05:26:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026092632.CTGA22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 05:26:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id exSE1V00E1kojtg0000000 Thu, 26 Oct 2006
 05:26:14 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 26 Oct 2006, Junio C Hamano wrote:
>
>>   We'd still need more work on merge-recursive to fix the
>>   overcautious "working file will be overwritten by merge" --
>>   this is really needed for usability.
>
> I am sorry, but I do not have the time to wrap my head around this for at 
> least another week. It seems to be a complicated problem (not the fix, 
> mind you, but the side effects you have to think of!), and I stupidly 
> started to play with shallow clones when I knew I had no time already.

No need to worry nor feel pressure; it's all volunteer work and
we do this for fun.

> BTW what happened to the builtin shortlog? It is the last Perl script I 
> use regularly... (should make people happy who are stuck with Activision 
> Perl...)

Yeah, I was wondering about it too, when I was looking for
something readily mergeable to "next" today.  I must have
misplaced it.


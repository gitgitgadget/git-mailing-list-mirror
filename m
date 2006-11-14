X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 14:56:25 -0800
Message-ID: <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 22:58:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611141633430.2591@xanadu.home> (Nicolas Pitre's
	message of "Tue, 14 Nov 2006 16:34:18 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31391>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk7Di-0004qQ-RN for gcvg-git@gmane.org; Tue, 14 Nov
 2006 23:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966437AbWKNW4o (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 17:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966436AbWKNW4o
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 17:56:44 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46469 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S966432AbWKNW40
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 17:56:26 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061114225626.SBXN296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 17:56:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mmwY1V00B1kojtg0000000; Tue, 14 Nov 2006
 17:56:32 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 14 Nov 2006, Jakub Narebski wrote:
>
>> The git interface refactoring should be I think the cause for git 2.0.0
>> release...
>
> Good idea indeed.

We need to avoid user confusion, so making a command that used
to do one thing to suddenly do something completely different is
a no-no.  However, I do not think it needs to wait for 2.0.0.
We can start with a separate namespace (or even a separate
"Improved git UI project") and introduce the "improved UI set"
in 1.5.0 timeframe.

If managed properly, the "improved git UI" can coexist with the
current set of tools and over time we can give an option not to
even install the older Porcelain-ish commands.

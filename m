X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 18:10:16 -0800
Message-ID: <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 02:10:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611142007010.2591@xanadu.home> (Nicolas Pitre's
	message of "Tue, 14 Nov 2006 20:48:09 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31403>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkAEJ-0001wD-GA for gcvg-git@gmane.org; Wed, 15 Nov
 2006 03:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966462AbWKOCKT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 21:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966464AbWKOCKT
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 21:10:19 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:54421 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S966462AbWKOCKR
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 21:10:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115021017.IOEJ18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 21:10:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mqAP1V00C1kojtg0000000; Tue, 14 Nov 2006
 21:10:23 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> "You pull the remote changes with 'git-pull upstream,, then you can 
> merge them in your current branch with 'git-merge upstream'."
>
> Isn't it much simpler to understand (and to teach) that way?

If it were "you download the remote changes with 'git download
upstream' and then merge with 'git merge'", then perhaps, but if
you used the word "pull" or "fetch", I do not think so.

I would be all for changing the semantics of "pull" from one
thing to another, if the new semantics were (1) what everybody
welcomed, (2) what "pull" traditionally meant everywhere else.
In that case, we have been misusing it to be confusing to
outsiders and I agree it makes a lot of sense to remove the
source of confusion.  But I do not think CVS nor SVN ever used
the term, and I was told that BK was what introduced the term,
and the word meant something different from what you are
proposing.

You have to admit both pull and fetch have been contaminated
with loaded meanings from different backgrounds. I was talking
about killing the source of confusion in the longer term by
removing fetch/pull/push, so we are still on the same page.

That's where my "you download from the upstream and merge" comes
from.


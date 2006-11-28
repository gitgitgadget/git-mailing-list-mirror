X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Trim hint printed when gecos is empty.
Date: Tue, 28 Nov 2006 10:29:50 -0800
Message-ID: <7v3b834e75.fsf@assigned-by-dhcp.cox.net>
References: <ekh2uh$nk2$1@sea.gmane.org>
	<200611281403.36370.andyparkins@gmail.com>
	<Pine.LNX.4.63.0611281536230.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<200611281506.53518.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 18:30:13 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32560>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp7iN-0006wI-EO for gcvg-git@gmane.org; Tue, 28 Nov
 2006 19:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758724AbWK1S3w (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 13:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758726AbWK1S3w
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 13:29:52 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:49309 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1758724AbWK1S3v
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 13:29:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061128182951.DFQ4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Tue, 28
 Nov 2006 13:29:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id sJVz1V0131kojtg0000000; Tue, 28 Nov 2006
 13:30:00 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Tuesday 2006 November 28 14:40, Johannes Schindelin wrote:
>
>> You are probably different than me. What with my track record, I _trust_
>> my patches to be not perfect at all...
>
> ...  I had understood it was a 
> legal tool to trace the provenance of a patch - not to sign off on it being 
> bug free (which surely is impossible).

Johannes, Andy's interpretation is in line with the policy in
SubmittingPatches.  S-o-b is about warranty of provenance, and
not about correctness or cheering (Acked-by).

And I think it makes sense to add "-s" automatically to commits
made in a private working repository in which the developer who
configured "-s" to be added automatically is the only person who
makes commits.  As already mentioned in the thread, one of the
hooks should be usable for that.  And it certainly is a
possibility to add a config to turn "-s" on.

But I suspect that it would be cleaner and more useful to teach
"git commit" to use a commit message template per repository and
put the S-o-b in there -- that mechanism would be usable for
things other than just S-o-b lines as projects see fit.


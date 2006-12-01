X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: selective git-update-index per diff(1) chunks
Date: Fri, 01 Dec 2006 03:38:13 -0800
Message-ID: <7v3b7zalsq.fsf@assigned-by-dhcp.cox.net>
References: <b6fcc0a0612010323x7554e47m5e6bdafe85fc8224@mail.gmail.com>
	<slrnen04os.a5.Peter.B.Baumann@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 1 Dec 2006 11:38:45 +0000 (UTC)
Cc: git@vger.kernel.org, "Alexey Dobriyan" <adobriyan@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <slrnen04os.a5.Peter.B.Baumann@xp.machine.xx> (Peter Baumann's
	message of "Fri, 1 Dec 2006 12:33:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32901>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq6j3-0002f7-V6 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 12:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936475AbWLALiP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 06:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936477AbWLALiP
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 06:38:15 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:56503 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S936475AbWLALiO
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 06:38:14 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061201113813.OBLL4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Fri, 1
 Dec 2006 06:38:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id tPeN1V00Q1kojtg0000000; Fri, 01 Dec 2006
 06:38:23 -0500
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org

Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
writes:

> I don't think it belongs in the plumbing, the git-update-index but I
> think something like this would be very usefull.
>
> AFAIR darcs has this functionality. It selectively ask for each hunk if
> it should be commited. This would be awfull to have in git.

I concur, on both counts.  My own now-defunct Porcelain had the
darcs style interactive hunk selection because it felt so
useful (and sometimes it was).


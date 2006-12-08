X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: reorganize cvs-migration.txt
Date: Thu, 07 Dec 2006 23:25:17 -0800
Message-ID: <7vmz5yn92a.fsf@assigned-by-dhcp.cox.net>
References: <4576D92A.80307@xs4all.nl> <20061206145802.GC1714@fieldses.org>
	<Pine.LNX.4.63.0612061613460.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061206171950.GD1714@fieldses.org>
	<20061206172450.GE1714@fieldses.org>
	<7v7ix47wbr.fsf@assigned-by-dhcp.cox.net>
	<20061207041805.GC3457@fieldses.org>
	<Pine.LNX.4.63.0612071522080.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061207174306.GC16858@fieldses.org>
	<Pine.LNX.4.63.0612071849340.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061208033400.GD30129@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 07:25:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33666>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsa6l-0007D3-Cu for gcvg-git@gmane.org; Fri, 08 Dec
 2006 08:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425062AbWLHHZU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 02:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425060AbWLHHZU
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 02:25:20 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:36913 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1425064AbWLHHZS (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 02:25:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061208072518.HJYG3525.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Fri, 8
 Dec 2006 02:25:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id w7RU1V00L1kojtg0000000; Fri, 08 Dec 2006
 02:25:28 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

"J. Bruce Fields" <bfields@fieldses.org> writes:

> From 22e5bdd9de398f29dfb11125a0921bb4529e2ab7 Mon Sep 17 00:00:00 2001
> From: J. Bruce Fields <bfields@citi.umich.edu>
> Date: Thu, 7 Dec 2006 22:32:28 -0500
> Subject: [PATCH] Documentation: simpler shared repository creation
>
> Take Johannes Schindelin's suggestion for a further simplification of the
> shared repository creation using git --bare init-db --shared.
>
> Also fix a mistake from the previous patch: I forgot to remove the manual setup
> which the --shared does for us.
>
> Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
> ---
>  Documentation/cvs-migration.txt |   27 ++++++++-------------------
>  1 files changed, 8 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
> index 4fab0d7..20c5719 100644

Well, this does not apply at all, as I do not have a commit with
4fab0d7 blob and already applied the reordering patch from you.
Could you fix up and send again after I push out the latest?  I
could try to coax into the documentation, but since I am not
even a CVS migrant myself and am known to be very bad at
documentation, I _really_ don't think you want me to do so.

;-)

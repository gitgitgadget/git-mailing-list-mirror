X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] "init-db" can really be just "init"
Date: Mon, 27 Nov 2006 14:05:27 -0800
Message-ID: <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 22:05:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611271622260.9647@xanadu.home> (Nicolas Pitre's
	message of "Mon, 27 Nov 2006 16:31:47 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32454>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoobU-0003vA-6C for gcvg-git@gmane.org; Mon, 27 Nov
 2006 23:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933832AbWK0WF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 17:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933880AbWK0WF3
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 17:05:29 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:43228 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S933832AbWK0WF2
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 17:05:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127220528.DUSK4817.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Mon, 27
 Nov 2006 17:05:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ry4w1V0071kojtg0000000; Mon, 27 Nov 2006
 17:04:56 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> This should make first GIT impression a little less intimidating.
>
> Signed-off-by: Nicolas Pitre <nico@cam.org>

I was not sure about this for quite some time, thinking that it
might make sense to default the behaviour of init-db for bare
repositories and give init as a user-level wrapper to drive
init-db to add customization suitable for repositories with
working trees.  List?

> Maybe that could be a good rule of thumb to have all porcelainish 
> commands not have any hyphen in their name, like "diff", "commit", 
> "add", etc. ?

I was also hoping that would become the case except verify-tag,
cherry-pick, and format-patch.  Also I was wondering if it would
make sense to give two dashes to the back-end ones that never
get invoked by the end users directly (e.g. merge--recursive,
upload--pack) but thought it was too ugly.

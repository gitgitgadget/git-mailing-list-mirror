X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] StGit removed git branch of the same name as StGit branch
Date: Mon, 20 Nov 2006 13:08:32 -0800
Message-ID: <7vbqn125db.fsf@assigned-by-dhcp.cox.net>
References: <200611202201.45521.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 21:10:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611202201.45521.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 20 Nov 2006 22:01:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31939>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmGOx-0003QW-QN for gcvg-git@gmane.org; Mon, 20 Nov
 2006 22:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966747AbWKTVIh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 16:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966754AbWKTVIg
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 16:08:36 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:43917 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S966747AbWKTVIe
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 16:08:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061120210833.SBII18207.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Mon, 20
 Nov 2006 16:08:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id p9831V00S1kojtg0000000; Mon, 20 Nov 2006
 16:08:04 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> I have used StGit (wonderfull tool) to manage patches on git branch 
> gitweb/web. Unfortunately, I have named stg branch the same as git 
> branch. When removing stg branch (I wanted to remove 
> heads/base/gitweb/web) using "stg branch --delete gitweb/web" it 
> deleted also git branch when I wanted to remove only the StGit managed 
> indicator. Fortunately I was able to recover the branch from reflog, as 
> StGit didn't delete reflog with deletion of git branch.
>
> Perhaps that is correct behavior... but certainly unexpected.

I am also a novice who recently started appreciating the
convenience of StGIT.  I _think_ the usage StGIT expect us to
follow is to run "stg clean" to make the series empty, and not
worry about leftover refs/bases/ at all, but I may well be
mistaken.


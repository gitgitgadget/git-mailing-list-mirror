From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach git push .git/branches shorthand
Date: Mon, 08 Aug 2005 19:48:35 -0700
Message-ID: <7vvf2fyge4.fsf@assigned-by-dhcp.cox.net>
References: <7viryhgdo5.fsf@assigned-by-dhcp.cox.net>
	<200508081225.59949.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0508081234300.32668@wgmdd8.biozentrum.uni-wuerzburg.de>
	<200508081822.24582.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 04:49:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2KAS-0006uH-Is
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 04:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVHICsi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 22:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVHICsi
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 22:48:38 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:9129 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932419AbVHICsh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 22:48:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050809024837.LSYC3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 22:48:37 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

>> My point being that I still can say
>>
>> 	git pull x some_non_default_head
>>
>> with a file "x" in .git/branches.
>
> Is this currently possible?

Not right now, but that is the plan.

> My understanding of .git/branches was that Cogito uses this as mapping of 
> remote branches/heads to local branches/refs, and not to store shortcuts for 
> remote git repositories.
> IMHO, the above usage is a kind of "type mismatch", as the "x" already 
> contains the branch.

You can look at it this way: "x which already contains the
branch" can specify the default branch if command line did not
say anything, but the command line can override it.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/2] Remove emu23, fix entry order
Date: Thu, 01 Sep 2005 23:36:19 -0700
Message-ID: <7vll2gkmcc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509020202030.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 08:37:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EB5A2-0000WC-QV
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 08:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbVIBGgX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 02:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbVIBGgX
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 02:36:23 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:53904 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030409AbVIBGgW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2005 02:36:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050902063620.QYAE9510.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Sep 2005 02:36:20 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509020202030.23242@iabervon.org> (Daniel
	Barkalow's message of "Fri, 2 Sep 2005 02:05:43 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8007>

Daniel Barkalow <barkalow@iabervon.org> writes:

> A few things to improve testing. I'll clean up the series as a whole once 
> it's tested.
>
> This removes the emu23 tests; I think that the only DF conflict tests were 
> in that set, however, so these should be fished out and added to something 
> else.

Thanks.  I'll take a look at 'test moving' part later, perhaps
this weekend.

I should give Pasky a heads-up, since I vaguely recall him
writing something about always doing 3-way merge even when fast
forwarding in his TODO list in the Cogito tree, and just in case
emu23 was what he had in mind...  I'll also CC: Catalin too
just in case StGIT is tempted to use emu23 in git.switch().

Petr, we _might_ remove "read-tree --emu23" in the near future,
but not immediately.  That will not happen until the read-tree
rewrite Daniel is working on proves to be useful in making
'interesting' merges more reliably work.

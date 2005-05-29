From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not show empty diff in diff-cache uncached.
Date: Sun, 29 May 2005 13:09:42 -0700
Message-ID: <7vis11n69l.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
	<7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 22:37:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcU4D-0004TY-LG
	for gcvg-git@gmane.org; Sun, 29 May 2005 22:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVE2UJs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 16:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVE2UJs
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 16:09:48 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:17283 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261424AbVE2UJp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 16:09:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529200944.SEBN20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 16:09:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 29 May 2005 11:53:56 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I'm not sure I like this.

LT> I actually _expect_ that "git-diff-files" will show files that don't match 
LT> the index, even if they happen to have the exact content that the index 
LT> points to. It's how I know whether the index is up-to-date or not.

LT> The exact same thing is trye of git-diff-cache. If something isn't 
LT> up-to-date in the cache, you should show it, since certain operations 
LT> depend on the cache being updated.

Let me make sure that we are on the same page.  I am only
talking about '-p' (diff-patch) case in this patch.  The code
should continue to show the 0{40} SHA1 on the right hand side in
diff-raw output.  Do you still want to see the header in that
case to match the diff-raw exactly?



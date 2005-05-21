From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Sat, 21 May 2005 02:37:31 -0700
Message-ID: <7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 11:36:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZQPc-00045S-CR
	for gcvg-git@gmane.org; Sat, 21 May 2005 11:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVEUJhi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 05:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVEUJhi
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 05:37:38 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:37762 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261489AbVEUJhd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 05:37:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521093732.YXSL1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 05:37:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 19 May 2005 09:19:28 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> [ rambling mode on: ]

LT> One thing that struck me is that there is nothing wrong with having the 
LT> same old file marked twice for a rename, or considering new files to be 
LT> copies of old files. So if we ever allow that, then "rename" may be the 
LT> wrong name for this, since the logic certainly allows the old file to 
LT> still exist (or be removed and show up multiple times in a new guise).

People say be careful what you wish and for a reason.  You may
get it ;-).  I am sending the following:

 [PATCH 1/3] Diff overhaul, adding half of copy detection.
 [PATCH 2/3] Introducing software archaeologist's tool "pickaxe".
 [PATCH 3/3] Diff overhaul, adding the other half of copy detection.



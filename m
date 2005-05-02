From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] git-diff-cache sans --cached and unmerged paths
Date: Mon, 02 May 2005 16:21:33 -0700
Message-ID: <7vr7gpnria.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 01:19:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSk8W-0003du-SV
	for gcvg-git@gmane.org; Tue, 03 May 2005 01:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVEBXVq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 19:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVEBXVq
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 19:21:46 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:24831 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261216AbVEBXVl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2005 19:21:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050502232134.LCCG1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 2 May 2005 19:21:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus, 

    git-diff-cache without --cached says 'U filename" (or
"unmerged filename") when working with an unmerged cache entry.
Since the form without --cached is to mean "look at the work
tree", I think it should be changed to report the mode and the
magic 0{40} SHA1.  What do you think?

I was manually fixing up a merge and I wanted to compare the
merge result in the work tree with the pre-merge HEAD version
from either heads, but this behaviour (yes I am the guilty one)
makes it cumbersome, and that is the reason behind this
question.

BTW, when you have a chance, could you please give the
executable bit to git-apply-patch-script, pretty please.  This
is my fourth attempt ;-).



From: Junio C Hamano <junkio@cox.net>
Subject: Just a note: .git/refs/snap/ is not standard
Date: Sun, 01 May 2005 18:54:51 -0700
Message-ID: <7vacneqtn8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 04:42:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSQsz-0005QN-Ir
	for gcvg-git@gmane.org; Mon, 02 May 2005 04:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVEBCNr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 22:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVEBCLb
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 22:11:31 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:27559 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261668AbVEBByy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 21:54:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050502015452.RIZA1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 21:54:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus, 

    not that there is any "de facto" or any standard there, but
the name .git/refs/snap/ you lifted from the vicinity thing is
not something Cogito folks have.  My understanding is of their
concensus is that .git/refs have single level subdirectories
like 'heads' and 'tags', and there will be little 41-byte text
files that look like .git/HEAD.  So you probably would want to
either (1) readdir in .git/refs (to future proof) or (2) drop
refs/snap from the vicinity list for now (to not give special
treatment to JIT, which I myself do not mind ;-)).  Also if you
go route (2) drop "refs" itself as well.


From: Junio C Hamano <junkio@cox.net>
Subject: Re: Extend "git reset" to take a reset point
Date: Sat, 06 Aug 2005 18:42:33 -0700
Message-ID: <7vmznu4j5i.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508061746530.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sun Aug 07 03:44:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1aCi-0002d9-R7
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 03:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVHGBmq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 21:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVHGBmq
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 21:42:46 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:24263 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750719AbVHGBmq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2005 21:42:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050807014234.LRNK7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 Aug 2005 21:42:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508061746530.3258@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 6 Aug 2005 18:01:03 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

How about saving the current HEAD to $GIT_DIR/OLD_HEAD just in
case?  Then after fixing up the files in the working tree, you
could say "git commit -m OLD_HEAD".

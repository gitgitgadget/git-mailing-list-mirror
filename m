From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sat, 21 May 2005 23:57:39 -0700
Message-ID: <7vis1bd9y4.fsf@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
	<7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
	<7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505212253350.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 08:56:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZkO1-0000rA-R5
	for gcvg-git@gmane.org; Sun, 22 May 2005 08:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVEVG5q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 02:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVEVG5q
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 02:57:46 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:27345 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261754AbVEVG5n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 02:57:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050522065739.LCRZ22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 May 2005 02:57:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505212253350.2206@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 21 May 2005 23:01:27 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Doing "-C50" to ask for at least 50% similarity makes it ok (and it finds
LT> the "git-pull-script" -> "git-resolve-script" thing), but there's
LT> something strange going on, becuase -C10 and -C90 don't work, even if -C40
LT> and -C50 _do_ work.

Plain -C (or -M) not working was a bug I now understand why,
and I would not be surprised that -C10 may give ridiculous
or hilarious results (false hits), but I am having trouble
reproducing the -C90 case.  Will do some more digging later.



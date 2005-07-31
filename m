From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added hook in git-receive-pack
Date: Sun, 31 Jul 2005 16:24:31 -0700
Message-ID: <7viryqd0eo.fsf@assigned-by-dhcp.cox.net>
References: <200507312117.43957.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.58.0507311305170.29650@g5.osdl.org>
	<7vr7ded8ax.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507311549300.14342@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 01:25:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzNBt-0005B3-QQ
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 01:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVGaXZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 19:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVGaXZU
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 19:25:20 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:17381 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262060AbVGaXYd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 19:24:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050731232431.EZWQ12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 31 Jul 2005 19:24:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507311549300.14342@g5.osdl.org> (Linus Torvalds's message of "Sun, 31 Jul 2005 15:50:21 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> No I'm not. Try all the machines behind my firewall.

Ah, that's true.  Do you push into them?

Let's yank out the update_server_info() call when Josef's patch
can handle a single hook call at the end of the run, in addition
to one call per each ref getting updated.

From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: What broke snapshots now?
Date: Sun, 10 Jul 2005 18:22:27 +0100
Message-ID: <1121016147.23706.91.camel@baythorne.infradead.org>
References: <1120907336.8058.293.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0507090908490.17536@g5.osdl.org>
	 <1120952292.23706.49.camel@baythorne.infradead.org>
	 <1121006378.23706.65.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0507100954080.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 19:22:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrfVv-0001un-JX
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 19:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVGJRWa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 13:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVGJRWa
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 13:22:30 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:10968 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261978AbVGJRW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 13:22:28 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DrfVb-0000z3-T8; Sun, 10 Jul 2005 18:22:27 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507100954080.17536@g5.osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-07-10 at 10:08 -0700, Linus Torvalds wrote:
> Which script is this? I'm looking at your scripts, but
> "cg-feedmaillist.sh" is unreadable for me, so I can't see all of it.

Hm. Dunno why that happened -- it's readable now, and also at
http://david.woodhou.se/cg-feedmaillist.sh

> Anyway, it's possible that this is a temporary problem: one of the issues 
> is that since you seem to be using the "rsync:" protocol for updating 
> things, what happens is that if the mirroring is off a bit, you may have 
> gotten a new head, but not all the objects. Then you'd get exactly this.

It's done locally on hera though -- so the mirroring shouldn't be a
problem. IIRC the reason it uses rsync is because I wasn't getting tags
when it was using whatever other method was the default for a local
'parent repository'.

That was actually more relevant for the snapshots than the mailing list
feed, though -- so even if it isn't fixed now, I could live without
tags.

More usefully though, if ordering really isn't a problem on your
repository then I should probably rewrite the script to work directly
from that instead of from a copy.

-- 
dwmw2

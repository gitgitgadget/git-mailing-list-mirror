From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: full kernel history, in patchset format
Date: Mon, 18 Apr 2005 10:45:22 +1000
Message-ID: <1113785123.11910.43.camel@localhost.localdomain>
References: <20050416131528.GB19908@elte.hu>
	 <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
	 <1113780698.11910.8.camel@localhost.localdomain>
	 <20050417233936.GV1461@pasky.ji.cz>
	 <1113782805.11910.36.camel@localhost.localdomain>
	 <20050418003526.GD1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 02:42:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNKL8-0002FA-Ci
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 02:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVDRAp7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 20:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVDRAp7
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 20:45:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45001 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261475AbVDRApx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 20:45:53 -0400
Received: from [150.203.247.9] (helo=[172.24.3.18])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DNKOX-0003Ut-Bz; Mon, 18 Apr 2005 01:45:47 +0100
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050418003526.GD1461@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-18 at 02:35 +0200, Petr Baudis wrote:
> > For the special case of removing history before 2.6.12-rc2 from the
> > trees, I certainly think we can do it by leaving out all the commits,
> > not just the trees. We can do that easily, but there's no way we can
> > _add_ that history retrospectively if we omit it in the first place.
> 
> I'm confused by this paragraph, but that might be my English skills
> failing somehow.

"For the general case of people pruning their own trees, _maybe_ you're
right that it would be good to keep the commits even if we delete the
actual trees. But for history older than 2.6.12-rc2, that's a special
case -- I think we can happily delete the commits too.

"We can delete old trees/commits easily, but we can't _add_ them to the
existing linux-2.6.git tree, because the oldest commit in that tree
(b4ceb6e27e4cc3f37d26e04c4535c79b98a9f889) doesn't have a parent."

-- 
dwmw2


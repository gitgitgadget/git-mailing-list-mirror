From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 16:09:03 +0100
Message-ID: <1113577744.27227.53.camel@hades.cambridge.redhat.com>
References: <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	 <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	 <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	 <20050414121624.GZ25711@pasky.ji.cz>
	 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
	 <1113556448.12012.269.camel@baythorne.infradead.org>
	 <20050415093649.GA28077@elte.hu>
	 <1113559533.12012.296.camel@baythorne.infradead.org>
	 <20050415145324.GA4677@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 17:06:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMSOC-0000jI-SN
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 17:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVDOPJR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 11:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVDOPJR
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 11:09:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49053 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261777AbVDOPJM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 11:09:12 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DMSRN-0006md-LK; Fri, 15 Apr 2005 16:09:06 +0100
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050415145324.GA4677@elte.hu>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-04-15 at 16:53 +0200, Ingo Molnar wrote:
> but the specific scenario you described would require _Linus'_ tree to
> be in limbo for a long time, and have uncommitted half-done edits.
> I.e.:
> 
>    (A1B2)--(A2B2)--(A2'B3)
>     /  \   /            \
>    /    \ /              \
>  (A1B1)  X               (...)
>    \    / \              /
>     \  /   \            /
>    (A2B1)--(A2B2)--(A3B2')
> 
> in the above scenario Linus' tree needs to 'cross' with a maintainer's
> tree.  (maintainer's tree wont cross with another maintainer's tree,
> as maintainer-to-maintainer merges rare.)

Is that true? Consider (A2B1) to be a bugfixes-only tree which I make
available for Linus to pull from. I keep doing more experimental stuff
in my own private copy of the tree along the bottom branch, while Linus
_eventually_ responds to my pull request and moves on, stopping only to
add a 'static' to one of my new functions. I move on too but don't pull
from Linus again for a little while; the final merge happens when I _do_
pull again.

-- 
dwmw2


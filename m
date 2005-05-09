From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: History messup
Date: Mon, 09 May 2005 18:27:57 +0100
Message-ID: <1115659677.16187.393.camel@hades.cambridge.redhat.com>
References: <1115657971.19236.33.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 09 19:27:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVBwE-0002q6-Es
	for gcvg-git@gmane.org; Mon, 09 May 2005 19:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVEIR2G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 13:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVEIR2F
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 13:28:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10477 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261449AbVEIR2A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 13:28:00 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DVC2w-0003Cs-IC; Mon, 09 May 2005 18:27:59 +0100
To: tglx@linutronix.de
In-Reply-To: <1115657971.19236.33.camel@tglx>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-05-09 at 16:59 +0000, Thomas Gleixner wrote:
> David merged from Linus repository . Linus synced later with David.
> Linus did not create a new commit for this update and just pointed his
> "HEAD" to Davids "HEAD", which means he forked Davids repository at
> this point.
> 
> Due to that the parent->parent history is not longer unique. This
> makes it impossible to do file revision graphs over the various
> repositories in the correct order.
> 
> Is this a unique problem or is the omission of a commit in cases like
> that usual practice ? In the latter case proper history tracking is
> almost impossible.

It's normal practice, and it _has_ to be the case. Otherwise the trees
would never stabilise -- every time Linus pulled from my tree he would
create a merge-commit which I don't yet have, and vice versa.

Unless a commit also carries a unique repo-id identifying the repository
in which it originally occurred, you'll only ever be able to track
history in the way people want by means of heuristics.

-- 
dwmw2


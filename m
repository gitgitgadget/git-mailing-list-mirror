From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [GIT PATCH] Selective diff-tree
Date: Sun, 24 Apr 2005 16:25:13 +1000
Message-ID: <1114323914.3419.70.camel@localhost.localdomain>
References: <1113400651.20848.135.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 08:21:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPaUi-0004Sz-Qw
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 08:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVDXG0H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 02:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVDXG0H
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 02:26:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5869 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262270AbVDXG0E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 02:26:04 -0400
Received: from [203.53.50.91] (helo=[172.18.240.72])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DPaZ8-0002Jp-Vr; Sun, 24 Apr 2005 07:26:04 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-23 at 22:09 -0700, Linus Torvalds wrote:
> It passes all the tests I threw at it, but they weren't exhaustive (but I 
> do think I tested the border cases). Mind double-checking that it works 
> for your cases too?

It seems to work at least as well as my version did -- which is to say
it's fine for the handful of test cases I tried, which is probably about
the same as what you did.

On the other hand, my gitfilelog.sh is fairly fundamentally flawed and
probably needs rewriting in C based on rev-tree.

-- 
dwmw2


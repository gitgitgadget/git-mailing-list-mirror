From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Use libcurl to use HTTP to get repositories
Date: Sun, 17 Apr 2005 06:55:59 +0200
Message-ID: <20050417045559.GA769@elte.hu>
References: <Pine.LNX.4.21.0504162008190.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 06:53:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN1mN-0005Pa-Sy
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 06:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVDQE4p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 00:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVDQE4p
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 00:56:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:21380 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261257AbVDQE4g (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 00:56:36 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 8AF7D3184BC;
	Sun, 17 Apr 2005 06:55:08 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 197BC1FC2; Sun, 17 Apr 2005 06:56:02 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504162008190.30848-100000@iabervon.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Daniel Barkalow <barkalow@iabervon.org> wrote:

> Still leaks a bit of memory due to bug copied from read-tree.

Linus, should i resend the 18 fixes i sent the other day? (as a GIT 
repository perhaps?) I found roughly 6 common memory leaks, 8 
theoretical memory leaks, 2 overflows and did a couple of cleanups. One 
of the patches [the cache collision related thing] we agreed was not 
needed, the rest is still very much valid i think. I did some basic 
testing with the fixes applied, nothing seemed to break in any visible 
way in these tests.

	Ingo

From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: gitweb wishlist
Date: Fri, 13 May 2005 14:06:18 +0200
Message-ID: <20050513120618.GA26263@diku.dk>
References: <20050511012626.GL26384@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 13:59:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWYol-0007Di-QI
	for gcvg-git@gmane.org; Fri, 13 May 2005 13:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVEMMGf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 08:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVEMMGf
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 08:06:35 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:5832 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S262343AbVEMMGU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 08:06:20 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id E7E016DFAFC; Fri, 13 May 2005 14:06:11 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A92AA6DF8AC; Fri, 13 May 2005 14:06:11 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 8E96E61FDE; Fri, 13 May 2005 14:06:18 +0200 (CEST)
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
In-Reply-To: <20050511012626.GL26384@pasky.ji.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I don't know if this is intentional, but it looks like gitweb discards
everything after the first line starting with 'Signed-off-by:' on the
log page. This will in some cases remove valuable log information when
a second author or the committer adds additional comments to a commit:

        <log message by author>

        Signed-off-by: <author>

        <log message by committer>

        Signed-off-by: <committer>

The commit page gets it right, which is why I suspect it might just be a
way to trim the amount of text on the log page.

I also noticed that there is a 'faulty' signed-off-by line in commit
14ebb908e10f068dc1901d35f4b716bc69143d19 in case the above is
intentional. Dunno if that should be matched by relaxing the regexp a
little.

-- 
Jonas Fonseca

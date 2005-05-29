From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [RFC] Removing git-*.html references from manpages
Date: Sun, 29 May 2005 03:52:13 +0200
Message-ID: <20050529015213.GC7520@diku.dk>
References: <20050527225850.GA25491@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 03:50:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcCwL-0005Bt-Oa
	for gcvg-git@gmane.org; Sun, 29 May 2005 03:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVE2BwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 21:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVE2BwR
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 21:52:17 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:59101 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261205AbVE2BwO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 May 2005 21:52:14 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 9B67B6E26B8; Sun, 29 May 2005 03:51:43 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 65FB06E26A8; Sun, 29 May 2005 03:51:43 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id ABFE361FE0; Sun, 29 May 2005 03:52:13 +0200 (CEST)
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <20050527225850.GA25491@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jonas Fonseca <fonseca@diku.dk> wrote Sat, May 28, 2005:
> Just a minor issue but still.

Another issue: `--' gets replaced with `&#8212;'. The debian cogito
package mentions this. Seems it can be fixed by overwriting the default
replacement rule using the following in asciidoc.conf:

	[replacements]
	(^|[^-])--($|[^-])=\1--\2

Maybe it can be done smarter.

-- 
Jonas Fonseca

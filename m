From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-diff should not fire up $PAGER, period!
Date: Wed, 17 Dec 2008 14:04:30 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812171401300.14014@localhost.localdomain>
References: <20081216005658.GB3679@coredump.intra.peff.net> <8763lixyps.fsf_-_@jidanni.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Wed Dec 17 23:06:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD4XA-0002Ch-Og
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 23:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbYLQWFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 17:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbYLQWFG
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 17:05:06 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57710 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751792AbYLQWFF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2008 17:05:05 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHM4VKM006379
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Dec 2008 14:04:32 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHM4UKb026024;
	Wed, 17 Dec 2008 14:04:31 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <8763lixyps.fsf_-_@jidanni.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.423 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103400>



On Thu, 18 Dec 2008, jidanni@jidanni.org wrote:
>
> Gentlemen, I have found the solution to your problem.

Umm. YOUR problem.

Do that whole

	[core]
		pager = 

and you can get the behaviour you want.

Or just get rid of emacs. Your problem has nothing to do with git, and 
everything to do with emacs. And then you have the _gall_ to talk about 
"unix design" and not gumming programs together, when you yourself use the 
most gummed-up piece of absolute sh*t there is!

			Linus

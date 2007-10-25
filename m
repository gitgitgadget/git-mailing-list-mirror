From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/6] Cleaned-up rename detection patch-series
Date: Thu, 25 Oct 2007 11:37:08 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710251126490.30120@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.or
 g>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:38:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il7ap-00084s-Ct
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbXJYSh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754353AbXJYSh3
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:37:29 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41479 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753867AbXJYSh2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2007 14:37:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PIb8t7022177
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Oct 2007 11:37:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PIb8Aw009079;
	Thu, 25 Oct 2007 11:37:08 -0700
In-Reply-To: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.221 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62356>



Final notes:

 - all of these were done on top of the current 'master' branch.  Not that 
   it likely matters much, but I thought I'd mention it in case there are 
   conflicts with anything currently cooking in 'next'. I didn't even 
   check.

 - The commits depend on each other, but apart from the ordering, they all 
   stand on their own. They pass the test-suite at all stages.

 - In particular, the first four commits are cleanups and infrastructure 
   that really is totally independent of the last two. I'd argue that the 
   first one (the dependency fix) could/should be merged into stable, and 
   the next three can probably be merged more aggressively than the last 
   two.

 - I *think* this series is good to go. I've used the new rename detection 
   code in my own "production" environment (ie the kernel) since sending 
   it out, and the end result of all these patches is identical - apart 
   from the the dependency fix - to what I've been running for the last 
   week. But maybe it makes more sense to merge the first four into 
   'next', and leave the last two in 'pu', for example (or 'master' and 
   'next' respectively, depending on how comfy people are with the 
   patches).

Splitting the thing up definitely makes the series more readable, and 
maybe that means that somebody will actually comment on it. I don't think 
I got any comments on the original series once I fixed the stupid bugs. 
Hopefully the cleaner series is more amenable to people reviewing it.

			Linus

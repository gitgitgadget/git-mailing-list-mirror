From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge time
Date: Sun, 29 Jul 2007 20:16:01 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707292011170.4161@woody.linux-foundation.org>
References: <498048.62681.qm@web51002.mail.re2.yahoo.com>
 <alpine.LFD.0.999.0707292000190.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew L Foster <mfoster167@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 05:17:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFLkn-0001Kk-J3
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 05:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965841AbXG3DQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 23:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759914AbXG3DQk
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 23:16:40 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53012 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965700AbXG3DQj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 23:16:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6U3G6H7001769
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 Jul 2007 20:16:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6U3G1LI022957;
	Sun, 29 Jul 2007 20:16:01 -0700
In-Reply-To: <alpine.LFD.0.999.0707292000190.4161@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.726 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.15__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54174>



On Sun, 29 Jul 2007, Linus Torvalds wrote:
>
> So in theory, we could pick one particular public kernel.org machine, and 
> use the times as _that_ machine sees it, but the fact is, that isn't how 
> git works. No normal git command will ever show you such a senseless 
> ordering.

So to be constructive, and just tell you what the *sensible* ordering is:

 - get a kernel git clone

 - do "git pull" to update it.

 - do

	gitk ORIG_HEAD..

   to show what the new stuff is after each update, or do something like

	gitk v2.6.23-rc1..

  to show what is new after -rc1 (or "gitk @{2.days.ago}.." to see what 
  is new in _your_ tree in the last two days or whatever).

No commit dates anywhere. Just commit relationships and your *local* views 
of time.

(Sure, gitk will show you the commit dates too, but they aren't important, 
since they have no meaning as to whether a commit got merged into 
2.6.23-rc1 or not).

		Linus

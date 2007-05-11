From: Jeff Garzik <jeff@garzik.org>
Subject: kernel cherry UN-picking?
Date: Fri, 11 May 2007 17:31:14 -0400
Message-ID: <4644E0A2.90008@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 11 23:31:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmchu-0000LL-Vb
	for gcvg-git@gmane.org; Fri, 11 May 2007 23:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758976AbXEKVbR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 17:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760651AbXEKVbQ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 17:31:16 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:43088 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758976AbXEKVbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 17:31:16 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1Hmchn-0008Gg-1Q; Fri, 11 May 2007 21:31:15 +0000
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.8 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46986>

So, I merge the next batch of net driver patches.  After I merge a PPP 
patch, deep in the pile-o-patches, Andrew says "I shouldn't have sent 
that to you, don't apply it"  ;-)

Right now, my process for reversing this damage is to start over: 
create a new branch, manually double-click the mouse on each commit in 
the "damaged" branch, and git-cherrypick it.  Very, very time consuming 
when you have more than a couple commits.

Is there a better way?
Is there any way to say "cherrypick all commits except <these>"?

	Jeff

From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 'git commit' duplicates parents?
Date: Sun, 19 Jun 2005 22:40:05 -0400
Message-ID: <42B62C85.10701@pobox.com>
References: <42B59CF7.3080509@pobox.com> <Pine.LNX.4.58.0506191921270.2268@ppc970.osdl.org> <Pine.LNX.4.58.0506191926530.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 04:35:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkC8B-0007t2-Qa
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 04:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVFTCk0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 22:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVFTCk0
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 22:40:26 -0400
Received: from mail.dvmed.net ([216.237.124.58]:59543 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261327AbVFTCkL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 22:40:11 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DkCCm-0000IY-CA; Mon, 20 Jun 2005 02:40:08 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506191926530.2268@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> Btw, if possibly, you should just undo it. It's "valid" in the sense that

Any crap like this, I undo it manually (cat previous head to .git/HEAD)


> Again, "git commit" _did_ warn about this, I'm sure, but I actually see 
> why that stupid MERGE_HEAD file was there - a null merge won't remove a 
> stale MERGE_HEAD, so it's probably because you did a "git pull" that was a 
> trivial merge, and that would have left that turd around..

Probably PEBCAK...  my missing the big "MERGE_HEAD exists" warning 
caused the problem, it sounds like.

I simply assumed that the vanilla git scripts would clean up after 
themselves :)

	Jeff




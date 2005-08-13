From: Dave Jones <davej@redhat.com>
Subject: Re: Fwd: Re: git checkout -f branch doesn't remove extra files
Date: Sat, 13 Aug 2005 01:27:32 -0400
Message-ID: <20050813052731.GC11456@redhat.com>
References: <20050813041737.GB25236@redhat.com> <Pine.LNX.4.58.0508122151120.19049@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 07:28:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3oYh-00029G-Nv
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 07:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVHMF1r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 01:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVHMF1r
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 01:27:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63374 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751310AbVHMF1r (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 01:27:47 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j7D5RZwS024675;
	Sat, 13 Aug 2005 01:27:35 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j7D5RZV26395;
	Sat, 13 Aug 2005 01:27:35 -0400
Received: from nwo.kernelslacker.org (vpn50-5.rdu.redhat.com [172.16.50.5])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j7D5RZE8001357;
	Sat, 13 Aug 2005 01:27:35 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.4/8.13.4) with ESMTP id j7D5RYno012121;
	Sat, 13 Aug 2005 01:27:34 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.4/8.13.4/Submit) id j7D5RW4k012119;
	Sat, 13 Aug 2005 01:27:32 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508122151120.19049@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 12, 2005 at 10:05:11PM -0700, Linus Torvalds wrote:

 > HOWEVER, if all you want to do is just a tar-file, then there's a better 
 > solution. It's called
 > 
 > 	snap=git-snapshot-$(date +"%Y%m%d")
 > 	git-tar-tree HEAD $snap | gzip -9 > $snap.tar.gz
 > 
 > which is even easier, and a hell of a lot more efficient.

Nice. That takes noticably less time to create the sparse/git snapshots
compared to my crappy old script. And its now less than half the size.
I'm sold.

 > Git actually has a _lot_ of nifty tools. I didn't realize that people 
 > didn't know about such basic stuff as "git-tar-tree" and "git-ls-files". 

Maybe its because things are moving so fast :)  Or maybe I just wasn't
paying attention on that day. (I even read the git changes via RSS,
so I should have no excuse).

		Dave

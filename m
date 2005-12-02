From: Junio C Hamano <junkio@twinsun.com>
Subject: Re: More merge questions (why doesn't this work?)
Date: Fri, 2 Dec 2005 22:00:42 +0000 (UTC)
Message-ID: <loom.20051202T225802-582@post.gmane.org>
References: <7vbqzz2qc8.fsf@assigned-by-dhcp.cox.net> <20051202213214.27282.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 02 23:05:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiJ0H-0002yY-O3
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 23:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbVLBWDi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 17:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbVLBWDi
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 17:03:38 -0500
Received: from main.gmane.org ([80.91.229.2]:2466 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750866AbVLBWDh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 17:03:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EiIxg-0001un-U8
	for git@vger.kernel.org; Fri, 02 Dec 2005 23:01:01 +0100
Received: from ip-66-80-53-59.lax.megapath.net ([66.80.53.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Dec 2005 23:01:00 +0100
Received: from junkio by ip-66-80-53-59.lax.megapath.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Dec 2005 23:01:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.80.53.59 (Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915 Firefox/1.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13130>

 <linux <at> horizon.com> writes:

> + git merge 'Merge a, b, c' master a b c
> Trying simple merge with a
> Trying simple merge with b
> Trying simple merge with c
> Simple merge did not work, trying automatic merge.
> Removing c
> fatal: merge program failed
> No merge strategy handled the merge.

I think this is the same problem I fixed yesterday after the breakage report
from Luben Tuikov.  You need the ce3ca275452cf069eb6451d6f5b0f424a6f046aa commit.
Sorry about that.

Could you try the latest and see if it still breaks?

From: Junio C Hamano <junkio@twinsun.com>
Subject: Re: git-ls-tree: add "-t" option to always show the tree entries
Date: Fri, 2 Dec 2005 22:12:09 +0000 (UTC)
Message-ID: <loom.20051202T231110-711@post.gmane.org>
References: <7vlkz5n3r1.fsf@assigned-by-dhcp.cox.net> <20051201085433.GA7866@c165.ib.student.liu.se> <Pine.LNX.4.64.0512011022520.3099@g5.osdl.org> <7vlkz4friv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0512011354500.3099@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 02 23:14:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiJB0-00078w-Fn
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 23:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVLBWOn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 17:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVLBWOn
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 17:14:43 -0500
Received: from main.gmane.org ([80.91.229.2]:25517 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750891AbVLBWOm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 17:14:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EiJ8q-0006Pk-0Y
	for git@vger.kernel.org; Fri, 02 Dec 2005 23:12:32 +0100
Received: from ip-66-80-53-59.lax.megapath.net ([66.80.53.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Dec 2005 23:12:32 +0100
Received: from junkio by ip-66-80-53-59.lax.megapath.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Dec 2005 23:12:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.80.53.59 (Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915 Firefox/1.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13131>

Linus Torvalds <torvalds <at> osdl.org> writes:

> That brings up another issue. I typed
> 
> 	git-ls-tree -r --name-only ..
> 
> and it obviously didn't work.

This brings up another issue.  When git-ls-tree works from subdirectory,
do we want to see repository-relative paths, or cwd relative paths?
Currently we do the latter.

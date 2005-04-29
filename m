From: Rob Jellinghaus <robj@unrealities.com>
Subject: Val Henson's critique of hash-based content storage systems
Date: Fri, 29 Apr 2005 00:06:01 +0000 (UTC)
Message-ID: <loom.20050429T015434-928@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Apr 29 17:23:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRXJ6-0001Yf-Mu
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 17:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVD2P1J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 11:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbVD2P1J
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 11:27:09 -0400
Received: from main.gmane.org ([80.91.229.2]:64166 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262793AbVD2P1F (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 11:27:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DRXIJ-0001Rf-2H
	for git@vger.kernel.org; Fri, 29 Apr 2005 17:20:47 +0200
Received: from mailhost.nimblefish.com ([207.213.220.164])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Apr 2005 17:20:43 +0200
Received: from robj by mailhost.nimblefish.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Apr 2005 17:20:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.54.159.162 (Mozilla/5.0 (Windows; U; Windows NT 5.1; rv:1.7.3) Gecko/20041001 Firefox/0.10.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I assume most people here have read this, but just in case:

http://www.usenix.org/events/hotos03/tech/full_papers/henson/henson.pdf

Is git vulnerable to attacks in the event that SHA-1 is broken?

If an attacker used an SHA-1 attack to create a blob that matched the hash of
some well-known git object (say, the tree for Linux 2.7-rc1), and spammed public
git repositories with it ahead of Linus's release, what would be the potential
for mischief, and what would the recovery process be?

It seems that git is optimized to support networks of trust, so provided you
accept only signed commits from people you trust, it's likely that corruption
and mischief can be mostly avoided.  But probably not completely; there is still
a window of vulnerability.

It seems that git repositories could (at great expense) be regenerated to use a
new hash algorithm.  Is that the plan if SHA-1 is compromised (or comes so close
to compromise as to make Linus nervous ;-)?

Cheers,
Rob



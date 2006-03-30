From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Rebase semantic and cherry-pick
Date: Thu, 30 Mar 2006 03:59:16 +0200
Organization: At home
Message-ID: <e0fe1h$d5r$1@sea.gmane.org>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net> <Pine.LNX.4.64.0603281749060.15714@g5.osdl.org> <7vlkutc36w.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603291102440.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Mar 30 03:59:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOmRa-0008NS-Jz
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 03:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWC3B7Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 20:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWC3B7X
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 20:59:23 -0500
Received: from main.gmane.org ([80.91.229.2]:29090 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751432AbWC3B7X (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Mar 2006 20:59:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FOmRS-0008Ls-5K
	for git@vger.kernel.org; Thu, 30 Mar 2006 03:59:18 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Mar 2006 03:59:18 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Mar 2006 03:59:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18183>

Linus Torvalds wrote:

> In contrast, here's an alternate workflow that is much easier to explain,
> and doesn't involve "rebase" at all:
> 
> git checkout his
> git cherry-pick origin..mine
[...] 
> Now, "git cherry-pick" doesn't actually support the above format, and I'm
> not saying that the "git rebase" name itself is evil. I think we could fix
> "git rebase" to work better, but the semantics - the way they are
> _designed_ right now - are just horrible.

Perhaps if possible also have

git cherry-pick --whole-branch branchname

meaning

git cherry-pick branchname:begining..branchname:HEAD

-- 
Jakub Narebski

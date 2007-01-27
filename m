From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 20:54:11 +0100
Organization: At home
Message-ID: <epgaj2$bn9$1@sea.gmane.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <45BB9C8B.8020907@fs.ei.tum.de> <Pine.LNX.4.64.0701271103520.25027@woody.linux-foundation.org> <Pine.LNX.4.64.0701271119300.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 27 20:53:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAtcE-0005aw-Vy
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 20:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbXA0Tx3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 14:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbXA0Tx3
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 14:53:29 -0500
Received: from main.gmane.org ([80.91.229.2]:53532 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbXA0Tx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 14:53:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HAtc1-00009l-9l
	for git@vger.kernel.org; Sat, 27 Jan 2007 20:53:21 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Jan 2007 20:53:21 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Jan 2007 20:53:21 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37992>

Linus Torvalds wrote:

> On Sat, 27 Jan 2007, Linus Torvalds wrote:

>> Quoth Simon 'corecode' Schubert:

>>> git log kdelibs/README takes 1:18.  One minute, eighteen seconds.
>>> git rev-list and git blame take roughly the same time.
> 
> Btw, why do people even think this is "slow"?
> 
> Yeah, we should speed it up, just because I think having that large a repo 
> will make it more obvious what we can do even better. No question about 
> that.
[...]
> Basically, asking for "git log --since=1.week.ago" should be 
> constant-time, regardless of how big the history is (well, it obviously 
> depends on how many changes there have been in the last week, but the 
> point is that it shouldn't get slower over time).
[...]
> That's why "git blame" is so horrible. It's fundamentally an operation 
> that depends on "whole history" and thus cannot scale.

By the way, in git-blame you can also give the cutoff like in git-log;
the lines which come from outside given revision range either get blamed
on boundary, or are shown "unblamed".

I wonder if any other SCM's blame/annotate has that...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

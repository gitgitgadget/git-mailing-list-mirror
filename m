From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Wed, 31 Jan 2007 15:53:23 +0100
Organization: At home
Message-ID: <epqaej$nug$1@sea.gmane.org>
References: <87odognuhl.wl%cworth@cworth.org> <Pine.LNX.4.64.0701301853300.20138@iabervon.org> <Pine.LNX.4.64.0701302052230.3021@xanadu.home> <Pine.LNX.4.64.0701302331440.20138@iabervon.org> <Pine.LNX.4.64.0701310923010.3021@xanadu.home> <20070131143811.GC10646@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 15:52:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCGpH-0006pi-Jx
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 15:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933316AbXAaOw3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 09:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933317AbXAaOw3
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 09:52:29 -0500
Received: from main.gmane.org ([80.91.229.2]:52745 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933316AbXAaOw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 09:52:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCGoq-0001G7-Uu
	for git@vger.kernel.org; Wed, 31 Jan 2007 15:52:16 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 15:52:16 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 15:52:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38253>

J. Bruce Fields wrote:
> On Wed, Jan 31, 2007 at 09:31:00AM -0500, Nicolas Pitre wrote:

>> It is not the commit which is dangerous when the head is detached.  It 
>> is the checkout of another branch.  And this case is covered already 
>> such that the checkout is refused unless you actually create a branch 
>> for your detached head or you give -f to checkout to override the 
>> protection.
>> 
>> Giving a warning at commit time is not the place where the user has to 
>> be aware of the issue since it is indeed not the place where there is 
>> any issue to worry about.

I'd like to have some configuration option to make git more careful
and prohibit commiting in detached HEAD state (the default being that
you can commit on top of detached HEAD). More secure but less powerfull.
 
> By the same argument, the original checkout of a non-branch is also not
> the place for a warning; by the time you commit and then do a checkout
> to switch away from the new commit, that original checkout may be a
> distant memory.

But the initial checkout of a non-branch is place where we can notify
user that he does something unexpected / unusual. Though I think that
single-line warning would be enough...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

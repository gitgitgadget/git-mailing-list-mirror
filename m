From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git user survey and `git pull`
Date: Thu, 21 Sep 2006 19:17:05 +0200
Organization: At home
Message-ID: <eeuhe8$i66$1@sea.gmane.org>
References: <20060921162401.GD3934@spearce.org> <Pine.LNX.4.64.0609211259340.2627@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Sep 21 19:33:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQSNU-00060g-I4
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 19:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWIURaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 13:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWIURaF
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 13:30:05 -0400
Received: from main.gmane.org ([80.91.229.2]:48266 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751373AbWIURaE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 13:30:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GQSHr-000472-Qn
	for git@vger.kernel.org; Thu, 21 Sep 2006 19:24:36 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Sep 2006 19:24:35 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Sep 2006 19:24:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27497>

Nicolas Pitre wrote:

> On Thu, 21 Sep 2006, Shawn Pearce wrote:
> 
>> I think its probably too late to change the UI[*1*] but I think
>> it is definately an issue for folks learning Git.  Calling push
>> push, fetch fetch and fetch+merge pull is probably a design flaw.
>> IMHO it probably should have been something like:
>> 
>>   Current            Shoulda Been
>>   ---------------    ----------------
>>   git-push           git-push
>>   git-fetch          git-pull
>>   git-pull . foo     git-merge foo
>>   git-pull           git-pull --merge
>>   git-merge          git-merge-driver
>> 
>> in other words pull does the download and doesn't automatically
>> start a merge unless --merge was also given and git-merge is a
>> cleaner wrapper around the Grand Unified Merge Driver that makes
>> it easier to start a merge.
> 
> I must say that I second this.  Although I'm rather familiar with GIT I 
> still feel unconfortable with the current naming and behavior.

Using git-pull . <branch> for _merge_, and git-merge being mid-level
command (one of the arguments is <msg>, instead of having git-commit like
ways to provide/amend commit message) is somewhat confusing.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

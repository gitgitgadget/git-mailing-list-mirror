From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Subversion-style incrementing revision numbers
Date: Wed, 20 Sep 2006 02:15:00 +0200
Organization: At home
Message-ID: <eeq14e$isu$1@sea.gmane.org>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com> <Pine.LNX.4.64.0609191416500.4388@g5.osdl.org> <20060919220604.GE8259@pasky.or.cz> <Pine.LNX.4.64.0609191519090.4388@g5.osdl.org> <Pine.LNX.4.62.0609191709160.9752@joeldicepc.ecovate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 20 02:15:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPpjq-0002tT-F2
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 02:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWITAOv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 20:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWITAOv
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 20:14:51 -0400
Received: from main.gmane.org ([80.91.229.2]:9389 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750717AbWITAOu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 20:14:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GPpjb-0002ps-OY
	for git@vger.kernel.org; Wed, 20 Sep 2006 02:14:39 +0200
Received: from host-81-190-31-133.torun.mm.pl ([81.190.31.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 02:14:39 +0200
Received: from jnareb by host-81-190-31-133.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 02:14:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-133.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27318>

Joel Dice wrote:

> On Tue, 19 Sep 2006, Linus Torvalds wrote:
>> On Wed, 20 Sep 2006, Petr Baudis wrote:
>>> This is actually exactly how SVN revision numbering works. There's just
>>> a single number (no '1.') and it indeed jumps randomly if you have
>>> several concurrent branches in your (ok, Linus does not have any, just
>>> someone's) repository.
>>
>> Oh, ok, if it's just a single numbering, then that's easy to do. It won't
>> _mean_ anything, and you're seriously screwed if you ever merge anything
>> else (or use a git that doesn't update the refcache or whatever), but it
>> is simple and stable within a single repo.
> 
> Well, what it means is "this is the order in which commits were applied to 
> this repository".  I suggest that this information is useful for the most 
> common development style - the kind which relies on a central repository 
> as the canonical source for a project's code.  "gcc-trunk-r117064" means a 
> lot more to me than "39282037d7cc39829f1d56bf8307b8e5430d585f", and is no 
> less precise.

What about "v1.4.2.1-gf7f93e7", or "tags/v1.4.2-rc4^0~19", or just
"39282037"? Or "next@{2006-09-19 22:44:33 +0000}"?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: .gitlink for Summer of Code
Date: Wed, 28 Mar 2007 01:31:41 +0200
Organization: At home
Message-ID: <euc9av$2p9$1@sea.gmane.org>
References: <1174825838.12540.5.camel@localhost> <Pine.LNX.4.64.0703271409070.6730@woody.linux-foundation.org> <Pine.LNX.4.63.0703271245580.15345@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 01:31:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWL8g-0001Zb-TX
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 01:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933452AbXC0Xbk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 19:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933473AbXC0Xbk
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 19:31:40 -0400
Received: from main.gmane.org ([80.91.229.2]:56739 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933452AbXC0Xbj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 19:31:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HWL7b-0008LE-R7
	for git@vger.kernel.org; Wed, 28 Mar 2007 01:30:35 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Mar 2007 01:30:35 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Mar 2007 01:30:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43321>

David Lang wrote:

> On Tue, 27 Mar 2007, Linus Torvalds wrote:
> 
>> On Tue, 27 Mar 2007, Daniel Barkalow wrote:
>>>
>>> Are you talking about submodule history, or submodule state? If they care
>>> about any state but not the corresponding history, they need to do a
>>> shallow clone of the subproject, right?
>>
>> I don't see what the confusion is about.
>>
>> Why would you want a shallow clone, and what does that have to do with
>> submodules?
>>
>> I'm saying that the *normal* case is that of the thousands of submodules,
>> you generally care about one or two (the ones you work on).
>>
>> Those modules you want full history for. The supermodule you want because
>> it contains the build infrastructure. You'd generally want full history
>> for that too.
> 
> if you are working on the submodule then you are correct.
> 
> however if you are working on the supermodule it's a different story.
> 
> if I'm working on the 'ubuntu superproject' it would be nice to be able to find 
> what is different between the 'Jan 2007' and 'April 2007' versions. one could 
> have the 2.6.19 kernel and the other would have 2.6.20. I don't care about all 
> the individual changes between these two states of the kernel, but I need to be 
> able to compile either one as part of my testing. If I bisect the in the 
> superproject to the commit that updated the kernel, then I would consider 
> getting the 'kernel subproject' history to be able to bisect the bug further (or 
> I may just report it to the kernel maintainers for them to check.

I'd rather call this idea _sparse_ clone (not shallow), as you have only
some points in the history, but they don't need to be top 'n' ones.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

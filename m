From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Git wiki
Date: Sat, 06 May 2006 09:33:15 +0200
Organization: At home
Message-ID: <e3hjfk$bjn$1@sea.gmane.org>
References: <20060505005659.9092.qmail@science.horizon.com> <20060505181540.GB27689@pasky.or.cz> <Pine.LNX.4.64.0605051123420.3622@g5.osdl.org> <20060505185445.GD27689@pasky.or.cz> <7vr738w8t4.fsf@assigned-by-dhcp.cox.net> <46a038f90605052353m2d2aca11weac7efee80c6fb35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat May 06 09:33:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcHIG-0006nK-0N
	for gcvg-git@gmane.org; Sat, 06 May 2006 09:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWEFHdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 03:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWEFHdY
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 03:33:24 -0400
Received: from main.gmane.org ([80.91.229.2]:8613 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751265AbWEFHdY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 03:33:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FcHHt-0006l1-QS
	for git@vger.kernel.org; Sat, 06 May 2006 09:33:14 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 May 2006 09:33:13 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 May 2006 09:33:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19652>

Martin Langhoff wrote:

> On 5/6/06, Junio C Hamano <junkio@cox.net> wrote:

>>> Try doing
>>>
>>> git diff v1.3.0..
>>>
>>> and think about what that actually _means_. Think about the fact that it
>>> doesn't actually walk the commit chain at all: it diffs the trees
>>> between v1.3.0 and the current one. What if the rename happened in a
>>> commit in the middle?
>>
>> Then the automated renames detection will miss it given that the other
>> accumulated differences are large enough, and the suggested workarounds
>> _are_ precisely walking the commit chain.
> 
> I agree here with Pasky that after a while the automated
> renames/copy/splitup detection will miss the operation in cases where
> it would be interesting to note it to the user.

Perhaps an option to do rename detection with walking the commit chain?

-- 
Jakub Narebski
Warsaw, Poland

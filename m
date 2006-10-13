From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] git-repack: -b to pass --delta-base-offset
Date: Fri, 13 Oct 2006 15:51:31 +0200
Organization: At home
Message-ID: <ego5kp$fm4$1@sea.gmane.org>
References: <11607177011745-git-send-email-junkio@cox.net> <11607177024171-git-send-email-junkio@cox.net> <Pine.LNX.4.64.0610130912500.2435@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Oct 13 15:53:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYNSg-0000QJ-Aa
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 15:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWJMNwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 09:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWJMNwX
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 09:52:23 -0400
Received: from main.gmane.org ([80.91.229.2]:26505 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750834AbWJMNwX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Oct 2006 09:52:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GYNSC-0000HG-K5
	for git@vger.kernel.org; Fri, 13 Oct 2006 15:52:03 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 15:52:00 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 15:52:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28846>

Nicolas Pitre wrote:

> On Thu, 12 Oct 2006, Junio C Hamano wrote:
> 
>> This new option makes the resulting pack express the delta base
>> with more compact "offset" format.
> 
> Actually I thought about making it the default whenever git-pack-objects 
> supported it, and use a negative option with git-repack to disable it 
> instead.
> 
> The fact is that there is little reason for not using delta base offsets 
> in most cases and specifying -b all the time would become more of an 
> annoyance.

Perhaps we should leave it to configuretion variable, instead?
And turn the new format on by default, like core.legacyHeaders
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

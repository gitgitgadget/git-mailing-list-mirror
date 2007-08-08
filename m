From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Wed, 08 Aug 2007 11:58:49 +0200
Organization: At home
Message-ID: <f9c44o$gqs$1@sea.gmane.org>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net> <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site> <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site> <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site> <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site> <20070803053717.GA16379@midwinter.com> <alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org> <7v4pjc9czm.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0708072004150.23971@woody.linux-foundation.org> <Pine.LNX.4.64.0708080923580.14781@racer.site> <7v3ayu5scj.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0708081022440.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 11:59:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIiKU-0005Zs-EX
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 11:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759737AbXHHJ7L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 05:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759134AbXHHJ7J
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 05:59:09 -0400
Received: from main.gmane.org ([80.91.229.2]:55741 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759355AbXHHJ7I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 05:59:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIiJg-0001GG-SX
	for git@vger.kernel.org; Wed, 08 Aug 2007 11:59:00 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 11:59:00 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 11:59:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55314>

Johannes Schindelin wrote:

> On Wed, 8 Aug 2007, Junio C Hamano wrote:
> 
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>>> So I have the slight suspicion that all this will accomplish is "shut the 
>>> darn thing up", and old-timers will have a harder time, since they no 
>>> longer spot easily when they did a Dumb Thing and left the index out of 
>>> sync.
>> 
>> The hardest hit would be old-timers who try to be friendly by
>> trying to help new people, who has much less chance to notice
>> and report these much less prominent warnings, over e-mail or
>> irc.
> 
> True.  It is even bigger than that annoyance to people who know how git 
> works.

Perhaps config variable, by default old behaviour if not set?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

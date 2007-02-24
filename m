From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Fixup no-progress for fetch & clone
Date: Sat, 24 Feb 2007 18:56:29 +0100
Organization: At home
Message-ID: <erpu4b$daa$1@sea.gmane.org>
References: <Pine.LNX.4.63.0702232002480.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vfy8w3add.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702240217550.22628@wbgn013.biozentrum.uni-wuerzburg.de> <alpine.LRH.0.82.0702232046300.29426@xanadu.home> <Pine.LNX.4.63.0702240314250.22628@wbgn013.biozentrum.uni-wuerzburg.de> <alpine.LRH.0.82.0702232123110.29426@xanadu.home> <Pine.LNX.4.63.0702240336130.22628@wbgn013.biozentrum.uni-wuerzburg.de> <alpine.LRH.0.82.0702232141040.29426@xanadu.home> <7vbqjk17a8.fsf@assigned-by-dhcp.cox.net> <alpine.LRH.0.82.0702240005270.29426@xanadu.home> <7v7iu80y6i.fsf@assigned-by-dhcp.cox.net> <alpine.LRH.0.82.0702240922250.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 24 18:55:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HL17c-0008Va-4d
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 18:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933527AbXBXRzB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 12:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933529AbXBXRzB
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 12:55:01 -0500
Received: from main.gmane.org ([80.91.229.2]:57986 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933528AbXBXRzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 12:55:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HL16V-0001cE-6P
	for git@vger.kernel.org; Sat, 24 Feb 2007 18:54:39 +0100
Received: from host-89-229-2-22.torun.mm.pl ([89.229.2.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 24 Feb 2007 18:54:39 +0100
Received: from jnareb by host-89-229-2-22.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 24 Feb 2007 18:54:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-2-22.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40521>

Nicolas Pitre wrote:

> On Sat, 24 Feb 2007, Junio C Hamano wrote:
> 
>> Nicolas Pitre <nico@cam.org> writes:
>> 
>>> How does that solve the issue with servers (currently all of them) that 
>>> don't know about the new sideband?
>> 
>> I actually happen to consider that a non problem.
>> 
>> It is true that you can only prepare the client and server side
>> by 1.5.1, and new clients talking to 1.5.0 or older servers
>> would not be able to squelch the noise.  But that is _not_ a new
>> problem anyway, and given time the server side will eventually
>> be updated to 1.5.1 or later.  If anything else, it would give
>> incentive to people to upgrade their servers to 1.5.1 ;-)
> 
> Well... for such a special case feature I doubt this might be such a 
> great insentive.  And since locally filtering on '\r' is so simple I 
> wonder what the complexity of the alternative solution really buys us.

Slighly less bandwidth used (we don't send progress report)?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

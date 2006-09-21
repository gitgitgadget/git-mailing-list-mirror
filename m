From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix showing of path in tree view
Date: Thu, 21 Sep 2006 10:50:46 +0200
Organization: At home
Message-ID: <eetjp0$22n$1@sea.gmane.org>
References: <20060920231224.GN13132@pasky.or.cz> <7vpsdqdsh1.fsf@assigned-by-dhcp.cox.net> <20060920234052.GO13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Sep 21 10:52:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQKHI-0004na-6b
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 10:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWIUIvY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 04:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWIUIvY
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 04:51:24 -0400
Received: from main.gmane.org ([80.91.229.2]:34285 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750823AbWIUIvX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 04:51:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GQKGy-0004gu-7a
	for git@vger.kernel.org; Thu, 21 Sep 2006 10:51:09 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Sep 2006 10:51:08 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Sep 2006 10:51:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27465>

Petr Baudis wrote:

> Dear diary, on Thu, Sep 21, 2006 at 01:32:42AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...

>> But I think the older one was visually nicer and more intuitive
>> in one very small detail that I think matters.  Slashes between
>> path components were not part of the anchor elements, so it was
>> clear that there were two links in "gitweb / gitweb.perl" page
>> title, not just one link.  Now it is not obvious that clicking
>> different parts of the path string in "/stgit/commands/mail.py"
>> would lead to different places.  And as you are aware, losing
>> the leading "/" would be nicer as well ;-).
> 
>   Well, this was the best I could come up without introducing "[root] /"
> or something in front of the path, which would be IMHO even uglier.
> Alternative ideas welcomed. :-)

"[$project] /", or "~ /" instead of "[root] /".

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

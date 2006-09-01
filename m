From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: gitweb_check_feature always return list
Date: Fri, 01 Sep 2006 21:48:23 +0200
Organization: At home
Message-ID: <eda2q0$la8$1@sea.gmane.org>
References: <ed8a90$pfn$1@sea.gmane.org> <11571390683018-git-send-email-jnareb@gmail.com> <7vk64n5qep.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Sep 01 21:48:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJF0Q-0004sG-0j
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 21:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWIATsl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 15:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWIATsl
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 15:48:41 -0400
Received: from main.gmane.org ([80.91.229.2]:41178 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751037AbWIATsk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Sep 2006 15:48:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GJF0B-0004qe-Ep
	for git@vger.kernel.org; Fri, 01 Sep 2006 21:48:31 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Sep 2006 21:48:31 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Sep 2006 21:48:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26308>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Modified feature_blame so it returns one-element list and not scalar,
>> thus making gitweb_check_feature always return list.  Updated comment
>> to explain that part.
> 
> I do not understand what you are fixing.
> 
>       sub A { return (1); }
>       sub B { return 1; }
> 
> Don't they quack the same way?

Well, that is just nitpicking. gitweb_check_feature returns list if feature
is not overridable, so I made it that it always returns list.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

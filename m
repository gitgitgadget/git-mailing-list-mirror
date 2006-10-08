From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Cleanup Git logo and Git logo target generation
Date: Sun, 08 Oct 2006 22:54:34 +0200
Organization: At home
Message-ID: <egbogh$d7d$1@sea.gmane.org>
References: <20060919212725.GA13132@pasky.or.cz> <ef43do$fm1$1@sea.gmane.org> <7vac4qs43g.fsf@assigned-by-dhcp.cox.net> <200610061231.06017.jnareb@gmail.com> <egauic$1l2$1@sea.gmane.org> <7vwt7aio8l.fsf@assigned-by-dhcp.cox.net> <20061008201031.GL20017@pasky.or.cz> <7vbqomim46.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Oct 08 22:54:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWff1-0001cq-Vp
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 22:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWJHUyI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 16:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWJHUyI
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 16:54:08 -0400
Received: from main.gmane.org ([80.91.229.2]:13955 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751388AbWJHUyF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 16:54:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GWfei-0001Yf-Uo
	for git@vger.kernel.org; Sun, 08 Oct 2006 22:53:52 +0200
Received: from host-81-190-27-91.torun.mm.pl ([81.190.27.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 22:53:52 +0200
Received: from jnareb by host-81-190-27-91.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 22:53:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-91.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28551>

Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
> 
>> Is there a problem with taking <200610061231.06017.jnareb@gmail.com>?
>>
>> I think it's currently not worth the complexity and breakage of
>> backwards compatibility to do the more elaborate form you proposed.
> 
> I agree with that, except that the 72x27 dimension bit troubles
> me.

First, that's the problem for the future. The 72x27 was there, I have not
introduced this. 

Second, 72x27 is size override, so although logo would better be 72x27,
but if it is not it will be scaled to given size.
  http://www.w3.org/TR/html401/struct/objects.html#visual
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

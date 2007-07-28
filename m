From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-svn rebase screwing up commit messages
Date: Sat, 28 Jul 2007 16:32:36 +0200
Organization: At home
Message-ID: <f8fk23$cuo$1@sea.gmane.org>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr> <7v8x90sp25.fsf@assigned-by-dhcp.cox.net> <20070728083536.540e471d.seanlkml@sympatico.ca> <7vodhwptba.fsf@assigned-by-dhcp.cox.net> <20070728092914.48f6305c.seanlkml@sympatico.ca> <7vk5skps1g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 16:33:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEnLn-0008JM-Nv
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 16:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbXG1Oc5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 10:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbXG1Oc5
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 10:32:57 -0400
Received: from main.gmane.org ([80.91.229.2]:52431 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915AbXG1Oc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 10:32:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IEnLf-0002H1-HN
	for git@vger.kernel.org; Sat, 28 Jul 2007 16:32:51 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 16:32:51 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 16:32:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54037>

Junio C Hamano wrote:

> Sean <seanlkml@sympatico.ca> writes:
> 
>>> Having said all that, so that the readers understand the
>>> background, here is a not-so-heavily-tested patch, which might
>>> help.  It passes all the test suite as before, but that tells
>>> how existing git-svn tests do not test many things.
>>> 
>>> I am not considering this for inclusion right now, by the way.
>>
>> FWIW your patch fixed my test case here.
> 
> Actually the patched behaviour actively encourages a bad (not in
> the sense that those oneline tools will not work well, but in
> the sense that these messages are reader unfriendly) practice; I
> do not think what the patch did deserves to be called "fixed".
> 
> And that is one of the reasons, other than that we are in -rc
> freeze that we do not add anything but unarguable fixes, that I
> am not considering the patch for inclusion right now.

I think that git should not enforce this policy. Think import
and exchange with foreign SCMs which do not follow this, argueably
very reasonable, one-line summary policy.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

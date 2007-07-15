From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: question about git-submodule
Date: Sun, 15 Jul 2007 15:52:18 +0200
Message-ID: <20070715135218.GE999MdfPADPa@greensroom.kotnet.org>
References: <20070713214630.GB7106@genesis.frugalware.org>
 <20070715083959.GC999MdfPADPa@greensroom.kotnet.org>
 <20070715104712.GF2568@steel.home>
 <20070715115148.GD999MdfPADPa@greensroom.kotnet.org>
 <20070715134212.GH2568@steel.home>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: VMiklos <vmiklos@frugalware.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 15:52:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA4WO-0002r8-6y
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 15:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053AbXGONwU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 09:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753689AbXGONwU
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 09:52:20 -0400
Received: from psmtp12.wxs.nl ([195.121.247.24]:45400 "EHLO psmtp12.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192AbXGONwT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 09:52:19 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp12.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JL800J8W3V66U@psmtp12.wxs.nl> for git@vger.kernel.org; Sun,
 15 Jul 2007 15:52:18 +0200 (MEST)
Received: (qmail 18967 invoked by uid 500); Sun, 15 Jul 2007 13:52:18 +0000
In-reply-to: <20070715134212.GH2568@steel.home>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52553>

On Sun, Jul 15, 2007 at 03:42:12PM +0200, Alex Riesen wrote:
> Sven Verdoolaege, Sun, Jul 15, 2007 13:51:48 +0200:
> > I agree that fetching should probably be left as a separate operation,
> > but if you have all the data, then I find it very inconvenient that
> > every time you switch to a different commit you have to update
> > all the subprojects separately too.
> 
> I found I do _not_ need to do it every time I switch to a different
> commit.

Ok.  Then I guess we have different needs and I should only
do it if some config option is set if I ever try to resend
the patch.

> > The update in the superproject would fail if the subproject is dirty
> > (just as with files.)
> 
> Haven't noticed this yet. Merge ignores subprojects. What do you mean?
> 

I mean that if such a feature would be implemented, then it wouldn't
go ahead with the update if some of the subprojects couldn't be updated.

skimo

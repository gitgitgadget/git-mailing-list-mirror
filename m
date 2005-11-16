From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add option USE_INPLACE to Makefile
Date: Wed, 16 Nov 2005 12:04:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511161117090.16852@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511160333460.15130@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzk5cmnd.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511160903360.16063@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vpsp19eg7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 12:06:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcL6U-0002yi-Mn
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 12:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbVKPLEZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 06:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVKPLEZ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 06:04:25 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:690 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030275AbVKPLEY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 06:04:24 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7F62213F97F; Wed, 16 Nov 2005 12:04:23 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5F7E0B51FC; Wed, 16 Nov 2005 12:04:23 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3ECEBB51F4; Wed, 16 Nov 2005 12:04:23 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 256CE13F97F; Wed, 16 Nov 2005 12:04:23 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsp19eg7.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12019>

Hi,

On Wed, 16 Nov 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Now, *I* know what I have to put into config.mak, but I would hate the 
> > project if I was new to it, tried to play around with it, and nothing 
> > would work in spite of being compiled with just one warning, thank you.
> 
> Hmph.  That certainly sounds like what I might do.  Especially
> the part "play around before installing", so I am *very*
> sympathetic.
> 
> OTOH, I do not particularly want to advertise/encourage in-place
> use.  Once you built today's git ;-), wouldn't you cd somewhere
> else and use it for your real work?  That would mean you have
> one location on your PATH that you keep the latest git build
> and I am not sure why being able to run in-place is such a big
> deal.  Is it because $HOME is under a tight quota?

Okay. So it would be better to provide a short snippet in INSTALL which 
can be copied into config.mak?

> > Just a safety measure for the price of two lines. When I check out a new 
> > project, I do "make", play around with it, and then do "make install". If 
> > I had to set "export USE_INPLACE=1", "make install" should barf, because 
> > the compiled programs are not meant to be used anywhere else.
> 
> OK.  That's sensible.

Well, the patch was untested, and wrong (template_dir was bogus). But I 
agree that it might be a better idea to deprecate that behaviour.

I *will* learn to "make install" after "make", and not spend hours just to 
find that ./git called the old installed binaries.

Ciao,
Dscho

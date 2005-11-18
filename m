From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Fri, 18 Nov 2005 03:53:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511180350430.6359@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org> 
 <7v1x1eubpr.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0511171505080.13959@g5.osdl.org>
  <Pine.LNX.4.63.0511180030260.18775@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90511171740x756b0336ib8b8937ee3a2af03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 03:54:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcwNL-0004OY-0B
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 03:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVKRCxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 21:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbVKRCxQ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 21:53:16 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:47244 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750729AbVKRCxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 21:53:16 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 21AA113FE3B; Fri, 18 Nov 2005 03:53:15 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 061F99F34A; Fri, 18 Nov 2005 03:53:15 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B7BC89CC6E; Fri, 18 Nov 2005 03:53:14 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9C81613FE3B; Fri, 18 Nov 2005 03:53:14 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90511171740x756b0336ib8b8937ee3a2af03@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12186>

Hi,

On Fri, 18 Nov 2005, Martin Langhoff wrote:

> On 11/18/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Thu, 17 Nov 2005, Linus Torvalds wrote:
> > > Seriously, I can't imagine what else we'd want.
> > An error when there's a chance the result is unexpected?
> 
> That'd be even harder to define -- I'd rather have it spit out what it
> interpreted so that porcelains can display it to the user. The user
> can tell at a glance if the parser is off -- for it will be off by a
> mile.

Yes, it may be off by a mile. But if there exists a feature to specify a 
date that comfortably, people don't RTFM, but use it.

Now comes the rub: if nothing is displayed, they take it that everything 
was fine. *If* something was displayed, one knew that the code parsed 
yesterday when last year was meant. But *if not*, nobody knows.

This is dangerous. It is wrong, but does not say so.

Hth,
Dscho

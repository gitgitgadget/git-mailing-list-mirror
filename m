From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Autoconf/Automake
Date: Fri, 16 Jun 2006 01:10:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606160105100.7480@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1150324030.23268.12.camel@dv> <20060615072450.GF7766@nowhere.earth>
 <20060615133146.GA5794@steel.home> <20060615163209.GJ7766@nowhere.earth>
 <Pine.LNX.4.64.0606150954430.5498@g5.osdl.org> <20060615211454.GK7766@nowhere.earth>
 <Pine.LNX.4.64.0606151545050.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Yann Dirson <ydirson@altern.org>, Alex Riesen <raa.lkml@gmail.com>,
	Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 16 01:10:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr0yj-00055r-8s
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 01:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWFOXKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 19:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWFOXKO
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 19:10:14 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:17082 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750729AbWFOXKM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 19:10:12 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 7F804218D;
	Fri, 16 Jun 2006 01:10:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 734662189;
	Fri, 16 Jun 2006 01:10:10 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 1A48E2157;
	Fri, 16 Jun 2006 01:10:09 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606151545050.5498@g5.osdl.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21921>

Hi,

On Thu, 15 Jun 2006, Linus Torvalds wrote:

> On Thu, 15 Jun 2006, Yann Dirson wrote:
> > 
> > In tha case of jam, the doc issue can certainly be raised, but the
> > most prominent problem is probably that everyone and their dog knows
> > make,
> 
> Oh, I agree. A "simpler" thing that people don't know is often much 
> inferior to a complex thing that people are generally intimately familiar 
> with.
> 
> I just personally believe that autoconf/automake are the worst of both 
> worlds (ie it's a _complex_ thing that a lot of people don't know).
> 
> GNU make in many ways is actually not that bad. Yeah, the makefiles get 
> more complex, but it's usually not totally unreadable, and you can do some 
> clever stuff with it. 

I can add to that with first-hand experience of ant and maven.

A whole sh*t-load of people think make is broken. It does not live up to 
what they want, and it is slow.

And then they invent a _DISEASE_ like ant, which _does not begin_ to sport 
the features of make.

In a project I am stuck in, maven is used. It tries -- of all things -- to 
fix a few shortcomings of ant -- which was supposed to fix shortcomings of 
make! And let's face it. Maven is complicated, slow as a dog lacking all 
four feet, and it still does not do the things I can do in three lines 
with make. It's a complete desaster.

So to keep the discussion on topic: tell me what you want to fix wrt the 
current setup of git, and I'll try to fix it in less than 10 lines of make 
code. If that is impossible, let's continue then and there with the 
discussion about a switch to a newer, less tested, replacement of make, 
okay?

Ciao,
Dscho

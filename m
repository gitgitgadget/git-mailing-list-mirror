From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 12:22:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511171216310.29989@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk> 
 <b0943d9e0511160311k725526d8v@mail.gmail.com>  <7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
  <7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net> 
 <81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com> 
 <7vy83ny450.fsf@assigned-by-dhcp.cox.net> <81b0412b0511170236r28572db9i84dc271700ded79a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 12:23:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Echqk-0000yW-PP
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 12:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVKQLWk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 06:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVKQLWk
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 06:22:40 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:171 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750760AbVKQLWj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 06:22:39 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 703A413F8F5; Thu, 17 Nov 2005 12:22:38 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3A0B3B5227; Thu, 17 Nov 2005 12:22:38 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DFA16B5220; Thu, 17 Nov 2005 12:22:37 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AFF5B13F8F5; Thu, 17 Nov 2005 12:22:37 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0511170236r28572db9i84dc271700ded79a@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12104>

Hi,

On Thu, 17 Nov 2005, Alex Riesen wrote:

> As it turned out, not the git.c is guilty, but the missing
> NO_MMAP=YesPlease in Cygwin section. I had it for a long time and
> accidentally removed by the recent pull. BTW, I couldn't find nowhere
> on original branch. Was it never submitted?

It was not, because someone (Peter?) had success without NO_MMAP=YesPlease 
on cygwin. So it was decided to keep NO_MMAP an option which has to be 
provided by the user.

> > Ideally I should get a cygwin environment myself, but for that
> > first I need to procure Windows box.  Or does cygwin run on
> > Wine, and if so is cygwin running on Wine a good enough
> > approximation of the real thing?

It does not. The problem with mmap is a problem which stems from working 
around Windows not being POSIX. Also note that the problem goes poof in a 
gdb session. I tend to think it is a timing problem in conjunction with 
the (very conservative) Antivirus setting.

Ciao,
Dscho

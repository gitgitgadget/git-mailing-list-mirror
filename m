From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Anyone running GIT on native Windows
Date: Mon, 7 May 2007 19:45:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705071936340.4167@racer.site>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500>  <7vejlufmhd.fsf@assigned-by-dhcp.cox.net>
  <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>  <463ECEF4.625F3633@eudaptics.com>
 <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com>
 <463F14FF.F8DF11EB@eudaptics.com> <002801c790ae$d86a1a90$0200a8c0@AMD2500>
 <Pine.LNX.4.64.0705071624210.4167@racer.site> <00c701c790c6$512804d0$0200a8c0@AMD2500>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Aaron Gray <angray@beeb.net>
X-From: git-owner@vger.kernel.org Mon May 07 19:47:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl7Gp-0007IH-24
	for gcvg-git@gmane.org; Mon, 07 May 2007 19:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590AbXEGRpF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 13:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754587AbXEGRpF
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 13:45:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:57380 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754595AbXEGRpE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 13:45:04 -0400
Received: (qmail invoked by alias); 07 May 2007 17:45:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 07 May 2007 19:45:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+d5oMClQidfiVXYQe5phuhSr6JL/PhiCge/BE2sT
	dHzZ9f9gyP23Oc
X-X-Sender: gene099@racer.site
In-Reply-To: <00c701c790c6$512804d0$0200a8c0@AMD2500>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46472>

Hi,

On Mon, 7 May 2007, Aaron Gray wrote:

> > > An .sh to c converter would be the best solution. I will be looking 
> > > into how hard this would be to do.
> > 
> > NACK.
> > 
> > A stupid .sh to c converter will almost certainly result in slow and
> > hard-to-debug code.
> 
> I had presumed you do not have to really look at the code if the 
> tanslator is sound.

IMHO no automatic shell->C converter can be sound. Besides, you are 
missing that we are dealing with the opposite of POSIX here. After all, 
your target platform is Windows, right? That makes a sensible sh->C 
converter all the more difficult.

> > If you had bothered to check, you'd know that there are ongoing 
> > efforts to do the ports properly.
> 
> This is good. So the shell code is being migrated to C ?
> 
> Could you give me a link or refernce please ?

You can see a lot in Git's history itself:

	git log --grep="[Mmake].*builtin" --no-merges builtin.h

The Google Summer of Code projects' home page is

	http://git.or.cz/gitwiki/SoC2007Projects

The ongoing progress for this particular project can be seen here:

	http://repo.or.cz/w/git/builtin-gsoc.git

Hth,
Dscho

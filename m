From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Thu, 28 Sep 2006 15:27:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609281456520.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vodt0zbhc.fsf@assigned-by-dhcp.cox.net> <20060928093623.GJ20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 15:27:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSvvT-00089p-N4
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 15:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965417AbWI1N1i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 09:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWI1N1i
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 09:27:38 -0400
Received: from mail.gmx.de ([213.165.64.20]:8623 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751886AbWI1N1h (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 09:27:37 -0400
Received: (qmail invoked by alias); 28 Sep 2006 13:27:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 28 Sep 2006 15:27:36 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060928093623.GJ20017@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28002>

Hi,

On Thu, 28 Sep 2006, Petr Baudis wrote:

> Dear diary, on Thu, Sep 28, 2006 at 09:39:11AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
> 
> >   + Git.pm lost Git.xs; its remnant still remains, though.
> >     Notably, we still compile x86_64 with -fPIC, and the top
> >     level Makefile has {BASIC,ALL}_{CFLAGS,LDFLAGS} distinction
> >     and INSTALL talks about perl/blib/arch/auto.  I am torn
> >     between removing these and keeping them; on one hand, they
> >     are not needed and makes new developers wonder what the
> >     distinction between BASIC and ALL are.  On the other hand,
> >     we may eventually would want to reintroduce Git.xs in the
> >     future and keeping them might help us.  But on the third
> >     hand ;-), we can always resurrect it from the repository and
> >     that is the point of using git to keep track of the project,
> >     so removing them might not be such a big deal.  I'd like to
> >     decide between this two and push it out to 'master' before
> >     doing the -rc1.
> 
> FWIW, I'd say kill it all (perhaps except BASIC_*, I don't know about
> that one) - we indeed can easily resurrect this, and that was the
> presumption with which I've killed the rest of Git.xs. There's no point
> in keeping legacy cruft around when we can take it back from the
> history.
> 
> Perhaps we could throw a note to perl/Makefile saying
> 
> 	# If you are thinking about adding Git.xs support, please note
> 	# that we have already been there before - see the #next branch
> 	# history for more-or-less working one already added, and also
> 	# the reason why it was removed for now.
> 
> so that noone wastes their time.

Having ranted so often about Git.xs, I feel like I have to apologize. It 
would be a better idea (IMHO) to put an effort into having the _option_ to 
use Git.xs, since it is so much more efficient. If it is a strict opt-in, 
I think it could remain in "next", and it would be much more likely that 
people took up the ball and worked towards libifying git.

Ciao,
Dscho

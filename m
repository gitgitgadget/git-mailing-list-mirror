From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] .gitignore git-rerere and config.mak
Date: Tue, 7 Feb 2006 19:52:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602071951370.26070@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060207172234.41A975BF02@nox.op5.se> <7vk6c7uj21.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 19:53:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6XxD-0002ul-Os
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 19:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWBGSwl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 13:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWBGSwl
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 13:52:41 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:7051 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964889AbWBGSwk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 13:52:40 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5795F14651B; Tue,  7 Feb 2006 19:52:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 4904CA07;
	Tue,  7 Feb 2006 19:52:37 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 10038146549; Tue,  7 Feb 2006 19:52:37 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6c7uj21.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15707>

Hi,

On Tue, 7 Feb 2006, Junio C Hamano wrote:

> Andreas Ericsson <ae@op5.se> writes:
> 
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -123,3 +124,4 @@ git-core.spec
> >  libgit.a
> >  *.o
> >  *.py[co]
> > +config.mak
> 
> I am not sure about this part.  It is plausible that somebody
> who privately uses config.mak has it in _his_ repository under
> version control.  Should we list it in .gitignore?

I have it in .gitignore. If there were changes to config.mak which I had 
in all my copies of git, I'd have them directly in the Makefile.

Hth,
Dscho

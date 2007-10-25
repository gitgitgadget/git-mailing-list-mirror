From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix generation of perl/perl.mak
Date: Thu, 25 Oct 2007 21:42:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710252140500.4362@racer.site>
References: <20071025201724.GA11308@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 22:43:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il9Y8-0007jC-6W
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 22:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbXJYUnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 16:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753870AbXJYUnO
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 16:43:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:60172 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753827AbXJYUnN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 16:43:13 -0400
Received: (qmail invoked by alias); 25 Oct 2007 20:43:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp005) with SMTP; 25 Oct 2007 22:43:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jvd1HitQjndcAfG/jGJiFmaFj0OlOj0nWLWn6+X
	EM7Jx/g8eDBlOw
X-X-Sender: gene099@racer.site
In-Reply-To: <20071025201724.GA11308@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62374>

Hi,

On Thu, 25 Oct 2007, Alex Riesen wrote:

> Besides, a changed Git.pm is *NOT* a reason to rebuild all the perl 
> scripts, so remove the dependency too.
>
> [...]
> 
> @@ -931,10 +931,6 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
>  	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(XDIFF_OBJS)
>  
>  
> -perl/Makefile: perl/Git.pm perl/Makefile.PL GIT-CFLAGS
> -	(cd perl && $(PERL_PATH) Makefile.PL \
> -		PREFIX='$(prefix_SQ)')
> -

This is not really the dependency triggering a rebuild of all perl 
scripts, right?

Ciao,
Dscho

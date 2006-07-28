From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: ssh-pull.o depends on ssh-fetch.c
Date: Fri, 28 Jul 2006 20:55:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607282054190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607281117240.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslkllhqo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 20:55:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6XUe-00052j-Rt
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 20:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbWG1SzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 14:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbWG1SzZ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 14:55:25 -0400
Received: from mail.gmx.de ([213.165.64.21]:9438 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752062AbWG1SzY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 14:55:24 -0400
Received: (qmail invoked by alias); 28 Jul 2006 18:55:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 28 Jul 2006 20:55:23 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslkllhqo.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24400>

Hi,

On Fri, 28 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +ssh-pull.o: ssh-fetch.c
> 
> My personal preference would be to deprecate these commit walkers ;-) 
> but in any case we would also need to make ssh-push.o depend on 
> ssh-upload.c for the same logic.

Probably. But this was a _necessary_ fix: git stopped compiling here (yes, 
I could have done "make clean && make", but that takes all the fun out of 
it...).

Ciao,
Dscho
